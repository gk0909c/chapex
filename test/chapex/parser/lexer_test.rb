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
      [:CLASS, 'class', 0, 4],
      [:IDENT, 'Leo', 6, 8],
      [:L_CB, '{', 10, 10],
      [:SCOPE, 'public', 14, 19],
      [:IDENT, 'String', 21, 26],
      [:IDENT, 'str1', 28, 31],
      [:SEMI, ';', 32, 32],
      [:IDENT, 'Integer', 36, 42],
      [:IDENT, 'str2', 44, 47],
      [:SEMI, ';', 48, 48],
      [:SCOPE, 'public', 53, 58],
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
      check_token(t, e[0], e[1], e[2], e[3])
    end
  end

  private

  def check_token(token, type, value, t_s, t_e)
    assert_equal(type, token[0])
    assert_equal(value, token[1].value)
    # a little taking easy course
    assert_equal(t_s, token[1].token_start) if t_s
    assert_equal(t_e, token[1].token_end) if t_e
  end
end
