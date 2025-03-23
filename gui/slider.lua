local PATH_BASE = (...):match('^(.*)%..*$') .. '.'

local State = require(PATH_BASE .. 'state')
local UIControl = require(PATH_BASE .. 'ui_control')
local TextComponent = require(PATH_BASE .. 'text_component')
local BorderComponent = require(PATH_BASE .. 'border_component')
local BackgroundComponent = require(PATH_BASE .. 'background_component')

local function clamp(min, max, value)
    return math.max(min, math.min(max, value))
end

local function map(min, max, value, new_min, new_max)
    local t = min ~= max and ((value - min) / (max - min)) or 0
    return new_min + (new_max - new_min) * t
end

---@source core
---@param core Core
local function Slider(core, x, y, w, h, min, max, value, step)
    x, y, w, h = x or 0, y or 0, w or 100, h or 30
    min, max, value = min or 0, max or 100, value or 0
    value = clamp(min, max, value)
    step = step or 1

    local handle_width = 20
    local handle_height = 20
    local handle_min = 0
    local handle_max = w - handle_width
    local handle_x = map(min, max, value, handle_min, handle_max)
    local handle_y = (h - handle_height) / 2

    local control = UIControl.new(core, x, y, w, h)
    local line = UIControl.new(core, 0, 10, w, h - 20)
    local handle = UIControl.new(core, handle_x, handle_y, handle_width, handle_height)
    local text = UIControl.new(core, 0, 0, w, h)

    line.handle_mouse_input = true
    handle.handle_mouse_input = true

    control:addChild(line)
    control:addChild(handle)
    control:addChild(text)

    core:processControl(control)
    local handle_state = core:processControl(handle)
    local line_state = core:processControl(line)

    local hover = handle_state.hover or line_state.hover
    local active = handle_state.active or line_state.active
    local clicked = false

    --- @source state
    --- @type State
    local state = State.new(hover, active, clicked)

    local new_value = value
    if state.active and core.mouse_pos then
        local handle_offset, _ = handle.parent:absolutePosition()
        local mp = core.mouse_pos[1]
        mp = mp - handle_offset - handle_width / 2
        handle_x = clamp(handle_min, handle_max, mp)

        new_value = map(handle_min, handle_max, handle_x, min, max)
        new_value = math.floor(new_value / step) * step

        handle_x = map(min, max, new_value, handle_min, handle_max)
        handle.x = handle_x
    end

    --- @type Style
    local style = core:getStyle(state)

    text.text = TextComponent.new(tostring(new_value), core.font, style.text_color, "center", "middle")

    line.background = BackgroundComponent.new(style.slider.color)
    line.border = BorderComponent.new(style.slider.border)

    handle.background = BackgroundComponent.new(style.slider_handle.color)
    handle.border = BorderComponent.new(style.slider_handle.border)

    core:addControl(control)

    local changed = value ~= new_value
    return changed, new_value
end

return Slider
