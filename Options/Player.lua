local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local L = _G.TweakUnit_Locale

TweakUnit.Options_Player = {
    type = "group",
    name = L["Player"],
    args = {
        classColor = {
            type = "toggle",
            name = L["Class Color"],
            desc = L["Enable/disable class color on player frame"],
            order = 1,
            get = function() return TweakUnit.db.profile.player.classColor end,
            set = function(_, v)
                TweakUnit.db.profile.player.classColor = v
                TweakUnit.UnitFrames:UpdatePlayerClassColor(v)
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
            get = function() return TweakUnit.db.profile.player.texture end,
            set = function(_, v)
                TweakUnit.db.profile.player.texture = v
                TweakUnit.UnitFrames:UpdatePlayerTexture(v)
            end,
        }
    }
}
