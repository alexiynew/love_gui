local PATH_BASE = (...) .. "."

-- Load core functionality
local Core = require(PATH_BASE .. 'core')
local Style = require(PATH_BASE .. 'style')

local core = Core:new(Style)

-- Load controls
require(PATH_BASE .. 'ui_control')


local createLabel = require(PATH_BASE .. 'label')

--- Creates new label
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
--- @return Label
local function Label(text, x, y)
    return createLabel(core, text, x, y)
end

local gui = {
    draw = function() core:draw() end,

    -- UI elements
    Label = Label
}

return gui
