class Chapex::Parser::Apex
rule
  apex_class: class_dec L_CB class_body  R_CB {
    result = @builder.apex_class([val[0], val[2]])
  }
  class_dec: scope CLASS IDENT {
    result = @builder.class_dec(val[0, 3])
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
            result =  @builder.field(val[0, 3])
          }
  scope:
       | SCOPE
end

---- header
  require 'chapex/parser/base'
