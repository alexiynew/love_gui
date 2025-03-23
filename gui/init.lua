local PATH_BASE = (...) .. '.'

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
GUI.__index = GUI

--- Render all UI
function GUI:draw()
    self.core:draw()
end

--- Creates new label
--- @param text string # Text to show
--- @param x? number # The x position
--- @param y? number # The y position
function GUI:Label(text, x, y)
    return Label(self.core, text, x, y)
end

--- Creates new button
--- @param text string # Text to show
--- @param x number # The x position
--- @param y number # The y position
--- @param w? number # The width
--- @param h? number # The heigh
--- @return boolean # true if button is clicked
function GUI:Button(text, x, y, w, h)
    return Button(self.core, text, x, y, w, h)
end

--- Creates new slider
--- @param x number # The x position
--- @param y number # The y position
--- @param w? number # The width, default 100
--- @param h? number # The height, default 30
--- @param min? number # The min value, default 0
--- @param max? number # The max value, default 100
--- @param value? number # The current value, default 0
--- @param step? number # The step to change value, default 1
--- @return boolean # true if slider changed value
--- @return number # new slider value
function GUI:Slider(x, y, w, h, min, max, value, step)
    return Slider(self.core, x, y, w, h, min, max, value, step)
end

--- Enable debug mode rendering
--- @param enabled boolean
function GUI:setDebugMode(enabled)
    self.core.debug = enabled or false
end

--- Set new font for UI
--- @param font table
function GUI:setFont(font)
    self.core.font = font or self.core.font
end

--- Creates new GUI module instance
--- @return GUI
function GUI.new()
    local self = setmetatable({}, GUI)

    self.core = Core.new(Style)
    self.core.debug = false

    return self
end

return GUI
