--- @alias Graphics table

--- @alias DrawFunction fun(graphics: Graphics, style :Style)

--- @class DrawCommand
--- @field control UIControl
--- @field styles StyleList
--- @field command DrawFunction

--- @class Core
--- @field graphics table # Reference to love.graphics
--- @field mouse table # Reference to love.mouse
--- @field style StyleDescription # Style configuration
--- @field draw_commands DrawCommand[] # list of functions to draw controls
--- @field mouse_pos [number,number]|nil # {x, y}
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

--- @param styles StyleList
--- @param state ControlState
--- @return Style
local function chooseStyleFormState(styles, state)
    if state.disabled then
        return styles.disabled or styles.default
    elseif state.clicked then
        return styles.clicked or styles.default
    elseif state.hover then
        return styles.hover or styles.default
    elseif state.focus then
        return styles.focus or styles.default
    end

    return styles.default
end

function Core:draw()
    for _, dc in ipairs(self.draw_commands) do

        --- @type Style
        local style = chooseStyleFormState(dc.styles, dc.control.state)
        dc.command(self.graphics, style)
    end

    endFrame(self)
end

--- Add new command to draw UIControl
--- @param control UIControl
--- @param styles StyleList
--- @param command DrawFunction
function Core:addDrawCommand(control, styles, command)
    --- @type DrawCommand
    local dc = {
        control = control,
        styles = styles,
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
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return Core
