local UIControl = require("gui.ui_control")
local BorderComponent = require("gui.border_component")
local BackgroundComponent = require("gui.background_component")

local function clamp(min, max, value)
    return math.max(min, math.min(max, value))
end

local function map(min, max, value, new_min, new_max)
    local t = min ~= max and ((value - min) / (max - min)) or 0
    return new_min + (new_max - new_min) * t
end

local function Slider(core, x, y, w, h, min, max, value, step)
    x, y, w, h = x or 0, y or 0, w or 100, h or 30
    min, max, value = min or 0, max or 100, value or 0
    value = clamp(min, max, value)
    step = step or 1

    local handle_width = 10
    local handle_min = 0
    local handle_max = w - handle_width
    local handle_pos = map(min, max, value, handle_min, handle_max)

    local control = UIControl:new(core, x, y, w, h)
    local line = UIControl:new(core, 0, 10, w, h - 20)
    local handle = UIControl:new(core, handle_pos, 0, handle_width, h)

    line.handle_mouse_input = true
    handle.handle_mouse_input = true

    control:addChild(line)
    control:addChild(handle)

    local handle_state = core:processControl(handle)
    local line_state = core:processControl(line)
    core:processControl(control)

    --- @type State
    local state = {
        hover = handle_state.hover or line_state.hover,
        active = handle_state.active or line_state.active,
        clicked = false,
    }

    local new_value = value
    if state.active and core.mouse_pos then
        local handle_offset, _ = handle.parent:absolutePosition()
        local mp = core.mouse_pos[1]
        mp = mp - handle_offset - handle_width / 2
        handle_pos = clamp(handle_min, handle_max, mp)

        new_value = map(handle_min, handle_max, handle_pos, min, max)
        new_value = math.floor(new_value / step) * step

        handle_pos = map(min, max, new_value, handle_min, handle_max)
        handle.x = handle_pos
    end

    local style = core:getStyle(state)

    line.background = BackgroundComponent:new(style.bg)
    line.border = BorderComponent:new(style.border.color, style.border.width, style.border.radius)

    handle.background = BackgroundComponent:new(style.bg)
    handle.border = BorderComponent:new(style.border.color, style.border.width, style.border.radius)

    core:addControl(control)

    local changed = value ~= new_value
    return changed, new_value
end

return Slider
