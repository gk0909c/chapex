module Chapex
  # Check Apex Code Style
  class Checker
    def initialize
      @errors = []
    end

    def class_name(str)
      @errors << 'class name should start with Upper case!' unless str[0] =~ /[A-Z]/
    end

    def var_name(str)
      @errors << 'var name should start with Lower case!' unless str[0] =~ /[a-z]/
    end

    def result
      if @errors.empty?
        puts 'no error'
      else
        puts "errors are below -- #{@errors.inspect}"
      end
    end
  end
end
