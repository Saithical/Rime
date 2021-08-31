rime.pvp.Praenomen.routes = {

	["overpower"] = {

		["initial"] = {
			"shielded",
			"annihilate",
			"seize",
			"blood_rune",
			"blood_feast",
			"behead",
			"paresis",
			"asthma",
			"slickness",
			"no_blind",
			"sensitivity",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"vomiting",
			"allergies",
			"haemophilia",
			"voyria",
			"stun",
			"upset_effusion",
			"effused_blood",
			"sapped_dexterity",
			"minion_reset",
			"feed",
			"frenzy",
		},

		["whispers"] = {
			"temptation",
			"seduction",
			"impatience",
			"epilepsy",
			"loneliness",
			"berserking",
			"vertigo",
			"masochism",
			"recklessness",
			"confusion",
			"peace",
			"stupidity",
			"paranoia",
			"dementia",
			"indifference",
			"anorexia",
			"amnesia",

		}
	},

	["craze"] = {

		["initial"] = {
			"shielded",
			"annihilate",
			"seize",
			"blood_rune",
			"blood_feast",
			"behead",
			"paresis",
			"asthma",
			"slickness",
			"no_blind",
			"sensitivity",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"vomiting",
			"allergies",
			"haemophilia",
			"voyria",
			"upset_effusion",
			"effused_blood",
			"stun",
			"sapped_dexterity",
			"minion_reset",
			"rend",
			"feed",
			"frenzy",
		},

		["whispers"] = {
			"impatience",
			"epilepsy",
			"dementia",
			"confusion",
			"paranoia",
			"loneliness",
			"vertigo",
			"agoraphobia",
			"masochism",
			"recklessness",
			"stupidity",
			"indifference",
			"anorexia",
			"amnesia",
		}
	},

	["leech"] = {

		["initial"] = {
			"shielded",
			"annihilate",
			"seize",
			"blood_rune",
			"blood_feast",
			"behead",
			"paresis",
			"asthma",
			"slickness",
			"no_blind",
			"sensitivity",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"vomiting",
			"allergies",
			"haemophilia",
			"voyria",
			"upset_effusion",
			"effused_blood",
			"stun",
			"sapped_dexterity",
			"minion_reset",
			"rend",
			"feed",
			"frenzy",
		},

		["whispers"] = {
			"impatience",
			"epilepsy",
			"stupidity",
			"loneliness",
			"confusion",
			"peace",
			"vertigo",
			"agoraphobia",
			"masochism",
			"recklessness",
			"paranoia",
			"dementia",
			"indifference",
			"anorexia",
			"amnesia",
		}
	},

	["black"] = {

		["initial"] = {
      		"annihilate",
      		"seize",
      		"mind_para",
			"asthma",
			"slickness",
			"disrupted",
			"paresis",
			"sensitivity",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"vomiting",
			"allergies",
			"haemophilia",
			"voyria",
			"upset_effusion",
			"effused_blood",
			"stun",
			"sapped_dexterity",
    		"feed",
			"frenzy",
			},

		["whispers"] = {
			"temptation",
			"seduction",
			"impatience",
     		"epilepsy",
     		"confusion",
     		"stupidity",
     		"loneliness",
     		"berserking",
			"peace",
			"recklessness",
			"vertigo",
			"masochism",
			"agoraphobia",
			"paranoia",
			"dementia",
			"anorexia",
			"indifference",
			"amnesia",
			},
		},
 

}

prae = prae or {}

prae.initials = prae.initials or {}

prae.thirst = prae.thirst or false

prae.can_spew = prae.can_spew or true

prae.can_seize = prae.can_seize or true

prae.can_trill = prae.can_trill or true

--This is a table that lists all of your possible Praenomen attacks that go before whispers or can't be combo'd with whispers

prae.initials = {

	["mind_para"] = {
		"mind paralyse target",
		choice = function()
			return prae.initials.mind_para[1]
		end,
		can = function()
			if not rime.saved.torc then return false end
			local target = rime.target
			if prae.poison_count(target) >= 2 and rime.pvp.has_aff("blood_poison", target) and not (rime.pvp.has_aff("paralysis", target) or rime.pvp.has_aff("paresis", target)) then
				return true
			end
		end,
		combo = false,
		aff = "paresis",
	},

	["behead"] = {
		"behead target",
		choice = function()
			return prae.initials.behead[1]
		end,
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("locked", target) and rime.pvp.has_aff("confusion", target) and rime.pvp.has_aff("disrupted", target) then
				return true
			else
				return false
			end
		end,
		combo = false,
		aff = "behead",
	},

	["rend"] = {
		"claw target",
		choice = function()
			return prae.initials.rend[1]
		end,
		can = function()
			local target = rime.target
			if rime.pvp.has_def("rebounding", target) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "rend",
	},

	["shielded"] = {
		"frenzy target",
		choice = function()
			return prae.initials.shielded[1]
		end,
		can = function()
			local target = rime.target
			if rime.pvp.has_def("shielded", target) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "shielded",
	},

	["blood_rune"] = {
		"blood rune target",
		choice = function()
			return prae.initials.blood_rune[1]
		end,
		can = function()
			if rime.pvp.has_aff("blood_rune", rime.target) then
				return false
			else
				return true
			end
		end,
		combo = true,
		aff = "blood_rune",
 	},

	["seize"] = {
		"blood seize target",
		choice = function()
			return prae.initials.seize[1]
		end,
		can = function()
			local spec = gmcp.Char.Status.spec
			if spec ~= "Rituos" then return end
			if not prae.can_seize then return false end
			local targ = rime.target
			local mAffs = rime.pvp.mental_count(rime.target)
			local mAffBump = 4.00
			local seizeMana = tonumber((10.98) + (mAffs*mAffBump))
			--blood curse:
			-- %/10*1.5
			if rime.pvp.has_aff("blood_curse", targ) then
				seizeMana = seizeMana+((seizeMana/10)*1.5)
			end

			if ( rime.targets[rime.target].mana- seizeMana ) <= 37 and rime.pvp.has_aff("blood_rune", targ) then
				return true
			elseif ( rime.targets[rime.target].mana- seizeMana ) <= 32 then
				return true
			end
			return false
		end,
    	combo = false,
    	aff = "seize",
	},

  ["annihilate"] = {
    "annihilate target",
    choice = function()
        return prae.initials.annihilate[1]
    end,
    can = function()
        if rime.targets[rime.target].mana < 35 then
            return true
        elseif rime.targets[rime.target].mana < 44 and rime.pvp.has_aff("blood_rune", rime.target) then
            return true
        else
            return false
        end
    end,
    combo = false,
    aff = "annihilate",
    },
	["blood_feast"] = {
		"blood feast target",
		can = function()
      local spec = gmcp.Char.Status.spec
			if rime.pvp.has_aff("writhe_transfix", rime.target) and spec == "Phreneses" then
				return true
			else
				return false
			end
		end,
		combo = false,
		aff = "blood_feast",
	},
	["asthma"] = {
	"attack target kalmia lightly",
    "attack target kalmia",
    choice = function()
      local spec = gmcp.Char.Status.spec
      if spec == "Phreneses" then
        return prae.initials.asthma[1]
      else
        return prae.initials.asthma[2]
      end
    end,
		can = function()
			if rime.canGash() and prae.can_spew then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "kalmia"
	},
  ["no_blind"] = {
    "attack target oculus lightly",
    "attack target oculus",
    "mesmerize target",
    choice = function()
      local spec = gmcp.Char.Status.spec
      local targ = rime.target
      if rime.has_aff("prone") or rime.has_aff("left_arm_broken") or rime.has_aff("right_arm_broken") or rime.targets[targ].defences.rebounding then
        return prae.initials.no_blind[3]
      elseif spec == "Phreneses" then
        return prae.initials.no_blind[1]
      else
        return prae.initials.no_blind[2]
      end
    end,
    can = function()
      if rime.pvp.has_def("rebounding", rime.target) then
        return false
      else
        return true
      end
    end,
    combo = true,
    aff = "oculus"
  },
	["writhe_transfix"] = {
		"mesmerize target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("no_blind", targ) and not rime.pvp.has_aff("writhe_impale", targ) and not rime.pvp.has_aff("writhe_transfix", targ) then
				return true
			else
				return false
			end
		end,
		combo = false,
		aff = "writhe_transfix"
	},
	["disrupted"] = {
		"disrupt target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("confusion", targ) and rime.pvp.has_aff("sadness", targ) and rime.pvp.has_aff("impatience", targ) then
				return true
			elseif rime.pvp.has_aff("confusion", targ) and rime.pvp.has_aff("slickness", targ) and rime.pvp.has_aff("anorexia", targ) and rime.pvp.has_aff("asthma", targ) then
				return true
			else
				return false
			end
		end,
		combo = false,
		aff = "disrupted"
	},
	["fling"] = {
		"fling secondary_target",
		"fling target",
		choice = function()
			local indoors = gmcp.Room.Info.detals.indoors or false
			if indoors then
				return prae.inititals.fling[2]
			else
				return prae.initials.fling[1]
			end
		end,
		can = function()
			local indoors = gmcp.Room.Info.details.indoors or false
			local targ = rime.target
			if prae.initials.fling.choice() == "fling target" then
				if rime.pvp.has_aff("prone", targ) then
					return false
				else
					return true
				end
			elseif prae.initials.fling.choice() == "fling secondary_target" then
				if indoors then
					return true
				else
					return false
				end
			end
		end,
		combo = true,
		aff = "fling"
	},					
	["frenzy"] = {
		"frenzy target",
		can = function()
			if rime.has_aff("prone") or rime.has_aff("paralysis") or rime.has_aff("writhe_transfix") or rime.has_aff("writhe_impaled") then
				return false
			else
				return true
			end
		end,
		combo = true,
		aff = "frenzy"
	},
	["feed"] = {
		"feed target",
		can = function()
			local targ = rime.target
			if (rime.pvp.has_aff("physical", targ) and not (rime.targets[targ].defences.fangbarrier)) or 
      (rime.pvp.has_aff("blood_feast", targ) and not (rime.targets[targ].defences.fangbarrier)) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "feed"
	},
	 
	["paresis"] = {
		"attack target curare",
		choice = function()
			local spec = gmcp.Char.Status.spec
			return prae.initials.paresis[1]
		end,
		can = function()
			if rime.pvp.minion == "ghastly" then return false end
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "curare"
	},

	["no_deaf"] = {
		"attack target prefarar",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "prefarar"
	},
	["sensitivity"] = {
		"attack target prefarar",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "prefarar"
	},
	["clumsiness"] = {
		"attack target xentio",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "xentio"
	},
	["left_leg_broken"] = {
		"attack target epseth",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "epseth"
	},
	["right_leg_broken"] = {
		"attack target epseth",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "epseth"
	},
	["left_arm_broken"] = {
		"attack target epteth",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "epteth"
	},
	["right_arm_broken"] = {
		"attack target epteth",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "epteth"
	},
	["vomiting"] = {
		"attack target euphorbia",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "euphorbia"
	},
	["allergies"] = {
		"attack target darkshade",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "darkshade"
	},
	["haemophilia"] = {
		"attack target hepafarin",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "hepafarin"
	},
	["shyness"] = {
		"attack target digitalis",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "digitalis"
	},
	["dizziness"] = {
		"attack target larkspur",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "larkspur"
	},
	["disfigurement"] = {
		"attack target monkshood",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "monkshood"
	},
	["voyria"] = {
		"attack target voyria",
		can = function()
			if rime.canGash() then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "voyria"
	},
	["effused_blood"] = {
		"blood effuse target",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("loneliness", target) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "effused_blood",
	},
	["upset_effusion"] = {
		"frenzy target upset",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("effused_blood", targ) and not rime.pvp.has_aff("upset_effusion", targ) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "upset_effusion"
	},
	["sapped_dexterity"] = {
		"frenzy target bodyleech",
		can = function()
			local targ = rime.target
			local euphoriant_affs = 0
			for k,v in ipairs(rime.curing.affsByCure.euphoriant) do
				if rime.pvp.has_aff(v, targ) then
					euphoriant_affs = euphoriant_affs+1
				end
			end
			if euphoriant_affs >= 3 then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "sapped_dexterity"
	},
  ["slickness"] = {
		"breathe target",
		can = function()
		local spec = gmcp.Char.Status.spec
			local targ = rime.target
			if rime.pvp.has_aff("asthma", targ) then
				return true
			elseif spec == "Phreneses" and tonumber(gmcp.Char.Vitals.blood) < 85 and rime.targets[targ].defences.fangbarrier then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "slickness"
	},
	["stun"] = {
	"frenzy target overpower",
		can = function()
			local targ = rime.target
			local depressant_affs = 0
			for k,v in ipairs(rime.curing.affsByCure.depressant) do
				if rime.pvp.has_aff(v, targ) then
					depressant_affs = depressant_affs+1
				end
			end
			if depressant_affs >= 3 then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "stun"
	},
	["minion_reset"] = {
		"frenzy target craze",
		can = function()
			local targ = rime.target
			local antipsychotic_affs = 0
			local mutation_conversion = {
				["eldritch"] = "hallucinations",
				["ghastly"] = "paresis",
				["festering"] = "haemophilia",
				["oozing"] = "fangbarrier",
		}
			for k,v in ipairs(rime.curing.affsByCure.antipsychotic) do
				if rime.pvp.has_aff(v, targ) then
					antipsychotic_affs = antipsychotic_affs+1
				end
			end
			if antipsychotic_affs >= 3 and not rime.pvp.minion == "oozing" and not rime.pvp.has_aff(mutation_conversion[rime.pvp.minion], targ) then
				return true
			else
				return false
			end
		end,
		combo = true,
		aff = "frenzy"
	},
}

function prae.poison_count(target)

	if not target then target = rime.target end
	local tree_total = 0

	for k,v in ipairs(rime.curing.affsByCure.antipsychotic) do
		if rime.pvp.has_aff(v, target) then
			tree_total = tree_total+1
			break
		end
	end

	for k,v in ipairs(rime.curing.affsByCure.euphoriant) do
		if rime.pvp.has_aff(v, target) then
			tree_total = tree_total+1
			break
		end
	end

	for k,v in ipairs(rime.curing.affsByCure.depressant) do
		if rime.pvp.has_aff(v, target) then
			tree_total = tree_total+1
			break
		end
	end

	return tree_total

end


function rime.canGash()
	
	local target = rime.target

	if rime.targets[target].defences.rebounding or rime.targets[target].defences.shielded or rime.targets[target].defences.prismatic then return false end
	
	if rime.has_aff("left_arm_broken") or rime.has_aff("right_arm_broken") or rime.has_aff("paralysis") or rime.has_aff("writhe_transfix")
	or rime.has_aff("writhe_impaled") or rime.has_aff("writhe_web") then return false end
	
	return true
	
end

function prae.init()

	local targ = rime.target

	for k,v in ipairs(rime.pvp.route.initial) do
		if not rime.pvp.has_aff(v, targ) and prae.initials[v].can() then
			if prae.initials[v].choice ~= nil then
				return prae.initials[v].choice():gsub("target", rime.target), prae.initials[v].aff, prae.initials[v].combo
			else
				return prae.initials[v][1]:gsub("target", rime.target), prae.initials[v].aff, prae.initials[v].combo
			end
		end
	end


end

function prae.whispers()

	local whis1, whis2
	local whisper_command = "whisper"
	local target = rime.target
	local whisper_affs = {}

	if prae.can_trill and not rime.has_aff("peace") then
		whisper_command = "trill"
	else
		whisper_command = "whisper"
	end

		for k,v in ipairs(rime.pvp.route.whispers) do
			if whis1 and not rime.pvp.has_aff(v, rime.target)  then
				whis2 = v
				break
			elseif not rime.pvp.has_aff(v, rime.target)  then
				whis1 = v
			end
		end


		if not whis1 then whis1 = "indifference" end
		if not whis2 then whis2 = "anorexia" end

		local spec = gmcp.Char.Status.spec
    
    	local attack, aff, combo = prae.init()

    	if aff == "slickness" then
         	 whis1 = "anorexia"
    	end

		if spec == "Phreneses" or rime.pvp.has_aff("blood_poison", rime.target) then

			if whisper_command == "trill" then

				return whisper_command .. " " .. whis1, whis1

			else

				return whisper_command .. " " .. whis1 .. " " .. target, whis1

			end

		elseif whisper_command == "trill" then


			return whisper_command .. " " .. whis1 .. " " .. whis2, whis1 .. " " .. whis2

		else
			
			return whisper_command .. " " .. whis1 .. " " .. whis2 .. " " .. target, whis1 .. " " .. whis2

		end
		
end

function prae.weapon_selection()

    local spec = gmcp.Char.Status.spec
    local hp = rime.vitals.percent_health
    local left_hand = gmcp.Char.Vitals.wield_left
    local right_hand = gmcp.Char.Vitals.wield_right
    local weapons = {"scythe", "flyssa", "battleaxe", "whip", "warhammer", "glaive", "shortsword", "bastardsword"}
    local shields = {"buckler", "tower"}
    local need_wield = "nothing"
    local weapon_chosen = ""
    local target = rime.target

    if prae.need_curse() and not right_hand:find(rime.saved.flavor_1h) then
		need_wield = "buckler " .. rime.saved.flavor_1h
		weapon_chosen = rime.saved.flavor_1h
    elseif hp < 45 and not right_hand:find(rime.saved.flavor_1h) then
		need_wield = "buckler " .. rime.saved.flavor_1h
		weapon_chosen = rime.saved.flavor_1h
	elseif prae.need_poison() and not right_hand:find(rime.saved.flavor_1h) then
		need_wield = "buckler " .. rime.saved.flavor_1h
		weapon_chosen = rime.saved.flavor_1h
	elseif rime.has_aff("lethargy") and not right_hand:find(rime.saved.flavor_1h) then
		need_wield = "buckler " .. rime.saved.flavor_1h
		weapon_chosen = rime.saved.flavor_1h
	elseif spec == "Rituos" and hp > 45 and not left_hand:find(rime.saved.flavor_2h) then
    	need_wield = rime.saved.flavor_2h
    	weapon_chosen = rime.saved.flavor_2h
	else
		need_wield = "nothing"
		weapon_chosen = "none"
	end

	if weapon_chosen == "none" then
		return "", weapon_chosen
	else
		return "quickwield both " .. need_wield, weapon_chosen
	end
	

end

prae.curse_at = 2 --like right here just set it at 2

function prae.need_curse()

	if gmcp.Char.Status.spec ~= "Rituos" then return false end

	local targ = rime.target
	local antipsychotic_affs = 0
	for k,v in ipairs(rime.curing.affsByCure.antipsychotic) do
		if rime.pvp.has_aff(v, targ) then
			antipsychotic_affs = antipsychotic_affs+1
		end
	end
	if antipsychotic_affs >= tonumber(prae.curse_at) and not rime.pvp.has_aff("blood_curse", targ) then
		return true
	else
		return false
	end

end

function prae.need_poison()

	if gmcp.Char.Status.spec ~= "Insidiae" then return false end

	local who, init_aff, cares = prae.init()

	if init_aff == "slickness" then return false end

	local targ = rime.target
	local affs = 0
	for k,v in ipairs(rime.curing.affsByCure.antipsychotic) do
		if rime.pvp.has_aff(v, targ) and v ~= "sadness" then
			affs = affs+1
			break
		end
	end

	for k,v in ipairs(rime.curing.affsByCure.depressant) do
		if rime.pvp.has_aff(v, targ) and v ~= "commitment_fear" then
			affs = affs+1
			break
		end
	end

	for k,v in ipairs(rime.curing.affsByCure.euphoriant) do
		if rime.pvp.has_aff(v, targ) and v ~= "selfpity" then
			affs = affs+1
			break
		end
	end

	if affs >= tonumber(prae.curse_at) and not rime.pvp.has_aff("blood_poison", targ) then
		return true
	end

	return false 
	
end

function prae.offense()

	local target = rime.target
	local sep = rime.saved.separator
	local init_attack, init_aff, combo = prae.init()
	local whispers, whisper_call = prae.whispers()
	local command = ""
	local whisper_call = whisper_call:gsub(" ", "/")
	local web_call = ""
	local weapon_wield, weapon = prae.weapon_selection()
	local left_hand = gmcp.Char.Vitals.wield_left
	local right_hand = gmcp.Char.Vitals.wield_right
	local weapons = {"scythe", "flyssa", "battleaxe", "whip", "warhammer", "glaive", "shortsword", "bastardsword", "rapier"}

	if init_attack:find("annihilate") and rime.pvp.has_aff("blood_rune", target) then
		init_attack = "activate rune"..sep..init_attack
	end

	if weapon == "none" then
		for k,v in ipairs(weapons) do
			if right_hand:find(v) then
				weapon = v
				break
			elseif left_hand:find(v) then
				weapon = v
				break
			end
		end
	end

	if rime.pvp.web_aff_calling then

		if combo then

			web_call = rime.pvp.omniCall(init_aff.."/"..whisper_call)

		else

			web_call = rime.pvp.omniCall(init_aff.."/")

		end

	end

	if rime.pvp.web_aff_calling then

		command = rime.pvp.queue_handle() .. sep .. web_call .. sep .. weapon_wield .. sep .. init_attack .. sep .. whispers

	elseif prae.need_curse() then

		command = rime.pvp.queue_handle() .. sep .. web_call .. sep .. weapon_wield .. sep .. init_attack .. sep .. "blood curse " .. target

	elseif prae.need_poison() then

		command = rime.pvp.queue_handle() .. sep .. web_call .. sep .. weapon_wield .. sep .. init_attack .. sep .. "blood poison " .. target

	else

		command = rime.pvp.queue_handle() .. sep .. web_call .. sep .. weapon_wield .. sep .. init_attack .. sep .. whispers

	end

	if command:find("attack") and weapon_wield then command = command:gsub("attack", rime.pvp.weapon_verbs[weapon]) end
	command = command:gsub("nothing", "")
	command = command:gsub(sep .. sep .. "+", sep)

	act(command)



end
