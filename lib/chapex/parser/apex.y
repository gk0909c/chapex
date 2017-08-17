class Chapex::Parser::Apex
rule
  apex_class: class_dec L_CB class_body  R_CB {
    result = @builder.apex_class([val[0], val[2]])
  }
  class_dec: scope class ident {
    result = @builder.class_dec(val[0, 3])
  }
  class_body:
          | members
  members: member {
            result = @builder.class_body([val[0]])
          }
          | members member {
            result = val[0] << val[1]
          }
  member: field 
        | method
  field: scope ident ident SEMI {
            result =  @builder.field(val[0, 3])
          }
  method: scope ident ident L_RB R_RB L_CB method_body R_CB {
            children = val[0, 3].concat([val[6]])
            result =  @builder.method(children)
          }
  method_body: stmt {
          result = @builder.method_body([val[0]])
          }
        | method_body stmt {
          result = val[0] << val[1]
        }
  stmt: rhs {
          result = @builder.stmt([val[0]])
        }
  rhs: call_target L_RB argments R_RB SEMI {
                  result = @builder.join_as_node(:rhs, val[0], val[2])
                }
  call_target: ident
             | ident dot_idents {
               result = @builder.join_as_node(:call_target, *val)
             }
  dot_idents:  dot_ident {
              result = val[0]
            }
            | dot_idents dot_ident {
              result = val[0] << val[1]
            }
  dot_ident: DOT ident {
              result = @builder.join_as_node(:dot_ident, *val)
            }
  argments: S_LITERAL
  class: CLASS {
        result = @builder.terminal_node(:class, val[0])
       }
  scope: {
        result = @builder.terminal_node(:scope, nil)
       }
       | SCOPE {
        result = @builder.terminal_node(:scope, val[0])
       }
  ident: IDENT {
        result = @builder.terminal_node(:ident, val[0])
      }
end
