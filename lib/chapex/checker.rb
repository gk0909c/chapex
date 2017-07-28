module Chapex
  # Check Apex Code Style
  class Checker
    def initialize
      @errors = []
    end

    def class_name(str)
      return unless str.include?('error')

      @errors << 'class name error!'
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
