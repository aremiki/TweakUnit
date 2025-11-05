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

function TweakUnit.UnitFrames:UpdatePlayerClassColor(enabled)
    if not PlayerFrame or not PlayerFrame.healthbar then return end

    -- Apply texture
    local textureName = TweakUnit.db.profile.player.texture or "Blizzard"
    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or TweakUnit.defaultTextures["Blizzard"]
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
        if UnitIsPlayer("target") then
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