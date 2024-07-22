
--- @class BorderComponent
--- @field color Color
--- @field width integer
--- @field radius integer
local BorderComponent = {}


function BorderComponent:draw(graphics, x, y, w, h)
    graphics.setLineWidth(self.width - 0.5)
    graphics.setColor(self.color)
    graphics.rectangle('line', x, y, w, h, self.radius, self.radius)
end

--- Creates new text
--- @param color Color
--- @param width? integer # default 1
--- @param radius? integer # default 0
--- @return BorderComponent
function BorderComponent:new(color, width, radius)
    width = width or 1
    radius = radius or 0

    --- @type BorderComponent
    local t = {
        color = color,
        width = width,
        radius = radius,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return BorderComponent
