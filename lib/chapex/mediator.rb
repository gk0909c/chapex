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

    def on_field(node)
      cops = @cops.select do |c|
        c.respond_to?(:on_field)
      end

      cops.each do |c|
        c.send(:on_field, node.to_a)
      end
    end
  end
end
