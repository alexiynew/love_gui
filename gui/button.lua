local path = select(1, ...):match(".+%.") or ""

local UIControl = require(path .. 'core.ui_control')
local TextComponent = require(path .. 'core.text_component')
local BorderComponent = require(path .. 'core.border_component')
local BackgroundComponent = require(path .. 'core.background_component')

local function Button(core, text, x, y, w, h)
    x, y = x or 0, y or 0

    local font = core.font

    w = w or font:getWidth(text)
    h = h or font:getHeight()

    local control = UIControl.new(core, x, y, w, h)
    control.handle_mouse_input = true

    local state = core:processControl(control)
    --- @type Style
    local style = core:getStyle(state)
    control.text = TextComponent.new(text, font, style.text_color, "center", "middle")
    control.background = BackgroundComponent.new(style.button.color)
    control.border = BorderComponent.new(style.button.border)

    core:addControl(control)

    return state.clicked
end

return Button
