---

--- @alias Color [number,number,number,number] # {r,g,b,a} in range (0-1)

--- @class Border
--- @field radius number
--- @field width number
--- @field color Color

--- @class Style
--- @field fg Color # foreground color
--- @field bg Color # background color
--- @field border Border

--- @class StyleList
--- @field default Style
--- @field disabled Style|nil
--- @field hover Style|nil
--- @field clicked Style|nil
--- @field focus Style|nil

--- @class StyleDescription
--- @field default StyleList
--- @field label StyleList

--- @type StyleList
local default_stile = {
    default = {
        fg = {1, 0.0, 0.0, 1},
        bg = {0, 0, 0.1, 1},
        border = {
            radius = 4,
            width = 1,
            color = {0.3, 0.3, 0.3, 1}
        }
    }
}

--- @type StyleList
local label_style = {
    default = {
        fg = {0.8, 0.8, 0.8, 1},
        bg = {0.1, 0.1, 0.3, 1},
        border = {
            radius = 4,
            width = 1,
            color = {0.3, 0.3, 0.3, 1}
        }
    },
    hover = {
        fg = {0.5, 0.5, 0.8, 1},
        bg = {0.1, 0.1, 0.3, 1},
        border = {
            radius = 4,
            width = 1,
            color = {0.3, 0.3, 0.3, 1}
        }
    }
}


--- @type StyleDescription
local styles = {
    default = default_stile,
    label = label_style,
}

return styles
