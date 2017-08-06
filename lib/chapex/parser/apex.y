class Chapex::Parser::Apex
rule
  apex_class: class_def class_body {
    result = @builder.apex_class(val)
  }
  class_def: IDENT CLASS_NAME LEFT_CB {
    result = @builder.class_name(val[1])
  }
  class_body:
              | var_def {
              result = @builder.class_body(val[0])
            }
  var_def: IDENT VAR_NAME SEMI {
    result =  @builder.var_name(val[1])
  }
         | var_def IDENT VAR_NAME SEMI {
           a = val[0].is_a?(Array) ? val[0] : [val[0]]
           result = a.push(@builder.var_name(val[2]))
          }
end

---- header
  require 'chapex/parser/base'
