
indo = indo or {}
indo.attacks = indo.attacks or {}

indo.can_aeon = true
indo.can_chimera = true
indo.can_envelop = true
indo.can_wheel = true
indo.wheel_toggle = false
indo.adder_ready = false
indo.adder_toggle = false
indo.despair_toggle = false
indo.soulmaster_toggle = false
indo.deform_count = indo.deform_count or 13

rime.pvp.Indorani.routes = {

	["glock"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"asthma",
			"paresis",
			"clumsiness",
			"impatience",
			"superstition",
			"confusion",
			"epilepsy",
			"lovers_effect",
			"stupidity",
			"lethargy",
			"vomiting",
			"justice",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}
	},

	["group"] = {

		["main"] = {
			--"ally_heal",
			"ally_cure",
			"shielded",
			"vivisex",
			"deform",
			"decay",
			"aeon",
			"asthma",
			"clumsiness",
			"sensitivity",
			"impatience",
			"stupidity",
			"confusion",
			"epilepsy",
			"recklessness",
			"paresis",
			"superstition",
			"weariness",
			"vomiting",
			"justice",
			"lovers_effect",
			"anorexia",
			"lethargy",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}
	},

	["aeon"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"deform",
			"despair",
			"aeon",
			"asthma",
			"clumsiness",
			"impatience",
			"aeon",
			"paresis",
			"vomiting",
			"sensitivity",
			"weariness",
			"superstition",
			"stupidity",
			"epilepsy",
			"recklessness",
			"justice",
			"lovers_effect",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}
	},

	["white"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"decay",
			"deform",
			"writhe_ropes",
			"despair",
			"paresis",
			"no_deaf",
			"superstition",
			"lethargy",
			"vomiting",
			"impatience",
			"confusion",
			"epilepsy",
			"weariness",
			"stupidity",
			"berserking",
			"justice",
			"lovers_effect",
			"asthma",
			"confusion",
			"recklessness",
			"aeon",
		},

		["chimera"] = {
			"damage",
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		},

	},

	["black"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"decay",
			"deform",
			"writhe_ropes",
			"paresis",
			"clumsiness",
			"lethargy",
			"no_deaf",
			"superstition",
			"impatience",
			"epilepsy",
			"stupidity",
			"berserking",
			"justice",
			"lovers_effect",
			"asthma",
			"weariness",
			"vomiting",
			"confusion",
			"recklessness",
			"aeon",
		},

		["chimera"] = {
			"damage",
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}

	},

	["vivi"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"right_leg_broken",
			"left_leg_broken",
			"right_arm_broken",
			"left_arm_broken",

		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}

	},

	["limbs"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"frozen",
			"paresis",
			"writhe_ropes",
			"right_leg_damaged",
			"left_leg_damaged",
			"left_arm_broken",
			"right_arm_broken",
			"left_arm_damaged",
			"right_arm_damaged",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}

	},

	["grouplimb"] = {

		["main"] = {
			"shielded",
			"vivisex",
			"deform",
			"right_leg_broken",
			"left_leg_broken",
			"right_leg_damaged",
			"left_leg_damaged",
			"right_arm_broken",
			"left_arm_broken",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}
	},

	["vlock"] = {

		["main"] = {
			"shielded",
			"paresis",
			"hypersomnia",
			"asleep",
			"lethargy",
			"superstition",
			"asthma",
			"clumsiness",
			"impatience",
			"confusion",
			"epilepsy",
			"stupidity",
			"berserking",
			"justice",
			"lovers_effect",
			"recklessness",
			"aeon",
			"deform",
		},

		["chimera"] = {
			"no_deaf",
			"stun",
		},

		["slime"] = {
			"envelop"
		},

		["soulmaster"] = {
			"kneel"
		}
	},

}

indo.attacks = {

	["ally_heal"] = {
		"fling priestess at ally",
		card = "priestess",
		can = function()
            rime.pvp.ally = rime.pvp.ally or rime.saved.allies[1]
            for k,v in ipairs(rime.saved.allies) do
               if tonumber(rime.targets[v].aggro) > tonumber(rime.targets[rime.pvp.ally].aggro) and rime.targets[v].defences.shielded == false then
                    rime.pvp.ally = v
                end
            end

            if tonumber(rime.targets[rime.pvp.ally].aggro) > 20 and not rime.targets[rime.pvp.ally].defences.shielded then
                return true
            else
                return false
            end
        end,
        choice = function()
        	return indo.attacks.ally_heal[1]
        end,
	},

	["ally_cure"] = {
		"fling fool at ally",
		card = "fool",
		can = function()
            rime.pvp.ally = rime.pvp.ally or rime.saved.allies[1]
            for k,v in ipairs(rime.saved.allies) do
               if tonumber(rime.targets[v].aggro) > tonumber(rime.targets[rime.pvp.ally].aggro) then
                    rime.pvp.ally = v
                end
            end

            if tonumber(rime.targets[rime.pvp.ally].aggro) > 20 then
                return true
            else
                return false
            end
        end,
        choice = function()
        	return indo.attacks.ally_cure[1]
        end,
	},

	["frozen"] = {
		"chill target",
		card = false,
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("frozen", target) or rime.targets[target].chilled then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.frozen[1]
		end,
	},

	["shielded"] = {
		"touch hammer target",
		card = false,
		can = function()
			local target = rime.target
			if rime.pvp.has_def("shielded", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.shielded[1]
		end,
	},

	["decay"] = {
		"order doppleganger return\\order doppleganger seek target\\order doppleganger channel decay target",
		card = false,
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("deform", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.decay[1]
		end,
	},
	["wheel"] = {
		"wheel",
		card = "wheel",
		can = function()
			local target = rime.target
			local aff_total = 0
			for k,v in pairs(rime.targets[target].afflictions) do
				if rime.pvp.has_aff(k, target) then
					aff_total = aff_total+1
				end
			end
			local limbs_damaged = {"left_leg_damaged", "right_leg_damaged", "right_arm_damaged", "left_arm_damaged"}
			local limbs_broken = {"left_leg_broken", "right_leg_broken", "left_arm_broken", "right_arm_broken"}
			local limbs_damaged_total = 0
			local limbs_broken_total = 0
			for k,v in ipairs(limbs_damaged) do
				if rime.pvp.has_aff(v, target) then
					limbs_damaged_total = limbs_damaged_total+1
				end
			end
			for k,v in ipairs(limbs_broken) do
				if rime.pvp.has_aff(v, target) then
					limbs_broken_total = limbs_broken_total+1
				end
			end
			if limbs_broken_total >= 2 and limbs_damaged_total >= 1 and indo.can_wheel then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.wheel[1]
		end,
	},
	["deform"] = {
		"deform target",
		card = false,
		can = function()
			local target = rime.target
			local aff_total = 0
			for k,v in pairs(rime.targets[target].afflictions) do
                if rime.pvp.has_aff(k, target) and not ignore_aff(k) then
                    aff_total = aff_total+1
                end
            end
			if aff_total >= tonumber(indo.deform_count) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.deform[1]
		end,
	},
	["writhe_ropes"] = {
		"hangedman",
		card = "hangedman",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("prone", target) or rime.pvp.has_aff("left_leg_damaged", target) or rime.pvp.has_aff("right_leg_damaged", target) then
				return true
			elseif indo.can_chimera and rime.pvp.has_aff("no_deaf", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.writhe_ropes[1]
		end,
	}, 
	["justice"] = {
		"justice",
		card = "justice",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.justice[1]
		end,
	},

	["lovers_effect"] = {
		"lovers",
		card = "lovers",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.lovers_effect[1]
		end,
	},

	["paresis"] = {
		"sun paresis",
		card = "sun",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("paralysis", target) or rime.pvp.has_aff("paresis", target) then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.paresis[1]
		end,
	},

	["clumsiness"] = {
		"sun clumsiness",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.clumsiness[1]
		end
	},

	["asthma"] = {
		"sun asthma",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.asthma[1]
		end,
	},

	["vomiting"] = {
		"sun vomiting",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.vomiting[1]
		end,
	},

	["lethargy"] = {
		"sun lethargy",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.lethargy[1]
		end,
	},

	["sensitivity"] = {
		"sun sensitivity",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.sensitivity[1]
		end,
	},

	["no_deaf"] = {
		"sun sensitivity",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.sensitivity[1]
		end,
	},

	["superstition"] = {
		"sun superstition",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.superstition[1]
		end,
	},

	["hypersomnia"] = {
		"sun hypersomnia",
		card = "sun",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.hypersomnia[1]
		end,
	},

	["asleep"] = {
		"sandman",
		card = "sandman",
		can = function()
			local target = rime.target
			if not rime.pvp.has_def("insomnia", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.asleep[1]
		end,
	},

	["stupidity"] = {
		"moon stupidity",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.stupidity[1]
		end,
	},

	["confusion"] = {
		"moon confusion",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.confusion[1]
		end,
	},

	["recklessness"] = {
		"moon recklessness",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.recklessness[1]
		end,
	},

	["impatience"] = {
		"moon impatience",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.impatience[1]
		end,
	},

	["epilepsy"] = {
		"moon epilepsy",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.epilepsy[1]
		end,
	},

	["berserking"] = {
		"moon berserking",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.berserking[1]
		end,
	},

	["weariness"] = {
		"moon weariness",
		card = "moon",
		can = function()
			return true
		end,
		choice = function()
			return indo.attacks.weariness[1]
		end,
	},

	["anorexia"] = {
		"moon anorexia",
		card = "moon",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("slickness") and rime.pvp.has_aff("asthma") and rime.pvp.has_aff("impatience") then
				return true
			elseif rime.pvp.route_choice == "limbs" then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.anorexia[1]
		end,
	},

	["aeon"] = {
		"aeon",
		card = "aeon",
		can = function()
			if indo.can_aeon then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.aeon[1]
		end,
	},

	["left_arm_broken"] = {
		"shrivel target left arm",
		"shrivel target arms",
		can = function()
			local target = rime.target
			if rime.pvp.route_choice == "vivi" or rime.pvp.has_aff("locked", target) or rime.pvp.route_choice == "aeon" then
				return true
			elseif  rime.pvp.has_aff("right_leg_broken", target) and rime.pvp.has_aff("left_leg_broken", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.left_arm_broken[1]
		end,
		card = false,
	},

	["right_arm_broken"] = {
		"shrivel target right arm",
		"shrivel target arms",
		can = function()
			local target = rime.target
			if rime.pvp.route_choice == "vivi" or rime.pvp.has_aff("locked", target) or rime.pvp.route_choice == "aeon" then
				return true
			elseif rime.pvp.has_aff("right_leg_broken", target) and rime.pvp.has_aff("left_leg_broken", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.right_arm_broken[1]
		end,
		card = false,
	},

	["left_leg_broken"] = {
		"shrivel target left leg",
		"shrivel target legs",
		can = function()
			local target = rime.target
			if rime.pvp.route_choice == "vivi" or rime.pvp.has_aff("locked", target) or rime.pvp.route_choice == "aeon" then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.left_leg_broken[1]
		end,
		card = false,
	},

	["right_leg_broken"] = {
		"shrivel target right leg",
		"shrivel target legs",
		can = function()
			local target = rime.target
			if rime.pvp.route_choice == "vivi" or rime.pvp.has_aff("locked", target) or rime.pvp.route_choice == "aeon" then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.right_leg_broken[1]
		end,
		card = false,
	},

	["crippled_throat"] = {
		"shrivel target throat",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("locked", target) then
				return true
			else
				return false
			end
		end,
	},

	["left_leg_damaged"] = {
		"warrior left leg",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("left_leg_broken", target) then
				return false
			elseif rime.pvp.lastLimb_hit == "left_leg" and not rime.limit.left_leg_restore and rime.targets[target].limbs.left_leg > 2200 then
				return true
			elseif rime.limit.left_leg_restore or rime.pvp.lastLimb_hit == "left_leg" then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.left_leg_damaged[1]
		end,
		card = "warrior",
	},
	["right_leg_damaged"] = {
		"warrior right leg",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("right_leg_broken", target) then
				return false
			elseif rime.pvp.lastLimb_hit == "right_leg" and not rime.limit.right_leg_restore and rime.targets[target].limbs.right_leg > 2200 then
				return true
			elseif rime.limit.right_leg_restore or rime.pvp.lastLimb_hit == "right_leg" then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.right_leg_damaged[1]
		end,
		card = "warrior",
	},

	["right_arm_damaged"] = {
		"warrior right arm",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("right_arm_broken", target) then
				return false
			elseif rime.pvp.lastLimb_hit == "right_arm" and not rime.limit.right_arm_restore and rime.targets[target].limbs.right_arm > 2200 then
				return true
			elseif rime.limit.right_arm_restore or rime.pvp.lastLimb_hit == "right_arm" then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.right_arm_damaged[1]
		end,
		card = "warrior",
	},

	["left_arm_damaged"] = {
		"warrior left arm",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("left_arm_broken", target) then
				return false
			elseif rime.pvp.lastLimb_hit == "left_arm" and not rime.limit.left_arm_restore and rime.targets[target].limbs.left_arm > 2200 then
				return true
			elseif rime.limit.left_arm_restore or rime.pvp.lastLimb_hit == "left_arm" then
				return false
			else
				return true
			end
		end,
		choice = function()
			return indo.attacks.left_arm_damaged[1]
		end,
		card = "warrior",
	},

	["vivisex"] = {
		"vivisect target",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("left_arm_broken", target) and rime.pvp.has_aff("right_arm_broken", target) and rime.pvp.has_aff("left_leg_broken", target) and rime.pvp.has_aff("right_leg_broken", target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.vivisex[1]
		end,
		card = false,
	},

	["adder"] = {
		"adder gecko",
		card = "adder",
		can = function()
			local targ = rime.target
			if not rime.pvp.has_aff("slickness") and not rime.pvp.has_aff("adder") and rime.pvp.has_aff("asthma") and rime.pvp.has_aff("impatience") then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.adder[1]
		end,
	},

	["despair"] = {
		"despair",
		card = "despair",
		can = function()
			if indo.despair_toggle then
				return true
			else
				return false
			end
		end,
		choice = function()
			return indo.attacks.despair[1]
		end,
	},
}



indo.domination = indo.domination or {}

indo.domination = {

	--not really domination but whatever, just no bal attacks really.

	["no_deaf"] = {
		"order chimera roar",
		can = function()
			if indo.can_chimera then
				return true
			else
				return false
			end 
		end,
	},

	["stun"] = {
		"order chimera roar",
		can = function()
			if indo.can_chimera then
				return true
			else
				return false
			end 
		end,
	},

	["envelop"] = {
		"order slime envelop",
		can = function()
			if indo.can_envelop then
				return true
			else
				return false
			end
		end,
	},

	["damage"] = {
		"order chimera headbutt",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("deform", target) and indo.can_chimera then
				return true
			else
				return false
			end
		end,
	},

	["no_insomnia"] = {
		"order chimera gas",
		can = function()
			local target = rime.target
			if rime.targets[target].defences.insomnia and indo.can_chimera then
				return true
			else
				return false
			end
		end,
	},

	["kneel"] = {
		"order target kneel bulrok",
		can = function()
			if indo.can_soulmaster and indo.soulmaster then
				return true
			else
				return false
			end
		end,
	},

	["dodge_off"] = {
		"order target dodge none",
		can = function()
			if indo.can_soulmaster and indo.soulmaster_toggle then
				return true
			else
				return false
			end
		end,
	},
}

function ignore_aff(aff)
   if aff == "leeched_aura" then return true end
   if aff == "no_deaf" then return true end
   if aff == "no_blind" then return true end
   if aff == "prone" then return true end

   return false
end

function indo.solve_wheel(aff, target)
	aff = string.gsub(aff, "and ", ",")
	aff = string.split(aff, ",", "\n")

	local library = {
		["a broken left leg"] = "left_leg_broken",
		["a broken right leg"] = "right_leg_broken",
		["a broken left arm "] = "left_arm_broken",
		["a broken right arm"] = "right_arm_broken",
	}

	for k,v in ipairs(aff) do
		if not rime.pvp.has_aff(v, target) then
			if library[v] then
				rime.pvp.add_aff(library[v], target)
			elseif v ~= "" then
				rime.pvp.add_aff(v, target)
			end
		end
	end

end


function indo.get_attacks()

	local target = rime.target
	local attack1 = false
	local attack2 = false
	local aff1 = false
	local aff2 = false
	local card1 = false
	local card2 = false

	for k,v in ipairs(rime.pvp.route.main) do
		if not rime.pvp.has_aff(v, target) and indo.attacks[v].can() then
			attack1 = indo.attacks[v].choice()
			card1 = indo.attacks[v].card
			aff1 = v
			break
		end
	end

	if card1 then
		for k,v in ipairs(rime.pvp.route.main) do
			if not rime.pvp.has_aff(v, target) and indo.attacks[v].can() and indo.attacks[v].card and indo.attacks[v].card ~= card1 and indo.attacks[v].card ~= "hangedman" then
				attack2 = indo.attacks[v].choice()
				card2 = indo.attacks[v].card
				aff2 = v
				break
			end
		end
	end

	if card2 then

		return attack1, card1, aff1, attack2, card2, aff2

	else

		return attack1, card1, aff1, "nothing", false, "nothing"

	end

end


function indo.get_dom()

	local target = rime.target
	local commands = {}
	local sep = rime.saved.separator

	if indo.can_chimera then

		for k,v in ipairs(rime.pvp.route.chimera) do
			if not rime.pvp.has_aff(v, target) and indo.domination[v].can() then
				table.insert(commands, indo.domination[v][1])
			end
		end

	end

	if not rime.pvp.has_aff("leeched_aura", target) then
		table.insert(commands, "leech target")
	end

	if indo.can_envelop then
		table.insert(commands, "order slime envelop")
	end

	if rime.pvp.has_def("flight", target) then
		table.insert(commands, "order dervish act")
	end

	if rime.pvp.has_aff("deform", target) then
		table.insert(commands, "order hound kill target")
	end

	return table.concat(commands, sep)


end


function indo.offense()

	if rime.has_aff("left_arm_broken") and rime.has_aff("right_arm_broken") then
		return ""
	elseif rime.has_aff("prone") then
		return ""
	end

	local target = rime.target
	local attack1, card1, aff1, attack2, card2, aff2 = indo.get_attacks()
	local sep = rime.saved.separator
	local actual_attack = {}
	local queue_handle = rime.pvp.queue_handle()
	local web_call = ""
	local command = ""
	local dom_attack = indo.get_dom() or ""
	local adder = "activate adder"

	if card1 then
		table.insert(actual_attack, "draw "..card1.." from deck")
	end
	if card2 and card1 ~= "fool" and card1 ~= "priestess" then
		table.insert(actual_attack, "draw "..card2.." from deck")
	end
	if card1 == "fool" or card1 == "priestess" then
		table.insert(actual_attack, "fling "..card1.." at ally")
	elseif card1 and card2 then
		table.insert(actual_attack, "fling " .. attack1 .. " and " .. attack2 .. " at target")
	elseif card1 and not card2 then
		table.insert(actual_attack, "fling "..attack1.." at target")
	elseif not card1 and card2 then
		table.insert(actual_attack, "fling "..attack2.." at target")
	elseif not card1 and not card2 then
		table.insert(actual_attack, attack1)
	end
    if rime.pvp.web_aff_calling then
        local card1_call = false
        local card2_call = false
        if card1 == "moon" or card1 == "sun" then
            card1_call = aff1
        end
        if card2 == "moon" or card2 == "sun" then
            card2_call = aff2
        end
        if card1_call and card2_call then
            web_call = rime.pvp.omniCall(aff1.."/"..aff2)
        elseif card1_call and not card2_call then
            web_call = rime.pvp.omniCall(aff1.."/")
        elseif card2_call and not card1_call then
            web_call = rime.pvp.omniCall(aff2.."/")
        end
    end

	if rime.pvp.web_aff_calling then

		command = queue_handle .. sep .. web_call .. sep .. dom_attack .. sep .. table.concat(actual_attack, sep)

	else

		command = queue_handle .. sep .. dom_attack .. sep .. table.concat(actual_attack, sep)

	end

	--command = command .. " " .. rime.pvp.post_queue()

	command = command:gsub("target", rime.target):gsub("ally", rime.pvp.ally)
	if rime.has_aff("prone") and (rime.has_aff("left_leg_broken") or rime.has_aff("right_leg_broken") or rime.has_aff("writhe_grappled")) then
		
	else
		act(command)
	end

end