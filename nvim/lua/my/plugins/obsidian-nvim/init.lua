return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required.
    },
    opts = {
        -- A list of workspace names, paths, and configuration overrides.
        -- If you use the Obsidian app, the 'path' of a workspace should generally be
        -- your vault root (where the `.obsidian` folder is located).
        -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
        -- the workspace to the first workspace in the list whose `path` is a parent of the
        -- current markdown file being edited.
        workspaces = {
            {
                name = "personal",
                path = "~/Notes/personal",
            },
            {
                name = "work",
                path = "~/Notes/work",
            },
        },

        -- Optional, if you keep notes in a specific subdirectory of your vault.
        notes_subdir = "notes",

        -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
        -- levels defined by "vim.log.levels.*".
        log_level = vim.log.levels.INFO,

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "notes/dailies",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = { "daily-notes" },
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil,
        },

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        -- Either 'wiki' or 'markdown'.
        preferred_link_style = "wiki",

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,

        -- Optional, for templates (see below).
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {
                time24 = function() return os.date("%H:%M:%S") end,
                time12 = function()
                    -- Conversion to 12-hour format with AM/PM
                    local hour = tonumber(os.date("%H"))
                    local ampm = hour >= 12 and "PM" or "AM"
                    hour = hour % 12
                    hour = hour == 0 and 12 or hour
                    return string.format("%02d:%s %s", hour, os.date("%M:%S"), ampm)
                end,
                year = function() return os.date("%Y", os.time()) end,
                month = function() return os.date("%B", os.time()) end,
                yesterday = function() return os.date("%Y-%m-%d", os.time() - 86400) end,
                nextday = function() return os.date("%Y-%m-%d", os.time() + 86400) end,
                hdate = function() return os.date("%A, %B %d, %Y") end,
                rfc3339 = function() return os.date("!%Y-%m-%dT%H:%M:%SZ") end,
                week = function() return os.date("%V", os.time()) end,
                isoweek = function() return os.date("%G-W%V", os.time()) end,
                isoprevweek = function()
                    local adjustment = -7 * 24 * 60 * 60 -- One week in seconds
                    return os.date("%G-W%V", os.time() + adjustment)
                end,
                isonextweek = function()
                    local adjustment = 7 * 24 * 60 * 60 -- One week in seconds
                    return os.date("%G-W%V", os.time() + adjustment)
                end,
                day_of_month = function() return os.date("%d", os.time()) end,
                month_numeric = function() return os.date("%m", os.time()) end,
                weekday = function() return os.date("%A", os.time()) end,
            },
        },

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            -- vim.fn.jobstart({ "open", url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            vim.ui.open(url) -- need Neovim 0.10.0+
        end,

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
        -- file it will be ignored but you can customize this behavior here.
        ---@param img string
        follow_img_func = function(img)
            vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        end,

        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = false,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = false,

        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
            name = "fzf-lua",
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            note_mappings = {
                -- Create a new note from your query.
                new = "<C-x>",
                -- Insert a link to the selected note.
                insert_link = "<C-l>",
            },
            tag_mappings = {
                -- Add tag(s) to current note.
                tag_note = "<C-x>",
                -- Insert a tag at the current location.
                insert_tag = "<C-l>",
            },
        },

        -- Optional, determines how certain commands open notes. The valid options are:
        -- 1. "current" (the default) - to always open in the current window
        -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
        -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
        open_notes_in = "current",
    },
}
