local TweakUnit = LibStub("AceAddon-3.0"):GetAddon("TweakUnit")
local L = _G.TweakUnit_Locale
local LSM = LibStub("LibSharedMedia-3.0")

TweakUnit.Options_Raid = {
    type = "group",
    name = L["Raid"],
    childGroups = "tab",
    args = {
        -- Section Texture
        textureHeader = {
            type = "header",
            name = L["Texture"],
            order = 1
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
            get = function() return TweakUnit.db.profile.raid.texture end,
            set = function(_, v)
                TweakUnit.db.profile.raid.texture = v
                TweakUnit.RaidFrames:UpdateTexture(v)
            end,
        },
        
        -- Section Fade
        fadeHeader = {
            type = "header",
            name = L["Fade Options"],
            order = 10
        },
        fadeMinAlpha = {
            type = "range",
            name = L["Minimum Fade"],
            desc = L["Opacity for out of range raid members"],
            min = 0.1,
            max = 1,
            step = 0.05,
            isPercent = true,
            order = 11,
            get = function() 
                return TweakUnit.db.profile.raid.fade.minAlpha
            end,
            set = function(_, v)
                TweakUnit.db.profile.raid.fade.minAlpha = v
                TweakUnit.RaidFrames:UpdateRaidFade()
            end
        },
        fadeMaxAlpha = {
            type = "range",
            name = L["Maximum Fade"],
            desc = L["Opacity for in range raid members"],
            min = 0.1,
            max = 1,
            step = 0.05,
            isPercent = true,
            order = 12,
            get = function() 
                return TweakUnit.db.profile.raid.fade.maxAlpha
            end,
            set = function(_, v)
                TweakUnit.db.profile.raid.fade.maxAlpha = v
                TweakUnit.RaidFrames:UpdateRaidFade()
            end
        },
        
        -- Section Fonts
        fontsHeader = {
            type = "header",
            name = L["Fonts"],
            order = 20
        },
        
        -- Name Font Group
        nameFontGroup = {
            type = "group",
            name = L["Name Font"],
            inline = true,
            order = 21,
            args = {
                nameFont = {
                    type = "select",
                    name = L["Fonts"],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable("font"),
                    order = 1,
                    get = function() 
                        return TweakUnit.db.profile.raid.nameFont
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.nameFont = v
                        TweakUnit.RaidFrames:UpdateNameFonts()
                    end
                },
                nameFontSize = {
                    type = "range",
                    name = L["Size"],
                    min = 8,
                    max = 24,
                    step = 1,
                    order = 2,
                    get = function() 
                        return TweakUnit.db.profile.raid.nameFontSize or 12
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.nameFontSize = v
                        TweakUnit.RaidFrames:UpdateNameFonts()
                    end
                },
                nameFontOutline = {
                    type = "select",
                    name = L["Outline"],
                    values = {
                        NONE = L["None"],
                        OUTLINE = L["Thin"],
                        THICKOUTLINE = L["Thick"]
                    },
                    order = 3,
                    get = function() 
                        return TweakUnit.db.profile.raid.nameFontOutline or "NONE"
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.nameFontOutline = v
                        TweakUnit.RaidFrames:UpdateNameFonts()
                    end
                }
            }
        },
        
        -- Health Font Group
        healthFontGroup = {
            type = "group",
            name = L["Health Font"],
            inline = true,
            order = 22,
            args = {
                healthFont = {
                    type = "select",
                    name = L["Fonts"],
                    dialogControl = 'LSM30_Font',
                    values = LSM:HashTable("font"),
                    order = 1,
                    get = function() 
                        return TweakUnit.db.profile.raid.healthFont
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.healthFont = v
                        TweakUnit.RaidFrames:UpdateHealthFonts()
                    end
                },
                healthFontSize = {
                    type = "range",
                    name = L["Size"],
                    min = 6,
                    max = 50,
                    step = 1,
                    order = 2,
                    get = function() 
                        return TweakUnit.db.profile.raid.healthFontSize or 10
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.healthFontSize = v
                        TweakUnit.RaidFrames:UpdateHealthFonts()
                    end
                },
                healthFontOutline = {
                    type = "select",
                    name = L["Outline"],
                    values = {
                        NONE = L["None"],
                        OUTLINE = L["Thin"],
                        THICKOUTLINE = L["Thick"]
                    },
                    order = 3,
                    get = function() 
                        return TweakUnit.db.profile.raid.healthFontOutline or "NONE"
                    end,
                    set = function(_, v)
                        TweakUnit.db.profile.raid.healthFontOutline = v
                        TweakUnit.RaidFrames:UpdateHealthFonts()
                    end
                },
                healthFontColor = {
                    type = "color",
                    name = L["Text Color"],
                    hasAlpha = true,
                    order = 4,
                    get = function()
                        local c = TweakUnit.db.profile.raid.healthFontColor or {r=1, g=1, b=1, a=1}
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(_, r, g, b, a)
                        TweakUnit.db.profile.raid.healthFontColor = {r=r, g=g, b=b, a=a or 1}
                        TweakUnit.RaidFrames:UpdateHealthFonts()
                    end
                }
            }
        }
    }
}