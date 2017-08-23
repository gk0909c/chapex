require 'test_helper'

class LowerCamelCaseTest < Minitest::Test
  def setup
    @node = MiniTest::Mock.new
    @target = MiniTest::Mock.new
    @checker = Chapex::Check::Naming::LowerCamelCase.new

    @node.expect(:find, @target, [:name])
  end

  def test_on_field_when_valid
    @node.expect(:has, false, [:static])
    @node.expect(:has, false, [:final])
    @target.expect(:value, 'validName')

    @checker.on_field(@node)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_field_when_const
    @node.expect(:has, true, [:static])
    @node.expect(:has, true, [:final])
    @target.expect(:value, 'VALID_NAME')

    @checker.on_field(@node)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_field_when_invalid
    @node.expect(:has, false, [:static])
    @node.expect(:has, false, [:final])
    @target.expect(:value, 'InvalidName')
    @target.expect(:location, Chapex::SourceLocation.new(1, 2))

    @checker.on_field(@node)

    assert_equal(1, @checker.violations.size)
  end
end
