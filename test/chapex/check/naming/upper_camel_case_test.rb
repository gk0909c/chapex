require 'test_helper'

class UpperCamelCaseTest < Minitest::Test
  def setup
    @node = MiniTest::Mock.new
    @target = MiniTest::Mock.new
    @checker = Chapex::Check::Naming::UpperCamelCase.new

    @node.expect(:find, @target, [:name])
  end

  def test_on_class_when_valid
    @target.expect(:value, 'ValidName')

    @checker.on_class_dec(@node)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_class_when_invalid
    @target.expect(:value, 'invalidName')
    @target.expect(:location, Chapex::SourceLocation.new(1, 2))

    @checker.on_class_dec(@node)

    assert_equal(1, @checker.violations.size)
  end
end
