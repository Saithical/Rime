tera = tera or {}

rime.teradrim = rime.teradrim or {}
rime.teradrim.fracture = rime.teradrim.fracture or false


rime.pvp.Teradrim.routes = {

	["group"] = {
		["affs"] = {
			"stonevice",
			"writhe_impaled",
			"rebounding",
			"sandrot",
			"levitation",
			"stonevice",
			"writhe_impaled",
			"limbPicker",
			"skullbash",
			"choke",
			"barrage",
			"writhe_grapple",
			"rip",
			"right_leg_broken",
			"left_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"right_leg_mangled",
			"left_leg_mangled",
			"left_arm_mangled",
			"right_arm_mangled",
			"right_leg_bruised",
			"left_leg_bruised",
			"left_arm_bruised",
			"right_arm_bruised",
			"head_bruised",
			"torso_bruised",
			"torso_mangled",
			"head_mangled",
			"right_leg_bruised_moderate",
			"left_leg_bruised_moderate",
			"left_arm_bruised_moderate",
			"right_arm_bruised_moderate",
			"head_bruised_moderate",
			"torso_bruised_moderate",
			"collapsed_lung",
			
		}
	},
	["legs"] = {
		["blurb"] = {"leg breaks first, start in fracture mode"},
		["affs"] = {
			"shielded",
			"rebounding",
			"hammer",
			"quake",
			"levitation",
			"stonevice",
			"writhe_impaled",
			"limbPrepper",
			"writhe_grapple",
			"skullbash",
			"choke",
			"heartpunch",
			--"rip",
			"barrage",
			"right_leg_broken",
			"left_leg_broken",
			"head_bruised",
			"torso_bruised",
			"collapsed_lung",
			"right_leg_bruised",
			"left_leg_bruised",
			"right_leg_mangled",
			"left_leg_mangled",
			"head_bruised_moderate",
			"torso_bruised_moderate",
			"right_leg_bruised_moderate",
			"left_leg_bruised_moderate",
			"torso_mangled",
			"indifference",
			"head_mangled",
		}
	},
	["arms"] = {
		["blurb"] = {"arm breaks first, start in fracture mode"},
		["affs"] = {
			"shielded",
			"rebounding",
			"hammer",
			"quake",
			"levitation",
			"stonevice",
			"writhe_impaled",
			"limbPrepper",
			"writhe_grapple",
			"skullbash",
			"choke",
			"heartpunch",
			--"rip",
			"barrage",
			"right_arm_broken",
			"left_arm_broken",
			"head_bruised",
			"torso_bruised",
			"collapsed_lung",
			"left_arm_bruised",
			"right_arm_bruised",
			"left_arm_mangled",
			"right_arm_mangled",
			"head_bruised_moderate",
			"torso_bruised_moderate",
			"left_arm_bruised_moderate",
			"right_arm_bruised_moderate",
			"torso_mangled",
			"indifference",
			"head_mangled",
		}
	},
	["fury"] = {
		["blurb"] = {"limb prep with furor"},
		["affs"] = {
			"shielded",
			"rebounding",
			"hammer",
			"quake",
			"levitation",
			"stonevice",
			"writhe_impaled",
			"limbPrepper",
			"writhe_grapple",
			"skullbash",
			"choke",
			"heartpunch",
			--"rip",
			"barrage",
			"right_arm_broken",
			"left_arm_broken",
			"right_leg_broken",
			"left_leg_broken",
			"head_bruised",
			"torso_bruised",
			"collapsed_lung",
			"right_leg_bruised",
			"left_leg_bruised",
			"left_arm_bruised",
			"right_arm_bruised",
			"left_arm_mangled",
			"right_arm_mangled",
			"right_leg_mangled",
			"left_leg_mangled",
			"head_bruised_moderate",
			"torso_bruised_moderate",
			"right_leg_bruised_moderate",
			"left_leg_bruised_moderate",
			"left_arm_bruised_moderate",
			"right_arm_bruised_moderate",
			"torso_mangled",
			"indifference",
			"head_mangled",
		}
	}
}

lastLimbHit = "none"
prerestoredLimb = "none"

rime.teradrim.attacks = {
	["torso_mangled"] = {
		"earth batter target torso",
		choice = function()
			return rime.teradrim.attacks.torso_mangled[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.limit.torso_restore and not rime.pvp.parry_pred("torso") and not rime.pvp.has_aff("torso_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
	["head_mangled"] = {
		"earth batter target head",
		choice = function()
			return rime.teradrim.attacks.head_mangled[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.limit.head_restore and not rime.pvp.parry_pred("head") and not rime.pvp.has_aff("head_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
	["skullbash"] = {
		"earth skullbash target",
		choice = function()
			return rime.teradrim.attacks.skullbash[1]
		end,
		can = function()
			local tar = rime.target
			local head_bruises = {"head_bruised, head_bruised_moderate, head_bruised_critical"}
			local bruise_count = 0
			for k,v in ipairs(head_bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end
			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end
			--and not rime.pvp.has_def("shielded", tar)
			if bruise_count >= 1 and not rime.pvp.parry_pred("head") and not rime.limit.head_restore and not rime.pvp.has_aff("stupidity", tar) then
				return true
			else
				return false
			end
		end
	},
	["levitation"] = {
		"earth overhand target",
		choice = function()
			return rime.teradrim.attacks.levitation[1]
		end,
		can = function()
			local tar = rime.target
			-- and not rime.pvp.has_def("shielded", tar)
			if rime.pvp.has_def("rebounding", tar) and not rime.pvp.has_aff("prone", tar) then
				if rime.pvp.has_aff("left_leg_broken", tar) and rime.pvp.has_aff("left_leg_damaged", tar) and not rime.pvp.has_aff("prone", tar) then
					return true
				elseif rime.pvp.has_aff("right_leg_broken", tar) and rime.pvp.has_aff("right_leg_damaged", tar) and not rime.pvp.has_aff("prone", tar) then
					return true
				end
			else
				return false
			end
		end
	},
	["quake"] = {
		"earth quake",
		choice = function()
			return rime.teradrim.attacks.quake[1]
		end,
		can = function()
			local target_limbs = table.copy(rime.targets[rime.target].limbs)
            local sort_limbs = sortedKeys(target_limbs)
			local sorted_limbs = {}
			local limbDamage = 0
            local mode = rime.pvp.prediction_mode
            local last_parried = rime.targets[rime.target].parry
			local tar = rime.target
  
            for _, key in ipairs(sort_limbs) do
                table.insert(sorted_limbs, key)
            end
            for k, v in ipairs(rime.targets[rime.target].limbs) do
                if rime.limit[v .. "_restore"] then
                    table.remove(sorted_limbs, table.index_of(sorted_limbs, v))
                end
			end
			
			for k, v in ipairs(sorted_limbs) do
				limbDamage = limbDamage + rime.targets[rime.target].limbs[v]
			end

			--  and not rime.pvp.has_def("shielded", tar)
			if limbDamage >= 39000 and rime.pvp.has_aff("prone", tar) and rime.pvp.has_aff("right_leg_broken", tar) and rime.pvp.has_aff("left_leg_broken", tar) then
				return true
			elseif limbDamage >= 39000 and rime.pvp.has_aff("prone", tar) and rime.pvp.has_aff("deepwound", tar) and rime.pvp.target_tumbling and rime.pvp.has_aff("right_leg_broken", tar) and rime.pvp.has_aff("left_leg_broken", tar) then
				return true
			else
				return false
			end
		end
	},
	["barrage"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.barrage[1]
		end,
		can = function()
			local bruises = {"left_arm_bruised", "right_arm_bruised", "left_leg_bruised", "right_leg_bruised", "torso_bruised", "head_bruised", "left_arm_bruised_moderate", "right_arm_bruised_moderate", "left_leg_bruised_moderate", "right_leg_bruised_moderate", "torso_bruised_moderate", "head_bruised_moderate"}
			local tar = rime.target
			local bruise_count = 0
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.vitals.sandstorm <= 5 and bruise_count < 1 then
				return true
			else
				return false
			end
		end
	},

	["hammer"] = {
		"earth hammer target",
		choice = function()
			return rime.teradrim.attacks.hammer[1]
		end,
		can = function()
			local bruises = {"left_arm_bruised_moderate", "right_arm_bruised_moderate", "left_leg_bruised_moderate", "right_leg_bruised_moderate", "torso_bruised_moderate", "head_bruised_moderate"}
			local tar = rime.target
			local bruise_count = 0
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end

			if bruise_count >= 3 then
				return true
			else
				return false
			end
		end
	},
	["shielded"] = {
		"earth stoneblast target",
		choice = function()
			return rime.teradrim.attacks.shielded[1]
		end,
		can = function()
			local tar = rime.target
			if rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_bruised"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.left_leg_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.limit.left_leg_restore and not rime.pvp.parry_pred("left_leg") then
				return true
			end
		end,
	},
	["right_leg_bruised"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.right_leg_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") then
				return true
			else
				return false
			end
		end,
	},
	["left_arm_bruised"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.left_arm_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.targets[tar].limbs.left_arm >= 2300 and not rime.limit.left_arm_restore and not rime.pvp.parry_pred("left_arm") then
				return true
			else
				return false
			end
		end,
	},
	["right_arm_bruised"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.right_arm_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.limit.right_arm_restore and not rime.pvp.parry_pred("right_arm") then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_bruised_moderate"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.left_leg_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("left_leg_bruised", tar) and not rime.limit.left_leg_restore and not rime.pvp.parry_pred("left_leg") then
				return true
			else
				return false
			end
		end,
	},
	["right_leg_bruised_moderate"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.right_leg_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			-- and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("right_leg_bruised", tar) and not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") then
				return true
			else
				return false
			end
		end,
	},
	["left_arm_bruised_moderate"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.left_arm_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("left_arm_bruised", tar) and not rime.limit.left_arm_restore and not rime.pvp.parry_pred("left_arm") then
				return true
			else
				return false
			end
		end,
	},
	["right_arm_bruised_moderate"] = {
		"earth barrage target",
		choice = function()
			return rime.teradrim.attacks.right_arm_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar)
			if rime.pvp.has_aff("right_arm_bruised", tar) and not rime.limit.right_arm_restore and not rime.pvp.parry_pred("right_arm") then
				return true
			else
				return false
			end
		end,
	},
	["torso_bruised"] = {
		"earth gutsmash target",
		choice = function()
			return rime.teradrim.attacks.torso_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if not rime.pvp.parry_pred("torso") then
				return true
			else
				return false
			end
		end,
	},
	["torso_bruised_moderate"] = {
		"earth gutsmash target",
		choice = function()
			return rime.teradrim.attacks.torso_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("torso_bruised", tar) and not rime.pvp.parry_pred("torso") then
				return true
			else
				return false
			end
		end,
	},
	["head_bruised"] = {
		"earth facesmash target",
		choice = function()
			return rime.teradrim.attacks.head_bruised[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar)
			if not rime.pvp.parry_pred("head") and not rime.pvp.parry_pred("head") then
				return true
			else
				return false
			end
		end,
	},
	["head_bruised_moderate"] = {
		"earth facesmash target",
		choice = function()
			return rime.teradrim.attacks.head_bruised_moderate[1]
		end,
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("head_bruised", tar) and not rime.pvp.parry_pred("head") then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_broken"] = {
		"earth fracture target left leg",
		"earth barrage target",
		"earth furor target left leg ",
		"sand scourge target",
		"earth shockwave target",
		"earth batter target left leg",
		choice = function()
			local bruises = {"left_arm_bruised", "right_arm_bruised", "left_leg_bruised", "right_leg_bruised"}
			
			local tar = rime.target
			local bruise_count = 0
			
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end

			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end

			if rime.pvp.has_aff("left_leg_bruised", tar) and bruise_count >= 3 and break_count < 1 then
				return rime.teradrim.attacks.left_leg_broken[5]
			elseif rime.targets[rime.target].limbs["left_leg"] >= 1540 and rime.targets[rime.target].limbs["left_leg"] < 3333 then
				return rime.teradrim.attacks.left_leg_broken[6]
			elseif rime.targets[rime.target].limbs["left_leg"] >= 5300 and rime.targets[rime.target].limbs["left_leg"] <= 6666 then
				return rime.teradrim.attacks.left_leg_broken[6]
			elseif rime.targets[rime.target].limbs["left_leg"] < 1540 and not rime.pvp.has_aff("left_leg_broken", tar) then
				return rime.teradrim.attacks.left_leg_broken[1]
			else
				return rime.teradrim.attacks.left_leg_broken[2]
			end
		end,
		can = function()
			local tar = rime.target
			-- and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.route_choice == "group" then
				if not rime.pvp.has_aff("left_leg_broken", tar) then
					return true
				else
					return false
				end
			elseif not rime.pvp.parry_pred("left_leg") and not rime.limit.left_leg_restore then
				return true
			else
				return false
			end
		end
	},
	["right_leg_broken"] = {
		"earth fracture target right leg",
		"earth barrage target",
		"earth furor target right leg ",
		"sand scourge target",
		"earth shockwave target",
		"earth batter target right leg",
		choice = function()
			local bruises = {"left_arm_bruised", "right_arm_bruised", "left_leg_bruised", "right_leg_bruised"}
			local tar = rime.target
			local bruise_count = 0
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end

			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end
			
			if rime.pvp.has_aff("right_leg_bruised", tar) and bruise_count >= 3 and break_count < 1 then
				return rime.teradrim.attacks.right_leg_broken[5]
			elseif rime.targets[rime.target].limbs["right_leg"] >= 1540 and rime.targets[rime.target].limbs["right_leg"] < 3333 then
				return rime.teradrim.attacks.right_leg_broken[6]
			elseif rime.targets[rime.target].limbs["right_leg"] >= 5300 and rime.targets[rime.target].limbs["right_leg"] < 6666 then
				return rime.teradrim.attacks.right_leg_broken[6]
			elseif rime.targets[rime.target].limbs["right_leg"] < 1540 and not rime.pvp.has_aff("right_leg_broken", tar) then
				return rime.teradrim.attacks.right_leg_broken[1]
			else
				return rime.teradrim.attacks.right_leg_broken[2]
			end
		end,
		can = function()
			local tar = rime.target
			-- and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.route_choice == "group" then
				if not rime.pvp.has_aff("right_leg_broken", tar) then
					return true
				else
					return false
				end
			elseif not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") then
				return true
			else
				return false
			end
		end,
	},
	["left_arm_broken"] = {
		"earth fracture target left arm",
		"earth barrage target",
		"earth furor target left arm ",
		"sand scourge target",
		"earth shockwave target",
		"earth batter target left arm",
		choice = function()
			local bruises = {"left_arm_bruised", "right_arm_bruised", "left_leg_bruised", "right_leg_bruised"}
			local tar = rime.target
			local bruise_count = 0
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end

			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end

			if rime.pvp.has_aff("left_arm_bruised", tar) and bruise_count >= 3 and break_count < 1 then
				return rime.teradrim.attacks.left_arm_broken[5]
			elseif rime.targets[rime.target].limbs["left_arm"] >= 1540 and rime.targets[rime.target].limbs["left_arm"] < 3333  then
				return rime.teradrim.attacks.left_arm_broken[6]
			elseif rime.targets[rime.target].limbs["left_arm"] >= 5300 and rime.targets[rime.target].limbs["left_arm"] < 6666 then
				return rime.teradrim.attacks.left_arm_broken[6]
			elseif rime.targets[rime.target].limbs["left_arm"] < 1540 and not rime.pvp.has_aff("left_arm_broken", tar) then
				return rime.teradrim.attacks.left_arm_broken[1]
			else
				return rime.teradrim.attacks.left_arm_broken[2]
			end
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.route_choice == "group" then
				if not rime.pvp.has_aff("left_arm_broken", tar) then
					return true
				else
					return false
				end
			elseif not rime.limit.left_arm_restore and not rime.pvp.parry_pred("left_arm") then
				return true
			else
				return false
			end
		end,
	},
	["right_arm_broken"] = {
		"earth fracture target right arm",
		"earth barrage target",
		"earth furor target right arm ",
		"sand scourge target",
		"earth shockwave target",
		"earth batter target right arm",
		choice = function()
			local bruises = {"left_arm_bruised", "right_arm_bruised", "left_leg_bruised", "right_leg_bruised"}
			local tar = rime.target
			local bruise_count = 0
			for k,v in ipairs(bruises) do
				if rime.pvp.has_aff(v, tar) then
					bruise_count = bruise_count+1
				end
			end

			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end


			if rime.pvp.has_aff("right_arm_bruised", tar) and bruise_count >= 3 and break_count < 1 then
				return rime.teradrim.attacks.right_arm_broken[5]
			elseif rime.targets[rime.target].limbs["right_arm"] >= 1540 and rime.targets[rime.target].limbs["right_arm"] < 3333 then
				return rime.teradrim.attacks.right_arm_broken[6]
			elseif rime.targets[rime.target].limbs["right_arm"] >= 5300 and rime.targets[rime.target].limbs["right_arm"] < 6666 then
				return rime.teradrim.attacks.right_arm_broken[6]
			elseif rime.targets[rime.target].limbs["right_arm"] < 1540 and not rime.pvp.has_aff("right_arm_broken", tar) then
				return rime.teradrim.attacks.right_arm_broken[1]
			else
				return rime.teradrim.attacks.right_arm_broken[2]
			end
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar)
			if rime.pvp.route_choice == "group" then
				if not rime.pvp.has_aff("right_arm_broken", tar) then
					return true
				else
					return false
				end
			elseif not rime.limit.right_arm_restore and not rime.pvp.parry_pred("right_arm") then
				return true
			else
				return false
			end
		end,
	},
	["indifference"] = {
		"earth skullbash target",
		choice = function()
			return rime.teradrim.attacks.indifference[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("head_bruised_moderate", tar) and not rime.pvp.parry_pred("head") and not rime.pvp.has_aff("indifference", tar) then
				return true
			else
				return false
			end
		end,
	},
	["writhe_impaled"] = {
		"earth impale target",
		choice = function()
			return rime.teradrim.attacks.writhe_impaled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.pvp.route_choice == "group" then
				if rime.pvp.has_aff("prone", tar) and not rime.pvp.has_aff("writhe_impaled", tar) then
					return true
				else
					return false
				end
			elseif rime.pvp.target_tumbling and not rime.pvp.has_aff("deepwound", tar) then
				return true
			else
				return false
			end
		end,
	},
	["stonevice"] = {
		"earth stonevice",
		choice = function()
			return rime.teradrim.attacks.stonevice[1]
		end,
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("writhe_impaled", tar) then
				return true
			else
				return false
			end
		end,
	},
	-- ["sandrot"] = {
	-- 	"sand curse target storm",
	-- 	choice = function()
	-- 		return rime.teradrim.attacks.sandrot[1]
	-- 	end,
	-- 	can = function()
	-- 		if rime.teradrim.get_sand() ~= "sand curse target storm" then
	-- 			return true
	-- 		else
	-- 			return false
	-- 		end
	-- 	end,
	-- },
	["collapsed_lung"] = {
		"earth pulp target",
		choice = function()
			return rime.teradrim.attacks.collapsed_lung[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.has_aff("prone", tar) and not rime.pvp.has_aff("collapsed_lung", tar) then
				return true
			else
				return false
			end
		end,
	},
	["heartflutter"] = {
		"earth gutsmash target",
		choice = function()
			return rime.teradrim.attacks.heartflutter[1]
		end,
		can = function()
			local tar = rime.target
			--and not rime.pvp.has_def("shielded", tar) 
			if rime.pvp.runemark_minor == "green" then
				return true
			else
				return false
			end
		end,
	},
	["limbPrepper"] = {
        "earth furor target pick1 pick2",
        can = function()
            local target_limbs = table.copy(rime.targets[rime.target].limbs)
            local sort_limbs = sortedKeys(target_limbs)
			local sorted_limbs = {}
			local prepping = {}
			local breaking = {}
            local mode = rime.pvp.prediction_mode
            local last_parried = rime.targets[rime.target].parry
			local tar = rime.target
  
            for _, key in ipairs(sort_limbs) do
                table.insert(sorted_limbs, key)
            end
            for k, v in ipairs(rime.targets[rime.target].limbs) do
                if rime.limit[v .. "_restore"] then
                    table.remove(sorted_limbs, table.index_of(sorted_limbs, v))
                end
            end
  
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "head"))
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "torso"))
  
            if rime.pvp.canParry() and table.contains(sorted_limbs, last_parried) then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, last_parried))
            end
            if lastLimbHit ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, lastLimbHit:gsub(" ", "_")))
            end
            if prerestoredLimb ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, prerestoredLimb:gsub(" ", "_")))
			end
			
			for k, v in ipairs(sorted_limbs) do
				if rime.targets[rime.target].limbs[v] < 1540 then
					table.insert(prepping, v)
				elseif rime.targets[rime.target].limbs[v] >= 2313 and rime.targets[rime.target].limbs[v] < 3333 then
					table.insert(breaking, v)
				elseif rime.targets[rime.target].limbs[v] >= 5646 and rime.targets[rime.target].limbs[v] < 6666 then
					table.insert(breaking, v)
				end
			end

			--and not rime.pvp.has_def("shielded", tar) 
            if #breaking > 1 and #prepping < 1 then
				rime.teradrim.attacks.limbPrepper[1] = "earth furor target "..sorted_limbs[1]:gsub("_", " ").." "..sorted_limbs[2]:gsub("_", " ")
				return true
			elseif #prepping > 2 and rime.vitals.sandstorm <= 5 then
				rime.teradrim.attacks.limbPrepper[1] = "earth barrage target"
				return true
            else
				return false
            end
        end,
		choice = function()
			return rime.teradrim.attacks.limbPrepper[1]
		end
    },
	["limbPicker"] = {
        "earth furor target pick1 pick2",
        can = function()
            local target_limbs = table.copy(rime.targets[rime.target].limbs)
            local sort_limbs = sortedKeys(target_limbs)
			local sorted_limbs = {}
			local breaking = {}
            local mode = rime.pvp.prediction_mode
            local last_parried = rime.targets[rime.target].parry
			local tar = rime.target
  
            for _, key in ipairs(sort_limbs) do
                table.insert(sorted_limbs, key)
            end
            for k, v in ipairs(rime.targets[rime.target].limbs) do
                if rime.limit[v .. "_restore"] then
                    table.remove(sorted_limbs, table.index_of(sorted_limbs, v))
                end
            end
  
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "head"))
            table.remove(sorted_limbs, table.index_of(sorted_limbs, "torso"))
  
            if rime.pvp.canParry() and table.contains(sorted_limbs, last_parried) then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, last_parried))
            end
            if lastLimbHit ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, lastLimbHit:gsub(" ", "_")))
            end
            if prerestoredLimb ~= "none" then
                table.remove(sorted_limbs, table.index_of(sorted_limbs, prerestoredLimb:gsub(" ", "_")))
			end
			
			for k, v in ipairs(sorted_limbs) do
				if rime.targets[rime.target].limbs[v] >= 2600 and rime.targets[rime.target].limbs[v] < 3333 then
					table.insert(breaking, v)
				elseif rime.targets[rime.target].limbs[v] >= 5900 and rime.targets[rime.target].limbs[v] < 6666 then
					table.insert(breaking, v)
				end
			end

			--and not rime.pvp.has_def("shielded", tar) 
            if #breaking > 1 then
                rime.teradrim.attacks.limbPicker[1] = "earth furor target "..breaking[1]:gsub("_", " ").." "..breaking[2]:gsub("_", " ")
                return true
            else
               return false
            end
		end,
		choice = function()
			return rime.teradrim.attacks.limbPicker[1]
		end
    },
	["right_leg_mangled"] = {
		"earth batter target right leg",
		choice = function()
			return rime.teradrim.attacks.right_leg_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") and not rime.pvp.has_def("shielded", tar) and not rime.pvp.has_aff("right_leg_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_mangled"] = {
		"earth batter target left leg",
		choice = function()
			return rime.teradrim.attacks.left_leg_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") and not rime.pvp.has_def("shielded", tar) and not rime.pvp.has_aff("left_leg_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
	["right_arm_mangled"] = {
		"earth batter target right arm",
		choice = function()
			return rime.teradrim.attacks.right_arm_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") and not rime.pvp.has_def("shielded", tar) and not rime.pvp.has_aff("right_arm_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
	["left_arm_mangled"] = {
		"earth batter target left arm",
		choice = function()
			return rime.teradrim.attacks.left_arm_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") and not rime.pvp.has_def("shielded", tar) and not rime.pvp.has_aff("left_arm_mangled", tar) then
				return true
			else
				return false
			end
		end,
	},
}

rime.teradrim.sand_attacks = {
	["rebounding"] = {
		"sand slice target storm",
		choice = function()
			return rime.teradrim.sand_attacks.rebounding[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm >= 3 and rime.pvp.has_def("rebounding", tar) then
				return true
			else
				return false
			end
		end,
	},

	["sandrot"] = {
		"sand curse target storm",
		choice = function()
			return rime.teradrim.sand_attacks.sandrot[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.pvp.has_aff("sandrot", rime.target) then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_broken"] = {
		"sand scourge target storm",
		choice = function()
			return rime.teradrim.sand_attacks.left_leg_broken[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and rime.pvp.route_choice == "group"  and not rime.pvp.has_def("shielded", tar) then
				return true
			elseif rime.vitals.sandstorm >= 3 and not rime.pvp.has_aff("left_leg_broken", tar) and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end
	},
	["right_leg_broken"] = {
		"sand scourge target storm",
		choice = function()
			return rime.teradrim.sand_attacks.right_leg_broken[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and rime.pvp.route_choice == "group" and not rime.pvp.has_def("shielded", tar) then
				return true
			elseif rime.vitals.sandstorm == 5 and not rime.pvp.has_aff("right_leg_broken", tar)  and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end
	},
	["left_arm_broken"] = {
		"sand scourge target storm",
		choice = function()
			return rime.teradrim.sand_attacks.left_arm_broken[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and rime.pvp.route_choice == "group" then
				return true
			elseif rime.vitals.sandstorm == 5 and not rime.pvp.has_aff("left_arm_broken", tar) and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end
	},
	["right_arm_broken"] = {
		"sand scourge target storm",
		choice = function()
			return rime.teradrim.sand_attacks.right_arm_broken[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and rime.pvp.route_choice == "group" then
				return true
			elseif rime.vitals.sandstorm == 5 and not rime.pvp.has_aff("right_arm_broken", tar) and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end
	},
	["torso_mangled"] = {
		"sand shred target torso storm",
		choice = function()
			return rime.teradrim.sand_attacks.torso_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.limit.torso_restore and not rime.pvp.parry_pred("torso") and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	},
	["left_leg_mangled"] = {
		"sand shred target left leg storm",
		choice = function()
			return rime.teradrim.sand_attacks.left_leg_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.limit.left_leg_restore and not rime.pvp.parry_pred("left_leg") and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	},
	["right_leg_mangled"] = {
		"sand shred target right leg storm",
		choice = function()
			return rime.teradrim.sand_attacks.right_leg_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.limit.right_leg_restore and not rime.pvp.parry_pred("right_leg") and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	},
	["left_arm_mangled"] = {
		"sand shred target left arm storm",
		choice = function()
			return rime.teradrim.sand_attacks.left_arm_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.limit.left_arm_restore and not rime.pvp.parry_pred("left_arm") and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end
	},
	["right_arm_mangled"] = {
		"sand shred target right arm storm",
		choice = function()
			return rime.teradrim.sand_attacks.right_arm_mangled[1]
		end,
		can = function()
			local tar = rime.target
			if rime.vitals.sandstorm == 5 and not rime.limit.right_arm_restore and not rime.pvp.parry_pred("right_arm") and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	},
	["quicksand"] = {
		"sand quicksand target storm",
		choice = function()
			return rime.teradrim.sand_attacks.quicksand[1]
		end,
		can = function()
			local breaks = {"left_arm_broken", "right_arm_broken", "left_leg_broken", "right_leg_broken"}
			local tar = rime.target
			local break_count = 0
			for k,v in ipairs(breaks) do
				if rime.pvp.has_aff(v, tar) then
					break_count = break_count+1
				end
			end
			if rime.vitals.sandstorm == 5 and rime.pvp.has_aff("prone", tar) and break_count < 4 and not rime.pvp.has_def("shielded", tar) then
				return true
			else
				return false
			end
		end,
	}
}

rime.teradrim.golem_attacks = {
	["heartpunch"] = {
		"prepare earthenwill heatpunch",
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("torso_bruised", tar) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.heartpunch[1]
		end,
	},
	["rip"] = {
		"prepare earthenwill rip",
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("prone", tar) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.rip[1]
		end,
	},
	["wrack"] = {
		"prepare earthenwill wrack",
		can = function()
			local tar = rime.target
			if rime.targets[tar].limbs.torso >= 6600 then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.wrack[1]
		end,
	},
	["shout"] = {
		"prepare earthenwill shout",
		can = function()
			local tar = rime.target
			if rime.targets[tar].limbs.head > 2400 then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.shout[1]
		end,
	},
	["grapple"] = {
		"prepare earthenwill grapple",
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("prone", tar) and rime.targets[tar].limbs.torso > 2400 then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.grapple[1]
		end,
	},
	["choke"] = {
		"prepare earthenwill choke",
		can = function()
			local tar = rime.target
			if rime.pvp.has_aff("prone", tar) and rime.pvp.has_aff("head_bruised_moderate", tar) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.choke[1]
		end,
	},
	["dislocation"] = {
		"prepare earthenwill wrench",
		can = function()
			local tar = rime.target
			if string.find(rime.teradrim.get_flail(), "slam") and string.find(rime.teradrim.get_flail(), "left leg") and rime.pvp.has_aff("left_leg_bruised", tar) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.dislocation[1]
		end,
	},
	["writhe_grapple"] = {
		"prepare earthenwill grapple",
		can = function()
			if rime.targets[rime.target].limbs.torso > 2400 and rime.pvp.has_aff("prone", rime.target) then
				return true
			else
				return false
			end
		end,
		choice = function()
			return rime.teradrim.golem_attacks.writhe_grapple[1]
		end,
	},
}


function rime.teradrim.get_sand()

	local tar = rime.target

	for k,v in ipairs(rime.pvp.route.affs) do
		if rime.teradrim.sand_attacks[v] then
			if not rime.pvp.has_aff(v, tar) and rime.teradrim.sand_attacks[v].can() then
				return rime.teradrim.sand_attacks[v].choice()
			end
		end
	end

	return ""

end

function rime.teradrim.can_flail()

	local tar = rime.target
	
		if not rime.pvp.has_def("rebounding", tar) or string.find(rime.teradrim.get_sand(), "slice") then
	
			return true
	
		else
	
			return false
	
		end
	
end

function rime.teradrim.get_golem()

	local tar = rime.target

	for k,v in ipairs(rime.pvp.route.affs) do
		if rime.teradrim.golem_attacks[v] then
			if rime.teradrim.golem_attacks[v] and rime.teradrim.golem_attacks[v].can() then
				return rime.teradrim.golem_attacks[v].choice()
			end
		end
	end

	return ""

end

function rime.teradrim.get_flail()

	local tar = rime.target
	
		for k,v in ipairs(rime.pvp.route.affs) do
			if rime.teradrim.attacks[v] then
				if not rime.pvp.has_aff(v, tar)  and rime.teradrim.attacks[v].can() then
					return rime.teradrim.attacks[v].choice()
				elseif (v == "stonevice" or v == "writhe_impaled") and tonumber(rime.pvp.has_stack("stonevice", tar)) <= 3 and rime.teradrim.attacks[v].can() then
					return rime.teradrim.attacks[v].choice()
				end
			end
		end
	
end



rime.pvp.targetThere = rime.pvp.targetThere or true
rime.teradrim.lastCommand = rime.teradrim.lastCommand or ""

function rime.teradrim.offense()


	local sep = rime.saved.separator
	local target = rime.saved.target
	local sand = rime.vitals.sandstorm
	local golem_attack = rime.teradrim.get_golem()
	local sand_attack = rime.teradrim.get_sand()
	local flail_attack = rime.teradrim.get_flail()
	local pre_command = rime.pvp.queue_handle()
	local last_flail = ''
	local command = ''

	if flail_attack ~= nil then
		if rime.vitals.sandstorm == 5 and not string.find(rime.teradrim.get_sand(), "slice") then
			command = pre_command .. sep .. "order golem kill " .. rime.target .. sep .. "earth momentum" .. sep .. golem_attack .. sep .. sand_attack .. sep .. "sand slice target storm" .. sep .. flail_attack
		else
			command = pre_command .. sep .. "order golem kill " .. rime.target .. sep .. "earth momentum" .. sep .. golem_attack .. sep .. sand_attack .. sep .. flail_attack
		end
	end

	command = command:gsub("target", rime.target)
	command = command .. sep .. rime.pvp.post_queue()

	if not rime.vitals.prone and not (rime.has_aff("left_arm_broken") and rime.has_aff("right_arm_broken")) then
		act(command)
		rime.teradrim.lastCommand = command
	end

end