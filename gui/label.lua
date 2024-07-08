local function Label(core, text, x, y)
    local base = package.loaded['gui.ui_control']
    if not base then
        error('ui_control packeage not loaded')
    end

    local bg = { 0.2, 0.2, 0.4, 1 }
    local fg = { 0.9, 0.9, 0.9, 1 }
    local radius = 4
    local x, y = x or 10, y or 10
    local w, h = 200, 30

    core:addDrawCommand(
        function(graphics)
            graphics.setColor(bg)
            graphics.rectangle('fill', x, y, w, h, radius)

            graphics.setColor(fg)
            graphics.printf(text, x + 2, y, w - 4, "left")
        end
    )

    return base:new(core, x, y, w, h)
end

return Label
