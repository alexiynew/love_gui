local UIControl = require("gui.ui_control")
local TextComponent = require("gui.text_component")

local function Label(core, text, x, y)
    x, y = x or 0, y or 0

    local font = core.font

    local h = font:getHeight()
    local w = font:getWidth(text)

    local control = UIControl:new(core, x, y, w, h)
    local state = core:processControl(control)
    --- @type Style
    local style = core:getStyle(state)
    control.text = TextComponent:new(text, font, style.text_color)

    core:addControl(control)
end

return Label
