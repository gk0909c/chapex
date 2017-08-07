module Chapex
  # do investigate
  class Mediator < AST::Processor
    def initialize(source, conf = {})
      @source = source
      @conf = conf
      @cops = Check::Base.all
    end

    def investigate
      process(@source.ast)

      @cops.each do |c|
        puts c.warnings.inspect
      end
    end

    def on_apex_class(node)
      node.children.each do |n|
        process(n)
      end
    end

    def on_class_body(node)
      node.children.each do |n|
        process(n)
      end
    end

    def on_var_name(node)
      cops = @cops.select do |c|
        c.respond_to?(:on_var_name)
      end

      cops.each do |c|
        c.send(:on_var_name, node.children[0])
      end
    end
  end
end
