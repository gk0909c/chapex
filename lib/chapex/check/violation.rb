module Chapex
  module Check
    # violation expressoin of the style
    class Violation
      attr_reader :message, :row, :column, :severity
      attr_accessor :filename

      def initialize(message, row, column, severity = :warn)
        @message = message
        @row = row
        @column = column
        @severity = severity
      end
    end
  end
end
