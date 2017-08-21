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
          violation_row(v),
          violation_column(v),
          v.severity,
          v.message
        ]
      end

      def violation_row(v)
        v.row.nil? ? -99 : v.row + 1
      end

      def violation_column(v)
        v.column.nil? ? -99 : v.column + 1
      end
    end
  end
end
