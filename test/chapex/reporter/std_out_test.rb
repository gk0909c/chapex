require 'test_helper'

class StdOutTest < Minitest::Test
  def test_output
    v1 = Chapex::Check::Violation.new('mes1', loc(0, 0))
    v2 = Chapex::Check::Violation.new('mes2', loc(1, 1))
    v3 = Chapex::Check::Violation.new('mes3', loc(2, 2))

    reporter = Chapex::Reporter::StdOut.new
    reporter.add_violations('filename.ext', [v1, v2, v3])

    expected = <<-HERE
filename.ext:1:1:[warn] mes1
filename.ext:2:2:[warn] mes2
filename.ext:3:3:[warn] mes3
    HERE

    assert_output(expected) { reporter.output }
  end

  private

  def loc(row, column)
    Chapex::SourceLocation.new(row, column)
  end
end
