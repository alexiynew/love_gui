if arg[2] == 'debug' then
    require('lldebugger').start()


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
    GUI = require 'gui'
end

function love.update(dt)
    GUI.update(dt)

    local l = GUI.Label("Hello GUI")
    local l2 = GUI.Label("Hello GUI", 10, 50)

    if (l:isHoveredIn()) then
        print("hoverIn")
    end
    if (l:isHovered()) then
        print("hovered")
    end
    if (l:isHoveredOut()) then
        print("hoverOut")
    end
end

function love.draw()
    GUI.draw(dt)
end
