; extends
(
 (comment) @_comment-text
 (#match? @_comment-text "sql")
 (template_string) @ql
)
