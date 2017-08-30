require 'test_helper'

class ApexForParseTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/ForParsing.cls")
    parser = Chapex::Parser::Apex.new(source)
    parser.parse
    ast = source.ast

    # check class_dec
    expected = <<-HERE
(program
  (class-dec
    (scope "public")
    (class "class")
    (name "ForParsing")
    (class-body
      (method
        (scope "public")
        (type "void")
        (name "forMethod")
        (method-args
          (method-arg
            (type "List<String>")
            (name "def")))
        (method-body
          (for-stmt
            (for-init
              (variable
                (type "Integer")
                (name "i"))
              (equal "=")
              (rhs "0"))
            (condition
              (lhs "i")
              (operator "<")
              (rhs "10"))
            (increament "i++")
            (for-body
              (stmt
                (rhs "System.debug(i)"))))
          (for-each-stmt
            (type "String")
            (name "d")
            (ident "def")
            (for-body
              (stmt
                (rhs "System.debug(d)")))))))))
    HERE
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
