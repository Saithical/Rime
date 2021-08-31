rime.pvp.Revenant.routes = {

    ["black"] = {
        ["blurb"] = {"Brute Retri"},
        ["weapon"] = "1handblades",
        ["chirography"] = {
            "killatdum",
            "aneda_right",
            "aneda_left",
            "atdum",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "deceive",
            "duplicity",
        },
        ["venoms"] = {
            "shoveStupid", -- shoves aconite if they're locked
            "lockAsthma", -- shoves kalmia if they're 1 aff away from lock
            "lockSlickness",
            "lockAnorexia",
            "mortalterror",
            "paresis",
            "clumsiness",
            "outdoor_stupidity",
            "asthma",
            "disfigurement",
            "mental_disruption",
            "stupidity",
            "buffSlickness",
            "weariness",
            "crippled",
            "physical_disruption",
            "crippled_body",
            "left_arm_broken",
            "right_arm_broken",
            "left_leg_broken",
            "right_leg_broken",
        },

    },
    
    ["white"] = {
        ["blurb"] = {"phys affs into transpierce"},
        ["weapon"] = "1handblades",
        ["chirography"] = {
            "stunatdum",
            "wilaveeespam",
            "atdum",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "transpierce",
            "deceive",
            "wilaveee",
            "duplicity",
        },
        ["venoms"] = {
            "shoveLBA",
            "shoveRBA",
            "paresis",
            "no_deaf",
            "clumsiness",
            "asthma",
            "vomiting",
            "allergies",
            "sensitivity",
            "buffSlickness",
            "haemophilia",
            "mental_disruption",
            "weariness",
            "anorexia",
            "stupidity",
            "mortalterror",
            "physical_disruption",
            "crippled",
            "crippled_body",
        },
    },

    ["red"] = {
        ["blurb"] = {"Blood for the blood god!"},
        ["weapon"] = "1handblades",
        ["chirography"] = {
            "double_lawid",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "grouptranspierce",
            "deceive",
            "duplicity",
        },
        ["venoms"] = {
            "damage",
            "damage",
        },
    },

    ["group"] = {
        ["blurb"] = {"Group route for when they call \"affs\""},
        ["weapon"] = "1handblades",
        ["chirography"] = {
            "double_lawid",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "grouptranspierce",
            "deceive",
            "duplicity",
        },
        ["venoms"] = {
            "asthma",
            "paresis",
            "slickness",
            "anorexia",
            "haemophilia",
            "no_deaf",
            "sensitivity",
            "damage",
            "damage",
        },
    },

    ["limbs"] = {
        ["blurb"] = {"Group route for when they call \"limbs\""},
        ["weapon"] = "1handblades",
        ["chirography"] = {
            "double_lawid",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "grouptranspierce",
            "deceive",
            "duplicity",
        },
        ["venoms"] = {
            "left_leg_broken",
            "right_leg_broken",
            "left_arm_broken",
            "right_arm_broken",
            "asthma",
            "slickness",
            "anorexia",
            "stupidity",
            "haemophilia",
            "damage",
            "damage",
        },
    },

    ["mace"] = {
        ["blurb"] = {"That's my purse! I don't know you!"},
        ["weapon"] = "1handblunts",
        ["chirography"] = {
            "limb_lawid",
            "wasiatdum",
            "limbatdum",
            --"double_telvi",
        },
        ["attack"] = {
            "extirpate",
            "cull",
            "hemoclysm",
            "limbtranspierce",
            "deceive",
            "wilaveee",
            "breakCheck",
        },
        ["venoms"] = {
            "lura",
        },
        ["limbs"] = {
            "right_leg",
            "left_leg",
            "right_arm",
            "left_arm",
            "torso",
            "head",
        },
    },

}

rev = rev or {}

rev.attacks = rev.attacks or {}
rev.slashes = rev.slashes or {}
rev.can = rev.can or {}

rev.need_circle = false
lastLimbHit = "none"
prerestoredLimb = "none"

-- Limb Functions
function rev.mostDamaged(limb)
    local max = rime.targets[rime.target].limbs[limb]
    for k, v in pairs(rime.targets[rime.target].limbs) do
        if k ~= limb and v >= max then
            return false
        end
    end
    return true
end
function rev.canClobber(limb)
    local dmg = 893
    dmg = dmg*2 -- clobber
    if rime.targets[rime.target].limbs[limb] < 3333 and (rime.targets[rime.target].limbs[limb]+dmg) >= 3333 then
        return true
    else
        return false
    end
end
function rev.canBreak(limb)
    local dmg = 893
    if rime.targets[rime.target].limbs[limb] < 3333 and (rime.targets[rime.target].limbs[limb]+dmg) >= 3333 then
        return true
    end
    return false
end
function rev.canDoubleBreak(limbs)
    local dmg = 893
    if limbs == "arms" then
        if rime.targets[rime.target].limbs.left_arm < 3333 and rime.targets[rime.target].limbs.right_arm < 3333 then
            if rime.targets[rime.target].limbs.left_arm+dmg >= 3333 and rime.targets[rime.target].limbs.right_arm+dmg >= 3333 then
                return true
            end
        end
    elseif limbs == "legs" then
        if rime.targets[rime.target].limbs.left_leg < 3333 and rime.targets[rime.target].limbs.right_leg < 3333 then
            if rime.targets[rime.target].limbs.left_leg+dmg >= 3333 and rime.targets[rime.target].limbs.right_leg+dmg >= 3333 then
                return true
            end
        end
    end
    
    return false
end
function rev.limbSelect(num)
    local last_parried = rime.targets[rime.target].parry
    -- Supposedly, returns x number of unique things from priority list.
    local limbnum = tonumber(num)
    local iterations = tonumber(0)
    local limbList = {}
    local failCase = 0
    while limbnum > iterations do
        for k, v in pairs(rime.pvp.route.limbs) do
            local mostDamage = rev.mostDamaged(v)
                if not rime.pvp.canParry() then
                    if table.contains(limbList, v) == false
                        and prerestoredLimb ~= v then
                        table.insert(limbList, v)
                        iterations = iterations+1
                        break
                    end
                else
                -- parry
                if table.contains(limbList, v) == false
                and lastLimbHit ~= v
                and prerestoredLimb ~= v
                and last_parried ~= v
                    and mostDamage ~= true then
                    table.insert(limbList, v)
                    iterations = iterations+1
                    break
                end
                end
            if failCase > 100 then
                rime.echo("shitfuckshit")
                return
            end
            failCase = failCase+1
        end
    end
    return limbList
end
function rev.breakCheck()
    local limbList = {}
    if rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canBreak("left_leg") and prerestoredLimb ~= "left leg" then
        table.insert(limbList, "left_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "left_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("PRONE/CAN'T PARRY: LEFT LEG 1")
    elseif rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canBreak("right_leg") and prerestoredLimb ~= "right leg" then
        table.insert(limbList, "right_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "right_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("PRONE/CAN'T PARRY: RIGHT LEG 1")
    elseif rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canBreak("torso") and prerestoredLimb ~= "torso" then
        table.insert(limbList, "torso")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "torso" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("PRONE/CAN'T PARRY: TORSO 1")
    elseif rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canClobber("left_leg") and prerestoredLimb ~= "left leg" then
        table.insert(limbList, "left_leg")
        table.insert(limbList, "left_leg")
        rime.echo("PRONE/CAN'T PARRY: LEFT LEG 2")
    elseif rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canClobber("right_leg") and prerestoredLimb ~= "right leg" then
        table.insert(limbList, "right_leg")
        table.insert(limbList, "right_leg")
        rime.echo("PRONE/CAN'T PARRY: RIGHT LEG 2")
    elseif rime.pvp.has_aff("prone") and not rime.pvp.canParry() and rev.canClobber("torso") and prerestoredLimb ~= "torso" then
        table.insert(limbList, "torso")
        table.insert(limbList, "torso")
        rime.echo("PRONE/CAN'T PARRY: TORSO 2")
    elseif rime.pvp.has_aff("prone") and rev.canBreak("left_leg") and prerestoredLimb ~= "left leg" then
        table.insert(limbList, "left_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "left_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("PRONE/CAN PARRY: LEFT LEG 1")
    elseif rime.pvp.has_aff("prone") and rev.canBreak("right_leg") and prerestoredLimb ~= "right leg" then
        table.insert(limbList, "right_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "right_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("PRONE/CAN PARRY: RIGHT LEG 1")
    elseif not rime.pvp.canParry() and rev.canDoubleBreak("legs") then
        table.insert(limbList, "left_leg")
        table.insert(limbList, "right_leg")
        rime.echo("CAN'T PARRY: DOUBLE LEGS")
    elseif not rime.pvp.canParry() and rev.canDoubleBreak("arms") then
        table.insert(limbList, "left_arm")
        table.insert(limbList, "right_arm")
        rime.echo("CAN'T PARRY: DOUBLE ARMS")
    elseif not rime.pvp.canParry() and rev.canBreak("left_leg") and prerestoredLimb ~= "left leg" then
        table.insert(limbList, "left_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "left_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("STAND/CAN'T PARRY: LEFT LEG 1")
    elseif not rime.pvp.canParry() and rev.canBreak("right_leg") and prerestoredLimb ~= "right leg" then
        table.insert(limbList, "right_leg")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "right_leg" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("STAND/CAN'T PARRY: RIGHT LEG 1")
    elseif not rime.pvp.canParry() and rev.canBreak("torso") and prerestoredLimb ~= "torso" then
        table.insert(limbList, "torso")
        local limbSecond = rev.limbSelect(2)
        if limbSecond[1] == "torso" then
            table.insert(limbList, limbSecond[2])
        else
            table.insert(limbList, limbSecond[2])
        end
        rime.echo("STAND/CAN'T PARRY: TORSO 1")
    elseif not rime.pvp.canParry() and rev.canClobber("torso") and prerestoredLimb ~= "torso" then
        table.insert(limbList, "torso")
        table.insert(limbList, "torso")
        rime.echo("STAND/CAN'T PARRY: TORSO 2")
    elseif not rime.pvp.canParry() and rev.canClobber("left_leg") and prerestoredLimb ~= "left leg" then
        table.insert(limbList, "left_leg")
        table.insert(limbList, "left_leg")
        rime.echo("STAND/CAN'T PARRY: LEFT LEG 2")
    elseif not rime.pvp.canParry() and rev.canClobber("right_leg") and prerestoredLimb ~= "right leg" then
        table.insert(limbList, "right_leg")
        table.insert(limbList, "right_leg")
        rime.echo("STAND/CAN'T PARRY: RIGHT LEG 2")
    else
        limbList = rev.limbSelect(2)
    end
    limbList = table.concat(limbList, " ") --turns the table we built into a string of entries.
    return limbList:gsub("_", " ")
end


rev.slashes = {

    ["anorexiaSeal"] = {
        "slike",
        "anorexia",
        can = function()
            local targ = rime.target
            local focusbal = rime.pvp.balanceCheck("focus", rime.target)
            if rime.pvp.has_aff("asthma", targ) and rime.pvp.has_aff("slickness", targ) and (rime.pvp.has_aff("stupidity", targ) or focusbal >= 2.2) then
                return true
            end
            return false
        end,
    },
    ["lockAnorexia"] = {
        "slike",
        "anorexia",
        can = function()
        local targ = rime.target
        local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
        if not rime.pvp.has_def("rebounding", targ) then
            if charged >= 140 then
                if #rime.missingAff("asthma/slickness/paresis", "/") < 3 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/slickness/paresis", "/") < 2 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            else
                if #rime.missingAff("asthma/slickness/paresis", "/") < 2 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/slickness/paresis", "/") < 1 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            end
        else
            if charged >= 140 then
                if #rime.missingAff("asthma/slickness/paresis", "/") < 2 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/slickness/paresis", "/") < 1 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            else
                if #rime.missingAff("asthma/slickness/paresis", "/") < 1 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatiences", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    end
                end
            end
        end
        return false
    end,
    },
    ["lockSlickness"] = {
        "gecko",
        "slickness",
        can = function()
        local targ = rime.target
        local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
         if not rime.pvp.has_def("rebounding", targ) then
            if charged >= 140 then
                if #rime.missingAff("asthma/anorexia/paresis", "/") < 3 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/anorexia/paresis", "/") < 2 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            else
                if #rime.missingAff("asthma/anorexia/paresis", "/") < 2 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/anorexia/paresis", "/") < 1 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            end
        else
            if charged >= 140 then
                if #rime.missingAff("asthma/anorexia/paresis", "/") < 2 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                    elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    elseif #rime.missingAff("asthma/anorexia/paresis", "/") < 1 and rev.slashes.shoveStupid.can() then
                        return true
                    end
                end
            else
                if #rime.missingAff("asthma/anorexia/paresis", "/") < 1 then
                    if rime.pvp.has_aff("stupidity", targ) or rime.pvp.has_aff("impatience", targ) then
                        return true
                 elseif rime.pvp.balanceCheck("focus", targ) > 2.2 then
                        return true
                    end
                end
            end
        end
        return false
    end,
    },
    ["lockAsthma"] = {
        "kalmia",
        "asthma",
        can = function()
        local targ = rime.target
        local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
        if not rime.pvp.has_def("rebounding", targ) then
            if charged >= 140 then
                if #rime.missingAff("slickness/anorexia/paresis", "/") < 3 then
                    return true
                end
            else
                if #rime.missingAff("slickness/anorexia/paresis", "/") < 2 then
                    return true
                end
            end
        else
            if charged >= 140 then
                if #rime.missingAff("slickness/anorexia/paresis", "/") < 2 then
                    return true
                end
            else
                if #rime.missingAff("slickness/anorexia/paresis", "/") < 1 then
                    return true
                end
            end
        end
        return false
    end,
    },
    ["shoveStupid"] = {
        "aconite",
        "stupidity",
        can = function()
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            local targ = rime.target
            if not rime.pvp.has_def("rebounding", targ) then
                if charged >= 140 then
                    if #rime.missingAff("asthma/slickness/anorexia/paresis", "/") < 3 then
                        return true
                    end
                else
                    if #rime.missingAff("asthma/slickness/anorexia/paresis", "/") < 2 then
                        return true
                    end
                end
            else
                if charged >= 140 then
                    if #rime.missingAff("asthma/slickness/anorexia/paresis", "/") < 2 then
                        return true
                    end
                else
                    if #rime.missingAff("asthma/slickness/anorexia/paresis", "/") < 1 then
                        return true
                    end
                end
            end
            return false
        end,
    },
    ["mentalBlocker"] = {
        "aconite",
        "stupidity",
        can = function()
            local targ = rime.target
            if not rime.pvp.has_aff("epilepsy", targ) then
                return true
            end
            return false
        end,
    },
    ["shoveLBA"] = {
        "epteth",
        "left_arm_broken",
        can = function()
        local targ = rime.target
        if not rime.pvp.has_def("rebounding", targ) then
            if #rime.missingAff("asthma/slickness/deconblock/paresis", "/") < 2 then
                return true
            end
        else
            if rime.pvp.has_aff("locked", targ) then
                return true
            end
        end
        return false
    end,
    },
    ["shoveRBA"] = {
        "epteth",
        "right_arm_broken",
        can = function()
        local targ = rime.target
        if not rime.pvp.has_def("rebounding", targ) then
            if #rime.missingAff("asthma/slickness/deconblock/paresis", "/") < 2 then
                return true
            end
        else
            if rime.pvp.has_aff("locked", targ) then
                return true
            end
        end
        return false
    end,
    },
    ["shoveLBL"] = {
        "epseth",
        "left_leg_broken",
        can = function()
        local targ = rime.target
        if not rime.pvp.has_def("rebounding", targ) then
            if #rime.missingAff("asthma/slickness/deconblock/paresis", "/") < 2 then
                return true
            end
        else
            if rime.pvp.has_aff("locked", targ) then
                return true
            end
        end
        return false
    end,
    },
    ["shoveRBL"] = {
        "epseth",
        "right_leg_broken",
        can = function()
        local targ = rime.target
        if not rime.pvp.has_def("rebounding", targ) then
            if #rime.missingAff("asthma/slickness/deconblock/paresis", "/") < 2 then
                return true
            end
        else
            if rime.pvp.has_aff("locked", targ) then
                return true
            end
        end
        return false
    end,
    },
    ["outdoor_stupidity"] = {
        "aconite",
        "stupidity",
        can = function()
            if rime.pvp.room.indoors then
                return false
            elseif rime.pvp.has_aff("epilepsy") then
                return true 
            elseif (rev.aneda_left_scribed or rev.aneda_right_scribed) or rime.pvp.balanceCheck("focus") < 2.3 then
                return true
            end
            return false
        end,
    },
    ["mortalterror"] = {
        "bimre",
        "mortalterror",
        can = function()
        if rime.pvp.has_aff("mortalterror", rime.target) then
            return false
        else
            return true
        end
    end,
    },
    ["mental_disruption"] = {
        "dirne",
        "mental_disruption",
        can = function()
            return true
        end,
    },
    ["physical_disruption"] = {
        "dirne",
        "physical_disruption",
        can = function()
            return true
        end,
    },
    ["crippled"] = {
        "azu",
        "crippled",
        can = function()
            if rime.pvp.has_aff("crippled_body", rime.target) then
                return false
            end
            return true
        end,
    },
    ["crippled_body"] = {
        "azu",
        "crippled_body",
        can = function()
            return true
        end,
    },
    ["flared"] = {
        "livfa",
        "flared",
        can = function()
            return true
        end,
    },
    ["stun"] = {
        "adil",
        "stun",
        can = function()
            return true
        end,
    },
    ["damage"] = {
        "wilave",
        "damage",
        can = function()
            return true
        end,
    },
    ["lura"] = {
        "lura",
        "limbdamage",
        can = function()
            return true
        end,
    },
    ["physical_disruption_stuff"] = {
        "dirne",
        "physical_disruption",
        can = function()
            if rime.pvp.has_aff("mental_disruption", rime.target) then
                return true
            end
            return false
        end,
    },

    ["mental_disruption_outdoor"] = {
        "dirne",
        "mental_disruption",
        can = function()
            if rime.pvp.room.indoors then
                return false
            elseif rev.aneda_left_scribed or rev.aneda_right_scribed then
                return true
            end
        end,
    },

    ["mental_disruption_phys"] = {
        "dirne",
        "mental_disruption",
        can = function()
            local targ = rime.target
            if rime.pvp.has_aff("physical_disruption", targ) then
                return false
            else
                return true
            end
        end,
    },

    ["paresis"] = {
        "curare",
        "paresis",
        can = function()
        if rime.pvp.has_aff("paralysis", rime.target) then
        	return false
        else
        	return true
        end
    end,
    },
    ["peace"] = {
        "ouabain",
        "peace",
        can = function()
        targ = rime.target
        if rime.pvp.has_aff("implant", targ) and implantVenom == "ouabain" then
            return false
        end
        return true
    end
    },
    ["clumsiness"] = {
        "xentio",
        "clumsiness",
        can = function()
        return true
    end
    },
    ["sleep"] = {
        "delphinium",
        "sleep",
        can = function()
        return true
    end
    },
    ["asthma"] = {
        "kalmia",
        "asthma",
        can = function()
        return true
    end
    },
    ["slickness"] = {
        "gecko",
        "slickness",
        can = function()
        return true
    end
    },
    ["buffSlickness"] = {
        "gecko",
        "slickness",
        can = function()
        targ = rime.target
        if rime.pvp.has_aff("asthma", targ) and (rime.pvp.has_aff("clumsiness", targ) or rime.pvp.has_aff("weariness", targ)) then
            return true
        end
        return false
    end
    },
    ["anorexia"] = {
        "slike",
        "anorexia",
        can = function()
        return true
    end
    },
    ["vomiting"] = {
        "euphorbia",
        "vomiting",
        can = function()
        return true
    end
    },
    ["allergies"] = {
        "darkshade",
        "allergies",
        can = function()
        return true
    end
    },
    ["voyria"] = {
        "voyria",
        "voyria",
        can = function()
        return true
    end
    },
    ["sensitivity"] = {
        "preFarar",
        "sensitivity",
        can = function()
        if rime.pvp.has_aff("no_deaf", rime.target) then
            return true
        end
        return true
    end
    },
    ["no_deaf"] = {
        "prefarar",
        "no_deaf",
        can = function()
        if rime.pvp.has_aff("sensitivity", rime.target) then
            return false
        else
            return true
        end
    end
    },
    ["blurry_vision"] = {
        "oCulus",
        "blurry_vision",
        can = function()
        if rime.pvp.has_aff("no_blind", rime.target) then
            return true
        end
        return false
    end
    },
    ["no_blind"] = {
        "oculus",
        "no_blind",
        can = function()
        return true
    end
    },
    ["ho_blind"] = {
        "oculus",
        "no_blind",
        can = function()
        if rime.pvp.has_aff("blurry_vision") then
            return false
        else
            return true
        end
    end
    },
    ["haemophilia"] = {
        "hepafarin",
        "haemophilia",
        can = function()
        return true
    end
    },
    ["stuttering"] = {
        "jalk",
        "stuttering",
        can = function()
        return true
    end
    },
    ["weariness"] = {
        "vernalius",
        "weariness",
        can = function()
        return true
    end
    },
    ["shyness"] = {
        "digitalis",
        "shyness",
        can = function()
        return true
    end
    },
    ["dizziness"] = {
        "larkspur",
        "dizziness",
        can = function()
        return true
    end
    },
    ["stupidity"] = {
        "aconite",
        "stupidity",
        can = function()
        return true
    end
    },
    ["disfigurement"] = {
        "monkshood",
        "disfigurement",
        can = function()
        local targ = rime.target
        local pet_classes = {"sentinel", "carnifex", "praenomen", "teradrim", "indorani"}
        if rime.pvp.has_aff("asthma", targ) and (rime.pvp.has_aff("clumsiness", targ) or rime.pvp.has_aff("weariness", targ)) and not rime.pvp.has_def("rebounding", targ) then
            for i=1,#pet_classes do
                if rime.cure_set == pet_classes[i] then
                    return true
                end
            end
        end
        return false
    end
    },
    ["right_leg_broken"] = {
        "epseth",
        "right_leg_broken",
        can = function()
        return true
    end
    },
    ["left_leg_broken"] = {
        "epseth",
        "left_leg_broken",
        can = function()
        if rime.pvp.has_aff("right_leg_broken", rime.target) then
            return true
        end
        return false
    end
    },
    ["right_arm_broken"] = {
        "epteth",
        "right_arm_broken",
        can = function()
        return true
    end
    },
    ["left_arm_broken"] = {
        "epteth",
        "left_arm_broken",
        can = function()
        if rime.pvp.has_aff("right_arm_broken", rime.target) then
            return true
        end
        return false
    end
    },
}

--This is a table that lists all of your possible attacks for Revenant
rev.attacks = {

	["juxtapose_ally"] = {
        "riving juxtapose ally",
        can = function()
            rime.pvp.ally = rime.pvp.ally or rime.saved.allies[1]
            for k,v in ipairs(rime.saved.allies) do
               if tonumber(rime.targets[v].aggro) > tonumber(rime.targets[rime.pvp.ally].aggro) and rime.targets[v].defences.defended == false then
                    rime.pvp.ally = v
                end
            end

            if tonumber(rime.targets[rime.pvp.ally].aggro) > 10 and not rime.targets[rime.pvp.ally].defences.defended and rime.pvp.ally ~= rime.target then
                if (rime.affTally > 5 or rime.vitals.percent_health < 40) or has_def("defending") then
                    return false 
                else
                    return true
                end
            end
            return false
        end,
    },

    ["circle"] = {
        "riving circle target",
        can = function()
            if rev.need_circle and not has_def("circling") then
                return true
            else
                return false
            end
        end
    },

    ["cull"] = {
        "chirography cull target",
        can = function()
            if #rime.missingAff("mental_disruption/physical_disruption/crippled_body/paralysis", "/") == 0 then
                return true
            else
                return false
            end
        end
    },

    ["deceive"] = {
        "riving deceive target",
        can = function()
            local targ = rime.target
            if rev.canSwing() and (rime.targets[targ].defences.rebounding or rime.targets[targ].defences.shielded) then
                if rime.pvp.route_choice == "mace" then
                    if rev.chirography.wasiatdum.can() then
                        return false
                    else
                        return true
                    end
                else
                    return true
                end
            end
            return false
        end,
    },
    ["hemoclysm"] = {
        "riving hemoclysm target pick1",
        can = function()
        local affs = rime.targets[rime.target].afflictions
        local bruises = {
                    "right_arm_bruised_critical",
                    "left_arm_bruised_critical",
                    "right_leg_bruised_critical",
                    "left_leg_bruised_critical",
                    "torso_bruised_critical",
                    "right_arm_bruised_moderate",
                    "left_arm_bruised_moderate",
                    "right_leg_bruised_moderate",
                    "left_leg_bruised_moderate",
                    "torso_bruised_moderate",
                }
            local bruisecount = 0
            local left_charged = rime.vitals.left_charge
            local right_charged = rime.vitals.right_charge
            if not (rev.canSwing() and left_charged >= 40 and right_charged >= 40) then return false end
            for k,v in ipairs(bruises) do
                if rime.pvp.has_aff(v, rime.target) then
                    bruisecount = bruisecount+1
                    if string.find(v, "critical") then
                        if string.find(v, "torso") or string.find(v, "head") then
                            rev.attacks.hemoclysm[1] = "chirography lurk target"..rime.saved.separator.."riving hemoclysm target "..v:gsub("(%a+)_bruised_%a+", "%1")
                        else
                            rev.attacks.hemoclysm[1] = "chirography lurk target"..rime.saved.separator.."riving hemoclysm target "..v:gsub("(%a+)_(%a+)_bruised_%a+", "%1 %2")
                        end
                        return true
                    elseif rev.bongoBonanza then --Bonus Round activated!
                        if string.find(v, "torso") or string.find(v, "head") then
                            rev.attacks.hemoclysm[1] = "chirography lurk target"..rime.saved.separator.."riving hemoclysm target "..v:gsub("(%a+)_bruised_%a+", "%1")
                        else
                            rev.attacks.hemoclysm[1] = "chirography lurk target"..rime.saved.separator.."riving hemoclysm target "..v:gsub("(%a+)_(%a+)_bruised_%a+", "%1 %2")
                        end
                        return true
                    else
                        rev.bongoBonanza = false
                        return false
                    end
                end
                rev.bongoBonanza = false
            end
            return false
        end
    },
    ["breakCheck"] = {
     "riving duplicity target pick1 pick2",
     can = function()
        if rev.canBreak("left_leg") and not rime.pvp.canParry() and not rime.pvp.has_aff("right_leg_broken", rime.target) and not rev.canDoubleBreak("legs") and not rime.pvp.has_aff("prone", rime.target) then
            rev.attacks.breakCheck[1] = "riving duplicity target left leg right leg lura baludu"
            return true
        elseif rev.canBreak("right_leg") and not rime.pvp.canParry() and not rime.pvp.has_aff("left_leg_broken", rime,target) and not rev.canDoubleBreak("legs") and not rime.pvp.has_aff("prone", rime.target) then
            rev.attacks.breakCheck[1] = "riving duplicity target right leg left leg lura baludu"
            return true
        else
            rev.attacks.breakCheck[1] = "riving duplicity target "..rev.breakCheck()
            return true
        end
     end
    },
    ["wilaveee"] = {
     "riving duplicity target nothing nothing wilave wilave",
     can = function()
        if rev.wilaveee then
            return true
        end
        return false
     end
    },
    ["limbPicker"] = {
        "riving fell target pick1 pick2",
        can = function()
            local target_limbs = table.copy(rime.targets[rime.target].limbs)
            local sort_limbs = sortedKeys(target_limbs)
            local sorted_limbs = {}
            local mode = rime.pvp.prediction_mode
            local last_parried = rime.targets[rime.target].parry
  
            for _, key in ipairs(sort_limbs) do
                table.insert(sorted_limbs, key)
            end
            for k, v in ipairs(rime.targets[rime.target].limbs) do
                if rime.limit[v .. "_restore"] then
                    table.remove(sorted_limbs, table.index_of(sorted_limbs, v))
                end
            end
  
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "head"))
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "right_arm"))
  
            if rime.pvp.canParry() and table.contains(sorted_limbs, last_parried) then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, last_parried))
            end
            if lastLimbHit ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, lastLimbHit:gsub(" ", "_")))
            end
            if prerestoredLimb ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, prerestoredLimb:gsub(" ", "_")))
            end

            if #sorted_limbs > 1 then
                rev.attacks.limbPicker[1] = "riving fell target "..sorted_limbs[1]:gsub("_", " ").." "..sorted_limbs[2]:gsub("_", " ")
                return true
            else
                rev.attacks.limbPicker[1] = "riving fell target "..sorted_limbs[1]:gsub("_", " ").." "..sorted_limbs[1]:gsub("_", " ")
                return true
            end
        end,

    },

    ["dupPicker"] = {
        "riving duplicity target pick1 pick2",
        can = function()
            local target_limbs = table.copy(rime.targets[rime.target].limbs)
            local sort_limbs = sortedKeys(target_limbs)
            local sorted_limbs = {}
            local mode = rime.pvp.prediction_mode
            local last_parried = rime.targets[rime.target].parry
  
            for _, key in ipairs(sort_limbs) do
                table.insert(sorted_limbs, key)
            end
            for k, v in ipairs(rime.targets[rime.target].limbs) do
                if rime.limit[v .. "_restore"] then
                    table.remove(sorted_limbs, table.index_of(sorted_limbs, v))
                end
            end
  
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "head"))
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "right_arm"))
  
            if rime.pvp.canParry() and table.contains(sorted_limbs, last_parried) then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, last_parried))
            end
            if lastLimbHit ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, lastLimbHit:gsub(" ", "_")))
            end
            if prerestoredLimb ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, prerestoredLimb:gsub(" ", "_")))
            end

            if #sorted_limbs > 1 then
                rev.attacks.dupPicker[1] = "riving duplicity target "..sorted_limbs[1]:gsub("_", " ").." "..sorted_limbs[2]:gsub("_", " ")
                return true
            else
                rev.attacks.dupPicker[1] = "riving duplicity target "..sorted_limbs[1]:gsub("_", " ").." "..sorted_limbs[1]:gsub("_", " ")
                return true
            end
        end,

    },
    ["duplicity"] = {
        "riving duplicity target",
        can = function()
            if rev.canSwing() then
                return true
            else
                return false
            end
        end,
    },
    ["locktranspierce"] = {
        "riving transpierce target",
        can = function()
            local targ = rime.target
            if (rime.pvp.has_aff("prone", targ) or rime.pvp.has_aff("frozen", targ) or rime.pvp.has_aff("indifference", targ) or rime.pvp.has_aff("paralysis", targ)
            or rime.pvp.has_aff("writhe_transfix", targ) or rime.pvp.has_aff("writhe_web", targ)) and (rev.target_locked() and rime.pvp.has_aff("sensitivity", targ) and rime.pvp.has_aff("stupidity", targ)) then
                return true
            else 
                return false
            end
        end
    },
    ["transpierce"] = {
        "riving transpierce target",
        can = function()
            local targ = rime.target
            if (rime.pvp.has_aff("prone", targ) or rime.pvp.has_aff("frozen", targ) or rime.pvp.has_aff("indifference", targ) or rime.pvp.has_aff("paralysis", targ)
            or rime.pvp.has_aff("writhe_transfix", targ) or rime.pvp.has_aff("writhe_web", targ)) 
            or rev.chirography.stunatdum.can() then
                if rime.pvp.has_aff("writhe_impaled", targ) then
                    return false
                elseif rev.canlurk and rime.pvp.count_affs("physical") >= 5 then
                    rev.attacks.transpierce[1] = "chirography lurk target"..rime.saved.separator.."riving transpierce target"
                    return true
                elseif rime.pvp.count_affs("physical") >= 5 then
                    rev.attacks.transpierce[1] = "riving transpierce target"
                    return true
                end
            end 
            return false
        end
    },
    ["limbtranspierce"] = {
        "riving transpierce target",
        can = function()
            local targ = rime.target
            if (rime.pvp.has_aff("prone", targ) or rime.pvp.has_aff("frozen", targ) or rime.pvp.has_aff("indifference", targ) or rime.pvp.has_aff("paralysis", targ)
            or rime.pvp.has_aff("writhe_transfix", targ) or rime.pvp.has_aff("writhe_web", targ)) 
            or rev.chirography.limbatdum.can() then
                if rime.pvp.has_aff("writhe_impaled", targ) then
                    return false
                elseif rev.canlurk then
                    rev.attacks.transpierce[1] = "quickwield both falcata falcata.2"..rime.saved.separator.."chirography lurk target"..rime.saved.separator.."riving transpierce target"
                else
                    rev.attacks.transpierce[1] = "quickwield both falcata falcata.2"..rime.saved.separator.."riving transpierce target"
                end
                if rime.pvp.has_aff("torso_damaged", targ) or rime.pvp.has_aff("torso_mangled", targ) then
                    return true
                elseif rime.pvp.has_aff("right_leg_mangled", targ) and rime.pvp.has_aff("left_leg_damaged", targ) then
                    return true
                elseif rime.pvp.has_aff("left_leg_mangled", targ) and rime.pvp.has_aff("right_leg_damaged", targ) then
                    return true
                end
            end 
            return false
        end
    },
    ["grouptranspierce"] = {
        "chirography lurk target"..rime.saved.separator.."riving transpierce target",
        can = function()
            local targ = rime.target
            if rime.pvp.has_aff("prone", targ) or rime.pvp.has_aff("frozen", targ) or rime.pvp.has_aff("indifference", targ) or rime.pvp.has_aff("paralysis", targ)
                or rime.pvp.has_aff("writhe_transfix", targ) or rime.pvp.has_aff("writhe_web", targ) or rime.pvp.target_tumbling then
                return true
            else 
                return false
            end
        end
    },
    ["tumblestop"] = {
        "riving transpierce target",
        can = function()
            local targ = rime.target
            if rime.pvp.target_tumbling then
                return true
            else
                return false
            end
        end
    },
    ["extirpate"] = {
        "riving extirpate",
        can = function()
            local targ = rime.target
            if rev.canSwing() and targetImpaled then
                return true
            else
                return false
            end
        end
    },
    ["shouldCheese"] = {
        "riving duplicity target epseth epseth nothing nothing",
        can = function()
            local target = rime.target
            local poulticeBalance = rime.pvp.balanceCheck("poultice", rime.target)
            local treeBalance = rime.pvp.balanceCheck("tree", rime.target)
            if not rime.targets[target].time.poultice then
                return false
            elseif not getStopWatchTime(rime.targets[target].time.poultice) then
                return false
            elseif rev.canSwing() and poulticeBalance >= 3 and not rime.pvp.has_aff("prone", rime.target) and not rime.pvp.has_aff("left_leg_broken", rime.target) and not rime.pvp.has_aff("right_leg_broken", rime.target) and not rime.targets[target].defences.rebounding then
                return true
            else
                return false
            end
        end,
    },


}

rev.chirography = {

    ["atdum"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM venom",
        can = function()
            local targ = rime.target
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            atdumslash = "wilave"
            if rev.canSwing() and charged >= 140 then
                for k,v in ipairs(rime.pvp.route.venoms) do
                    if not rime.pvp.has_aff(rev.slashes[v][2], targ) and rev.slashes[v][1] ~= rev.ven1 and rev.slashes[v][1] ~= rev.ven2 and rev.slashes[v].can() then
                        atdumslash = rev.slashes[v][1]
                        break
                    end
                end
                rev.chirography.atdum[1] = "chirography blade scribe left atdum " ..atdumslash
                return true
            else
                return false
            end
        end
    },

    ["stunatdum"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM ADIL",
        can = function()
            local targ = rime.target
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            atdumslash = "adil"
            if rev.canSwing() and charged >= 140 and rime.pvp.count_affs("physical") >= 5  then
                return true
            end
            return false
        end
    },
    ["limbatdum"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM ADIL",
        can = function()
            local targ = rime.target
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            atdumslash = "adil"
            if rev.canSwing() and charged >= 140 then
                return true
            else
                return false
            end
        end
    },
    ["wasiatdum"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM WASI",
        can = function()
            local targ = rime.target
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            atdumslash = "wasi"
            if rev.canSwing() and charged >= 140 and rime.pvp.has_def("rebounding", rime.target) and not rev.attacks.limbtranspierce.can() then
                return true
            else
                return false
            end
        end
    },

    ["killatdum"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM venom",
        can = function()
            local targ = rime.target
            local charged = math.min(rime.vitals.right_charge, rime.vitals.left_charge)
            atdumslash = "adil"
            if rev.canSwing() and charged >= 140 and #rime.missingAff("crippled_body/physical_disruption/mental_disruption/paralysis", "/") == 1 then
                --logic and index[1] manip for atdum/cull
                if not rime.pvp.has_aff("crippled_body", targ) and not rime.pvp.has_aff("crippled", targ) then
                    return false
                elseif not rime.pvp.has_aff("physical_disruption", targ) and not rime.pvp.has_aff("mental_disruption", targ) then
                    return false
                elseif not rime.pvp.has_aff("paralysis", targ) then
                    return false
                elseif not rime.pvp.has_aff("crippled_body", targ) and rime.pvp.has_aff("crippled", targ) then
                    rev.chirography.killatdum[1] = "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM AZU"..rime.saved.separator.."chirography cull "..targ
                    atdumslash = "azu"
                    return true
                elseif not rime.pvp.has_aff("mental_disruption", targ) then
                    rev.chirography.killatdum[1] = "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM DIRNE"..rime.saved.separator.."chirography cull "..targ
                    atdumslash = "dirne"
                    return true
                elseif not rime.pvp.has_aff("physical_disruption", targ) and rime.pvp.has_aff("mental_disruption", targ) then
                    rev.chirography.killatdum[1] = "CHIROGRAPHY BLADE SCRIBE LEFT ATDUM DIRNE"..rime.saved.separator.."chirography cull "..targ
                    atdumslash = "dirne"
                    return true
                end
            end
            return false
        end,
    },

    ["aneda_left"] = {
        "chirography blade scribe left aneda",
        can = function()
            local target = rime.target
            local charged = rime.vitals.left_charge
            if rev.canSwing() and charged >= 40 and not rev.aneda_left_scribed and not rime.pvp.room.indoors and not rime.pvp.has_aff("epilepsy", target) then
                return true
            else
                return false
            end
        end,
    },

    ["aneda_right"] = {
        "chirography blade scribe right aneda",
        can = function()
            local target = rime.target
            local charged = rime.vitals.right_charge
            if rev.canSwing() and charged >= 40 and not rev.aneda_right_scribed and not rime.pvp.room.indoors and not rime.pvp.has_aff("epilepsy", target) then
                return true
            else
                return false
            end
        end,
    },

    ["lawid_left"] = {
        "CHIROGRAPHY BLADE SCRIBE LEFT LAWID",
        can = function()
            local targ = rime.target
            local charged = rime.vitals.left_charge
            if rev.canSwing() and charged >= 40 then
                return true
            else
                return false
            end
        end
    },
    
    ["lawid_right"] = {
        "CHIROGRAPHY BLADE SCRIBE RIGHT LAWID",
        can = function()
            local targ = rime.target
            local charged = rime.vitals.right_charge
            if rev.canSwing() and charged >= 40 then
                return true
            else
                return false
            end
        end
    },

    ["double_lawid"] = {
        "chirography blade scribe left lawid".. rime.saved.separator .."chirography blade scribe right lawid",
        can = function()
            local targ = rime.target
            local left_charged = rime.vitals.left_charge
            local right_charged = rime.vitals.right_charge
            if rev.canSwing() and left_charged >= 40 and right_charged >= 40 then
                return true
            else
                return false
            end
        end
    },

    ["wilaveeespam"] = {
        "chirography blade scribe left lawid".. rime.saved.separator .."chirography blade scribe right lawid",
        can = function()
            local targ = rime.target
            local left_charged = rime.vitals.left_charge
            local right_charged = rime.vitals.right_charge
            if rev.canSwing() and left_charged >= 40 and right_charged >= 40 and rev.wilaveee then
                return true
            else
                return false
            end
        end
    },

    ["limb_lawid"] = {
        "chirography blade scribe left lawid".. rime.saved.separator .."chirography blade scribe right lawid",
        can = function()
            local affs = rime.targets[rime.target].afflictions
            local bruises = {
                    "right_arm_bruised_critical",
                    "left_arm_bruised_critical",
                    "right_leg_bruised_critical",
                    "left_leg_bruised_critical",
                    "torso_bruised_critical",
                    "right_arm_bruised_moderate",
                    "left_arm_bruised_moderate",
                    "right_leg_bruised_moderate",
                    "left_leg_bruised_moderate",
                    "torso_bruised_moderate",
                }
            local targ = rime.target
            local left_charged = rime.vitals.left_charge
            local right_charged = rime.vitals.right_charge
            if rev.canSwing() and left_charged >= 40 and right_charged >= 40 then
            for k,v in ipairs(bruises) do
                if rime.pvp.has_aff(v, rime.target) then
                    if string.find(v, "critical") then
                        return true
                    else
                        return false
                    end
                end
            end
            end
        end
    },

    ["double_telvi"] = {
        "chirography blade scribe left telvi".. rime.saved.separator .."chirography blade scribe right telvi",
        can = function()
            local targ = rime.target
            local left_charged = rime.vitals.left_charge
            local right_charged = rime.vitals.right_charge
            if rev.canSwing() and left_charged >= 120 and right_charged >= 120 then
                return true
            else
                return false
            end
        end
    },
}

atdumslash = "wilave"
rev.aneda_left_scribed = false
rev.aneda_right_scribed = false
rev.canlurk = true
rev.bongoBonanza = false
rev.wilaveee = false
rev.chimerized = {}

function rev.canSwing()

    local target = rime.target

    if rime.has_aff("left_arm_broken") or rime.has_aff("right_arm_broken") or rime.has_aff("paralysis")
    or rime.has_aff("writhe_transfix") or rime.has_aff("writhe_impaled") or rime.has_aff("writhe_web") then
        return false
    end

    return true

end

function rev.chiro()

    for k,v in ipairs(rime.pvp.route.chirography) do
        if rev.chirography[v].can() then
            return rev.chirography[v][1]:gsub("target", rime.target):gsub("ally", rime.pvp.ally)
        end
    end

    return false

end

function rev.atk()

    local targ = rime.target

    for k,v in ipairs(rime.pvp.route.attack) do
        if not rime.pvp.has_aff(v, targ) and rev.attacks[v].can() then
            return rev.attacks[v][1]:gsub("target", rime.target):gsub("ally", rime.pvp.ally)
        end
    end

    return false

end

function rev.venoms()
    rev.ven1 = false
    rev.ven2 = false
    local targ = rime.target

    for k,v in ipairs(rime.pvp.route.venoms) do
        if rev.ven1 ~= false then
            if not rime.pvp.has_aff(rev.slashes[v][2], targ) and rev.slashes[v].can() then
                if rev.slashes[v][1] ~= rev.ven1 and rev.slashes[v][1] ~= atdumslash then
                    rev.ven2 = rev.slashes[v][1]
                    break
                end
            end
        elseif not rime.pvp.has_aff(rev.slashes[v][2], targ) and rev.slashes[v].can() then
            if rev.slashes[v][1] ~= atdumslash then
                rev.ven1 = rev.slashes[v][1]
            end
        end
    end

    local bluntweapons = {"club", "flail", "mace", "morningstar", "greatmaul", "warhammer", "cudgel",}
    for k,v in pairs(bluntweapons) do
        if gmcp.Char.Vitals.wield_left:find(v) then
            if not rev.ven1 then rev.ven1 = "lura" end
            if not rev.ven2 then rev.ven2 = "lura" end
        end
    end

    if not rev.ven1 then rev.ven1 = "wilave" end
    if not rev.ven2 then rev.ven2 = "wilave" end

end

function rev.lock_swing()
    local missing = rime.missingAff("asthma/slickness/anorexia", "/")
    --check for two affs + 1 = venomlock
    if #missing == 1 and (rev.slashes[missing[1]][2] == rev.ven1 or rev.slashes[missing[1]][1] == rev.ven2) then
        return true
    elseif #missing == 2 and (rev.slashes[missing[1]][1] == rev.ven1 or rev.slashes[missing[1]][1] == rev.ven2) and (rev.slashes[missing[2]][1] == rev.ven1 or rev.slashes[missing[2]][1] == rev.ven2) then
        return true
    else
        return false
    end
end

function rev.target_locked()
    local targ = rime.target
    if rime.pvp.has_aff("asthma", targ) and rime.pvp.has_aff("slickness", targ) and (rime.pvp.has_aff("anorexia", targ) or (rime.pvp.has_aff("left_arm_broken", targ) and rime.pvp.has_aff("right_arm_broken", targ))) then
        return true
    else
        return false
    end
end

function rev.weapon_check()
    local left,right = "",""
    if rime.pvp.route.weapon == "1handblunts" then 
        left = rime.saved.revblunt1
        right = rime.saved.revblunt2
        if left ~= string.match(gmcp.Char.Vitals.wield_left, "%d+") or right ~= string.match(gmcp.Char.Vitals.wield_right, "%d+") then
            return "quickwield both "..left.." "..right
        end
    elseif rime.pvp.route.weapon == "2handblunt" then 
        left = rime.saved.rev2handblunt
        if left ~= string.match(gmcp.Char.Vitals.wield_left, "%d+") then
            return "quickwield both "..left.." "..right
        end
    elseif rime.pvp.route.weapon == "2handblade" then 
        left = rime.saved.rev2handblade
        if left ~= string.match(gmcp.Char.Vitals.wield_left, "%d+") then
            return "quickwield both "..left.." "..right
        end
    else
        left = rime.saved.revblade1
        right = rime.saved.revblade2
        if left ~= string.match(gmcp.Char.Vitals.wield_left, "%d+") or right ~= string.match(gmcp.Char.Vitals.wield_right, "%d+") then
            return "quickwield both "..left.." "..right
        end
    end
    return false
end

function rev.offense()
    --Meat and potatoes attack picking and command sending done here
    local target = rime.target
    local sep = rime.saved.separator
    rev.venoms() --this sets rev.ven1 and rev.ven2
    local riving_attack = rev.atk() or ""
    local venom_call = ""
    local command = ""

    if rev.chiro() ~= false then command =  rev.chiro() end

    if rev.weapon_check() then command = command..rev.weapon_check() end

    if riving_attack:find("duplicity") then
        if riving_attack:find("epseth epseth") then
            command = command.. sep .. riving_attack
            venom_call = "epseth/epseth"
        else
            command =  command.. sep .. riving_attack .. " " .. rev.ven2 .. " " .. rev.ven1
            venom_call = rev.ven2.."/"..rev.ven1
        end
    elseif riving_attack:find("deceive") then
        if riving_attack:find("epteth") then
            command =  command.. sep .. "target nothing"..sep..riving_attack
            venom_call = "epseth"
        else
            command  =  command.. sep .. "target nothing"..sep..riving_attack .. " " .. rev.ven1
            venom_call = rev.ven1
        end
    else
        command =  command.. sep .. riving_attack
    end

    if not has_def("circling") then
        command = command .. sep .. "riving circle "..rime.target
    end

    if rime.pvp.targetThere and rime.pvp.web_aff_calling and (riving_attack:find("duplicity") or riving_attack:find("deceive")) then

        local web_call = rime.pvp.omniCall(venom_call)
        command = rime.pvp.queue_handle() .. sep .. web_call .. sep .. command

    else

        command = rime.pvp.queue_handle() .. sep .. command

    end

    command = command:gsub(sep .. sep .. "+", sep)
    command = command .. rime.pvp.post_queue()

    if command ~= rime.balance_queue and command ~= rime.balance_queue_attempted then
        act(command)
        rime.balance_queue_attempted = command
    end

end
