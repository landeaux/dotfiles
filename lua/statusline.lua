local gl = require('galaxyline')
local utils = require('utils')
local dracula = require('config/ui/colorscheme').dracula

local gls = gl.section
gl.short_line_list = {' '} -- keeping this table { } as empty will show inactive statuslines

local normal = utils.get_hi_term('Normal', 'guibg')
local file_icon_color = require('galaxyline.provider_fileinfo').get_file_icon_color

local colors = {
  left_LeftRounded = {
    fg = dracula.cyan,
    bg = normal,
  },
  StatusIcon  = {
    fg = dracula.bg_light,
    bg = dracula.cyan,
    sep_fg = dracula.bg_lighter,
    sep_bg = dracula.bg_lighter,
  },
  FileIcon = {
    fg = file_icon_color,
    bg = dracula.bg_lighter,
  },
  FileName = {
    fg = dracula.fg,
    bg = dracula.bg_lighter,
  },
  left_RightRounded = {
    fg = dracula.bg_lighter,
    bg = dracula.bg_light,
    sep_fg = dracula.bg_light,
    sep_bg = dracula.bg_light,
  },
  DiffAdd = {
    fg = dracula.yellow,
    bg = dracula.bg_light,
  },
  DiffModified = {
    fg = dracula.orange,
    bg = dracula.bg_light,
  },
  DiffRemove = {
    fg = dracula.red,
    bg = dracula.bg_light,
  },
  DiagnosticError = {
    fg = dracula.red,
    bg = dracula.bg_light,
  },
  Space = {
    fg = dracula.bg_light,
    bg = dracula.bg_light,
  },
  DiagnosticWarn = {
    fg = dracula.orange,
    bg = dracula.bg_light,
  },
  ShowLspClient = {
    fg = dracula.fg,
    bg = dracula.bg_light,
  },
  GitIcon = {
    fg = dracula.green,
    bg = dracula.bg_light,
    sep_fg = dracula.bg_light,
    sep_bg = dracula.bg_light,
  },
  GitBranch = {
    fg = dracula.green,
    bg = dracula.bg_light,
  },
  right_LeftRounded = {
    fg = dracula.purple,
    bg = dracula.bg_light,
    sep_fg = dracula.normal,
    sep_bg = dracula.bg_light,
  },
  ViMode = {
    fg = dracula.bg_light,
    bg = dracula.purple,
  },
  Percent = {
    fg = dracula.bg_light,
    bg = dracula.fg,
    sep_fg = dracula.purple,
    sep_bg = dracula.purple,
  },
  right_RightRounded = {
    fg = dracula.fg,
    bg = normal,
  }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left = {
    {
        left_LeftRounded = {
            provider = function()
                return ''
            end,
            highlight = {colors.left_LeftRounded.fg, colors.left_LeftRounded.bg}
        }
    },
    {
        StatusIcon = {
            provider = function()
                return '   '
            end,
            highlight = {colors.StatusIcon.fg, colors.StatusIcon.bg},
            separator = ' ',
            separator_highlight = {colors.StatusIcon.sep_fg, colors.StatusIcon.sep_bg}
        }
    },
    {
        FileIcon = {
            provider = 'FileIcon',
            condition = buffer_not_empty,
            highlight = {colors.FileIcon.fg, colors.FileIcon.bg}
        }
    },
    {
        FileName = {
            provider = {'FileName', 'FileSize'},
            condition = buffer_not_empty,
            highlight = {colors.FileName.fg, colors.FileName.bg}
        }
    },
    {
        left_RightRounded = {
            provider = function()
                return ''
            end,
            separator = ' ',
            separator_highlight = {colors.left_RightRounded.sep_fg, colors.left_RightRounded.sep_bg},
            highlight = {colors.left_RightRounded.fg, colors.left_RightRounded.bg}
        }
    },
    {
        ShowLspClient = {
            provider = 'GetLspClient',
            condition = function()
                local tbl = {['startify'] = true, [' '] = true, [''] = true}
                if tbl[vim.bo.filetype] then return false end
                return true
            end,
            icon = ' ',
            highlight = {colors.ShowLspClient.fg, colors.ShowLspClient.bg},
        }
    },
    {
        Space = {
            provider = function()
                return ' '
            end,
            highlight = {colors.Space.fg, colors.Space.bg}
        }
    },
    {
        DiagnosticError = {
            provider = 'DiagnosticError',
            icon = '  ',
            highlight = {colors.DiagnosticError.fg, colors.DiagnosticError.bg}
        }
    },
    {
        Space = {
            provider = function()
                return ' '
            end,
            highlight = {colors.Space.fg, colors.Space.bg}
        }
    },
    {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = '  ',
            highlight = {colors.DiagnosticWarn.fg, colors.DiagnosticWarn.bg}
        }
    },
    {
        Space = {
            provider = function() return '' end,
            highlight = {colors.Space.fg, colors.Space.bg}
        }
    },
}

gls.right = {
    {
        DiffAdd = {
            provider = 'DiffAdd',
            condition = checkwidth,
            icon = '   ',
            highlight = {colors.DiffAdd.fg, colors.DiffAdd.bg}
        }
    },
    {
        DiffModified = {
            provider = 'DiffModified',
            condition = checkwidth,
            icon = ' ',
            highlight = {colors.DiffModified.fg, colors.DiffModified.bg}
        }
    },
    {
        DiffRemove = {
            provider = 'DiffRemove',
            condition = checkwidth,
            icon = ' ',
            highlight = {colors.DiffRemove.fg, colors.DiffRemove.bg}
        }
    },
    {
        GitIcon = {
            provider = function()
                return '   '
            end,
            condition = require('galaxyline.provider_vcs').check_git_workspace,
            separator = ' ',
            separator_highlight = {colors.GitIcon.sep_fg, colors.GitIcon.sep_bg},
            highlight = {colors.GitIcon.fg, colors.GitIcon.bg},
        }
    },
    {
        GitBranch = {
            provider = 'GitBranch',
            condition = require('galaxyline.provider_vcs').check_git_workspace,
            highlight = {colors.GitBranch.fg, colors.GitBranch.bg},
        }
    },
    {
        right_LeftRounded = {
            provider = function()
                return ''
            end,
            separator = ' ',
            separator_highlight = {colors.right_LeftRounded.fg, colors.right_LeftRounded.bg},
            highlight = {colors.right_LeftRounded.fg, colors.right_LeftRounded.bg}
        }
    },
    {
        ViMode = {
            provider = function()
                local alias = {
                    n = 'NORMAL',
                    i = 'INSERT',
                    c = 'COMMAND',
                    V = 'VISUAL',
                    [''] = 'VISUAL',
                    v = 'VISUAL',
                    R = 'REPLACE'
                }
                return alias[vim.fn.mode()]
            end,
            highlight = {colors.ViMode.fg, colors.ViMode.bg}
        }
    },
    {
        Percent = {
            provider = 'LinePercent',
            separator = ' ',
            separator_highlight = {colors.Percent.sep_fg, colors.Percent.sep_bg},
            highlight = {colors.Percent.fg, colors.Percent.bg}
        }
    },
    {
        right_RightRounded = {
            provider = function()
                return ''
            end,
            highlight = {colors.right_RightRounded.fg, colors.right_RightRounded.bg}
        }
    },
}
