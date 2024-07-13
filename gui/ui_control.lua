
--- @alias HitBox [number,number,number,number] # {x, y, w, h}

--- @class ControlState
--- @field disabled boolean # Is control in an disabled state. e.g. can't process events.
--- @field hover boolean # Is control hovered? User holding the mouse pointer over the control.
--- @field clicked boolean # Is control being activated by the user. For example, when the item is clicked on.
--- @field focus boolean # Does Control has keyboard focus.


--- @class UIControl
--- @field hit_box HitBox
--- @field state ControlState
local UIControl = {}


--- Cheks if mouse is over control
--- @return boolean # True if mouse hovers the control
function UIControl:isHovered()
    return self.state.hover 
end


--- Creates new UIControl
--- @param core Core
--- @param x number # The x position of control
--- @param y number # The y position of control
--- @param w number # The width of control
--- @param h number # The height of control
--- @return UIControl
function UIControl:new(core, x, y, w, h)

    --- @type HitBox
    local hit_box = {x, y, w, h}

    --- @type UIControl
    local t = {
        hit_box = hit_box,
        state = core:checkHitbox(hit_box),
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return UIControl
