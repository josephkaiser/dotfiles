return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    config = function()
        local ok, mkdp = pcall(require, "mkdp")
        if not ok then
            return
        end

        mkdp.setup({
            auto_open = true,
            browser = "firefox",
            port = 8888,
        })
    end,
}
