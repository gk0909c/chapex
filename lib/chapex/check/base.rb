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

      def add_violation(location, *message_args)
        message = build_message(message_args)
        violation = Violation.new(message, location)
        @violations << violation
      end

      def build_message(args)
        if args.length.zero?
          self.class::MSG
        else
          self.class::MSG % args
        end
      end
    end
  end
end
