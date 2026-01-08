return {
    '3rd/time-tracker.nvim',
    event = 'VeryLazy',
    dependencies = {"3rd/sqlite.nvim"},
    opts = {
        data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
        tracking_timeout_seconds = 1 * 60, -- Track idle time after first minute
    },
}
