local L = {}
local locale = GetLocale()

if locale == "zhTW" then
    L["Base Options"] = "基礎選項"
    L["Show Minimap Button"] = "顯示小地圖按鈕"
    L["Show or hide the minimap button"] = "顯示或隱藏小地圖按鈕"
    L["Minimap Button Tooltip"] = "點擊打開TweakUnit選項"
    L["Player"] = "玩家"
    L["Class Color"] = "職業顏色"
    L["Enable/disable class color on player frame"] = "啟用/停用玩家框架上的職業顏色"
    L["Texture"] = "材質"
    L["Select the healthbar texture"] = "選擇生命條材質"
    L["Invert Health Bar Colors"] = "反轉生命條顏色"
    L["Swap foreground and background colors of the health bar"] = "交換生命條的前景色和背景色"
    L["Inverted Health Bar Color"] = "反轉的生命條顏色"
    L["Color to use for the health bar when inverted"] = "反轉模式下生命條使用的顏色"
    L["Target"] = "目標"
    L["Enable/disable class color on target frame"] = "啟用/停用目標框架上的職業顏色"
    L["Raid"] = "團隊"
    L["Fade Options"] = "淡出選項"
    L["Minimum Fade"] = "最小淡出"
    L["Maximum Fade"] = "最大淡出"
    L["Opacity for out of range raid members"] = "範圍外團隊成員不透明度"
    L["Opacity for in range raid members"] = "範圍內團隊成員不透明度"
    L["Minimap Button Tooltip"] = "點擊打開TweakUnit選項"
    L["Fonts"] = "字體"
    L["Name Font"] = "名稱字體"
    L["Health Font"] = "生命值字體"
    L["Size"] = "大小"
    L["Outline"] = "輪廓"
    L["None"] = "無"
    L["Thin"] = "細"
    L["Thick"] = "粗"
    L["Text Color"] = "文字顏色"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
