require 'test_helper'

class ApexWhileParseTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/WhileParsing.cls")
    parser = Chapex::Parser::Apex.new(source)
    parser.parse
    ast = source.ast

    # check class_dec
    expected = <<-HERE
(program
  (class-dec
    (scope "public")
    (class "class")
    (name "WhileParsing")
    (class-body
      (method
        (scope "public")
        (type "void")
        (name "whileMethod")
        (method-args
          (method-arg
            (type "Integer")
            (name "i")))
        (method-body
          (do-while-stmt
            (do-body
              (stmt
                (rhs "System.debug(i)"))
              (stmt
                (rhs "i++")))
            (condition
              (lhs "i")
              (operator "<=")
              (rhs "10")))))
      (method
        (scope "public")
        (type "void")
        (name "whileMethod2")
        (method-args
          (method-arg
            (type "Integer")
            (name "l")))
        (method-body
          (while-stmt
            (condition
              (lhs "l")
              (operator ">=")
              (rhs "5"))
            (while-body
              (stmt
                (rhs "System.debug(l)"))
              (stmt
                (rhs "l--")))))))))
    HERE
    expected.chomp!

    assert_equal(expected, ast.to_sexp)
  end
end
