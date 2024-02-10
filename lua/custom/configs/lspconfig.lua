local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

lspconfig.sqls.setup {
  on_attach = function(client, bufnr)
    -- The document formatting implementation of sqls is buggy.
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities
}

lspconfig.templ.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" }
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" }
}

lspconfig.htmx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
}

lspconfig.tailwindcss.setup = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  init_options = { userLanguages = { templ = "html" } },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    analyses = {
      assign = true,
      atomic = true,
      bools = true,
      composites = true,
      copylocks = true,
      deepequalerrors = true,
      embed = true,
      errorsas = true,
      fieldalignment = true,
      httpresponse = true,
      ifaceassert = true,
      loopclosure = true,
      lostcancel = true,
      nilfunc = true,
      nilness = true,
      nonewvars = true,
      printf = true,
      shadow = true,
      shift = true,
      simplifycompositelit = true,
      simplifyrange = true,
      simplifyslice = true,
      sortslice = true,
      stdmethods = true,
      stringintconv = true,
      structtag = true,
      testinggoroutine = true,
      tests = true,
      timeformat = true,
      unmarshal = true,
      unreachable = true,
      unsafeptr = true,
      unusedparams = true,
      unusedresult = true,
      unusedvariable = true,
      unusedwrite = true,
      useany = true,
    },
    hoverKind = "FullDocumentation",
    linkTarget = "pkg.go.dev",
    usePlaceholders = true,
    vulncheck = "Imports",
  }
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
}
