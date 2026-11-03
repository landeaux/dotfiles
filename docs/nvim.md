# Neovim config

- Plugins are managed with `vim.pack` (`lua/my/pack.lua`, lockfile `nvim-pack-lock.json`). Per-plugin config lives in
  `lua/my/plugins/`.
- Run nvim non-interactively with `nvim --headless` (benchmarks, health checks, Lua one-offs). Without it nvim waits
  for a terminal and hangs.
