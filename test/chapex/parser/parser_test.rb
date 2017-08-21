require 'test_helper'

class ParserTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/Valid.cls")
    parser = Chapex::Parser::Apex.new(source)
    parser.parse
    ast = source.ast

    # check class_dec
    expected = <<-HERE
(program
  (class-dec
    (scope "public")
    (virtual)
    (abstract)
    (sharing)
    (class "class")
    (ident "Leo")
    (class-body
      (field
        (scope "public")
        (ident "String")
        (name "str1"))
      (field
        (scope "private")
        (ident "String")
        (name "str2"))
      (field
        (scope)
        (ident "Integer")
        (name "int1"))
      (field
        (scope "private")
        (ident "Integer")
        (name "int2")
        (assign "= 3"))
      (method
        (scope "public")
        (ident "void")
        (ident "getMethod")
        (method-body
          (stmt
            (rhs "System.debug('test message'")))))))
    HERE
    # remove last line feed
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
