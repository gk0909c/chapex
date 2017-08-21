class Chapex::Parser::Apex
rule
  program: class_dec {
    result = @builder.program([val[0]])
  }
  class_dec: scope virtual abstract sharing class ident L_CB class_body implemation inherit R_CB {
    children = val[0, 6] << val[7]
    result = @builder.class_dec(children)
  }
  implemation:
            | IMPLEMENTS ident {
              result = @builder.terminal_node(:implements, val[0])
            }
  inherit:
            | EXTENDS ident
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
  field: field_dec field_assign SEMI {
            children = val[1] ? val[0] << val[1] : val[0]
            result =  @builder.field(children)
          }
  field_dec: scope member_modifier ident ident {
            name_node = val[3].updated(:name)
            result = [val[0]].concat(val[1]) << val[2] << name_node
          }
  field_assign: {
                  result = nil
              }
              | EQUAL assigned_val {
                result = @builder.join_as_node(:assign, *val)
              }
  method: scope member_modifier ident ident L_RB R_RB L_CB method_body R_CB {
            children = [val[0]].concat(val[1]).concat(val[2, 2]) << val[7]
            result =  @builder.method(children)
          }
  member_modifier: {
                    result = []
                  }
                  | FINAL {
                    result = [@builder.terminal_node(:final, val[0])]
                  }
                  | OVERRIDE {
                    result = [@builder.terminal_node(:override, val[0])]
                  }
                  | STATIC {
                    result = [@builder.terminal_node(:static, val[0])]
                  }
                  | FINAL STATIC {
                    final = @builder.terminal_node(:final, val[0])
                    static = @builder.terminal_node(:static, val[1])
                    result = [final, static]
                  }
                  | STATIC FINAL {
                    static = @builder.terminal_node(:static, val[0])
                    final = @builder.terminal_node(:final, val[1])
                    result = [static, final]
                  }
                  | OVERRIDE STATIC {
                    override = @builder.terminal_node(:override, val[0])
                    static = @builder.terminal_node(:static, val[1])
                    result = [override, static]
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
  assigned_val: S_LITERAL
            | N_LITERAL
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
  virtual: {
        result = @builder.terminal_node(:virtual, nil)
       }
       | VIRTUAL {
        result = @builder.terminal_node(:virtual, val[0])
       }
  abstract: {
        result = @builder.terminal_node(:abstract, nil)
       }
       | ABSTRACT {
        result = @builder.terminal_node(:abstract, val[0])
       }
  sharing: {
        result = @builder.terminal_node(:sharing, nil)
       }
       | SHARING {
        result = @builder.terminal_node(:sharing, val[0])
       }
end
