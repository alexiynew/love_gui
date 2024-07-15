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
    Game.gui:setFont(font)
end

function love.update(dt)
    Game.gui:Label("Hello GUI", 10, 10)
end

function love.draw()
    love.graphics.setFont(MainFont)

    Game.gui:draw()
end
