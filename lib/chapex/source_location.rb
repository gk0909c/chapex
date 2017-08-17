module Chapex
  # source location expression
  class SourceLocation
    attr_reader :row, :column

    def initialize(row, column)
      @row = row
      @column = column
    end
  end
end
