
--- @class BackgroundComponent
--- @field color Color
local BackgroundComponent = {}

function BackgroundComponent:draw(graphics, x, y, w, h, redius)
    graphics.setColor(self.color)
    graphics.rectangle('fill', x, y, w, h, redius)
end

--- Creates new debug component
--- @param color Color
--- @return BackgroundComponent
function BackgroundComponent:new(color)
    --- @type BackgroundComponent
    local t = {
        color = color,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return BackgroundComponent
