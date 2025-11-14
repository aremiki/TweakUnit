local L = {}
local locale = GetLocale()

if locale == "frFR" then
    L["Base Options"] = "Options de base"
    L["Show Minimap Button"] = "Afficher le bouton sur la minicarte"
    L["Show or hide the minimap button"] = "Affiche ou masque le bouton sur la minicarte"
    L["Minimap Button Tooltip"] = "Cliquez pour ouvrir les options de TweakUnit"
    L["Player"] = "Joueur"
    L["Class Color"] = "Couleur de classe"
    L["Enable/disable class color on player frame"] = "Activer/désactiver la couleur de classe sur le cadre du joueur"
    L["Texture"] = "Texture"
    L["Select the healthbar texture"] = "Sélectionner la texture de la barre de vie"
    L["Power Bar Texture"] = "Texture de la barre de pouvoir"
    L["Select the power bar texture"] = "Sélectionner la texture de la barre de pouvoir"
    L["Invert Health Bar Colors"] = "Inverser les couleurs de la barre de vie"
    L["Swap foreground and background colors of the health bar"] = "Inverser les couleurs d'avant-plan et d'arrière-plan de la barre de vie"
    L["Inverted Health Bar Color"] = "Couleur de la barre de vie inversée"
    L["Color to use for the health bar when inverted"] = "Couleur à utiliser pour la barre de vie en mode inversé"
    L["Target"] = "Cible"
    L["Enable/disable class color on target frame"] = "Activer/désactiver la couleur de classe sur le cadre de la cible"
    L["Raid"] = "Raid"
    L["Fade Options"] = "Options de fondu"
    L["Minimum Fade"] = "Fondu minimum"
    L["Maximum Fade"] = "Fondu maximum"
    L["Opacity for out of range raid members"] = "Opacité pour les membres du raid hors de portée"
    L["Opacity for in range raid members"] = "Opacité pour les membres du raid à portée"
    L["Minimap Button Tooltip"] = "Cliquez pour ouvrir les options de TweakUnit"
    L["Fonts"] = "Polices"
    L["Name Font"] = "Police du nom"
    L["Health Font"] = "Police de la vie"
    L["Size"] = "Taille"
    L["Outline"] = "Contour"
    L["None"] = "Aucun"
    L["Thin"] = "Mince"
    L["Thick"] = "Épais"
    L["Text Color"] = "Couleur du texte"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
