module Chapex
  # chapex client
  class Cli
    # check apex
    def run(path_pattern, reporter)
      files = Dir.glob("#{Dir.pwd}/#{path_pattern}")

      files.each do |f|
        result = investigate_file(f)
        reporter.add_violations(f, result)
      end

      # output
      reporter.output
    end

    private

    def investigate_file(filepath)
      source = Source.new(filepath)

      # parse source
      parser = Chapex::Parser::Apex.new(source)
      parser.parse
      # puts source.ast

      # check!
      mediator = Mediator.new(source)
      mediator.investigate
    end
  end
end
