class Chapex::Apex
rule
  apex_class: class_def class_body
  class_def: CLASS_DEF { @checker.class_name(val[0]) }
  class_body:
            | variable
  variable: VARIABLE_DEF { @vars << val[0] }
          | variable VARIABLE_DEF { @vars << val[1] }
end

---- header
  require 'chapex/parser'
