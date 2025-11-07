local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local LSM = LibStub("LibSharedMedia-3.0", true)

TweakUnit.RaidFrames = {}
TweakUnit.RaidFrames.__index = TweakUnit.RaidFrames

-- Apply texture to a single frame
function TweakUnit.RaidFrames:UpdateTexture(frame, textureName)
    if not frame or not frame.healthBar then return end

    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or "Blizzard Raid Bar"

    frame.healthBar:SetStatusBarTexture(texturePath)
    -- Store texture path on the frame to detect when it changes
    frame.healthBar.tweakUnitTexture = texturePath

    -- Also update background texture if invert colors is enabled
    if TweakUnit.db.profile.raid.invertHealthBarColor and frame.background then
        frame.background:SetTexture(texturePath)
    end
end

-- Update health bar color inversion
function TweakUnit.RaidFrames:UpdateHealthBarColor(frame)
    if not frame or not frame.healthBar or not frame.unit then return end

    -- Prevent infinite loop by checking if we're already updating this frame
    if frame.healthBar.tweakUnitUpdating then return end

    local invert = TweakUnit.db.profile.raid.invertHealthBarColor

    if invert then
        frame.healthBar.tweakUnitUpdating = true

        -- Get current health bar color (foreground)
        local r, g, b, a = frame.healthBar:GetStatusBarColor()

        -- Apply foreground color to background
        if frame.background then
            frame.background:SetVertexColor(r, g, b)
        end

        -- Set health bar to custom color (inverted background look)
        local color = TweakUnit.db.profile.raid.invertedHealthBarColor
        frame.healthBar:SetStatusBarColor(color.r, color.g, color.b, color.a)

        frame.healthBar.tweakUnitUpdating = false
    end
    -- If not inverted, do nothing and let Blizzard's default color system work
end

function TweakUnit.RaidFrames:UpdateRaidFade(frame)
    if not frame or not frame.optionTable.fadeOutOfRange then return end
    local inRange, checkedRange = UnitInRange(frame.displayedUnit)

    if checkedRange and not inRange then
        frame:SetAlpha(TweakUnit.db.profile.raid.fade.minAlpha)
        frame.background:SetAlpha(TweakUnit.db.profile.raid.fade.minAlpha)
    else
        frame:SetAlpha(TweakUnit.db.profile.raid.fade.maxAlpha)
        frame.background:SetAlpha(TweakUnit.db.profile.raid.fade.maxAlpha)
    end
end

function TweakUnit.RaidFrames:UpdateNameFonts(frame)
    local font = LSM:Fetch("font", TweakUnit.db.profile.raid.nameFont or "Friz Quadrata TT")
    local size = TweakUnit.db.profile.raid.nameFontSize or 12
    local outline = TweakUnit.db.profile.raid.nameFontOutline or "NONE"
    
    local function SetFontSafe(fontString)
        if fontString and fontString.SetFont then
            fontString:SetFont(font, size, outline)
            fontString:SetShadowColor(0, 0, 0, 1)
            fontString:SetShadowOffset(1, -1)
        end
    end

    local function ApplyToFrame(frame)
        if not frame or not frame.unit then return end

        -- Nom du joueur
        if frame.name then
            SetFontSafe(frame.name)
        end
    end

    ApplyToFrame(frame)
end


function TweakUnit.RaidFrames:UpdateHealthFonts(frame)
    if not frame or not frame.unit or not frame.statusText then return end

    local font = LSM:Fetch("font", TweakUnit.db.profile.raid.healthFont or "Friz Quadrata TT")
    local size = TweakUnit.db.profile.raid.healthFontSize or 10
    local outline = TweakUnit.db.profile.raid.healthFontOutline or "OUTLINE"
    local color = TweakUnit.db.profile.raid.healthFontColor

    -- Apply font settings
    frame.statusText:SetFont(font, size, outline)
    frame.statusText:SetTextColor(color.r, color.g, color.b, color.a)
    frame.statusText:SetShadowColor(0, 0, 0, 1)
    frame.statusText:SetShadowOffset(1, -1)

    -- Store our settings on the frame to detect when they change
    frame.statusText.tweakUnitFont = font
    frame.statusText.tweakUnitSize = size
    frame.statusText.tweakUnitOutline = outline
end

-- Helper function to iterate all visible raid/party frames
local function IterateAllFrames(callback)
    local count = 0

    -- Raid frames - the children ARE the individual player frames!
    local container = _G.CompactRaidFrameContainer
    if container and container:IsShown() then
        local frames = { container:GetChildren() }
        for _, frame in ipairs(frames) do
            if frame and frame:IsShown() and frame:GetObjectType() == "Button" then
                count = count + 1
                callback(frame)
            end
        end
    end

    -- Party frames
    for i = 1, 5 do
        local frame = _G["CompactPartyFrameMember"..i]
        if frame and frame:IsShown() then
            count = count + 1
            callback(frame)
        end
    end
end

-- Helper functions to apply changes to all frames (used by options panel)
function TweakUnit.RaidFrames:UpdateAllTextures()
    local textureName = TweakUnit.db.profile.raid.texture
    IterateAllFrames(function(frame)
        self:UpdateTexture(frame, textureName)
    end)
end

function TweakUnit.RaidFrames:UpdateAllNameFonts()
    IterateAllFrames(function(frame)
        self:UpdateNameFonts(frame)
    end)
end

function TweakUnit.RaidFrames:UpdateAllHealthFonts()
    IterateAllFrames(function(frame)
        self:UpdateHealthFonts(frame)
    end)
end

function TweakUnit.RaidFrames:UpdateAllHealthColors()
    IterateAllFrames(function(frame)
        self:UpdateHealthBarColor(frame)
    end)
end

function TweakUnit.RaidFrames:UpdateAllFades()
    IterateAllFrames(function(frame)
        self:UpdateRaidFade(frame)
    end)
end