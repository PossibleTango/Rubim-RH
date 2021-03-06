--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet = Unit.Pet
local Spell = HL.Spell
local Item = HL.Item

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

-- Spells
RubimRH.Spell[103] = {
    Regrowth = Spell(8936),
    BloodtalonsBuff = Spell(145152),
    Bloodtalons = Spell(155672),
    CatFormBuff = Spell(768),
    CatForm = Spell(768),
    ProwlBuff = Spell(5215),
    Prowl = Spell(5215),
    IncarnationBuff = Spell(102543),
    JungleStalkerBuff = Spell(252071),
    Berserk = Spell(106951),
    TigersFury = Spell(5217),
    TigersFuryBuff = Spell(5217),
    Berserking = Spell(26297),
    FeralFrenzy = Spell(274837),
    Incarnation = Spell(102543),
    BerserkBuff = Spell(106951),
    Shadowmeld = Spell(58984),
    Rake = Spell(1822),
    RakeDebuff = Spell(155722),
    ShadowmeldBuff = Spell(58984),
    FerociousBite = Spell(22568),
    PredatorySwiftnessBuff = Spell(69369),
    RipDebuff = Spell(1079),
    ApexPredatorBuff = Spell(252752),
    MomentofClarity = Spell(236068),
    SavageRoar = Spell(52610),
    SavageRoarBuff = Spell(52610),
    Rip = Spell(1079),
    FerociousBiteMaxEnergy = Spell(22568),
    BrutalSlash = Spell(202028),
    ThrashCat = Spell(106830),
    ThrashCatDebuff = Spell(106830),
    MoonfireCat = Spell(155625),
    ClearcastingBuff = Spell(135700),
    SwipeCat = Spell(106785),
    Shred = Spell(5221),
    LunarInspiration = Spell(155580),
    MoonfireCatDebuff = Spell(155625),
    Sabertooth = Spell(202031)
};
local S = RubimRH.Spell[103];

-- Items
if not Item.Druid then
    Item.Druid = {}
end
Item.Druid.Feral = {
    LuffaWrappings = Item(137056),
    OldWar = Item(127844),
    AiluroPouncers = Item(137024)
};
local I = Item.Druid.Feral;


-- Variables
local VarUseThrash = 0;

local EnemyRanges = { 8 }
local function UpdateRanges()
    for _, i in ipairs(EnemyRanges) do
        HL.GetEnemies(i);
    end
end

local function num(val)
    if val then
        return 1
    else
        return 0
    end
end

local function bool(val)
    return val ~= 0
end

S.FerociousBiteMaxEnergy.CustomCost = {
    [3] = function()
        if Player:BuffP(S.ApexPredatorBuff) then
            return 0
        elseif (Player:BuffP(S.IncarnationBuff) or Player:BuffP(S.BerserkBuff)) then
            return 25
        else
            return 50
        end
    end
}

S.Rip:RegisterPMultiplier({ S.BloodtalonsBuff, 1.2 }, { S.SavageRoar, 1.15 }, { S.TigersFury, 1.15 })
S.Rake:RegisterPMultiplier(
        S.RakeDebuff,
        { function()
            return Player:IsStealthed(true, true) and 2 or 1;
        end },
        { S.BloodtalonsBuff, 1.2 }, { S.SavageRoar, 1.15 }, { S.TigersFury, 1.15 }
)

local OffensiveCDs = {
    S.Incarnation,
    S.Berserk,
}

local function UpdateCDs()
    RubimRH.db.profile.mainOption.disabledSpellsCD = {}
    if RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if not spell:IsEnabledCD() then
                RubimRH.delSpellDisabledCD(spell:ID())
            end
        end

    end
    if not RubimRH.CDsON() then
        for i, spell in pairs(OffensiveCDs) do
            if spell:IsEnabledCD() then
                RubimRH.addSpellDisabledCD(spell:ID())
            end
        end
    end
end

--- ======= ACTION LISTS =======
local function APL()
    local Precombat, Cooldowns, SingleTarget, StFinishers, StGenerators
    UpdateRanges()
    UpdateCDs()
    Precombat = function()
        -- flask
        -- food
        -- augmentation
        -- regrowth,if=talent.bloodtalons.enabled
        if S.Regrowth:IsReady() and (S.Bloodtalons:IsAvailable()) and Player:BuffDown(S.BloodtalonsBuff) then
            return S.Regrowth:Cast()
        end
        -- variable,name=use_thrash,value=0
        if (true) then
            VarUseThrash = 0
        end
        -- variable,name=use_thrash,value=1,if=equipped.luffa_wrappings
        if (I.LuffaWrappings:IsEquipped()) then
            VarUseThrash = 1
        end
        -- cat_form
        if S.CatForm:IsReady() and (not Player:Buff(S.CatFormBuff)) and (true) then
            return S.CatForm:Cast()
        end
        -- prowl
        if S.Prowl:IsReady() and Player:BuffDownP(S.ProwlBuff) and (true) then
            return S.Prowl:Cast()
        end
        -- snapshot_stats
        -- potion
    end
    Cooldowns = function()
        -- dash,if=!buff.cat_form.up
        -- prowl,if=buff.incarnation.remains<0.5&buff.jungle_stalker.up
        if S.Prowl:IsReady() and (Player:BuffRemains(S.IncarnationBuff) < 0.5 and Player:Buff(S.JungleStalkerBuff)) then
            return S.Prowl:Cast()
        end
        -- berserk,if=energy>=30&(cooldown.tigers_fury.remains>5|buff.tigers_fury.up)
        if S.Berserk:IsReady() and RubimRH.CDsON() and (Player:Energy() >= 30 and (S.TigersFury:CooldownRemains() > 5 or Player:Buff(S.TigersFuryBuff))) then
            return S.Berserk:Cast()
        end
        -- tigers_fury,if=energy.deficit>=60
        if S.TigersFury:IsReady() and (Player:EnergyDeficit() >= 60) then
            return S.TigersFury:Cast()
        end
        -- berserking
        if S.Berserking:IsReady() and RubimRH.CDsON() and (true) then
            return S.Berserking:Cast()
        end
        -- feral_frenzy,if=combo_points=0
        if S.FeralFrenzy:IsReady() and (Player:ComboPoints() == 0) then
            return S.FeralFrenzy:Cast()
        end
        -- incarnation,if=energy>=30&(cooldown.tigers_fury.remains>15|buff.tigers_fury.up)
        if S.Incarnation:IsReady() and RubimRH.CDsON() and (Player:Energy() >= 30 and (S.TigersFury:CooldownRemains() > 15 or Player:Buff(S.TigersFuryBuff))) then
            return S.Incarnation:Cast()
        end
        -- potion,name=prolonged_power,if=target.time_to_die<65|(time_to_die<180&(buff.berserk.up|buff.incarnation.up))
        -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
        if S.Shadowmeld:IsReady() and (Player:ComboPoints() < 5 and Player:Energy() >= S.Rake:Cost() and Target:PMultiplier(S.Rake) < 2.1 and Player:Buff(S.TigersFuryBuff) and (Player:Buff(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable()) and (not S.Incarnation:IsAvailable() or S.Incarnation:CooldownRemains() > 18) and not Player:Buff(S.IncarnationBuff)) then
            return S.Shadowmeld:Cast()
        end
        -- use_items
    end
    SingleTarget = function()
        -- cat_form,if=!buff.cat_form.up
        if S.CatForm:IsReady() and (not Player:Buff(S.CatFormBuff)) then
            return S.CatForm:Cast()
        end
        -- rake,if=buff.prowl.up|buff.shadowmeld.up
        if S.Rake:IsReady() and (Player:Buff(S.ProwlBuff) or Player:Buff(S.ShadowmeldBuff)) then
            return S.Rake:Cast()
        end
        -- auto_attack
        -- call_action_list,name=cooldowns
        if (true) then
            if Cooldowns() ~= nil then
                return Cooldowns()
            end
        end
        -- ferocious_bite,target_if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>10&(target.health.pct<25|talent.sabertooth.enabled)
        if S.FerociousBite:IsReady() and (Target:DebuffP(S.RipDebuff) and Target:DebuffRemainsP(S.RipDebuff) < 3 and Target:TimeToDie() > 10 and (Target:HealthPercentage() < 25 or S.Sabertooth:IsAvailable())) then
            return S.FerociousBite:Cast()
        end
        -- regrowth,if=combo_points=5&buff.predatory_swiftness.up&talent.bloodtalons.enabled&buff.bloodtalons.down&(!buff.incarnation.up|dot.rip.remains<8)
        if S.Regrowth:IsReady() and (Player:ComboPoints() == 5 and Player:Buff(S.PredatorySwiftnessBuff) and S.Bloodtalons:IsAvailable() and Player:BuffDown(S.BloodtalonsBuff) and (not Player:Buff(S.IncarnationBuff) or Target:DebuffRemains(S.RipDebuff) < 8)) then
            return S.Regrowth:Cast()
        end
        -- regrowth,if=combo_points>3&talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.apex_predator.up&buff.incarnation.down
        if S.Regrowth:IsReady() and (Player:ComboPoints() > 3 and S.Bloodtalons:IsAvailable() and Player:Buff(S.PredatorySwiftnessBuff) and Player:Buff(S.ApexPredatorBuff) and Player:BuffDown(S.IncarnationBuff)) then
            return S.Regrowth:Cast()
        end
        -- ferocious_bite,if=buff.apex_predator.up&((combo_points>4&(buff.incarnation.up|talent.moment_of_clarity.enabled))|(talent.bloodtalons.enabled&buff.bloodtalons.up&combo_points>3))
        if S.FerociousBite:IsReady() and (Player:Buff(S.ApexPredatorBuff) and ((Player:ComboPoints() > 4 and (Player:Buff(S.IncarnationBuff) or S.MomentofClarity:IsAvailable())) or (S.Bloodtalons:IsAvailable() and Player:Buff(S.BloodtalonsBuff) and Player:ComboPoints() > 3))) then
            return S.FerociousBite:Cast()
        end
        -- run_action_list,name=st_finishers,if=combo_points>4
        if (Player:ComboPoints() > 4) then
            return StFinishers();
        end
        -- run_action_list,name=st_generators
        if (true) then
            return StGenerators();
        end
    end
    StFinishers = function()
        -- pool_resource,for_next=1
        -- savage_roar,if=buff.savage_roar.down
        if S.SavageRoar:IsReady() and (Player:BuffDown(S.SavageRoarBuff)) then
            if S.SavageRoar:IsUsable() then
                return S.SavageRoar:Cast()
            else
                S.SavageRoar:Cast()
                return 0, 135328
            end
        end
        -- pool_resource,for_next=1
        -- rip,target_if=!ticking|(remains<=duration*0.3)&(target.health.pct>25&!talent.sabertooth.enabled)|(remains<=duration*0.8&persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die>8
        if S.Rip:IsCastableP() and (not Target:DebuffP(S.RipDebuff) or (Target:DebuffRemainsP(S.RipDebuff) <= S.RipDebuff:BaseDuration() * 0.3) and (Target:HealthPercentage() > 25 and not S.Sabertooth:IsAvailable()) or (Target:DebuffRemainsP(S.RipDebuff) <= S.RipDebuff:BaseDuration() * 0.8 and Player:PMultiplier(S.Rip) > Target:PMultiplier(S.Rip)) and Target:TimeToDie() > 8) then
            if S.Rip:IsReady() then
                return S.Rip:Cast()
            else
                S.Rip:Queue()
                return 0, 135328
            end
        end
        -- pool_resource,for_next=1
        -- savage_roar,if=buff.savage_roar.remains<12
        if S.SavageRoar:IsReady() and (Player:BuffRemains(S.SavageRoarBuff) < 12) then
            if S.SavageRoar:IsUsable() then
                return S.SavageRoar:Cast()
            else
                S.SavageRoar:Queue()
                return 0, 135328
            end
        end
        -- ferocious_bite,max_energy=1
        if S.FerociousBiteMaxEnergy:IsReady() and S.FerociousBiteMaxEnergy:IsUsableP() and (true) then
            return S.FerociousBite:Cast()
        end

        return 0, 135328
    end
    StGenerators = function()
        -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&combo_points=4&dot.rake.remains<4
        if S.Regrowth:IsReady() and (S.Bloodtalons:IsAvailable() and Player:Buff(S.PredatorySwiftnessBuff) and Player:BuffDown(S.BloodtalonsBuff) and Player:ComboPoints() == 4 and Target:DebuffRemains(S.RakeDebuff) < 4) then
            return S.Regrowth:Cast()
        end
        -- regrowth,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&(buff.predatory_swiftness.stack>2|(buff.predatory_swiftness.stack>1&dot.rake.remains<3))&buff.bloodtalons.down
        if S.Regrowth:IsReady() and (I.AiluroPouncers:IsEquipped() and S.Bloodtalons:IsAvailable() and (Player:BuffStack(S.PredatorySwiftnessBuff) > 2 or (Player:BuffStack(S.PredatorySwiftnessBuff) > 1 and Target:DebuffRemains(S.RakeDebuff) < 3)) and Player:BuffDown(S.BloodtalonsBuff)) then
            return S.Regrowth:Cast()
        end
        -- brutal_slash,if=spell_targets.brutal_slash>desired_targets
        if S.BrutalSlash:IsReady() and (Cache.EnemiesCount[8] > 1) then
            return S.BrutalSlash:Cast()
        end
        -- pool_resource,for_next=1
        -- thrash_cat,if=refreshable&(spell_targets.thrash_cat>2)
        if S.ThrashCat:IsReadyMorph() and (Target:DebuffRefreshableC(S.ThrashCatDebuff) and (Cache.EnemiesCount[8] > 2)) then
            if S.ThrashCat:IsUsable() then
                return S.ThrashCat:Cast()
            else
                S.ThrashCat:Queue()
                return 0, 135328
            end
        end
        -- pool_resource,for_next=1
        -- thrash_cat,if=spell_targets.thrash_cat>3&equipped.luffa_wrappings&talent.brutal_slash.enabled
        if S.ThrashCat:IsReadyMorph() and (Cache.EnemiesCount[8] > 3 and I.LuffaWrappings:IsEquipped() and S.BrutalSlash:IsAvailable()) then
            if S.ThrashCat:IsUsable() then
                return S.ThrashCat:Cast()
            else
                S.ThrashCat:Queue()
                return 0, 135328
            end
        end
        -- pool_resource,for_next=1
        -- rake,target_if=!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)&target.time_to_die>4
        if S.Rake:IsReady() and (not Target:DebuffP(S.RakeDebuff) or (not S.Bloodtalons:IsAvailable() and Target:DebuffRemainsP(S.RakeDebuff) < S.RakeDebuff:BaseDuration() * 0.3) and Target:TimeToDie() > 4) then
            if S.Rake:IsUsable() then
                return S.Rake:Cast()
            else
                S.Rake:Queue()
                return 0, 135328
            end
        end
        -- pool_resource,for_next=1
        -- rake,target_if=talent.bloodtalons.enabled&buff.bloodtalons.up&((remains<=7)&persistent_multiplier>dot.rake.pmultiplier*0.85)&target.time_to_die>4
        if S.Rake:IsReady() and  (S.Bloodtalons:IsAvailable() and Player:BuffP(S.BloodtalonsBuff) and ((Target:DebuffRemainsP(S.RakeDebuff) <= 7) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake) * 0.85) and Target:TimeToDie() > 4) then
            if S.Rake:IsUsable() then
                return S.Rake:Cast()
            else
                S.Rake:Queue()
                return 0, 135328
            end
        end
        -- brutal_slash,if=(buff.tigers_fury.up&(raid_event.adds.in>(1+max_charges-charges_fractional)*recharge_time))
        if S.BrutalSlash:IsReady() and ((Player:Buff(S.TigersFuryBuff) and (10000000000 > (1 + S.BrutalSlash:MaxCharges() - S.BrutalSlash:ChargesFractional()) * S.BrutalSlash:Recharge()))) then
            return S.BrutalSlash:Cast()
        end
        -- moonfire_cat,target_if=refreshable
        if S.MoonfireCat:IsReadyMorph() and (Target:DebuffRefreshableCP(S.MoonfireCatDebuff)) then
            return S.MoonfireCat:Cast()
        end
        -- pool_resource,for_next=1
        -- thrash_cat,if=refreshable&(variable.use_thrash=2|spell_targets.thrash_cat>1)
        if S.ThrashCat:IsReadyMorph() and (Target:DebuffRefreshableC(S.ThrashCatDebuff) and (VarUseThrash == 2 or Cache.EnemiesCount[8] > 1)) then
            if S.ThrashCat:IsUsable() then
                return S.ThrashCat:Cast()
            else
                S.ThrashCat:Queue()
                return 0, 135328
            end
        end
        -- thrash_cat,if=refreshable&variable.use_thrash=1&buff.clearcasting.react
        if S.ThrashCat:IsReadyMorph() and (Target:DebuffRefreshableC(S.ThrashCatDebuff) and VarUseThrash == 1 and Player:Buff(S.ClearcastingBuff)) then
            return S.ThrashCat:Cast()
        end
        -- pool_resource,for_next=1
        -- swipe_cat,if=spell_targets.swipe_cat>1
        if S.SwipeCat:IsReadyMorph() and (Cache.EnemiesCount[8] > 1) then
            if S.SwipeCat:IsUsable() then
                return S.SwipeCat:Cast()
            else
                S.SwipeCat:Cast()
                return 0, 135328
            end
        end
        -- shred,if=dot.rake.remains>(action.shred.cost+action.rake.cost-energy)%energy.regen|buff.clearcasting.react
        if S.Shred:IsReady() and (Target:DebuffRemains(S.RakeDebuff) > (S.Shred:Cost() + S.Rake:Cost() - Player:Energy()) / Player:EnergyRegen() or Player:Buff(S.ClearcastingBuff)) then
            return S.Shred:Cast()
        end
        return 0, 135328
    end
    -- stuff
    if Player:IsCasting() and Player:CastRemains() >= ((select(4, GetNetStats()) / 1000) * 2) then
        return 0, "Interface\\Addons\\Rubim-RH\\Media\\channel.tga"
    end

    -- call precombat
    if not Player:AffectingCombat() then
        if Precombat() ~= nil then
            return Precombat()
        end
        return 0, 462338
    end
    -- run_action_list,name=single_target,if=dot.rip.ticking|time>15
    if (Target:Debuff(S.RipDebuff) or HL.CombatTime() > 15) then
        return SingleTarget();
    end
    -- rake,if=!ticking|buff.prowl.up
    if S.Rake:IsReady() and (not Target:Debuff(S.RakeDebuff) or Player:Buff(S.ProwlBuff)) then
        return S.Rake:Cast()
    end
    -- dash,if=!buff.cat_form.up
    -- auto_attack
    -- moonfire_cat,if=talent.lunar_inspiration.enabled&!ticking
    if S.MoonfireCat:IsReadyMorph() and (S.LunarInspiration:IsAvailable() and not Target:Debuff(S.MoonfireCatDebuff)) then
        return S.MoonfireCat:Cast()
    end
    -- savage_roar,if=!buff.savage_roar.up
    if S.SavageRoar:IsReady() and (not Player:Buff(S.SavageRoarBuff)) then
        return S.SavageRoar:Cast()
    end
    -- berserk
    if S.Berserk:IsReady() and RubimRH.CDsON() and (true) then
        return S.Berserk:Cast()
    end
    -- incarnation
    if S.Incarnation:IsReady() and RubimRH.CDsON() and (true) then
        return S.Incarnation:Cast()
    end
    -- tigers_fury
    if S.TigersFury:IsReady() and (true) then
        return S.TigersFury:Cast()
    end
    -- regrowth,if=(talent.sabertooth.enabled|buff.predatory_swiftness.up)&talent.bloodtalons.enabled&buff.bloodtalons.down&combo_points=5
    if S.Regrowth:IsReady() and ((S.Sabertooth:IsAvailable() or Player:Buff(S.PredatorySwiftnessBuff)) and S.Bloodtalons:IsAvailable() and Player:BuffDown(S.BloodtalonsBuff) and Player:ComboPoints() == 5) then
        return S.Regrowth:Cast()
    end
    -- rip,if=combo_points=5
    if S.Rip:IsReady() and (Player:ComboPoints() == 5) then
        return S.Rip:Cast()
    end
    -- thrash_cat,if=!ticking&variable.use_thrash>0
    if S.ThrashCat:IsReadyMorph() and (not Target:Debuff(S.ThrashCatDebuff) and VarUseThrash > 0) then
        return S.ThrashCat:Cast()
    end
    -- shred
    if S.Shred:IsReady() and (true) then
        return S.Shred:Cast()
    end
    return 0, 135328
end

RubimRH.Rotation.SetAPL(103, APL)

local function PASSIVE()
    return RubimRH.Shared()
end
RubimRH.Rotation.SetPASSIVE(103, PASSIVE)