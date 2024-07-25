if arg[2] == 'debug' then
    local lldebugger = require('lldebugger')
    lldebugger.start()

    local love_errorhandler = love.errorhandler

    function love.errorhandler(msg)
        if lldebugger then
            error(msg, 2)
        else
            return love_errorhandler(msg)
        end
    end
end

--- @class Game
--- @field gui GUI|nil
local Game = {
    gui = nil
}

function love.load()
    local gui = require('gui')

    Game.cursor = love.mouse.getSystemCursor("hand")
    -- local ui_font = love.graphics.newFont("NotoSans-Regular.ttf", 14)
    local ui_font = love.graphics.newFont("font/NotoSans-Bold.ttf", 14)

    Game.gui = gui:new()
    Game.gui:setDebugMode(false)
    Game.gui:setFont(ui_font)
end


local slider_value = 0
local clicked = 0

function love.update(dt)
    local s_active, s_value = Game.gui:Slider(10, 120, 200, 30, -2, 20, slider_value, 0.01)
    if s_active then
        slider_value = s_value
    end
    Game.gui:Label("Slider " .. slider_value .. "  " .. tostring(s_active) .. "  " .. s_value, 10, 180)

    for i = 1, 2 do
        local pos = 10 + i * (100 + 10)
        if (Game.gui:Button("Click me " .. i, pos, 60, 100, 30)) then
            clicked = i
        end
    end
    Game.gui:Label("Button clicked " .. clicked, 10, 10)

end

function love.draw()
    Game.gui:draw()
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end
