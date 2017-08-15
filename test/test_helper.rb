require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'chapex'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
