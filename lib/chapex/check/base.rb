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

      def add_warning(message, node)
        warn = "filename:#{node.row}:#{node.column}: #{message}"
        @warnings << warn
      end
    end
  end
end
