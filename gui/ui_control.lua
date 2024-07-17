
local UIControl = {}

local function getOffsetForAlign(box_h, font_h,  v_align)
    if v_align == "top" then
        return 0
    elseif v_align == "middle" then
        return (box_h - font_h) / 2
    elseif v_align == "bottom" then
        return box_h - font_h
    end

    error("Invalid vertical alignment [" .. v_align .. "]")
end

function UIControl:drawText(text, h_align, v_align)
    local gr = self.graphics
    local fg = self.style.fg

    h_align = h_align or "left"
    v_align = v_align or "top"

    -- center text inside button
    local font_height = self.font:getHeight()
    local text_y_offset = getOffsetForAlign(self.h, font_height, v_align)

    gr.setFont(self.font)
    gr.setColor(fg)
    gr.printf(text, self.x, self.y + text_y_offset, self.w, h_align)
end

function UIControl:drawDebugBox()
    local gr = self.graphics
    gr.setColor(self.style.debug_color)
    gr.rectangle('line', self.x, self.y, self.w, self.h)
end

function UIControl:drawBox()
    local gr = self.graphics
    local bg = self.style.bg
    local border = self.style.border

    -- box
    gr.setColor(bg)
    gr.rectangle('fill', self.x, self.y, self.w, self.h, border.radius)

    gr.setLineWidth(border.width - 0.5)
    gr.setColor(border.color)
    gr.rectangle('line', self.x, self.y, self.w, self.h, border.radius, border.radius)
end

function UIControl:new(core, x, y, w, h)
    local id = core:getNewId()
    local style = core:processControl(id, x, y, w, h)

    local t = {
        graphics = core.graphics,
        id = id,
        font = core.font,
        style = style,
        x = x,
        y = y,
        w = w,
        h = h,
    }

    setmetatable(t, self)
    self.__index = self

    return t
end

return UIControl
