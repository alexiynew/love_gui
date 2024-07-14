local PATH_BASE = (...) .. "."

-- Load core functionality
local Core = require(PATH_BASE .. 'core')
local Style = require(PATH_BASE .. 'style')

-- Load controls
require(PATH_BASE .. 'ui_control')
local createLabel = require(PATH_BASE .. 'label')

local GUI = {}

function GUI:draw()
    self.core:draw()
end

--- Creates new label
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
--- @return Label
function GUI:Label(text, x, y)
    return createLabel(self.core, text, x, y)
end

function GUI:setDebugMode(enabled)
    self.core.debug = enabled
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
