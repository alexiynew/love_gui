local UIControl = require("gui.ui_control")

--- Creates new button
--- @param core Core
--- @param text string # Text to show
--- @param x integer # The x position
--- @param y integer # The y position
--- @param w integer # The width
--- @param h integer # The hiegh
local function Button(core, text, x, y, w, h)
    x, y = x or 0, y or 0

    local debug = core.debug
    local font = core.font

    w = w or font:getWidth(text)
    h = h or font:getHeight()

    local control = UIControl:new(core, x, y, w, h)

    local draw_function = function()
        control:drawBox()
        control:drawText(text, "center", "middle")
        if debug then
            control:drawDebugBox()
        end
    end

    core:addDrawCommnad(control.id, draw_function)

    local button = {
        hover = core.hover_id == control.id,
        active = core.active_id == control.id,
        clicked = core.clicked_id == control.id,
    }

    return button
end

return Button
