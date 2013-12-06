if ENV['COVERAGE'] == '1'
  require 'simplecov'

  SimpleCov.start { add_filter 'spec' }
end

$:.unshift File.dirname(__FILE__) + "../lib"

require "rubygems"
require "braspag"
require "rspec"
require "pry"
