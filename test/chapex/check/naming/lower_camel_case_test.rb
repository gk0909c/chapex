require 'test_helper'

class LowerCamelCaseTest < Minitest::Test
  def setup
    @node = MiniTest::Mock.new
    @target = MiniTest::Mock.new
    @checker = Chapex::Check::Naming::LowerCamelCase.new

    @node.expect(:[], @target, [2])
  end

  def test_on_field_when_valid
    @target.expect(:value, 'validName')

    @checker.on_field(@node)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_field_when_invalid
    @target.expect(:value, 'InvalidName')
    @target.expect(:location, Chapex::SourceLocation.new(1, 2))

    @checker.on_field(@node)

    assert_equal(1, @checker.violations.size)
  end
end
