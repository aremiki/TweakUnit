local L = {}
local locale = GetLocale()

if locale == "ptBR" then
    L["Base Options"] = "Opções básicas"
    L["Show Minimap Button"] = "Mostrar botão no minimapa"
    L["Show or hide the minimap button"] = "Mostrar ou esconder o botão no minimapa"
    L["Minimap Button Tooltip"] = "Clique para abrir as opções do TweakUnit"
    L["Player"] = "Jogador"
    L["Class Color"] = "Cor de classe"
    L["Enable/disable class color on player frame"] = "Ativar/desativar cor de classe no quadro do jogador"
    L["Texture"] = "Textura"
    L["Select the healthbar texture"] = "Selecionar a textura da barra de vida"
    L["Target"] = "Alvo"
    L["Enable/disable class color on target frame"] = "Ativar/desativar cor de classe no quadro do alvo"
    L["Raid"] = "Raide"
    L["Fade Options"] = "Opções de esmaecimento"
    L["Minimum Fade"] = "Esmaecimento mínimo"
    L["Maximum Fade"] = "Esmaecimento máximo"
    L["Opacity for out of range raid members"] = "Opacidade para membros do raide fora do alcance"
    L["Opacity for in range raid members"] = "Opacidade para membros do raide no alcance"
    L["Minimap Button Tooltip"] = "Clique para abrir as opções do TweakUnit"
    L["Fonts"] = "Fontes"
    L["Name Font"] = "Fonte do nome"
    L["Health Font"] = "Fonte da vida"
    L["Size"] = "Tamanho"
    L["Outline"] = "Contorno"
    L["None"] = "Nenhum"
    L["Thin"] = "Fino"
    L["Thick"] = "Grosso"
    L["Text Color"] = "Cor do texto"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
