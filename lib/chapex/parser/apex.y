class Chapex::Parser::Apex
rule
  program: class_dec {
    result = @builder.program([val[0]])
  }
  class_dec: scope class_modifier class ident L_CB class_body implemation inherit R_CB {
    children = [val[0]].concat(val[1]).concat(val[2, 2]) << val[5]
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
  field_dec: scope member_modifier type ident {
            name_node = val[3].updated(:name)
            result = [val[0]].concat(val[1]) << val[2] << name_node
          }
  field_assign: {
                  result = nil
              }
              | EQUAL assigned_val {
                result = @builder.join_as_node(:assign, *val)
              }
  method: scope member_modifier type ident L_RB R_RB L_CB method_body R_CB {
            name = val[3].updated(:name)
            children = [val[0]].concat(val[1]) << val[2] << name << val[7]
            result =  @builder.method(children)
          }
        | scope member_modifier type ident L_RB method_args R_RB L_CB method_body R_CB {
            name = val[3].updated(:name)
            children = [val[0]].concat(val[1]) << val[2] << name << val[5] << val[8]
            result =  @builder.method(children)
          }
  class_modifier: {
                    result = []
                  }
                  | VIRTUAL {
                    result = [@builder.terminal_node(:virtual, val[0])]
                  }
                  | ABSTRACT {
                    result = [@builder.terminal_node(:abstract, val[0])]
                  }
                  | SHARING {
                    result = [@builder.terminal_node(:sharing, val[0])]
                  }
                  | VIRTUAL SHARING {
                    virtual = @builder.terminal_node(:virtual, val[0])
                    sharing = @builder.terminal_node(:sharing, val[1])
                    result = [virtual, sharing]
                  }
                  | ABSTRACT SHARING {
                    abstract = @builder.terminal_node(:virtual, val[0])
                    sharing = @builder.terminal_node(:sharing, val[1])
                    result = [abstract, sharing]
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
  method_body: stmts {
          result = val[0].updated(:method_body)
          }
  stmts: stmt {
          result = @builder.stmts([val[0]])
        }
        | stmts stmt {
          result = val[0] << val[1]
        }
  stmt: rhs SEMI {
          result = @builder.stmt([val[0]])
        }
      | lhs equal rhs SEMI {
          result = @builder.stmt(val[0, 3])
        }
      | if_stmt {
        result = val[0]
      }
      | else_if_stmt {
        result = val[0]
      }
      | else_stmt {
        result = val[0]
      }
      | for_stmt
      | for_each_stmt
  if_stmt: IF L_RB condition R_RB L_CB stmts R_CB {
              if_body = val[5].updated(:if_body)
              result = @builder.if_stmt([val[2], if_body])
            }
  else_if_stmt: ELSE IF L_RB condition R_RB L_CB stmts R_CB {
              if_body = val[6].updated(:if_body)
              result = @builder.else_if_stmt([val[3], if_body])
            }
  else_stmt: ELSE L_CB stmts R_CB {
              else_body = val[2].updated(:else_body)
              result = @builder.else_stmt([else_body])
            }
  for_stmt: FOR L_RB for_init SEMI condition SEMI increament R_RB L_CB stmts R_CB {
              body = val[9].updated(:for_body)
              result = @builder.for_stmt([val[2], val[4], val[6], body])
            }
  for_init: lhs equal expr {
              rhs = val[2].updated(:rhs)  
              result = @builder.for_init([val[0], val[1], rhs])
            }
  increament: ident INCREAMENT {
              result = @builder.join_as_node(:increament, val[0], val[1])
            }
            | ident DECREAMENT {
              result = @builder.join_as_node(:increament, val[0], val[1])
            }
  for_each_stmt: FOR L_RB type ident COLON ident R_RB L_CB stmts R_CB {
              name = val[3].updated(:name)
              body = val[8].updated(:for_body)
              result = @builder.for_each_stmt([val[2], name, val[5], body])
            }
  condition: TRUE {
              node = @builder.terminal_node(:true, val[0])
              result = @builder.condition([node])
            } 
            | FALSE {
              node = @builder.terminal_node(:false, val[0])
              result = @builder.condition([node])
            }
            | expr comparison_operator expr {
              lhs = val[0].updated(:lhs)
              rhs = val[2].updated(:rhs)
              result = @builder.condition([lhs, val[1], rhs])
            }
            | rhs {
              stmt = val[0].updated(:stmt)
              result = @builder.condition([stmt])
            }
  comparison_operator: DBL_EQUAL {
                        result = @builder.terminal_node(:operator, val[0])
                      }
                      | GREATER_EQUAL  {
                        result = @builder.terminal_node(:operator, val[0])
                      }
                      | GREATER  {
                        result = @builder.terminal_node(:operator, val[0])
                      }
                      | LESS_EQUAL  {
                        result = @builder.terminal_node(:operator, val[0])
                      }
                      | LESS  {
                        result = @builder.terminal_node(:operator, val[0])
                      }

  lhs: ident {
          result = val[0]
        }
      | type ident {
          name = val[1].updated(:name)
          result = @builder.variable([val[0], name])
        }
  rhs:  assigned_val {
          result = val[0].updated(:rhs)
        }
      | call_target L_RB args R_RB {
          result = @builder.join_as_node(:rhs, val[0], val[3])
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
  assigned_val: expr
  method_args: method_arg {
              result = @builder.method_args([val[0]])
            }
            | method_args COMMA method_arg {
              result = val[0] << result[2]
            }
  method_arg: type ident {
              name = val[1].updated(:name)
              result = @builder.method_arg([val[0], name]) 
            }
  type: ident {
          result = val[0]
        }
        | ident GREATER ident LESS {
          result = @builder.join_as_node(:ident, *val)
        }
  args:
      | expr
      | args COMMA expr
  expr: literal
      | ident
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
  literal: S_LITERAL {
          result = @builder.terminal_node(:s_literal, val[0])
        }
      | N_LITERAL {
          result = @builder.terminal_node(:n_literal, val[0])
        }
  equal: EQUAL {
        result = @builder.terminal_node(:equal, val[0])
       }
end
