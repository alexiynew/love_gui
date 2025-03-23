--- @class DebugComponent
--- @field color Color
local DebugComponent = {}
DebugComponent.__index = DebugComponent

function DebugComponent:draw(graphics, x, y, w, h)
    graphics.setColor(self.color)
    graphics.rectangle('fill', x, y, w, h)
end

--- Creates new debug component
--- @param color Color
--- @return DebugComponent
function DebugComponent.new(color)
    local self = setmetatable({}, DebugComponent)

    self.color = color

    -- make transparent
    self.color[4] = 0.1

    return self
end

return DebugComponent
