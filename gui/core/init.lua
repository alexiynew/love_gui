local path = (...) .. '.'

local State = require(path .. 'state')

--- @alias Graphics table

--- @alias ControlId integer
--- @alias DrawFunction fun(graphics: Graphics)

local left_mouse_button = 1
local right_mouse_button = 2

--- @class Core
--- @field graphics Graphics # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field style StyleList # Style configuration
--- @field mouse_pos [number,number]|nil # {x, y}
--- @field mouse_down boolean
--- @field debug boolean # Show debug draw
--- @field font table # Current UI font
--- @field controls UIControl[]
--- @field next_id ControlId
--- @field hover_id ControlId|nil
--- @field active_id ControlId|nil
--- @field clicked_id ControlId|nil
local Core = {}
Core.__index = Core


local function pointInRect(point, x, y, w, h)
    local px, py = unpack(point)
    return px >= x and px <= x + w and py >= y and py <= y + h
end

function Core:draw()
    for _, c in ipairs(self.controls) do
        c:draw(self.graphics)
    end

    -- End frame
    self.mouse_pos = { self.mouse.getPosition() }
    self.mouse_down = self.mouse.isDown(left_mouse_button, right_mouse_button)
    self.controls = {}
    self.next_id = 0
    self.hover_id = nil
    self.clicked_id = nil
end

--- New control id
--- @return ControlId
function Core:getNewId()
    self.next_id = self.next_id + 1
    return self.next_id
end

--- Get control state
--- @param id ControlId
--- @return State
function Core:getState(id)
    --- @type State
    local state = State.new(self.hover_id == id, self.active_id == id, self.clicked_id == id)

    return state
end

--- Process control
--- @param control UIControl
--- @return State
function Core:processControl(control)
    if not control.handle_mouse_input then
        --- empty state
        return State.new()
    end

    local x, y = control:absolutePosition()
    local w, h = control.w, control.h
    local id = control.id

    --- @type boolean
    local hover = self.mouse_pos and pointInRect(self.mouse_pos, x, y, w, h) or false
    --- @type boolean
    local active = self.active_id == id

    if hover then
        -- click
        if active and not self.mouse_down then
            self.clicked_id = id
            self.active_id = nil
        end

        -- press
        if not active and self.mouse_down then
            self.active_id = id
        end

        self.hover_id = id
    else
        if active and not self.mouse_down then
            self.active_id = nil
        end
    end

    return self:getState(id)
end

--- Returns control style
--- @param state State
--- @return Style
function Core:getStyle(state)
    --- @type StyleList
    local s = self.style

    if state.clicked then
        return s.clicked
    elseif state.active then
        return s.active
    elseif state.hover then
        return s.hover
    end

    return s.default
end

--- Adds new command to draw control
--- @param control UIControl
function Core:addControl(control)
    self.controls[#self.controls + 1] = control
end

--- Creates new core instance
--- @param style StyleList
--- @return Core
function Core.new(style)
    local self = setmetatable({}, Core)

    self.graphics = love.graphics
    self.mouse = love.mouse
    self.style = style
    self.mouse_pos = nil
    self.mouse_down = false
    self.debug = false
    self.font = love.graphics.getFont()
    self.controls = {}
    self.next_id = 0
    self.hover_id = nil
    self.active_id = nil
    self.clicked_id = nil

    return self
end

return Core
