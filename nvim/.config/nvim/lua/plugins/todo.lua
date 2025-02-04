return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { signs = false },
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup()
    
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    local Hydra = require("hydra")
    local cmd = require("hydra.keymap-util").cmd

    Hydra({
      name = "TODO",
      hint = [[
_[_: prev todo _t_: project todos
_]_: next todo _s_: search project todos

            _<Esc>_: exit
]],
      config = {
        color = "red",
        invoke_on_body = true,
        hint = {
          float_opts = {
            border = "rounded",
          },
        },
      },
      mode = "n",
      body = "<leader>t",
      heads = {
        {
          "[",
          function()
            todo_comments.jump_prev()
          end,
        },
        {
          "]",
          function()
            todo_comments.jump_next()
          end,
        },
        { "t",     cmd("Trouble todo toggle"), { exit = true } },
        { "s",     cmd("TodoFzfLua"),          { exit = true } },
        { "<Esc>", nil,                        { exit = true, nowait = true } },
      },
    })
  end,
}
