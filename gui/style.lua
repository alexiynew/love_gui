---

--- @alias Color [number,number,number,number] # {r,g,b,a} in range (0-1)

--- @class BorderStyle
--- @field radius number
--- @field width number
--- @field color Color

--- @class ElementStyle
--- @field color Color
--- @field border BorderStyle

--- @class Style
--- @field text_color Color
--- @field button ElementStyle
--- @field slider ElementStyle
--- @field slider_handle ElementStyle

--- @class StyleList
--- @field default Style
--- @field disabled Style|nil
--- @field hover Style|nil
--- @field active Style|nil
--- @field clicked Style|nil
--- @field focus Style|nil
--- @field debug_color Color


local function hexToRGBA(hex)
    hex = hex:gsub("#", "")
    local r = tonumber("0x" .. hex:sub(1, 2)) / 255
    local g = tonumber("0x" .. hex:sub(3, 4)) / 255
    local b = tonumber("0x" .. hex:sub(5, 6)) / 255

    local a = tonumber("0x" .. hex:sub(7, 8)) or 255
    a = a / 255

    return { r, g, b, a }
end

local color = {
    -- green
    green_default = hexToRGBA("#1ABC9C"),
    green_active = hexToRGBA("#16A085"),
    green_hover = hexToRGBA("#48C9B0"),

    -- blue
    petermann = hexToRGBA("#3498DB"),
    belize_hole = hexToRGBA("#2980B9"),

    -- purple
    amethyst = hexToRGBA("#9B59B6"),
    wisteria = hexToRGBA("#8E44AD"),

    -- yellow
    sun_flower = hexToRGBA("#F1C40F"),

    -- orange
    orange = hexToRGBA("#F39C12"),
    carrot = hexToRGBA("#E67E22"),
    pumpkin = hexToRGBA("#D35400"),

    -- red
    alizrin = hexToRGBA("#E74C3C"),
    pomegranate = hexToRGBA("#C0392B"),

    -- dark gray
    wet_asphalt = hexToRGBA("#34495E"),
    midnight = hexToRGBA("#2C3E50"),

    -- light gray
    clouds = hexToRGBA("#ECF0F1"),
    silver = hexToRGBA("#BDC3C7"),

    -- gray
    concrete = hexToRGBA("#95A5A6"),
    asbestos = hexToRGBA("#7F8C8D"),

    shadowed_steel = hexToRGBA("#4B4B4B"),
    baltic_sea = hexToRGBA("#3D3D3D"),

    -- pink
    fuchsia = hexToRGBA("#FF00FF")
}

local debug_color = hexToRGBA("#FF00FF11")

--- @type BorderStyle
local default_border = {
    radius = 8,
    width = 0,
    color = color.midnight,
}

local active_border = {
    radius = 8,
    width = 4,
    color = color.petermann,
}

local slider_handle_border = {
    radius = 30,
    width = 0,
    color = color.petermann,
}

--- @type Style
local default = {
    text_color = color.clouds,
    button = {
        color = color.green_default,
        border = default_border,
    },
    slider = {
        color = color.green_default,
        border = default_border,
    },
    slider_handle = {
        color = color.green_active,
        border = slider_handle_border,
    }
}

--- @type Style
local hover = {
    text_color = color.clouds,
    button = {
        color = color.green_hover,
        border = default_border,
    },
    slider = {
        color = color.green_default,
        border = default_border,
    },
    slider_handle = {
        color = color.green_hover,
        border = slider_handle_border,
    },
}

--- @type Style
local active = {
    text_color = color.clouds,
    button = {
        color = color.green_active,
        border = active_border,
    },
    slider = {
        color = color.green_default,
        border = default_border,
    },
    slider_handle = {
        color = color.green_active,
        border = slider_handle_border,
    },
}

--- @type StyleList
local style = {
    default = default,
    hover = hover,
    active = active,
    clicked = default,
    debug_color = debug_color,
}

return style
