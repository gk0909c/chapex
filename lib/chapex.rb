require 'chapex/ast/node'

require 'chapex/version'
require 'chapex/cli'

require 'chapex/check/base'
require 'chapex/check/lower_camel_case'

module Chapex
  def self.run(str)
    Cli.new.run(str)
  end
end
