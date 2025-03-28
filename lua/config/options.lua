-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.api.nvim_set_keymap('n', '<leader>h', ':Dashboard<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>yf", ":let @+ = expand('%:p')<CR>", { desc = "Yank Filepath" })

vim.api.nvim_create_user_command("Repo", function()
  local handle = io.popen("git remote get-url origin")
  if handle then
    local url = handle:read("*a"):gsub("%s+$", "")
    handle:close()

    if url == "" then
      print("No remote URL found")
      return
    end

    url = url:gsub("^git@([^:]+):(.+)$", "https://%1/%2")

    local open_cmd = vim.fn.has("win32") == 1 and "start" or "xdg-open"
    os.execute(open_cmd .. " " .. url)
  end
end, { desc = "Open remote repository" })