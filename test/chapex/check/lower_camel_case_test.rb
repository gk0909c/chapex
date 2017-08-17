require 'test_helper'

class LowerCamelCaseTest < Minitest::Test
  def setup
    @nodes = MiniTest::Mock.new
    @target = MiniTest::Mock.new
    @checker = Chapex::Check::LowerCamelCase.new

    @nodes.expect(:[], @target, [2])
  end

  def test_on_field_when_valid
    @target.expect(:value, 'validName')

    @checker.on_field(@nodes)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_field_when_invalid
    @target.expect(:value, 'InvalidName')
    @target.expect(:row, 1)
    @target.expect(:column, 2)

    @checker.on_field(@nodes)

    assert_equal(1, @checker.violations.size)
  end
end
