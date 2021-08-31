rime.attacks = rime.attacks or {}
rime.attacks.personal = false

rime.attacks = {

	--#Carnifex
	["Savagery"] = {

		Hammerthrow = function(target)
			return
		end,

		Hack = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,
		
		Skewer = function(target, fail_check)
			if not fail_check then
				rime.pvp.add_aff("writhe_impaled", target)
				rime.pvp.add_limb("torso", target, 1249)
				rime.pvp.aggro(target)
				if rime.attacks.personal then targetImpaled = true end
				if target == rime.target then rime.pvp.target_tumbling = false end
			else
				rime.pvp.remove_aff("prone", target)
			end
		end,

		Wrench = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_limb("torso", target, 1249)
		end,

		Hook = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("prone", target)
		end,

		Spinning = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			--rime.pvp.web_venoms()
		end,

		Carve = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.web_venoms()
		end,

		Reveling = function(target)
			--add def here
		end,

		Furor = function(target)
			--add def here
		end,

		Batter = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Gutcheck = function(target)
			rime.pvp.aggro(target)
			if rime.attacks.personal then rime.pvp.add_limb("torso", target, 1469) else rime.pvp.add_limb("torso", target, 1400) end
			rime.last_hit = target
			lastLimbHit = "torso"
			rime.time("gutcheck", target)
			if target == rime.target then gutcheckHit = true end
		end,

		Charging = function(target)
			if rime.attacks.personal then carn.need_charge = false end
		end,

		Razehack = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.web_venoms()
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
		end,

		Raze = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or razed == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
		end,

		Fearless = function(target)
			return
		end,

		Doublebash = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Crush = function(target, where)
			rime.pvp.aggro(target)
			if where == "elbows" then
				rime.pvp.add_aff("crushed_elbows", target)
			elseif where == "knees" then
				rime.pvp.add_aff("crushed_knees", target)
			elseif where == "chest" then
				return
			end
		end,

		Pulverize = function(target)
			rime.pvp.aggro(target, "reset")
			rime.echo("RIP THIS MANS")
		end,

		Swat = function(target)
			rime.pvp.aggro(target, "reset")
			return
		end,

		Cruelty = function(target)
			return
		end,

		Herculeanrage = function()
			return
		end,

		Reckless = function()
			return
		end,

		Fitness = function(target)
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
		end,

		Gripping = function()
			return
		end,

		Dismember = function(target, fail)
			rime.pvp.aggro(target)
			return
		end,

        Whirlwind = function(who, stage)
            if rime.attacks.personal then
                if stage == "start" then
                    enableTimer("whirlwind_timer")
                elseif stage == "end" then
                    disableTimer("whirlwind_timer")
                end
            end
            if who ~= gmcp.Char.Status.name then
                if not table.contains(rime.pvp.beyblades, who) then
                    rime.pvp.beyblades[who] = {
                        ["venoms"] = {},
                    }
                end
            end
        end,

	},

	["Warhounds"] = {

		Sniff = function(target)
			return
		end,

		Openings = function(target)
			return
		end,

		Dismiss = function(target)
			return
		end,

		Whistle = function()
			if rime.attacks.personal then
				active_hound = rime.saved.hound_atks.mark
				rime.pve.openings = false
				rime.pve.need_ents = false
				if rime.pve.bashing then rime.pve.bash_attack() end
			end
		end,

		Openings = function()
			if rime.attacks.personal then
				rime.pve.openings = true
				if rime.pve.bashing then rime.pve.bash_attack() end
			end
		end,

		Deliver = function(target)
			return
		end,

		Switch = function(target)
			if rime.attacks.personal then rime.pve.openings = false end
			return
		end,

		Recall = function(target)
			return
		end,

		Shock = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("epilepsy", target) then
				rime.pvp.add_aff("epilepsy", target)
			elseif not rime.pvp.has_aff("hallucinations", target) then
				rime.pvp.add_aff("hallucinations", target)
			end
			carn.lastHound = "none"
		end,

		Growl = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("dizziness", target) then
				rime.pvp.add_aff("dizziness", target)
			elseif not rime.pvp.has_aff("recklessness", target) then
				rime.pvp.add_aff("recklessness", target)
			end
			carn.lastHound = "none"
		end,

		Poisonclaw = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("blisters", target) then
				rime.pvp.add_aff("blisters", target)
			elseif not rime.pvp.has_aff("limp_veins", target) then
				rime.pvp.add_aff("limp_veins", target)
			end
			carn.lastHound = "none"
		end,

		Acidspit = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("weariness", target) then
				rime.pvp.add_aff("weariness", target)
			elseif not rime.pvp.has_aff("crippled", target) then
				rime.pvp.add_aff("crippled", target)
			end
			carn.lastHound = "none"
		end,

		Stare = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("berserking", target) then
				rime.pvp.add_aff("berserking", target)
			elseif not rime.pvp.has_aff("impairment", target) then
				rime.pvp.add_aff("impairment", target)
			end
			carn.lastHound = "none"
		end,

		Mark = function(target)
			if rime.attacks.personal then rime.pvp.add_aff("houndmark", target) end
			carn.lastHound = "none"
		end,

		Tundralhowl = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("caloric", target)
			carn.lastHound = "none"
		end,

		Firebreath = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("ablaze", target)
			carn.lastHound = "none"
		end,

		Bite = function(target, limb)
			rime.pvp.aggro(target)
			if not limb then return end
			rime.pvp.add_limb(limb, target, 349)
			rime.last_hit = target
			carn.lastHound = "none"
		end,

	},

	["Deathlore"] = {

		Cull = function(target)
			return
		end,

		Strike = function(target)
			return
		end,

		Consume = function(target)
			return
		end,

		Souldrain = function(target)
			return
		end,

		Reave = function(target, stage)
			if target == "you" then
				if stage == "begin" then
					rime.echo("YOU'RE BEING REAVED BY "..matches[2]:upper())
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					rime.echo("YOU'RE BEING REAVED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING REAVED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING REAVED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.pvp.aggro(target)
				else
					rime.echo("I can't believe you let them do this to you, smh", "pvp")
				end
			else
				if stage == "begin" then
					rime.echo(target.." being reaved by "..matches[2], "pvp")
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					rime.echo(target.." being reaved by "..matches[2], "pvp")
					rime.pvp.aggro(target)
				else
					if rime.attacks.personal then
						expandAlias("dab")
						rime.paused = false
						rime.pvp.aggro(target, "reset")
					else
						rime.echo(matches[2]:upper().." REAVED "..target:upper().." THE ABSOLUTE MAD PERSON", "pvp")
						rime.pvp.aggro(target, "reset")
					end
				end
			end
		end,

		Disease = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("soul_disease", target)
		end,

		Wraith = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("wraith", target)
		end,

		Soulbind = function(target)
			return
		end,

		Shroud = function(target)
			return
		end,

		Sacrifice = function(target)
			--add def here
		end,

		Fortify = function(target)
			return
		end,

		Shield = function(target)
			rime.pvp.addDef("shielded", target)
		end,

		Erode = function(target)
			rime.pvp.aggro(target)
			rime.pvp.noDef("rebounding", target)
			rime.pvp.noDef("shielded",  target)
			rime.pvp.noDef("prismatic", target)
		end,

		Substitute = function(target)
			return
		end,

		Distortion = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("distortion", target)
			if rime.attacks.personal then carn.can.distort = false end
		end,

		Implant = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Frailty = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("glasslimb", target)
		end,

		Poison = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("soul_poison", target)
		end,

		Bloodburst = function(target)
			if target == "you" then return end
			rime.pvp.add_aff("hypertension", target)
			if not rime.targets[target].bloodburstCount then rime.targets[target].bloodburstCount = 0 end
			rime.targets[target].bloodburstCount = rime.targets[target].bloodburstCount +1
		end,

		Spiritsight = function()
			return
		end,

		Soulthirst = function()
			if rime.attacks.personal then
				addDef("soulthirst")
			end
		end,

		Fracture = function()
			return
		end,

		Summon = function()
			return
		end,

		Puncture = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("soulpuncture", target)
		end,

		
	},

	--#Warden

	["Warding"] = {

		Release = function(target)
			rime.pvp.aggro(target)
		end,

		Strike = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,
		
		Constrict = function(target, fail_check)
			if not fail_check then
				rime.pvp.add_aff("writhe_impaled", target)
				rime.pvp.add_limb("torso", target, 1249)
				rime.pvp.aggro(target)
				if rime.attacks.personal then targetImpaled = true end
				if target == rime.target then rime.pvp.target_tumbling = false end
			else
				rime.pvp.remove_aff("prone", target)
			end
		end,

		Twist = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_limb("torso", target, 1249)
		end,

		Terrorize = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("prone", target)
		end,

		Lacerate = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			--rime.pvp.web_venoms()
		end,

		Shed = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.web_venoms()
		end,

		Initiative = function(target)
			--add def here
		end,

		Rigor = function(target)
			--add def here
		end,

		Bash = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Rush = function(target)
			rime.pvp.aggro(target)
			if rime.attacks.personal then rime.pvp.add_limb("torso", target, 1469) else rime.pvp.add_limb("torso", target, 1400) end
			rime.last_hit = target
			lastLimbHit = "torso"
			rime.time("gutcheck", target)
			if target == rime.target then gutcheckHit = true end
		end,

		Anticipate = function(target)
			if rime.attacks.personal then carn.need_charge = false end
		end,

		Bypass = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
			rime.pvp.web_venoms()
		end,

		Raze = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or razed == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
		end,

		Fortitude = function(target)
			return
		end,

		Maul = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Pummel = function(target, where)
			rime.pvp.aggro(target)
			if where == "elbows" then
				rime.pvp.add_aff("crushed_elbows", target)
			elseif where == "knees" then
				rime.pvp.add_aff("crushed_knees", target)
			elseif where == "chest" then
				return
			end
		end,

		Decimate = function(target)
			rime.pvp.aggro(target, "reset")
			rime.echo("RIP THIS MANS")
		end,

		Barrel = function(target)
			rime.pvp.aggro(target, "reset")
			return
		end,

		Homage = function(target)
			return
		end,

		Roaring = function()
			return
		end,

		Battleflow = function()
			return
		end,

		Fitness = function(target)
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
		end,

		Gripping = function()
			return
		end,

		Destruction = function(target, fail)
			rime.pvp.aggro(target)
			return
		end,

        Sidewind = function(who, stage)
            if rime.attacks.personal then
                if stage == "start" then
                    enableTimer("whirlwind_timer")
                elseif stage == "end" then
                    disableTimer("whirlwind_timer")
                end
            end
            if who ~= gmcp.Char.Status.name then
                if not table.contains(rime.pvp.beyblades, who) then
                    rime.pvp.beyblades[who] = {
                        ["venoms"] = {},
                    }
                end
            end
        end,

	},
	
	["Ancestry"] = {

		Lunge = function(target)
			return
		end,

		Duel = function(target)
			return
		end,

		Consume = function(target)
			return
		end,

		Expel = function(target)
			return
		end,

		Sacrifice = function(target, stage)
			if target == "you" then
				if stage == "begin" then
					rime.echo("YOU'RE BEING SACRIFICED BY "..matches[2]:upper())
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					rime.echo("YOU'RE BEING SACRIFICED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING SACRIFICED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING SACRIFICED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.pvp.aggro(target)
				else
					rime.echo("I can't believe you got Baludu'd. For shame.", "pvp")
				end
			else
				if stage == "begin" then
					rime.echo(target.." being sacrificed by "..matches[2], "pvp")
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					rime.echo(target.." being sacrificed by "..matches[2], "pvp")
					rime.pvp.aggro(target)
				else
					if rime.attacks.personal then
						expandAlias("dab")
						rime.paused = false
						rime.pvp.aggro(target, "reset")
					else
						rime.echo(matches[2]:upper().." SACRIFICED "..target:upper().." THE ABSOLUTE MAD PERSON", "pvp")
						rime.pvp.aggro(target, "reset")
					end
				end
			end
		end,

		Portent = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("ancestral_portent", target)
		end,

		Inhibit = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("inhibited", target)
		end,

		Clarity = function(target)
			return
		end,

		Distort = function(target)
			return
		end,

		Offering = function(target)
			--add def here
		end,

		Bolster = function(target)
			return
		end,

		Intercept = function(target)
			rime.pvp.addDef("shielded", target)
		end,

		Carve = function(target)
			rime.pvp.aggro(target)
			rime.pvp.noDef("rebounding", target)
			rime.pvp.noDef("shielded",  target)
			rime.pvp.noDef("prismatic", target)
		end,

		Intervention = function(target)
			return
		end,

		Elude = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("eluded", target)
			if rime.attacks.personal then carn.can.distort = false end
		end,

		Attune = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Debilitate = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("debilitated", target)
		end,

		Ambush = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("ancestral_ambush", target)
		end,

		Engorge = function(target)
			if target == "you" then return end
			rime.pvp.add_aff("hypertension", target)
			if not rime.targets[target].bloodburstCount then rime.targets[target].bloodburstCount = 0 end
			rime.targets[target].bloodburstCount = rime.targets[target].bloodburstCount +1
		end,

		Seance = function()
			return
		end,

		Displacement = function()
			return
		end,

		Invocation = function()
			return
		end,

		Fissure = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("soulpuncture", target)
		end,

	},

	["Communion"] = {

		Scout = function(target)
			return
		end,

		Openings = function(target)
			return
		end,

		Dismiss = function(target)
			return
		end,

		Rally = function()
			if rime.attacks.personal then
				active_hound = rime.saved.hound_atks.mark
				rime.pve.openings = false
				rime.pve.need_ents = false
				if rime.pve.bashing then rime.pve.bash_attack() end
			end
		end,

		Openings = function()
			if rime.attacks.personal then
				rime.pve.openings = true
				if rime.pve.bashing then rime.pve.bash_attack() end
			end
		end,

		Deliver = function(target)
			return
		end,

		Switch = function(target)
			if rime.attacks.personal then rime.pve.openings = false end
			return
		end,

		Recall = function(target)
			return
		end,

		Stormwarden = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("epilepsy", target) then
				rime.pvp.add_aff("epilepsy", target)
			elseif not rime.pvp.has_aff("hallucinations", target) then
				rime.pvp.add_aff("hallucinations", target)
			end
			carn.lastHound = "none"
		end,

		Chanter = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("dizziness", target) then
				rime.pvp.add_aff("dizziness", target)
			elseif not rime.pvp.has_aff("recklessness", target) then
				rime.pvp.add_aff("recklessness", target)
			end
			carn.lastHound = "none"
		end,

		Toxicologist = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("blisters", target) then
				rime.pvp.add_aff("blisters", target)
			elseif not rime.pvp.has_aff("limp_veins", target) then
				rime.pvp.add_aff("limp_veins", target)
			end
			carn.lastHound = "none"
		end,

		Harrier = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("weariness", target) then
				rime.pvp.add_aff("weariness", target)
			elseif not rime.pvp.has_aff("crippled", target) then
				rime.pvp.add_aff("crippled", target)
			end
			carn.lastHound = "none"
		end,

		Inciter = function(target)
			rime.pvp.aggro(target)
			if not rime.pvp.has_aff("berserking", target) then
				rime.pvp.add_aff("berserking", target)
			elseif not rime.pvp.has_aff("impairment", target) then
				rime.pvp.add_aff("impairment", target)
			end
			carn.lastHound = "none"
		end,

		Mark = function(target)
			if rime.attacks.personal then rime.pvp.add_aff("houndmark", target) end
			rime.pvp.aggro(target)
			carn.lastHound = "none"
		end,

		Snowdancer = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("caloric", target)
			carn.lastHound = "none"
		end,

		Firestrike = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("ablaze", target)
			carn.lastHound = "none"
		end,

		Assault = function(target, limb)
			rime.pvp.aggro(target)
			if not limb then return end
			rime.pvp.add_limb(limb, target, 349)
			rime.last_hit = target
			carn.lastHound = "none"
		end,

	},

	--#Zealot

	["Zeal"] = {

		Descent = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.add_aff("backstrain", target)
		end,

		Rive = function(target)
			rime.pvp.aggro(target)
		end,

		Swagger = function(target)
			return
		end,
		
		Edgekick = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("crippled_throat", target)
			rime.pvp.add_limb("head", target, 350)
		end,

		Jawcrack = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("stuttering", target)
			rime.pvp.add_aff("blurry_vision", target)
		end,

		Uprise = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("whiplash", target)
		end,

		Pummel = function(target, limb)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_limb(limb, target, 950)
		end,

		Sunkick = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("stupidity", target)
			rime.pvp.add_aff("dizziness", target)
			rime.pvp.add_limb("head", target, 950)
		end,

		Wanekick = function(target, limb)
			rime.pvp.aggro(target)
			rime.pvp.add_limb(limb, target, 900)
		end,

		Heelrush = function(target, limb)
			rime.pvp.aggro(target)
			if target == "you" then
				rime.curing.heel_rush = limb
				tempTimer(3, [[rime.curing.heel_rush = "none"]])
			end
		end,

		Clawtwist = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_limb("torso", target, 850)
		end,

		Anklepin = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("sore_ankle", target)
		end,

		Twinpress = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("stiffness", target)
			rime.pvp.add_aff("muscle_spasms", target)
		end,

		Dislocate = function(target, limb)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.add_aff(limb.."_dislocated", target)
		end,

		Wristlash = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.add_aff("sore_wrist", target)
		end,

	},

	["Purification"] = {

		Pendulum = function(target, direction)
			rime.pvp.aggro(target)
			if target == "you" then
				if direction == "clockwise" then
				    local pendulum = table.copy(rime.curing.limbs)
				    rime.curing.limbs.right_arm = pendulum.left_arm
				    rime.curing.limbs.left_arm = pendulum.left_leg
				    rime.curing.limbs.right_leg = pendulum.right_arm
				    rime.curing.limbs.left_leg = pendulum.right_leg
				else
				    local pendulum = table.copy(rime.curing.limbs)
				    rime.curing.limbs.right_arm = pendulum.right_leg
				    rime.curing.limbs.left_arm = pendulum.right_arm
				    rime.curing.limbs.right_leg = pendulum.left_leg
				    rime.curing.limbs.left_leg = pendulum.left_leg
				end
			else
				if direction == "clockwise" then
				    local pendulum = table.copy(rime.targets[target].limbs)
				    rime.targets[target].limbs.right_arm = pendulum.left_arm
				    rime.targets[target].limbs.left_arm = pendulum.left_leg
				    rime.targets[target].limbs.right_leg = pendulum.right_arm
				    rime.targets[target].limbs.left_leg = pendulum.right_leg
				else
				    local pendulum = table.copy(rime.curing.limbs)
				    rime.targets[target].limbs.right_arm = pendulum.right_leg
				    rime.targets[target].limbs.left_arm = pendulum.right_arm
				    rime.targets[target].limbs.right_leg = pendulum.left_leg
				    rime.targets[target].limbs.left_leg = pendulum.left_leg
				end
			end
		end,

		Pyromania = function(caster)
			return 
		end,


		Firefist = function(target)
			return
		end,

		Zenith = function(target)
			return
		end,

		Heatspear = function(target)
			rime.pvp.aggro(target)
			if rime.pvp.has_aff("ablaze", target) then
				rime.pvp.add_aff("heatspear", target)
			end
		end,

		Scorch = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("ablaze", target)
		end,

		Resurgence = function(target)
			if rime.attacks.personal then
    			rime.reset()
			end
    		act("wt "..target.." starbursted!")
    	end,
	},

	["Psionics"] = {

		Shock = function(target)
			return
		end,

	},


	--#Sentinel

	["Dhuriv"] = {

		Whirl = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Followup = {
			Whirl = function(target)
				rime.pvp.aggro(target)
				rime.last_hit = target
			end,
		},

		Stab = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,
		
		Slash = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Gouge = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("impatience", target)
		end,

		Heartbreaker = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("heartflutter", target)
		end,

		Thrust = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_limb("torso", target, 350)
		end,

		Crosscut = function(target)
			rime.pvp.aggro(target)
			if rime.pvp.has_aff("impairment", target) then
				rime.pvp.add_aff("addiction", target)
			else
				rime.pvp.add_aff("impairment", target)
			end
		end,

		Throatcrush = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("destroyed_throat", target)
		end,

		Twirl = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("confusion", target)
		end,

		Impale = function(target)
			rime.pvp.add_aff("writhe_impaled", target)
			rime.pvp.aggro(target)
			rime.pvp.add_limb("torso", target, 1250)
			if target == rime.target then rime.pvp.target_tumbling = false end
		end,

		Reave = function(target, def)
			if target == "you" then return end
			rime.pvp.noDef(def, target)
			rime.pvp.aggro(target)
		end,

		Riposte = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
		end,

		Weaken = function(target, limb)
			if target == "you" then return end
			rime.pvp.aggro(target)
		end,

		Flourish = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
		end,


	},

	["Tracking"] = {

		Scent = function(target)
			return
		end,

		Hurling = function(target, resin)
			rime.pvp.aggro(target)
			return
		end,

		Combust = function(target)
			rime.pvp.aggro(target)
			return
		end,
	},

	["Woodlore"] = {

		Might = function(target)
			return
		end,

		Icebreath = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.add_aff("caloric", target)
		end,
	},

	--#Luminary

	["Spirituality"] = {

		Absolve = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target, "reset")
			return
		end,

		Power = function(target)
			return 
		end,

		Crush = function(target, limb)
			if target == "you" then return end
			rime.pvp.aggro(target)
		end,

		Sacrifice = function(target)
			rime.pvp.clear_target(target)
		end,

		Sap = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			return
		end,

		Judgement = function(target)
			if target == "you" then
				rime.echo("YOU ARE BEING JUDGED!")
				rime.echo("YOU ARE BEING JUDGED!")
				rime.echo("YOU ARE BEING JUDGED!")
				rime.echo("YOU ARE BEING JUDGED!")
			else
				rime.pvp.aggro(target)
				rime.echo(string.upper(target).." IS BEING JUDGED!")
				rime.echo(string.upper(target).." IS BEING JUDGED!")
				rime.echo(string.upper(target).." IS BEING JUDGED!")
				rime.echo(string.upper(target).." IS BEING JUDGED!")
			end
		end,

		Overwhelm = function(target)
			rime.pvp.aggro(target)
			--blackout stuff
			return
		end,

		Crash = function(target)
			rime.pvp.add_aff("disrupted", target)
		end,

		Spiritwrack = function(target)
			return
		end,
		
		Strike = function(target)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff("paresis", target)
		end,

		Chasten = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Slam = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.add_aff("asthma", target)
		end,

		Brilliance = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("no_blind", target)
		end,

		Punch = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.add_aff("weariness", target)
		end,

		Battle = function(target, aff)
			rime.pvp.aggro(target)
			if target == "you" then return end
			rime.pvp.add_aff(aff, target)
		end,

		Raze = function(target, def)
			rime.pvp.aggro(target)
			if target == "you" then return end
			if def == "failure" then
				rime.pvp.noDef(target, "rebounding")
				rime.pvp.noDef(target, "shielded")
				return
			end
			rime.pvp.noDef(target, def)
		end,

		Aura = function(target)
			rime.pvp.addDef("shielded", target)
		end,

		Smite = function(target)
			rime.pvp.aggro(target)
		end,

	},

	["Devotion"] = {

		Hands = function(target)
			return
		end,

		Hellsight = function(target)
			rime.pvp.aggro(target)
			rime.pvp.add_aff("hellsight", target)
		end,

		Truth = function(target)
			return
		end,

		Force = function(target)
			return
		end,

		Peace = function(target)
			rime.pvp.add_aff("peace", target)
		end,

		Dazzle = function(target)
			rime.pvp.add_aff("confusion", target)
			rime.pvp.add_aff("dizziness", target)
		end,
	},

	["Illumination"] = {

		Lightform = function(target)
			rime.pvp.addDef("lightform", target)
		end,

		Flare = function(target)
			if target == "you" then
				for k,v in pairs(rime.curing.pipes) do
					if k ~= "last" then
						rime.curing.pipes[k] = false
					end
				end
				local sep = rime.saved.separator
				act("outc willow" .. sep .. "outc yarrow" .. sep .. "outc reishi")
			end
		end,

		Transfixion = function(target)
			rime.pvp.add_aff("writhe_transfix", target)
			rime.pvp.add_aff("no_blind", target)
		end,

		Cleansing = function(target)
			return
		end,

		Shine = function(target)
			return
		end,

		Heatwave = function(target)
			rime.pvp.add_aff("hallucinations", target)
			rime.pvp.add_aff("berserking", target)
		end,

		Shadow = function(target)
			rime.pvp.add_aff("shadowed", target)
		end,

		Rebirth = function(target)
			return
		end,

	},

	--Syssin

	["Assassination"] = {

		Doublestab = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.web_venoms()
			rime.pvp.web_venoms()
		end,

		Shrugging = function(target)
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
		end,

		Backstab = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.web_venoms()
		end,

		Flay = function(target, effect)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.last_hit = target
			if effect == "rebounding" or effect == "failure-rebounding" then
				rime.pvp.noDef("rebounding", target)
			elseif effect == "fangbarrier" or effect == "failure-fangbarrier" then
				rime.pvp.noDef("fangbarrier", target)
			elseif effect == "speed" or effect == "failure-speed" then
				rime.pvp.noDef("speed", target)
			elseif effect == "shield" or effect == "failure-shield" then
				rime.pvp.noDef("shielded", target)
			end
		end,

		Bite = function(target, effect)
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.add_aff(effect, target)
		end,

		Recuperate = function(target)
			return
		end,

		Garrote = function(target)
			rime.pvp.aggro(target)
		end,
	},

	["Subterfuge"] = {

		Bedazzle = function(target)
			if target == "you" then
				rime.hidden_aff("bedazzle")
				rime.hidden_aff("bedazzle")
				rime.check_hidden()
			end
		end,

	},

	["Hypnosis"] = {

		Marks = function(target, effect)
			rime.pvp.add_aff(string.lower(effect), target)
		end,

		Sleight = function(target, effect)
			rime.pvp.add_aff(string.lower(effect), target)
		end,
	},

	--Sciomancer

	["Sciomancy"] = {

		Engulf = function(target)
			return
		end,

		Shadeling = function(target)
			return
		end,

		Falter = function(target)
			return
		end,

		Leech = function(target)
			return
		end,

		Blast = function(target)
			return
		end,

		Mantle = function(target)
			--add def
			return
		end,

		Gloom = function(target)
			rime.pvp.add_aff("gloom", target)
		end,

		Voidgaze = function(target)
			rime.pvp.add_aff("voidgaze", target)
		end,

		Ruin = function(target)
			local ruin_affs = {"clumsiness", "weariness", "lethargy", "paresis"}
			for k,v in ipairs(ruin_affs) do
				if not rime.pvp.has_aff(v, target) then
					rime.pvp.add_aff(v, target)
					break
				end
			end
		end,

		Fever = function(target)
			rime.pvp.add_aff("haemophilia", target)
			rime.pvp.add_aff("vomiting", target)
		end,

		Shadowsphere = function(target)
			rime.pvp.add_aff("shadowsphere", target)
			rime.sciomancer.can.shadowsphere = false
		end,

		Shadowbrand = function(target, complete)
			if complete == "end" then
				rime.pvp.add_aff("shadowbrand", target)
			end
		end,

		Chill = function(target)
			rime.pvp.add_aff("caloric", target)
		end,

		Scourge = function(target)
			return
		end,

		Repay = function(target)
			return
		end,

		Hew = function(target)
			rime.pvp.noDef("shielded", target)
		end,

		Shaderot = function(target)
			if target == "you" then return end
			rime.pvp.add_aff("shaderot", target)
		end,

		["Shadowprice"] = {

			Haunt = function(target)
				return
			end,

			Falter = function(target)
				return
			end,

			Leech = function(target)
				return
			end,

			Gloom = function(target)
				rime.pvp.add_aff("gloom", target)
			end,

			Voidgaze = function(target)
				rime.pvp.add_aff("voidgaze", target)
				rime.pvp.add_aff("no_blind", target)
				rime.pvp.noDef("blind", target)
			end,

			Ruin = function(target)
				local ruin_affs = {"clumsiness", "weariness", "lethargy", "paresis"}
				for k,v in ipairs(ruin_affs) do
					if not rime.pvp.has_aff(v, target) then
						rime.pvp.add_aff(v, target)
						break
					end
				end

				for k,v in ipairs(ruin_affs) do
					if not rime.pvp.has_aff(v, target) then
						rime.pvp.add_aff(v, target)
						break
					end
				end
			end,

			Fever = function(target)
				rime.pvp.add_aff("haemophilia", target)
				rime.pvp.add_aff("vomiting", target)
			end,

			Shadowsphere = function(target)
				rime.pvp.add_aff("shadowsphere", target)
				rime.pvp.add_aff("nyctophobia", target)
				rime.sciomancer.can.shadowsphere = false
			end,

			Shadowbrand = function(target)
				rime.pvp.add_aff("shadowbrand", target)
			end,

			Scourge = function(target)
				return
			end,

			Hew = function(target)
				rime.pvp.noDef("shielded", target)
			end,

			Shaderot = function(target)
				if target == "you" then return end
				rime.pvp.add_aff("shaderot", target)
				rime.pvp.add_aff("shaderot", target)
			end,

		},

	},

	["Sorcery"] = {

		Transfix = function(target, blind)
    		if not blind then
    			rime.pvp.add_aff("no_blind", target)
    			rime.pvp.add_aff("writhe_transfix", target)
    		else
    			rime.pvp.add_aff("no_blind", target)
    		end
    		rime.sciomancer.can.transfix = false
		end,

		Ensorcell = function(target)
			return
		end,

		Sagacity = function(target)
			--add def
			return
		end,

		Countercurrent = function(target)
			--add def
			return
		end,

		Blurring = function(target)
			--add def
			return
		end,

	},

	["Gravitation"] = {

		Genesis = function(target)
			return
		end,

		Featherstep = function(target)
			--add def
			return
		end,

		Grip = function(target)
			rime.pvp.add_aff("paresis", target)
			rime.pvp.add_aff("prone", target)
			rime.pvp.add_stack("gravity", target)
		end,

		Imbue = function(target)
			rime.pvp.add_aff("imbue", target)
		end,

		Erupt = function(target, limb)
			local amount = {
				[0] = 400,
				[1] = 800,
				[2] = 1300,
				[3] = 1900,
				[4] = 2500,
				[5] = 3300,
			}
		if target == "you" then return end
			local target_gravity = rime.targets[target].stacks.gravity
			rime.pvp.add_limb(limb, target, tonumber(amount[target_gravity]))
			if not rime.pvp.has_aff("shadowbrand", target) then
				rime.targets[target].stacks.gravity = 0
				rime.echo(string.title(target).." lost all gravity stacks!", "pvp")
			elseif rime.pvp.has_aff("shadowbrand", target) and target_gravity < 3 then
				rime.targets[target].stacks.gravity = 0
				rime.echo(string.title(target).." lost all gravity stacks!", "pvp")
			end
		end,

		Impede = function(target)
			rime.pvp.add_aff("impede", target)
		end,

		Collapse = function(target)
			return
		end,

	},
    --Praenomen

    ["Mentis"] = {
    	Lifevision = function()
    		return
    	end,

    	Whisper = function(target)
    		if target == "you" then 
	    		if rime.has_aff("blood_curse") then
	    			rime.hidden_aff("blood_curse")
	    			rime.hidden_aff("blood_curse")
	    			rime.check_hidden()
	    		end
    		end
    		rime.pvp.whisper_affs(target)
    	end,

    	Deathsight = function()
    		return
    	end,

    	Psycombat = function()
    		return
    	end,

    	Assess = function()
    		return
    	end,

    	Disrupt = function(target)
    		rime.pvp.add_aff("disrupted", target)
    	end,

    	Siphon = function(target)
    		return
    	end,

    	Mesmerize = function(target, blind)
    		if not blind then
    			rime.pvp.add_aff("no_blind", target)
    			rime.pvp.add_aff("writhe_transfix", target)
    		else
    			rime.pvp.add_aff("no_blind", target)
    		end
    	end,

    	ForkedTongue = function()
    		return
    	end,

    	Telesense = function()
    		return
    	end,

    	Panic = function(target)
    		return
    	end,

    	Contemplation = function(target)
    		return
    	end,

    	Trill = function()
    		return
    	end,

    	Lure = function(target)
    		return
    	end,

    	Annihilate = function(target)
    		return
    	end,

    	Confusion = function(target)
    		rime.pvp.add_aff("confusion", target)
    	end,

    	Fear = function(target)
    		return
    	end,

    	Impatience = function(target)
    		rime.pvp.add_aff("impatience", target)
    	end,

    	Paranoia = function(target)
    		rime.pvp.add_aff("paranoia", target)
    	end,

    	Stupidity = function(target)
    		rime.pvp.add_aff("stupidity", target)
    	end,

		Agoraphobia = function(target)
		    rime.pvp.add_aff("agoraphobia", target)
		end,

		Masochism = function(target)
		    rime.pvp.add_aff("masochism", target)
		end,

		Loneliness = function(target)
		    rime.pvp.add_aff("loneliness", target)
		end,

		Seduction = function(target)
		    rime.pvp.add_aff("seduction", target)
		end,

		Epilepsy = function(target)
		    rime.pvp.add_aff("epilepsy", target)
		end,

		Anorexia = function(target)
		    rime.pvp.add_aff("anorexia", target)
		end,

		Amnesia = function(target)
		    return
		end,

		Peace = function(target)
		    rime.pvp.add_aff("peace", target)
		end,

		Dementia = function(target)
		    rime.pvp.add_aff("dementia", target)
		end,

		Berserking = function(target)
		    rime.pvp.add_aff("berserking", target)
		end,

		Indifference = function(target)
		    rime.pvp.add_aff("indifference", target)
		end,

		Vertigo = function(target)
		    rime.pvp.add_aff("vertigo", target)
		end,

		Temptation = function(target)
		    rime.pvp.add_aff("temptation", target)
		end,

		Recklessness = function(target)
		    rime.pvp.add_aff("recklessness", target)
		end,
    },
    ["Sanguis"] = {
    	Sanguine = function()
    		return
    	end,

    	Pervade = function()
    		return
    	end,

    	Raise = function()
    		return
    	end,

    	Wisp = function()
    		return
    	end,

    	Track = function()
    		return
    	end,

    	Command = function()
    		return
    	end,

    	Thirst = function()
    		return
    	end,

    	Regurgitate = function(target)
    		return
    	end,

    	Haze = function()
    		return
    	end,

    	Level = function(target)
    		return
    	end,

    	Effusion = function(target)
    		rime.pvp.add_aff("effused_blood", target)
    	end,

    	Gift = function()
    		return
    	end,

    	Mask = function()
    		return
    	end,

    	Mutation = function()
    		return
    	end,

    	Pulse = function(target)
    		return
    	end,

    	Blur = function()
    		return
    	end,

    	Trepidation = function()
    		return
    	end,

    	Concentration = function()
    		return
    	end,

    	Bind = function()
    		return
    	end,

    	Shadow = function()
    		return
    	end,

    	Path = function()
    		return
    	end,

    	Affinity = function(target)
    		return
    	end,

    	Deluge = function()
    		return
    	end,

    	Sire = function()
    		return
    	end,

    	Glance = function()
    		return
    	end,

    	Vision = function()
    		return
    	end,

    	Beckon = function()
    		return
    	end,

    	Will = function()
    		return
    	end,

    	Tune = function()
    		return
    	end,

    	Monitor = function()
    		return
    	end,

    	Invigorate = function()
    		return
    	end,

    	Aegis = function()
    		return
    	end,

    	Rile = function()
    		return
    	end,

    	Embrace = function()
    		return
    	end,

    	Poison = function(target)
    		rime.pvp.add_aff("blood_poison", target)
    	end,

    	Curse = function(target)
    		rime.pvp.add_aff("blood_curse", target)
    	end,

    	Spew = function(target)
    		rime.pvp.add_aff("no_blind", target)
    		rime.pvp.add_aff("no_deaf", target)
    	end,

    	Rune = function(target)
    		rime.pvp.add_aff("blood_rune", target)
    	end,

    	Enrage = function()
    		return
    	end,

    	Strengthen = function()
    		return
    	end,

    	Feast = function(target)
    		rime.pvp.add_aff("feast", target)
    	end,

    	Seize = function(target)
    		return
    	end,

    	Pillar = function()
    		return
    	end,
    },
    ["Corpus"] = {

    	Mend = function(target)
    		return
    	end,

    	Feed = function(target)
    		return
    	end,

    	Earthmeld = function()
    		return
    	end,

    	Frenzy = function(target, sunder)
    		rime.pvp.aggro(target)
    		if not sunder then return else rime.pvp.noDef("shielded", target) end
    	end,

    	Chill = function(target)
    		rime.pvp.add_aff("caloric", target)
    	end,

    	Nightsight = function()
    		return
    	end,

    	Elusion = function()
    		return
    	end,

    	Lifescent = function()
    		return
    	end,

    	Hide = function()
    		return
    	end,

    	Masquerade = function()
    		return
    	end,

    	WolfForm = function()
    		return
    	end,

    	Stalking = function()
    		return
    	end,

    	Deadbreath = function(target)
    		rime.pvp.add_aff("slickness", target)
    		rime.pvp.noDef("fangbarrier", target)
    	end,

    	Clotting = function()
    		return
    	end,

    	Catching = function()
    		return
    	end,

    	Clawing = function(target)
    		rime.pvp.add_aff("rend", target)
    	end,

    	Fortify = function()
    		return
    	end,

    	BatForm = function()
    		return
    	end,

    	Celerity = function()
    		return
    	end,

    	Blocking = function(direction)
    		rime.echo(string.upper(direction).." HAS BEEN BLOCKED")
    	end,

    	Sunder = function(target)
    		rime.pvp.noDef("shielded", target)
    	end,

    	MistForm = function()
    		return
    	end,

    	Mending = function()
    		return
    	end,

    	Lifesecent = function()
    		return
    	end,

    	Warding = function()
    		return
    	end,

    	Veil = function()
    		return
    	end,

    	Gash = function(target)
    		rime.last_hit = target
    		rime.pvp.web_venoms()
    	end,

    	Fling = function(target)
    		return
    	end,

    	Entomb = function()
    		return
    	end,

    	Deathlink = function()
    		return
    	end,

    	Potence = function()
    		return
    	end,

    	Fade = function()
    		return
    	end,

    	Reconstruct = function()
    		-- ???????????????
    		return
    	end,

    	Purify = function()
    		return
    	end,
    },

    --Indorani
    ["Tarot"] = {
		Charging = function(target)
		    return
		end,

		Inscribing = function(target)
		    return
		end,

		Cardpacks = function(target)
		    return
		end,

		Emperor = function(target)
		    return
		end,

		Magician = function(target)
		    return
		end,

		Priestess = function(target)
		    return
		end,

		Fool = function(target)
			rime.pvp.aggro_count_down()
		    return
		end,

		Chariot = function(target)
		    return
		end,

		Hermit = function(target)
		    return
		end,

		Empress = function(target)
		    if target == rime.target and indo.need_empress then
                indo.need_empress = false
                if rime.pvp.ai then
                    rime.pvp.offense()
                end
        	end
		end,

		Sun = function(target)
			if rime.attacks.personal then
				indo.eclipse = indo.eclipse+1
			end
	    	if rime.pvp.web_sun then
				rime.pvp.add_aff(rime.pvp.web_sun, target)
			end
		end,

		Lovers = function(target)
		    rime.pvp.add_aff("lovers_effect", target)
		end,

		Hierophant = function(target)
		    return
		end,

		Sandman = function(target)
		    rime.pvp.add_aff("sleep", target)
		end,

        Hangedman = function(target, arg)
            if arg == "prone" then
                rime.pvp.add_aff("prone", target)
            elseif arg == "entangle" then
                rime.pvp.add_aff("writhe_ropes", target)
            end
        end,

		Warrior = function(target, limb)
			rime.pvp.add_limb(limb, target, 1250)
		end,

		Tower = function(target)
		    rime.echo("Exits have been <red>rubbled", "pvp")
		end,

		Wheel = function(target)
		    indo.can_wheel = false
		end,

		Creator = function(target, type)
		    if rime.attacks.personal then
                indo.can_creator = false
                if rime.pvp.ai then
                   rime.pvp.offense()
                end
                rime.echo("LOSER")
            end
            if type == "demonscape" then
                rime.echo(class_color().."fking yikes dawg")
            end
		end,

		Adder = function(target)
			if target == "you" then
				rime.curing.adder = true
				return
			end
			indo.add_ready = false
		    rime.pvp.add_aff("adder", target)
		    rime.pvp.add_aff("haemophilia", target)
		end,

		Justice = function(target)
		    rime.pvp.add_aff("justice", target)
		end,

		Star = function(target)
		    return
		end,

		Aeon = function(target, speedcheck)
			if not speedcheck then
		  	  rime.pvp.add_aff("aeon", target)
		  	end
		end,

		Eclipse = function(target)
		    return
		end,

		Lust = function(target)
		    return
		end,

		Universe = function(target)
		    rime.echo("Hey, that's a <purple>UNIVERSE Tarot!")
		end,

		Despair = function(target)
		    return
		end,

		Devil = function(target)
		    return
		end,

		Moon = function(target)
			if rime.pvp.web_moon then
		  	  rime.pvp.add_aff(rime.pvp.web_moon, target)
		  	end
		end,

		Death = function(target)
		    rime.echo(target.." was just rubed with <red>DEATH! <white>SPOOKY!", "pvp")
		end,

		Imprint = function(target)
		    return
		end,
    },
    ["Domination"] = {
    	Dervish = {
    		Act = function()
		    	for k,v in pairs(rime.targets) do
		    		rime.targets[k].defences.flight = false
		    	end
		    end,
		},

		Sycophant = function(target)
		    return
		end,

		Gremlin = function(target)
		    return
		end,

		Transcendence = function(target)
		    return
		end,

		ChaosOrb = function(target)
		    return
		end,

		Bloodleech = function(target)
		    return
		end,

		Firelord = function(target)
		    return
		end,

		Minion = function(target)
		    return
		end,

		Worm = function(target)
		    return
		end,

		Mask = function(target)
		    return
		end,

		Slime = {
		    Envelop = function()
		    	return
		    end
		},

		Pathfinder = function(target)
		    return
		end,

		Soulmaster = function(target)
		    return
		end,

		Humbug = function(target)
		    return
		end,

		Chimera = {
			Roar = function(target)
				if rime.attacks.personal then
					indo.can_chimera = false
				end
		    	rime.pvp.noDef("deaf", target)
		    	rime.pvp.add_aff("no_deaf", target)
			end,
			Headbutt = function(target)
		    	return
			end,
			Gas = function(target)
		    	rime.pvp.noDef("insomnia", target)
		    	return
			end,
		},

		Bubonis = function(target)
		    return
		end,

		Doppleganger = function(target)
		    return
		end,

		Storm = function(target)
		    return
		end,

		Gatekeeper = function(target)
		    return
		end,

		Hound = function(target)
		    return
		end,

		Link = function(target)
		    return
		end,

		Crone = function(target)
		    return
		end,

		Pit = function(target)
			rime.targets[target].aggro = rime.targets[target].aggro+100
		    return
		end,
    },
    ["Necromancy"] = {
		Deathsight = function(target)
		    return
		end,

		Essence = function(target)
		    return
		end,

		Decay = function(target)
		    return
		end,

		Dissect = function(target)
		    return
		end,

		Chill = function(target)
			return
		end,

		Nightsight = function(target)
		    return
		end,

		Sense = function(target)
		    return
		end,

		Night = function(target)
		    return
		end,

		Shroud = function(target)
		    return
		end,

		Screech = function(target)
		    for _,v in ipairs(gmcp.Room.Players) do
    			rime.pvp.add_aff("no_deaf", v.name)
  			end
		end,

		Belch = function(target)
		    return
		end,

		Taint = function(target)
		    return
		end,

		Leech = function(target)
		    rime.pvp.add_aff("leeched_aura", target)
		end,

		Bonedagger = function(target)
    		rime.last_hit = target
    		rime.pvp.ignore_rebounding = true
    		rime.pvp.web_venoms_noreb()
		end,

		Lifevision = function(target)
		    return
		end,

		Shrivel = function(target, limb)
		    --rime.pvp.add_aff(limb.."_broken", target)
		    rime.pvp.aggro(target)
		end,

		Soulmask = function(target)
		    return
		end,

		Cannibalism = function(target)
		    return
		end,

		Ectoplasm = function(target)
		    return
		end,

		Morisensus = function(target)
		    return
		end,

		Putrefaction = function(target)
		    return
		end,

		Drain = function(target)
		    return
		end,

		Deathaura = function(target)
		    return
		end,

		Bonehelm = function(target)
		    return
		end,

		Deform = function(target)
			rime.pvp.add_aff("deform", target)
		end,

		Gravehands = function(target)
		    return
		end,

		Gravechill = function(target)
		    return
		end,

		Rot = function(target)
		    return
		end,

		Desecration = function(target)
		    return
		end,

		Vengeance = function(target)
		    return
		end,

		Regeneration = function(target)
		    return
		end,

		Blackwind = function(target)
		    return
		end,

		Vivisect = function(target)
		    return
		end,

		Soulcage = function(target)
		    return
		end,
    },

        --Teradrim
	["Terramancy"] = {

		Inscribe = function()
			return
		end,

		Formation = function()
			return
		end,

		Batter = function(target)
			rime.last_hit = target
		end,

		Absorb = function()
			return
		end,

		Stonebind = function()
			return
		end,

		Surefooted = function()
			return
		end,

		Entwine = function()
			return
		end,

		Slam = function(target, limb)
			rime.last_hit = target
			if target == "you" then return end
			limb = limb:gsub(" ", "_")
			rime.pvp.add_limb(limb, target, 1000, "slam")
			if not rime.pvp.has_def("rebounding", target) then
				if rime.pvp.has_aff(limb .. "_bruised", target) and not rime.pvp.has_aff(limb .. "_bruised_moderate", target) then
					rime.pvp.add_aff(limb .. "_bruised_moderate", target)
				elseif rime.pvp.has_aff(limb .. "_bruised_moderate", target) then
					rime.pvp.add_aff(limb .. "_bruised_critical", target)
				else
					rime.pvp.add_aff(limb .. "_bruised", target)
				end
			end
		end,

		Stoneblast = function(target)
			if rime.pvp.has_def("rebounding", target) then
			end
		end,

		Resonance = function()
			return
		end,

		Facesmash = function(target)
			rime.last_hit = target
		end,

		Stonefury = function()
			return
		end,

		Grasp = function(target)
			rime.last_hit = target
		end,

		Rockshower = function()
			return
		end,

		Gutsmash = function(target)
			rime.last_hit = target
		end,

		Quake = function()
			return
		end,

		Erosion = function()
			return
		end,

		Runemark = function()
			return
		end,

		Earthenpass = function(target)
			return
		end,

		Chasm = function(target)
			return
		end,

		Fracture = function(target)
			rime.last_hit = target
		end,

		Impale = function(target)
			rime.pvp.add_aff("writhe_impaled", target)
			rime.pvp.add_limb("torso", target, 1250)
			if target == rime.target then rime.pvp.target_tumbling = false end
		end,

		Steady = function()
			return
		end,

		Ricochet = function()
			return
		end,

		Stonevice = function(target)
			rime.pvp.remove_aff("writhe_impaled", target)
			rime.pvp.add_aff("lightwound", target)
			rime.pvp.add_aff("deepwound", target)
		end,

		Furor = function(target)
			rime.last_hit = target
		end,

		Overhand = function(target)
			rime.last_hit = target
		end,

		Momentum = function()
			return
		end,

		Pulp = function(target)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.last_hit = target
			rime.pvp.add_aff("collapsed_lung", target)
		end,

		Earthenwill = function()
			return
		end,

		Barrage = function(target)
			rime.last_hit = target
		end,

        Skullbash = function(target)
            if target == "you" then return end
            rime.last_hit = target
            rime.pvp.add_limb("head", target, 1600)
            if rime.pvp.has_aff("head_bruised", target) then rime.pvp.add_aff("whiplash", target) end
            if rime.pvp.has_aff("head_bruised_moderate", target) then rime.pvp.add_aff("indifference", target) end
            if rime.pvp.has_aff("head_bruised_critical", target) then rime.pvp.add_aff("smashed_throat", target) end
        end,

		Shockwave = function(target)
			rime.last_hit = target
		end,

		Hammer = function(target)
			rime.last_hit = target
		end,

		Earthenform = function()
			return
		end,
	},

	["Desiccation"] = {
		Scour = function()
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
		end,

		Flood = function()
			return
		end,

		Sandwalk = function()
			return
		end,

		Surge = function()
			return
		end,

		Trap = function(target)
			rime.last_hit = target
		end,

		Presences = function()
			return
		end,

		Regeneration = function()
			return
		end,

		Ruminate = function()
			return
		end,

		Sandstorm = function()
			return
		end,

		Concealment = function()
			return
		end,

		Desiccate = function()
			return
		end,

		Shift = function(target)
			rime.last_hit = target
		end,

		Disturbances = function()
			return
		end,

		Blast = function()
			return
		end,

		Simoon = function(target)
			rime.last_hit = target
		end,

		Distort = function()
			return
		end,

		Shield = function(target)
			if target == "you" then return end
			rime.pvp.addDef("shielded", target)
		end,

		Swelter = function()
			return
		end,

		Confound = function()
			return
		end,

		Projection = function()
			return
		end,

		Wave = function(target)
			rime.last_hit = target
		end,

		Instability = function()
			return
		end,

		Spikes = function()
			return
		end,

		Harshen = function()
			return
		end,

		Desert = function()
			return
		end,

		Whirl = function()
			return
		end,

		Meld = function()
			return
		end,

		Pillar = function()
			return
		end,

		Whip = function(target)
			rime.last_hit = target
		end,

		Scourge = function(target)
			rime.last_hit = target
		end,

		Slice = function(target)
			rime.last_hit = target
		end,

		Shred = function(target)
			rime.last_hit = target
		end,

		Curse = function(target)
			rime.pvp.add_aff("sandrot", target)
			limitStart(target.."_sandrot", 10)
		end,

		Quicksand = function(target)
			rime.last_hit = target
		end,
    },

    ["Animation"] = {
		Animate = function()
			return
		end,

		Instruct = function()
			return
		end,

		Imprinting = function()
			return
		end,

		Erasure = function()
			return
		end,

		Movement = function()
			return
		end,

		Earthpaint = function()
			return
		end,

		Listening = function()
			return
		end,

		Escape = function()
			return
		end,

		Glance = function()
			return
		end,

		Priority = function()
			return
		end,

		Recover = function()
			return
		end,

		Bodylink = function()
			return
		end,

		Memory = function()
			return
		end,

		Servant = function()
			return
		end,

		Twinsoul = function()
			return
		end,

		Intertwine = function()
			return
		end,

		Vigilance = function()
			return
		end,

		Strike = function()
			return
		end,

		Barrel = function(target)
			return
		end,

		Heartpunch = function(target)
			return
		end,

		Rip = function(target)
			return
		end,

		Wrack = function(target)
			return
		end,

		Shout = function(target)
			return
		end,

		Grapple = function(target)
			return
		end,

		Shatter = function(target)
			rime.pvp.noDef("shielded", target)
		end,

		Pummel = function(target)
			return
		end,

		Choke = function(target)
			return
		end,

		Wrench = function(target)
			return
		end,

		Knockdown = function(target)
			return
		end,

		Corner = function()
			return
		end,

		Fend = function()
			return
		end,

		Airguard = function()
			return
		end,

		Rattle = function(target)
			return
		end,

		Prop = function()
			return
		end,

		Cycling = function()
			return
		end,

		Shake = function(target)
			return
		end,

		Kneeshatter = function(target)
			return
		end,

		Steadfast = function()
			return
		end,
    },

    	--Archivist
    ["Numerology"] = {
    	Forget = function(target)
		    return
		end,

		Primality = function(target)
		    return
		end,

		Duality = function(target)
		    return
		end,

		Triunity = function(target)
		    return
		end,

		Spheres = function(target)
		    return
		end,

		Empower = function(target)
		    return
		end,

		Fix = function(target)
		    return
		end,

		Settle = function(target)
		    return
		end,

		Position = function(target)
		    return
		end,

		Collapse = function(target)
		    return
		end,

		Oneness = function(target)
		    return
		end,

		Retrieve = function(target)
		    return
		end,

		Glimpse = function(target)
		    return
		end,

		Absorb = function(target)
		    return
		end,

		Ascent = function(target)
		    return
		end,

		Veil = function(target)
		    return
		end,

		Changeheart = function(target)
			if target == "you" then
				rime.hidden_aff("changeheart")
				rime.check_hidden()
				return
			end
			rime.last_hit = target
		    rime.pvp.web_venoms_noreb()
		end,

		Bloodwork = function(target)
		    return
		end,

		Sublimation = function(target)
		    return
		end,

		Weakness = function(target)
		    return
		end,

		Formation = function(target)
		    return
		end,

		Stream = function(target)
		    return
		end,

		Affliction = function(target)
		    return
		end,

		Dilation = function(target)
		    return
		end,

		Symphony = function(target)
		    return
		end,

		Syncopate = function(target)
		    return
		end,

		Link = function(target)
		    return
		end,

		Return = function(target)
		    return
		end,

		Madness = function(target)
		    rime.pvp.add_aff("dementia", target)
			rime.pvp.add_aff("hallucinations", target)
			rime.pvp.add_aff("paranoia", target)
		end,

		Unravel = function(target)
		    return
		end,

		Recollection = function(target)
		    return
		end,
    },

    ["Geometrics"] = {
    	Codex = function(target)
		    return
		end,

		Incite = function(target)
		    return
		end,

		Shape = function(target, hidden)
			if not hidden then return end
			if target == "you" then
				rime.hidden_aff("shapes")
				rime.check_hidden()
			end
		end,

		Token = function(target)
		    return
		end,

		Impress = function(target)
		    return
		end,

		Afterimage = function(target)
		    return
		end,

		Invert = function(target)
		    return
		end,

		Trace = function(target)
		    return
		end,

		Conjoin = function(target)
		    return
		end,

		Pattern = function(target)
		    rime.pvp.add_aff("patterns", target)
		end,

		Sealing = function(target)
		    return
		end,

		Matrix = function(target)
		    return
		end,

		Crux = function(target)
		    return
		end,

		Fork = function(target)
		    rime.pvp.noDef("shielded", target)
		end,

		Triangle = function(target)
		    rime.pvp.add_aff("Triangle", target)
		end,

		Square = function(target)
		    rime.pvp.add_aff("Square", target)
		end,

		Circle = function(target)
		    rime.pvp.add_aff("Circle", target)
		end,

		Swirl = function(target)
		    return
		end,

		Arrow = function(target)
		    return
		end,

		Lens = function(target)
		    return
		end,

		Wave = function(target)
		    return
		end,

		Bloom = function(target)
		    return
		end,

		Rod = function(target)
		    return
		end,

		Crescent = function(target)
		    return
		end,

		Hex = function(target)
		    return
		end,

		Star = function(target)
		    return
		end,

		Lemniscate = function(target)
		    return
		end,
    },

    ["Bioessence"] = {
		Energy = function(target)
		    return
		end,

		Jolt = function(target)
		    return
		end,

		Diagnose = function(target)
		    return
		end,

		Infection = function(target)
		    return
		end,

		Preservation = function(target)
		    return
		end,

		Tension = function(target)
		    return
		end,

		Knitting = function(target)
		    return
		end,

		Flare = function(target)
		    return
		end,

		Steroid = function(target)
		    return
		end,

		Probe = function(target)
		    return
		end,

		Adaptation = function(target)
		    return
		end,

		Osmosis = function(target)
		    return
		end,

		Stimulant = function(target)
		    return
		end,

		Ethereal = function(target)
		    return
		end,

		Catabolism = function(target)
		    return
		end,

		Ameliorate = function(target)
		    return
		end,

		Growth = function(target)
		    return
		end,

		Autonomy = function(target)
		    return
		end,

		Nexus = function(target)
		    return
		end,

		Mutagen = function(target)
		    return
		end,

		Depressant = function(target)
		    return
		end,

		Acute = function(target)
		    return
		end,

		Somnolent = function(target)
		    return
		end,

		Psychoactive = function(target)
		    return
		end,

		Virulent = function(target)
		    return
		end,

		Reactive = function(target)
		    return
		end,

		Narcotic = function(target)
		    return
		end,

		Chronic = function(target)
		    return
		end,

		Degenerative = function(target)
		    return
		end,

		Malignant = function(target)
		    return
		end,

		Sporatic = function(target)
		    return
		end,

		Atrophic = function(target)
		    return
		end,

		Morphic = function(target)
		    return
		end,
    },
    --#Ascendril
    ["Thaumaturgy"] = {

    	Shift = function(target)
    		if rime.target == target then
    			act("wt TARGET HAS SHIFTED PICK A NEW TARGET PLEASE")
    		end
    	end,

    	Flare = function(target)
    		return
    	end,

    	Stall = function(target)
    		return
    	end,
    },

    ["Elemancy"] = {

    	Fireball = function(target)
    		return
    	end,

    	Prism = function(target)
    		return
    	end,

    	Thunder = function(target)
    		rime.pvp.add_aff("stupidity", target)
    		rime.pvp.add_aff("dizziness", target)
    	end,

    	Coldsnap = function(target, element)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("stupidity", target)
    		if element == "Fire" then
    			rime.pvp.add_aff("recklessness", target)
    		elseif element == "Air" then 
    			rime.pvp.add_aff("masochism", target)
    		end
    	end,

    },

    ["Arcanism"] = {

    	Prism = function(caster)
    		return 
    	end,

    	Transfix = function(target)
    		rime.pvp.add_aff("writhe_transfix", target)
    		rime.pvp.add_aff("no_blind", target)
    	end,
    },

    --#Shaman

    ["Shamanism"] = {

    	Attunement = function(target)
    		return
    	end,

    	Premonition = function(target)
    		if target == "you" then return end
    		rime.pvp.add_aff("premonition", target)
    		rime.pvp.aggro(target)
    	end,
    },

    ["Naturalism"] = {

    	Thorncoat = function(target)
    		return
    	end,

    	Barrier = function(target)
    		rime.pvp.addDef("shielded", target)
    	end,

    },

    ["Primality"] = {

    	Vinelash = function(target)
    		if target == "you" then
    			rime.vitals.damage_expected = true
    		else
    			rime.pvp.aggro(target)
    		end
    	end,

    	Naturaltide = function()
    		return 
    	end,

    	Spines = function(target)
    		if target == "you" then return end
    		rime.pvp.add_aff("blighted", target)
    		rime.pvp.aggro(target)
    	end,

    	Strangle = function(target)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("writhe_web", target)
    	end,

    	Staticburst = function(target)
    		if target == "you" then
    			rime.vitals.damage_expected = true
    		else
    			rime.pvp.aggro(target)
    		end
    	end,

    	Chainlightning = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Lightning = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Sporulation = function(target)
    		if target == "you" then
    			rime.add_possible_aff("hallucinations")
    		else
    			rime.pvp.add_aff("confusion", target)
    			rime.pvp.add_aff("impatience", target)
    			rime.pvp.aggro(target)
    		end
    	end,

    	Overload = function(target)
    		if target == "you" then
    			return
    		else
    			rime.pvp.add_aff("paresis", target)
    			rime.pvp.add_aff("stupidity", target)
    			rime.pvp.aggro(target)
    		end
    	end,

    	Infest = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Leafstorm = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Reclamation = function(target, state)
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    		rime.echo(target.." RUN BITCH "..state, "pvp")
    	end,

    	Boosted = {
    		Overload = function(target)
    			if target == "you" then
	    			rime.curing.shamans_are_bullshit = true
    			else
	    			rime.pvp.add_aff("paresis", target)
	    			rime.pvp.add_aff("stupidity", target)
	    			rime.pvp.add_aff("blackout", target)
	    			rime.pvp.aggro(target)
	    		end
	    	end,

	    	Equivalence = function(target)
	    		if target == "you" then
	    			rime.add_aff("justice")
	    		else
	    			rime.pvp.add_aff("justice", target)
	    			rime.pvp.aggro(target)
	    		end
	    	end,

	    	Vinelash = function(target)
	    		if target == "you" then
	    			rime.curing.vinethorns = rime.curing.vinethorns+1
	    		else
	    			rime.pvp.aggro(target)
	    		end
	    	end,

	    	Leafstorm = function(target)
	    		rime.pvp.aggro(target)
	    		return
	    	end,

	    	Staticburst = function(target)
	    		if target == "you" then
	    			rime.hidden_aff("staticburst")
					rime.check_hidden()
	    		else
	    			rime.pvp.aggro(target)
	    		end
	    	end,

	    	Chainlightning = function(target)
	    		rime.pvp.aggro(target)
	    		return
	    	end,

	    	Lightning = function(target)
	    		rime.pvp.aggro(target)
	    		return
	    	end,

	    	Infest = function(target)
	    		rime.pvp.aggro(target)
	    		return
	    	end,

	    	Effusion = function(target)
	    		rime.pvp.add_aff("sensitivity", target)
	    		rime.pvp.aggro(target)
	    	end,


    	},

    },

    --#Shifter

    ["Shapeshifting"] = {

    	Scent = function(target)
    		return
    	end,

    	Bodyheat = function(target)
    		return
    	end,

    	Thickhide = function(target)
    		return
    	end,

    	Endurance = function(target)
    		return
    	end,

    	Pounce = function(target)
    		rime.pvp.noDef(target, "shielded")
    		rime.pvp.aggro(target)
    	end,


    },

    ["Ferality"] = {

    	Slash = function(target)
    		rime.pvp.aggro(target)
    	end,

    	Gut = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("torso_mangled", target)
    	end,

    	Mangle = function(target, limb)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff(limb.."_broken", target)
    		rime.pvp.add_aff(limb.."_damaged", target)
    	end,

    	Destroy = function(target, limb)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff(limb.."_broken", target)
    		rime.pvp.add_aff(limb.."_damaged", target)
    		rime.pvp.add_aff(limb.."_mangled", target)
    	end,

    	Thighlock = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("writhe_thighlock", target)
    		rime.pvp.add_aff("prone", target)
    	end,

    	Necklock = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("writhe_necklock", target)
    		rime.pvp.add_aff("prone", target)
    	end,

    	Skullcrush = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("prone", target)
    	end,

    	Quarter = function(target)
    		rime.pvp.remove_aff("writhe_thighlock", target)
    	end,

    	Groinrip = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.remove_aff("writhe_thighlock", target)
    		rime.pvp.add_aff("ripped_groin", target)
    	end,

    	Skullwhack = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_limb("head", target, 750)
    	end,

    	Faceslash = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_limb("head", target, 750)
    		rime.pvp.add_aff("blurry_vision", target)
    	end,

    	Jugular = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_limb("head", target, 750)
    	end,

    	Bite = function(target, limb)
    		rime.pvp.aggro(target)
    		if limb then
    			rime.pvp.add_limb(limb, target, 899)
    		end
    	end,

    	Throatslice = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_limb("head", target, 750)
    		rime.pvp.add_aff("crippled_throat", target)
    	end,

    	Hamstring = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Rend = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Bodypunch = function(target)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_limb("torso", target, 700)
    	end,

    	Spinalcrack = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("paresis", target)
    	end,
    },

    ["Vocalizing"] = {

    	Boneshaking = function(target)
    		return
    	end,

    	Baying = function(target, aff)
    		rime.pvp.aggro(target)
    		local aff_conversion = {
    			["distasteful"] = "anorexia",
    		},
    		rime.pvp.add_aff(aff[aff_conversion], target)
    	end,
    	
    },

    --#Wayfarer

 ["Tenacity"] = {
	--Ranged Tenacity
    	Lob = function(target)
    		rime.pvp.aggro(target)
			rime.pvp.ignore_rebounding = true
    		rime.last_hit = target
    		rime.pvp.web_venoms_noreb()
    	end,
 
    	Cripple = function(target)
    		rime.pvp.aggro(target)
			rime.pvp.ignore_rebounding = true
    		rime.last_hit = target
    		rime.pvp.web_venoms_noreb()
    	end,

    	Obstruct = function(target)
    		return 
    	end,
 
    	Assault = function(target)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		--NOTE probably want to parry the limb that gets hit here? Maybe? Not sure :(
			rime.pvp.ignore_rebounding = true
			rime.last_hit = target
			rime.pvp.web_venoms()
    	end,
 
    	Slaughter = function(target) --double axe req prone+ broken leg = faster axe return
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.ignore_rebounding = true
			rime.last_hit = target
			rime.pvp.web_venoms()
    	end,

    	Carve = function(target)
    		rime.pvp.aggro(target)
    	--vomit and torso damage/ If vomit or damaged torso stun and fallen instead may need to adjust code
			if target == "you" then return end
			rime.pvp.ignore_rebounding = true
			rime.last_hit = target
			rime.pvp.web_venoms()
    	end,
 
    	Retrieve = function(target) --range line of sight pull
    		return
    	end,
 
    	Toss = function(target) --this needs work because it has a lot of options venoms + time delays
    		rime.pvp.aggro(target)
    		return
    	end,
 
 
    	Embed = function(target) --this needs work soon
    		rime.pvp.aggro(target)
    		return
    	end,
 
 
		-- Melee Tenacity
    	Devastate = function(target)
			rime.last_hit = target
			rime.pvp.aggro(target)
			local gotOne = false
			if rime.pvp.has_def("shielded", target) then
				rime.pvp.noDef("shielded", target)
				gotOne = true
			end
			if rime.pvp.has_def("rebounding", target) then
				rime.pvp.noDef("rebounding", target)
				if gotone then
					gotOne = false
				else
					gotOne = true
				end
			end
			if gotOne then
				rime.last_hit = target
			end
	    end,
 
		Chop = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Sweep = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Lacerate = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Bash = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Dropstrike = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Whirlwind = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Punish = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Ravage = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
		Ambush = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
 
		Execute = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,
 
    },

    ["Fury"] = {

    	Expunge = function(target, boosted)
			return
		end,

		Shake = function(target, boosted)
			if target == "you" then return end
			rime.pvp.aggro(target)
			rime.pvp.add_aff("weariness", target)
		end,

    	Threaten = function(target, boosted)
    		rime.pvp.add_aff("hatred", target)
    		rime.pvp.aggro(target)
    		if boosted then
    			rime.pvp.add_aff("masochism", target)
    			rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("shielded",  target)
				rime.pvp.noDef("prismatic", target)
			end
    	end,

    	Distract = function(target, boosted)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.targets[target].parry = "nothing"
    	end,

    	Enrage = function(target)
    		return
    	end,

    	Halt = function(target, boosted)
    		if target == "you" then return end
    		rime.pvp.add_aff("lethargy", target)
    		rime.pvp.aggro(target)
    	end,

    	Shatter = function(target, boosted)
    		if target == "you" then
    			rime.hidden_aff("shatter")
				rime.check_hidden()
			end
			rime.pvp.aggro(target)
		end,

		Warcry = function(target, boosted)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("no_deaf", target)
    		if boosted then
    			rime.pvp.add_aff("ringing_ears", target)
    		end
		end,

		Startle = function(target, boosted)
    		if target == "you" then
    			rime.pvp.aggro(target)
    			limitEnd("rebounding")
    			rime.silent_addAff("rebounding")
				remDef("rebounding")
    		end
    	end,

    	Exhaust = function(target)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("exhausted", target)
    	end,

    },

    ["Axe"] = {

    	Rampage = function(target)
    		return
    	end,
    },

    --#Templar

    ["Battlefury"] = {

    	Cleave = function(target, stage)
    		if target == "you" then
				if not stage then
					rime.echo("YOU'RE BEING CLEAVED BY "..matches[2]:upper())
				elseif stage == "mid" then
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING CLEAVED BY <red>"..matches[2]:upper().." <white>BITCH PAY ATTENTION", "pvp")
				else
					rime.echo("I can't believe you let them do this to you, smh", "pvp")
				end
			else
				if not stage then
					rime.echo("YOU'RE BEING CLEAVED BY "..matches[2]:upper())
					rime.echo("YOU'RE BEING CLEAVED BY "..matches[2]:upper())
					rime.echo("YOU'RE BEING CLEAVED BY "..matches[2]:upper())
					rime.echo("YOU'RE BEING CLEAVED BY "..matches[2]:upper())
				elseif stage == "mid" then
					rime.echo(target.." being cleaved by "..matches[2], "pvp")
				else
					if rime.attacks.personal then
						expandAlias("dab")
					else
						rime.echo(matches[2]:upper().." CLEAVED "..target:upper().." AND THEY NEED TO DIE NOW", "pvp")
					end
				end
			end
		end,

    	Impale = function(target)
    		rime.pvp.add_aff("writhe_impaled", target)
			rime.pvp.add_limb("torso", target, 1250)
			rime.pvp.aggro(target)
			if target == rime.target then rime.pvp.target_tumbling = false end
    	end,

    	Gripping = function(caster)
    		return 
    	end,

    	Lunge = function(target, effect)
    		if effect == "impale" then
    			rime.pvp.aggro(target)
    			rime.pvp.add_aff("writhe_impaled", target)
    			if target == rime.target then rime.pvp.target_tumbling = false end
    		end
    	end,

    	Doublestrike = function(target)
    		rime.pvp.aggro(target)
    		if target == "you" then return end
    		rime.last_hit = target
    		rime.pvp.web_venoms()
    	end,

    	Doubleswing = function(target)
    		rime.pvp.aggro(target)
    		rime.last_hit = target
    	end,

    	Zeal = function(target)
    		if target == "you" then return end
    		rime.targets[target].aggro = rime.targets[target].aggro+2
    		rime.pvp.aggro(target)
    		rime.last_hit = target
    	end,

    	Razestrike = function(target, what)
    		if target == "you" then return end
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "reflection" then
				return
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
			rime.pvp.aggro(target)
			rime.pvp.web_venoms()
    	end,

    	Raze = function(target, what)
    		if target == "you" then return end
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "reflection" then
				return
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
			rime.pvp.aggro(target)
    	end,

    	Defend = function(target)
    		if target == "you" then return end
    		if rime.attacks.personal then return end
    		act("wt "..target.." is being defended by "..string.upper(matches[2]).."!")
    	end,
    },

    ["Bladefire"] = {

    	Vorpal = function(target)
    		rime.last_hit = target
    		rime.pvp.aggro(target)
    		rime.pvp.web_venoms()
    	end,

    	Lightning = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Penance = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Crescent = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Conviction = function(target)
    		if target == "you" then return end
    		rime.pvp.add_aff("conviction", target)
    	end,
    },

    ["Righteousness"] = {

    	Withering = function(target)
    		if target == "you" then return end
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("withering", target)
    	end,

    },

    --#Monk

    ["Tekura"] = {

    	Kipup = function(caster, stance)
    		return 
    	end,

    	Stance = function(caster, stance)
    		return 
    	end,

    	Scythekick = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.noDef("shielded", target)
    	end,

    	Backbreaker = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Cometkick = function(target)
    		rime.pvp.aggro(target)
    		if rime.pvp.has_aff("right_arm_broken", target) and rime.pvp.has_aff("left_arm_broken", target) then
    			rime.pvp.add_aff("collapsed_lung", target)
    		end
    	end,

    	Whirlwind = function(target)
    		rime.pvp.aggro(target)
    		--headstuff
    		return
    	end,

    	Moonkick = function(target)
    		rime.pvp.aggro(target)
    		--blahblah
    		return
    	end,

    	Sweepkick = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("prone", target)
    	end,

    	Sidekick = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Hammerfist = function(target)
    		rime.pvp.aggro(target)
    		--add stuff for blank here. Legs
    		return
    	end,

    	Uppercut = function(target)
    		rime.pvp.aggro(target)
    		--add stuff for head damage here
    		return
    	end,

    	Palmstrike = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.add_aff("blurry_vision", target)
    	end,

    	Snapkick = function(target)
    		rime.pvp.aggro(target)
    		--add stuff for blank here. Legs
    		return
    	end,

    	Feint = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Bladehand = function(target)
    		return
    	end,

    	Wrench = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Spear = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Jab = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Slam = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Hook = function(target)
    		rime.pvp.aggro(target)
    		return
    	end,
    },

    ["Kaido"] = {

    	Banish = function(target)
    		rime.pvp.aggro(target, "reset")
    	end,

    	Resistance = function(target)
    		return 
    	end,

    	Numbness = function(target)
    		return
    	end,

    	Cripple = function(target)
    		rime.pvp.aggro(target)
    		rime.pvp.aggro(target)
    		return
    	end,

    	Enfeeble = function(target)
    		rime.pvp.aggro(target)
    		--add indorani support here
    	end,

    	Transmute = function(target)
    		--add check for contemplate/annihilate here
    	end,

    	Fitness = function(target)
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
    	end,

    	Deliverance = function(target, proc)
    		if proc == "proc" then
    			if target == "you" then
    				rime.echo("HAHAHAHAHAHAHAHA YOU FUCKING SUCK AHAHAHA OMG OMG OMG OMGO MGOMGOMGOMGOMOAIDFOAIDUF YOU SUCK")
    				swarm.removeTarget(target)
    				swarm.autoTargeting()
    			else
    				rime.echo("wt and another one bites the dust. And another one bites and another one bites and another one bites the dust.")
    				swarm.removeTarget(target)
    				swarm.autoTargeting()
    			end
    		else
    			swarm.removeTarget(target)
    			swarm.autoTargeting()
    		end
    	end,

    },

    ["Telepathy"] = {


    },

    --#Revenant

    ["Riving"] = {

		Gripping = function(target)
			return
		end,

		Clotting = function(target)
			return
		end,

		Envenom = function(target)
			return
		end,

		Fitness = function(target)
			if rime.attacks.personal then return end
			rime.time("lockbreaker", target)
		end,

		Sturdiness = function(target)
			return
		end,

		Juxtapose = function(target)
			rime.pvp.aggro(target, "reset")
			if target == "you" then return end
			rime.targets[matches[2]].aggro = rime.targets[matches[2]].aggro +15
			rime.targets[target].defences.defended = true
			if rime.attacks.personal then
				defending = target
				return
			end
			act("wt "..target.." is being defended by "..string.upper(matches[2]).."!")
    	end,

		Rage = function(target)
			for _,aff in ipairs(rime.curing.affsByCure.steroid) do
				if rime.pvp.has_aff(aff, target) then
					rime.pvp.remove_aff(aff, target)
					break
				end
			end
		end,

		MainGauche = function(target)
			return
		end,

		Separate = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Circle = function(target)
			rime.pvp.aggro(target)
			if rime.attacks.personal then rev.need_circle = false end
		end,

		Rive = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Raze = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or razed == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
		end,

		Fell = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Duplicity = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Umbrage = function(target, hit)
			if hit then
				rime.last_hit = target
				rime.pvp.ignore_rebounding = true
			end
		end,

		Initiate = function(target)
			rime.pvp.aggro(target)
			return
		end,

		Gouge = function(target)
			rime.pvp.aggro(target)
			rime.last_hit = target
		end,

		Deceive = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
			rime.pvp.web_venoms()
			rev.wilaveee = false
		end,

		Razestrike = function(target, what)
			rime.pvp.aggro(target)
			rime.last_hit = target
			if what == "shield" then
				rime.pvp.noDef("shielded", target)
			elseif what == "rebounding" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
			elseif what == "speed" or what == "failure" then
				rime.pvp.noDef("shielded", target)
				rime.pvp.noDef("rebounding", target)
				rime.pvp.noDef("speed", target)
			end
			rime.pvp.web_venoms()
			rev.wilaveee = false
		end,

		Eclipse = function(target, stage)
			if target == "you" then
				if stage == "start" then
					rime.echo(matches[2]:upper().." IS ECLIPSING THE ABSOLUTE MAD PERSON")
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					rime.echo("YOU'RE BEING ECLIPSED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING ECLIPSED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.echo("YOU'RE BEING ECLIPSED BY <red>"..matches[2]:upper().."<white>BITCH PAY ATTENTION", "pvp")
					rime.pvp.aggro(target)
				else
					rime.echo("I can't believe you let them do this to you, smh", "pvp")
				end
			else
				if stage == "start" then
					if target ~= "You" then
						rime.echo(target.." being eclipsed by "..matches[2], "pvp")
					end
					rime.pvp.aggro(target)
				elseif stage == "mid" then
					if target ~= "You" then
						rime.echo(target.." being eclipsed by "..matches[2], "pvp")
					end
					rime.pvp.aggro(target)
				else
					if rime.attacks.personal then
						expandAlias("dab")
						rime.paused = false
						rime.pvp.aggro(target, "reset")
					else
						rime.echo(matches[2]:upper().." ECLIPSED "..target:upper().." THE ABSOLUTE MAD PERSON", "pvp")
						rime.pvp.aggro(target, "reset")
					end
				end
			end
		end,

		Harrow = function(target)
			return
		end,

		Transpierce = function(target, fail_check)
			if not fail_check then
				rime.pvp.add_aff("writhe_impaled", target)
				rime.pvp.add_limb("torso", target, 1000)
				rime.pvp.aggro(target)
				if rime.attacks.personal then targetImpaled = true end
				if target == rime.target then rime.pvp.target_tumbling = false end
			else
				rime.pvp.remove_aff("prone", target)
			end
			rime.pvp.remove_aff("lurk", target)
		end,

		Hemoclysm = function(target, limb)
			--[[save this for logic later? limb = limb:gsub(" ", "_")]]
			rev.bongoBonanza = true
			rev.wilaveee = true
			rime.pvp.remove_aff("lurk", target)
		end,

		Calm = function()
			return
		end,

		Jumpcut = function(target, what)
			if what == "impale" then
				rime.pvp.add_aff("writhe_impaled", target)
				rime.pvp.add_aff("prone", target)
				rime.pvp.aggro(target)
				if rime.attacks.personal then targetImpaled = true end
				if target == rime.target then rime.pvp.target_tumbling = false end
			elseif what == "hack" then
				rime.pvp.add_aff("prone", target)
			else
				return
			end
		end,

		Harvest = function(target)
			return
		end,

		Extirpate = function(target)
			rime.targetImpaled = false
			rime.pvp.remove_aff("writhe_impaled", target)
			rime.pvp.remove_aff("lurk", target)
			rev.wilaveee = true
		end,
    },

    ["Manifestation"] = {

		Phantasm = function(target)
			--handled with a trigger
			return
		end,

		Engulf = function(target)
			return 
		end,

		Chimerization = function(target)
			--also handled with a separate trigger
			return
		end,

		Parasite = function(target)
			if target == "you" then return end
			rime.pvp.add_aff("withering", target)
		end,

		Serpent = function(target, state)
			return
		end,

    },

    ["Chirography"] = {

    	Lawid = function(target, type)
    		if target == "you" then return end
    		if type == "two-hand" then
    			rime.pvp.add_limb("torso", target, 900)
    		end
    	end,

    	Bimre = function(target)
    		if target == "you" then return end
    		if rime.attacks.personal then
    			rev.terror = true
    		end
    		rime.pvp.add_aff("mortalterror", target)
    		rime.last_hit = target
    	end,

    	Dirne = function(target)
    		if target == "you" then return end
    		rime.last_hit = target
    	end,

    	Telvi = function(target, hands)
    		if target == "you" then return end
    		if hands == "two-hand" then
    			rime.pvp.add_aff("caloric", target)
    			rime.pvp.add_aff("caloric", target)
    		else
    			rime.pvp.add_aff("caloric", target)
    		end
    	end,

    	Atdum = function(target)
    		if target == "you" then return end
    		rime.last_hit = target
    		rime.pvp.ignore_rebounding = true
    	end,

    	Aneda = function(target)
            if rime.attacks.personal then
                if not rev.aneda_left_scribed then
                    rev.aneda_left_scribed = true
                else
                    rev.aneda_right_scribed = true
                end
            end
        end,

        Lurk = function(target)
        	rime.pvp.add_aff("lurk", target)
        	if rime.attacks.personal then rev.canlurk = false end
        end,


    },

    --#Misc

    ["Avoidance"] = {

    	Nimbleness = function(target)
    		--add def
    		return
    	end,

    	Bolstering = function(target)
    		return
    	end,
    },

    ["Research"] = {

    	Disperse = function(target)
    		for k,v in ipairs(rime.curing.priority.default.writhe) do
				rime.pvp.remove_aff(v, target)
			end

			if target == rime.target and targetImpaled then
				targetImpaled = false
			end	
		end,

    },

    ["Enchantment"] = {

    	Eye = function(target)
    		rime.pvp.noDef("lightform", "All")
    		rime.pvp.noDef("blackwind", "All")
    	end,

    	Allsight = function(target)
    		--add def
    		return
    	end,

    	Waterwalking = function(target)
    		--add def
    		return
    	end,

    	Worrystone = function(caster)
    		return 
    	end,
    },

    ["Artifact"] = {

    	Locket = function(target)
    		return
    	end,

    	Light = function(target)
    		return 
    	end,

    	Darkness = function(target)
    		return
    	end,

    	Flood = function(target)
    		return
    	end,

		Stability = function(target)
			rime.pvp.addDef("density", target)
		end,

		Shroud = function(target)
			rime.pvp.addDef("shroud", target)
		end,
    },

    ["Antiquated"] = {

    	["Ring"] = {

    		Defend = function(target)
	    		rime.pvp.aggro(target, "reset")
				if target == "you" then return end
				rime.targets[matches[2]].aggro = rime.targets[matches[2]].aggro +15
				rime.targets[target].defences.defended = true
				if rime.attacks.personal then
					defending = target
					return
				end
				act("wt "..target.." is being defended by "..string.upper(matches[2]).."!")
			end,
    	},
    },

    --consistency!

    ["Obscuring"] = {

    	Cloak = function(target)
    		return
    	end,
    },

    ["Relic"] = {

    	Translocator = function(target)
    		return
    	end,

    	Webspray = function(target, dodged)
    		if not dodged then
    			rime.pvp.add_aff("writhe_web", target)
    		end
    	end,

    	Entangle = function(target)
    		rime.pvp.add_aff("writhe_web", target)
    	end,
    },

    ["Fishing"] = {

    	Cast = function(target)
    		return
    	end,

    	Catch = function(target)
    		return
    	end,

    	Reel = function(target)
    		return
    	end,

    	Cut = function(target)
    		return
    	end,

    	Discern = function(target)
    		return
    	end,

    	Disappointment = function(target)
    		return
    	end,
    },

    ["Racial"] = {

    	Shift = function(target)
    		return
    	end,

    	Scent = function(target)
    		return
    	end,

    	Gripping = function(target)
    		return
    	end,
    },

    ["Race"] = {

    	Icebreath = function(target)
    		rime.pvp.add_aff("caloric", target)
    	end,
    },

    ["Tattoos"] = {

    	Hammer = function(target)
            rime.pvp.noDef("shielded", target)
        end,

    	Crystal = function(target)
    		rev.wilaveee = false
    		return
    	end,

    	Starburst = function(target)
    		if rime.attacks.personal then
    			rime.reset()
			end
    		act("wt "..target.." starbursted!")
    	end,

    	Cloak = function(target)
    		rime.pvp.addDef("cloak", target)
    	end,

    	Shield = function(target)
    		rime.pvp.addDef("shielded", target)
    	end,

    	Mindseye = function(target)
    		return
    	end,

    	Flame = function(target)
    		return
    	end,

    	Web = function(target, dodged)
    		if not dodged then
    			rime.pvp.add_aff("writhe_web", target)
    		end
    	end,
    },

    ["Survival"] = {

        Restoration = function(target)
            if not rime.pvp.has_aff("left_arm_damaged", target) then rime.pvp.remove_aff("left_arm_broken", target) end
            if not rime.pvp.has_aff("right_arm_damaged", target) then rime.pvp.remove_aff("right_arm_broken", target) end
            if not rime.pvp.has_aff("left_leg_damaged", target) then rime.pvp.remove_aff("left_leg_broken", target) end
            if not rime.pvp.has_aff("right_leg_damaged", target) then rime.pvp.remove_aff("right_leg_broken", target) end
        end,

    },

    ["Manipulation"] = {

    	Returning = function(target)
    		return
    	end,

    	Combustion = function(target)
    		return
    	end,

    	Backlash = function(target, proc)
    		return
    	end,

    	Aegis = function(target)
    		if target == "you" then target = "me" end
    		act("wt Aegis up on "..target)
    	end,
    },

    ["Prize"] = {

    	Open = function(target)
    		rime.echo("wow neat")
    	end,
    },

    --special 200 snowflakes

    ["Chaos"] = {

    	Mend = function(target)
    		return
    	end,

    	Embrace = function(target)
    		return
    	end,

    },

    ["Nocturn"] = {

    	Shadow = function(target)
    		return
    	end,
    },

    ["Adherent"] = {

    	Barrier = function(target)
    		return
    	end,

    	Inferno = function(target)
    		rime.pvp.aggro(target)
    	end,

    	Blossom = function(target)
    		rime.pvp.aggro(target)
    	end,

    	Tentacle = function(target)
    		rime.pvp.aggro(target)
    	end,

    	Balefire = function(target)
    		rime.pvp.aggro(target)
    	end,

    	Purify = function(target)
    		return 
    	end,

    	Avatar = function(target)
    		rime.pvp.web_venoms()
    	end,


    }

}