
local DebugComponent = require("gui.debug_component")

--- @class State
--- @field hover boolean
--- @field active boolean
--- @field clicked boolean
local State = {}


--- @class UIControl
--- @field id ControlId
--- @field x integer
--- @field y integer
--- @field w integer
--- @field h integer
--- @field handle_mouse_input boolean
--- @field parent? UIControl
--- @field children? UIControl[]
--- @field text? TextComponent
--- @field background? BackgroundComponent
--- @field border? BorderComponent
--- @field debug? DebugComponent
local UIControl = {}


function UIControl:draw(graphics)
    local x, y = self:absolutePosition()
    local w, h = self.w, self.h

    if self.background then
        local radius = self.border and self.border.radius or 0
        self.background:draw(graphics, x, y, w, h, radius)
    end
    if self.border then
        self.border:draw(graphics, x, y, w, h)
    end
    if self.text then
        self.text:draw(graphics, x, y, w, h)
    end
    if self.debug then
        self.debug:draw(graphics, x, y, w, h)
    end

    if self.children then
        for _, c in ipairs(self.children) do
            c:draw(graphics)
        end
    end
end

--- Get absolute position of the control (x, y)
--- @return integer
--- @return integer
function UIControl:absolutePosition()
    local x, y = self.x, self.y

    if self.parent then
        local px, py = self.parent:absolutePosition()
        x = x + px
        y = y + py
    end

    return x, y
end


function UIControl:addChild(control)
    self.children[#self.children+1] = control
    control.parent = self
end


function UIControl:new(core, x, y, w, h)
    local id = core:getNewId()

    --- @type UIControl
    local t = {
        id = id,
        x = x,
        y = y,
        w = w,
        h = h,
        handle_mouse_input = false,
        children = {},
    }

    if core.debug then
        t.debug = DebugComponent:new(core.style.debug_color)
    end

    setmetatable(t, self)
    self.__index = self

    return t
end

return UIControl
