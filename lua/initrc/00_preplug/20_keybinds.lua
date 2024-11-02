U = require("util")
local vks = U.vks

-- enforce efficiency
vks("", "<Up>", "<NOP>", { silent = true })
vks("", "<Down>", "<NOP>", { silent = true })
vks("", "<Left>", "<NOP>", { silent = true })
vks("", "<Right>", "<NOP>", { silent = true })

-- TODO maybe use ':' for something?
vks("", ":", "<NOP>", {})
vks("", ";", ":", {})

-- shift is easier
vks("n", "<S-I>", "<C-O>", { desc = "Jump back" })
vks("n", "<S-K>", "<C-I>", { desc = "Jump forward" })

-- easy search and replace
vks("n", "<Leader>s", ":%s///g<Left><Left><Left>")

-- easier window hopping
vks("n", "w", "<C-w>", {})

-- easy wipeout to prevent buffer pollution
vks("n", "<A-BS>", ":bp|bd #<CR>", { silent = true })
