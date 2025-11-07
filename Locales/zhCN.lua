local L = {}
local locale = GetLocale()

if locale == "zhCN" then
    L["Base Options"] = "基础选项"
    L["Show Minimap Button"] = "显示小地图按钮"
    L["Show or hide the minimap button"] = "显示或隐藏小地图按钮"
    L["Minimap Button Tooltip"] = "点击打开TweakUnit选项"
    L["Player"] = "玩家"
    L["Class Color"] = "职业颜色"
    L["Enable/disable class color on player frame"] = "启用/禁用玩家框架的职业颜色"
    L["Texture"] = "材质"
    L["Select the healthbar texture"] = "选择生命条材质"
    L["Invert Health Bar Colors"] = "反转生命条颜色"
    L["Swap foreground and background colors of the health bar"] = "交换生命条的前景色和背景色"
    L["Inverted Health Bar Color"] = "反转的生命条颜色"
    L["Color to use for the health bar when inverted"] = "反转模式下生命条使用的颜色"
    L["Target"] = "目标"
    L["Enable/disable class color on target frame"] = "启用/禁用目标框架的职业颜色"
    L["Raid"] = "团队"
    L["Fade Options"] = "淡出选项"
    L["Minimum Fade"] = "最小淡出"
    L["Maximum Fade"] = "最大淡出"
    L["Opacity for out of range raid members"] = "范围外团队成员不透明度"
    L["Opacity for in range raid members"] = "范围内团队成员不透明度"
    L["Minimap Button Tooltip"] = "点击打开TweakUnit选项"
    L["Fonts"] = "字体"
    L["Name Font"] = "名称字体"
    L["Health Font"] = "生命值字体"
    L["Size"] = "大小"
    L["Outline"] = "轮廓"
    L["None"] = "无"
    L["Thin"] = "细"
    L["Thick"] = "粗"
    L["Text Color"] = "文本颜色"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
