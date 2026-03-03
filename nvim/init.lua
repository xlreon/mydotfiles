-- =============================================================================
-- Neovim config - Sidharth Satapathy (@xlreon)
-- Modern: lazy.nvim + native LSP + AI (avante.nvim + copilot)
-- =============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Options
-- =============================================================================
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.splitbelow = true
opt.splitright = true
opt.clipboard = "unnamedplus"  -- use system clipboard
opt.undofile = true            -- persistent undo
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 400

opt.completeopt = { "menu", "menuone", "noselect" }

-- Insert mode → absolute line numbers; Normal mode → relative
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() vim.opt.relativenumber = true end,
})

-- =============================================================================
-- Leader key
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Keymaps
-- =============================================================================
local map = function(mode, lhs, rhs, opts)
  opts = opts or { silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Better escape
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Window navigation (matches VS Code & tmux bindings)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits
map("n", "<C-Up>",    ":resize +2<CR>")
map("n", "<C-Down>",  ":resize -2<CR>")
map("n", "<C-Left>",  ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines up/down (like VS Code Alt+Up/Down)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep visual selection after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Center screen after jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Clear search highlight
map("n", "<leader>nh", ":nohl<CR>")

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprev<CR>")
map("n", "<leader>bd", ":bdelete<CR>")

-- Save
map("n", "<Space>", ":w<CR>")

-- Telescope (replaces fzf.vim + CtrlSF)
map("n", "<C-p>",      "<cmd>Telescope find_files hidden=true<CR>")
map("n", "<C-f>f",     "<cmd>Telescope live_grep<CR>")
map("n", "<C-f>n",     "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
map("n", "<leader>fg", "<cmd>Telescope git_status<CR>")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>")

-- Neo-tree (replaces NERDTree, same shortcut)
map("n", "<C-b>", "<cmd>Neotree toggle<CR>")
map("n", "<leader>pv", "<cmd>Neotree reveal<CR>")

-- LSP (mirrors old CoC keybindings)
map("n", "<leader>gd", vim.lsp.buf.definition)
map("n", "<leader>gy", vim.lsp.buf.type_definition)
map("n", "<leader>gi", vim.lsp.buf.implementation)
map("n", "<leader>gr", vim.lsp.buf.references)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ac", vim.lsp.buf.code_action)
map("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end)
map("n", "<leader>qf", vim.diagnostic.setloclist)
map("n", "K",          vim.lsp.buf.hover)
map("n", "[d",         vim.diagnostic.goto_prev)
map("n", "]d",         vim.diagnostic.goto_next)

-- Git
map("n", "<leader>bs", "<cmd>Git blame<CR>")
map("n", "<leader>lg", "<cmd>LazyGit<CR>")

-- Avante AI (new! AI assistant in editor)
-- <leader>aa  → open AI chat
-- <leader>ae  → explain code
-- <leader>ar  → refactor with AI
-- (configured in avante plugin below)

-- =============================================================================
-- Plugins (lazy.nvim)
-- =============================================================================
require("lazy").setup({

  -- ── Colorscheme ──────────────────────────────────────────────────────────
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({ contrast = "hard" })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- ── UI ───────────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_c = {
            { "filename", path = 1 },  -- relative path
          },
        },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({ options = { diagnostics = "nvim_lsp" } })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require("ibl").setup() end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end,
  },

  {
    "mhinz/vim-startify",  -- keep the start screen
    config = function()
      vim.g.startify_change_to_dir = 0
    end,
  },

  -- ── File tree ─────────────────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 35 },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = { enabled = true },
        },
      })
    end,
  },

  -- ── Fuzzy Finder ─────────────────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          layout_config = { horizontal = { preview_width = 0.55 } },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- ── Treesitter (better syntax highlighting) ───────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "javascript", "typescript", "tsx",
          "python", "html", "css", "json", "markdown", "bash",
          "go", "rust", "yaml", "toml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      })
    end,
  },

  -- ── LSP ──────────────────────────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",          -- TypeScript/JavaScript
          "pyright",        -- Python
          "html",
          "cssls",
          "tailwindcss",
          "jsonls",
          "lua_ls",
          "eslint",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = { "ts_ls", "pyright", "html", "cssls", "tailwindcss", "jsonls", "eslint" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({ capabilities = capabilities })
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

    end,
  },
  {
    "stevearc/conform.nvim",  -- formatting (replaces none-ls)
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript      = { "prettier" },
          typescript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          css             = { "prettier" },
          html            = { "prettier" },
          json            = { "prettier" },
          markdown        = { "prettier" },
          python          = { "ruff_format" },
          lua             = { "stylua" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,  -- fall back to LSP if no formatter found
        },
      })
    end,
  },

  -- ── Autocompletion ────────────────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
          ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]   = cmp.mapping.scroll_docs(4),
          ["<C-e>"]   = cmp.mapping.abort(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- ── AI: GitHub Copilot ────────────────────────────────────────────────────
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },  -- using cmp source instead
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function() require("copilot_cmp").setup() end,
  },

  -- ── AI: Avante (Claude/GPT chat in editor) ────────────────────────────────
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      provider = "claude",  -- use Claude (set ANTHROPIC_API_KEY in ~/.secrets)
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-6",
        max_tokens = 8192,
      },
      -- Keymaps
      mappings = {
        ask = "<leader>aa",        -- ask AI
        edit = "<leader>ae",       -- edit with AI
        refresh = "<leader>ar",    -- refresh AI response
        diff = {
          ours = "co",
          theirs = "ct",
          both = "cb",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  },

  -- ── Git ──────────────────────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",  -- replaces vim-gitgutter
    config = function()
      require("gitsigns").setup({
        signs = {
          add    = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
        },
      })
    end,
  },
  { "tpope/vim-fugitive" },         -- Git commands in nvim (:Git, :Gblame)
  {
    "kdheepak/lazygit.nvim",         -- LazyGit TUI in nvim
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- ── Editing ──────────────────────────────────────────────────────────────
  { "tpope/vim-surround" },
  { "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },
  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end,
  },
  { "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup() end,
  },
  {
    "folke/which-key.nvim",   -- shows keybinding hints
    event = "VeryLazy",
    config = function() require("which-key").setup() end,
  },
  {
    "folke/trouble.nvim",     -- pretty diagnostics list
    config = function() require("trouble").setup() end,
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>" },
    },
  },

  -- ── Markdown ─────────────────────────────────────────────────────────────
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
  },

}, {
  ui = {
    icons = {
      cmd = "⌘", config = "🛠", event = "📅", ft = "📂",
      init = "⚙", keys = "🗝", plugin = "🔌", runtime = "💻",
      source = "📄", start = "🚀", task = "📌",
    },
  },
})
