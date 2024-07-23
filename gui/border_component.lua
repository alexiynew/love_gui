
--- @class BorderComponent
--- @field color Color
--- @field width integer
--- @field radius integer
local BorderComponent = {}


function BorderComponent:draw(graphics, x, y, w, h)
    if (self.width == 0) then
        return
    end

    graphics.setLineWidth(self.width - 0.5)
    graphics.setColor(self.color)
    graphics.rectangle('line', x, y, w, h, self.radius, self.radius)
end

--- Creates new border
--- @param color Color
--- @param width? integer # default 0
--- @param radius? integer # default 0
--- @return BorderComponent
function BorderComponent:new(color, width, radius)
    width = width or 0
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

--- Creates new border
--- @param style BorderStyle
--- @return BorderComponent
function BorderComponent:fromBorderStyle(style)
    return self:new(style.color, style.width, style.radius)
end

return BorderComponent
