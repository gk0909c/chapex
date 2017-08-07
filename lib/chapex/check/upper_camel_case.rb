module Chapex
  module Check
    # check upper camel case
    class UpperCamelCase < Base
      MSG = 'var name should start with Lower case about %s'.freeze
      def on_var_name(name)
        add_warning(MSG % name) unless name[0] =~ /[a-z]/
      end
    end
  end
end
