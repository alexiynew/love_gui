---

--- @class Style
local Style = {}

function Style:default_style()
    local t = {}

    setmetatable(t, self)
    self.__index = self

    t.foreground_color = { 0.8, 0.8, 0.8, 1 }
    t.background_color = { 0.2, 0.2, 0.6, 1 }
    t.corner_radius = 4

    return t
end

return Style
