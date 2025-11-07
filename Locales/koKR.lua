local L = {}
local locale = GetLocale()

if locale == "koKR" then
    L["Base Options"] = "기본 옵션"
    L["Show Minimap Button"] = "미니맵 버튼 표시"
    L["Show or hide the minimap button"] = "미니맵 버튼을 표시하거나 숨깁니다"
    L["Minimap Button Tooltip"] = "TweakUnit 설정을 열려면 클릭하세요"
    L["Player"] = "플레이어"
    L["Class Color"] = "직업 색상"
    L["Enable/disable class color on player frame"] = "플레이어 프레임에서 직업 색상 사용"
    L["Texture"] = "텍스처"
    L["Select the healthbar texture"] = "생명력 바 텍스처 선택"
    L["Invert Health Bar Colors"] = "체력 바 색상 반전"
    L["Swap foreground and background colors of the health bar"] = "체력 바의 전경색과 배경색 교체"
    L["Inverted Health Bar Color"] = "반전된 체력 바 색상"
    L["Color to use for the health bar when inverted"] = "반전 시 체력 바에 사용할 색상"
    L["Target"] = "대상"
    L["Enable/disable class color on target frame"] = "대상 프레임에서 직업 색상 사용"
    L["Raid"] = "공격대"
    L["Fade Options"] = "페이드 옵션"
    L["Minimum Fade"] = "최소 페이드"
    L["Maximum Fade"] = "최대 페이드"
    L["Opacity for out of range raid members"] = "범위 밖 공격대원 불투명도"
    L["Opacity for in range raid members"] = "범위 내 공격대원 불투명도"
    L["Minimap Button Tooltip"] = "TweakUnit 설정을 열려면 클릭하세요"
    L["Fonts"] = "글꼴"
    L["Name Font"] = "이름 글꼴"
    L["Health Font"] = "생명력 글꼴"
    L["Size"] = "크기"
    L["Outline"] = "외곽선"
    L["None"] = "없음"
    L["Thin"] = "얇게"
    L["Thick"] = "두껍게"
    L["Text Color"] = "텍스트 색상"
end

_G.TweakUnit_Locale = _G.TweakUnit_Locale or {}
for k,v in pairs(L) do _G.TweakUnit_Locale[k] = v end
