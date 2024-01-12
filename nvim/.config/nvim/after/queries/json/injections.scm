;; extends
(
 (pair
  key: (string (string_content) @key-name) 
  value: (object
   (pair
    value: (string (string_content) @injection.content (#set! injection.language "bash"))
    )
   )
  )
  (#eq? @key-name "scripts")
 )
