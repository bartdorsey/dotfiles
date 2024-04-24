return {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
    config = function()
        require("pets").setup()
    end,
}
