--- @alias Graphics table

--- @alias ControlId integer
--- @alias DrawFunction fun(graphics: Graphics)

local left_mouse_button = 1
local right_mouse_button = 2

--- @class Core
--- @field graphics table # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field style StyleDescription # Style configuration
--- @field mouse_pos [number,number]|nil # {x, y}
--- @field mouse_down boolean
--- @field debug boolean # Show debug draw
--- @field font table # Current UI font
--- @field draw_commands table<ControlId,DrawFunction>
--- @field hover_id ControlId|nil
--- @field active_id ControlId|nil
--- @field clicked_id ControlId|nil
local Core = {}


local function pointInRect(point, x, y, w, h)
    local px, py = unpack(point)
    return px >= x and px <= x + w and py >= y and py <= y + h
end

function Core:draw()
    for _, c in ipairs(self.draw_commands) do
        c(self.graphics)
    end

    -- End framw
    self.mouse_pos = { self.mouse.getPosition() }
    self.mouse_down = self.mouse.isDown( left_mouse_button, right_mouse_button )
    self.draw_commands = {}
    self.hover_id = nil
    self.clicked_id = nil
end


--- New control id
--- @return ControlId
function Core:getNewId()
    return #self.draw_commands + 1
end


--- Process controll
--- @param id ControlId
--- @param x integer
--- @param y integer
--- @param w integer
--- @param h integer
function Core:processControl(id, x, y, w, h)
    --- @type boolean
    local hover = self.mouse_pos and pointInRect(self.mouse_pos, x, y, w, h) or false
    local active = self.active_id == id

    if hover then
        if active and not self.mouse_down then
            -- click
            self.clicked_id = id
            self.active_id = nil
        elseif self.mouse_down and self.active_id == nil then
            -- press
            self.active_id = id
        end

        self.hover_id = id
    else
        if active and not self.mouse_down then
            self.active_id = nil
        end
    end

    return self:getStyle(id)
end

--- Returns control style
--- @param id ControlId
--- @return Style
function Core:getStyle(id)
    --- @type boolean
    local active = self.active_id == id
    local hover = self.hover_id == id

    --- @tyle Style
    local s = self.style.default

    if active then
        return s.active
    elseif hover then
        return s.hover
    end

    return s.default
end


--- Adds new command to draw control
--- @param id ControlId
--- @param command DrawFunction
function Core:addDrawCommnad(id, command)
    self.draw_commands[id] = command
end

--- Creates new core instance
--- @param style StyleDescription
--- @return Core
function Core:new(style)
    --- @type Core
    local t = {
        graphics = love.graphics,
        mouse = love.mouse,
        style = style,
        mouse_pos = nil,
        mouse_down = false,
        debug = false,
        font = love.graphics.getFont(),
        draw_commands = {},
        hover_id = nil,
        active_id = nil,
        clicked_id = nil,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return Core
