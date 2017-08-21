require 'test_helper'

# e2e test for valid file
class ValidFileTest < Minitest::Test
  def test_valid
    reporter = Chapex::Reporter::StdOut.new
    cli = Chapex::Cli.new

    assert_output('') do
      cli.run('e2e/fixtures/Valid.cls', reporter)
    end
  end
end
