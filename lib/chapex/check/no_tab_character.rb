module Chapex
  module Check
    # check lower camel case
    class NoTabCharacter < Base
      MSG = 'no tab character, use space instead'.freeze

      def investigate(lines)
        lines.each_with_index { |l, i| add_tab_character_violation(l, i) }
      end

      private

      def add_tab_character_violation(line, row)
        index = line.index(/\t/)
        add_violation(Chapex::SourceLocation.new(row, index)) if index
      end
    end
  end
end
