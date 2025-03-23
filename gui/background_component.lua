--- @class BackgroundComponent
--- @field color Color
local BackgroundComponent = {}
BackgroundComponent.__index = BackgroundComponent

function BackgroundComponent:draw(graphics, x, y, w, h, radius)
    graphics.setColor(self.color)
    graphics.rectangle('fill', x, y, w, h, radius)
end

--- Creates new background component
--- @param color Color
--- @return BackgroundComponent
function BackgroundComponent.new(color)
    local self = setmetatable({}, BackgroundComponent)

    self.color = color or { 1, 0, 1, 1 }

    return self
end

return BackgroundComponent
