local L = {}
local locale = GetLocale()

if locale == "ruRU" then
    L["Base Options"] = "Основные настройки"
    L["Show Minimap Button"] = "Показать кнопку у миникарты"
    L["Show or hide the minimap button"] = "Показать или скрыть кнопку у миникарты"
    L["Minimap Button Tooltip"] = "Нажмите, чтобы открыть настройки TweakUnit"
    L["Player"] = "Игрок"
    L["Class Color"] = "Цвет класса"
    L["Enable/disable class color on player frame"] = "Включить/выключить цвет класса на рамке игрока"
    L["Texture"] = "Текстура"
    L["Select the healthbar texture"] = "Выберите текстуру полосы здоровья"
    L["Power Bar Texture"] = "Текстура полосы силы"
    L["Select the power bar texture"] = "Выберите текстуру полосы силы"
    L["Invert Health Bar Colors"] = "Инвертировать цвета полосы здоровья"
    L["Swap foreground and background colors of the health bar"] = "Поменять местами цвета переднего плана и фона полосы здоровья"
    L["Inverted Health Bar Color"] = "Цвет инвертированной полосы здоровья"
    L["Color to use for the health bar when inverted"] = "Цвет для полосы здоровья в инвертированном режиме"
    L["Target"] = "Цель"
    L["Enable/disable class color on target frame"] = "Включить/выключить цвет класса на рамке цели"
    L["Raid"] = "Рейд"
    L["Fade Options"] = "Настройки затухания"
    L["Minimum Fade"] = "Минимальное затухание"
    L["Maximum Fade"] = "Максимальное затухание"
    L["Opacity for out of range raid members"] = "Непрозрачность для членов рейда вне зоны досягаемости"
    L["Opacity for in range raid members"] = "Непрозрачность для членов рейда в зоне досягаемости"
    L["Minimap Button Tooltip"] = "Нажмите, чтобы открыть настройки TweakUnit"
    L["Fonts"] = "Шрифты"
    L["Name Font"] = "Шрифт имени"
    L["Health Font"] = "Шрифт здоровья"
    L["Size"] = "Размер"
    L["Outline"] = "Контур"
    L["None"] = "Нет"
    L["Thin"] = "Тонкий"
    L["Thick"] = "Толстый"
    L["Text Color"] = "Цвет текста"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
