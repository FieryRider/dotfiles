vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noselect"

require'cmp'.setup {
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  --[[
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  --]]
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip' },

    { name = 'path' },
    { name = 'calc' },
    { name = 'spell' },
    { name = 'tags' },
    { name = 'snippets-nvim' },
    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
  }
}

