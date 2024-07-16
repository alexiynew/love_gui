--- @alias HitBox [number,number,number,number] # {x, y, w, h}

--- @class ControlState
--- @field disabled boolean # Is control in an disabled state. e.g. can't process events.
--- @field hover boolean # Is control hovered? User holding the mouse pointer over the control.
--- @field clicked boolean # Is control being activated by the user. For example, when the item is clicked on.
--- @field focus boolean # Does Control has keyboard focus.


--- @class UIControl
--- @field hit_box HitBox
--- @field state ControlState
--- @field style Style
local UIControl = {}




--- Cheks if mouse is over control
--- @return boolean # True if mouse hovers the control
function UIControl:isHovered()
    return self.state.hover
end

--- Draw control box
--- @param graphics Graphics
function UIControl:drawBox(graphics)
    local bg, border = self.style.bg, self.style.border
    local x, y, w, h = unpack(self.hit_box)

    graphics.setColor(bg)
    graphics.rectangle('fill', x, y, w, h, border.radius)

    graphics.setLineWidth(border.width - 0.5)
    graphics.setColor(border.color)
    graphics.rectangle('line', x, y, w, h, border.radius, border.radius)
end

--- Draw control box
--- @param graphics Graphics
--- @param text string
function UIControl:drawText(graphics, text)
    local x, y, w = unpack(self.hit_box)
    local fg = self.style.fg
    local font = self.style.font

    graphics.setFont(font)
    graphics.setColor(fg)
    graphics.printf(text, x, y, w, "left")
end

--- Draw debug bounding box
--- @param graphics Graphics
function UIControl:drawDebugBox(graphics)
    local x, y, w, h = unpack(self.hit_box)

    graphics.setColor(debug_color)
    graphics.rectangle('line', x, y, w, h)
end

--- Draw control
--- @param graphics Graphics
function UIControl:draw(graphics)
    error("Not implemented")
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
    local hit_box = { x, y, w, h }
    local state = core:checkHitbox(hit_box)
    local style = core:getStyle(state)

    --- @type UIControl
    local t = {
        hit_box = hit_box,
        state = state,
        style = style,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return UIControl
