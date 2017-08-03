require 'ast'

require 'chapex/version'
require 'chapex/cli'

module Chapex
  def self.run(str)
    Cli.new.run(str)
  end
end
