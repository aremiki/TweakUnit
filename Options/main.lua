local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local L = _G.TweakUnit_Locale
local LibAceConfig = LibStub("AceConfig-3.0")
local LibAceConfigDialog = LibStub("AceConfigDialog-3.0")
local LibAceDBOptions = LibStub("AceDBOptions-3.0")

function TweakUnit:SetupOptions()
    local options = {
        name = "TweakUnit",
        type = "group",
        args = {
            baseOptions = {
                type = "group",
                name = L["Base Options"],
                order = 1,
                args = {
                    miniMapButton = {
                        type = "toggle",
                        name = L["Show Minimap Button"],
                        desc = L["Show or hide the minimap button"],
                        get = function() return not self.db.profile.miniMapButton.hide end,
                        set = function(_, v) 
                            self.db.profile.miniMapButton.hide = not v
                            self:UpdateMinimapButton()
                        end
                    }
                }
            },

            player = self.Options_Player,
            target = self.Options_Target,
            raid = self.Options_Raid,
            profiles = LibAceDBOptions:GetOptionsTable(self.db)
        }
    }

    options.args.player.order = 2
    options.args.target.order = 3
    options.args.raid.order = 4
    options.args.profiles.order = 5

    LibAceConfig:RegisterOptionsTable("TweakUnit", options)
    LibAceConfigDialog:AddToBlizOptions("TweakUnit", "TweakUnit")
end
