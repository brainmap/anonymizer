#!/usr/bin/env ruby
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'optparse'
require 'anonymizer'

options = Hash.new
options[:collection] = Array.new

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
end.parse!

raise(IndexError, "No items specified to anonymize. Check your glob pattern or explicitly list your  items using -c.") if options[:collection].empty?
a = Anonymizer.new(options[:collection])
a.record_to(options[:destination])