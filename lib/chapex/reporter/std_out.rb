module Chapex
  module Reporter
    # reporter of standard output format
    class StdOut
      def initialize
        @violations = []
      end

      def add_violations(filename, violations)
        violations.each { |v| v.filename = filename }
        @violations.concat(violations)
      end

      def output
        @violations.each do |v|
          message = "[#{v.severity}]#{v.filename}:#{v.row}:#{v.column} #{v.message}"
          puts message
        end
      end
    end
  end
end
