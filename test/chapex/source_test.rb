require 'test_helper'

class SourceTest < Minitest::Test
  def setup
    @source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/Simple.cls")
  end

  def test_initialize
    assert_equal(8, source.lines.length)
    assert_equal('public class Leo {', source.lines[0])
    assert_equal('    public String str1;', source.lines[1])
    assert_equal('    Integer int2;', source.lines[2])
    assert_equal('', source.lines[3])
    assert_equal('    public void getMethod() {', source.lines[4])
    assert_equal("        System.debug('test message');", source.lines[5])
    assert_equal('    }', source.lines[6])
    assert_equal('}', source.lines[7])
  end

  def test_position
    assert_position(0, 0, 0)
    assert_position(18, 0, 18)
    assert_position(19, 1, 0)
    assert_position(23, 1, 4)
    assert_position(137, 7, 1)
    assert_position(138, -1, -1)
    assert_position(150, -1, -1)
  end

  def test_slice_with_range
    assert_equal('las', source[8..10])
  end

  private

  attr_reader :source

  def assert_position(index, row, column)
    a_row, a_column = source.position(index)
    assert_equal(row, a_row, 'row check')
    assert_equal(column, a_column, 'column check')
  end
end
