module Chapex
  # do investigate
  class Mediator
    def initialize(source, conf = {})
      @source = source
      @conf = conf
    end

    def investigate
      # process ast, then invoke check by defined methods
      # so this class must inheri AST::Processor
      nil
    end
  end
end
