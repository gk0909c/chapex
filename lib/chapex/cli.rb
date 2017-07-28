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
      puts parser.inspect
    end
  end
end
