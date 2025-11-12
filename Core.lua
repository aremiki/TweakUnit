local TweakUnit = LibStub("AceAddon-3.0"):NewAddon("TweakUnit", "AceConsole-3.0", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0", true)
local LDB = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)
local L = TweakUnit_Locale or {}

SLASH_TweakUnit1 = "/tu"
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

local Media = LibStub("LibSharedMedia-3.0", true)

if Media then
	AceGUIWidgetLSMlists = {
		['font'] = Media:HashTable("font"),
		['sound'] = Media:HashTable("sound"),
		['statusbar'] = Media:HashTable("statusbar"),
		['border'] = Media:HashTable("border"),
		['background'] = Media:HashTable("background"),
	}
end

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
                hide = false,
                minimapPos = 335,
                radius = 80
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
                invertHealthBarColor = false,
                invertedHealthBarColor = {r=0.3, g=0.3, b=0.3, a=1},
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
            icon = "Interface\\AddOns\\TweakUnit\\media\\logosmall.png",
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
            LDBIcon:Register("TweakUnit", ldb, self.db.profile.miniMapButton)
        end
    end
end


function TweakUnit:OnEnable()
    -- Hook for raid fade updates when range changes
    hooksecurefunc("CompactUnitFrame_UpdateInRange", function(frame)
        self.RaidFrames:UpdateRaidFade(frame)
    end)

    hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame)
        self.RaidFrames:UpdateTexture(frame, self.db.profile.raid.texture)
        self.RaidFrames:UpdateNameFonts(frame)
        self.RaidFrames:UpdateHealthFonts(frame)
        self.RaidFrames:UpdateHealthBarColor(frame)
    end)

    -- Hook when Blizzard sets up default textures (this resets our custom texture!)
    -- Apply immediately without delay, like RaidFrameSettings does
    hooksecurefunc("DefaultCompactUnitFrameSetup", function(frame)
        if frame then
            self.RaidFrames:UpdateTexture(frame, self.db.profile.raid.texture)
            self.RaidFrames:UpdateHealthBarColor(frame)
        end
    end)

    -- Hook when all frames are updated (roster changes, etc.)
    hooksecurefunc("CompactUnitFrame_UpdateAll", function(frame)
        if frame then
            self.RaidFrames:UpdateTexture(frame, self.db.profile.raid.texture)
        end
    end)

    -- Hook after Blizzard updates health color to reapply our inversion
    hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
        if frame then
            self.RaidFrames:UpdateHealthBarColor(frame)
        end
    end)

    -- Hook to maintain health font when health updates
    hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(frame)
        if frame and frame.statusText then
            self.RaidFrames:UpdateHealthFonts(frame)
        end
    end)

    -- Hook when name updates to maintain name font
    hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
        if frame then
            self.RaidFrames:UpdateNameFonts(frame)
        end
    end)

    -- Hook when frames are displayed/shown
    hooksecurefunc("CompactUnitFrame_UpdateVisible", function(frame)
        if frame and frame:IsShown() then
            self.RaidFrames:UpdateTexture(frame, self.db.profile.raid.texture)
            self.RaidFrames:UpdateNameFonts(frame)
            self.RaidFrames:UpdateHealthFonts(frame)
            self.RaidFrames:UpdateHealthBarColor(frame)
        end
    end)

    -- Register events
    self:RegisterEvent("PLAYER_LOGIN", "OnPlayerLogin")
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnTargetChanged")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatEnd")
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
        self.RaidFrames:UpdateAllTextures()
        self.RaidFrames:UpdateAllNameFonts()
        self.RaidFrames:UpdateAllHealthFonts()
    end)
end

function TweakUnit:OnCombatEnd()
    -- Reapply fonts and textures after combat ends to fix any changes that happened during combat
    C_Timer.After(0.1, function()
        self.RaidFrames:UpdateAllNameFonts()
        self.RaidFrames:UpdateAllHealthFonts()
        self.RaidFrames:UpdateAllTextures()
    end)
end

function TweakUnit:OnGroupRosterUpdate()
    -- Update all raid frames when group composition changes
    C_Timer.After(0.5, function()
        self.RaidFrames:UpdateAllTextures()
        self.RaidFrames:UpdateAllNameFonts()
        self.RaidFrames:UpdateAllHealthFonts()
        self.RaidFrames:UpdateAllHealthColors()
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