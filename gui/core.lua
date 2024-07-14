--- @alias Graphics table

--- @alias DrawFunction fun(graphics: Graphics, style :Style)

--- @class DrawCommand
--- @field control UIControl
--- @field command DrawFunction

--- @class Core
--- @field graphics table # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field style StyleDescription # Style configuration
--- @field draw_commands DrawCommand[] # list of functions to draw controls
--- @field mouse_pos [number,number]|nil # {x, y}
--- @field debug boolean # Show debug draw
local Core = {}


local function pointInRect(point, box)
    local px, py = unpack(point)
    local x, y, w, h = unpack(box)
    return px >= x and px <= x + w and py >= y and py <= y + h
end

local function endFrame(core)
    core.mouse_pos = { core.mouse.getPosition() }
    core.draw_commands = {}
end

local function copyTable(input)
    local res = {}
    for k, v in pairs(input) do
        if type(v) == "table" then
            res[k] = copyTable(v)
        else
            res[k] = v
        end
    end

    return res
end


function Core:draw()
    for _, dc in ipairs(self.draw_commands) do
        dc.command(self.graphics, dc.control.style)
        if self.debug then
            dc.control:drawDebugBox(self.graphics)
        end
    end

    endFrame(self)
end

--- Add new command to draw UIControl
--- @param control UIControl
--- @param command DrawFunction
function Core:addDrawCommand(control, command)
    --- @type DrawCommand
    local dc = {
        control = control,
        command = command,
    }
    self.draw_commands[#self.draw_commands + 1] = dc
end

--- Checks if mouse is in control hit box
--- @param hit_box HitBox
--- @return ControlState
function Core:checkHitbox(hit_box)
    --- @type boolean
    local hover = self.mouse_pos and pointInRect(self.mouse_pos, hit_box) or false

    --- @type ControlState
    local state = {
        disabled = false,
        hover = hover,
        clicked = false,
        focus = false,
    }

    return state
end

--- Returns control style depending on it's state
--- @param state ControlState
--- @return Style
function Core:getStyle(state)
    --- @tyle Style
    local s = self.style.default
    local res = nil

    if state.disabled then
        res = s.disabled or s.default
    elseif state.clicked then
        res = s.clicked or s.default
    elseif state.hover then
        res = s.hover or s.default
    elseif state.focus then
        res = s.focus or s.default
    end

    res = res or s.default

    return copyTable(res)
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
        draw_commands = {},
        mouse_pos = nil,
        debug = false,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return Core
