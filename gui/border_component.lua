--- @class BorderComponent
--- @field color Color
--- @field width integer
--- @field radius integer
local BorderComponent = {}
BorderComponent.__index = BorderComponent

function BorderComponent:draw(graphics, x, y, w, h)
    if (self.width == 0) then
        return
    end

    graphics.setLineWidth(self.width - 0.5)
    graphics.setColor(self.color)
    graphics.rectangle('line', x, y, w, h, self.radius, self.radius)
end

--- Creates new border
--- @param style BorderStyle
--- @return BorderComponent
function BorderComponent.new(style)
    local self = setmetatable({}, BorderComponent)

    self.color = style.color or { 1, 0, 1, 1 }
    self.width = style.width or 0
    self.radius = style.radius or 0

    return self
end

return BorderComponent
