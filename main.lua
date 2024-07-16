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
local MainFont = {}

function love.load()
    local font = love.graphics.newFont("NotoSans-Regular.ttf", 34)
    MainFont = love.graphics.newFont("NotoSans-Regular.ttf", 14)
    local gui = require('gui')

    Game.gui = gui:new()
    Game.gui:setDebugMode(true)
    --- Game.gui:setFont()
end

function love.update(dt)
    local b = Game.gui:Button("Click me", 10, 60, 100, 30)
    if b.hover then
        Game.gui:Label("Button hover", 10, 10)
    else
        Game.gui:Label("Button normal", 10, 10)
    end
end

function love.draw()
    love.graphics.setFont(MainFont)
    Game.gui:draw()
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end
