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

    local id = core:getNewId()
    local style = core:processControl(id, x, y, w, h)

    local draw_function = function(graphics)
        local fg, bg = style.fg, style.bg
        local border = style.border

        -- box
        graphics.setColor(bg)
        graphics.rectangle('fill', x, y, w, h, border.radius)

        graphics.setLineWidth(border.width - 0.5)
        graphics.setColor(border.color)
        graphics.rectangle('line', x, y, w, h, border.radius, border.radius)

        -- tex
        graphics.setFont(font)
        graphics.setColor(fg)
        graphics.printf(text, x, y, w, "left")

        if debug then
            graphics.setColor(style.debug_color)
            graphics.rectangle('line', x, y, w, h)
        end
    end

    core:addDrawCommnad(id, draw_function)

    local button = {
        hover = core.hover_id == id
    }

    return button
end

return Button
