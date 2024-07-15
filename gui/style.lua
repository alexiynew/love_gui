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
--- @field font table|nil

--- @class StyleList
--- @field default Style
--- @field disabled Style|nil
--- @field hover Style|nil
--- @field clicked Style|nil
--- @field focus Style|nil

--- @class StyleDescription
--- @field default StyleList


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
    turquose = hexToRGBA("#1ABC9C"),
    green_sea = hexToRGBA("#16A085"),
    emerald = hexToRGBA("#2ECC71"),
    nephritis = hexToRGBA("#27AE60"),

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
}

local text_color = color.clouds
local bg_color = color.green_sea
local border_color = color.midnight

local hover_bg_color = color.turquose

--- @type Border
local default_border = {
    radius = 4,
    width = 1,
    color = border_color,
}

--- @type Style
local default = {
    fg = text_color,
    bg = bg_color,
    border = default_border,
    font = nil,
}

--- @type Style
local hover = {
    fg = text_color,
    bg = hover_bg_color,
    border = default_border,
    font = nil,
}

--- @type StyleList
local default_stile = {
    default = default,
    hover = hover,
}

--- @type StyleDescription
local styles = {
    default = default_stile,
}

return styles
