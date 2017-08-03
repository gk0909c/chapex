class Chapex::Parser::Apex
rule
  apex_class: class_def class_body {
    puts val.inspect
  }
  class_def: IDENT CLASS_NAME LEFT_CB {
    @checker.class_name(val[1])
  }
  class_body:
            | var_def
  var_def: IDENT VAR_NAME SEMI {
    @checker.var_name(val[1])
    result =  [@builder.var_name(val[1])]
  }
         | var_def IDENT VAR_NAME SEMI {
           @checker.var_name(val[2])
           a = val[0]
           result = a.push(@builder.var_name(val[2]))
          }
end

---- header
  require 'chapex/parser/base'
