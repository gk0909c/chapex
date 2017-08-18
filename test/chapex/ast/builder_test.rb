require 'test_helper'

class BuilderTest < Minitest::Test
  def setup
    @source = MiniTest::Mock.new
    @builder = Chapex::Ast::Builder.new(@source)
  end

  def test_terminal_node_when_valid_token
    @source.expect(:position, [3, 4], [1])
    token = Chapex::Parser::TokenValue.new('val', 1, 2)
    node = @builder.terminal_node(:test, token)

    assert_equal(:test, node.type)
    assert_equal('val', node.value)
    assert_equal(3, node.row)
    assert_equal(4, node.column)

    @source.verify
  end

  def test_terminal_node_when_invalid_token
    node = @builder.terminal_node(:test, nil)

    assert_equal(:test, node.type)
    assert_nil(node.value)
  end

  def test_join_as_node
    # return sliced source by whole start and end
    @source.expect(:[], 'sourcestring', [Range.new(2, 6)])
    # return row and column by whole start
    @source.expect(:position, [7, 8], [2])

    t1 = Chapex::Parser::TokenValue.new('t1', 5, 6)
    n1 = Chapex::Ast::Node.new(:test, ['n1'], token_start: 2, token_end: 2)
    n2 = Chapex::Ast::Node.new(:test, ['n2'], token_start: 3, token_end: 4)
    result = @builder.join_as_node(:test, t1, n1, n2)

    assert_equal(:test, result.type)
    assert_equal('sourcestring', result.value)
    assert_equal(2, result.token_start)
    assert_equal(6, result.token_end)
    assert_equal(7, result.row)
    assert_equal(8, result.column)

    @source.verify
  end

  def test_join_as_node_with_nil_type
    @source.expect(:[], 'sourcestring', [Range.new(2, 6)])
    @source.expect(:position, [7, 8], [2])

    t1 = Chapex::Parser::TokenValue.new('t1', 5, 6)
    n1 = Chapex::Ast::Node.new(:test, ['n1'], token_start: 2, token_end: 2)
    assert_raises { @builder.join_as_node(nil, n1, t1) }
  end

  def test_add_parent_to_children
    c1 = Chapex::Ast::Node.new(:child)
    c2 = Chapex::Ast::Node.new(:child)
    n = @builder.field([c1, c2])

    assert_equal(n, c1.parent)
    assert_equal(n, c2.parent)
    assert_nil(n.parent)
  end
end
