require 'test_helper'

class MediatorTest < MiniTest::Test
  def test_investigate
    source = mocked_source
    cop1 = MiniTest::Mock.new.expect(:on_field, nil, [@field])
    cop2 = MiniTest::Mock.new.expect(:on_method, nil, [@method])
    cops = [cop1, cop2]

    cops.each { |c| c.expect(:violations, []) }

    Chapex::Check::Base.stub(:all, cops) do
      mediator = Chapex::Mediator.new(source)
      mediator.investigate
    end

    cops.each(&:verify)
  end

  private

  def mocked_source
    source = MiniTest::Mock.new
    source.expect(:ast, ast)
    source
  end

  def ast
    @method = Chapex::Ast::Node.new(:method)
    @field = Chapex::Ast::Node.new(:field)
    class_body = Chapex::Ast::Node.new(:class_body, [@field, @method])
    class_dec = Chapex::Ast::Node.new(:class_dec)
    Chapex::Ast::Node.new(:apex_class, [class_dec, class_body])
  end
end
