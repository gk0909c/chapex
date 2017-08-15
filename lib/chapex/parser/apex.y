class Chapex::Parser::Apex
rule
  apex_class: class_dec L_CB class_body  R_CB {
    result = apex_class([val[0], val[2]])
  }
  class_dec: scope class ident {
    result = class_dec(val[0, 3])
  }
  class_body:
              | fields {
              result = class_body(val[0])
            }
  fields: field {
              result = [val[0]]
            }
          | fields field {
              result = val[0] << val[1]
          }
  field: scope ident ident SEMI {
            result =  field(val[0, 3])
          }
  class: CLASS {
        result = edge_node(:class, val[0])
       }
  scope: {
        result = edge_node(:scope, nil)
       }
       | SCOPE {
        result = edge_node(:scope, val[0])
       }
  ident: IDENT {
        result = edge_node(:ident, val[0])
      }
end

---- header
  require 'chapex/parser/base'
