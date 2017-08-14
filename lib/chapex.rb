require 'chapex/ast/node'

require 'chapex/version'
require 'chapex/cli'

require 'chapex/parser/token_value'

require 'chapex/check/base'
require 'chapex/check/lower_camel_case'

module Chapex
  def self.run
    Cli.new.run
  end
end
