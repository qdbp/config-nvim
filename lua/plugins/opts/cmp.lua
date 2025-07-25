--- nvim‑cmp configuration extracted to its own module
--- Place this file somewhere in your &runtimepath, e.g.
---   ~/.config/nvim/lua/plugins/cmp.lua
--- and change the Lazy‑spec for `hrsh7th/nvim-cmp` to
---   { "hrsh7th/nvim-cmp", config = function() require("plugins.cmp")() end, ... }
---
--- Prerequisites (add as plugins if you don't already use them):
---   * hrsh7th/cmp-nvim-lsp
---   * hrsh7th/cmp-buffer
---   * hrsh7th/cmp-path
---   * hrsh7th/cmp-cmdline        -- NEW: dedicated cmdline source
---   * L3MON4D3/LuaSnip           -- for snippet support
---   * zbirenbaum/copilot-cmp     -- for GitHub Copilot integration
---
--- Neovim ≥ 0.10 is recommended.

return function()
  ---------------------------------------------------------------------------
  --  Requirements & global opts                                           --
  ---------------------------------------------------------------------------
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  -- Completion pop‑up behaviour
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  ---------------------------------------------------------------------------
  --  Helpers                                                              --
  ---------------------------------------------------------------------------
  ---Check if there is a non‑whitespace character before the cursor.
  ---Prevents <Tab> from inserting ^I at BOL.
  ---@return boolean
  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 then return false end
    local prev_char = vim.api.nvim_buf_get_text(0, line - 1, col - 1, line - 1, col, {})[1]
    return not prev_char:match("%s")
  end

  ---------------------------------------------------------------------------
  --  Insert‑mode mappings                                                 --
  ---------------------------------------------------------------------------
  local insert_mapping = {
    -- Trigger completion explicitly
    ["<A-Tab>"] = cmp.mapping.complete(),

    -- Navigate completion menu / jump in snippets / fallback
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Accept currently selected item
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }

  ---------------------------------------------------------------------------
  --  Core completion setup                                               --
  ---------------------------------------------------------------------------
  cmp.setup({
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },

    mapping = cmp.mapping.preset.insert(insert_mapping),

    sources = cmp.config.sources({
      { name = "copilot" },
      {
        name = "nvim_lsp",
        entry_filter = function(entry, _)
          -- Filter out Python‑style dunder methods (__init__ etc.)
          return not entry:get_insert_text():match("^__.*__$")
        end,
      },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    }),

    experimental = { ghost_text = true },
  })

  ---------------------------------------------------------------------------
  --  Cmdline‑mode setups                                                 --
  ---------------------------------------------------------------------------
  -- 1. Search (`/` and `?`) uses just the buffer source.
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
  })

  -- Helper for <Tab>/<S-Tab> inside command‑line mode
  local function c_tab(next)
    return function()
      if cmp.visible() then
        if next then
          cmp.select_next_item()
        else
          cmp.select_prev_item()
        end
      else
        cmp.complete()
      end
    end
  end

  -- Feed an <CR> into the cmdline, effectively executing the command typed
  local function feed_cr()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
  end

  -- 2. Commands (`:`) combine path + cmdline sources.
  cmp.setup.cmdline(":", {
    -- Use the cmdline preset and extend it with our own <Tab> logic
    mapping = cmp.mapping.preset.cmdline({
      ["<Tab>"] = { c = c_tab(true) },
      ["<S-Tab>"] = { c = c_tab(false) },
      --  pressing <CR> on something like `:q` should *not* expand to the
      --  first completion (often `qall`).  Only confirm if the user has
      --  actively selected an entry.
      ["<CR>"] = {
        c = function()
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = false })
          else
            cmp.close()
            feed_cr() -- execute the typed command as-is
          end
        end,
      },
    }),

    -- Two‑tier source list: path has priority over cmdline keywords.
    sources = cmp.config.sources(
      { { name = "path" } }, -- first group (higher priority)
      { { name = "cmdline" } } -- second group
    ),

    -- Allow fuzzy matches with leading symbols (e.g. :Git).
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end
