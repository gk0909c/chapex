require 'test_helper'

class ParserTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/ParserTest.cls")
    parser = Chapex::Parser::Apex.new(source)
    parser.parse
    ast = source.ast

    # check class_dec
    expected = <<-HERE
(apex-class
  (class-dec
    (scope "public")
    (class "class")
    (ident "Leo"))
  (class-body
    (field
      (scope "public")
      (ident "String")
      (ident "str1"))
    (field
      (scope "private")
      (ident "String")
      (ident "str2"))
    (field
      (scope)
      (ident "Integer")
      (ident "int1"))
    (method
      (scope "public")
      (ident "void")
      (ident "getMethod")
      (method-body
        (stmt
          (rhs "System.debug('test message'"))))))
    HERE
    # remove last line feed
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
