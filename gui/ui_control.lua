---

--- @class UIControl
--- @field core UICore
--- @field id ControlId
--- @field x number # The x position
--- @field y number # The Y position
--- @field w number # Width of the control
--- @field h number # Height of the control
local UIControl = {}


--- Cheks if control has been hevered
--- @return boolean # True if mouse hovers the control in this frame
function UIControl:isHoveredIn()
    return self.core:isHoveredIn(self.id)
end

--- Cheks if mouce is over control
--- @return boolean # True if mouse hovers the control
function UIControl:isHovered()
    return self.core:isHovered(self.id)
end

--- Cheks if mouse leave control
--- @return boolean # True if mouse leave the control in this frame
function UIControl:isHoveredOut()
    return self.core:isHoveredOut(self.id)
end

--- Creates new UI control
--- @param core any
--- @return table
function UIControl:new(core, x, y, w, h)
    local t = {}

    setmetatable(t, self)
    self.__index = self

    t.core = core
    t.id = core:getNewId()
    t.x, t.y, t.w, t.h = x, y, w, h

    core:addHitBox(t.id, x, y, w, h)

    return t
end

return UIControl
