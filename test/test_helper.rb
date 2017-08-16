require 'simplecov'
SimpleCov.start do
  track_files 'lib/**/*.rb'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'chapex'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
