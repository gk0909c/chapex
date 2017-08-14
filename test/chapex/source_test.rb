require 'test_helper'

class SourceTest < Minitest::Test
  def setup
    @source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/Apex.cls")
  end

  def test_initialize
    assert_equal(5, source.lines.length)
    assert_equal('class Leo {', source.lines[0])
    assert_equal('    public String 1tr1;', source.lines[1])
    assert_equal('    public String str2;', source.lines[2])
    assert_equal('    public String str3;', source.lines[3])
    assert_equal('}', source.lines[4])
  end

  def test_position
    assert_position(0, 0, 0)
    assert_position(11, 0, 11)
    assert_position(12, 1, 0)
    assert_position(16, 1, 4)
    assert_position(69, 3, 9)
    assert_position(85, 4, 1)
    assert_position(86, -1, -1)
    assert_position(100, -1, -1)
  end

  private

  attr_reader :source

  def assert_position(index, row, column)
    a_row, a_column = source.position(index)
    assert_equal(row, a_row, 'row check')
    assert_equal(column, a_column, 'column check')
  end
end
