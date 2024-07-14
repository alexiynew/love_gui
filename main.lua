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

function love.load()
    local gui = require('gui')

    GUI = gui:new()
end

function love.update(dt)
    GUI:Label("Hello GUI", 10, 10)
end

function love.draw()
    GUI:draw()
end
