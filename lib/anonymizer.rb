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
  # the anonymizations in a keymap.yml file.  A csv file can be optionally written using :inclue_csv => true.
  def record_to(destination_dir, options = {})
    raise(IOError, "Destination directory not found.") unless File.exists?(destination_dir) and File.directory?(destination_dir)
    @anonymizations.each do |orig, anon|
      copy_directory_or_file(orig, File.join(destination_dir, anon))
    end
    write_yml(destination_dir)
    write_csv(destination_dir) if options[:include_csv]
  end
  
  private
  
  def copy_directory_or_file(orig, dest)
    raise(IOError, "Original file or directory not found: #{orig}") unless File.exists?(orig)
    if File.directory?(orig)  # recursively copy directories
      FileUtils.cp_r(orig, dest)
    else  # simple copy of files, but preserve file extensions
      ext = File.extname(orig)
      FileUtils.cp(orig, dest + ext)
    end
  end
  
  def to_yaml
    @anonymizations.to_yaml
  end
  
  def to_csv
    csv_contents = ""
    @anonymizations.each do |orig, anon|
      csv_contents += "#{orig}, #{anon}\n"
    end
    return csv_contents
  end
  
  def write_yml(destination_dir)
    File.open(File.join(destination_dir,'keymap.yml'), 'w') do |out|
       YAML.dump(@anonymizations, out)
    end
  end
  
  def write_csv(destination_dir)
    File.open(File.join(destination_dir,'keymap.csv'), 'w') do |out|
      out.write(to_csv)
    end
  end

end

class Array
  def pick
    at(rand(length))
  end
  def pick!
    delete_at(rand(length))
  end
end