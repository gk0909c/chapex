require 'chapex/source'
require 'chapex/mediator'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run(str)
      source = Source.new(str)
      source.parse_ast
      puts source.ast

      mediator = Mediator.new(source)
      mediator.investigate
    end
  end
end
