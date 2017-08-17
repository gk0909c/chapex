module Chapex
  # do investigate
  class Mediator < AST::Processor
    def initialize(source, conf = {})
      @source = source
      @conf = conf
      @checks = Check::Base.all
      @callbacks = {}
    end

    def investigate
      check_with_ast
      check_with_lines
      @checks.map(&:violations).flatten
    end

    def check_with_ast
      process(@source.ast)
    end

    def check_with_lines
      @checks.each do |c|
        c.investigate(@source.lines) if c.respond_to?(:investigate)
      end
    end

    # only through to children
    def traverse(node)
      node.children.each do |n|
        process(n)
      end
    end
    alias on_apex_class :traverse
    alias on_class_body :traverse

    # define call checks methods
    Chapex::Ast::Builder::NODE_TYPES.each do |type|
      handler = :"on_#{type}"
      next if method_defined?(handler)

      define_method(handler) do |node|
        @callbacks[handler] ||= @checks.select do |c|
          c.respond_to?(handler)
        end

        @callbacks[handler].each do |c|
          c.send(handler, node)
        end
      end
    end
  end
end
