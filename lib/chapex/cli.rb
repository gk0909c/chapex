require 'chapex/source'
require 'chapex/mediator'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run
      # create source object
      filepath = "#{Dir.pwd}/test/fixtures/Apex.cls"
      source = Source.new(filepath)

      # parse source
      parser = Chapex::Parser::Apex.new(source)
      parser.parse
      puts source.ast

      # check!
      mediator = Mediator.new(source)
      mediator.investigate
    end
  end
end
