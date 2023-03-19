require("user.keymaps")

local M = {}

M.load_api_key = function()
    vim.fn.setenv('OPENAI_API_KEY', os.getenv("OPENAI_API_KEY"))
end

local config = {
    CHAT_GPT_NVIM_MAPPINGS,
}

M.setup = function()
    local ok, chatgpt = pcall(require, 'chatgpt')
    if not ok then
        vim.notify("missing module chatgpt", vim.log.levels.WARN)
        return
    end
    chatgpt.setup(config)
end

return M
