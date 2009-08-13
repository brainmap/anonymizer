require 'fileutils'
require 'yaml'

class Anonymizer
  # an array of strings, the paths to the items to be anonymized
  attr_accessor :filepaths
  # a string, the directory to which all of the anoymizations and the key should be copied
  attr_accessor :destination_dir
  # a hash, the keys are the original filepaths, the values are the corresponding anonymized names
  attr_accessor :anonymizations
  
  # Creates a new instance with an array of filepaths (strings)
  # A new set of anaonymizations will be created automatically at initialization.  If you want to reshuffle the 
  # anonymizations you can call anonymize at any time afterward.
  def initialize(filepaths)
    @filepaths = filepaths
    @anonymizations = Hash.new
    anonymize
  end
  
  # Reshuffles the anonymized names
  def anonymize
    keys = Array.new(@filepaths)
    idx = 0
    ndigits = (Math.log10(@filepaths.length)+1).floor
    until keys.empty?
      @anonymizations[keys.pick!] = "%0#{ndigits}d" % idx
      idx += 1
    end
  end
  
  # Copies the collection of files/directories to the destination directory using the current anonymized names. Records
  # the anonymizations in a keymap.yml file.
  #
  # === Options
  # :inclue_csv => true -- writes the csv format keymap in addition to the yaml
  #
  # :keymap_name => "basename" -- uses an alternate file basename for the keymap files (the default is "keymap")
  #
  def record_to(destination_dir, options = {})
    raise(IOError, "Destination directory not found.") unless File.exists?(destination_dir) and File.directory?(destination_dir)
    @anonymizations.each do |orig, anon|
      copy_directory_or_file(orig, File.join(destination_dir, anon))
    end
    keymap_filename = options[:keymap_name].nil? ? "keymap" : options[:keymap_name]
    puts "This is the keymap_filename: #{keymap_filename}"
    write_yml(destination_dir, keymap_filename + '.yml')
    write_csv(destination_dir, keymap_filename + '.csv') if options[:include_csv]
  end
  
private
  # recursively copies directories, simply copies files preserving file extension.
  def copy_directory_or_file(orig, dest)
    raise(IOError, "Original file or directory not found: #{orig}") unless File.exists?(orig)
    if File.directory?(orig)  # recursively copy directories
      FileUtils.cp_r(orig, dest)
    else  # simple copy of files, but preserve file extensions
      ext = File.extname(orig)
      FileUtils.cp(orig, dest + ext)
    end
  end
  
  # creates yaml text based on current anonymization
  def to_yaml
    @anonymizations.to_yaml
  end
  
  # creates csv text based on current anonymization
  def to_csv
    csv_contents = ""
    @anonymizations.each do |orig, anon|
      csv_contents += "#{orig}, #{anon}\n"
    end
    return csv_contents
  end
  
  # writes the current anonymization yaml to a file
  def write_yml(destination_dir,keymap_filename)
    File.open(File.join(destination_dir,keymap_filename), 'w') do |out|
       YAML.dump(@anonymizations, out)
    end
  end
  
  # writes the current anonymization csv to a file
  def write_csv(destination_dir,keymap_filename)
    File.open(File.join(destination_dir,keymap_filename), 'w') do |out|
      out.write(to_csv)
    end
  end

end

# Augments the ruby array class with a couple convenient random picking methods
class Array
  # Picks one value from the array at random, array remains unchanged.
  def pick
    at(rand(length))
  end
  # Removes and returns one element of the array at random, the original array is changed by this method.
  def pick!
    delete_at(rand(length))
  end
end