module Chapex
  module Check
    # violation expressoin of the style
    class Violation
      attr_reader :message, :row, :column, :severity
      attr_accessor :filename

      def initialize(message, location, severity = :warn)
        @message = message
        @row = location.row
        @column = location.column
        @severity = severity
      end
    end
  end
end
