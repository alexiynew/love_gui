--- @class State (exact)
--- @field hover boolean
--- @field active boolean
--- @field clicked boolean
local State = {}
State.__index = State

State.__tostring = function(self)
    return "hover: " .. tostring(self.hover) ..
        ", active: " .. tostring(self.active) ..
        ", clicked: " .. tostring(self.clicked)
end

--- Creates new state
--- @param hover boolean
--- @param active boolean
--- @param clicked boolean
--- @return State
function State.new(hover, active, clicked)
    local self = setmetatable({}, State)

    self.hover = hover or false
    self.active = active or false
    self.clicked = clicked or false

    return self
end

return State
