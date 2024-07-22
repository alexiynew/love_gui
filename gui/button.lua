local UIControl = require("gui.ui_control")
local TextComponent = require("gui.text_component")
local BorderComponent = require("gui.border_component")
local BackgroundComponent = require("gui.background_component")

--- Creates new button
--- @param core Core
--- @param text string # Text to show
--- @param x integer # The x position
--- @param y integer # The y position
--- @param w integer # The width
--- @param h integer # The hiegh
local function Button(core, text, x, y, w, h)
    x, y = x or 0, y or 0

    local font = core.font

    w = w or font:getWidth(text)
    h = h or font:getHeight()

    local control = UIControl:new(core, x, y, w, h)
    local state = core:processControl(control)
    local style = core:getStyle(state)
    control.text = TextComponent:new(text, font, style.fg, "center", "middle")
    control.background = BackgroundComponent:new(style.bg)
    control.border = BorderComponent:new(style.border.color, style.border.width, style.border.radius)

    core:addControl(control)

    return state.clicked
end

return Button
