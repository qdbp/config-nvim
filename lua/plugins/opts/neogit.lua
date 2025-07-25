return {
  -- ❶  Overall look & feel ----------------------------------------------
  kind = "floating", -- open in the current window instead of a tab

  commit_editor = {
    kind = "floating", -- open commit editor in a floating window
  },

  rebase_editor = {
    kind = "floating", -- open rebase editor in a floating window
  },

  commit_view = {
    kind = "floating", -- open commit view in a vertical split
    show_patch_in_split = true, -- show the patch in the commit view split
  },
  use_icons = true, -- enable devicons everywhere
  graph_style = "unicode", -- ─╮ prettier branch graph (ascii|unicode|kitty)

  -- ❷  Status buffer cosmetics ------------------------------------------
  status = {
    show_head_commit_hash = true, -- (adds the short SHA after HEAD)
    recent_commit_count = 15,
    HEAD_padding = 6, -- tighten the header
    mode_padding = 2,
  },

  -- ❸  Folding & sections ----------------------------------------------
  sections = {
    untracked = { folded = false, hidden = false },
    unstaged = { folded = false },
    staged = { folded = false },
    stashes = { folded = true, hidden = false },
  },

  -- ❹  Signs / chevrons -------------------------------------------------
  signs = {
    --   { closed,  open }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" }, -- disable inline hunk folding arrow
  },

  -- ❺  Window-dressing --------------------------------------------------
  floating = {
    border = "rounded",
    width = 0.5,
    height = 0.75,
  },
  disable_line_numbers = true,
  disable_relative_line_numbers = true,

  -- ❻  Behaviour tweaks -------------------------------------------------
  auto_refresh = true,
  auto_show_console = false,
  disable_commit_confirmation = true,
}
