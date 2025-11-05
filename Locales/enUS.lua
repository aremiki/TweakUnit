local L = {}
local locale = GetLocale()

if locale == "enUS" or locale == "enGB" then
    L["Base Options"] = "Base Options"
    L["Show Minimap Button"] = "Show Minimap Button"
    L["Show or hide the minimap button"] = "Show or hide the minimap button"
    L["Minimap Button Tooltip"] = "Click to open TweakUnit options"
    L["Player"] = "Player"
    L["Class Color"] = "Class Color"
    L["Enable/disable class color on player frame"] = "Enable/disable class color on player frame"
    L["Texture"] = "Texture"
    L["Select the healthbar texture"] = "Select the healthbar texture"
    L["Target"] = "Target"
    L["Enable/disable class color on target frame"] = "Enable/disable class color on target frame"
    L["Raid"] = "Raid"
    L["Fade Options"] = "Fade Options"
    L["Minimum Fade"] = "Minimum Fade"
    L["Maximum Fade"] = "Maximum Fade"
    L["Opacity for out of range raid members"] = "Opacity for out of range raid members"
    L["Opacity for in range raid members"] = "Opacity for in range raid members"
    L["Minimap Button Tooltip"] = "Click to open TweakUnit options"
    L["Fonts"] = "Fonts"
    L["Name Font"] = "Name Font"
    L["Health Font"] = "Health Font"
    L["Size"] = "Size"
    L["Outline"] = "Outline"
    L["None"] = "None"
    L["Thin"] = "Thin"
    L["Thick"] = "Thick"
    L["Text Color"] = "Text Color"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
