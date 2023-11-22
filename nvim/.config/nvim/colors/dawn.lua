vim.cmd.source("~/.config/vim/colors/dawn.vim")

Dawn = {
    rosewater = "#F5E0DC",
    flamingo = "#F2CDCD",
    pink = "#F5C2E7",
    mauve = "#CBA6F7",
    red = "#F38BA8",
    maroon = "#EBA0AC",
    peach = "#FAB387",
    yellow = "#F9E2AF",
    green = "#A6E3A1",
    teal = "#94E2D5",
    sky = "#89DCEB",
    sapphire = "#74C7EC",
    blue = "#89B4FA",
    lavender = "#B4BEFE",
    text = "#CDD6F4",
    subtext1 = "#BAC2DE",
    subtext0 = "#A6ADC8",
    overlay2 = "#9399B2",
    overlay1 = "#7F849C",
    overlay0 = "#6C7086",
    surface2 = "#585B70",
    surface1 = "#45475A",
    surface0 = "#313244",
    base = "#1E1E2E",
    mantle = "#181825",
    crust = "#11111B",
    none = "NONE",
    slate = "#3C5E7F",
    poggers = "#7480C2",
    white = "#FFFFFF",
}

local function highlight(group, attrs)
    return vim.api.nvim_set_hl(0, group, attrs)
end

-- editor
highlight("DiagnosticDeprecated", { link = "Comment" })
highlight("DiagnosticError", { fg = Dawn.red })
highlight("DiagnosticHint", { fg = Dawn.teal })
highlight("DiagnosticInfo", { fg = Dawn.green })
highlight("DiagnosticUnderlineError", { link = "NONE" })
highlight("DiagnosticUnderlineHint", { link = "NONE" })
highlight("DiagnosticUnderlineInfo", { link = "NONE" })
highlight("DiagnosticUnderlineWarn", { link = "NONE" })
highlight("DiagnosticWarn", { fg = Dawn.yellow })
highlight("FloatBorder", { bg = Dawn.none })
highlight("LspCodeLens", { fg = Dawn.slate })
highlight("LspCodeLensSeparator", { link = "LspCodeLens" })
highlight("LspInlayHint", { link = "Comment" })
highlight("LspReferenceRead", { link = "LspReferenceText" })
highlight("LspReferenceText", { fg = Dawn.yellow, bold = true })
highlight("LspReferenceWrite", { link = "LspReferenceText" })
-- highlight("Normal", { bg = Dawn.none })
highlight("NormalFloat", { link = "Normal" })
highlight("SnippetTabstop", { bg = Dawn.surface0 })
highlight("TermCursor", { link = "Cursor" })
highlight("TermCursorNC", { bg = Dawn.lavender })
highlight("Whitespace", { fg = Dawn.surface0 })
highlight("WinBar", { fg = Dawn.sapphire, italic = true })

-- vimdoc
highlight("@label", { fg = Dawn.red, bold = true })
highlight("@text.literal.vimdoc", { fg = Dawn.overlay2 })
highlight("@text.reference", { fg = Dawn.red, bold = true })
highlight("@text.warning", { fg = Dawn.peach, bold = true })
highlight("helpOption", { fg = Dawn.red })

-- treesitter
highlight("@constant.builtin", { fg = Dawn.peach, bold = true })
highlight("@constructor", { link = "Type" })
highlight("@constructor.lua", { link = "Delimiter" })
highlight("@error", { link = "Error" })
highlight("@field", { fg = Dawn.lavender })
highlight("@function.builtin", { fg = Dawn.peach })
highlight("@label", { fg = Dawn.sapphire })
highlight("@namespace", { fg = Dawn.blue })
highlight("@parameter", { fg = Dawn.maroon })
highlight("@property", { link = "@field" })
highlight("@string.special", { fg = Dawn.mauve, bold = true })
highlight("@text.danger", { fg = Dawn.red, bold = true })
highlight("@text.literal", { link = "@text" })
highlight("@variable.builtin", { fg = Dawn.red })

-- lsp
highlight("@lsp.mod.attribute", { fg = Dawn.subtext1 })
highlight("@lsp.mod.controlFlow", { fg = Dawn.mauve, bold = true })
highlight("@lsp.mod.crateRoot", { fg = Dawn.red, bold = true })
highlight("@lsp.mod.defaultLibrary", { fg = Dawn.peach })
highlight("@lsp.mod.global", { fg = Dawn.white, bold = true })
highlight("@lsp.mod.library", { link = "@namespace" })
highlight("@lsp.mod.macro", { link = "@macro" })
highlight("@lsp.mod.static", { link = "@lsp.mod.global" })
highlight("@lsp.mod.trait", { link = "@lsp.typemod.interface" })
highlight("@lsp.mod.unsafe", { fg = Dawn.red, bold = true })
highlight("@lsp.type", { link = "@type" })
highlight("@lsp.type.attributeBracket", { link = "Delimiter" })
highlight("@lsp.type.character", { link = "@character" })
highlight("@lsp.type.constParameter", { fg = Dawn.white })
highlight("@lsp.type.escapeSequence", { fg = Dawn.mauve })
highlight("@lsp.type.formatSpecifier", { link = "Delimiter" })
highlight("@lsp.type.interface", { link = "@lsp.typemod.interface" })
highlight("@lsp.type.keyword", { link = "@keyword" })
highlight("@lsp.type.lifetime", { link = "@storageclass.lifetime" })
highlight("@lsp.type.member", { link = "NONE" })
highlight("@lsp.type.namespace", { link = "@namespace" })
highlight("@lsp.type.number", { link = "@number" })
highlight("@lsp.type.operator", { link = "@operator" })
highlight("@lsp.type.parameter", { link = "@parameter" })
highlight("@lsp.type.property", { link = "@property" })
highlight("@lsp.type.punctuation", { link = "@punctuation" })
highlight("@lsp.type.selfKeyword", { link = "@variable.builtin" })
highlight("@lsp.type.selfTypeKeyword", { link = "@type" })
highlight("@lsp.type.string", { link = "@string" })
highlight("@lsp.type.typeAlias", { link = "Type" })
highlight(
    "@lsp.typemod.attributeBracket",
    { link = "@lsp.type.attributeBracket" }
)
highlight("@lsp.typemod.builtinAttribute", { fg = Dawn.peach })
highlight("@lsp.typemod.builtinType", { link = "@lsp.type.builtinType" })
highlight("@lsp.typemod.character", { link = "@lsp.type.character" })
highlight("@lsp.typemod.decorator", { link = "@lsp.type.decorator" })
highlight("@lsp.typemod.derive", { link = "@lsp.typemod.interface" })
highlight("@lsp.typemod.enum", { link = "@lsp.type.enum" })
highlight("@lsp.typemod.enumMember", { link = "@lsp.type.enumMember" })
highlight("@lsp.typemod.generic", { link = "@lsp.type.generic" })
highlight("@lsp.typemod.generic.attribute", { link = "@lsp.mod.attribute" })
highlight("@lsp.typemod.generic.macro", { link = "@lsp.type" })
highlight(
    "@lsp.typemod.interface",
    { fg = Dawn.rosewater, bold = true, italic = true }
)
highlight(
    "@lsp.typemod.interface.defaultLibrary",
    { fg = Dawn.flamingo, bold = true, italic = true }
)
highlight("@lsp.typemod.keyword", { link = "@lsp.type.keyword" })
highlight("@lsp.typemod.keyword.crateRoot", { link = "@lsp.mod.crateRoot" })
highlight("@lsp.typemod.keyword.unsafe", { link = "@lsp.mod.unsafe" })
highlight("@lsp.typemod.macro", { link = "@lsp.type.macro" })
highlight("@lsp.typemod.method", { link = "@lsp.type.method" })
highlight("@lsp.typemod.namespace", { link = "@lsp.type.namespace" })
highlight("@lsp.typemod.namespace.crateRoot", { link = "@lsp.mod.crateRoot" })
highlight("@lsp.typemod.number", { link = "@lsp.type.number" })
highlight("@lsp.typemod.operator", { link = "@lsp.type.operator" })
highlight("@lsp.typemod.property", { link = "@lsp.type.property" })
highlight("@lsp.typemod.selfKeyword", { link = "@lsp.type.selfKeyword" })
highlight("@lsp.typemod.string", { link = "@lsp.type.string" })
highlight("@lsp.typemod.struct", { link = "@lsp.type.struct" })
highlight("@lsp.typemod.toolModule", { link = "@lsp.type.toolModule" })
highlight("@lsp.typemod.typeAlias", { link = "@lsp.type.typeAlias" })
highlight("@lsp.typemod.variable", { link = "@lsp.type.variable" })
highlight("@lsp.typemod.variable.global", { link = "@lsp.mod.global" })
highlight(
    "@lsp.typemod.variable.static",
    { link = "@lsp.type.variable.static" }
)

-- telescope
highlight("TelescopePromptCounter", { link = "Text" })
highlight("TelescopeSelection", { link = "CursorLine" })
highlight(
    "TelescopeMatching",
    { fg = Dawn.poggers, bold = true, italic = true }
)

-- fugitive
highlight("diffAdded", { link = "DiffAdd" })
highlight("diffRemoved", { link = "DiffDelete" })
