local PATH_BASE = (...) .. "."

-- Load core functionality
local Core = require(PATH_BASE .. 'core')
local Style = require(PATH_BASE .. 'style')

-- Load controls
local Label = require(PATH_BASE .. 'label')
local Button = require(PATH_BASE .. 'button')
local Slider = require(PATH_BASE .. 'slider')

--- @class GUI
--- @field core Core
local GUI = {}

function GUI:draw()
    self.core:draw()
end

--- Creates new label
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
function GUI:Label(text, x, y)
    return Label(self.core, text, x, y)
end

--- Creates new button
--- @param text string # Text to show
--- @param x integer # The x position
--- @param y integer # The y position
--- @param w integer # The width
--- @param h integer # The height
function GUI:Button(text, x, y, w, h)
    return Button(self.core, text, x, y, w, h)
end

--- Creates new slider
--- @param x integer # The x position
--- @param y integer # The y position
--- @param w integer # The width
--- @param h integer # The height
--- @param min integer # The min value
--- @param max integer # The max value
--- @param value integer # The currnet value
--- @param step integer # The step to change value
function GUI:Slider(x, y, w, h, min, max, value, step)
    return Slider(self.core, x, y, w, h, min, max, value, step)
end

function GUI:setDebugMode(enabled)
    self.core.debug = enabled or false
end

function GUI:setFont(font)
    self.core.font = font or self.core.font
end

function GUI:new()
    local t = {}

    t.core = Core:new(Style)
    t.core.debug = false

    setmetatable(t, self)
    self.__index = self

    return t
end

return GUI
