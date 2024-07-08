local PATH_BASE = (...) .. "."

local UICore = require(PATH_BASE .. 'core')

require(PATH_BASE .. 'ui_control')

--- @class Label: UIControl

-- IMGUI_API bool IsItemHovered(ImGuiHoveredFlags flags = 0); // is the last item hovered? (and usable, aka not blocked by a popup, etc.). See ImGuiHoveredFlags for more options.
-- IMGUI_API bool IsItemActive(); // is the last item active? (e.g. button being held, text field being edited. This will continuously return true while holding mouse button on an item. Items that don't interact will always return false)
-- IMGUI_API bool IsItemFocused(); // is the last item focused for keyboard/gamepad navigation?
-- IMGUI_API bool IsItemClicked(ImGuiMouseButton mouse_button = 0); // is the last item hovered and mouse clicked on? (**) == IsMouseClicked(mouse_button) && IsItemHovered()Important. (**) this it NOT equivalent to the behavior of e.g. Button(). Read comments in function definition.
-- IMGUI_API bool IsItemVisible(); // is the last item visible? (items may be out of sight because of clipping/scrolling)
-- IMGUI_API bool IsItemEdited(); // did the last item modify its underlying value this frame? or was pressed? This is generally the same as the "bool" return value of many widgets.
-- IMGUI_API bool IsItemActivated(); // was the last item just made active (item was previously inactive).
-- IMGUI_API bool IsItemDeactivated(); // was the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that requires continuous editing.
-- IMGUI_API bool IsItemDeactivatedAfterEdit(); // was the last item just made inactive and made a value change when it was active? (e.g. Slider/Drag moved). Useful for Undo/Redo patterns with widgets that requires continuous editing. Note that you may get false positives (some widgets such as Combo()/ListBox()/Selectable() will return true even when clicking an already selected item).
-- IMGUI_API bool IsItemToggledOpen(); // was the last item open state toggled? set by TreeNode().

local label_func = require(PATH_BASE .. 'label')

--- Creates label control
--- @param text string
--- @param x? number
--- @param y? number
--- @return Label
local function Label(text, x, y)
    return label_func(UICore, text, x, y)
end

local gui = {
    update = function(...) UICore:update(...) end,
    draw = function(...) UICore:draw(...) end,

    -- UI elements
    Label = Label
}

return gui
