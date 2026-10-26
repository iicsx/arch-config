require("avante").setup({
  provider = "copilot",
  -- providers = {
  --   ollama = {
  --     model = "qwen3:8b",
  --     extra_request_body = {
  --       options = {
  --         temperature = 0.75,   -- Randomness (0.0-1.0)
  --         num_ctx = 20480,      -- Context window size
  --         top_p = 0.9,          -- Nucleus sampling
  --         top_k = 40,           -- Top-k sampling
  --         repeat_penalty = 1.1, -- Repetition penalty
  --         keep_alive = "5m",    -- Model keep-alive duration
  --       },
  --     },
  --     is_env_set = require("avante.providers.ollama").check_endpoint_alive,
  --   }
  -- }
})
