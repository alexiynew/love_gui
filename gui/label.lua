local UIControl = require("gui.ui_control")

--- Creates new label
--- @param core Core
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
local function Label(core, text, x, y)
    x, y = x or 0, y or 0

    local debug = core.debug
    local font = core.font

    local h = font:getHeight()
    local w = font:getWidth(text)

    local control = UIControl:new(core, x, y, w, h)

    local draw_function = function()
        control:drawText(text)
        if debug then
            control:drawDebugBox()
        end
    end

    core:addDrawCommnad(control.id, draw_function)
end

return Label
