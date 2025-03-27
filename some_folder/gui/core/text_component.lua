--- @enum VAlign
local VAlign = {
    top = "top",
    middle = "middle",
    bottom = "bottom",
}

--- @enum HAlign
local HAlign = {
    left = "left",
    center = "center",
    right = "right",
}

--- Top offset for vertical alignment
--- @param box_h integer
--- @param font_h integer
--- @param v_align VAlign
--- @return integer
local function getOffsetForAlign(box_h, font_h, v_align)
    if v_align == VAlign.top then
        return 0
    elseif v_align == VAlign.middle then
        return (box_h - font_h) / 2
    elseif v_align == VAlign.bottom then
        return box_h - font_h
    end

    error("Invalid vertical alignment [" .. v_align .. "]")
end


--- @class TextComponent (exact)
--- @field text string
--- @field font table
--- @field color Color
--- @field h_align HAlign
--- @field v_align VAlign
local TextComponent = {}
TextComponent.__index = TextComponent


function TextComponent:draw(graphics, x, y, w, h)
    -- center text inside button
    local font_height = self.font:getHeight()
    local text_y_offset = getOffsetForAlign(h, font_height, self.v_align)

    graphics.setFont(self.font)
    graphics.setColor(self.color)
    graphics.printf(self.text, x, y + text_y_offset, w, self.h_align)
end

--- Creates new text
--- @param text string
--- @param font table
--- @param color Color
--- @param h_align? HAlign # default: left
--- @param v_align? VAlign # default: middle
--- @return TextComponent
function TextComponent.new(text, font, color, h_align, v_align)
    h_align = h_align or "left"
    v_align = v_align or "middle"

    local self = setmetatable({}, TextComponent)
    self.text = text
    self.font = font
    self.color = color
    self.h_align = h_align
    self.v_align = v_align

    return self
end

return TextComponent
