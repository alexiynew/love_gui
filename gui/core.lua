---
--- @module 'Core'
---

--- @class UIControl

--- @alias ControlId number
--- @alias HitBox [number,number,number,number] # {x, y, w, h}

--- @class Core
--- @field graphics table # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field next_index ControlId # Id for next control
--- @field draw_commands function[]
--- @field last_hovered ControlId
--- @field current_hovered ControlId
--- @field mouse_pos [number,number] # {x, y}
local Core = {}
Core.__index = Core

Core.graphics = love.graphics
Core.mouse = love.mouse
Core.next_index = 1
Core.draw_commands = {}
Core.mouse_pos = { 0, 0 }
Core.style = nil

local function pointInRect(point, box)
    local px, py = unpack(point)
    local x, y, w, h = unpack(box)
    return px >= x and px <= x + w and py >= y and py <= y + h
end

local function endFrame()
    Core.mouse_pos = { Core.mouse.getPosition() }
    Core.next_index = 1

    Core.last_hovered, Core.current_hovered = Core.current_hovered, nil
end

function Core:draw()
    for _, command in pairs(self.draw_commands) do
        command(self.graphics)
    end

    endFrame()
end

function Core:isHoveredIn(id)
    return id == self.current_hovered and id ~= self.last_hovered
end

function Core:isHovered(id)
    return id == self.current_hovered
end

function Core:isHoveredOut(id)
    return id ~= self.current_hovered and id == self.last_hovered
end

function Core:getNewId()
    local i = self.next_index
    self.next_index = self.next_index + 1
    return i
end

--- Add new command to draw UIControl
--- @param commnad function
function Core:addDrawCommand(commnad)
    table.insert(self.draw_commands, commnad)
end

--- Creates new UI control
--- @return UIControl
function Core:newControl(x, y, w, h)
    local t = {}
    t.__index = t

    t.id = self:getNewId()
    t.hit_box = { x, y, w, h }
    t.style = self.style:default_style()


    --- Cheks if control has been hevered
    --- @return boolean # True if mouse hovers the control in this frame
    t.isHoveredIn = function()
        return self:isHoveredIn(t.id)
    end

    --- Cheks if mouce is over control
    --- @return boolean # True if mouse hovers the control
    t.isHovered = function()
        return self:isHovered(t.id)
    end

    --- Cheks if mouse leave control
    --- @return boolean # True if mouse leave the control in this frame
    t.isHoveredOut = function()
        return self:isHoveredOut(t.id)
    end

    if pointInRect(self.mouse_pos, t.hit_box) then
        self.current_hovered = t.id
    end

    return t
end

return Core
