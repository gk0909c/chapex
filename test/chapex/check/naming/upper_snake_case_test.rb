require 'test_helper'

class UpperSnakeCaseTest < Minitest::Test
  def setup
    @node = MiniTest::Mock.new
    @target = MiniTest::Mock.new
    @checker = Chapex::Check::Naming::UpperSnakeCase.new

    @node.expect(:find, @target, [:name])
  end

  def test_on_field_when_valid
    @node.expect(:has?, true, [:static])
    @node.expect(:has?, true, [:final])
    @target.expect(:value, 'VALID_NAME1')

    @checker.on_field(@node)

    assert_equal(0, @checker.violations.size)
  end

  def test_on_field_when_invalid
    @node.expect(:has?, true, [:static])
    @node.expect(:has?, true, [:final])
    @target.expect(:value, 'validName')
    @target.expect(:location, Chapex::SourceLocation.new(1, 2))

    @checker.on_field(@node)

    assert_equal(1, @checker.violations.size)
    ex = 'constant field name "validName" should be upper snake case'
    assert_equal(ex, @checker.violations[0].message)
  end
end
