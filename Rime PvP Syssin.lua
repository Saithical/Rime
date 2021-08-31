syssin = syssin or {}

rime.pvp.Syssin.routes = {
	["black"] = {
		["venoms"] = {
			"slickness",
			"anorexia",
			"asthma",
			"paresis",
			"shyness",
			"clumsiness",
			"weariness",
			"stupidity",
			"haemophilia",
			"left_leg_broken",
			"right_leg_broken",
			"left_arm_broken",
			"right_arm_broken",
			"sleep",
			},

		["hypnosis"] = {


		},

	["white"] = {
		["venoms"] = {
			"paresis",
			"asthma",
			"clumsiness",
		},
	},
},
}

syssin.dstabs = {
	["paresis"] = {
		"curare",
		can = function()
			return true
		end,
	},
	["asthma"] = {
		"kalmia", 
		can = function()
			return true
		end,
	},
	["clumsiness"] = {
		"xentio",
		can = function()
			return true
		end,
	},
	["shyness"] = {
		"digitalis",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("impatience", target) then
				return true
			else
				return false
			end
		end,
	},
	["weariness"] = {
		"vernalius",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("locked", target) or rime.targets[target].time.focus < 2 or rime.pvp.has_aff("impatience", target) or rime.pvp.has_aff("stupidity") then
				return true
			else
				return false
			end
		end,
	},
	["stupidity"] = {
		"aconite",
		can = function()
			local target = rime.target
			if rime.pvp.has_aff("locked", target) or rime.targets[target].time.focus < 2 or rime.pvp.has_aff("impatience", target) then
				return true
			else
				return false
			end
		end,
	},
}


function syssin.dstab_attack()


	local sep = rime.saved.separator
	local targ = rime.target
	local first_venom = false
	local second_venom = false

	for k,v in ipairs(rime.pvp.route.venoms) do
		if not rime.pvp.has_aff(v, targ) and syssin.dstabs[v].can() and first_venom then
			second_venom = syssin.dstabs[v][1]
			break
		elseif not rime.pvp.has_aff(v, targ) and syssin.dstabs[v].can() then
			first_venom = syssin.dstabs[v][1]
		end
	end

	act("qeb quickwield right dirk" .. sep .. "dstab " .. targ .. " " .. first_venom .. " " .. second_venom)


end