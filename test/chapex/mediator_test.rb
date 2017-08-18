require 'test_helper'

class MediatorTest < MiniTest::Test
  def test_investigate
    source = mocked_source
    check1 = MiniTest::Mock.new.expect(:on_field, nil, [@field])
    check2 = MiniTest::Mock.new.expect(:on_method, nil, [@method])
    checks = [check1, check2]

    checks.each { |c| c.expect(:violations, []) }

    Chapex::Check::Base.stub(:all, checks) do
      mediator = Chapex::Mediator.new(source)
      mediator.investigate
    end

    checks.each(&:verify)
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
    Chapex::Ast::Node.new(:program, [class_dec, class_body])
  end
end
