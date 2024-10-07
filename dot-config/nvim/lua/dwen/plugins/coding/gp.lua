-- TODO: need to set up more sensible navigation for GpChatFinder popup
return {
  "robitx/gp.nvim",
  config = function()
    local gp = require("gp")

    gp.setup({
      providers = {
        anthropic = {
          disable = false,
          endpoint = "https://api.anthropic.com/v1/messages",
          secret = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
      hooks = {
        Explain = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by explaining the code above."
          local agent = gp.get_chat_agent()
          gp.Prompt(params, gp.Target.popup, agent, template)
        end,
      },
      default_chat_agent = "ChatClaude-3-5-Sonnet",
      default_command_agent = "CodeClaude-3-5-Sonnet",
    })
    local keymap = vim.keymap

    keymap.set("n", "<leader>ln", "<cmd>GpChatNew popup<cr>", { desc = "Create new LLM chat" })
    keymap.set("n", "<leader>ll", "<cmd>GpChatToggle popup<cr>", { desc = "Toggle last active LLM chat" })
    keymap.set("n", "<leader>lf", "<cmd>GpChatFinder<cr>", { desc = "Find LLM chat" })
    keymap.set("n", "<leader>fl", "<cmd>GpChatFinder<cr>", { desc = "Find LLM chat" })
    keymap.set("n", "<leader>le", "<cmd>GpExplain<cr>", { desc = "Explain the current line" })
    keymap.set("v", "<leader>le", ":'<,'>GpExplain<CR>", { desc = "Explain the selection" })
  end,
}