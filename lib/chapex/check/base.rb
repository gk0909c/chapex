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

      attr_reader :warnings

      def initialize
        @warnings = []
      end

      def add_warning(warning)
        @warnings << warning
      end
    end
  end
end
