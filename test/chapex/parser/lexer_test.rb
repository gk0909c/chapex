require 'test_helper'

class LexerTest < Minitest::Test
  def test_tokenize
    source = <<-EOS
    class Leo {
      public String str1;
      Integer str2;

      public void getMethod() {
        System.debug('test message');
      }
    }
    EOS

    expects = [
      [:CLASS, 'class'],
      [:IDENT, 'Leo'],
      [:L_CB, '{'],
      [:SCOPE, 'public'],
      [:IDENT, 'String'],
      [:IDENT, 'str1'],
      [:SEMI, ';'],
      [:IDENT, 'Integer'],
      [:IDENT, 'str2'],
      [:SEMI, ';'],
      [:SCOPE, 'public'],
      [:IDENT, 'void'],
      [:IDENT, 'getMethod'],
      [:L_RB, '('],
      [:R_RB, ')'],
      [:L_CB, '{'],
      [:IDENT, 'System'],
      [:DOT, '.'],
      [:IDENT, 'debug'],
      [:L_RB, '('],
      [:S_LITERAL, "'test message'"],
      [:R_RB, ')'],
      [:SEMI, ';'],
      [:R_CB, '}'],
      [:R_CB, '}']
    ]

    lexer = Chapex::Parser::Lexer.new(source)
    lexer.tokenize
    tokens = lexer.tokens

    assert_equal(25, tokens.length)
    tokens.each_with_index do |t, i|
      e = expects[i]
      check_token(t, e[0], e[1])
    end
  end

  private

  def check_token(token, type, value)
    assert_equal(type, token[0])
    assert_equal(value, token[1])
  end
end
