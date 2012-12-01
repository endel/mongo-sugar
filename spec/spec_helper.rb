$: << 'lib'

ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'simplecov'

SimpleCov.start

require 'rspec'
require 'mongo-sugar'
