local L = {}
local locale = GetLocale()

if locale == "deDE" then
    L["Base Options"] = "Grundlegende Einstellungen"
    L["Show Minimap Button"] = "Minimap-Button anzeigen"
    L["Show or hide the minimap button"] = "Minimap-Button ein- oder ausblenden"
    L["Minimap Button Tooltip"] = "Klicken, um die TweakUnit-Optionen zu öffnen"
    L["Player"] = "Spieler"
    L["Class Color"] = "Klassenfarbe"
    L["Enable/disable class color on player frame"] = "Klassenfarbe im Spielerfenster ein-/ausschalten"
    L["Texture"] = "Textur"
    L["Select the healthbar texture"] = "Textur der Gesundheitsleiste auswählen"
    L["Target"] = "Ziel"
    L["Enable/disable class color on target frame"] = "Klassenfarbe im Zielfenster ein-/ausschalten"
    L["Raid"] = "Schlachtzug"
    L["Fade Options"] = "Ausblendungsoptionen"
    L["Minimum Fade"] = "Minimale Ausblendung"
    L["Maximum Fade"] = "Maximale Ausblendung"
    L["Opacity for out of range raid members"] = "Deckkraft für Schlachtzugmitglieder außerhalb der Reichweite"
    L["Opacity for in range raid members"] = "Deckkraft für Schlachtzugmitglieder in Reichweite"
    L["Minimap Button Tooltip"] = "Klicken, um die TweakUnit-Optionen zu öffnen"
    L["Fonts"] = "Schriftarten"
    L["Name Font"] = "Namensschriftart"
    L["Health Font"] = "Gesundheitsschriftart"
    L["Size"] = "Größe"
    L["Outline"] = "Umriss"
    L["None"] = "Keine"
    L["Thin"] = "Dünn"
    L["Thick"] = "Dick"
    L["Text Color"] = "Textfarbe"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
