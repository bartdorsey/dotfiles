local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

vim.notify("Loaded markdown snippets")

return {
    s("TODO", {
        t("<!-- TODO: "),
        i(1),
        t("-->"),
    }),
}
