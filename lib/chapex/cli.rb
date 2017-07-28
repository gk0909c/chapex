require 'chapex/apex'

module Chapex
  # chapex client
  class Cli
    # check apex
    def run(str)
      parser = Chapex::Apex.new
      parser.parse(str)
      puts parser.checker.result
    end
  end
end
