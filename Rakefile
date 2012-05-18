#!/usr/bin/env rake
require "rubygems"
require "bundler"
require 'digest/md5'
require "fileutils"
Bundler.require

task :default => [:minify]

task :minify do
  minify_file("index.html.erb", "index.html")

  def minify_file(input, output)
    html = File.read(input)
    minified = html.gsub(/$\s*/, "").gsub("\n", "")
    File.open(output, 'w') {|f| f.write(minified) }
  end
end

task :environment do
  require './app'
end

namespace :assets do
  desc "Compile all the assets"
  task :precompile => :environment do
    raise "Not implemented yet"
  end

  desc "Remove compiled assets"
  task :clean => :environment do
    raise "Not implemented yet"
  end
end
