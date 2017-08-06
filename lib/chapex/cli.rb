require 'chapex/source'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run(str)
      source = Source.new(str)
      source.parse_ast
      puts source.ast
      # puts parser.checker.result
    end
  end
end
