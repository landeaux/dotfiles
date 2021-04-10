local gl = require('galaxyline')
local utils = require('utils')
local dracula = require('config/colorscheme').dracula

local gls = gl.section
gl.short_line_list = {' '} -- keeping this table { } as empty will show inactive statuslines

local normal = utils.get_hi_term('Normal', 'guibg')
local file_icon_color = require('galaxyline.provider_fileinfo').get_file_icon_color

local colors = {
  leftRounded = {
    fg = dracula.cyan,
    bg = normal,
  },
  statusIcon  = {
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
  teech = {
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
  LeftEnd = {
    fg = dracula.bg_light,
    bg = dracula.bg_light,
    sep_fg = dracula.bg_light,
    sep_bg = dracula.bg_light,
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
    fg = dracula.blue,
    bg = dracula.bg_light,
  },
  GitIcon = {
    fg = dracula.green,
    bg = dracula.bg_light,
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
  rightRounded = {
    fg = dracula.fg,
    bg = normal,
  }
}

-- local colors = {
--     bg = '#282c34',
--     line_bg = '#282c34',
--     fg = '#D8DEE9',
--     fg_green = '#65a380',
--     yellow = '#A3BE8C',
--     cyan = '#22262C',
--     darkblue = '#61afef',
--     green = '#BBE67E',
--     orange = '#FF8800',
--     purple = '#252930',
--     magenta = '#c678dd',
--     blue = '#22262C',
--     red = '#DF8890',
--     lightbg = '#3C4048',
--     nord = '#81A1C1',
--     greenYel = '#EBCB8B'
-- }

gls.left[1] = {
    leftRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.leftRounded.fg, colors.leftRounded.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return '   '
        end,
        highlight = {colors.statusIcon.fg, colors.statusIcon.bg},
        separator = ' ',
        separator_highlight = {colors.statusIcon.sep_fg, colors.statusIcon.sep_bg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {colors.FileIcon.fg, colors.FileIcon.bg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {'FileName', 'FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.FileName.fg, colors.FileName.bg}
    }
}

gls.left[5] = {
    teech = {
        provider = function()
            return ''
        end,
        separator = ' ',
        separator_highlight = {colors.teech.sep_fg, colors.teech.sep_bg},
        highlight = {colors.teech.fg, colors.teech.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[6] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '   ',
        highlight = {colors.DiffAdd.fg, colors.DiffAdd.bg}
    }
}

gls.left[7] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.DiffModified.fg, colors.DiffModified.bg}
    }
}

gls.left[8] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.DiffRemove.fg, colors.DiffRemove.bg}
    }
}

gls.left[9] = {
    LeftEnd = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = {colors.LeftEnd.sep_fg, colors.LeftEnd.sep_bg},
        highlight = {colors.LeftEnd.fg, colors.LeftEnd.bg}
    }
}

gls.left[10] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.DiagnosticError.fg, colors.DiagnosticError.bg}
    }
}

gls.left[11] = {
    Space = {
        provider = function()
            return ' '
        end,
        highlight = {colors.Space.fg, colors.Space.bg}
    }
}

gls.left[12] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.DiagnosticWarn.fg, colors.DiagnosticWarn.bg}
    }
}

gls.left[14] = {
    Space = {
        provider = function() return '' end,
        highlight = {colors.Space.fg, colors.Space.bg}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return '   '
        end,
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.GitIcon.fg, colors.GitIcon.bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.GitBranch.fg, colors.GitBranch.bg},
    }
}

gls.right[3] = {
    right_LeftRounded = {
        provider = function()
            return ''
        end,
        separator = ' ',
        separator_highlight = {colors.right_LeftRounded.fg, colors.right_LeftRounded.bg},
        highlight = {colors.right_LeftRounded.fg, colors.right_LeftRounded.bg}
    }
}

gls.right[4] = {
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
}

gls.right[5] = {
    Percent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.Percent.sep_fg, colors.Percent.sep_bg},
        highlight = {colors.Percent.fg, colors.Percent.bg}
    }
}

gls.right[6] = {
    rightRounded = {
        provider = function()
            return ''
        end,
        highlight = {colors.rightRounded.fg, colors.rightRounded.bg}
    }
}

