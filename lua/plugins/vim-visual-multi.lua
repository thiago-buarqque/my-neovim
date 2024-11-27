return {
    {
        "mg979/vim-visual-multi",
        branch = "master",
        config = function()
            vim.g.VM_maps = {
                ['Find Next'] = '<M-]>', -- Alt + ]
                ['Find Prev'] = '<M-[>', -- Alt + [
            }
        end,
    },
}
