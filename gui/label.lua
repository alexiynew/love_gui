---

local function Label(core, text, x, y)
    local x, y = x or 10, y or 10
    local w, h = 200, 30

    local ui_control = core:newControl(x, y, w, h)

    core:addDrawCommand(
        function(graphics)
            local s = ui_control.style
            local fg = s.foreground_color
            local bg = s.background_color
            local radius = s.corner_radius

            graphics.setColor(bg)
            graphics.rectangle('fill', x, y, w, h, radius)

            graphics.setColor(fg)
            graphics.printf(text, x + 2, y, w - 4, "left")
        end
    )

    return ui_control
end

return Label
