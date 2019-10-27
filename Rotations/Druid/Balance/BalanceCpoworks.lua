local rotationName = "Cpoworks (Alpha / Not Complete)" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Define custom toggles
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1, overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of enemies in range.", highlight = 1, icon = br.player.spell.moonfire },
        [2] = { mode = "Mult", value = 2, overlay = "Multi Target rotation", tip = "Multi Target rotation", highlight = 1, icon = br.player.spell.starfall },
        [3] = { mode = "Sing", value = 3, overlay = "Force single target", tip = "Force single target", highlight = 0, icon = br.player.spell.solarWrath },
        [4] = { mode = "Off", value = 4, overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.soothe }
    };

    CreateButton("Rotation", 1, 0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1, overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.celestialAlignment },
        [2] = { mode = "On", value = 2, overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 1, icon = br.player.spell.celestialAlignment },
        [3] = { mode = "Off", value = 3, overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.celestialAlignment }
    };
    CreateButton("Cooldown", 2, 0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1, overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.barkskin },
        [2] = { mode = "Off", value = 2, overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.barkskin }
    };
    CreateButton("Defensive", 3, 0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1, overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.solarBeam },
        [2] = { mode = "Off", value = 2, overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.solarBeam }
    };
    CreateButton("Interrupt", 4, 0)
    -- FoN Button
    ForceofNatureModes = {
        [1] = { mode = "On", value = 1, overlay = "Force of Nature Enabled", tip = "Will Use Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature },
        [2] = { mode = "Key", value = 2, overlay = "Force of Nature hotkey", tip = "Key triggers Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature },
        [3] = { mode = "Off", value = 2, overlay = "Force of Nature Disabled", tip = "Will Not Use Force of Nature", highlight = 0, icon = br.player.spell.forceOfNature }
    };
    CreateButton("ForceofNature", 5, 0)

    FormsModes = {
        [1] = { mode = "On", value = 1, overlay = "Auto Forms Enabled", tip = "Will change forms", highlight = 0, icon = br.player.spell.travelForm },
        [2] = { mode = "Off", value = 2, overlay = "Auto Forms hotkey", tip = "Key triggers Auto Forms", highlight = 0, icon = br.player.spell.travelForm },
    };
    CreateButton("Forms", 6, 0)

end
---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS --- -- Define General Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile, "General")
        br.ui:createSpinner(section, "Pre-Pull Timer", 2.5, 0, 10, 0.5, "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        br.ui:createCheckbox(section, "Auto Soothe")
        br.ui:createCheckbox(section, "Auto Engage On Target", "Check this to cast sunfire on target OOC to engage combat")
        br.ui:createCheckbox(section, "Opener")
        br.ui:checkSectionState(section)
        -----------------------
        --- HEALING OPTIONS --- -- Define Healing Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile, "Healing")
        if br.player.talent.restorationAffinity then
            br.ui:createSpinner(section, "OOC Regrowth", 50, 1, 100, 5, "Set health to heal while out of combat. Min: 1 / Max: 100 / Interval: 5")
            br.ui:createSpinner(section, "OOC Wild Growth", 50, 1, 100, 5, "Set health to heal while out of combat. Min: 1 / Max: 100 / Interval: 5")
            br.ui:createSpinner(section, "Swiftmend", 15, 0, 100, 5, "Health Percent to Cast At")
        end
        br.ui:createSpinner(section, "Regrowth", 30, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createDropdown(section, "Rebirth", { "|cff00FF00Tanks", "|cffFFFF00Healers", "|cffFFFFFFTanks and Healers", "|cffFF0000Mouseover Target", "|cffFFFFFFAny" }, 3, "", "|ccfFFFFFFTarget to Cast On")
        br.ui:createCheckbox(section, "Revive target")
        br.ui:createDropdown(section, "Remove Corruption", { "|cff00FF00Player Only", "|cffFFFF00Selected Target", "|cffFFFFFFPlayer and Target", "|cffFF0000Mouseover Target", "|cffFFFFFFAny" }, 3, "", "|ccfFFFFFFTarget to Cast On")
        br.ui:createDropdown(section, "Off-healing", { "Nope", "always", "No-Healer" }, 1, "", "offheal")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "M+")
        br.ui:createCheckbox(section, "Freehold - pig")
        br.ui:createCheckbox(section, "Freehold - root grenadier")
        br.ui:createCheckbox(section, "Atal - root Spirit of Gold")
        br.ui:createCheckbox(section, "KR - Minions of Zul")
        br.ui:createCheckbox(section, "All - root Emissary of the Tides")
        br.ui:createCheckbox(section, "Punt Enchanted Emissary")
        br.ui:createCheckbox(section, "Dont DPS spotter", "wont DPS spotter", 0)
        br.ui:checkSectionState(section)
        ------------------------
        --- POTS OPTIONS --- -- Define Pots Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "Pots")
        br.ui:createCheckbox(section, "Auto use Pots")
        br.ui:createDropdownWithout(section, "Pots - 1 target", { "None", "Battle", "RisingDeath", "Draenic", "Prolonged", "Empowered Proximity", "Focused Resolve", "Superior Battle" }, 1, "", "Use Pot when Incarnation/Celestial Alignment is up")
        br.ui:createDropdownWithout(section, "Pots - 2-3 targets", { "None", "Battle", "RisingDeath", "Draenic", "Prolonged", "Empowered Proximity", "Focused Resolve", "Superior Battle" }, 1, "", "Use Pot when Incarnation/Celestial Alignment is up")
        br.ui:createDropdownWithout(section, "Pots - 4+ target", { "None", "Battle", "RisingDeath", "Draenic", "Prolonged", "Empowered Proximity", "Focused Resolve", "Superior Battle" }, 1, "", "Use Pot when Incarnation/Celestial Alignment is up")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        br.ui:createCheckbox(section, "Auto Innervate", "Use Innervate if you have Lively Spirit traits for DPS buff")
        br.ui:createCheckbox(section, "Racial")
        br.ui:createDropdownWithout(section,"Trinkets", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Trinkets.")
        br.ui:createCheckbox(section, "Warrior Of Elune")
        br.ui:createCheckbox(section, "Fury Of Elune")
        br.ui:createSpinnerWithout(section, "Fury of Elune Targets", 3, 1, 10, 1, "How many baddies before using Fury?")
        br.ui:createCheckbox(section, "Group Fury with CD")
        br.ui:createCheckbox(section, "Incarnation/Celestial Alignment")
        br.ui:createSpinnerWithout(section, "Treant Targets", 3, 1, 10, 1, "How many baddies before using Treant?")
        br.ui:createCheckbox(section, "Group treants with CD")
        br.ui:createDropdown(section, "Treants Key", br.dropOptions.Toggle, 6, "", "|cffFFFFFFTreant Key")
        br.ui:checkSectionState(section)
        --------------------------
        ---  ESSANCE OPTIONS   ---  -- Define Essance Options
        --------------------------
        section = br.ui:createSection(br.ui.window.profile, "Essances")
        br.ui:createSpinner(section, "ConcentratedFlame - Heal", 5, 0, 100, 5, "", "health to heal at")
        br.ui:createCheckbox(section, "ConcentratedFlame - DPS")
        br.ui:createCheckbox(section, "Guardian Of Azeroth")
        br.ui:createSpinner(section, "Focused Azerite Beam", 3, 1, 10, 1, "|cffFFFFFF Min. units hit to use Focused Azerite Beam")
        br.ui:checkSectionState(section)
        -------------------------
        ---  TARGET OPTIONS   ---  -- Define Target Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Targets")
        br.ui:createSpinnerWithout(section, "Max Stellar Flare Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Stellar Flare. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createSpinnerWithout(section, "Max Moonfire Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Moonfire. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createSpinnerWithout(section, "Max Sunfire Targets", 2, 1, 10, 1, "|cff0070deSet to maximum number of targets to dot with Sunfire. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createCheckbox(section, "Safe Dots")
        br.ui:createSpinnerWithout(section, "Starfall Targets (0 for auto)", 0, 0, 10, 1, "|cff0070deSet to minimum number of targets to use Starfall. 0 to calculate")
        br.ui:createSpinnerWithout(section, "Fury of Elune Targets", 2, 1, 10, 1, "|cff0070deSet to minimum number of targets to use Fury of Elune. Min: 1 / Max: 10 / Interval: 1")
        br.ui:createCheckbox(section, "Ignore dots during pewbuff")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS --- -- Define Defensive Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        br.ui:createSpinner(section, "Potion/Healthstone", 20, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Renewal", 25, 0, 100, 5, "Health Percent to Cast At")
        br.ui:createSpinner(section, "Barkskin", 60, 0, 100, 5, "Health Percent to Cast At")
        br.ui:checkSectionState(section)
        ---------------------
        --- FORMS OPTIONS --- -- Define Forms Options
        ---------------------
        section = br.ui:createSection(br.ui.window.profile, "Forms")
        br.ui:createCheckbox(section, "Auto Stealth", 1)
        br.ui:createCheckbox(section, "Auto Dash", 1)
        br.ui:createDropdown(section, "Bear Form Key", br.dropOptions.Toggle, 6, "", "|cffFFFFFFGO BEAR GO!")
        br.ui:createSpinner(section, "Bear Frenzies Regen HP", 50, 0, 100, 1, "HP Threshold start regen")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS --- -- Define Interrupt Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        br.ui:createCheckbox(section, "Solar Beam")
        br.ui:createCheckbox(section, "Mighty Bash")
        br.ui:createCheckbox(section, "Typhoon")
        br.ui:createSpinner(section, "InterruptAt", 0, 0, 95, 5, "|cffFFBB00Cast Percentage to use at.")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS --- -- Define Toggle Options
        ----------------------
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle, 4)
        br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle, 3)
        br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle, 6)
        br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle, 6)
        br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle, 6)
        br.ui:checkSectionState(section)
    end
    optionTable = { {
                        [1] = "Rotation Options",
                        [2] = rotationOptions,
                    } }
    return optionTable
end

local function runRotation()

    ---------------
    --- Toggles --- -- List toggles here in order to update when pressed
    ---------------
    UpdateToggle("Rotation", 0.25)
    UpdateToggle("Cooldown", 0.25)
    UpdateToggle("Defensive", 0.25)
    UpdateToggle("Interrupt", 0.25)
    UpdateToggle("ForceofNature", 0.25)
    UpdateToggle("Forms", 0.25)

    br.player.mode.forceOfNature = br.data.settings[br.selectedSpec].toggles["ForceofNature"]
    br.player.mode.DPS = br.data.settings[br.selectedSpec].toggles["Rotation"]
    br.player.mode.forms = br.data.settings[br.selectedSpec].toggles["Forms"]

    --------------
    --- Locals ---
    --------------
    local lowestHP = br.friend[1].unit
    local lowest = br.friend[1]
    local mana = getMana("player")
    local power, powmax, powgen = br.player.power.astralPower.amount(), br.player.powerMax, br.player.powerRegen
    
    --------------
    -- Player
    --------------
    local buff = br.player.buff
    local cast = br.player.cast
    local php = br.player.health
    local spell = br.player.spell
    local talent = br.player.talent
    local cd = br.player.cd
    local gcd = br.player.gcdMax
    local charges = br.player.charges
    local debuff = br.player.debuff
    local drinking = getBuffRemain("player", 192002) ~= 0 or getBuffRemain("player", 167152) ~= 0 or getBuffRemain("player", 192001) ~= 0
    local resable = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and GetUnitIsFriend("target", "player") and UnitInRange("target")
    local inCombat = isInCombat("player")
    local inInstance = br.player.instance == "party" or br.player.instance == "scenario"
    local inRaid = br.player.instance == "raid"
    local solo = #br.friend == 1
    local race = br.player.race
    local racial = br.player.getRacial()
    local traits = br.player.traits
    local moving = isMoving("player")
    local swimming = IsSwimming()
    local ttd = getTTD
    local astralPowerDeficit = br.player.power.astralPower.deficit()
    local travel, flight, cat = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.catForm.exists()
    local catspeed = br.player.buff.dash.exists() or br.player.buff.tigerDash.exists()
    local hasteAmount = GetHaste() / 100
    local thisUnit = nil
    local aoeTarget = 0
    local essence = br.player.essence
    local healPot = getHealthPot()
    local use = br.player.use
    local LastDamageSpell = nil
    -------------
    -- Raid
    ------------

    local tanks = getTanksTable()
    local lowest = br.friend[1]
    local friends = friends or {}
    local gcd = br.player.gcdMax
    
    -------------
    -- Enemies
    -------------
    local enemies = br.player.enemies
    local mode = br.player.mode
    local pullTimer = br.DBM:getPulltimer()
    local units = br.player.units
    local pewbuff = buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()
    local starfallRadius = nil

    if #tanks > 0 and inInstance then
        for i = 1, #tanks do
            tank = tanks[i].unit
        end
    else
        tank = "Player"
    end

    --wipe timers table
    if timersTable then
        wipe(timersTable)
    end

    enemies.get(45)
    enemies.get(40)
    enemies.get(15)
    enemies.get(8, "target") -- enemies.yards8t
    enemies.get(10, "target", true)
    enemies.get(11, "target") -- enemies.yards8t
    enemies.get(15, "target") -- enemies.yards15t
    enemies.get(12)
    enemies.get(12, "target") -- enemies.yards12t

    -- Opener Reset
    local opener = br.player.opener

    if (not inCombat and not GetObjectExists("target")) or opener.complete == nil then
        opener.count = 0
        opener.WRA1 = false
        opener.WRA2 = false
        opener.DOT1 = false
        opener.DOT2 = false
        opener.DOT3 = false
        opener.PWR = false
        opener.PEW = false
        opener.complete = false

        --Clear last cast table ooc to avoid strange casts
        if #br.lastCast.tracker > 0 then
            wipe(br.lastCast.tracker)
        end
    end

    ABOpener = ABOpener or false
    SW1 = SW1 or false
    SW2 = SW2 or false
    MF = MF or false
    SF = SF or false
    StF = StF or false
    CA = CA or false

    if (not inCombat and not GetObjectExists("target")) and ABopener then
        br.addonDebug("Opener Reset")
        ABOpener = false
        SW1 = false
        SW2 = false
        MF = false
        SF = false
        StF = false
        CA = false
        if #br.lastCast.tracker > 0 then
            wipe(br.lastCast.tracker)
        end
    end

    local astral_max = 0
    local astral_def = 0

    if talent.naturesBalance then
        astral_max = 95
    else
        astral_max = 100
    end
    astral_def = astral_max - power

    local standingTime = 0
    if DontMoveStartTime then
        standingTime = GetTime() - DontMoveStartTime
    end

    local groupTTD = 0
    for i = 1, #enemies.yards45 do
        thisUnit = enemies.yards45[i]
        groupTTD = groupTTD + ttd(thisUnit)
    end

    if getValue("Starfall Targets (0 for auto)") == 0 then
        aoeTarget = 4
        if traits.arcanicPulsar.active then
            aoeTarget = aoeTarget + 1
        end
        if talent.starlord then
            aoeTarget = aoeTarget + 1
        end
        if talent.twinMoons then
            aoeTarget = aoeTarget + 1
        end
        if traits.arcanicPulsar.active and br.player.traits.streakingStars.rank >= 2 then
            aoeTarget = aoeTarget + 1
        end

        if talent.stellarDrift then
            starfallRadius = 15
        else
            starfallRadius = 12
        end
    elseif getValue("Starfall Targets (0 for auto)") ~= 0 then
        aoeTarget = getValue("Starfall Targets (0 for auto)")
    end

    local function noDamageCheck(unit)
        if isChecked("Dont DPS spotter") and GetObjectID(unit) == 135263 then
            return true
        end

        if isCasting(302415, unit) then
            -- emmisary teleporting home
            return true
        end
        return false
    end

    local function dps()

        -- Track last damage spell
        if cast.last.starsurge() then
            LastDamageSpell = 'starsurge'
        elseif cast.last.moonfire() then
            LastDamageSpell = 'moonfire'
        elseif cast.last.sunfire() then
            LastDamageSpell = 'sunfire'
        elseif cast.last.stellarFlare() then
            LastDamageSpell = 'stellarFlare'
        elseif cast.last.solarWrath() then
            LastDamageSpell = 'solarWrath'
        elseif cast.last.lunarStrike() then
            LastDamageSpell = 'lunarStrike'
        end

        if not br.player.buff.moonkinForm.exists() and not buff.prowl.exists() and not cast.last.moonkinForm(1) then
            if cast.moonkinForm() then
                return true
            end
        end

        
        -- CDS

        --[[
                1, none, frX
                2, battle, 163222
                3, RisingDeath, 152559
                4, Draenic, 109218
                5, Prolonged, 142117
                6, Empowered Proximity, 168529
                7, Focused Resolve, 168506
                8, Superior Battle, 168498
                ]]


        if isChecked("Auto use Pots") then
            local auto_pot = nil
            if #enemies.yards12t == 1 and isBoss("target") then
                auto_pot = getOptionValue("Pots - 1 target")
            elseif #enemies.yards12t >= 2 and #enemies.yards12t <= 3 then
                auto_pot = getOptionValue("Pots - 2-3 targets")
            elseif #enemies.yards12t >= 4 then
                auto_pot = getOptionValue("Pots - 4+ target")
            end

            if not auto_pot == 1 and not solo and (buff.incarnationChoseOfElune.exists() and buff.incarnationChoseOfElune.remain() > 16.5) or (buff.celestialAlignment.exists() and buff.celestialAlignment.remain() > 13) then
                if auto_pot == 2 and canUseItem(163222) then
                    useItem(163222)
                elseif auto_pot == 3 and canUseItem(152559) then
                    useItem(152559)
                elseif auto_pot == 4 and canUseItem(109218) then
                    useItem(109218)
                elseif auto_pot == 5 and canUseItem(142117) then
                    useItem(142117)
                elseif auto_pot == 6 and #enemies.yards12 > 3 and canUseItem(168529) then
                    useItem(168529)
                elseif auto_pot == 7 and canUseItem(168506) then
                    useItem(168506)
                elseif auto_pot == 8 and canUseItem(168498) then
                    useItem(168498)
                end
            end
        end

        -- berserking,if=buff.ca_inc.up
        if useCDs()
        and (race == "Troll") and isChecked("Racial")  
        and pewbuff then
            cast.racial("player")
        end

        --guardian_of_azeroth,if=(!talent.starlord.enabled|buff.starlord.up)&!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
        if isChecked("Guardian Of Azeroth") 
        and useCDs() 
        and cast.able.guardianOfAzeroth()
        and (debuff.moonfire.exists("target") and debuff.sunfire.exists("target") and (not talent.stellarFlare or debuff.stellarFlare.exists("target")))
        and (not talent.starlord or buff.starLord.exists("player")) then
            if cast.guardianOfAzeroth() then
                br.addonDebug("Essence: Casting Guardian of Azeroth")
                return
            end
        end

        -- Trinkets
        if (use.able.slot(13) or use.able.slot(14)) then
            local opValue = getOptionValue("Use Trinkets")
            if (opValue == 1 or (opValue == 2 and useCDs())) and getDistance(units.dyn5) < 5 then
                for i = 13, 14 do
                    if use.able.slot(i) then

                        -- Cyclotronic Blast
                        if useCDs() and equiped.pocketSizedComputationDevice(i) and equiped.socket.pocketSizedComputationDevice(167672,1) then
                            -- use_item,effect_name=cyclotronic_blast,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
                            if debuff.moonfire.exists("target") and debuff.sunfire.exists("target") and (not talent.stellarFlare or debuff.stellarFlare.exists("target")) then
                                use.slot(i)
                                debug("Using Cyclotronic Blast [Slot "..i.."]")
                            end
                        end

                        --Azshara's Font of Power
                        -- use_item,name=azsharas_font_of_power,if=!buff.ca_inc.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)
                        if equiped.azsharasFontOfPower(i) and debuff.moonfire.exists("target") and debuff.sunfire.exists("target") and (not talent.stellarFlare or debuff.stellarFlare.exists("target")) then
                            use.slot(i)
                            debug("Using Azshara's Font of Power [Slot "..i.."]")
                        end

                        -- Shiver Venom Relic
                        --use_item,name=shiver_venom_relic,if=!buff.ca_inc.up&!buff.bloodlust.up,target_if=dot.shiver_venom.stack>=5
                        if equiped.ShiverVenomRelic(i) and getDebuffStacks("target", 301624) == 5 then
                            use.slot(i)
                            debug("Using Shiver Venom Relic [Slot "..i.."]")
                        end

                        -- All Others
                        if not (equiped.ShiverVenomRelic(i) or (equiped.pocketSizedComputationDevice(i) and equiped.socket.pocketSizedComputationDevice(167672,1)) or equiped.azsharasFontOfPower(i)) and useCDs() then
                            use.slot(i)
                            debug("Using Trinket [Slot "..i.."]")
                        end
                    end
                end
            end
        end


        --blood_of_the_enemy,if=cooldown.ca_inc.remains>30

        --memory_of_lucid_dreams,if=!buff.ca_inc.up&(astral_power<25|cooldown.ca_inc.remains>30),target_if=dot.sunfire.remains>10&dot.moonfire.remains>10&(!talent.stellar_flare.enabled|dot.stellar_flare.remains>10)

        --purifying_blast

        --ripple_in_space

        --concentrated_flame
        if useCDs() and isChecked("ConcentratedFlame - DPS") then
            if cast.concentratedFlame("target") then
                return true
            end
        end
        
        --the_unbound_force,if=buff.reckless_force.up,target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)

        --worldvein_resonance

        --focused_azerite_beam,if=(!variable.az_ss|!buff.ca_inc.up),target_if=dot.moonfire.ticking&dot.sunfire.ticking&(!talent.stellar_flare.enabled|dot.stellar_flare.ticking)

        --thorns

        --warrior_of_elune
        if useCDs() and isChecked("Warrior Of Elune") and talent.warriorOfElune and not buff.warriorOfElune.exists() and cast.able.warriorOfElune() then
            if cast.warriorOfElune() then
                return true
            end
        end

        --innervate,if=azerite.lively_spirit.enabled&(cooldown.incarnation.remains<2|cooldown.celestial_alignment.remains<12)
        if isChecked("Auto Innervate") and cast.able.innervate() and (getTTD(UnitTarget(tank)) >= 12 or (traits.livelySpirit.active and (cd.incarnationChoseOfElune.remain() < 2 or cd.celestialAlignment.remain() < 12))) then
            for i = 1, #br.friend do
                if UnitGroupRolesAssigned(br.friend[i].unit) == "HEALER" and getDistance(br.friend[i].unit) < 45 and inInstance or inRaid and not UnitIsDeadOrGhost(br.friend[i].unit) and getLineOfSight(br.friend[i].unit) then
                    --Print("Healer is: " .. br.friend[i].unit)
                    if cast.innervate(br.friend[i].unit) then
                        return true
                    end
                end
            end
        end

        --force_of_nature,if=(variable.az_ss&!buff.ca_inc.up|!variable.az_ss&(buff.ca_inc.up|cooldown.ca_inc.remains>30))&ap_check
        if talent.forceOfNature and cast.able.forceOfNature() and astral_def > 20 then
            if br.player.mode.forceOfNature == 1 and getTTD("target") >= 10
                    and (isChecked("Group treants with CD") and (pewbuff or cd.celestialAlignment.remain() > 30 or cd.incarnationChoseOfElune.remain() > 30) or not isChecked("Group treants with CD"))
                    and (#enemies.yards12t >= getValue("Treant Targets") or isBoss())
            then
                if cast.forceOfNature("best", nil, 1, 15, true) then
                    return true
                end
            elseif br.player.mode.forceOfNature == 2 and isChecked("Treants Key") and SpecificToggle("Treants Key") and not GetCurrentKeyBoardFocus() then
                if cast.forceOfNature("best", nil, 1, 15, true) then
                    return true
                end
            end
        end

        --incarnation,if=!buff.ca_inc.up&(buff.memory_of_lucid_dreams.up|((cooldown.memory_of_lucid_dreams.remains>20|!essence.memory_of_lucid_dreams.major)&ap_check))&(buff.memory_of_lucid_dreams.up|ap_check),target_if=dot.sunfire.remains>8&dot.moonfire.remains>12&(dot.stellar_flare.remains>6|!talent.stellar_flare.enabled)
        --celestial_alignment,if=!buff.ca_inc.up&(!talent.starlord.enabled|buff.starlord.up)&(buff.memory_of_lucid_dreams.up|((cooldown.memory_of_lucid_dreams.remains>20|!essence.memory_of_lucid_dreams.major)&ap_check))&(!azerite.lively_spirit.enabled|buff.lively_spirit.up),target_if=(dot.sunfire.remains>2&dot.moonfire.ticking&(dot.stellar_flare.ticking|!talent.stellar_flare.enabled))
        if useCDs() and isChecked("Incarnation/Celestial Alignment") and not pewbuff and power >= 40 then
            if cast.able.incarnationChoseOfElune() and talent.incarnationChoseOfElune then
                --buff.memory_of_lucid_dreams.up|((cooldown.memory_of_lucid_dreams.remains>20|!essence.memory_of_lucid_dreams.major)
                if debuff.sunfire.remain("target") > 8
                and debuff.moonfire.remain("target") > 12
                and (debuff.stellarFlare.remain("target") > 6 or not talent.stellarFlare)
                and groupTTD >= 30
                or hasBloodLust() and debuff.sunfire.exists("target") 
                and debuff.moonfire.exists("target") 
                and (debuff.stellarFlare.exists("target") or not talent.stellarFlare) then
                    if cast.incarnationChoseOfElune() then
                        return true
                    end
                end
            end   
            if cast.able.celestialAlignment() and not talent.incarnationChoseOfElune then
                if not pewbuff
                        and (buff.starLord.exists or not talent.starlord)
                        and (buff.memoryOfLucidDreams.exists() or ((cd.memoryOfLucidDreams.remains() > 20 or not essence.memoryOfLucidDreams.active) and power >= 40))
                        and groupTTD >= 20 and not pewbuff and
                        (not traits.livelySpirit.active or buff.livelySpirit.exists() or solo or (traits.livelySpirit.active and cd.innervate.remain() >= 30) or not isChecked("Auto Innervate")) and
                        debuff.sunfire.remain("target") > 2 and debuff.moonfire.exists("target") and
                        (debuff.stellarFlare.exists("target") or not talent.stellarFlare)
                        or hasBloodLust() and debuff.sunfire.exists("target") and debuff.moonfire.exists("target") and (debuff.stellarFlare.exists("target") or not talent.stellarFlare)
                then
                    if cast.celestialAlignment() then
                        return true
                    end
                end
            end
        end

        -- fury_of_elune,if=(buff.ca_inc.up|cooldown.ca_inc.remains>30)
        -- &solar_wrath.ap_check
        if cast.able.furyOfElune() 
        and talent.furyOfElune and isChecked("Fury Of Elune") 
        and (#enemies.yards8t >= getValue("Fury of Elune Targets") or isBoss()) 
        and groupTTD >= 8
        and (pewbuff or (cd.celestialAlignment.remain() > 30 or cd.incarnationChoseOfElune.remain() > 30)) then
            if cast.furyOfElune(getBiggestUnitCluster(45, 1.25)) then
                return true
            end
        end

        -- SPENDERS

        --cancel_buff,name=starlord,if=buff.starlord.remains<3&!solar_wrath.ap_check
        if buff.starLord.exists() and buff.starLord.stack() == 3 and buff.starLord.remain() < 3 and astral_def < 8 then
            br.addonDebug("Spender - Cancel Starlord")
            cancelBuff(279709)
        end

        -- actions+=/starfall,if=(buff.starlord.stack<3|buff.starlord.remains>=8)
        -- &spell_targets>=variable.sf_targets
        -- &(target.time_to_die+1)*spell_targets>cost%2.5
        if cast.able.starfall()
        and (buff.starLord.stack() < 3 or buff.starLord.remain() >= 5)
        and (talent.stellarDrift and #enemies.yards15t >= aoeTarget) or #enemies.yards12t >= aoeTarget 
        --and (ttd(units.dyn45) +1)*#enemies.yards15t > cost % 2.5 
        then
            if cast.starfall("best", false, aoeTarget, starfallRadius) then
                br.addonDebug("Spender - Starfall")
                return true
            end
        end

        -- starsurge,
        --if=(talent.starlord.enabled&(buff.starlord.stack<3|buff.starlord.remains>=5&buff.arcanic_pulsar.stack<8)|!talent.starlord.enabled&(buff.arcanic_pulsar.stack<8|buff.ca_inc.up))
        -- &spell_targets.starfall<variable.sf_targets
        -- &buff.lunar_empowerment.stack+buff.solar_empowerment.stack<4
        -- &buff.solar_empowerment.stack<3
        -- &buff.lunar_empowerment.stack<3
        -- &(!variable.az_ss|!buff.ca_inc.up|!prev.starsurge)
        -- |target.time_to_die<=execute_time*astral_power%40
        -- |!solar_wrath.ap_check
        if cast.able.starsurge() 
        and (talent.starlord and (buff.starLord.stack() < 3 or buff.starLord.remain() >= 5 and buff.arcanicPulsar.stack() < 8) or not talent.starlord and (buff.arcanicPulsar.stack() < 8 or pewbuff))
        and ((talent.stellarDrift and #enemies.yards15t < aoeTarget) or #enemies.yards12t < aoeTarget)
        and buff.lunarEmpowerment.stack() + buff.solarEmpowerment.stack() < 4 
        and buff.solarEmpowerment.stack() < 3 
        and buff.lunarEmpowerment.stack() < 3
        and (not traits.streakingStars.active or not pewbuff or LastDamageSpell ~= 'starsurge')
        -- ttd(units.dyn45) <= (br.player.gcd * power / 40)
        or astral_def <= 8 
        then
            if cast.starsurge(units.dyn45) then
                br.addonDebug("Spender - Starsurge")
                return
            end
        end

        -- sunfire,if=buff.ca_inc.up &buff.ca_inc.remains<gcd.max &variable.az_ss &dot.moonfire.remains>remains
        if cast.able.sunfire()
        and pewbuff
        and ((buff.celestialAlignment.remain() < br.player.gcd) or (buff.incarnationChoseOfElune.remain() < br.player.gcd))
        and traits.streakingStars.active
        and debuff.moonfile.remain(units.dyn45) > debuff.sunfile.remain(units.dyn45) then
            if cast.sunfire(units.dyn45) then
                br.addonDebug("Spender - Sunfire")
                return true
            end
        end

        --moonfire,if=buff.ca_inc.up&buff.ca_inc.remains<gcd.max&variable.az_ss
        if cast.able.moonfire()
        and pewbuff
        and ((buff.celestialAlignment.remain() < br.player.gcd) or (buff.incarnationChoseOfElune.remain() < br.player.gcd))
        and traits.streakingStars.active then
            if cast.moonfire(units.dyn45) then
                br.addonDebug("Spender - Moonfire")
                return true
            end
        end

        -- DOTS
        local sunfire_target = 0
        local sunfire_radius = 8
        if traits.highNoon.active then
            sunfire_target = #enemies.yards11t
            sunfire_radius = 11
        else
            sunfire_target = #enemies.yards8t
            sunfire_radius = 8
        end

        for i = 1, #enemies.yards45 do
            if mode.DPS < 3 then
                thisUnit = enemies.yards45[i]
            elseif mode.DPS == 3 then
                thisUnit = "target"
            end

            if not noDamageCheck(thisUnit) and (buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()) and not isChecked("Ignore dots during pewbuff")
            or not (buff.incarnationChoseOfElune.exists() or buff.celestialAlignment.exists()) then

                if isChecked("Safe Dots") 
                and ((inInstance and #tanks > 0 and getDistance(thisUnit, tanks[1].unit) <= 10)
                or (inInstance and #tanks == 0)
                or (inRaid and #tanks > 1 and (getDistance(thisUnit, tanks[1].unit) <= 10 or (getDistance(thisUnit, tanks[2].unit) <= 10)))
                or solo
                or (inInstance and #tanks > 0 and getDistance(tanks[1].unit) >= 90)) 
                or not isChecked("Safe Dots") then

                    local moonfiretalent = 0
                    if talent.twinMoons then
                        moonfiretalent = moonfiretalent + 1
                    end

                    -- sunfire,
                    -- target_if=refreshable,
                    -- if=ap_check
                    -- &floor(target.time_to_die%(2*spell_haste))*spell_targets>=ceil(floor(2%spell_targets)*1.5)+2*spell_targets
                    -- &(spell_targets>1+talent.twin_moons.enabled|dot.moonfire.ticking)
                    -- &(!variable.az_ss|!buff.ca_inc.up|!prev.sunfire)
                    -- &(buff.ca_inc.remains>remains|!buff.ca_inc.up)
                    if debuff.sunfire.count() == 0 then
                        if traits.highNoon.active then
                            if cast.sunfire(getBiggestUnitCluster(45, sunfire_radius)) then
                                br.addonDebug("Initial Sunfire - Cluster(" .. sunfire_radius .. ")")
                                return true
                            end
                        end
                    end

                    if cast.able.sunfire() and (debuff.sunfire.count() < getOptionValue("Max Sunfire Targets") or debuff.sunfire.exists(thisUnit)) or isBoss(thisUnit) and astral_def >= 3 then
                        if not debuff.sunfire.exists(thisUnit) then
                            if floor(ttd(thisUnit) / (2 * hasteAmount)) * sunfire_target >= ceil(floor(2 / sunfire_target) * 1.5) + 2 * sunfire_target
                            and (sunfire_target > 1 + moonfiretalent or debuff.moonfire.exists(thisUnit))
                            and (not traits.streakingStars.active or not pewbuff or LastDamageSpell ~= 'sunfire')
                            and ((buff.incarnationChoseOfElune.remain() > debuff.sunfire.remain(thisUnit)
                            or buff.celestialAlignment.exists() and buff.celestialAlignment.remain() < debuff.sunfire.remain(thisUnit)) or not pewbuff)
                            or isBoss(thisUnit) then
                                if cast.sunfire(thisUnit) then
                                    br.addonDebug("Initial Sunfire - non-Cluster")
                                    return true
                                end
                            end
                        elseif debuff.sunfire.exists(thisUnit) and debuff.sunfire.remain(thisUnit) < 5 and ttd(thisUnit) > 5 then
                            if cast.sunfire(thisUnit) then
                                br.addonDebug("Refreshing sunfire - remain: " .. debuff.sunfire.remain(thisUnit))
                                return true
                            end
                        end
                    end

                    --moonfire,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))*spell_targets>=6&(!variable.az_ss|!buff.ca_inc.up|!prev.moonfire)&(buff.ca_inc.remains>remains|!buff.ca_inc.up)
                    if talent.twinMoons and debuff.moonfire.count() == 0 then
                        if cast.moonfire(getBiggestUnitCluster(45, 15)) then
                            br.addonDebug("Initial moonfire - Cluster")
                            return true
                        end
                    end

                    if cast.able.moonfire() and (debuff.moonfire.count() < getOptionValue("Max Moonfire Targets") or debuff.moonfire.exists(thisUnit)) or isBoss(thisUnit) and
                            astral_def >= 3 then
                        if not debuff.moonfire.exists(thisUnit) then
                            if
                            (floor(ttd(thisUnit) / (2 * hasteAmount)) * #enemies.yards8t >= 6
                                    and (not traits.streakingStars.active or not pewbuff or LastDamageSpell ~= 'moonfire')
                                    and
                                    (
                                            (buff.incarnationChoseOfElune.exists() and buff.incarnationChoseOfElune.remain() > debuff.moonfire.remain(thisUnit)
                                                    or buff.celestialAlignment.exists() and buff.celestialAlignment.remain() > debuff.moonfire.remain(thisUnit)
                                            ) or not pewbuff
                                    )
                                    or isBoss(thisUnit)
                            )
                            then
                                if cast.moonfire(thisUnit) then
                                    br.addonDebug("Initial Moonfire")
                                    return true
                                end
                            end
                        elseif debuff.moonfire.exists(thisUnit) and debuff.moonfire.remain(thisUnit) < 6 and ttd(thisUnit) > 5 then
                            if cast.moonfire(thisUnit) then
                                br.addonDebug("Refreshing moonfire - remain: " .. debuff.moonfire.remain(thisUnit))

                                return true
                            end
                        end
                    end


                    --stellar_flare,target_if=refreshable,if=ap_check&floor(target.time_to_die%(2*spell_haste))>=5&(!variable.az_ss|!buff.ca_inc.up|!prev.stellar_flare)
                    if cast.able.stellarFlare() and LastDamageSpell ~= 'stellarFlare' and (debuff.stellarFlare.count() < getOptionValue("Max Stellar Flare Targets") or debuff.stellarFlare.exists(thisUnit)) or isBoss(thisUnit) and
                            astral_def >= 8 then
                        if not debuff.stellarFlare.exists(thisUnit) then
                            if (floor(ttd(thisUnit) / (2 * hasteAmount)) >= 5) or isBoss(thisUnit) then
                                if cast.stellarFlare(thisUnit) then
                                    br.addonDebug("Initial stellarFlare")
                                    return true
                                end
                            end
                        elseif debuff.stellarFlare.exists(thisUnit) and debuff.stellarFlare.remain(thisUnit) < 6 and ttd(thisUnit) > debuff.stellarFlare.remain(thisUnit) + 5 then
                            if cast.stellarFlare(thisUnit) then
                                br.addonDebug("Refreshing stellarFlare - remain: " .. debuff.stellarFlare.remain(thisUnit))
                                return true
                            end
                        end
                    end
                end
            end
        end

        
        -- GENERATORS

        --new_moon,if=ap_check
        if cast.able.newMoon() and (power <= 90) then
            if cast.newMoon(units.dyn45) then
                return
            end
        end

        --half_moon,if=ap_check
        if cast.able.halfMoon() and (power <= 80) then
            if cast.halfMoon(units.dyn45) then
                return
            end
        end

        --full_moon,if=ap_check
        if cast.able.fullMoon() and (power <= 60) then
            if cast.fullMoon(units.dyn45) then
                return
            end
        end
        
        -- llunar_strike,if=buff.solar_empowerment.stack<3
        -- &(ap_check|buff.lunar_empowerment.stack=3)
        -- &((buff.warrior_of_elune.up|buff.lunar_empowerment.up|spell_targets>=2&!buff.solar_empowerment.up)&(!variable.az_ss|!buff.ca_inc.up)|variable.az_ss&buff.ca_inc.up&prev.solar_wrath)
        
        if cast.able.lunarStrike() 
        and buff.solarEmpowerment.stack() < 3
        and (astral_def >= 12 or buff.lunarEmpowerment.stack() == 3) 
        and ((buff.warriorOfElune.exists() or buff.lunarEmpowerment.exists() or #enemies.yards8t >= 2 and not buff.solarEmpowerment.exists()) and (not traits.streakingStars.active or not pewbuff) or traits.streakingStars.active and pewbuff and cast.last.solarWrath()) then
            if mode.DPS < 3 then
                if cast.lunarStrike(getBiggestUnitCluster(45, 8)) then
                    br.addonDebug("Lunarstrike(cluster) Solar: " .. buff.solarEmpowerment.stack() .. " Lunar: " .. buff.lunarEmpowerment.stack())
                    return true
                end
            elseif mode.DPS == 3 then
                if cast.lunarStrike(units.dyn45) then
                    br.addonDebug("Lunarstrike Solar: " .. buff.solarEmpowerment.stack() .. " Lunar: " .. buff.lunarEmpowerment.stack())
                    return true
                end
            end
        end

        --solar_wrath,if=variable.az_ss<3|!buff.ca_inc.up|!prev.solar_wrath
        if cast.able.solarWrath() 
        and (traits.streakingStars.active or not pewbuff or LastDamageSpell ~= 'solarWrath') then
            if cast.solarWrath(units.dyn45) then
                br.addonDebug("Wrath - Solar: " .. buff.solarEmpowerment.stack() .. " Lunar: " .. buff.lunarEmpowerment.stack())
                return true
            end
        end

        -- MOVEMENT

        --sunfire
        if LastDamageSpell ~= 'sunfire' then
            if cast.sunfire(units.dyn45) then
                if not isMoving("player") then
                    br.addonDebug("FAIL! (Sunfire) Lunarstacks: " .. buff.lunarEmpowerment.stack() .. " Solarstacks: " .. buff.solarEmpowerment.stack() .. " Astral: " .. power .. " TTD: " .. ttd("target"))
                else
                    br.addonDebug("Fallback: Moving - sunfire")
                    return true                 
                end
            end
        else
            if cast.moonfire(units.dyn45) then
                if not isMoving("player") then
                    br.addonDebug("FAIL! (moonfire) Lunarstacks: " .. buff.lunarEmpowerment.stack() .. " Solarstacks: " .. buff.solarEmpowerment.stack() .. " Astral: " .. power .. " TTD: " .. ttd("target"))
                else
                    br.addonDebug("Fallback: Moving - moonfire")
                    return true
                end
            end
        end
    end

    local function defensive()

        --Bear Form Key-br.player.buff.bearForm.exists()
        if isChecked("Bear Form Key") and not buff.bearForm.exists("player") and SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            if cast.bearForm("player") then
                return true
            end
        elseif isChecked("Bear Form Key") and buff.bearForm.exists("player") and SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            return
        elseif isChecked("Bear Form Key") and buff.bearForm.exists("player") and not SpecificToggle("Bear Form Key") and not GetCurrentKeyBoardFocus() then
            if cast.moonkinForm() then
                return true
            end
        end

        -- Pot/Stoned
        if isChecked("Potion/Healthstone") and php <= getValue("Potion/Healthstone") then
            if inCombat and (hasHealthPot() or hasItem(5512) or hasItem(166799)) then
                if canUseItem(5512) then
                    br.addonDebug("Using Healthstone")
                    useItem(5512)
                elseif hasItem(156634) and canUseItem(156634) then
                    br.addonDebug("Using Silas' Vial of Continuous Curing")
                    useItem(156634)
                elseif hasItem(166799) and canUseItem(166799) then
                    br.addonDebug("Using Emerald of Vigor")
                    useItem(166799)
                elseif canUseItem(healPot) then
                    br.addonDebug("Using Health Pot")
                    useItem(healPot)
                end
            end
        end

        -- Renewal
        if isChecked("Renewal") and talent.renewal and php <= getValue("Renewal") then
            if cast.renewal("player") then
                return
            end
        end
        -- Barkskin
        if isChecked("Barkskin") and php <= getValue("Barkskin") then
            if cast.barkskin() then
                return
            end
        end
        -- Swiftmend
        if talent.restorationAffinity and isChecked("Swiftmend") and php <= getValue("Swiftmend") and charges.swiftmend.count() >= 1 then
            if cast.swiftmend("player") then
                return true
            end
        end
        -- Regrowth
        if isChecked("Regrowth") and not moving and php <= getValue("Regrowth") then
            if cast.regrowth("player") then
                return true
            end
        end
        -- Rebirth
        if inCombat and isChecked("Rebirth") and cd.rebirth.remain() <= gcd and not isMoving("player") then
            if getOptionValue("Rebirth") == 1 then
                local tanks = getTanksTable()
                for i = 1, #tanks do
                    local thisUnit = tanks[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 2 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitGroupRolesAssigned(thisUnit) == "HEALER" and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 3 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and (UnitGroupRolesAssigned(thisUnit) == "TANK" or UnitGroupRolesAssigned(thisUnit) == "HEALER") and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            elseif getOptionValue("Rebirth") == 4 then
                if GetUnitExists("mouseover") and UnitIsDeadOrGhost("mouseover") and GetUnitIsFriend("mouseover", "player") then
                    if cast.rebirth("mouseover", "dead") then
                        return true
                    end
                end
            elseif getOptionValue("Rebirth") == 5 then
                for i = 1, #br.friend do
                    local thisUnit = br.friend[i].unit
                    if UnitIsDeadOrGhost(thisUnit) and UnitIsPlayer(thisUnit) then
                        if cast.rebirth(thisUnit, "dead") then
                            return true
                        end
                    end
                end
            end
        end

        -- offheal
        local offheal = false
        if getOptionValue("offheal") == 2 then
            offheal = true
        elseif getOptionValue("offheal") == 3 then
            for i = 1, #br.friend do
                local thisUnit = br.friend[i].unit
                if UnitIsDeadOrGhost(thisUnit) and UnitGroupRolesAssigned(thisUnit) == "HEALER" and UnitIsPlayer(thisUnit) then
                    offheal = true
                end
            end
        end

        -- Remove Corruption
        if isChecked("Remove Corruption") then
            if getOptionValue("Remove Corruption") == 1 then
                if canDispel("player", spell.removeCorruption) then
                    if cast.removeCorruption("player") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 2 then
                if canDispel("target", spell.removeCorruption) then
                    if cast.removeCorruption("target") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 3 then
                if canDispel("player", spell.removeCorruption) then
                    if cast.removeCorruption("player") then
                        return true
                    end
                elseif canDispel("target", spell.removeCorruption) then
                    if cast.removeCorruption("target") then
                        return true
                    end
                end
            elseif getOptionValue("Remove Corruption") == 4 then
                if canDispel("mouseover", spell.removeCorruption) then
                    if cast.removeCorruption("mouseover") then
                        return true
                    end
                end
            elseif (getOptionValue("Remove Corruption") == 5 or offheal == true) then
                for i = 1, #br.friend do
                    if canDispel(br.friend[i].unit, spell.removeCorruption) then
                        if cast.removeCorruption(br.friend[i].unit) then
                            return true
                        end
                    end
                end
            end
        end
    end

    local function interrupts()
        if useInterrupts() then
            for i = 1, #enemies.yards45 do
                local thisUnit = enemies.yards45[i]
                if canInterrupt(thisUnit, getValue("InterruptAt")) then
                    -- Solar Beam
                    if isChecked("Solar Beam") then
                        if cast.solarBeam(thisUnit) then
                            return
                        end
                    end
                    -- Typhoon
                    if isChecked("Typhoon") and talent.typhoon and getDistance(thisUnit) <= 15 then
                        if cast.typhoon() then
                            return
                        end
                    end
                    -- Mighty Bash
                    if isChecked("Mighty Bash") and talent.mightyBash and getDistance(thisUnit) <= 10 then
                        if cast.mightyBash(thisUnit) then
                            return true
                        end
                    end
                end
            end
        end
    end

    local function isCC(unit)
        if getOptionCheck("Don't break CCs") then
            return isLongTimeCCed(Unit)
        end
        return false
    end

    local function root_cc()

        local root_UnitList = {}
        if isChecked("Freehold - root grenadier") then
            root_UnitList[129758] = "Irontide Grenadier"
        end
        if isChecked("Atal - root Spirit of Gold") then
            root_UnitList[131009] = "Spirit of Gold"
        end
        if isChecked("All - root Emissary of the Tides") then
            root_UnitList[155434] = "Emissary of the Tides"
        end

        for i = 1, #enemies.yards45 do
            thisUnit = enemies.yards45[i]

            if isChecked("Auto Soothe") then
                if cast.able.soothe() and canDispel(thisUnit, spell.soothe) then
                    if cast.soothe(thisUnit) then
                        return true
                    end
                end
            end
            --Enchanted emmisary == 155432
            if isChecked("Punt Enchanted Emissary") and inInstance then
                if GetObjectID(thisUnit) == 155432 then
                    if #tanks > 0 and getDistance(tank, thisUnit) <= 25 then
                        br.addonDebug("Punting Emissary - Range from tank: " .. getDistance(tank, thisUnit))
                        if cast.moonfire(thisUnit) then
                            return true
                        end
                    end
                end
            end
            if isChecked("Freehold - root grenadier") or isChecked("Atal - root Spirit of Gold") or isChecked("All - root Emissary of the Tides") or isChecked("KR - Minions of Zul") then
                --br.addonDebug("Mob: " .. thisUnit .. " Health: " .. getHP(thisUnit))
                if cast.able.massEntanglement() and isCC(thisUnit) and getHP(thisUnit) > 90 then
                    if (root_UnitList[GetObjectID(thisUnit)] ~= nil and getBuffRemain(thisUnit, 226510) <= 3) then
                        if cast.massEntanglement(thisUnit) then
                            br.addonDebug("Mass Rooting: " .. thisUnit)
                            return true
                        end
                    end
                end
                if cast.able.entanglingRoots() and isCC(thisUnit) and getHP(thisUnit) > 90 then
                    if (root_UnitList[GetObjectID(thisUnit)] ~= nil and getBuffRemain(thisUnit, 226510) <= 3) then
                        if cast.entanglingRoots(thisUnit) then
                            br.addonDebug("Rooting: " .. thisUnit)
                            return true
                        end
                    end
                end
            end
        end
    end

    local function PreCombat()
        -- Pre-Pull Timer
        if isChecked("Pre-Pull Timer") and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") then
            if PullTimerRemain() <= getOptionValue("Pre-Pull Timer") then
                if not br.player.buff.moonkinForm.exists() and not cast.last.moonkinForm(1) and not isMoving("player") then
                    if cast.moonkinForm() then
                        return true
                    end
                end
                if cast.solarWrath() then
                    return true
                end
            end
        end
        if isChecked("Auto Engage On Target") then
            if cast.sunfire() then
                return true
            end
        end
        if isChecked("Freehold - pig") and GetMinimapZoneText() == "Ring of Booty" then
            bossHelper()
        end
    end

    local function extras()
        --Resurrection
        if isChecked("Revive target") and not inCombat and not isMoving("player") then
            if UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and GetUnitIsFriend("target", "player") then
                if cast.revive("target", "dead") then
                    return true
                end
            end
        end
        -- Wild Growth
        if isChecked("OOC Wild Growth") and not isMoving("player") and php <= getValue("OOC Wild Growth") then
            if cast.wildGrowth() then
                return true
            end
        end
        -- Regrowth
        if isChecked("OOC Regrowth") and not isMoving("player") and php <= getValue("OOC Regrowth") then
            if cast.regrowth("player") then
                return true
            end
        end
        -- Shapeshift Form Management
        local standingTime = 0
        if DontMoveStartTime then
            standingTime = GetTime() - DontMoveStartTime
        end

        if mode.forms == 1 then
            if (travel or buff.catForm.exists()) and not buff.prowl.exists() and standingTime > 1 then
                if cast.moonkinForm("player") then
                    return true
                end
            end

            -- Flight Form
            if not inCombat and canFly() and not swimming and br.fallDist > 90 --[[falling > getOptionValue("Fall Timer")]] and br.player.level >= 58 and not buff.prowl.exists() then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    -- CancelShapeshiftForm()
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Aquatic Form
            if (not inCombat --[[or getDistance("target") >= 10--]]) and swimming and not travel and not buff.prowl.exists() and isMoving("player") then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    -- CancelShapeshiftForm()
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Travel Form
            if not inCombat and not swimming and br.player.level >= 58 and not buff.prowl.exists() and not catspeed and not travel and not IsIndoors() and IsMovingTime(1) then
                if GetShapeshiftForm() ~= 0 and not cast.last.travelForm() then
                    RunMacroText("/CancelForm")
                    CastSpellByID(783, "player")
                    return true
                else
                    CastSpellByID(783, "player")
                    return true
                end
            end
            -- Cat Form
            if not cat and not IsMounted() and not flying and IsIndoors() then
                -- Cat Form when not swimming or flying or stag and not in combat
                if moving and IsMovingTime(3) and not swimming and not flying and not travel then
                    if cast.catForm("player") then
                        return true
                    end
                end
                -- Cat Form - Less Fall Damage
                if (not canFly() or inCombat or br.player.level < 58) and (not swimming or (not moving and swimming and #enemies.yards5 > 0)) and br.fallDist > 90 then
                    --falling > getOptionValue("Fall Timer") then
                    if cast.catForm("player") then
                        return true
                    end
                end
            end
        end -- End Shapeshift Form Management

        --auto stuff in forms
        if cat then
            if isChecked("auto stealth") then
                if not br.player.buff.prowl.exists() then
                    if cast.prowl("Player") then
                        return true
                    end
                end
            end

            if isChecked("auto dash") and not catspeed then
                if cast.tigerDash() then
                    return true
                end
                if cast.dash() then
                    return true
                end
            end
        end
    end

    local function actionList_Opener()
        if ABOpener == false then
            if not SW1 then
                if cast.last.solarWrath() then
                    SW1 = true
                    br.addonDebug("Opener: SW1 Last Cast was Solarwrath")
                    return
                else 
                    cast.solarWrath()
                    SW1 = true
                    br.addonDebug("Opener: Solar Wrath 1 cast")
                    return
                end
            elseif SW1 and not SW2 then
                if cast.solarWrath() then
                    SW2 = true
                    br.addonDebug("Opener: Solar Wrath 2 cast")
                    return
                end
            elseif MF and not SF then
                if cast.sunfire() then
                    SF = true
                    br.addonDebug("Opener: Sunfire cast")
                    return
                end
            elseif SW2 and not MF then
                if cast.moonfire() then
                    MF = true
                    br.addonDebug("Opener: Moonfire cast")
                    return
                end
            elseif SF and not StF then
                if talent.stellarFlare then
                    if cast.stellarFlare() then
                        StF = true
                        br.addonDebug("Opener: Stellar Flare cast")
                        return
                    end
                else
                    StF = true
                    br.addonDebug("Opener: Stellar Flare not talented, bypassing")
                    return
                end
            elseif StF and not CA and power < 40 then
                if cast.solarWrath() then
                    br.addonDebug("Opener: Building Up AP")
                    return
                end
            elseif StF and not CA and power >= 40 then
                if talent.incarnationChoseOfElune and cd.incarnationChoseOfElune.remain() <= 3 then
                    if cast.incarnationChoseOfElune("player") then
                        br.addonDebug("Opener: Inc cast")
                        CA = true
                        return
                    end
                elseif not talent.incarnationChoseOfElune and cd.celestialAlignment.remain() <= 3 then
                    if cast.celestialAlignment("player") then
                        br.addonDebug("Opener: CA cast")
                        CA = true
                        return
                    end
                else
                    br.addonDebug("Opener: CA/Inc On CD, Bypassing")
                    CA = true
                    return
                end
            elseif CA then
                ABOpener = true
                br.addonDebug("Opener Complete")
                return
            end
        end
    end
    -----------------
    --- Rotations ---
    -----------------
    -- Pause
    if not (IsMounted() or br.player.buff.travelForm.exists() or br.player.buff.flightForm.exists()) or mode.rotation == 4 then
        if pause() or drinking or cast.current.focusedAzeriteBeam() then
            return true
        else

            ---------------------------------
            --- Out Of Combat - Rotations ---
            ---------------------------------
            if not inCombat and not UnitBuffID("player", 115834) then
                if extras() then return true end
                if useDefensive() then
                    if defensive() then return true end
                end
                if PreCombat() then return true end
            end
        end -- End Out of Combat Rotation
        -----------------------------
        --- In Combat - Rotations ---
        -----------------------------
        if inCombat and not UnitBuffID("player", 115834) then
            if useInterrupts() then
                if interrupts() then return true end
            end

            if useDefensive() then
                if defensive() then return true end
            end

            if root_cc() then return true end

            if ABOpener == false and isChecked("Opener") and (GetObjectExists("target") and isBoss("target")) then
                if actionList_Opener() then return true end
            else
                if dps() then return true end
            end
        end -- End In Combat Rotation
    end -- Pause
end -- End runRotation

local id = 102
if br.rotations[id] == nil then
    br.rotations[id] = {}
end

tinsert(br.rotations[id], {
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})