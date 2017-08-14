require 'chapex/parser/apex'

module Chapex
  # source expression in string, ast, line array.
  # string expression's newline character will be transformed to line feed.
  class Source
    attr_reader :string, :lines
    attr_accessor :ast

    def initialize(filepath)
      @string = File.read(filepath)
      @ast = nil
      @lines = []
      @line_starts = []

      make_lines
    end

    # get row and column on source. they begin with 0.
    # if index is outbound, return -1 about row and column.
    #
    # @param [Fixnum] :index target
    # @return [Fixnum, Fixnum] row and column
    def position(index)
      return [-1, -1] unless index < string.length

      row_start = @line_starts.select { |line_start| line_start <= index }.last
      row = @line_starts.index(row_start)
      column = index - row_start
      [row, column]
    end

    private

    def string_of(filepath)
      File.read(filepath).gsub(/\r\n/, "\n")
    end

    def make_lines
      line_start = 0

      string.split(/\n/).each do |l|
        @lines << l
        @line_starts << line_start
        # +1 is linefeed character length
        line_start += (l.length + 1)
      end
    end
  end
end
