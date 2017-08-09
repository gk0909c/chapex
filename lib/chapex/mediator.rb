module Chapex
  # do investigate
  class Mediator < AST::Processor
    def initialize(source, conf = {})
      @source = source
      @conf = conf
      @cops = Check::Base.all
      @callbacks = {}
    end

    def investigate
      process(@source.ast)

      @cops.each do |c|
        puts c.warnings.inspect
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
    Chapex::Builder::NODE_TYPES.each do |type|
      handler = :"on_#{type}"
      next if method_defined?(handler)

      define_method(handler) do |node|
        @callbacks[handler] ||= @cops.select do |c|
          c.respond_to?(handler)
        end

        @callbacks[handler].each do |c|
          c.send(handler, node.to_a)
        end
      end
    end
  end
end
