-- please see https://github.com/qdbp/SalmonTheme?tab=readme-ov-file#the-restraint-scheme
-- for an explanation for the motivation and design language used here
-- Initialize color palette
-- SALMON TWILIGHT
local palette = {
    name = "Restraint",
    view = "Twilight",
    colors = {
        ["bg_0"] = "#ccc7c8",
        ["bg_1"] = "#d3c6c6",
        ["bg_2"] = "#d8c5c0",
        ["bg_3"] = "#d8c8b9",
        ["bg_4"] = "#d2ccb9",
        ["bg_5"] = "#c9cdbd",
        ["bg_6"] = "#c7ccc3",
        ["bg_7"] = "#c8c9c7",
        ["dbg_0"] = "#beb9b8",
        ["dbg_1"] = "#c2b8b7",
        ["dbg_2"] = "#c6b8b2",
        ["dbg_3"] = "#c7baad",
        ["dbg_4"] = "#c2bdad",
        ["dbg_5"] = "#bcbdb0",
        ["dbg_6"] = "#babcb4",
        ["dbg_7"] = "#bbbbb7",
        ["white"] = "#fdf7ee",
        ["bg_light"] = "#f1eae2",
        ["bg"] = "#ece6dd",
        ["bg_dark"] = "#d4cec7",
        ["bg_darker"] = "#c4beb8",
        ["neutral"] = "#908c87",
        ["fg_light"] = "#6f6b67",
        ["fg"] = "#3c3a38",
        ["fg_dark"] = "#21201f",
        ["black"] = "#000000",
        ["hl_0"] = "#b6b1c6",
        ["hl_1"] = "#caabbf",
        ["hl_2"] = "#daaaaa",
        ["hl_3"] = "#dbb393",
        ["hl_4"] = "#c7c091",
        ["hl_5"] = "#aac3a1",
        ["hl_6"] = "#9fbfb4",
        ["hl_7"] = "#a5b9c2",
        ["hlbg_0"] = "#c4bfc8",
        ["hlbg_1"] = "#d0bcc4",
        ["hlbg_2"] = "#dabbb8",
        ["hlbg_3"] = "#dac0ab",
        ["hlbg_4"] = "#cec8a9",
        ["hlbg_5"] = "#bec9b2",
        ["hlbg_6"] = "#b8c7bd",
        ["hlbg_7"] = "#bbc3c5",
        ["hyper_0"] = "#4f3ba3",
        ["hyper_1"] = "#812687",
        ["hyper_2"] = "#a23249",
        ["hyper_3"] = "#aa5400",
        ["hyper_4"] = "#897d00",
        ["hyper_5"] = "#007e2d",
        ["hyper_6"] = "#008274",
        ["hyper_7"] = "#006893",
        ["hyperhl_0"] = "#8077c8",
        ["hyperhl_1"] = "#b365b1",
        ["hyperhl_2"] = "#d56676",
        ["hyperhl_3"] = "#d8813c",
        ["hyperhl_4"] = "#b0a432",
        ["hyperhl_5"] = "#56ab5c",
        ["hyperhl_6"] = "#00a595",
        ["hyperhl_7"] = "#328fba",
        ["pri_0"] = "#4d0054",
        ["pri_1"] = "#6c1d1b",
        ["pri_2"] = "#6b5000",
        ["pri_3"] = "#005118",
        ["pri_4"] = "#005254",
        ["pri_5"] = "#131b6a",
        ["shd000"] = "#b7b2b1",
        ["shd001"] = "#bbb1b0",
        ["shd002"] = "#c0b1ac",
        ["shd003"] = "#c0b3a7",
        ["shd004"] = "#bbb6a7",
        ["shd005"] = "#b5b6aa",
        ["shd006"] = "#b3b5ae",
        ["shd007"] = "#b4b4b1",
        ["tint_0"] = "#786372",
        ["tint_1"] = "#87655e",
        ["tint_2"] = "#807353",
        ["tint_3"] = "#63755d",
        ["tint_4"] = "#59706e",
        ["tint_5"] = "#656876",
        ["tone_0"] = "#28004e",
        ["tone_1"] = "#470025",
        ["tone_2"] = "#592700",
        ["tone_3"] = "#364100",
        ["tone_4"] = "#004430",
        ["tone_5"] = "#003048",
        ["ult_0"] = "#480084",
        ["ult_1"] = "#750042",
        ["ult_2"] = "#8c4200",
        ["ult_3"] = "#576700",
        ["ult_4"] = "#006c50",
        ["ult_5"] = "#000091",
        ["wht_0"] = "#e2dcda",
        ["wht_1"] = "#e6dbd8",
        ["wht_2"] = "#eadbd4",
        ["wht_3"] = "#eadccf",
        ["wht_4"] = "#e5dfcf",
        ["wht_5"] = "#e0e0d2",
        ["wht_6"] = "#dedfd6",
        ["wht_7"] = "#dfded9"
    },
}

local c = palette.colors
H = {}

-- *** SEMANTIC HIGHLIGHTING (SCHEME) ***
H.base_scheme = {
    -- we have a hierarchy of truth for highlighting information
    -- at the apex are LSP semantic token highlights

    -- LSP
    -- lsp mods
    ['@lsp.mod.builtin'] = { fg = c.ult_0 },
    ['@lsp.mod.defaultLibrary'] = '@lsp.builtin',
    -- TODO this doesn't work, need to use a callback to handle it properly!
    -- or better, fix upstream
    -- ['@lsp.mod.definition'] = { bold = false },
    ['@lsp.mod.classScope'] = '@lsp.property',

    -- lsp types
    ['@lsp.type.comment'] = { fg = c.fg_light },
    ['@lsp.type.unknown'] = { fg = c.fg_dark },
    -- text-like
    -- literal-like
    ['@lsp.type.boolean'] = { fg = c.tone_1, bold = true },
    ['@lsp.type.number'] = { fg = c.tone_1 },
    ['@lsp.type.string'] = { fg = c.tone_3 },
    ['@lsp.type.character'] = { fg = c.tone_4 },
    ['@lsp.type.regexp'] = { fg = c.tone_4 },
    -- class-like
    ['@lsp.type.enum'] = { fg = c.tone_1 },
    ['@lsp.type.class'] = { fg = c.tone_5 },
    ['@lsp.type.struct'] = { fg = c.tone_1 },
    -- function-like
    ['@lsp.type.function'] = { fg = c.black },
    ['@lsp.type.method'] = { fg = c.black },
    -- variable-like
    ['@lsp.type.constant'] = { fg = c.ult_5 },
    ['@lsp.type.parameter'] = { fg = c.pri_4 },
    ['@lsp.type.variable'] = { fg = c.fg_dark },
    ['@lsp.type.property'] = { fg = c.pri_1 },
    ['@lsp.type.enumMember'] = { fg = c.ult_1 },
    -- control flow-like
    ['@lsp.type.keyword'] = { fg = c.black, bold = true },
    ['@lsp.type.operator'] = '@lsp.type.keyword',
    ['@lsp.type.macro'] = { fg = c.ult_4 },
    ['@lsp.type.label'] = { fg = c.ult_2, bold = true },
    -- metaprogramming and scoping-like
    ['@lsp.type.decorator'] = { fg = c.ult_1 },
    ['@lsp.type.namespace'] = { fg = c.tint_3 },

    -- lsp legacy types; older LSPs still issue these?
    ['@lsp.enumMember'] = '@lsp.type.enumMember',
    ['@lsp.typeParameter'] = '@lsp.type.parameter',
    ['@lsp.operator'] = '@lsp.type.operator',
    ['@lsp.constant'] = '@lsp.type.constant',

    -- we're kind of making these one up, but they're handy
    ['@lsp.metadata'] = { fg = c.ult_1 },
    ['@lsp.label'] = '@lsp.type.label',

    -- base
    -- TODO fill out all entries from vim docs
    Comment = '@lsp.type.comment',
    SpecialComment = { fg = c.tint_5, bold = true },
    Todo = { fg = c.tint_1, bold = true },
    Constant = '@lsp.constant',

    -- primitives
    String = '@lsp.string',
    Character = '@lsp.type.regexp',
    Special = '@lsp.type.regexp',
    SpecialChar = { fg = c.tone_4 },
    Number = '@lsp.number',
    Float = '@lsp.number',
    Boolean = '@lsp.boolean',

    -- variables
    Identifier = '@lsp.variable',
    Function = '@lsp.function',
    Metadata = '@lsp.type.decorator',
    PreProc = '@lsp.type.decorator',
    Define = '@lsp.macro',
    Macro = '@lsp.macro',
    Include = '@lsp.macro',

    -- conrol flow
    Keyword = '@lsp.type.keyword',
    Statement = 'Keyword',
    Conditional = 'Keyword',
    Repeat = 'Keyword',
    Label = { fg = c.ult_2, bold = true },
    Operator = '@lsp.type.operator',

    -- syntax
    StorageClass = '@lsp.type.keyword',
    Exception = '@lsp.type.keyword',
    Type = '@lsp.type.class',
    PreCondit = '@lsp.type.keyword',
    Structure = '@lsp.type.struct',
    Typedef = '@lsp.type',
    Tag = '@lsp.keyword',
    Delimiter = { fg = c.fg_light }, -- unobtrusive

    -- meta
    Debug = '@lsp.keyword',
    Underlined = { underline = true },
    Ignore = { link = 'Comment' },
    Error = { fg = c.pri_1 },
    Added = '@diff.plus',
    Changed = '@diff.delta',
    Removed = '@diff.minus',

    LspReferenceRead = { bg = c.hl_0 },
    LspReferenceWrite = { bg = c.hl_5 },

    -- TREESITTER
    -- note: most of these should be defined in links pointing back to LSP
    -- only add cases here that are not well-covered by LSP
    ['@comment'] = 'Comment',
    ['@string.documentation'] = { fg = c.tint_2, bold = true },

    -- TODO unsorted

    -- variable-like
    ['@attribute'] = '@lsp.type.metadata',
    ['@variable'] = '@lsp.type.variable',
    ['@variable.builtin'] = '@lsp.type.builtin',
    ['@variable.parameter'] = '@lsp.type.parameter',
    ['@variable.member'] = '@lsp.type.property',
    ['@field'] = '@lsp.type.property',
    ['@constant'] = '@lsp.type.constant',
    ['@constant.builtin'] = '@lsp.type.constant',
    ['@parameter'] = '@lsp.type.parameter',
    ['@property'] = '@lsp.type.property',

    -- primite-like
    ['@boolean'] = '@lsp.type.boolean',
    ['@character'] = '@lsp.type.string',
    ['@constant.macro'] = '@lsp.type.macro',
    ['@constructor'] = '@lsp.type.method',
    ['@exception'] = '@lsp.type.keyword',
    ['@float'] = '@lsp.type.number',
    ['@function'] = '@lsp.type.function',
    ['@function.builtin'] = '@lsp.type.builtin',
    ['@function.macro'] = '@lsp.type.macro',

    -- keyword-like
    ['@conditional'] = '@lsp.type.keyword',
    ['@include'] = '@lsp.type.keyword',
    ['@keyword'] = 'Keyword',
    ['@keyword.conditional'] = '@keyword',
    ['@keyword.function'] = '@keyword',
    ['@keyword.operator'] = '@keyword',
    ['@operator'] = '@lsp.type.operator',
    ['@punctuation.delimiter'] = 'Delimiter',
    ['@punctuation.bracket'] = '@lsp.type.operator',
    ['@punctuation.special'] = '@lsp.type.operator',
    ['@repeat'] = '@lsp.type.keyword',
    ['@label'] = '@lsp.type.label',


    -- function-like
    ['@method'] = '@lsp.type.method',
    ['@function.call'] = { bold = true },
    ['@function.method.call'] = { bold = true },

    -- namespace-like
    ['@namespace'] = '@lsp.type.namespace',
    ['@module'] = '@lsp.type.namespace',

    ['@number'] = '@lsp.type.number',
    ['@string'] = '@lsp.type.string',
    ['@string.regex'] = '@lsp.type.string',
    ['@string.escape'] = '@lsp.type.string',
    ['@tag'] = '@lsp.type.keyword',
    ['@tag.attribute'] = '@lsp.type.property',
    ['@tag.delimiter'] = '@lsp.type.operator',
    ['@text'] = '@lsp.type.variable',
    ['@type'] = '@lsp.type.class',
    ['@type.builtin'] = '@lsp.type.class',

    -- language specific
    -- C/C++
    ['@attribute.cpp'] = { fg = c.tint_1 },                  -- make it less garish
    -- Python
    ['@punctuation.delimiter.python'] = '@lsp.type.keyword', -- needs this weight
    -- TODO need a general solution for this `@spell` issue...
    ['@spell.python'] = 'Comment'
}

-- THEME: styling the window and non-code elements
H.base_theme = {
    -- cursor tweaks
    Cursor = { fg = c.bg_light, bg = c.black },
    lCursor = { fg = c.black, bg = c.black },

    -- basics
    Normal = { fg = c.fg_dark, bg = c.bg },
    NormalNC = { fg = c.fg },
    WinSeparator = { fg = c.tint_1, bg = c.tint001 },
    Identifier = { link = 'Normal' },
    Special = { fg = c.tone_4 },
    ErrorMsg = { fg = c.pri_1 },

    -- window tile
    WinBar = { bg = c.dbg_3, fg = c.black },
    WinBarNC = { bg = c.dbg_3, fg = c.fg },

    -- bottom of screen
    -- basic
    MsgArea = { fg = c.fg, bg = c.bg_3 },
    StatusLine = { fg = c.fg_dark, bg = c.bg_3 },
    StatusLineNC = { fg = c.fg_light, bg = c.bg_3 },
    ModeMsg = { fg = c.fg, bold = true, bg = c.bg_3 },
    MoreMsg = { fg = c.fg, bold = true, bg = c.bg_3 },

    -- left of screen, gutter, and cursor rows
    LineNr = { fg = c.fg_light },
    CursorLine = { bg = c.wht_4 },
    CursorLineNR = { fg = c.tone_1 },
    FoldColumn = { fg = c.tint_1, bg = c.bg_3 },
    SignColumn = { link = 'FoldColumn' },
    GitGutterAdd = { bg = c.hl_5, fg = c.black },
    GitGutterChange = { bg = c.hl_3, fg = c.black },
    GitGutterDelete = { bg = c.hl_2, fg = c.black },
    GitGutterChangeDelete = { bg = c.hl_2, fg = c.black },

    -- top of screen
    TabLineFill = { bg = c.bg_3, fg = c.fg },
    TabLineSel = { bg = c.wht_4, fg = c.black },
    TabLine = { bg = c.bg_3, fg = c.fg },

    -- popups and modals
    NormalFloat = { bg = c.bg_3 },
    FloatBorder = { bg = c.hlbg_7 },
    FloatTitle = { bg = c.hlbg_7 },
    FloatFooter = { bg = c.hlbg_7 },
    Pmenu = { fg = c.fg, bg = c.bg_7 },
    PmenuSel = { fg = c.fg, bg = c.wht_6 },
    PmenuThumb = { fg = c.fg, bg = c.bg_3 },
    QuickFixLine = { bg = c.hlbg_7, bold = true },

    -- selection, folded, search and match highlights
    Visual = { bg = c.hl_0 },
    Folded = { fg = c.fg_light, bg = c.hlbg_7 },
    MatchParen = { bg = c.hl_7 },
    Search = { bg = c.hl_4 },

    -- diagnostics
    DiagnosticError = { fg = c.black, bg = c.hl_2 },
    DiagnosticUnderlineError = { sp = c.hyper_2, undercurl = true },
    DiagnosticWarn = { fg = c.fg, bg = c.hl_3 },
    DiagnosticUnderlineWarn = { sp = c.hyper_3, undercurl = true },
    DiagnosticInfo = { fg = c.fg, bg = c.hl_0 },
    DiagnosticUnderlineInfo = { sp = c.hl_0, underline = true },
    DiagnosticHint = { fg = c.fg, bg = c.hl_7 },
    DiagnosticUnderlineHint = { sp = c.hl_7, underline = true },
    DiagnosticOK = { fg = c.fg, bg = c.hl_5 },
    DiagnosticUnnecessary = 'Comment',
    WarningMsg = { fg = c.hyper_2 },
    -- debugging
    Breakpoint = { fg = c.hyper_2, bold = true, bg = c.wht_6 },
    BreakpointCondition = { fg = c.hyper_1, bold = true, bg = c.wht_6 },

    -- diffs
    DiffAdd = {bg = c.hl_5},
    DiffDelete = {bg = c.bg_darker },
    DiffChanged = {bg = c.hl_7 },

    ['@diff.plus'] = { bg = c.hl_5 },
    ['@diff.delta'] = { bg = c.hl_7 },
    ['@diff.minus'] = { bg = c.hl_2 },

    -- file navigation
    Directory = { fg = c.pri_5 },

    -- markdown et al
    Title = { fg = c.black, bold = true },
    -- TODO group these better
    Question = { fg = c.ult_5 },
    RenderMarkdownCode = { bg = c.wht_0 },
}


-- PLUGIN SPECIFIC
-- mason

H.mason_highlights = {
    MasonHighlight = { fg = c.pri_0 },
}

H.avante_highlights = {
    -- TODO avante diff resolution
    AvanteTitle = { fg = c.black, bg = c.bg_3, bold = true },
    AvanteSubtitle = { fg = c.black, bg = c.bg_3 },
    AvanteThirdTitle = { fg = c.fg, bg = c.bg_3 },
    AvanteReversedTitle = 'AvanteTitle',
    AvanteReversedSubtitle = 'AvanteSubtitle',
    AvanteReversedThirdTitle = 'AvanteThirdTitle',
    AvantePopupHint = { link = 'Comment' },
    AvanteInlineHint = { fg = c.fg_light }
}

-- telescope pimpage
H.telecope_highlights = {
    TelescopeNormal = { fg = c.fg_dark, bg = c.wht_4 },
    TelescopeMatching = { bold = true, bg = c.hl_4 },
}

-- nvim-tree
H.nvim_tree_highlights = {
    NvimTreeNormal = { bg = c.bg_3 },
    NvimTreeExecFile = { fg = c.pri_1 },
    NvimTreeImageFile = { fg = c.pri_3 },
    NvimTreeFolderIcon = 'Directory',
    NvimTreeGitNewIcon = { fg = c.pri_3 },
    NvimTreeGitDirtyIcon = { fg = c.pri_5 },
}

-- neogit
H.neogit_highlights = {
    NeogitSectionHeader = { fg = c.fg_dark }
}

-- Set highlight groups
local function set_highlights()
    -- theme cursor correctly
    vim.cmd('set guicursor=n-v-c:block-Cursor,i:ver1')

    for _, highlight_group in pairs(H) do
        for key, hl in pairs(highlight_group) do
            if type(hl) == "string" then
                vim.api.nvim_set_hl(0, key, { link = hl })
            else
                vim.api.nvim_set_hl(0, key, hl)
            end
        end
    end
end

-- SIGNS
-- Existing dap_signs definition
local dap_signs = {
    DapBreakpoint = { text = 'O', texthl = 'Breakpoint' },
    DapBreakpointCondition = { text = 'O', texthl='BreakpointCondition' },
    DapStopped = { text = '>', texthl = 'Breakpoint', linehl = 'DiagnosticWarn' },
    DapBreakpointRejected = {text = 'X', texthl = 'Comment' },
}

local all_signs = {
    dap_signs,
    -- Add other sign groups here as needed
}

local function set_signs()
    for _, sign_group in ipairs(all_signs) do
        for sign_name, sign_def in pairs(sign_group) do
            vim.fn.sign_define(sign_name, sign_def)
        end
    end
end

-- Call set_signs function
set_signs()


-- TODO call just for debugging, remove later
set_highlights()
-- TODO how to package as plugin?
return set_highlights
