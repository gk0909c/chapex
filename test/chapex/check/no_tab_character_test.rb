require 'test_helper'

class NoTabCharacterTest < MiniTest::Test
  def test_investigate
    checker = Chapex::Check::NoTabCharacter.new
    lines = [
      'abc',
      '  abc',
      "\tabc",
      "def \t"
    ]

    checker.investigate(lines)
    checker.inspect
    violations = checker.violations

    assert_equal(2, violations.size, 'violation count')
    assert_equal(2, violations[0].row)
    assert_equal(0, violations[0].column)
    assert_equal(3, violations[1].row)
    assert_equal(4, violations[1].column)
  end
end
