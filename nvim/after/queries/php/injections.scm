; extends

(assignment_expression
    left: (variable_name (name) @_name (#match? @_name "query"))
    right: (encapsed_string (string_value) @sql ))
(assignment_expression
    left: (variable_name (name) @_name (#match? @_name "sql"))
    right: (encapsed_string (string_value) @sql ))
