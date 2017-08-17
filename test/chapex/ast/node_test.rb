require 'test_helper'

class NodeTest < Minitest::Test
  def test_like_array_with_idx
    class_body = Chapex::Ast::Node.new(:class_body)
    class_dec = Chapex::Ast::Node.new(:class_dec)
    node = Chapex::Ast::Node.new(:apex_class, [class_dec, class_body])

    assert_equal(class_body, node[1])
  end
end
