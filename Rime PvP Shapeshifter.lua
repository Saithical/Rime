shifter = shifter or {}

rime.pvp.Shapeshifter.routes = {
	
	["quarter"] = {
		["attack"] = {
			"quarter",
			"writhe_thighlock",
			"left_leg_mangled",
			"left_leg_damaged",
			"left_leg_broken",
			"right_leg_mangled",
			"right_leg_damaged",
			"right_leg_broken",
			"left_leg_broken",
			"right_arm_broken",
			"left_arm_broken",
		}
	}


}

shifter.attacks = {
	["left_arm_broken"] = {
		"rend left",
		can = function()
			return true
		end,
		claw = true
	},
	["right_arm_broken"] = {
		"rend right",
		can = function()
			return true
		end,
		claw = true
	},
	["left_leg_broken"] = {
		"hamstring left",
		can = function()
			return true
		end,
		claw = true
	},
	["right_leg_broken"] = {
		"hamstring right",
		can = function()
			return true
		end,
		claw = true
	},
	["left_arm_damaged"] = {
		"mangle left arm of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("left_arm_broken", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["right_arm_damaged"] =	{
		"mangle right arm of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("right_arm_broken", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["left_leg_damaged"] = {
		"mangle left leg of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("left_leg_broken", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["right_leg_damaged"] = {
		"mangle right leg of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("right_leg_broken", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["left_arm_mangled"] = {
		"destroy left arm of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("left_arm_damaged", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["right_arm_mangled"] = {
		"destroy right arm of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("right_arm_damaged", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["left_leg_mangled"] = {
		"destroy left leg of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("left_leg_damaged", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["right_leg_mangled"] = {
		"destroy right leg of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("right_leg_damaged", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},
	["writhe_thighlock"] = {
		"jawlock thigh of target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("left_leg_mangled", targ) or rime.pvp.has_aff("right_leg_mangled", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},

	["quarter"] = {
		"quarter target",
		can = function()
			local targ = rime.target
			if rime.pvp.has_aff("writhe_thighlock", targ) then
				return true
			else
				return false
			end
		end,
		claw = false
	},

}




function shifter.pick_attack()

		local targ = rime.target
		local attack = "nothing"
		local combo = false
		local attack_two = false
		local sep = rime.saved.separator

		for k,v in ipairs(rime.pvp.route.attack) do
			if not rime.pvp.has_aff(v, targ) and shifter.attacks[v].can() then
				attack = shifter.attacks[v][1]
				combo = shifter.attacks[v].claw
				break
			end
		end

		if combo then
			for k,v in ipairs(rime.pvp.route.attack) do
				if not rime.pvp.has_aff(v, targ) and shifter.attacks[v][1] ~= attack and shifter.attacks[v].can() then
					attack_two = shifter.attacks[v][1]
					break
				end
			end
		end


		if combo then

			return "combo " .. targ .. " " .. attack .. " " .. attack_two

		else

			return attack

		end


end

function shifter.offense()

	local sep = rime.saved.separator
	local attack = shifter.pick_attack()

	attack = attack:gsub("target", rime.target)

	if has_def("fury") then

		attack = "pounce " .. rime.target .. sep .. attack

	end

	act(rime.pvp.queue_handle() .. sep .. attack)


end