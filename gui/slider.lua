local UIControl = require("gui.ui_control")

--- Creates new slider
--- @param core Core
--- @param x integer # The x position
--- @param y integer # The y position
--- @param w integer # The width
--- @param h integer # The height
--- @param min integer # The min value
--- @param max integer # The max value
--- @param value integer # The currnet value
--- @param step integer # The step to change value
local function Slider(core, x, y, w, h, min, max, value, step)
    x, y, w, h = x or 0, y or 0, w or 100, h or 30
    min, max, value = min or 0, max or 100, value or 0
    value = math.max(min, math.min(max, value))
    step = step or 1

    local control = UIControl:new(core, x, y, w, h)

    local slider = {
        hover = core.hover_id == control.id,
        active = core.active_id == control.id,
        clicked = core.clicked_id == control.id,
        value = 0,
    }

    local line = {
        width = w,
        height = 15,
        radius = 7,
        color = {1, 0, 0, 1}
    }

    local handle = {
        width = 20,
        height = h,
        radius = 7,
        color = {0,1,0,1}
    }

    local gr = control.graphics

    local line_top_offset = (h - line.height) / 2
    local handle_top_offset = line_top_offset + (line.height - handle.height) / 2

    local handle_min = x
    local handle_max = x + w - handle.width
    local handle_pos = x

    if slider.active and control.core.mouse_pos then
        local mp = control.core.mouse_pos[1]
        handle_pos = mp - handle.width / 2
        handle_pos = handle_min > handle_pos and handle_min or handle_pos
        handle_pos = handle_max < handle_pos and handle_max or handle_pos

        local t = handle_max ~= handle_min and (handle_pos - handle_min) / (handle_max - handle_min) or 0

        value = min + (max - min) * t
        value = math.floor(value / step) * step
    end

    local t = max ~= min and (value - min) / (max - min) or 0
    handle_pos = x + (handle_max - handle_min) * t

    slider.value = value

    local draw_function = function()
        -- line
        gr.setLineWidth(1)
        gr.setColor(line.color)
        gr.rectangle('fill', x, y + line_top_offset, line.width, line.height, line.radius, line.radius)

        -- handle
        gr.setColor(handle.color)
        gr.rectangle('fill', handle_pos, y + handle_top_offset, handle.width, handle.height, handle.radius, handle.radius)

        control:drawDebugBox()
    end

    core:addDrawCommnad(control.id, draw_function)

    return slider
end

return Slider
