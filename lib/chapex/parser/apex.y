class Chapex::Parser::Apex
rule
  apex_class: class_dec class_body {
    result = @builder.apex_class(val)
  }
  class_dec: IDENT CLASS_NAME LEFT_CB {
    result = @builder.class_dec(val[0, 2])
  }
  class_body:
              | fields {
              result = @builder.class_body(val[0])
            }
  fields: field {
              result = [val[0]]
            }
          | fields field {
              result = val[0] << val[1]
          }
  field: IDENT FIELD_NAME SEMI {
            result =  @builder.field(val[0, 2])
          }
end

---- header
  require 'chapex/parser/base'
