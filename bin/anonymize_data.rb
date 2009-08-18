#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'optparse'
require 'anonymizer'

options = Hash.new
options[:collection] = Array.new
options[:options_for_record_to] = Hash.new

OptionParser.new do |opts|
  opts.banner = "Usage: anonymize_data.rb [options]"

  opts.on("-d", "--destination <directory>", "Destination directory in which anonymized data should be save") do |d|
    options[:destination] = d
  end
  opts.on("-c", '--collection "<list>"', "A collection of files and/or directories to anonymize, seperate with spaces. Quotes are necessary.") do |c|
    options[:collection] += c.split
  end
  opts.on("-g", '--glob "<pattern>"', "Use a shell globbing pattern to select your collection. Quotes are neccessary.") do |g|
    options[:collection] += Dir.glob(g)
  end
  opts.on("--include-csv","Write a csv formatted keymap file in addition to the yaml file.") do |i|
    options[:options_for_record_to][:include_csv] = true
  end
  opts.on("-k","--keymap-name <basename>","Use an alternative file basename (i.e. without extension) for the keymap file.") do |k|
    options[:options_for_record_to][:keymap_name] = k
  end
end.parse!



raise(IndexError, "No items specified to anonymize. Check your glob pattern or explicitly list your  items using -c.") if options[:collection].empty?

puts "Anonymizing:"
options[:collection].each do |i|
  puts "\t#{i}"
end
puts "To:"
puts "\t#{options[:destination]}"

begin
  a = Anonymizer.new(options[:collection])
  a.record_to(options[:destination], options[:options_for_record_to])
rescue
  puts "There was an unknown problem with anonymization.  Sorry."
  exit 1
end

puts "+++ Successfully Anonymized. +++\n"
exit 0