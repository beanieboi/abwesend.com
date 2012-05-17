#!/usr/bin/env rake
require "rubygems"
require "bundler"
require 'digest/md5'
require "fileutils"
Bundler.require

task :default => [:minify]

task :minify do
  minify_file("index.html.erb", "index.html")
end

def minify_file(input, output)
  html = File.read(input)
  minified = html.gsub(/$\s*/, "").gsub("\n", "")
  File.open(output, 'w') {|f| f.write(minified) }
end
