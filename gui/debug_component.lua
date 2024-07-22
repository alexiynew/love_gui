
--- @class DebugComponent
--- @field color Color
local DebugComponent = {}

function DebugComponent:draw(graphics, x, y, w, h)
    graphics.setColor(self.color)
    graphics.rectangle('fill', x, y, w, h)
end

--- Creates new debug component
--- @param color Color
--- @return DebugComponent
function DebugComponent:new(color)
    --- @type DebugComponent
    local t = {
        color = color,
    }

    -- make transparent
    t.color[4] = 0.1

    setmetatable(t, self)
    self.__index = self

    return t
end

return DebugComponent
