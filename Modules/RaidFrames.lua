local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local LSM = LibStub("LibSharedMedia-3.0", true)

TweakUnit.RaidFrames = {}
TweakUnit.RaidFrames.__index = TweakUnit.RaidFrames

function TweakUnit.RaidFrames:UpdateTexture(textureName)
    local textures = TweakUnit:GetAvailableTextures()
    local texturePath = textures[textureName] or "Blizzard Raid Bar"

    local container = _G["CompactRaidFrameContainer"]
    if not container then return end

    -- Applique la texture à tous les frames de raid affichés
    local groups = { container:GetChildren() }
    for _, group in ipairs(groups) do
        local members = { group:GetChildren() }
        for _, member in ipairs(members) do
            if member and member.healthBar then
                member.healthBar:SetStatusBarTexture(texturePath)
            end
        end
    end

    -- Et aux frames de groupe (hors raid)
    for i = 1, 5 do
        local pf = _G["CompactPartyFrameMember"..i]
        if pf and pf.healthBar then
            pf.healthBar:SetStatusBarTexture(texturePath)
        end
    end
end

function TweakUnit.RaidFrames:UpdateRaidFade()
    if not IsInRaid() then return end

    local container = _G.CompactRaidFrameContainer
    if not container then return end
    
    for i = 1, container:GetNumChildren() do
        local frame = select(i, container:GetChildren())
        if frame and frame.healthBar and frame.unit and UnitExists(frame.unit) then
            local inRange, checkedRange = UnitInRange(frame.unit)
            local alpha = checkedRange and inRange and TweakUnit.db.profile.raid.fade.maxAlpha or TweakUnit.db.profile.raid.fade.minAlpha
            frame.healthBar:SetAlpha(alpha)
            if frame.healthBar.Background then
                frame.healthBar.Background:SetAlpha(alpha * 0.7)
            end
        end
    end
end

function TweakUnit.RaidFrames:UpdateNameFonts()
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

    -- RAID
    local raidContainer = _G.CompactRaidFrameContainer
    if raidContainer and raidContainer.GetChildren then
        for _, child in ipairs({ raidContainer:GetChildren() }) do
            ApplyToFrame(child)
        end
    end

    -- GROUPE
    for i = 1, 5 do
        local frame = _G["CompactPartyFrameMember"..i]
        if frame then
            ApplyToFrame(frame)
        end
    end
end


function TweakUnit.RaidFrames:UpdateHealthFonts()
    local font = LSM:Fetch("font", TweakUnit.db.profile.raid.healthFont or "Friz Quadrata TT")
    local size = TweakUnit.db.profile.raid.healthFontSize or 10
    local outline = TweakUnit.db.profile.raid.healthFontOutline or "OUTLINE"

    local function SetFontSafe(fontString)
        if fontString and fontString.SetFont then
            fontString:SetFont(font, size, outline)
            fontString:SetTextColor(TweakUnit.db.profile.raid.healthFontColor.r, TweakUnit.db.profile.raid.healthFontColor.g, TweakUnit.db.profile.raid.healthFontColor.b, TweakUnit.db.profile.raid.healthFontColor.a)
            fontString:SetShadowColor(0, 0, 0, 1)
            fontString:SetShadowOffset(1, -1)
        end
    end

    local function ApplyToFrame(frame)
        if not frame or not frame.unit then return end

        -- Health text
        if frame.statusText then
            SetFontSafe(frame.statusText)
        end
    end

    -- RAID
    local raidContainer = _G.CompactRaidFrameContainer
    if raidContainer and raidContainer.GetChildren then
        for _, child in ipairs({ raidContainer:GetChildren() }) do
            ApplyToFrame(child)
        end
    end

    -- GROUPE
    for i = 1, 5 do
        local frame = _G["CompactPartyFrameMember"..i]
        if frame then
            ApplyToFrame(frame)
        end
    end
end