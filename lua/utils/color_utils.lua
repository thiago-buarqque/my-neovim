local color_utils = {}

-- Helper function to clamp values between 0 and 255
local function clamp(val)
    return math.max(0, math.min(255, val))
end

-- Converts a HEX color (e.g., "#FFAA00") to RGB values
local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

-- Converts RGB values to HEX format
local function rgb_to_hex(r, g, b)
    return string.format("#%02X%02X%02X", r, g, b)
end

-- Darkens a HEX color by reducing RGB components
function color_utils.darken(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    r, g, b = clamp(r - amount), clamp(g - amount), clamp(b - amount)
    return rgb_to_hex(r, g, b)
end

-- Lightens a HEX color by increasing RGB components
function color_utils.lighten(hex, amount)
    local r, g, b = hex_to_rgb(hex)
    r, g, b = clamp(r + amount), clamp(g + amount), clamp(b + amount)
    return rgb_to_hex(r, g, b)
end

return color_utils

