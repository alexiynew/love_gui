local UIControl = package.loaded['gui.ui_control']

--- @class Label: UIControl

--- Creates new label
--- @param core Core
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
--- @return Label
local function createLabel(core, text, x, y)
    x, y = x or 0, y or 0
    local w, h = 200, 30

    --- @type Label
    local label = UIControl:new(core, x, y, w, h)

    core:addDrawCommand(label, core.style.label, 
        function(graphics, style)
            local fg, bg, border = style.fg, style.bg, style.border

            graphics.setColor(bg)
            graphics.rectangle('fill', x, y, w, h, border.radius)

            graphics.setColor(fg)
            graphics.printf(text, x + 2, y, w - 4, "left")
        end
    )

    return label
end

return createLabel
