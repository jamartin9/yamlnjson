#!/usr/bin/env ruby
# Simple script to convert .json to .yaml and .yaml to .json.
require 'json'
require 'yaml'
if ARGV.empty?
  puts 'Supply either a .yaml or .json file'
  exit
end
def self.convert(file)
  yaml_formats = ['.yaml']
  json_formats = ['.json']
  if !File.file? file
    puts "File #{file} doesn't exist"
  elsif yaml_formats.include? File.extname(file)
    output = "#{File.basename(file, '.yaml')}.json"
    puts "Converting #{file} to json file #{output}"
    data = YAML.load_file(file)
    json = JSON.dump(data)
    File.write(output, json)
  elsif json_formats.include? File.extname(file)
    output = "#{File.basename(file, '.json')}.yml"
    puts "Converting #{file} to yaml file #{output}"
    data = JSON.parse(File.read(file))
    yaml = YAML.dump(data)
    File.write(output, yaml)
  else
    puts "Skipping #{file} due to extension"
  end
end
commands = ARGV
commands.each { |command| convert(command) }
