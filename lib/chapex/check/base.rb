module Chapex
  module Check
    # check class base
    class Base
      @subclasses = []

      def self.inherited(subclass)
        @subclasses << subclass.new
      end

      def self.all
        @subclasses
      end

      attr_reader :violations

      def initialize
        @violations = []
      end

      def add_violation(message, node)
        violation = Violation.new(message, node.row, node.column)
        @violations << violation
      end
    end
  end
end
