local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local L = _G.TweakUnit_Locale

TweakUnit.Options_Target = {
    type = "group",
    name = L["Target"],
    args = {
        classColor = {
            type = "toggle",
            name = L["Class Color"],
            desc = L["Enable/disable class color on target frame"],
            order = 1,
            get = function() return TweakUnit.db.profile.target.classColor end,
            set = function(_, v)
                TweakUnit.db.profile.target.classColor = v
                TweakUnit.UnitFrames:UpdateTargetClassColor(v)
            end,
        },
        texture = {
            type = "select",
            name = L["Texture"],
            desc = L["Select the healthbar texture"],
            order = 2,
            values = function()
                local textures = TweakUnit:GetAvailableTextures()
                local textureList = {}
                for name, _ in pairs(textures) do
                    textureList[name] = name
                end
                return textureList
            end,
            get = function() return TweakUnit.db.profile.target.texture end,
            set = function(_, v)
                TweakUnit.db.profile.target.texture = v
                TweakUnit.UnitFrames:UpdateTargetTexture(v)
            end,
        }
    }
}
