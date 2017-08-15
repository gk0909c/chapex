require 'test_helper'

class BuilderTest < Minitest::Test
  def setup
    @source = MiniTest::Mock.new.expect(:position, [3, 4], [1])
    @builder = Chapex::Ast::Builder.new(@source)
  end

  def test_edge_node_when_valid_token
    token = Chapex::Parser::TokenValue.new('val', 1, 2)
    node = @builder.edge_node(:test, token)

    assert_equal(:test, node.type)
    assert_equal('val', node.value)
    assert_equal(3, node.row)
    assert_equal(4, node.column)

    @source.verify
  end

  def test_edge_node_when_invalid_token
    node = @builder.edge_node(:test, nil)

    assert_equal(:test, node.type)
    assert_nil(node.value)
  end
end
