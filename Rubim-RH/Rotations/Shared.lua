---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Rubim.
--- DateTime: 12/07/2018 07:01
---

local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;

local ProlongedPower = Item(142117)
local Healthstone = 5512

local trinket1 = 1030910
local trinket2 = 1030902

function trinketReady(trinketPosition)
    local inventoryPosition

    if trinketPosition == 1 then
        inventoryPosition = 13
    end
    if trinketPosition == 2 then
        inventoryPosition = 14
    end

    local start, duration, enable = GetInventoryItemCooldown("Player", inventoryPosition)

    if enable == 0 then
        return false
    end

    if start + duration - GetTime() > 0 then
        return false
    end
    return true
end

function RubimRH.Shared()
    if Item(Healthstone):IsReady() and Player:HealthPercentage() <= RubimRH.db.profile.mainOption.healthstoneper then
        return 0, 538745
    end

    if Target:Exists() and Target:MaxDistanceToPlayer(true) <= 8 then
        for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if RubimRH.db.profile.mainOption.useTrinkets[i] == 1 then
                if trinketReady(1) then
                    return trinket1
                end
            end

            if RubimRH.db.profile.mainOption.useTrinkets[i] == 2 then
                if trinketReady(2) then
                    return trinket1
                end
            end
        end
    end
end