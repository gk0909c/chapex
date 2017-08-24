require 'test_helper'

class ApexIfParseTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/IfParsing.cls")
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
    (ident "IfParsing")
    (class-body
      (method
        (scope "public")
        (ident "void")
        (name "ifMethod")
        (method-args
          (method-arg
            (ident "String")
            (name "def")))
        (method-body
          (stmt
            (variable
              (ident "String")
              (name "abc"))
            (equal "=")
            (rhs "'def'"))
          (if-stmt
            (condition
              (lhs "abc")
              (operator "==")
              (rhs "def"))
            (if-body
              (stmt
                (variable
                  (ident "String")
                  (name "a"))
                (equal "=")
                (rhs "abc.substring(1, 3)"))
              (stmt
                (rhs "System.debug(a)"))))
          (else-if-stmt
            (condition
              (stmt "def.exists()"))
            (if-body
              (stmt
                (rhs "System.debug('do else if')"))))
          (else-stmt
            (else-body
              (stmt
                (rhs "System.debug('do else')")))))))))
    HERE
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
