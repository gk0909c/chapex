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
        (final "final")
        (static "static")
        (ident "String")
        (name "CO_V"))
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
            (variable
              (ident "String")
              (name "mes"))
            (equal "=")
            (rhs "'abc'"))
          (stmt
            (rhs "System.debug(mes)"))
          (stmt
            (ident "str2")
            (equal "=")
            (rhs "mes"))
          (stmt
            (rhs "System.debug(str2)")))))))
    HERE
    # remove last line feed
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
