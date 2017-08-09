class Chapex::Parser::Apex
rule
  apex_class: class_dec class_body  RIGHT_CB {
    result = @builder.apex_class(val[0, 2])
  }
  class_dec: scope CLASS IDENT LEFT_CB {
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
  field: scope IDENT IDENT SEMI {
            result =  @builder.field(val[1, 2])
          }
  scope:
       | SCOPE
end

---- header
  require 'chapex/parser/base'
