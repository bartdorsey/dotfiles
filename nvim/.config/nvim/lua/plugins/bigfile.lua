return {
    enabled = true,
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    },
}
