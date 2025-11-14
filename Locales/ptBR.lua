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
    L["Power Bar Texture"] = "Textura da barra de poder"
    L["Select the power bar texture"] = "Selecionar a textura da barra de poder"
    L["Invert Health Bar Colors"] = "Inverter cores da barra de vida"
    L["Swap foreground and background colors of the health bar"] = "Trocar cores de primeiro plano e plano de fundo da barra de vida"
    L["Inverted Health Bar Color"] = "Cor da barra de vida invertida"
    L["Color to use for the health bar when inverted"] = "Cor a usar para a barra de vida quando invertida"
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
