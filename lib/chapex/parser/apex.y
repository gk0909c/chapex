class Chapex::Parser::Apex
rule
  apex_class: class_dec L_CB class_body  R_CB {
    result = @builder.apex_class([val[0], val[2]])
  }
  class_dec: scope class ident {
    result = @builder.class_dec(val[0, 3])
  }
  class_body:
          | blocks
  blocks: block {
            result = @builder.class_body(val[0])
          }
          | blocks block {
            result = val[0] << val[1]
          }
  block: field 
        | method
  field: scope ident ident SEMI {
            result =  @builder.field(val[0, 3])
          }
  method: scope ident ident L_RB R_RB L_CB stmts R_CB {
            result =  @builder.method(val[0, 3])
          }
  stmts: stmt
        | stmts stmt
  stmt: receiver ident L_RB argments R_RB SEMI
  receiver:  ident DOT
  argments: S_LITERAL
  class: CLASS {
        result = @builder.edge_node(:class, val[0])
       }
  scope: {
        result = @builder.edge_node(:scope, nil)
       }
       | SCOPE {
        result = @builder.edge_node(:scope, val[0])
       }
  ident: IDENT {
        result = @builder.edge_node(:ident, val[0])
      }
end
