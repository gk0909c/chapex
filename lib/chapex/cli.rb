require 'chapex/apex'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run(str)
      parser = Chapex::Apex.new
      result = parser.parse(str)
      puts
      puts "parser result is ---#{result.inspect}---"
      puts "class def is ---#{result.inspect}---"
      puts parser.checker.result
    end
  end
end
