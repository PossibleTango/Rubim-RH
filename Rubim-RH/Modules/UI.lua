local HL = HeroLib;
local Cache = HeroCache;
local StdUi = LibStub('StdUi')
local AceGUI = LibStub("AceGUI-3.0")

testTable = {}
function RubimRH.SpellBlocker(spellID, point, relativeTo, relativePoint, xOfs, yOfs)
    if spellID ~= nil then
        if RubimRH.db.profile.mainOption.disabledSpells[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.disabledSpells, { text = GetSpellInfo(spellID), value = spellID })
            print("Added: " .. GetSpellInfo(spellID))
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.disabledSpells do
                if RubimRH.db.profile.mainOption.disabledSpells[i].value == spellID then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.disabledSpells, duplicatedNumber)
                print("Removed: " .. GetSpellInfo(spellID))
            else
                table.insert(RubimRH.db.profile.mainOption.disabledSpells, { text = GetSpellInfo(spellID), value = spellID })
                print("Added: " .. GetSpellInfo(spellID))
            end
        end
        return
    end

    local currentSpellsNum = {}
    local numCount = 1
    local currentSpells = {}
    local disabledSpells = {}

    for _, Spell in pairs(RubimRH.allSpells) do
        if GetSpellInfo(Spell:ID()) ~= nil then
            table.insert(currentSpells, { text = "|cFF00FF00" .. GetSpellInfo(Spell:ID()) .. "|r", value = Spell:ID(), enabled = false })
            numCount = numCount + 1
            --table.insert(currentSpellsNum, Spell:ID())
        end
    end

    for i, v in pairs(currentSpells) do
        for i, p in pairs(RubimRH.db.profile.mainOption.disabledSpells) do
            if v.value == p.value then
                v.text = "|cFFFF0000" .. GetSpellInfo(v.value) .. "|r"
                --spellList:SetValue(v.value, "|cFFFF0000" .. v.text .. "|r")
            end
        end
    end

    local window = StdUi:Window(UIParent, 'Spell Blocker', 300, 200);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local general = StdUi:FontString(window, 'Spells List');
    StdUi:GlueTop(general, window, 0, -40);
    local generalSep = StdUi:FontString(window, '============');
    StdUi:GlueTop(generalSep, general, 0, -12);

    if #RubimRH.db.profile.mainOption.disabledSpells > 0 then
        disabledSpells = RubimRH.db.profile.mainOption.disabledSpells
    end

    -- multi select dropdown
    local spellList = StdUi:Dropdown(window, 200, 20, currentSpells, nil, nil);
    spellList:SetPlaceholder('-- Spell List --');
    StdUi:GlueBelow(spellList, generalSep, 0, -20);
    spellList.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.disabledSpells[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.disabledSpells, { text = GetSpellInfo(val), value = val })
            print("Added: " .. GetSpellInfo(val))
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.disabledSpells do
                if RubimRH.db.profile.mainOption.disabledSpells[i].value == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.disabledSpells, duplicatedNumber)
                print("Removed: " .. GetSpellInfo(val))
            else
                table.insert(RubimRH.db.profile.mainOption.disabledSpells, { text = GetSpellInfo(val), value = val })
                print("Added: " .. GetSpellInfo(val))
            end
        end
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        RubimRH.SpellBlocker(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local extra1 = StdUi:Button(window, 100, 20, 'Clear');
    StdUi:GlueBelow(extra1, spellList, 0, -24, 'CENTER');
    extra1:SetScript('OnClick', function()
        print("RubimRH: Disabled spells cleared.")
        RubimRH.db.profile.mainOption.disabledSpells = {}
    end);
end

local function AllMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1 = RubimRH.db.profile[RubimRH.playerSpec].sk1 or -1
    local sk1id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk1id) or "") .. ": "
    local sk1tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk1tooltip or ""

    local sk2 = RubimRH.db.profile[RubimRH.playerSpec].sk2 or -1
    local sk2id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk2id) or "") .. ": "
    local sk2tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk2tooltip or ""

    local sk3 = RubimRH.db.profile[RubimRH.playerSpec].sk3 or -1
    local sk3id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk3id) or "") .. ": "
    local sk3tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk3tooltip or ""

    local sk4 = RubimRH.db.profile[RubimRH.playerSpec].sk4 or -1
    local sk4id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk4id) or "") .. ": "
    local sk4tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk4tooltip or ""

    local sk5 = RubimRH.db.profile[RubimRH.playerSpec].sk5 or -1
    local sk5id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk5id) or "") .. ": "
    local sk5tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk5tooltip or ""

    local sk6 = RubimRH.db.profile[RubimRH.playerSpec].sk6 or -1
    local sk6id = (GetSpellInfo(RubimRH.db.profile[RubimRH.playerSpec].sk6id) or "") .. ": "
    local sk6tooltip = RubimRH.db.profile[RubimRH.playerSpec].sk6tooltip or ""


    local windowHeight = 380
    local extraPosition = -280
    if sk3 >= 0 then
        windowHeight = 428
        extraPosition = -328
    end
    if sk6 >= 0 then
        windowHeight = 456
        extraPosition = -368
    end




    local window = StdUi:Window(UIParent, select(2, UnitClass("player")) .. " - " .. select(2, GetSpecializationInfo(GetSpecialization())), 350, windowHeight);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        AllMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        AllMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0
    if sk1 >= 0 then
        sk_1_0 = StdUi:Slider(window, 100, 16, sk1 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
        local sk_1_0Label = StdUi:FontString(window, sk1id .. sk1);
        StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
        StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_1_0:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk1 = value
            sk1 = value
            sk_1_0Label:SetText(sk1id .. sk1)
        end
    end

    local sk_1_1
    if sk2 >= 0 then
        sk_1_1 = StdUi:Slider(window, 100, 16, sk2 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
        local sk_1_1Label = StdUi:FontString(window, sk2id .. sk2);
        StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
        StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_1_1:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk2 = value
            sk2 = value
            sk_1_1Label:SetText(sk2id .. sk2)
        end
    end

    local sk_2_0
    if sk3 >= 0 then
        sk_2_0 = StdUi:Slider(window, 100, 16, sk3 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
        local sk_2_0Label = StdUi:FontString(window, sk3id .. sk3);
        StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
        StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_2_0:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk3 = value
            sk3 = value
            sk_2_0Label:SetText(sk3id .. sk3)
        end
    end

    local sk_2_1
    if sk4 >= 0 then
        sk_2_1 = StdUi:Slider(window, 100, 16, sk4 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
        local sk_2_1Label = StdUi:FontString(window, sk4id .. sk4);
        StdUi:GlueTop(sk_2_1Label, sk_2_1, 0, 16);
        StdUi:FrameTooltip(sk_2_1, sk4tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_2_1:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk4 = value
            sk4 = value
            sk_2_1Label:SetText(sk4id .. sk4)
        end

    end

    if sk5 >= 0 then
        local sk_3_0 = StdUi:Slider(window, 100, 16, sk5 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_3_0, sk_2_0, 0, -24, 'LEFT');
        local sk_3_0Label = StdUi:FontString(window, sk5id .. sk5);
        StdUi:GlueTop(sk_3_0Label, sk_3_0, 0, 16);
        StdUi:FrameTooltip(sk_3_0, sk5tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_3_0:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk5 = value
            sk5 = value
            sk_3_0Label:SetText(sk5id .. sk5)
        end
    end

    if sk6 >= 0 then
        local sk_3_1 = StdUi:Slider(window, 100, 16, sk6 / 5, false, 0, 19)
        StdUi:GlueBelow(sk_3_1, sk_2_1, 0, -24, 'RIGHT');
        local sk_3_1Label = StdUi:FontString(window, sk6id .. sk6);
        StdUi:GlueTop(sk_3_1Label, sk_3_1, 0, 16);
        StdUi:FrameTooltip(sk_3_1, sk6tooltip, 'TOPLEFT', 'TOPRIGHT', true);
        function sk_3_1:OnValueChanged(value)
            local value = math.floor(value) * 5
            RubimRH.db.profile[RubimRH.playerSpec].sk6 = value
            sk6 = value
            sk_3_1Label:SetText(sk6id .. sk6)
        end
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, extraPosition);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);

end

local function BloodMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].icebound
    local sk1text = "Icebound: "
    local sk1tooltip = "HP Percent to use Icebound Fortitude."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].runetap
    local sk2text = "Runetap: "
    local sk2tooltip = "HP Percent to use Runetap."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].vampiricblood
    local sk3text = "Vamp Blood: "
    local sk3tooltip = "HP Percent to use Vampiric Blood."

    local sk4var = RubimRH.db.profile[RubimRH.playerSpec].drw
    local sk4text = "DRW: "
    local sk4tooltip = "HP Percent to use Dancing Rune Weapon."

    local sk5var = RubimRH.db.profile[RubimRH.playerSpec].smartds
    local sk5text = "Inc DmG DS: "
    local sk5tooltip = "How much (percent wise) of inc dmg that we should use DS to heal back."

    local sk6var = RubimRH.db.profile[RubimRH.playerSpec].deficitds
    local sk6text = "Deficit RP: "
    local sk6tooltip = "How much deficit of Runic Power (MaxRP - CurrentRP) so we can start to use Death Strike./nValue of 20 means usually at 130RP."

    local window = StdUi:Window(UIParent, 'Death Knight - Blood', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        BloodMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        BloodMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].icebound = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end

    local sk_1_1 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].runetap = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk3var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk3text .. sk3var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].vampiricblood = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local sk_2_1 = StdUi:Slider(window, 100, 16, sk4var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
    local sk_2_1Label = StdUi:FontString(window, sk4text .. sk4var);
    StdUi:GlueTop(sk_2_1Label, sk_2_1, 0, 16);
    StdUi:FrameTooltip(sk_2_1, sk4tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].drw = value
        sk4var = value
        sk_2_1Label:SetText(sk4text .. sk4var)
    end

    local sk_3_0 = StdUi:Slider(window, 100, 16, sk5var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_3_0, sk_2_0, 0, -24, 'LEFT');
    local sk_3_0Label = StdUi:FontString(window, sk5text .. sk5var);
    StdUi:GlueTop(sk_3_0Label, sk_3_0, 0, 16);
    StdUi:FrameTooltip(sk_3_0, sk5tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_3_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].smartds = value
        sk5var = value
        sk_3_0Label:SetText(sk5text .. sk5var)
    end

    local sk_3_1 = StdUi:Slider(window, 100, 16, sk6var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_3_1, sk_2_1, 0, -24, 'RIGHT');
    local sk_3_1Label = StdUi:FontString(window, sk6text .. sk6var);
    StdUi:GlueTop(sk_3_1Label, sk_3_1, 0, 16);
    StdUi:FrameTooltip(sk_3_1, sk6tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_3_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deficitds = value
        sk6var = value
        sk_3_1Label:SetText(sk6text .. sk6var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -410);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);

end

local function FrostMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].icebound
    local sk1text = "Icebound: "
    local sk1tooltip = "HP Percent to use Icebound Fortitude."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].deathstrike
    local sk2text = "Death Strike (Proc): "
    local sk2tooltip = "HP Percent to use Death Stike with Dark Succur."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].deathstrikeper
    local sk3text = "Death Strike: "
    local sk3tooltip = "HP Percent to use Death Strike."

    local sk4var = RubimRH.db.profile[RubimRH.playerSpec].deathpact
    local sk4text = "Death Pact: "
    local sk4tooltip = "HP Percent to use Death Pact."

    local window = StdUi:Window(UIParent, 'Death Knight - Frost', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FrostMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FrostMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].icebound = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end

    local sk_1_1 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathstrike = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk3var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk3text .. sk3var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathstrikeper = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local sk_2_1 = StdUi:Slider(window, 100, 16, sk4var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
    local sk_2_1Label = StdUi:FontString(window, sk4text .. sk4var);
    StdUi:GlueTop(sk_2_1Label, sk_2_1, 0, 16);
    StdUi:FrameTooltip(sk_2_1, sk4tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathpact = value
        sk4var = value
        sk_2_1Label:SetText(sk4text .. sk4var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -310);
    local extraSep = StdUi:FontString(window, '===================');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -50, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function UnholyMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].icebound
    local sk1text = "Icebound: "
    local sk1tooltip = "HP Percent to use Icebound Fortitude."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].deathstrike
    local sk2text = "Death Strike (Proc): "
    local sk2tooltip = "HP Percent to use Death Stike with Dark Succur."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].deathstrikeper
    local sk3text = "Death Strike: "
    local sk3tooltip = "HP Percent to use Death Strike."

    local sk4var = RubimRH.db.profile[RubimRH.playerSpec].deathpact
    local sk4text = "Death Pact: "
    local sk4tooltip = "HP Percent to use Death Pact."

    local window = StdUi:Window(UIParent, 'Death Knight - Unholy', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        UnholyMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        UnholyMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].icebound = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end

    local sk_1_1 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathstrike = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk3var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk3text .. sk3var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathstrikeper = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local sk_2_1 = StdUi:Slider(window, 100, 16, sk4var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
    local sk_2_1Label = StdUi:FontString(window, sk4text .. sk4var);
    StdUi:GlueTop(sk_2_1Label, sk_2_1, 0, 16);
    StdUi:FrameTooltip(sk_2_1, sk4tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].deathpact = value
        sk4var = value
        sk_2_1Label:SetText(sk4text .. sk4var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -310);
    local extraSep = StdUi:FontString(window, '===================');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -50, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function ArmsMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].victoryrush
    local sk1text = "Victory Rush: "
    local sk1tooltip = "HP Percent to use Victory Rush."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].diebythesword
    local sk2text = "Dye by the Sword: "
    local sk2tooltip = "HP Percent to use Die by the Sword."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].rallyingcry
    local sk3text = "Rallying Cry: "
    local sk3tooltip = "HP Percent to use Rallying Cry."

    local window = StdUi:Window(UIParent, 'Warrior - Arms', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets1 --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        ArmsMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        ArmsMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].victoryrush = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end

    local sk_1_1 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].diebythesword = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk3var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk3text .. sk3var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].rallyingcry = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end
local function FuryMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].victoryrush
    local sk1text = "Victory Rush: "
    local sk1tooltip = "HP Percent to use Victory Rush."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].rallyingcry
    local sk2text = "Rallying Cry: "
    local sk2tooltip = "HP Percent to use Rallying Cry."

    local window = StdUi:Window(UIParent, 'Warrior - Fury', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FuryMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FuryMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].victoryrush = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end

    local sk_1_1 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].rallyingcry = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function MMMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].exhilaration
    local sk1text = "Exhilaration: "
    local sk1tooltip = "HP Percent to use Exhilaration."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].aspectoftheturtle
    local sk2text = "Aspect Turtle: "
    local sk2tooltip = "HP Percent to use Aspect of the Turtle."

    local window = StdUi:Window(UIParent, 'Hunter - Marksman', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        MMMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        MMMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_1Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].exhilaration = value
        sk1var = value
        sk_1_1Label:SetText(sk1text .. sk1var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk2var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].aspectoftheturtle = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function SurvivalMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].mendpet
    local sk1text = "Mend Ptt: "
    local sk1tooltip = "HP Percent to use Mend Pet."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].aspectoftheturtle
    local sk2text = "Aspect Turtle: "
    local sk2tooltip = "HP Percent to use Aspect of the Turtle."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].exhilaration
    local sk3text = "Exhilaration: "
    local sk3tooltip = "HP Percent to use Exhilaration."

    local window = StdUi:Window(UIParent, 'Hunter - Survival', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        SurvivalMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        SurvivalMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_1Label = StdUi:FontString(window, sk2text .. sk2var);
    StdUi:GlueTop(sk_1_1Label, sk_1_1, 0, 16);
    StdUi:FrameTooltip(sk_1_1, sk2tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].runetap = value
        sk2var = value
        sk_1_1Label:SetText(sk2text .. sk2var)
    end

    local sk_2_0 = StdUi:Slider(window, 100, 16, sk3var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    local sk_2_0Label = StdUi:FontString(window, sk3text .. sk3var);
    StdUi:GlueTop(sk_2_0Label, sk_2_0, 0, 16);
    StdUi:FrameTooltip(sk_2_0, sk3tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].mendpet = value
        sk3var = value
        sk_2_0Label:SetText(sk3text .. sk3var)
    end

    local sk_2_1 = StdUi:Slider(window, 100, 16, sk4var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
    local sk_2_1Label = StdUi:FontString(window, sk4text .. sk4var);
    StdUi:GlueTop(sk_2_1Label, sk_2_1, 0, 16);
    StdUi:FrameTooltip(sk_2_1, sk4tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].drw = value
        sk4var = value
        sk_2_1Label:SetText(sk4text .. sk4var)
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function BMMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Hunter - Beast Mastery', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        BMMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        BMMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].mendpet);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Mend Pet', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].mendpet = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].aspectoftheturtle);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Aspect of the Turtle', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].aspectoftheturtle = value
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end


--local tex = StdUi:Texture(window, 350, 500, [[Interface\AddOns\AltzUI\media\statusbar]]);
--tex:SetColorTexture(1, 1, 1, 1)
--StdUi:GlueTop(tex, window, 0, 0);
local function OutMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Rogue - Outlaw', 350, 500);
    window:SetPoint('CENTER');


    --window.texture = window:CreateTexture(nil, "BACKGROUND")
    --window.texture:SetTexture(1, 1, 1, 1)
    --window.texture:SetColorTexture(1, 1, 1, 1)

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local gn_1_1 = StdUi:Checkbox(window, 'Use Racial');
    gn_1_1:SetChecked(RubimRH.db.profile.mainOption.useRacial)
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    function gn_1_1:OnValueChanged(value)
        RubimRH.RacialToggle()
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile.mainOption.healthstoneper);
    gn_2_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    StdUi:AddLabel(window, gn_2_1, 'Healthstone', 'TOP');
    function gn_2_1:OnValueChanged(value)
        RubimRH.db.profile.mainOption.healthstoneper = value
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].crimsonvial);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Crimson Vial', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].crimsonvial = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Cloak of Shadows', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows = value
    end

    local sk_2_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].riposte);
    sk_2_0:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    StdUi:AddLabel(window, sk_2_0, 'Riposte', 'TOP');
    function sk_2_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].riposte = value
    end

    local dice = {
        { text = 'Simcraft', value = 1 },
        { text = 'SoloMode', value = 2 },
        { text = '1+ Buff', value = 3 },
        { text = 'Broadsides', value = 4 },
        { text = 'Buried Treasure', value = 5 },
        { text = 'Grand Melee', value = 6 },
        { text = 'Jolly Roger', value = 7 },
        { text = 'Shark Infested Waters', value = 8 },
        { text = 'Ture Bearing', value = 9 },
    };

    local sk_2_1 = StdUi:Dropdown(window, 100, 24, dice, 1);
    StdUi:GlueBelow(sk_2_1, sk_1_1, 0, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_2_1, 'Roll the Bones', 'TOP');
    function sk_2_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].dice = self:GetText()
        print("Roll the Bones: " .. RubimRH.db.profile[RubimRH.playerSpec].dice)
    end

    local sk_3_0 = StdUi:Checkbox(window, "Vanish Attack");
    sk_3_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].vanishattack)
    StdUi:GlueBelow(sk_3_0, sk_2_0, 0, -24, 'LEFT');
    function sk_3_0:OnValueChanged(value)
        if RubimRH.db.profile[RubimRH.playerSpec].vanishattack then
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = false
        else
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = true
        end
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -380);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function SubMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Rogue - Sub', 350, 500);
    window:SetPoint('CENTER');


    --window.texture = window:CreateTexture(nil, "BACKGROUND")
    --window.texture:SetTexture(1, 1, 1, 1)
    --window.texture:SetColorTexture(1, 1, 1, 1)

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local gn_1_1 = StdUi:Checkbox(window, 'Use Racial');
    gn_1_1:SetChecked(RubimRH.db.profile.mainOption.useRacial)
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    function gn_1_1:OnValueChanged(value)
        RubimRH.RacialToggle()
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile.mainOption.healthstoneper);
    gn_2_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    StdUi:AddLabel(window, gn_2_1, 'Healthstone', 'TOP');
    function gn_2_1:OnValueChanged(value)
        RubimRH.db.profile.mainOption.healthstoneper = value
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].crimsonvial);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Crimson Vial', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].crimsonvial = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Cloak of Shadows', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows = value
    end

    local sk_2_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].evasion);
    sk_2_0:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    StdUi:AddLabel(window, sk_2_0, 'Evasion', 'TOP');
    function sk_2_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].evasion = value
    end

    local sk_2_1 = StdUi:Checkbox(window, "Vanish Attack");
    sk_2_1:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].vanishattack)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 15, -24, 'RIGHT');
    function sk_2_1:OnValueChanged(value)
        if RubimRH.db.profile[RubimRH.playerSpec].vanishattack then
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = false
        else
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = true
        end
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -380);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function AssMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Rogue - Ass', 350, 500);
    window:SetPoint('CENTER');


    --window.texture = window:CreateTexture(nil, "BACKGROUND")
    --window.texture:SetTexture(1, 1, 1, 1)
    --window.texture:SetColorTexture(1, 1, 1, 1)

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local gn_1_1 = StdUi:Checkbox(window, 'Use Racial');
    gn_1_1:SetChecked(RubimRH.db.profile.mainOption.useRacial)
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    function gn_1_1:OnValueChanged(value)
        RubimRH.RacialToggle()
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile.mainOption.healthstoneper);
    gn_2_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    StdUi:AddLabel(window, gn_2_1, 'Healthstone', 'TOP');
    function gn_2_1:OnValueChanged(value)
        RubimRH.db.profile.mainOption.healthstoneper = value
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].crimsonvial);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Crimson Vial', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].crimsonvial = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Cloak of Shadows', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].cloakofshadows = value
    end

    local sk_2_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].evasion);
    sk_2_0:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_2_0, sk_1_0, 0, -24, 'LEFT');
    StdUi:AddLabel(window, sk_2_0, 'Evasion', 'TOP');
    function sk_2_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].evasion = value
    end

    local sk_2_1 = StdUi:Checkbox(window, "Vanish Attack");
    sk_2_1:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].vanishattack)
    StdUi:GlueBelow(sk_2_1, sk_1_1, 15, -24, 'RIGHT');
    function sk_2_1:OnValueChanged(value)
        if RubimRH.db.profile[RubimRH.playerSpec].vanishattack then
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = false
        else
            RubimRH.db.profile[RubimRH.playerSpec].vanishattack = true
        end
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -380);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function HavocMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Demon Hunter - Havoc', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        HavocMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        HavocMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].blur);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Blur', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].blur = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].darkness);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Darkness', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].darkness = value
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function RetributionMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Paladin - Retribution', 350, 500);
    window:SetPoint('CENTER');

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local healthStoneValue = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile.mainOption.healthstoneper);
    healthStoneValue:SetMinMaxValue(0, 100);
    StdUi:AddLabel(window, healthStoneValue, 'Healthstone', 'TOP');
    StdUi:GlueBelow(healthStoneValue, gn_separator, 50, -25, 'RIGHT');
    function healthStoneValue:OnValueChanged(value)
        RubimRH.db.profile.mainOption.healthstoneper = value
    end

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -15, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local racialUsage = StdUi:Checkbox(window, 'Use Racial');
    racialUsage:SetChecked(RubimRH.db.profile.mainOption.useRacial)
    StdUi:GlueBelow(racialUsage, gn_1_0, 0, -25, 'LEFT');
    function racialUsage:OnValueChanged(value)
        RubimRH.RacialToggle()
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -150);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local gn_3_0 = StdUi:Checkbox(window, 'Vengance');
    gn_3_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].SoVEnabled)
    StdUi:GlueBelow(gn_3_0, sk_separator, -50, -5, 'LEFT');
    function gn_3_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].SoVEnabled = value
        print("|cFF69CCF0Vengance" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].SoVEnabled))
    end

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].SoVHP);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, gn_3_0, 0, 0, 'LEFT');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].SoVHP = value
    end

    local flashoflight = StdUi:Checkbox(window, 'Flash of Light');
    flashoflight:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].FoL)
    StdUi:GlueBelow(flashoflight, sk_separator, 50, -5, 'RIGHT');
    function flashoflight:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].FoL = value
        print("|cFF69CCF0Flash of Light" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].FoL))
    end

    local FoLHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].flashoflight);
    FoLHP :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(FoLHP, flashoflight, -5, 0, 'RIGHT');
    function FoLHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].flashoflight = value
    end

    local justicarEnabled = StdUi:Checkbox(window, 'Justicar');
    justicarEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].justicariSEnabled)
    StdUi:GlueBelow(justicarEnabled, sk_1_0, 0, -5, 'LEFT');
    function justicarEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].justicariSEnabled = value
        print("|cFF69CCF0Justicar" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].justicariSEnabled))
    end

    local justicarHealth = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].JusticarHP);
    justicarHealth :SetMinMaxValue(10, 100);
    StdUi:GlueBelow(justicarHealth, justicarEnabled, 0, 0, 'LEFT');
    function justicarHealth :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].JusticarHP = value
    end

    local DivineEnabled = StdUi:Checkbox(window, 'Divine Shield');
    DivineEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].divineEnabled)
    StdUi:GlueBelow(DivineEnabled, FoLHP, 0, -5, 'RIGHT');
    function DivineEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].divineEnabled = value
        print("|cFF69CCF0Divine Shield" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].divineEnabled))
    end

    local DivineHealth = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].DivineHP);
    DivineHealth :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(DivineHealth, DivineEnabled, 0, 0, 'RIGHT');
    function DivineHealth :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].DivineHP = value
    end

    local LayOnHandEnabled = StdUi:Checkbox(window, 'Lay on Hands');
    LayOnHandEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].lohEnabled)
    StdUi:GlueBelow(LayOnHandEnabled, justicarHealth, 0, -5, 'LEFT');
    function LayOnHandEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lohEnabled = value
        print("|cFF69CCF0Lay on Hands" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].lohEnabled))
    end

    local lohHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].lohHealth);
    lohHP :SetMinMaxValue(10, 100);
    StdUi:GlueBelow(lohHP, LayOnHandEnabled, 0, 0, 'LEFT');
    function lohHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lohHealth = value
    end

    local wogactive = StdUi:Checkbox(window, 'Word of Glory');
    wogactive:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].wogenabled)
    StdUi:GlueBelow(wogactive, DivineHealth, 0, -5, 'RIGHT');
    function wogactive:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].wogenabled = value
        print("|cFF69CCF0Word of Glory" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].wogenabled))
    end

    local woghealth = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].wogHP);
    woghealth :SetMinMaxValue(10, 100);
    StdUi:GlueBelow(woghealth, wogactive, 0, 0, 'RIGHT');
    function woghealth :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].wogHP = value
    end

    local op_title = StdUi:FontString(window, 'Offensive Options');
    StdUi:GlueTop(op_title, window, 0, -350);
    local op_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(op_separator, op_title, 0, -12);

    local gn_4_0 = StdUi:Checkbox(window, 'Vengence in Opener');
    gn_4_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].SoVOpener)
    StdUi:GlueBelow(gn_4_0, op_separator, 0, -6, 'CENTER');
    function gn_4_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].SoVOpener = value
        print("|cFF69CCF0Vengance" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].SoVOpener))
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -420);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, 0, -14, 'CENTER');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function WWMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Monk - Windwalker', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        WWMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        WWMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].touchofkarma);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Touch of Karma', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].touchofkarma = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].dampemharm);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Dampem Harm', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].dampemharm = value
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function PProtectionMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Paladin - Protection', 350, 500);
    window:SetPoint('CENTER');

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        PProtectionMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        WWMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local LayOnHandEnabled = StdUi:Checkbox(window, 'Lay on Hands');
    LayOnHandEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].lohEnabled)
    StdUi:GlueBelow(LayOnHandEnabled, sk_separator, -50, -5, 'LEFT');
    function LayOnHandEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lohEnabled = value
        print("|cFF69CCF0Lay on Hands" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].lohEnabled))
    end

    local lohHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].lohHealth);
    lohHP :SetMinMaxValue(10, 100);
    StdUi:GlueBelow(lohHP, LayOnHandEnabled, 0, 0, 'LEFT');
    function lohHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lohHealth = value
    end

    local ancientKingEnabled = StdUi:Checkbox(window, 'Ancient Kings');
    ancientKingEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].akEnabled)
    StdUi:GlueBelow(ancientKingEnabled, sk_separator, 55, -5, 'RIGHT');
    function ancientKingEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].akEnabled = value
        print("|cFF69CCF0Guardian of the Ancient Kings" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].akEnabled))
    end

    local ancientKingHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].akHP);
    ancientKingHP :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(ancientKingHP, ancientKingEnabled, -5, 0, 'RIGHT');
    function ancientKingHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].akHP = value
    end

    local ArdentDefenderEnabled = StdUi:Checkbox(window, 'Ardent Defender');
    ArdentDefenderEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].adEnabled)
    StdUi:GlueBelow(ArdentDefenderEnabled, lohHP, 0, -5, 'LEFT');
    function ArdentDefenderEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].adEnabled = value
        print("|cFF69CCF0Ardent Defender" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].adEnabled))
    end

    local ArdentHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].adHP);
    ArdentHP :SetMinMaxValue(10, 100);
    StdUi:GlueBelow(ArdentHP, ArdentDefenderEnabled, 0, 0, 'LEFT');
    function ArdentHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].adHP = value
    end

    local protectorEnabled = StdUi:Checkbox(window, 'LotP');
    protectorEnabled:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].lotpEnabled)
    StdUi:GlueBelow(protectorEnabled, ancientKingHP, 0, -5, 'CENTER');
    function protectorEnabled:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lotpEnabled = value
        print("|cFF69CCF0Light of the Protector" .. "|r: |cFF00FF00" .. tostring(RubimRH.db.profile[RubimRH.playerSpec].lotpEnabled))
    end

    local protectorHP = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].lotpHP);
    protectorHP :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(protectorHP, protectorEnabled, -5, 0, 'CENTER');
    function protectorHP :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].lotpHP = value
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -300);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, 0, -14, 'CENTER');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end


local function EnhancementMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local sk1var = RubimRH.db.profile[RubimRH.playerSpec].HealingSurge
    local sk1text = "Healing Surge: "
    local sk1tooltip = "HP Percent to use Healing Surge."

    local sk2var = RubimRH.db.profile[RubimRH.playerSpec].EnableFS
    local sk2text = "Feral Spirit: "
    local sk2tooltip = "Check if you want use Feral Spirits."

    local sk3var = RubimRH.db.profile[RubimRH.playerSpec].EnableEE
    local sk3text = "Earth Elemental: "
    local sk3tooltip = "Check if you want to use earth Elemental."

     local sk4var = RubimRH.db.profile[RubimRH.playerSpec].interupt
    local sk4text = "Interupt: "
    local sk4tooltip = "Check if you want to use earth Elemental."

    local window = StdUi:Window(UIParent, 'Shaman - Enhancement', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        EnhancementMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        BloodMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:Slider(window, 100, 16, sk1var / 5, false, 0, 19)
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    local sk_1_0Label = StdUi:FontString(window, sk1text .. sk1var);
    StdUi:GlueTop(sk_1_0Label, sk_1_0, 0, 16);
    StdUi:FrameTooltip(sk_1_0, sk1tooltip, 'TOPLEFT', 'TOPRIGHT', true);
    function sk_1_0:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile[RubimRH.playerSpec].HealingSurge = value
        sk1var = value
        sk_1_0Label:SetText(sk1text .. sk1var)
    end


    local sk_2_0 = StdUi:Checkbox(window, 'Feral Spirits');
    sk_2_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].EnableFS)
    StdUi:GlueBelow(sk_2_0, sk_1_0Label, 0, -30, 'LEFT');
    function sk_2_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].EnableFS = value
        sk2var = value
        sk_2_0Label:SetText(sk2text .. tostring(sk2var))
    end

       local sk_3_0 = StdUi:Checkbox(window, 'Earth Elemental');
    sk_3_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].EnableEE)
    StdUi:GlueBelow(sk_3_0, sk_separator, 70, -20, 'LEFT');
    function sk_3_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].EnableEE = value
        sk3var = value
        sk_3_0Label:SetText(sk3text .. tostring(sk3var))
    end

       local sk_4_0 = StdUi:Checkbox(window, 'Use Interupt');
    sk_4_0:SetChecked(RubimRH.db.profile[RubimRH.playerSpec].interupt)
    StdUi:GlueBelow(sk_4_0, sk_3_0, 0, -13 , 'LEFT');
    function sk_4_0:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].interupt = value
        sk4var = value
        sk_4_0Label:SetText(sk4text .. tostring(sk4var))
    end


    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -410);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);

end








local function FeralMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Druid - Feral', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FeralMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        FeralMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -350);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

local function VengMenu(point, relativeTo, relativePoint, xOfs, yOfs)
    local window = StdUi:Window(UIParent, 'Demon Hunter - Vengeance', 350, 500);
    window:SetPoint('CENTER');
    if point ~= nil then
        window:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_title = StdUi:FontString(window, 'General');
    StdUi:GlueTop(gn_title, window, 0, -30);
    local gn_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(gn_separator, gn_title, 0, -12);

    local gn_1_0 = StdUi:Checkbox(window, 'Auto Target');
    gn_1_0:SetChecked(RubimRH.db.profile.mainOption.startattack)
    StdUi:GlueBelow(gn_1_0, gn_separator, -50, -24, 'LEFT');
    function gn_1_0:OnValueChanged(value)
        RubimRH.AttackToggle()
    end

    local trinketOptions = {
        { text = 'Trinket 1', value = 1 },
        { text = 'Trinket 2', value = 2 },
    }

    for i = 1, #trinketOptions do
        local duplicated = false
        for p = 1, #RubimRH.db.profile.mainOption.useTrinkets do
            if trinketOptions[i].value == RubimRH.db.profile.mainOption.useTrinkets[p] then
                trinketOptions[i].text = "|cFF00FF00" .. "Trinket " .. i .. "|r"
                duplicated = true
            end
            if duplicated == false then
                trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
            end
        end
    end

    if #RubimRH.db.profile.mainOption.useTrinkets == 0 then
        for i = 1, #trinketOptions do
            trinketOptions[i].text = "|cFFFF0000" .. "Trinket " .. i .. "|r"
        end
    end

    local gn_1_1 = StdUi:Dropdown(window, 100, 20, trinketOptions, nil, nil);

    gn_1_1:SetPlaceholder('-- Trinkets --');
    StdUi:GlueBelow(gn_1_1, gn_separator, 50, -24, 'RIGHT');
    gn_1_1.OnValueChanged = function(self, val)

        if RubimRH.db.profile.mainOption.useTrinkets[1] == nil then
            table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
            print("Trinket " .. val .. ": Enabled")
        else
            local duplicated = false
            local duplicatedNumber = 0
            for i = 1, #RubimRH.db.profile.mainOption.useTrinkets do
                if RubimRH.db.profile.mainOption.useTrinkets[i] == val then
                    duplicated = true
                    duplicatedNumber = i
                    break
                end
            end

            if duplicated then
                table.remove(RubimRH.db.profile.mainOption.useTrinkets, duplicatedNumber)
                print("Trinket " .. val .. ": Disabled")
            else
                table.insert(RubimRH.db.profile.mainOption.useTrinkets, val)
                print("Trinket " .. val .. ": Enabled")
            end
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        VengMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    local gn_2_0 = StdUi:Checkbox(window, 'Use Potion');
    gn_2_0:SetChecked(RubimRH.db.profile.mainOption.usePotion)
    StdUi:GlueBelow(gn_2_0, gn_1_0, 0, -24, 'LEFT');
    function gn_2_0:OnValueChanged(value)
        RubimRH.PotionToggle()
    end

    local gn_2_1 = StdUi:Slider(window, 100, 16, RubimRH.db.profile.mainOption.healthstoneper / 5, false, 0, 19)
    StdUi:GlueBelow(gn_2_1, gn_1_1, 0, -24, 'RIGHT');
    local gn_2_1Label = StdUi:FontString(window, 'Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper);
    StdUi:GlueTop(gn_2_1Label, gn_2_1, 0, 16);
    StdUi:FrameTooltip(gn_2_1, 'Percent HP to use Healthstone.', 'TOPLEFT', 'TOPRIGHT', true);
    function gn_2_1:OnValueChanged(value)
        local value = math.floor(value) * 5
        RubimRH.db.profile.mainOption.healthstoneper = value
        gn_2_1Label:SetText('Healthstone: ' .. RubimRH.db.profile.mainOption.healthstoneper)
    end

    local cdOptions = {
        { text = 'Everything', value = "Everything" },
        { text = 'Boss Only', value = "Boss Only" },
    }
    if RubimRH.db.profile.mainOption.cooldownsUsage == "Everything" then
        cdOptions[1].text = "|cFF00FF00" .. "Everything " .. "|r"
    else
        cdOptions[1].text = "|cFFFF0000" .. "Everything " .. "|r"
    end

    if RubimRH.db.profile.mainOption.cooldownsUsage == "Boss Only" then
        cdOptions[2].text = "|cFF00FF00" .. "Boss Only " .. "|r"
    else
        cdOptions[2].text = "|cFFFF0000" .. "Boss Only " .. "|r"
    end

    local gn_3_0 = StdUi:Dropdown(window, 100, 20, cdOptions, nil, nil);

    gn_3_0:SetPlaceholder('-- CDs  --');
    StdUi:GlueBelow(gn_3_0, gn_2_0, 0, -24, 'LEFT');
    gn_3_0.OnValueChanged = function(self, val)
        RubimRH.db.profile.mainOption.cooldownsUsage = val

        if val == "Everything" then
            print("CDs will be used on every mob")
        else
            print("CDs will only be used on Bosses/Rares")
        end

        --self:GetParent():Hide();
        self:GetParent():Hide();
        local point, relativeTo, relativePoint, xOfs, yOfs = self:GetParent():GetPoint()
        VengMenu(nil, point, relativeTo, relativePoint, xOfs, yOfs)
    end

    --------------------------------------------------
    local sk_title = StdUi:FontString(window, 'Class Specific');
    StdUi:GlueTop(sk_title, window, 0, -200);
    local sk_separator = StdUi:FontString(window, '===================');
    StdUi:GlueTop(sk_separator, sk_title, 0, -12);

    local sk_1_0 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].metamorphosis);
    sk_1_0 :SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_0, sk_separator, -50, -24, 'LEFT');
    StdUi:AddLabel(window, sk_1_0, 'Metamorphosis', 'TOP');
    function sk_1_0 :OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].metamorphosis = value
    end

    local sk_1_1 = StdUi:NumericBox(window, 100, 24, RubimRH.db.profile[RubimRH.playerSpec].soulbarrier);
    sk_1_1:SetMinMaxValue(0, 100);
    StdUi:GlueBelow(sk_1_1, sk_separator, 50, -24, 'RIGHT');
    StdUi:AddLabel(window, sk_1_1, 'Soul Barrier', 'TOP');
    function sk_1_1:OnValueChanged(value)
        RubimRH.db.profile[RubimRH.playerSpec].soulbarrier = value
    end

    local extra = StdUi:FontString(window, 'Extra');
    StdUi:GlueTop(extra, window, 0, -310);
    local extraSep = StdUi:FontString(window, '=====');
    StdUi:GlueTop(extraSep, extra, 0, -12);

    local extra1 = StdUi:Button(window, 100, 20, 'Spells Blocker');
    StdUi:GlueBelow(extra1, extraSep, -100, -24, 'LEFT');
    extra1:SetScript('OnClick', function()
        window:Hide()
        RubimRH.SpellBlocker()
    end);
end

function RubimRH.ClassConfig(specID)
    --AllMenu()
    if specID == 250 then
        BloodMenu()
    end
    if specID == 251 then
        FrostMenu()
    end

    if specID == 252 then
        UnholyMenu()
    end

    if specID == Arms then
        AllMenu()
    end

    if specID == 72 then
        FuryMenu()
    end

    if specID == 253 then
        BMMenu()
    end

    if specID == 254 then
        MMMenu()
    end

    if specID == Survival then
        AllMenu()
    end

    if specID == 66 then
        ProtectionMenu()
    end

    if specID == 259 then
        AssMenu()
    end

    if specID == 260 then
        OutMenu()
    end

    if specID == 261 then
        SubMenu()
    end

    if specID == 577 then
        HavocMenu()
    end

    if specID == 581 then
        VengMenu()
    end

    if specID == 269 then
        WWMenu()
    end

    if specID == 103 then
        FeralMenu()
    end

    if specID == Enhancement then
        AllMenu()
    end

    if specID == Guardian then
        AllMenu()
    end

    if specID == Brewmaster then
        AllMenu()
    end

    if specID == Retribution then
        AllMenu()
    end
end