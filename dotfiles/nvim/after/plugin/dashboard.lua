local db = require('dashboard')

local function concat_tables(...)
  local insert = {}
  local tables = { ... }

  for _, t in ipairs(tables) do
    for _, v in ipairs(t) do
      table.insert(insert, v)
    end
  end

  return insert
end

local function split(str, sep)
  local fields = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(c) fields[#fields + 1] = c end)

  return fields
end

local function is_file(str)
  if not str or #str == 0 then
    return false
  end

  local elements = split(str, '.')

  return #elements > 1
end

local function get_file(path)
  local elements = split(path, '/')

  return elements[#elements]
end

-- local function nl_string_to_table(s)
--   local lines = {}
--
--   for line in s:gmatch("[^\r\n]+") do
--     table.insert(lines, line)
--   end
--
--   return lines
-- end
--
-- local custom_header = nl_string_to_table([[
--
-- ]])

local ascii = {
  ["artworks"] = {
    ["planet"] = {
      [[                                                    ]],
      [[                                              ___   ]],
      [[                                           ,o88888  ]],
      [[                                        ,o8888888'  ]],
      [[                  ,:o:o:oooo.        ,8O88Pd8888"   ]],
      [[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"     ]],
      [[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"       ]],
      [[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"         ]],
      [[          , ..:.::o:ooOoOO8O888O8O,COCOO"           ]],
      [[         , . ..:.::o:ooOoOOOO8OOOOCOCO"             ]],
      [[          . ..:.::o:ooOoOoOO8O8OCCCC"o              ]],
      [[             . ..:.::o:ooooOoCoCCC"o:o              ]],
      [[             . ..:.::o:o:,cooooCo"oo:o:             ]],
      [[          `   . . ..:.:cocoooo"'o:o:::'             ]],
      [[          .`   . ..::ccccoc"'o:o:o:::'              ]],
      [[         :.:.    ,c:cccc"':.:.:.:.:.'               ]],
      [[       ..:.:"'`::::c:"'..:.:.:.:.:.'                ]],
      [[     ...:.'.:.::::"'    . . . . .'                  ]],
      [[    .. . ....:."' `   .  . . ''                     ]],
      [[  . . . ...."'                                      ]],
      [[  .. . ."'                                          ]],
      [[ .              _  _       __   ___                 ]],
      [[               | \| |___ __\ \ / (_)_ __            ]],
      [[               | .` / -_) _ \ V /| | '  \           ]],
      [[               |_|\_\___\___/\_/ |_|_|_|_|          ]],
      [[                                                    ]],
    },
    ["space"] = {
      [[  ]],
      [[  ]],
      [[  ]],
      [[  ]],
      [[   '                      ,                             O      *        '       .       ]],
      [[         .      .                     '                            .                    ]],
      [[         .             o         *              ,                  ;       *            ]],
      [[         :                              *                      - --+- -             '   ]],
      [[     .   !                         *        .       *              !          .         ]],
      [[         |        .                                            .                        ]],
      [[         |_         +                         |               *             ,       *   ]],
      [[      ,  | `.                 *             - o -                                       ]],
      [[--- --+-<#>-+- ---  --  -              *      |                   .-.,="``"=.           ]],
      [[      `._|_,'                 _  _       __   ___                 '=/_       \     ,    ]],
      [[         T                   | \| |___ __\ \ / (_)_ __      *      |  '=._    |         ]],
      [[         |                   | .` / -_) _ \ V /| | '  \             \     `=./`,        ]],
      [[         !                   |_|\_\___\___/\_/ |_|_|_|_|     *     . '=.__.=' `='    .  ]],
      [[  ,      :         . :                    *                                             ]],
      [[         .       *            .              :     o        .            '              ]],
      [[                          ,        *           .        ,          o        *           ]],
      [[                                                                                        ]],
    },
    ["starburst"] = {
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⠤⢤⣀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠴⠒⢋⣉⣀⣠⣄⣀⣈⡇ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣯⠴⠚⠉⠉⠀⠀⠀⠀⣤⠏⣿ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⡇⠁⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⡿⠿⢛⠁⠁⣸⠀⠀⠀⠀⠀⣤⣾⠵⠚⠁ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢦⡀⠀⣠⠀⡇⢧⠀⠀⢀⣠⡾⡇⠀⠀⠀⠀⠀⣠⣴⠿⠋⠁⠀⠀⠀⠀⠘⣿⠀⣀⡠⠞⠛⠁⠂⠁⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⣻⡦⣞⡿⣷⠸⣄⣡⢾⡿⠁⠀⠀⠀⣀⣴⠟⠋⠁⠀⠀⠀⠀⠐⠠⡤⣾⣙⣶⡶⠃⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣂⡷⠰⣔⣾⣖⣾⡷⢿⣐⣀⣀⣤⢾⣋⠁⠀⠀⠀⣀⢀⣀⣀⣀⣀⠀⢀⢿⠑⠃⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠠⡦⠴⠴⠤⠦⠤⠤⠤⠤⠤⠴⠶⢾⣽⣙⠒⢺⣿⣿⣿⣿⢾⠶⣧⡼⢏⠑⠚⠋⠉⠉⡉⡉⠉⠉⠹⠈⠁⠉⠀⠨⢾⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠂⠐⠀⠀⠀⠈⣇⡿⢯⢻⣟⣇⣷⣞⡛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣆⠀⠀⠀⠀⢠⡷⡛⣛⣼⣿⠟⠙⣧⠅⡄⠀⠀⠀⠀⠀⠀⠰⡆⠀⠀⠀⠀⢠⣾⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⢶⠏⠉⠀⠀⠀⠀⠀⠿⢠⣴⡟⡗⡾⡒⠖⠉⠏⠁⠀⠀⠀⠀⣀⢀⣠⣧⣀⣀⠀⠀⠀⠚⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⣠⢴⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⣠⣷⢿⠋⠁⣿⡏⠅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣿⢭⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⢀⡴⢏⡵⠛⠀⠀⠀⠀⠀⠀⠀⣀⣴⠞⠛⠀⠀⠀⠀⢿⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⢿⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⣀⣼⠛⣲⡏⠁⠀⠀⠀⠀⠀⢀⣠⡾⠋⠉⠀⠀⠀⠀⠀⠀⢾⡅⠀  ⠀ _  _       __   ___       ⠀⠀]],
      [[ ⠀⠀⡴⠟⠀⢰⡯⠄⠀⠀⠀⠀⣠⢴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⠆⠀  ⠀| \| |___ __\ \ / (_)_ __  ⠀⠀]],
      [[ ⠀⡾⠁⠁⠀⠘⠧⠤⢤⣤⠶⠏⠙⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢾⡃⠀  ⠀| .` / -_) _ \ V /| | '  \ ⠀⠀]],
      [[ ⠘⣇⠂⢀⣀⣀⠤⠞⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠇⠀  ⠀|_|\_\___\___/\_/ |_|_|_|_|⠀⠀]],
      [[ ⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠾⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    },
  },
  ["banners"] = {
    ["current"] = {
      [[    _  _       __   ___         ]],
      [[   | \| |___ __\ \ / (_)_ __    ]],
      [[   | .` / -_) _ \ V /| | '  \   ]],
      [[   |_|\_\___\___/\_/ |_|_|_|_|  ]],
    },
    ["old"] = {
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
    }
  },
}

local function get_random_artwork()
  local artworks = ascii.artworks
  local keys = {}

  for k in pairs(artworks) do
    table.insert(keys, k)
  end

  local random_key = keys[math.random(#keys)]
  return artworks[random_key]
end

local function get_random_banner()
  local banners = ascii.banners
  local keys = {}

  for k in pairs(banners) do
    table.insert(keys, k)
  end

  local random_key = keys[math.random(#keys)]
  return banners[random_key]
end

local default_shortcuts = {
  {
    icon = ' ',
    icon_hl = '@variable',
    desc = 'Files',
    group = 'Label',
    action = 'Telescope find_files',
    key = 'f',
  },
  {
    desc = ' Apps',
    group = 'DiagnosticHint',
    -- action = 'Telescope find_files cwd=~/source/repos',
    action = 'Oil ~/source/repos',
    key = 'a',
  },
  {
    desc = ' dotfiles',
    group = 'Number',
    action = 'Oil ~/source/setup/.dotfiles',
    key = 'd',
  },
  {
    desc = '󰐥 quit',
    group = 'Label',
    action = 'quit',
    key = 'q',
  }
}

if not WITH_CATS then
  table.insert(default_shortcuts, { desc = '󰊳 Update', group = '@property', action = 'Lazy sync', key = 'u' })
end

db.setup({
  theme = 'hyper',
  config = {
    header = concat_tables(
    -- get_random_artwork(),
      ascii.artworks["space"]
    ),
    plugins = { enable = true },
    footer = {}, -- removes the footer
    shortcut = default_shortcuts,
  },
})

local current_file = get_file(vim.fn.expand("%:p"))
if not is_file(current_file) then
  -- vim.cmd("Dashboard")
end

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#add8e6' })
vim.keymap.set("n", "<leader>d", ":Dashboard<CR>", { noremap = true })
vim.keymap.set("n", "<leader>d", ":Dashboard<CR>", { noremap = true })
