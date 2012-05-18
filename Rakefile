#!/usr/bin/env rake
require "rubygems"
require "bundler"
require './app'
require "guard/sprockets2"

namespace :assets do
  desc 'precompile assets'
  task :precompile do

    options = { :sprockets => App.sprockets, :assets_path => App.assets_path,
                :precompile => App.precompile, :digest => App.digest_assets}
    @compiler = Guard::Sprockets2::Compiler.new(options)
    @compiler.clean
    @compiler.compile
  end
end
