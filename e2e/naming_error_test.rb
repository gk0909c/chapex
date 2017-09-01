require 'test_helper'

class NamingErrorTest < Minitest::Test
  def test_naming_error
    reporter = Chapex::Reporter::StdOut.new
    cli = Chapex::Cli.new

    expected = <<-"HERE"
#{Dir.pwd}/e2e/fixtures/NamingError.cls:3:20:[warn] field name "Field" should be lower camelcase
#{Dir.pwd}/e2e/fixtures/NamingError.cls:5:17:[warn] field name "GetMethod" should be lower camelcase
#{Dir.pwd}/e2e/fixtures/NamingError.cls:5:34:[warn] field name "Arg" should be lower camelcase
#{Dir.pwd}/e2e/fixtures/NamingError.cls:6:16:[warn] field name "Message" should be lower camelcase
#{Dir.pwd}/e2e/fixtures/NamingError.cls:1:27:[warn] class name "leo" should be upper camelcase
#{Dir.pwd}/e2e/fixtures/NamingError.cls:2:32:[warn] constant field name "const" should be upper snake case
    HERE

    assert_output(expected) do
      cli.run('e2e/fixtures/NamingError.cls', reporter)
    end
  end
end
