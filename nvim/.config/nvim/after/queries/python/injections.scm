;; extends
(
    call function: (attribute 
        object: (identifier) 
        attribute: (identifier) @method (#eq? @method "execute")
    )
    arguments: (argument_list 
               (string (string_content) @injection.content 
                       (#set! injection.language "sql")))
)

