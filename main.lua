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
    GUI = require('gui')
end

function love.update(dt)
    local l = GUI.Label("Hello GUI", 10, 10)

    if (l:isHovered()) then
        print("hovered: ")
    end
end

function love.draw()
    GUI.draw()
end
