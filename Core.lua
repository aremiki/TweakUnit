local TweakUnit = LibStub("AceAddon-3.0"):NewAddon("TweakUnit", "AceConsole-3.0", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0", true)
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
local L = TweakUnit_Locale or {}

SLASH_TweakUnit1 = "/ri"
SlashCmdList["TweakUnit"] = function()
    LibStub("AceConfigDialog-3.0"):Open("TweakUnit")
end

-- Default textures from WoW
TweakUnit.defaultTextures = {
    ["Blizzard"] = "Interface\\TargetingFrame\\UI-StatusBar",
    ["Blizzard Raid Bar"] = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
    ["Blizzard Dialog Background"] = "Interface\\DialogFrame\\UI-DialogBox-Background",
    ["Solid"] = "Interface\\Buttons\\WHITE8X8",
    ["Default Player"] = "UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Health"
}

local Media = LibStub("LibSharedMedia-3.0")

AceGUIWidgetLSMlists = {
	['font'] = Media:HashTable("font"),
	['sound'] = Media:HashTable("sound"),
	['statusbar'] = Media:HashTable("statusbar"),
	['border'] = Media:HashTable("border"),
	['background'] = Media:HashTable("background"),
}

function TweakUnit:GetAvailableTextures()
    local textures = {}

    -- Add default WoW textures
    for name, path in pairs(self.defaultTextures) do
        textures[name] = path
    end

    -- Add LibSharedMedia textures if available
    if LSM then
        local lsmTextures = LSM:List("statusbar")
        for _, name in ipairs(lsmTextures) do
            textures[name] = LSM:Fetch("statusbar", name)
        end
    end

    return textures
end

function TweakUnit:OnInitialize()
    -- Initialize database with default values
    self.db = LibStub("AceDB-3.0"):New("TweakUnitDB", {
        profile = {
            miniMapButton = {
                hide = false
            },
            player = {
                classColor = false,
                texture = "Default Player"
            },
            target = {
                classColor = false,
                texture = "Default Player"
            },
            raid = {
                texture = "Blizzard Raid Bar",
                fade = {
                    minAlpha = 0.2,
                    maxAlpha = 1.0
                },
                nameFont = "Friz Quadrata TT",
                nameFontSize = 12,
                nameFontOutline = "NONE",
                healthFont = "Friz Quadrata TT",
                healthFontSize = 20,
                healthFontOutline = "NONE",
                healthFontColor = {r=0.5, g=0.5, b=0.5, a=1}
            }
        }
    }, true)

    -- Setup options menu
    if self.SetupOptions then
        self:SetupOptions()
    end

    -- Setup minimap button
    if LDB then
        local ldb = LDB:NewDataObject("TweakUnit", {
            type = "launcher",
            text = "TweakUnit",
            icon = "Interface\\AddOns\\TweakUnit\\Media\\logosmall.png",
            OnClick = function(clickedframe, button)
                if button == "LeftButton" then
                    LibStub("AceConfigDialog-3.0"):Open("TweakUnit")
                end
            end,
            OnTooltipShow = function(tooltip)
                tooltip:AddLine("TweakUnit")
                tooltip:AddLine(L["Minimap Button Tooltip"], 1, 1, 1, true)
            end,
        })

        if LDBIcon then
            LDBIcon:Register("TweakUnit", ldb, self.db.profile.minimapButton)
        end
    end
end


function TweakUnit:OnEnable()
    -- Hook for raid fade updates when range changes
    hooksecurefunc("CompactUnitFrame_UpdateInRange", function(frame)
        self.RaidFrames:UpdateRaidFade()
    end)

    -- Register events
    self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnTargetChanged")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "OnGroupRosterUpdate")
end


function TweakUnit:OnPlayerLogin()
    self.UnitFrames:UpdatePlayerClassColor(self.db.profile.player.classColor)
    self.UnitFrames:UpdatePlayerTexture(self.db.profile.player.texture)
    self:UpdateMinimapButton()
end

function TweakUnit:OnTargetChanged()
    self.UnitFrames:UpdateTargetClassColor(self.db.profile.target.classColor)
    self.UnitFrames:UpdateTargetTexture(self.db.profile.target.texture)
end

function TweakUnit:OnPlayerEnteringWorld()
    -- Update raid frames when entering world (reload, zone change, etc.)
    C_Timer.After(0.5, function()
        self.RaidFrames:UpdateTexture(self.db.profile.raid.texture)
        self.RaidFrames:UpdateNameFonts()
        self.RaidFrames:UpdateHealthFonts()
        self.RaidFrames:UpdateRaidFade()
    end)
end

function TweakUnit:OnGroupRosterUpdate()
    -- Update raid frames and fade when group composition changes
    C_Timer.After(0.1, function()
        self.RaidFrames:UpdateTexture(self.db.profile.raid.texture)
        self.RaidFrames:UpdateNameFonts()
        self.RaidFrames:UpdateHealthFonts()
        self.RaidFrames:UpdateRaidFade()
    end)
end

function TweakUnit:UpdateMinimapButton()
    if LDBIcon then
        if self.db.profile.miniMapButton.hide then
            LDBIcon:Hide("TweakUnit")
        else
            LDBIcon:Show("TweakUnit")
        end
    end
end