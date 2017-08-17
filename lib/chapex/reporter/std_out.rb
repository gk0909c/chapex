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
          message = format('%s:%d:%d:[%s] %s', *violation_to_message_args(v))
          puts message
        end
      end

      private

      def violation_to_message_args(v)
        [
          v.filename,
          v.row + 1,
          v.column + 1,
          v.severity,
          v.message
        ]
      end
    end
  end
end
