require 'test_helper'

class BuilderTest < Minitest::Test
  def setup
    @mocked_source = MiniTest::Mock.new.expect(:position, [3, 4], [1])

    @parser = Object.new
    @parser.instance_variable_set(:@source, @mocked_source)
    @parser.define_singleton_method(:position) do |st|
      @source.position(st)
    end
    @parser.extend(Chapex::Ast::Builder)
  end

  def test_edge_node_when_valid_token
    token = Chapex::Parser::TokenValue.new('val', 1, 2)
    node = @parser.edge_node(:test, token)

    assert_equal(:test, node.type)
    assert_equal('val', node.value)
    assert_equal(3, node.row)
    assert_equal(4, node.column)

    @mocked_source.verify
  end

  def test_edge_node_when_invalid_token
    node = @parser.edge_node(:test, nil)

    assert_equal(:test, node.type)
    assert_nil(node.value)
  end
end
