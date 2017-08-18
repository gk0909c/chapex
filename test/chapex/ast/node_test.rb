require 'test_helper'

class NodeTest < Minitest::Test
  def test_like_array_with_idx
    class_body = Chapex::Ast::Node.new(:class_body)
    class_dec = Chapex::Ast::Node.new(:class_dec)
    node = Chapex::Ast::Node.new(:program, [class_dec, class_body])

    assert_equal(class_body, node[1])
  end

  def test_first_child
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    assert_equal(class_dec, node.first_child)
  end

  def test_located_parent_from_grandchild
    grandchild = test_cls.new(:grandchild)
    child = test_cls.new(:child)
    parent = test_cls.new(:parent, [], row: 1, column: 2)

    grandchild.parent = child
    child.parent = parent

    assert_equal(parent, grandchild.located_parent)
  end

  def test_located_parent_from_child
    child = test_cls.new(:child)
    parent = test_cls.new(:parent, [], row: 1, column: 2)

    child.parent = parent

    assert_equal(parent, child.located_parent)
  end

  private

  def test_cls
    Chapex::Ast::Node
  end
end
