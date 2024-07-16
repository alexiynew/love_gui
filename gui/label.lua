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

    local id = core:getNewId()
    local style = core:processControl(id, x, y, w, h)

    local draw_function = function(graphics)
        local fg = style.fg

        graphics.setFont(font)
        graphics.setColor(fg)
        graphics.printf(text, x, y, w, "left")

        if debug then
            graphics.setColor(style.debug_color)
            graphics.rectangle('line', x, y, w, h)
        end
    end

    core:addDrawCommnad(id, draw_function)
end

return Label
