-- npm add --global prettier_d_slim
local prettier_d_slim  = {
  formatCommand = "prettier_d_slim --single-quote true --stdin --stdin-filepath ${INPUT}",
  formatStdin = true
}

-- local prettier_d_slim = {
--     formatCommand = [[
--         prettier_d_slim \
--             --semi false \
--             --single-quote true \
--             --tab-width 2 \
--             --trailing-comma es5 \
--             --stdin --stdin-filepath ${INPUT}
--     ]],
--     formatStdin = true
-- }

return prettier_d_slim
