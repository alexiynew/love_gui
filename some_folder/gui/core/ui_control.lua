local path = select(1, ...):match(".+%.") or ""

local DebugComponent = require(path .. 'debug_component')

--- @class UIControl (exact)
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
UIControl.__index = UIControl

--- Draws the control
--- @param graphics table love.graphics
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
    self.children[#self.children + 1] = control
    control.parent = self
end

--- Creates new control
--- @param core Core
--- @param x integer
--- @param y integer
--- @param w integer
--- @param h integer
--- @return UIControl
function UIControl.new(core, x, y, w, h)
    local self = setmetatable({}, UIControl)

    self.id = core:getNewId()
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.handle_mouse_input = false
    self.children = {}

    if core.debug then
        self.debug = DebugComponent.new(core.style.debug_color)
    end

    return self
end

return UIControl
