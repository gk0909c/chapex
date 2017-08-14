module Chapex
  module Parser
    # lexicalized token value expression
    class TokenValue
      attr_reader :value, :token_start, :token_end

      def initialize(value, token_start, token_end)
        @value = value
        @token_start = token_start
        @token_end = token_end
      end
    end
  end
end
