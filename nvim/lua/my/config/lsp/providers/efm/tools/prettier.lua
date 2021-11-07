-- You can look for project scope Prettier and Eslint with e.g.
-- vim.fn.glob("node_modules/.bin/prettier") etc. If it is not found revert to
-- global Prettier where needed.
return {
    formatCommand = [[
        ./node_modules/.bin/prettier \
            --semi false \
            --single-quote true \
            --tab-width 2 \
            --trailing-comma es5 \
            --stdin-filepath ${INPUT}
    ]],
    formatStdin = true,
}
