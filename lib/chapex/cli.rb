require 'chapex/parser/apex'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run(str)
      parser = Chapex::Parser::Apex.new
      parser.parse(str)
      puts parser.checker.result
    end
  end
end
