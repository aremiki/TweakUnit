local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")

TweakUnit.UnitFrames = {}
TweakUnit.UnitFrames.__index = TweakUnit.UnitFrames

-- Helper function to update frame texture
local function UpdateUnitFrameTexture(frame, textureName)
    if not frame or not frame.healthbar then return end

    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or "UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Health"
    frame.healthbar:SetStatusBarTexture(texturePath)
end

-- Custom power bar colors by power type
local POWER_TYPE_COLORS = {
    [0] = {r = 0.039, g = 0.455, b = 0.949},  -- Mana #0A74F2 (Mage, Priest, Paladin, Warlock, Shaman, Druid, Evoker)
    [1] = {r = 1.000, g = 0.000, b = 0.000},  -- Rage (Warrior, Druid Bear/Cat)
    [2] = {r = 1.00, g = 0.50, b = 0.25},  -- Focus (Hunter)
    [3] = {r = 1.00, g = 0.96, b = 0.41},  -- Energy (Rogue, Monk, Druid Cat)
    [4] = {r = 0.00, g = 1.00, b = 1.00},  -- Combo Points (Rogue, Druid)
    [5] = {r = 0.227, g = 0.886, b = 1.000},  -- Runic Power #3AE2FF (Death Knight)
    [6] = {r = 0.227, g = 0.886, b = 1.000},  -- Runic Power alternate #3AE2FF (Death Knight)
    [8] = {r = 0.412, g = 0.133, b = 0.894},  -- Lunar Power (Druid Balance)
    [11] = {r = 0.55, g = 0.57, b = 0.61},  -- Maelstrom (Shaman Elemental/Enhancement)
    [12] = {r = 0.80, g = 0.40, b = 0.80},  -- Chi (Monk)
    [13] = {r = 0.26, g = 0.45, b = 0.90},  -- Insanity (Priest Shadow)
    [17] = {r = 0.58, g = 0.51, b = 0.79},  -- Fury (Demon Hunter)
    [18] = {r = 0.71, g = 0.28, b = 0.93},  -- Pain (Warlock Affliction)
    [19] = {r = 0.00, g = 0.50, b = 1.00},  -- Essence (Evoker)
}

-- Custom alternate power bar colors by bar type
local ALTERNATE_POWER_TYPE_COLORS = {
    [0] = {r = 0.039, g = 0.455, b = 0.949},  -- Mana #0A74F2 (Druid Balance, etc.)
}

-- Helper function to update power bar texture and color
local function UpdatePowerBarTexture(frame, textureName, unitToken)
    if not frame or not unitToken then return end

    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or TweakUnit.defaultTextures["Solid"]

    -- Get the power type and color
    local powerType, powerToken = UnitPowerType(unitToken)
    local powerColor = POWER_TYPE_COLORS[powerType]

    if not powerColor then
        -- Fallback to Blizzard default colors
        powerColor = PowerBarColor[powerToken] or PowerBarColor[powerType]
    end

    if frame.manabar then
        frame.manabar:SetStatusBarTexture(texturePath)
        if powerColor then
            frame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
        end
    end

    if frame.powerBar then
        frame.powerBar:SetStatusBarTexture(texturePath)
        if powerColor then
            frame.powerBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
        end
    end

    -- Update AlternatePowerBar (Druid Balance Mana, etc.)
    if frame == PlayerFrame and AlternatePowerBar and AlternatePowerBar:IsShown() then
        AlternatePowerBar:SetStatusBarTexture(texturePath)

        -- AlternatePowerBar is typically used for mana on specs with alternative primary resources
        -- (e.g., Druid Balance shows mana here while main bar shows Astral Power)
        -- Force mana color (#0A74F2)
        local manaColor = POWER_TYPE_COLORS[0] -- 0 = Mana
        if manaColor then
            AlternatePowerBar:SetStatusBarColor(manaColor.r, manaColor.g, manaColor.b)
        end
    end
end

function TweakUnit.UnitFrames:UpdatePlayerClassColor(enabled)
    if not PlayerFrame or not PlayerFrame.healthbar then return end

    -- Apply texture
    local textureName = TweakUnit.db.profile.player.texture or "Default Player"
    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or TweakUnit.defaultTextures["Default Player"]
    PlayerFrame.healthbar:SetStatusBarTexture(texturePath)

    if enabled then
        local _, class = UnitClass("player")
        if class then
            local color = RAID_CLASS_COLORS[class]
            if color then
                PlayerFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
            end
        end
    else
        -- Restore default green color
        PlayerFrame.healthbar:SetStatusBarColor(1, 1, 1)
    end
end

function TweakUnit.UnitFrames:UpdateTargetClassColor(enabled)
    if not TargetFrame or not TargetFrame.healthbar then return end

    if enabled then
        if UnitIsPlayer("target") then
            local _, class = UnitClass("target")
            if class then
                local color = RAID_CLASS_COLORS[class]
                if color then
                    TargetFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
                end
            end
        else
            -- Not a player, restore default color based on reaction
            local reaction = UnitReaction("target", "player")
            if reaction then
                local color = FACTION_BAR_COLORS[reaction]
                if color then
                    TargetFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
                end
            end
        end
    else
        -- Restore default color based on unit type
        local textureName = TweakUnit.db.profile.target.texture or "Default Player"

        if textureName == "Default Player" then
            TargetFrame.healthbar:SetStatusBarColor(1, 1, 1)
        else
            local reaction = UnitReaction("target", "player")
            if reaction then
                local color = FACTION_BAR_COLORS[reaction]
                if color then
                    TargetFrame.healthbar:SetStatusBarColor(color.r, color.g, color.b)
                end
            end
        end
    end
end

function TweakUnit.UnitFrames:UpdatePlayerTexture(textureName)
    UpdateUnitFrameTexture(PlayerFrame, textureName)
    -- Reapply class color if enabled
    local enabled = TweakUnit.db.profile.player.classColor
    TweakUnit.UnitFrames:UpdatePlayerClassColor(enabled)
end

function TweakUnit.UnitFrames:UpdateTargetTexture(textureName)
    UpdateUnitFrameTexture(TargetFrame, textureName)
    -- Reapply class color if enabled
    local enabled = TweakUnit.db.profile.target.classColor
    TweakUnit.UnitFrames:UpdateTargetClassColor(enabled)
end

function TweakUnit.UnitFrames:UpdatePlayerPowerTexture(textureName)
    UpdatePowerBarTexture(PlayerFrame, textureName, "player")
end

function TweakUnit.UnitFrames:UpdateTargetPowerTexture(textureName)
    UpdatePowerBarTexture(TargetFrame, textureName, "target")
end