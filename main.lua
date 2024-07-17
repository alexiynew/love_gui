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

local Game = {}

function love.load()
    local gui = require('gui')

    Game.cursor = love.mouse.getSystemCursor("hand")
    -- local ui_font = love.graphics.newFont("NotoSans-Regular.ttf", 14)
    local ui_font = love.graphics.newFont("NotoSans-Bold.ttf", 14)

    Game.gui = gui:new()
    Game.gui:setDebugMode(true)
    Game.gui:setFont(ui_font)
end

function love.update(dt)

    for i = 1, 5 do
        local pos = 10 + i * (100 + 10)
        local b = Game.gui:Button("Click me " .. i, pos, 60, 100, 30)

        love.mouse.setCursor()
        if b.clicked then
            Game.gui:Label("Button " .. i .. " clicked", pos, 10)
            print("click " .. i)
        elseif b.active then
            Game.gui:Label("Button " .. i .. " active", pos, 10)
        elseif b.hover then
            Game.gui:Label("Button " .. i .. " hover", pos, 10)
        else
            Game.gui:Label("Button " .. i .. " normal", pos, 10)
        end
    end
end

function love.draw()
    Game.gui:draw()
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end
