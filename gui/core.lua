---
--- @module 'UICore'
---

--- @alias ControlId number
--- @alias HitBox [number,number,number,number] # {x, y, w, h}

--- @class UICore
--- @field graphics table # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field next_index ControlId # Id for next control
--- @field draw_commands function[]
--- @field hit_boxes table<ControlId, HitBox>
--- @field last_hovered ControlId[]
--- @field current_hovered ControlId[]
local UICore = {}
UICore.__index = UICore

UICore.graphics = love.graphics
UICore.mouse = love.mouse
UICore.next_index = 1
UICore.draw_commands = {}
UICore.hit_boxes = {}

local function pointInRect(px, py, box)
    local x, y, w, h = unpack(box)
    return px >= x and px <= x + w and py >= y and py <= y + h
end

local function contains(table, value)
    if not table then
        return false
    end

    for _, v in ipairs(table) do
        if v == value then return true end
    end
    return false
end

function UICore:update(dt)
    local mx, my = self.mouse.getPosition()

    self.last_hovered = self.current_hovered
    self.current_hovered = {}
    for id, hb in ipairs(self.hit_boxes) do
        if pointInRect(mx, my, hb) then
            table.insert(self.current_hovered, id)
        end
    end
end

function UICore:draw()
    for _, command in pairs(self.draw_commands) do
        command(self.graphics)
    end
end

function UICore:isHoveredIn(id)
    return not contains(self.last_hovered, id) and contains(self.current_hovered, id)
end

function UICore:isHovered(id)
    return contains(self.current_hovered, id)
end

function UICore:isHoveredOut(id)
    return contains(self.last_hovered, id) and not contains(self.current_hovered, id)
end

function UICore:getNewId()
    local i = self.next_index
    self.next_index = self.next_index + 1
    return i
end

--- Add new command to draw UIControl
--- @param commnad function
function UICore:addDrawCommand(commnad)
    table.insert(self.draw_commands, commnad)
end

function UICore:addHitBox(id, x, y, w, h)
    if self.hit_boxes[id] == nil then
        self.hit_boxes[id] = { x, y, w, h }
    end
end

return UICore
