require 'test_helper'

class ParserTest < Minitest::Test
  def test_parse
    source = Chapex::Source.new("#{Dir.pwd}/test/fixtures/ParserTest.cls")
    parser = Chapex::Parser::Apex.new(source)

    parser.parse
    puts source.ast
  end
end
