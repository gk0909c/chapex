require 'test_helper'

class IndentationWidthTest < MiniTest::Test
  def setup
    @checker = Chapex::Check::IndentationWidth.new
  end

  def test_on_stmt_invalid
    rhs = node(:rhs, [], row: 3, column: 3)
    stmt = node(:stmt, [rhs])
    method_body = node(:method_body, [stmt])
    scope = node(:scope, ['public'], row: 2, column: 3)
    method = node(:method, [scope, method_body])

    stmt.parent = method_body
    method_body.parent = method

    @checker.on_stmt(stmt)
    v = @checker.violations

    assert_equal(1, v.size)
    assert_equal('expected indentation is 5, but 3', v[0].message)
  end

  def test_on_stmt_valid
    rhs = node(:rhs, [], row: 3, column: 5)
    stmt = node(:stmt, [rhs])
    method_body = node(:method_body, [stmt])
    scope = node(:scope, ['public'], row: 2, column: 3)
    method = node(:method, [scope, method_body])

    stmt.parent = method_body
    method_body.parent = method

    @checker.on_stmt(stmt)
    v = @checker.violations

    assert_equal(0, v.size)
  end

  private

  def node(type, children = [], props = {})
    Chapex::Ast::Node.new(type, children, props)
  end
end
