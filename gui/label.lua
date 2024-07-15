local UIControl = package.loaded['gui.ui_control']

--- @class Label: UIControl

--- Creates new label
--- @param core Core
--- @param text string # Text to show
--- @param x? integer # The x position
--- @param y? integer # The y position
--- @return Label
local function createLabel(core, text, x, y)
    x, y = x or 0, y or 0

    --- @type Label
    local label = UIControl:new(core, x, y)
    core:addDrawCommand(label,
        function(graphics, style)
            label:drawText(graphics, text)
        end
    )

    return label
end

return createLabel
