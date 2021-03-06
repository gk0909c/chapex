require 'test_helper'

class ApexValidParaseTest < Minitest::Test
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
    (abstract "abstract")
    (class "class")
    (name "Leo")
    (class-body
      (field
        (scope "public")
        (final "final")
        (static "static")
        (type "String")
        (name "CO_V"))
      (field
        (scope "private")
        (type "String")
        (name "str2"))
      (field
        (scope)
        (type "Integer")
        (name "int1"))
      (field
        (scope "private")
        (type "Integer")
        (name "int2")
        (assign "= 3"))
      (method
        (scope "public")
        (type "void")
        (name "getMethod")
        (method-body
          (stmt
            (variable
              (type "String")
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
