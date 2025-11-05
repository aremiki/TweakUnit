local L = {}
local locale = GetLocale()

if locale == "esMX" then
    L["Base Options"] = "Opciones básicas"
    L["Show Minimap Button"] = "Mostrar botón en el minimapa"
    L["Show or hide the minimap button"] = "Mostrar u ocultar el botón en el minimapa"
    L["Minimap Button Tooltip"] = "Haz clic para abrir las opciones de TweakUnit"
    L["Player"] = "Jugador"
    L["Class Color"] = "Color de clase"
    L["Enable/disable class color on player frame"] = "Activar/desactivar el color de clase en el marco del jugador"
    L["Texture"] = "Textura"
    L["Select the healthbar texture"] = "Seleccionar la textura de la barra de salud"
    L["Target"] = "Objetivo"
    L["Enable/disable class color on target frame"] = "Activar/desactivar el color de clase en el marco del objetivo"
    L["Raid"] = "Banda"
    L["Fade Options"] = "Opciones de desvanecimiento"
    L["Minimum Fade"] = "Desvanecimiento mínimo"
    L["Maximum Fade"] = "Desvanecimiento máximo"
    L["Opacity for out of range raid members"] = "Opacidad para miembros de la banda fuera de rango"
    L["Opacity for in range raid members"] = "Opacidad para miembros de la banda dentro de rango"
    L["Minimap Button Tooltip"] = "Haz clic para abrir las opciones de TweakUnit"
    L["Fonts"] = "Fuentes"
    L["Name Font"] = "Fuente del nombre"
    L["Health Font"] = "Fuente de vida"
    L["Size"] = "Tamaño"
    L["Outline"] = "Contorno"
    L["None"] = "Ninguno"
    L["Thin"] = "Delgado"
    L["Thick"] = "Grueso"
    L["Text Color"] = "Color del texto"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
