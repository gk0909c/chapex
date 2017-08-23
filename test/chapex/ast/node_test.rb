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

  def test_first_child_location
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    loc = node.first_child_location
    assert_equal(1, loc.row)
    assert_equal(1, loc.column)
  end

  def test_first_child_location_when_grand_son_is_correct
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 3, column: 4)
    stmt = Chapex::Ast::Node.new(:stmt, [], row: 1, column: 2)
    class_dec = Chapex::Ast::Node.new(:class_dec, [stmt])
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    loc = node.first_child_location
    assert_equal(1, loc.row)
    assert_equal(2, loc.column)
  end

  def test_first_child_location_when_second_child_is_correct
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 3, column: 4)
    stmt = Chapex::Ast::Node.new(:stmt)
    class_dec = Chapex::Ast::Node.new(:class_dec, [stmt])
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    loc = node.first_child_location
    assert_equal(3, loc.row)
    assert_equal(4, loc.column)
  end

  def test_find_when_exists
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    assert_equal(class_dec, node.find(:class_dec))
  end

  def test_find_when_not_exists
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    assert_nil(node.find(:class_field))
  end

  def test_has_when_exists
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    assert(node.has?(:class_dec))
  end

  def test_has_when_not_exists
    class_body = Chapex::Ast::Node.new(:class_body, [], row: 1, column: 3)
    class_dec = Chapex::Ast::Node.new(:class_dec, [], row: 1, column: 1)
    node = Chapex::Ast::Node.new(:program, ['abc', class_dec, class_body])

    refute(node.has?(:class_dummy))
  end
end
