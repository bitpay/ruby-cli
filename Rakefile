require "bundler/gem_tasks"
require 'rspec/core/rake_task'

require_relative 'config/constants.rb'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Bitpay Tasks"
namespace :bitpay do
  desc "Clear local pem and token file"
  task :clear_local_files do
    puts "clearing local files"
    HOME_DIR = File.join(Dir.home, '.bitpay')
    KEY_FILE = File.join(HOME_DIR, 'bitpay.pem')
    TOKEN_FILE = File.join(HOME_DIR, 'tokens.json')
    File.delete(KEY_FILE) if File.file?(KEY_FILE)
    File.delete(TOKEN_FILE) if File.file?(TOKEN_FILE)
    puts "local files cleared"
  end
end
