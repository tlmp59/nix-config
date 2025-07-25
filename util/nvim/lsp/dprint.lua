---@type vim.lsp.Config
return {
    cmd = { 'dprint', 'lsp' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'json',
        'jsonc',
        'markdown',
        'python',
        'toml',
        'rust',
        'roslyn',
        'graphql',
    },
    root_markers = {
        'dprint.json',
        '.dprint.json',
        'dprint.jsonc',
        '.dprint.jsonc',
    },
}
