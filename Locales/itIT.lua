local L = {}
local locale = GetLocale()

if locale == "itIT" then
    L["Base Options"] = "Opzioni di base"
    L["Show Minimap Button"] = "Mostra pulsante sulla minimappa"
    L["Show or hide the minimap button"] = "Mostra o nascondi il pulsante sulla minimappa"
    L["Minimap Button Tooltip"] = "Clicca per aprire le opzioni di TweakUnit"
    L["Player"] = "Giocatore"
    L["Class Color"] = "Colore della classe"
    L["Enable/disable class color on player frame"] = "Attiva/disattiva il colore della classe sul riquadro del giocatore"
    L["Texture"] = "Texture"
    L["Select the healthbar texture"] = "Seleziona la texture della barra della salute"
    L["Target"] = "Bersaglio"
    L["Enable/disable class color on target frame"] = "Attiva/disattiva il colore della classe sul riquadro del bersaglio"
    L["Raid"] = "Incursione"
    L["Fade Options"] = "Opzioni dissolvenza"
    L["Minimum Fade"] = "Dissolvenza minima"
    L["Maximum Fade"] = "Dissolvenza massima"
    L["Opacity for out of range raid members"] = "Opacità per i membri dell'incursione fuori portata"
    L["Opacity for in range raid members"] = "Opacità per i membri dell'incursione in portata"
    L["Minimap Button Tooltip"] = "Clicca per aprire le opzioni di TweakUnit"
    L["Fonts"] = "Caratteri"
    L["Name Font"] = "Carattere del nome"
    L["Health Font"] = "Carattere della salute"
    L["Size"] = "Dimensione"
    L["Outline"] = "Contorno"
    L["None"] = "Nessuno"
    L["Thin"] = "Sottile"
    L["Thick"] = "Spesso"
    L["Text Color"] = "Colore del testo"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
