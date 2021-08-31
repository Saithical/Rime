rime.curing.stormtouched_mode = false
rime.curing.bloodleech = false
rime.curing.adder = false
rime.curing.need_howl_check = false
rime.curing.howl_one = false
rime.curing.howl_two = false
rime.curing.howl_three = false
rime.curing.heel_rush = "none"
rime.curing.restoring_limb = "none"
rime.curing.pressed_for_gloom = false
rime.curing.embedIn = rime.curing.embedIn or "none"
rime.howls_set = false
rime.curing.needWounds = false
rime.curing.class = true
rime.curing.vinethorns = 0
rime.curing.needShift = false
rime.staticParry = "none"
rime.curing.last_cured = "nothing"


function doCureAction()

	local sep = rime.saved.separator

    if cureAction == "none" or cureAction == nil or cureAction == "nothing" then return end
	
	if string.find(cureAction, "eat") and not rime.limit.pill_queue then
	
			if nextPillAff() == "impatience" and nextFocusAff() ~= "nothing" and rime.next_cured("euphoriant") == "impatience" and rime.balances.focus then
			
				cureAction = cureAction .. sep .. "focus"

			elseif nextPillAff() == "asthma" and nextPipeAff() ~= "nothing" then

				cureAction = cureAction .. sep .. getCureAction(nextPipeAff())

			elseif (nextPillAff() == "paralysis" or nextPillAff() == "paresis") and (not rime.has_aff("left_arm_broken") and not rime.has_aff("right_arm_broken")) and rime.balances.tree then

				for k,v in pairs(rime.curing.affsByType.tree) do
					if rime.has_aff(v) and v ~= nextPillAff() then
						cureAction = cureAction .. sep .. "touch tree"
						break
					end
				end

			elseif nextPillAff() == "epilepsy" then

				cureAction = cureAction .. sep .. "dodge melee"

			end

			if rime.has_aff("stupidity") then
				cureAction = "queue pill touch flaws" .. sep .. cureAction .. sep .. cureAction
			else
				cureAction = "queue pill touch flaws" .. sep .. cureAction
			end

			if (rime.has_aff("anorexia") or rime.has_aff("destroyed_throat") or nextPillAff() == "nothing") and rime.curing.queue.pill ~= "nothing" and not rime.limit.pill_queue then
				act("queue pill")
				if rime.has_aff("aeon") then
					limitStart("pill_queue", 1)
				else
					limitStart("pill_queue", .1)
				end
			elseif not (rime.has_aff("anorexia") or rime.has_aff("destroyed_throat") or nextPillAff() == "nothing") and cureAction ~= "queue pill " .. rime.curing.queue.pill and not rime.limit.pill_queue then
		 		if rime.has_aff("aeon") then
		 			cureAction = cureAction:gsub("queue pill ", "")
		 			act(cureAction)
		 			limitStart("pill_queue", 1.5)
		 		else
		 			act(cureAction)
		 			limitStart("pill_queue", .1)
		 		end
			end
		 
	elseif string.find(cureAction, "press") and not rime.limit.poultice_queue then
	
		if (nextPoulticeAff() == "anorexia" or nextPoulticeAff() == "destroyed_throat") and nextPillAff() ~= "nothing" then
		
			local pill_cure = nextPillAff()
			cureAction = cureAction .. sep .. getCureAction(pill_cure)
			
		elseif (nextPoulticeAff() == "left_arm_broken" or nextPoulticeAff() == "right_arm_broken") and rime.balances.tree then

			for k,v in pairs(rime.curing.affsByType.tree) do
				if rime.has_aff(v) and v ~= nextPoulticeAff() then
					cureAction = cureAction .. sep .. "touch tree"
					break
				end
			end

		end

		if rime.has_aff("stupidity") then
			cureAction = "queue poultice touch flaws" .. sep .. cureAction .. sep .. cureAction
		else
			cureAction = "queue poultice touch flaws" .. sep .. cureAction
		end

		if (rime.has_aff("sandrot") or rime.has_aff("slickness") or nextPoulticeAff() == "nothing") and rime.curing.queue.poultice ~= "nothing" and not rime.limit.poultice_queue then
			act("queue poultice")
			if rime.has_aff("aeon") then
				limitStart("poultice_queue", 1)
			else
				limitStart("poultice_queue", .1)
			end
		elseif not (rime.has_aff("sandrot") or rime.has_aff("slickness") or nextPoulticeAff() == "nothing") and cureAction ~= "queue poultice " .. rime.curing.queue.poultice and not rime.limit.poultice_queue then
			if rime.has_aff("aeon") then
				cureAction = cureAction:gsub("queue poultice ", "")
				act(cureAction)
				limitStart("poultice_queue", 1)
			else
				act(cureAction)
				limitStart("poultice_queue", .1)
			end
		end
		
	elseif string.find(cureAction, "smoke") and not rime.limit.pipe_queue then

		if nextPipeAff() == "slickness" and nextPoulticeAff() ~= "nothing" then

			local poultice_cure = nextPoulticeAff()

			cureAction = cureAction .. sep .. getCureAction(poultice_cure)

		end

		if rime.has_aff("stupidity") then
			cureAction = "queue pipe touch flaws" .. sep .. cureAction .. sep .. cureAction
		else
			cureAction = "queue pipe touch flaws" .. sep .. cureAction
		end

		if (rime.has_aff("asthma") or rime.has_aff("troubled_breathing") or nextPipeAff() == "nothing") and rime.curing.queue.pipe ~= "nothing" and not rime.limit.pipe_queue then
			act("queue pipe")
			if rime.has_aff("aeon") then
				limitStart("pipe_queue", 1)
			else
				limitStart("pipe_queue", .1)
			end
		elseif not (rime.has_aff("asthma") or rime.has_aff("troubled_breathing") or nextPipeAff() == "nothing") and cureAction ~= "queue pipe " .. sep .. cureAction and not rime.limit.pipe_queue then
			if rime.has_aff("aeon") then
				cureAction = cureAction:gsub("queue pipe ", "")
				act(cureAction)
				limitStart("pipe_queue", 1)
			else
				act(cureAction)
				limitStart("pipe_queue", .1)
			end
		end


	elseif string.find(cureAction, "writhe") and not rime.limit.writhe_queue then

		act(cureAction)
		if rime.has_aff("aeon") then
			limitStart("writhe_queue", 1)
		else
			limitStart("writhe_queue", .1)
		end

	elseif string.find(cureAction, "sip") and not rime.limit.elixir_queue then
	
		if (rime.has_aff("anorexia") or rime.has_aff("destroyed_throat") or nextElixirAff() == "nothing") and rime.curing.queue.elixir ~= "nothing" and not rime.limit.elixir_queue then
			act("queue elixir")
			if rime.has_aff("aeon") then
				limitStart("elixir_queue", 1)
			else
				limitStart("elixir_queue", .1)
			end
		elseif not (rime.has_aff("anorexia") or rime.has_aff("destroyed_throat") or nextElixirAff() == "nothing") and cureAction ~= "queue elixir " .. sep .. cureAction and not rime.limit.elixir_queue then
			act("queue elixir "..cureAction)
			if rime.has_aff("aeon") then
				limitStart("elixir_queue", 1)
			else
				limitStart("elixir_queue", .1)
			end
		end
	end
	
	cureAction = "none"
	
end

function getCureAction(aff)

	local cureAct = rime.curing.curesByAff[aff]
	if aff == "nothing" then cureAct = "nothing" end
	
	return cureAct

end

rime.vitals.manawatch = rime.vitals.manawatch or false

function vitalsHeal()

	local hp = tonumber(rime.vitals.percent_health) or 100
	local mp = tonumber(rime.vitals.percent_mana) or 100
	local sip_action = "nothing"
	local anabiotic_action = "nothing"

	if rime.has_aff("anorexia") or rime.has_aff("destroyed_throat") then return end

	if rime.has_aff("voyria") then
		sip_action = "sip immunity"
	elseif hp < 75 and mp > 70 then
		sip_action = "sip health"
	elseif hp > 40 and mp < 75 and not rime.pve.bashing then
		sip_action = "sip mana"
	elseif hp < 40 then
		sip_action = "sip health"
	elseif hp > 40 and mp < 75 then
		sip_action = "sip mana"
	end
	
	if hp < 80 or mp < 80 or rime.has_aff("plodding") or rime.has_aff("idiocy") then
		anabiotic_action = "eat anabiotic"
	end
--[[
	if rime.has_aff("recklessness") then
		sip_action = "sip health"
		anabiotic_action = "eat anabiotic"
	end
--]]
	if rime.curing.queue.sip ~= sip_action and sip_action ~= "nothing" and not rime.limit.sip then
		act("touch flaws", "queue health "..sip_action)
		limitStart("sip")
	end
	
	if rime.curing.queue.anabiotic ~= anabiotic_action and anabiotic_action ~= "nothing" and not rime.limit.anabiotic then
		act("touch flaws", "queue anabiotic "..anabiotic_action)
		limitStart("anabiotic")
	end

	 if rime.curing.queue.sip ~= sip_action and sip_action == "nothing" and not rime.limit.sip then
	 	act("touch flaws", "queue health")
	 	limitStart("sip")
	 end

	 if rime.curing.queue.anabiotic ~= anabiotic_action and anabiotic_action == "nothing" and not rime.limit.anabiotic then
	 	act("touch flaws", "queue anabiotic")
	 	limitStart("anabiotic")
	 end


end

function rime.stand()

	if rime.has_aff("left_leg_broken") or rime.has_aff("right_leg_broken") or rime.has_aff("indifference") then return end

	if rime.vitals.prone and not rime.limit.stand then
		act("stand")
		limitStart("stand", 1)
	end

end

function rime.add_aff(affliction, type)

	if affliction == "paresis" and rime.paused then
		rime.paused = false
		rime.echo("WE ARE UNPAUSED I REPEAT UNPAUSED")
	end

	if affliction == "epilepsy" and rime.cure_set ~= "sentinel" then --sentinel fuckery?????
		act("dodge upset")
	end

	if affliction == "shivering" and rime.cure_set == "sciomancer" then
		act("dodge upset")
	end

	if affliction == "faintness" and type == "discovered" and rime.cure_set == "sciomancer" then
		rime.afflictions.nyctophobia = true
		rime.echo("Gained <red>nyctophobia", "curing")
		rime.afflictions.dementia = true
		rime.echo("Gained <red>dementia", "curing")
		rime.afflictions.confusion = true
		rime.echo("Gained <red>confusion", "curing")
		rime.afflictions.dizziness = true
		rime.echo("Gained <red>dizziness", "curing")
	elseif affliction == "faintness" and type == "discovered" and rime.cure_set == "archivist" then
		rime.afflictions.dizziness = true
		rime.echo("Gained <red>dizziness", "curing")
	end


	if rime.has_aff(affliction) then
		if affliction == "broken_arms" then
			rime.add_aff("left_arm_broken")
			rime.add_aff("right_arm_broken")
			if rime.has_aff("broken_arms") then rime.silent_remAff("broken_arms") end
		end
		if affliction == "broken_legs" then
			rime.add_aff("left_leg_broken")
			rime.add_aff("right_leg_broken")
			if rime.has_aff("broken_legs") then rime.silent_remAff("broken_legs") end
		end
		return
	end
	
	if type == "discovered" then
	
		if not rime.has_aff(affliction) and rime.has_possible_aff(affliction) then
			rime.echo("Discovered a hidden affliction!", "curing")
			if rime.curing.need_howl_check then rime.curing.howl_aff_set(affliction) end
			rime.hidden_affs_total = rime.hidden_affs_total-1
			if rime.hidden_affs_total < 1 then
				rime.hidden_affs_total = 0
				for k in pairs(rime.hidden_afflictions) do
					rime.hidden_afflictions[k] = false
				end
			end
		elseif not rime.has_aff(affliction) and not rime.has_possible_aff(affliction) then
			rime.echo("Discovered a hidden affliction, but you're not tracking it in any of your hidden affliction pools! LONG WINDED ECHO'S ARE ANNOYING FIX YOUR SHIT AND YOU CAN DELETE THEM YOU FUCKING SCRUB", "curing")
			if rime.curing.need_howl_check then rime.curing.howl_aff_set(affliction) end
			if rime.hidden_affs_total < 1 then
				rime.hidden_affs_total = 0
				for k in pairs(rime.hidden_afflictions) do
					rime.hidden_afflictions[k] = false
				end
			end
		end
	end

	if affliction == "fear" then
		act("compose")
		act("compose")
	end

	if affliction == "stun" then 
		rime.curing.queue = {
			renew = "nothing",
			poultice = "nothing",
			anabiotic = "nothing",
			pipe = "nothing",
			focus = "nothing",
			pill = "nothing",
			tree = "nothing",
			sip = "nothing",
			elixir = "nothing",
		}
	end


	if affliction == "blackout" then
		enableTimer("blackout_check")
	end

	if affliction == "effused_blood" then
		enableTimer("Effusion Backup Plan")
	end

	if affliction == "broken_any" then
		if rime.has_aff("broken_any") then
			rime.afflictions.broken_any_more = true 
		end
	end

	if not rime.has_aff(affliction) then
		rime.afflictions[affliction] = true
		rime.echo("Gained <red>"..affliction, "curing")
		rime.echo("Hidden count is <red>"..rime.hidden_affs_total.."<white>", "curing")
	end
	rime.hidden_afflictions[affliction] = false

	rime.cure_special()

	if affliction == "ravaged" then rime.curing.limbs.threshhold = tonumber(3000) end

	if affliction == "broken_arms" then
		rime.hidden_afflictions.left_arm_broken = true
		rime.hidden_afflictions.right_arm_broken = true
	end
	if affliction == "broken_legs" then
		rime.hidden_afflictions.left_leg_broken = true
		rime.hidden_afflictions.right_leg_broken = true
	end
	if affliction == "broken_any" then
		rime.hidden_affs_total = rime.hidden_affs_total+1
		rime.hidden_afflictions.left_leg_broken = true
		rime.hidden_afflictions.right_leg_broken = true
		rime.hidden_afflictions.left_arm_broken = true
		rime.hidden_afflictions.right_arm_broken = true
	end

	rime.affTally = 0
	rime.physAffTally = 0
	rime.mentalAffTally = 0
	for k in pairs(rime.afflictions) do
		if rime.has_aff(k) then
			if rime.afflictions[k] then rime.affTally = rime.affTally+1 end
			if table.contains(rime.curing.affsByType.physical, k) then rime.physAffTally = rime.physAffTally+1 end
			if table.contains(rime.curing.affsByType.focus, k) then rime.mentalAffTally = rime.mentalAffTally+1 end
		end
	end

	if rime.balances.balance and rime.balances.equilibrium then
		rime.pvp.queue_handle()
	end

	if rime.pvp.ai then rime.pvp.offense() end
	
	zgui.showAffs()

end

function rime.silent_addAff(affliction)
	
	rime.afflictions[affliction] = true
	rime.hidden_afflictions[affliction] = false
	if table.contains(zgui.myAfflictions, affliction) then
		removeDupAff = table.index_of(zgui.myAfflictions, affliction)
		table.remove(zgui.myAfflictions, removeDupAff) 
		table.insert(zgui.myAfflictions, 1, affliction)
	else
		table.insert(zgui.myAfflictions, 1, affliction)
	end

	zgui.showAffs()

end

function rime.remove_aff(affliction)

	if (affliction == "left_arm_broken" or affliction =="right_arm_broken") and rime.has_aff("broken_arms") then affliction = "broken_arms" end
	if (affliction == "left_leg_broken" or affliction =="right_leg_broken") and rime.has_aff("broken_legs") then affliction = "broken_legs" end

	if affliction == "epilepsy" then
		act("dodge melee")
	end

	if affliction == "stun" then 
		rime.curing.queue = {
			renew = "nothing",
			poultice = "nothing",
			anabiotic = "nothing",
			pipe = "nothing",
			focus = "nothing",
			pill = "nothing",
			tree = "nothing",
			sip = "nothing",
			elixir = "nothing",
		}
	end

	if affliction == "blackout" and rime.curing.shamans_are_bullshit then
		rime.curing.shamans_are_bullshit = false
		rime.hidden_affs_total = rime.hidden_affs_total+4
		rime.add_possible_aff("vitalbane")
		rime.add_possible_aff("epilepsy")
		rime.add_possible_aff("confusion")
		rime.add_possible_aff("impatience")
		rime.add_possible_aff("hallucinations")
		rime.add_possible_aff("faintness")
		rime.add_possible_aff("premonition")
		rime.add_possible_aff("infested")
		rime.hidden_aff("loki")
		rime.check_hidden()
	end

	if not rime.has_aff(affliction) and rime.has_possible_aff(affliction) then
		rime.echo("Discovered a hidden affliction!", "curing")
		if rime.curing.need_howl_check then rime.curing.howl_aff_set(affliction) end
		rime.hidden_affs_total = rime.hidden_affs_total-1
		if rime.hidden_affs_total < 1 then
			rime.hidden_affs_total = 0
			for k in pairs(rime.hidden_afflictions) do
				rime.hidden_afflictions[k] = false
			end
		end

	elseif not rime.has_aff(affliction) and not rime.has_possible_aff(affliction) and not string.find("pre_restore", affliction) then
		rime.echo("Discovered a hidden affliction, but you're not tracking it in any of your hidden affliction pools! LONG WINDED ECHO'S ARE ANNOYING FIX YOUR SHIT AND YOU CAN DELETE THEM YOU FUCKING SCRUB", "curing")
		rime.hidden_affs_total = rime.hidden_affs_total-1
		if rime.hidden_affs_total < 1 then
			rime.hidden_affs_total = 0
			for k in pairs(rime.hidden_afflictions) do
				rime.hidden_afflictions[k] = false
			end
		end
		
	end

	rime.echo("Cured <green>"..affliction, "curing")
	rime.afflictions[affliction] = false
	rime.hidden_afflictions[affliction] = false
	rime.curing.last_cured = affliction
	rime.cure_special()

	if rime.pve.bashing then rime.pve.autoBash() end

	if affliction == "ravaged" then rime.curing.limbs.threshhold = tonumber(1000) end

	if (affliction == "left_leg_broken" or affliction =="right_leg_broken" or affliction == "left_arm_broken" or affliction =="right_arm_broken")
	and rime.has_aff("broken_any") then
		if rime.has_aff("broken_any_more") then
			rime.silent_remAff("broken_any_more")
		else
			rime.silent_remAff("broken_any")
		end
	end

	rime.affTally = 0
	rime.physAffTally = 0
	rime.mentalAffTally = 0
	for k in pairs(rime.afflictions) do
		if rime.has_aff(k) then
			if rime.afflictions[k] then rime.affTally = rime.affTally+1 end
			if table.contains(rime.curing.affsByType.physical, k) then rime.physAffTally = rime.physAffTally+1 end
			if table.contains(rime.curing.affsByType.focus, k) then rime.mentalAffTally = rime.mentalAffTally+1 end
		end
	end

	if rime.balances.balance and rime.balances.equilibrium then
		rime.pvp.queue_handle()
	end

	if rime.pvp.ai then rime.pvp.offense() end

	zgui.showAffs()


end

function rime.silent_remAff(affliction)

	rime.afflictions[affliction] = false
	rime.hidden_afflictions[affliction] = false
	if table.contains(zgui.myAfflictions, affliction) then table.remove(zgui.myAfflictions, table.index_of(zgui.myAfflictions, affliction)) end

	zgui.showAffs()

end

function rime.has_aff(affliction)

	if rime.afflictions[affliction] == nil then rime.afflictions[affliction] = false end

	if affliction == "slickness2" then return rime.afflictions.slickness end

	return rime.afflictions[affliction]
	
end


function rime.cure_all()

	if not rime.firstaid then

		rime.cure_pipe()
		rime.cure_pill()
		rime.cure_poultice()
		rime.cure_focus()
		rime.cure_tree()
		rime.cure_renew()
		rime.cure_random()
		rime.cure_writhe()
		rime.cure_elixir()
		vitalsHeal()
		free_defs()
		
	end

end

function rime.cure_random()
	if not gmcp.Char.Status then return end
	local class = gmcp.Char.Status.class or ""

	local classAffs = {}

    for k,v in pairs(rime.afflictions) do
        if v then
            table.insert(classAffs, k)
            classAffs[k] = true
        end
    end

	local affs = {}
	local needClass = false

	local sep = rime.saved.separator

	local class_cures = {
	["Teradrim"] = "earth absorb",
	["Praenomen"] = "purify blood",
	["Carnifex"] = "soul purge",
	["Indorani"] = "draw fool from deck" .. sep .. "fling fool at me",
	}


	rime.affTally = 0
	rime.physAffTally = 0
	rime.mentalAffTally = 0
	for k in pairs(rime.afflictions) do
		if rime.has_aff(k) then
			if rime.afflictions[k] then rime.affTally = rime.affTally+1 end
			if table.contains(rime.curing.affsByType.physical, k) then rime.physAffTally = rime.physAffTally+1 end
			if table.contains(rime.curing.affsByType.focus, k) then rime.mentalAffTally = rime.mentalAffTally+1 end
		end
	end

	classAffs[rime.curing.tried.pill] = false
	classAffs[rime.curing.tried.poultice] = false
	classAffs[rime.curing.tried.pipe] = false
	classAffs[rime.curing.tried.focus] = false
	
	if rime.has_aff("right_arm_damaged") then classAffs["right_arm_broken"] = false end
	if rime.has_aff("left_arm_damaged") then classAffs["left_arm_broken"] = false end
	if rime.has_aff("right_leg_damaged") then classAffs["right_leg_broken"] = false end
	if rime.has_aff("left_leg_damaged") then classAffs["left_leg_broken"] = false end
	if rime.has_aff("heatspear") then classAffs["ablaze"] = false end

	if class == "Carnifex" then
		for k,v in pairs(rime.curing.affsByType.physical) do
			if classAffs[v] then
				additem(affs, v)
			end
		end
	else
		for k,v in pairs(rime.curing.affsByType.renew) do
			if classAffs[v] then
				additem(affs, v)
			end
		end
	end
	
	if rime.curing.class then

		if class == "Teradrim" then
			if #affs > 2 and not (rime.has_aff("paresis") or rime.has_aff("paralysis")) then
				needClass = true
			else
				needClass = false
			end
		elseif class == "Praenomen" then
			if #affs > 2 or rime.hidden_affs_total > 2 then
				needClass = true
			else
				needClass = false
			end
		elseif class == "Carnifex" then
			if (#affs > 1 or rime.physAffTally > 1) and not (rime.has_aff("paralysis")) and not rime.balances.tree then
				needClass = true
			elseif rime.has_aff("asthma") then
				needClass = true
			else
				needClass = false
			end
		elseif class == "Indorani" then
			if #affs > 2 then
				needClass = true
			else
				needClass = false
			end
		end

	end

	if needClass and not rime.limit.needClass then
		if class == "Carnifex" then
			act(class_cures[class])
		else
			act("qeb "..class_cures[class])
		end
		limitStart("needClass")
	end

end

function rime.cure_pill()

	pillAff = nextPillAff()
	
	if not pillAff then return end
	
	cureAction = getCureAction(pillAff)
	if string.find(cureAction, "eat") then cureAction = cureAction:gsub("eat ", "outc ") ..rime.saved.separator.. cureAction end
	
	if not rime.has_aff("anorexia") and not rime.has_aff("destroyed_throat") then 
	
		doCureAction()
		
		if rime.balances.pill then
			rime.curing.tried["pill"] = pillAff
		end
		
	end

end


function nextPillAff()

--and not isBlocked(v)
	
	local prio_list = rime.cure_set

	if rime.has_aff("disrupted") and rime.has_aff("confusion") and not isBlocked("confusion") then
		return "confusion"
	elseif rime.has_aff("paresis") and not isBlocked("paresis") and (rime.balances.tree or rime.pvp.ai == false) then
		if rime.next_cured("decongestant") ~= "asthma" then
			return "paresis"
		else
			return "asthma"
		end
	elseif rime.has_aff("asthma") and not isBlocked("asthma") and rime.next_cured("decongestant") == "asthma" then
		return "asthma"
	elseif rime.has_aff("paresis") and not isBlocked("paresis") and (rime.balances.tree or not rime.pvp.ai) and (not rime.cure_set == "praenomen" and not rime.has_aff("blind")) then
		return "paresis"
	elseif rime.has_aff("paralysis") and not isBlocked("paralysis") and rime.pvp.class_cure() then
		return "paralysis"
	elseif rime.has_aff("sensitivity") and not isBlocked("sensitivity") and rime.has_aff("writhe_impaled") then
		return "sensitivity"
	else
		for _, v in pairs(rime.curing.priority[prio_list].herb) do
			if rime.has_aff(v) and rime.curing.tried.focus ~= v and rime.next_cured(getCureAction(v):gsub("eat ", "")) == v  and not isBlocked(v) then
				return v
			end
		end
		for _, v in pairs(rime.curing.affsByType.herb) do
			if rime.has_aff(v) and rime.curing.tried.focus ~= v and rime.next_cured(getCureAction(v):gsub("eat ", "")) == v  and not isBlocked(v) then
				return v
			end
		end
	end
	
	return "nothing"
			
end

function rime.cure_poultice()

	poulticeAff = nextPoulticeAff()
	
	if not poulticeAff then return end

	cureAction = getCureAction(poulticeAff)
	
	if not rime.has_aff("slickness") and not rime.has_aff("sandrot") then
	
		if rime.balances.poultice then
			rime.curing.tried["poultice"] = poulticeAff
		end

		doCureAction()
		
	end
	 
end

function nextPoulticeAff()

	local prio_list = rime.cure_set

	generatePreRestore()

	for _, v in pairs(rime.curing.priority[prio_list].poultice) do

		if rime.has_aff(v) and not isBlocked(v) then
			
			if v == tostring(rime.curing.restoring_limb.."_damaged") then
				if (rime.curing.limbs[rime.curing.restoring_limb]-3000) >= 3333 then
					return v
				end
			elseif v == tostring(rime.curing.restoring_limb.."_mangled") then
				if (rime.curing.limbs[rime.curing.restoring_limb]-3000) >= 6666 then
					return v
				end
			elseif v == "voidgaze" and rime.curing.restoring_limb == "head" then
				break
			elseif v == "torso_elevation" and rime.curing.restoring_limb == "torso" then
				if (rime.curing.limbs.torso-3000) >= 0 then
					return v
				end
			elseif v == "heatspear" and rime.curing.restoring_limb == "torso" then
				if rime.has_aff("damaged_torso") and rime.curing.limbs.torso-3000 <= 3333 then
					return v
				--else
				--	break
				end
			else
				return v
			end

		end

	end

	for _, v in pairs(rime.curing.affsByType.poultice) do

		if rime.has_aff(v) and not isBlocked(v) then
			
			if v == tostring(rime.curing.restoring_limb.."_damaged") then
				if (rime.curing.limbs[rime.curing.restoring_limb]-3000) >= 3333 then
					return v
				end
			elseif v == tostring(rime.curing.restoring_limb.."_mangled") then
				if (rime.curing.limbs[rime.curing.restoring_limb]-3000) >= 6666 then
					return v
				end
			elseif v == "voidgaze" and rime.curing.restoring_limb == "head" then
				break
			elseif v == "torso_elevation" and rime.curing.restoring_limb == "torso" then
				if (rime.curing.limbs.torso-3000) >= 0 then
					return v
				end
			elseif v == "heatspear" and rime.curing.restoring_limb == "torso" then
				if rime.has_aff("damaged_torso") and rime.curing.limbs.torso-3000 <= 3333 then
					return v
				--else
				--	break
				end
			else
				return v
			end

		end

	end

	return "nothing"

end

function rime.cure_pipe()

	pipeAff = nextPipeAff()
	
	if not pipeAff then return end
	
	cureAction = getCureAction(pipeAff)

	if not rime.has_aff("asthma") and not rime.has_aff("troubled_breathing") then
	
		doCureAction()

		if rime.balances.pipe then
			rime.curing.tried["pipe"] = pipeAff
		end

	end

end



function nextPipeAff()

	local prio_list = rime.cure_set

	for _, v in pairs(rime.curing.priority[prio_list].pipe) do

		if (rime.has_aff(v) or rime.has_possible_aff(v)) and not isBlocked(v) then
		
			return v
			
		end
		
	end

	for _, v in pairs(rime.curing.affsByType.pipe) do

		if (rime.has_aff(v) or rime.has_possible_aff(v)) and not isBlocked(v) then
		
			return v
			
		end

	end

	return "nothing"

end

rime.curing.pipes = {
	["reishi"] = true,
	["yarrow"] = true,
	["willow"] = true,
	["last"] = "none",
}




function rime.cure_writhe()

	writheAff = nextWritheAff()

	if not writheAff then return end

	cureAction = getCureAction(writheAff)

	if gmcp.Char.Vitals.writhing == "0" then
		doCureAction()
	end
end

function nextWritheAff()

	local prio_list = rime.cure_set

	for _, v in pairs(rime.curing.priority[prio_list].writhe) do
		if rime.has_aff(v) then
			return v
		end
	end
	for _, v in pairs(rime.curing.affsByType.writhe) do
		if rime.has_aff(v) then
			return v
		end
	end

	return "nothing"

end

function rime.cure_elixir()

	elixirAff = nextElixirAff()
	
	if not elixirAff then return end

	cureAction = getCureAction(elixirAff)

	if not rime.has_aff("anorexia") and not rime.has_aff("destroyed_throat") then
	
		doCureAction()
		
		if rime.balances.elixir then
			rime.curing.tried["elixir"] = elixirAff
		end

	end

end

function nextElixirAff()

	for _, v in pairs(rime.curing.affsByType.elixir) do
	
		if rime.has_aff(v) and not isBlocked(v) then
			
			return v
			
		end
		
	end

	return "nothing"

end

function rime.cure_tree()

	if rime.shell or rime.has_aff("paresis") or rime.has_aff("paralysis") or rime.has_aff("tree_seared") or rime.has_aff("writhe_transfix") or (rime.has_aff("left_arm_broken") and rime.has_aff("right_arm_broken")) then return end

	local treeAffs = {}

    for k,v in pairs(rime.afflictions) do
        if v then
            table.insert(treeAffs, k)
            treeAffs[k] = true
        end
    end

	local needTree = false

	treeAffs[rime.curing.tried.pill] = false
	treeAffs[rime.curing.tried.poultice] = false
	treeAffs[rime.curing.tried.pipe] = false
	treeAffs[rime.curing.tried.focus] = false
	
	if rime.has_aff("right_arm_damaged") then treeAffs["right_arm_broken"] = false end
	if rime.has_aff("left_arm_damaged") then treeAffs["left_arm_broken"] = false end
	if rime.has_aff("right_leg_damaged") then treeAffs["right_leg_broken"] = false end
	if rime.has_aff("left_leg_damaged") then treeAffs["left_leg_broken"] = false end
	if rime.has_aff("heatspear") then treeAffs["ablaze"] = false end

	for _, v in pairs(rime.curing.affsByType.tree) do
		if treeAffs[v] and (rime.has_possible_aff(v) or rime.has_aff(v)) then
			needTree = true
		end
	end
	if rime.hidden_affs_total > 0 then
		needTree = true
	end
	
	if not needTree then
		if rime.curing.queue.tree ~= "nothing" and not rime.limit.tree_queue then
			act("queue tree")
			limitStart("tree_queue", .3)
		end
	
	return end
	
    if needTree and rime.curing.queue.tree == "nothing" and not rime.limit.tree_queue then
        act("queue tree touch tree")
        if rime.has_aff("aeon") then
            limitStart("tree_queue", 2)
        else
            limitStart("tree_queue", .1)
        end
    end

end

function rime.cure_focus()

	local needFocus = "nothing"

	local focusAffs = table.deepcopy(rime.afflictions)

	focusAffs[rime.curing.tried.pill] = false
	focusAffs[rime.curing.tried.poultice] = false
	focusAffs[rime.curing.tried.pipe] = false

	needFocus = nextFocusAff()
	if needFocus == "nothing" then
		for _, v in pairs(rime.curing.affsByType.focus) do
			if rime.has_possible_aff(v) then
				needFocus = v
			end
		end
	end

	if rime.vitals.current_mana == nil or rime.vitals.current_mana < 251 then
		needFocus = false
	end

	if rime.has_aff("impatience") then 
		needFocus = false
	end

	if rime.has_aff("muddled") then
		needFocus = false
	end

	if rime.cure_set == "sciomancer" and rime.has_aff("gloom") then
		if nextFocusAff() == "weariness" then
			needFocus = true
		else
			needFocus = false
		end
	end
	
	if needFocus == "nothing" or needFocus == false then
		if rime.curing.queue.focus ~= "nothing" and not rime.limit.focus_queue then
			act("queue focus")
			rime.curing.tried["focus"] = "nothing"
			if rime.has_aff("aeon") then
				limitStart("focus_queue", 1)
			else
				limitStart("focus_queue", .3)
			end
		end
		return
	elseif needFocus ~= false and needFocus ~= "nothing" and rime.curing.queue.focus == "nothing" and not rime.limit.focus_queue then
		if rime.has_possible_aff("laxity") then
			act("queue focus touch flaws"..rime.saved.separator.."focus"..rime.saved.separator.."cooldowns")
		else
			act("queue focus touch flaws"..rime.saved.separator.."focus")
		end
		if rime.balances.focus then
			rime.curing.tried["focus"] = needFocus
		end
		if rime.has_aff("aeon") then
			limitStart("focus_queue", 1)
		else
			limitStart("focus_queue", .3)
		end
	end

end

function nextFocusAff()

	local prio_list = rime.cure_set

	local focusAffs = table.deepcopy(rime.afflictions)

	focusAffs[rime.curing.tried.pill] = false
	focusAffs[rime.curing.tried.poultice] = false
	focusAffs[rime.curing.tried.pipe] = false

	for _, v in ipairs(rime.curing.affsByType.focus) do
		if focusAffs[v] then
			return v
		end
	end
	
	return "nothing"

end

function rime.cure_renew()

	if rime.has_aff("impairment") or rime.vitals.current_mana < 501 then return end

    local renewAffs = table.deepcopy(rime.afflictions)

	local needRenew = false

	renewAffs[rime.curing.tried.pill] = false
	renewAffs[rime.curing.tried.poultice] = false
	renewAffs[rime.curing.tried.pipe] = false
	renewAffs[rime.curing.tried.focus] = false
	
	
	if rime.has_aff("right_arm_damaged") then renewAffs["right_arm_broken"] = false end
	if rime.has_aff("left_arm_damaged") then renewAffs["left_arm_broken"] = false end
	if rime.has_aff("right_leg_damaged") then renewAffs["right_leg_broken"] = false end
	if rime.has_aff("left_leg_damaged") then renewAffs["left_leg_broken"] = false end
	if rime.has_aff("heatspear") then renewAffs["ablaze"] = false end
	
	for _, v in pairs(rime.curing.affsByType.renew) do
		if (rime.has_aff(v) or rime.has_possible_aff(v)) and renewAffs[v] then
			needRenew = true
		end
	end
	if rime.hidden_affs_total > 1 then
		needRenew = true
	end

	if not needRenew then
		if rime.curing.queue.renew ~= "nothing" and not rime.limit.renew_queue then
			act("queue renew")
			if rime.has_aff("aeon") then
				limitStart("renew_queue", 1)
			else
				limitStart("renew_queue", .3)
			end
		end
	
	return end
	
	if needRenew and rime.curing.queue.renew == "nothing" and not rime.limit.renew_queue then
		act("queue renew touch flaws" .. rime.saved.separator.."reconstitute")
		if rime.has_aff("aeon") then
			limitStart("renew_queue", 1)
		else
			limitStart("renew_queue", .3)
		end
		if not rime.balances.balance or not rime.balances.equilibrium then
			rime.curing.queue.renew = "queue renew touch flaws" ..rime.saved.separator.."reconstitute"
		end
	end

end

function rime.cure_special()
	local cureAct
	for i, v in ipairs(rime.curing.affsByType.special) do
		if v == "disrupted" and rime.has_aff("confusion") then break end
		if rime.has_aff(v) then cureAct = getCureAction(v) end
		if rime.has_aff(v) and cureAct ~= "none" then act(cureAct) end
		limitStart(v)
	end
end

function rime.next_cured(cure)

    for k,v in ipairs(rime.curing.affsByCure[cure]) do
        if rime.has_aff(v) then
            return v
        end
    end

end

function addlimbdam(limb, damage)

	damage = tonumber(damage)

	if damage == 0 or damage == 000 then
		rime.curing.limbs[limb] = 0
		rime.echo(string.title(limb):gsub("t_", "t ").." restored fully.", "curing")
		return
	end

	if rime.curing.limbs[limb] then
		rime.curing.limbs[limb] = tonumber(rime.curing.limbs[limb] + damage)
	end

	if rime.curing.limbs[limb] < 0 then
		rime.curing.limbs[limb] = 0
	end
	local limbName = "<DodgerBlue>"
	local limbNumber = "<DarkSlateGray>"
	local limbcho = "\n"
	for lmb, dmg in pairs(rime.curing.limbs) do
		if lmb == limb then limbName = "<orange>" limbNumber = "<white>" else limbName = "<DodgerBlue>" limbNumber = "<DarkSlateGray>" end
		limbcho = limbcho..limbName..lmb.." "..limbNumber..dmg.." "
	end
	cecho(limbcho)


end

if not rime.parry then rime.parry = "torso" end

function generatePreRestore()

	local class
	if gmcp.Char.Status then class = gmcp.Char.Status.class else return end --class check for guard/parry

--[[ this is an example on how to elevate torso damage to cure it first
	if rime.curing.limbs["torso"] > 0 and rime.has_aff("hypothermia") then
		rime.add_aff("torso_elevation")
	else
		if rime.has_aff("torso_elevation") then rime.silent_remAff("torso_elevation") end
	end
--]]
	if not rime.has_aff("ravaged") and rime.curing.embedIn ~= "none" and freshEmbed then
		freshEmbed = false
		local embed = rime.curing.embedIn:gsub(" ", "_")
		rime.curing.limbs[embed] = rime.curing.limbs[embed] + 3000
	end

	local parts = {"left_arm", "right_arm", "right_leg", "left_leg", "head", "torso"}
	local damagesort = {}

	local need_parry = {}

	for num, limb in pairs (parts) do
		if next(damagesort) == nil then
			table.insert(damagesort, limb)
		else
			for num2, limb2 in pairs (damagesort) do
				if tonumber(rime.curing.limbs[limb]) > tonumber(rime.curing.limbs[limb2]) then
					table.insert(damagesort, num2, limb)
					break
				elseif damagesort[num2 + 1] == nil then
					table.insert(damagesort, limb)
					break
				end
			end
		end

		rime.silent_remAff("pre_restore_"..limb)

		if rime.curing.restoring_limb == limb then
			if tonumber(rime.curing.limbs[limb]) - 3000 > tonumber(rime.curing.limbs.threshhold) then
				rime.silent_addAff("pre_restore_"..limb)
			end
		else
			if tonumber(rime.curing.limbs[limb]) > tonumber(rime.curing.limbs.threshhold) then
				rime.silent_addAff("pre_restore_"..limb)
			elseif tonumber(rime.curing.limbs.head) >= tonumber(1500) then
				rime.silent_addAff("pre_restore_head")
			end
		end
	end

	local prone
	if gmcp.Char then
		prone = gmcp.Char.Vitals.prone
	end

	local shifterParrying = false
	local wayfarerParrying = false
	local zealotParrying = false
	local groupParrying = false
	local ascendrilParrying = false
	local carnifexParrying = false
	local sentinelParrying = false
	local teradrimParrying = false
	local parryColor = "<red>"

	if rime.cure_set == "shifter" then
		shifterParrying = true
		parryColor = "<firebrick>"
	elseif rime.cure_set == "wayfarer" then
		wayfarerParrying = true
		parryColor = "<SaddleBrown>"
	elseif rime.cure_set == "zealot" then
		zealotParrying = true
		parryColor = "<purple>"
	elseif rime.cure_set == "group" then
		groupParrying = true
		parryColor = "<cyan>"
	elseif rime.cure_set == "carnifex" then
		carnifexParrying = true
		parryColor = "<SteelBlue>"
	elseif rime.cure_set == "ascendril" then
		ascendrilParrying = true
		parryColor = "<blue>"
	elseif rime.cure_set == "sentinel" then
		sentinelParrying = true
		parryColor = "<a_brown>"
	elseif rime.cure_set == "teradrim" then
		teradrimParrying = true
		parryColor = "<green>"
	end

	local limbs = table.copy(rime.curing.limbs)
	limbs.threshhold = nil

	local parryLimb = "head"
	if shifterParrying then parryLimb = "right leg" end
	if wayfarerParrying then parryLimb = "left leg" end
	if zealotParrying then parryLimb = "torso" end
	if groupParrying then parryLimb = "head" end
	if carnifexParrying then parryLimb = "torso" end
	if ascendrilParrying then parryLimb = "right leg" end
	if sentinelParrying then parryLimb = "head" end
	local restoLimb = rime.curing.restoring_limb
	if restoLimb == "none" then restoLimb = false end

	for limb, damage in pairs(limbs) do
		if restoLimb and restoLimb == limb then
			damage = damage - 3000 -- restoration has been applied.
		end

		if damage >= 6666 then damage = damage - 6666 end
		if damage >= 3333 then damage = damage - 3333 end
		if damage > limbs[string.gsub(parryLimb, " ", "_")] then
			parryLimb = string.gsub(limb, "_", " ")
		end
	end

	if prone == "1" or rime.has_aff("right_leg_damaged") or rime.has_aff("left_leg_damaged") then
		if restoLimb == "right_leg" then 
			parryLimb = "left leg" 
		else
			parryLimb = "right leg"
		end
	end

	if shifterParrying then 
		if rime.has_aff("right_leg_broken") and not rime.has_aff("right_leg_mangled") then
			parryLimb = "right leg"
		elseif rime.has_aff("left_leg_broken") and not rime.has_aff("left_leg_mangled") then
			parryLimb = "left leg"
		elseif rime.has_aff("right_leg_broken") then
			parryLimb = "right leg"
		elseif rime.has_aff("left_leg_broken") then
			parryLimb = "left leg"
		elseif rime.has_aff("left_arm_broken") and not rime.has_aff("left_arm_mangled") then
			parryLimb = "left arm"
		elseif rime.has_aff("right_arm_broken") and not rime.has_aff("right_arm_mangled") then
			parryLimb = "right arm"
		elseif rime.has_aff("left_arm_broken") then
			parryLimb = "left arm"
		elseif rime.has_aff("right_arm_broken") then
			parryLimb = "right arm"
		end
	end

	if wayfarerParrying then
		if prone == "1" then
			parryLimb = "head"
		elseif rime.curing.limbs.head >= 2100 then
			parryLimb = "head"
		elseif rime.curing.embedIn == "right leg" and not rime.has_aff("left_leg_damaged") then
			parryLimb = "left leg"
		elseif rime.curing.embedIn == "left leg" and not rime.has_aff("right_leg_damaged") then
			parryLimb = "right leg"
		end
	end

	if zealotParrying then
		if rime.curing.heel_rush ~= "none" then
			parryLimb = rime.curing.heel_rush:gsub("_", " ")
		elseif rime.has_aff("lightwound") then
			parryLimb = "torso"
		elseif rime.curing.limbs.torso >= 1600 and not restoLimb == "torso" then
			parryLimb = "torso"
		end
	end

	if carnifexParrying then
		if rime.has_aff("left_leg_damaged") and not rime.has_aff("right_leg_damaged") then
			parryLimb = "right leg"
		elseif rime.has_aff("right_leg_damaged") and not rime.has_aff("left_leg_damaged") then
			parryLimb = "left leg"
		elseif rime.curing.limbs.torso >= 1600 and not restoLimb == "torso" then
			parryLimb = "torso"
		end
	end

	if groupParrying then
		if rime.has_aff("right_leg_broken") and not rime.has_aff("right_leg_mangled") then
			parryLimb = "right leg"
		elseif rime.has_aff("left_leg_broken") and not rime.has_aff("left_leg_mangled") then
			parryLimb = "left leg"
		elseif rime.has_aff("left_arm_broken") and not rime.has_aff("left_arm_mangled") then
			parryLimb = "left arm"
		elseif rime.has_aff("right_arm_broken") and not rime.has_aff("right_arm_mangled") then
			parryLimb = "right arm"
		elseif rime.vitals.bleeding > 500 then
			parryLimb = "head"
		end
	end

	if ascendrilParrying then
        if rime.curing.limbs.torso >= 2000 and not restoLimb == "torso" then
            parryLimb = "torso"
        elseif rime.has_aff("left_leg_damaged") and not rime.has_aff("right_leg_damaged") then
            parryLimb = "right leg"
        elseif rime.has_aff("right_leg_damaged") and not rime.has_aff("left_leg_damaged") then
            parryLimb = "left leg"
        elseif rime.has_aff("right_arm_damaged") and not rime.has_aff("left_arm_damaged") then
            parryLimb = "left arm"
        elseif rime.has_aff("left_arm_damaged") and not rime.has_aff("right_arm_damaged") then
            parryLimb = "right arm"
        end
     end

	if sentinelParrying then
		parryLimb = "head"
	end

	if teradrimParrying then
		if rime.curing.limbs.right_leg >= 1000 and restoLimb ~= "right_leg" then
			parryLimb = "right leg"
		elseif rime.curing.limbs.left_leg >= 1000 and restoLimb ~= "left_leg" then
			parryLimb = "left leg"
		elseif rime.has_aff("right_leg_damaged") and not rime.has_aff("left_leg_damaged") then
			parryLimb = "left leg"
		elseif rime.has_aff("left_leg_damaged") and not rime.has_aff("right_leg_damaged") then
			parryLimb = "right leg"
		elseif rime.curing.limbs.right_arm >= 1000 and restoLimb ~= "right_arm" then
			parryLimb = "right arm"
		elseif rime.curing.limbs.left_arm >= 1000 and restoLimb ~= "left_arm" then
			parryLimb = "left arm"
		elseif rime.has_aff("right_arm_damaged") and not rime.has_aff("left_arm_damaged") then
			parryLimb = "left arm"
		elseif rime.has_aff("left_arm_damaged") and not rime.has_aff("right_arm_damaged") then
			parryLimb = "right arm"
		else
			parryLimb = "torso"
		end
	end

	if rime.staticParry ~= "none" then parryLimb = rime.staticParry end
	
	if parryLimb ~= rime.parry and hasSkill("Parrying") then
		rime.echo(parryColor.."Switching parry to "..parryLimb, "pvp")
	end
	rime.parry = parryLimb

	if class == "Monk" and rime.parry ~= "none" and rime.parry ~= rime.parried and rime.balances.balance and rime.balances.equilibrium and not rime.limit.parry and hasSkill("Guarding") then
		act("guard "..string.gsub(rime.parry, "_", " "))
		limitStart("parry", .1)

	elseif rime.parry ~= "none" and rime.parry ~= rime.parried and rime.balances.balance and rime.balances.equilibrium and not rime.limit.parry and hasSkill("Parrying") then
		act("parry "..string.gsub(rime.parry, "_", " "))
		limitStart("parry", .1)
	end

end

function isBlocked(affliction)

	if rime.curing.stormtouched_mode and not rime.has_aff("stormtouched") and rime.curing.last_ate ~= "nothing" then
		for k,v in ipairs(rime.curing.affsByCure[rime.curing.last_ate]) do
			if v == affliction then
				return true
			end
		end
	end

	if (affliction == "left_leg_broken" or affliction == "left_leg_bruised" or affliction == "left_leg_bruised_moderate") and (rime.has_aff("left_leg_damaged") or rime.has_aff("left_leg_mangled")) then
		if rime.curing.restoring_limb == "left_leg" then
			if tonumber(rime.curing.limbs.left_leg)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif (affliction == "right_leg_broken" or affliction == "right_leg_bruised" or affliction == "right_leg_bruised_moderate") and (rime.has_aff("right_leg_damaged") or rime.has_aff("right_leg_mangled")) then
		if rime.curing.restoring_limb == "right_leg" then
			if tonumber(rime.curing.limbs.right_leg)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif (affliction == "left_arm_broken" or affliction == "left_arm_bruised" or affliction == "left_arm_bruised_moderate") and (rime.has_aff("left_arm_damaged") or rime.has_aff("left_arm_damaged")) then
		if rime.curing.restoring_limb == "left_arm" then
			if tonumber(rime.curing.limbs.left_arm)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif (affliction == "right_arm_broken" or affliction == "right_arm_bruised" or affliction == "right_arm_bruised_moderate") and (rime.has_aff("right_arm_damaged") or rime.has_aff("right_arm_mangled")) then
		if rime.curing.restoring_limb == "right_arm" then
			if tonumber(rime.curing.limbs.right_arm)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif (affliction == "torso_bruised" or affliction == "torso_bruised_moderate") and (rime.has_aff("torso_damaged") or rime.has_aff("torso_mangled")) then
		if rime.curing.restoring_limb == "torso" then
			if tonumber(rime.curing.limbs.torso)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif (affliction == "head_bruised" or affliction == "head_bruised_moderate") and (rime.has_aff("head_damaged") or rime.has_aff("head_mangled")) then
		if rime.curing.restoring_limb == "head" then
			if tonumber(rime.curing.limbs.head)-3000 >= 3333 then
				return true
			else
				return false
			end
		else
			return true
		end
	elseif affliction == "shivering" and rime.has_aff("hypothermia") then
		return true
	elseif affliction == "insulation" and rime.has_aff("hypothermia") then
		return true
	elseif affliction == "blind" and rime.has_aff("gloom") then
		return true
	elseif affliction:find("shaderot_") and rime.has_aff("shadowsphere") then
		return true
	elseif affliction == "cracked_ribs" and (rime.has_aff("torso_damaged") or rime.has_aff("ablaze")) then
		return true
	elseif affliction == "crushed_chest" and rime.has_aff("torso_damaged") then
		if rime.curing.restoring_limb ~= "torso" then
			return true
		elseif (rime.curing.limbs.torso-3000) >= 3333 then
			return true
		else
			return false
		end
	elseif affliction == "ablaze" and rime.has_aff("heatspear") then
		if rime.curing.restoring_limb ~= "torso" then
			return true
		else
			return false
		end
	elseif affliction == "ablaze" and rime.has_aff("torso_damaged") then
		if rime.curing.restoring_limb ~= "torso" then
			return true
		elseif (rime.curing.limbs.torso-3000) >= 3333 then
			return true
		else
			return false
		end
	elseif affliction == "fire_elevation" and rime.has_aff("torso_damaged") then
		return true
	elseif affliction == "gloom" and rime.curing.pressed_for_gloom then
		return true
	elseif affliction == "voidgaze" and rime.has_aff("head_damaged") then
		return true
	elseif rime.defences.general[affliction] then
		if not rime.defences.general[affliction].keepup then
			return true
		else
			return false
		end
	elseif affliction == "blighted" or affliction == "infested" and rime.has_aff("premonition") then
		return true
	else
		return false
	end

end

rime.shell = rime.shell or false



function rime.hidden_aff(affliction)

	for k,v in pairs(rime.curing.hidden_affs[affliction]) do
		rime.add_possible_aff(v)
		--rime.echo("Checking for symptoms from <red>"..v.." <white>afflictions.", "curing")
	end
	rime.hidden_affs_total = rime.hidden_affs_total+1
	rime.echo("Currently tracking <plum>"..rime.hidden_affs_total.." <red>hidden<white> afflictions.")


end

function rime.has_possible_aff(affliction)

	if rime.hidden_afflictions[affliction] == nil then rime.hidden_afflictions[affliction] = false end
	return rime.hidden_afflictions[affliction]

end

function rime.add_possible_aff(affliction)

	--if gmcp.Char.Status.class == "Carnifex" and affliction == "paresis" then rime.echo("hi this worked??") return end
	rime.hidden_afflictions[affliction] = true
	--rime.echo("Added <plum>"..affliction.."<white> to your possible affs.", "curing")

end

function rime.remove_possible_aff(affliction, no_echo)

    rime.hidden_afflictions[affliction] = false
    local hideyCount = 0
    for k,v in pairs(rime.hidden_afflictions) do
    	if rime.hidden_afflictions[k] then hideyCount = hideyCount+1 end
    end
    if hideyCount == 0 then rime.hidden_affs_total = 0 end
    if hideyCount > 0 and hideyCount == rime.hidden_affs_total then
    	for k,v in pairs(rime.hidden_afflictions) do
    		if v then rime.add_aff(k, "discovered") end
    	end
    end

    if not no_echo then rime.echo("Removed <plum>"..affliction.."<white> from your possible affs.", "curing") end

end

function rime.check_hidden()

	local free_checks = {}

	local sep = rime.saved.separator

	if has_def("insomnia") and rime.has_possible_aff("asleep") then
		if rime.has_aff("asleep") then rime.silent_remAff("asleep") end
		rime.remove_possible_aff("asleep", "noecho")
	end

	if rime.has_possible_aff("hypersomnia") then
		table.insert(free_checks, "eat kawhe")
	end

	if rime.has_possible_aff("anorexia") then
		table.insert(free_checks, "eat vial")
	end

	if rime.has_possible_aff("impairment") then
        table.insert(free_checks, "chameleon nobodyhome")
    end

	if rime.has_possible_aff("blind") and gmcp.Char.Vitals.blind == "1" then
		if rime.has_aff("blind") then rime.silent_remAff("blind") end
		rime.remove_possible_aff("blind", "no_echo")
	end
	if rime.has_possible_aff("deaf") and gmcp.Char.Vitals.blind == "1" then
		if rime.has_aff("deaf") then rime.silent_remAff("deaf") end
		rime.remove_possible_aff("deaf", "no_echo")
	end
	if rime.hidden_affs_total > 0 and rime.balances.tree then
		act("queue tree touch flaws"..rime.saved.separator.."touch tree")
	end
	if rime.hidden_affs_total > 1 and rime.balances.renew then
		act("queue renew touch flaws"..rime.saved.separator.."renew")
	end

	if rime.has_possible_aff("weariness") and tonumber(gmcp.Char.Vitals.mounted) <= 0 then
		if not (rime.balances.balance or rime.balances.equilibrium) then
			local exit = ""
			for k,v in pairs(gmcp.Room.Info.exits) do
				exit = k
				break
			end
			table.insert(free_checks, "dash "..exit)
		end
	end

	if rime.has_possible_aff("dizziness") then
		if not (rime.balances.balance or rime.balances.equilibrium) then
			table.insert(free_checks, "recall mount")
			table.insert(free_checks, "quickdismount")
			table.insert(free_checks, "quickmount "..rime.saved.mount)
		end
	end

	if rime.has_possible_aff("impatience") then
		if rime.balances.equilibrium and rime.balances.balance then
			table.insert(free_checks, "meditate")
		end
	end

	if rime.has_possible_aff("paranoia") then
		if rime.balances.equilibrium and rime.balances.balance then
			table.insert(free_checks, "unenemy "..gmcp.Char.Status.name)
		end
	end

	if rime.has_possible_aff("peace") then
		if rime.balances.equilibrium and rime.balances.balance then
			table.insert(free_checks, "enemy "..rime.target)
		end
	end

	if rime.has_possible_aff("dementia") then
		table.insert(free_checks, "ih nonesense")
	end

	if rime.has_possible_aff("asthma") and not has_def("fitness") then
		table.insert(free_checks, "smoke vial")
	end

	local treeAffs = {}
    for k,v in pairs(rime.afflictions) do
        if v then
            table.insert(treeAffs, k)
            treeAffs[k] = true
        end
    end
	if rime.has_aff("right_arm_damaged") then treeAffs["right_arm_broken"] = false end
	if rime.has_aff("left_arm_damaged") then treeAffs["left_arm_broken"] = false end
	if rime.has_aff("right_leg_damaged") then treeAffs["right_leg_broken"] = false end
	if rime.has_aff("left_leg_damaged") then treeAffs["left_leg_broken"] = false end
	if rime.has_aff("hypothermia") then treeAffs["shivering"] = false end

	local touchTree = false
	for k,v in pairs(rime.curing.affsByType.tree) do
		if treeAffs[v] and rime.has_aff(v) then
	    	touchTree = true
	    	break
	  	end
	end

	if rime.has_possible_aff("paresis") or touchTree then
		table.insert(free_checks, "touch tree")
	end

	if rime.hidden_affs_total >= 3 and not rime.has_aff("hypochondria") then
		act("diag")
	end

	act(table.concat(free_checks, sep))


end

function rime.curing.howl_aff_set(aff)

	if not rime.curing.howl_one then
		rime.curing.howl_one = aff
		--rime.echo("Hi rime.curing.howl_one is "..aff)
		if rime.hidden_affs_total <= 1 then
			rime.curing.need_howl_check = false
			rime.howls_set = true
		end
	elseif not rime.curing.howl_two then
		rime.curing.howl_two = aff
		--rime.echo("Hi rime.curing.howl_two is "..aff)
		if rime.hidden_affs_total <= 1 then
			rime.curing.need_howl_check = false
			rime.howls_set = true
		end
	else
		rime.curing.howl_three = aff
		--rime.echo("Hi rime.curing.howl_three is "..aff)
		rime.curing.need_howl_check = false
		rime.howls_set = true
	end

end

function rime.reset()

	rime.echo("Afflictions cleared", "curing")

	for k,v in pairs(rime.afflictions) do
		rime.afflictions[k] = false
	end
	rime.hidden_affs_total = 0
	for k,v in pairs(rime.hidden_afflictions) do
		rime.hidden_afflictions[k] = false
	end
	rime.vitals.dead = false
	rime.shell = false
	rime.curing.need_howl_check = false
	rime.curing.howl_one = false
	rime.curing.howl_two = false
	rime.curing.howl_three = false
	rime.howls_set = false
	rime.curing.pressed_for_gloom = false
	rime.curing.class = true
	rime.curing.limbs.right_arm = 0
	rime.curing.limbs.right_leg = 0
	rime.curing.limbs.head = 0
	rime.curing.limbs.left_arm = 0
	rime.curing.limbs.torso = 0
	rime.curing.limbs.left_leg = 0

	act("queue clear")

end

function rime.fa_toggle()
	local sep = rime.saved.separator
	if rime.firstaid then
		rime.firstaid = false
		act("firstaid curing off"..sep.."firstaid defence off"..sep.."firstaid reporting off"..sep.."firstaid heal health off"..sep.."firstaid heal mana off"..sep.."firstaid use anabiotic off"..sep.."firstaid use tree off"..sep.."firstaid use focus off"..sep.."firstaid use renew off"..sep.."firstaid use clot off"..sep.."firstaid adder 0")
		rime.echo("Client side curing enabled!")
	else
		rime.firstaid = true
		act("firstaid curing on"..sep.."firstaid defence on"..sep.."firstaid reporting on"..sep.."firstaid heal health on"..sep.."firstaid heal mana on"..sep.."firstaid use anabiotic on"..sep.."firstaid use tree on"..sep.."firstaid use focus on"..sep.."firstaid use renew on"..sep.."firstaid use clot on"..sep.."firstaid adder 3")
		rime.echo("Swapping to FA curing!")

	end

end

bleeding_floor = tonumber(200)
mana_floor = tonumber(.4)

function clot()

    --if not canClot() then return end

    if rime.limit.clot then return end

    if rime.vitals.bleeding < bleeding_floor then return end

    if rime.cure_set == "luminary" then
        mana_floor = tonumber(.5)
    elseif rime.cure_set == "praenomen" then
        mana_floor = tonumber(.33)
    elseif rime.cure_set == "group" then
    	mana_floor = tonumber(.35)
    else
        mana_floor = tonumber(.10)
    end

    if rime.has_aff("recklessness") or (rime.has_aff("haemophilia") and rime.vitals.current_mana < 2000) or rime.has_aff("blackout") then return end

    local clotmana = 4

    local manadiff = math.floor(rime.vitals.current_mana-(rime.vitals.max_mana*(mana_floor+0.15)))
    if manadiff < 0 then manadiff = 0 end

    local clotnum = math.floor(rime.vitals.bleeding-bleeding_floor)
    if clotnum == 0 then return end
    local clotcost = clotnum*clotmana
    local manahack = clotcost
    if rime.saved.mana_boon then
    	clotmana = 2.68
    	clotcost = math.floor((clotnum*clotmana)+.5)
    	if manahack >= rime.vitals.current_mana then manahack = true else manahack = false end
    end
    if type(manahack) == "number" then manahack = false end

    if rime.has_aff("haemophilia") then clotcost = clotcost*1.75 end

    local clotshort = math.floor(manadiff/clotmana)

    if clotcost > math.floor(rime.vitals.current_mana-(rime.vitals.current_mana*mana_floor)) then
    	clotnum = clotshort
    	if rime.saved.mana_boon then clotcost = math.ceil((clotnum*clotmana)+.5) else clotcost = clotnum*clotmana end
    end

    --    if rime.curing.bloodleech then
    --        lose_leech = true
    --    end
    if manahack then
    	act("clot "..clotnum/2, "clot "..clotnum/2)
    	rime.echo("Clotting "..clotnum.." for "..clotcost.." mana...")
    	limitStart("clot")
    else
    	act("clot " .. clotnum)
    	rime.echo("Clotting "..clotnum.." for "..clotcost.." mana")
    	limitStart("clot")
    end

end

function rime.check_shapes(aff)


	for tree, affs in pairs(rime.curing.shape_trees) do
		if table.contains(affs, aff) and not rime.has_aff(aff) then
			for _, v in ipairs(affs) do
				rime.echo("Discovered Shape aff! They're going for "..tree, "curing")
				rime.add_aff(v, true)
				rime.curing.shape_tree = tree
				if v == aff then return end
			end
		end
	end

end

function rime.shape_count()

	shape_count["triangle"] = tonumber(0)
	shape_count["square"] = tonumber(0)
	shape_count["circle"] = tonumber(0)
	
	
		for _, tree in pairs (shape_count) do
			for k,v in ipairs(rime.shape_trees[tree.shape]) do
				if hasAff(v) then
					tree.count = tree.count + 1
				end
			end
		end
	
	table.sort(shape_count, function(a, b) return a.count > b.count end)

end

rime.shape_counts = {
{shape = "triangle", count = tonumber(0)},
{shape = "square", count = tonumber(0)},
{shape = "circle", count = tonumber(0)},
}

rime.curing.shape_tree = "false"
rime.curing.shape_trees = {
	["triangle"] = {
		"laxity",
		"lovers_effect",
		"peace",
		"magnanimity",
	},

	["square"] = {
		"dizziness",
		"faintness",
		"epilepsy",
		"shyness",
	},

	["circle"] = {
		"merciful",
		"masochism",
		"berserking",
		"recklessness",
	},
}


-----------NO FUNCTIONS BELOW THESE LINES PLEASE, ONLY TABLES-------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------

rime.cure_set = rime.cure_set or "default"
rime.cureset_skills = {
ascendril = {"Elemancy", "Arcanism", "Thaumaturgy"},
sciomancer = {"Sciomancy", "Sorcery", "Gravitation"},
indorani = {"Necromancy", "Tarot", "Domination"},
praenomen = {"Corpus", "Mentis", "Sanguis"},
archivist = {"Geometrics", "Numerology", "Bioessence"},
teradrim = {"Terramancy", "Animation", "Desiccation"},
luminary = {"Spirituality", "Devotion", "Illumination"},
sentinel = {"Dhuriv", "Woodlore", "Tracking"},
shaman = {"Primality", "Shamanism", "Naturalism"},
monk = {"Kaido", "Kai", "Tekura", "Telepathy"},
syssin = {"Assassination", "Subterfuge", "Hypnosis"},
shifter = {"Ferality", "Shapeshifting", "Vocalizing"},
wayfarer = {"Tenacity", "Wayfaring", "Fury"},
carnifex = {"Savagery", "Deathlore", "Warhounds", "Warding", "Ancestry", "Communion",},
templar = {"Battlefury", "Righteousness", "Bladefire", "Riving", "Manifestation", "Chirography", },
zealot = {"Zeal", "Purification", "Psionics"},
}
rime.curing.last_ate = "nothing"

rime.curing.hidden_affs = {
		["bedazzle"] = {
			"vomiting",
			"stuttering",
			"blurry_vision",
			"dizziness",
			"weariness",
			"laxity",
			},
		["shatter"] = {
			"dizziness",
			"stupidity",
			"dementia",
			"confusion",
			},
		["shapes"] = {
			"laxity",
			"lovers_effect",
			"peace",
			"magnanimity",
			"dizziness",
			"faintness",
			"epilepsy",
			"shyness",
			"merciful",
			"masochism",
			"berserking",
			"recklessness",
			},
		["staticburst"] = {
			"egocentric",
			"stupidity",
			"anorexia",
			"epilepsy",
			"peace",
			"paranoia",
			"hallucinations",
			"dizziness",
			"indifference",
			"berserking",
			"pacifism",
			"lovers_effect",
			"laxity",
			"hatred",
			"generosity",
			"claustrophobia",
			"vertigo",
			"faintness",
			"loneliness",
			"agoraphobia",
			"masochism",
			"recklessness",
			"weariness",
			"impatience",
			"confusion",
			"dementia",
			"nyctophobia",
		},
		["loki_pet"] = {
			"paresis",
			"clumsiness",
			"slickness",
			"vomiting",
			"sensitivity",
			"stupidity",
			"anorexia",
			"asthma",
			"recklessness",
			},
		["pestilence"] = {
			"vomiting",
			"allergies",
			"recklessness",
			"masochism",
			"epilepsy",
			"mirroring",
			},
		["changeheart"] = {
			"indifference",
			"hatred",
			"pacifism",
			},
		["plague"] = {
			"confusion",
			"weariness",
			"superstition",
			"vomiting",
			"recklessness",
			"epilepsy",
			"paresis",
			"anorexia",
			},
		["howls"] = {
			"fear",
			"amnesia",
			"no_deaf",
			"paresis",
			"sensitivity",
			"anorexia",
			"stupidity",
			"claustrophobia",
			"impairment",
			"recklessness",
			"plodding",
			"blurry_vision",
			"disrupted",
			"weariness",
			"lethargy",
			"berserking",
			"vomiting",
			"hatred",
			"confusion",
			},
		["moon"] = {
			"stupidity",
			"confusion",
			"recklessness",
			"impatience",
			"epilepsy",
			"berserking",
			"anorexia",
			"weariness",
			},
		["sun"] = {
			"paresis",
			"clumsiness",
			"asthma",
			"vomiting",
			"lethargy",
			"superstition",
			"sensitivity",
			"hypersomnia",
			},
		["loki"] = {
			"paresis",
			"right_leg_broken",
			"right_arm_broken",
			"left_leg_broken",
			"left_arm_broken",
			"shyness",
			"allergies",
			"stuttering",
			"deadening",
			"dizziness",
			"squelched",
			"thin_blood",
			"weariness",
			"peace",
			"haemophilia",
			"disfigurement",
			"voyria",
			"clumsiness",
			"slickness",
			"vomiting",
			"sensitivity",
			"stupidity",
			"anorexia",
			"asthma",
			"recklessness",
			"asleep",
			"blind",
			"deaf",
			"blurry_vision",
			"deadening",
			},
		["shine"] = {
			"stiffness",
			"disfigurement",
			"weariness",
			"dizziness",
			"ablaze",
			},
		["spiritwrack"] = {
			"anorexia",
			"stupidity",
			"impatience",
			"vertigo",
			"sensitivity",
			"selfpity",
			"berserking",
			"migraine",
			},
		["swelter"] = {
			"dizziness",
			"anorexia",
			"weariness",
			"vertigo",
			},
		["whip"] = {
			"sensitivity",
			"stupidity",
			"dizziness",
			"epilepsy",
			"recklessness",
			},
		["scourge"] = {
			"dizziness",
			"nyctophobia",
			"confusion",
			"dementia",
			},
		["chasten"] = {
			"anorexia",
			"dementia",
			"hypochondria",
			"lethargy",
			"loneliness",
			"masochism",
			"paranoia",
			"recklessness",
			"stupidity",
			"accursed",
			},
		["cougarspirit"] = {
            "impairment",
            "blurry_vision",
            "clumsiness",
            },
        ["blood_curse"] = {
            "confusion",
            "fear",
            "impatience",
            "paranoia",
            "stupidity",
            "agoraphobia",
            "masochism",
            "loneliness",
            "seduction",
            "epilepsy",
            "anorexia",
            "amnesia",
            "peace",
            "dementia",
            "berserking",
            "indifference",
            "vertigo",
            "temptation",
            "recklessness",
            },
        ["inferno"] = {
            "recklessness",
            "confusion",
            "stupidity",
            "indifference",
            "anorexia",
            "dementia",
        },
        ["blossom"] = {
            "paresis",
            "clumsiness",
            "vomiting",
            "weariness",
            "asthma",
            "haemophilia",
        },

}

rime.curing.tried = {
	["pill"] = "nothing",
	["poultice"] = "nothing",
	["pipe"] = "nothing",
	["focus"] = "nothing",
	["elixir"] = "nothing",
}

rime.curing["limbs"] = {
	["right_arm"] = tonumber(0),
	["left_arm"] = tonumber(0),
	["right_leg"] = tonumber(0),
	["left_leg"] = tonumber(0),
	["head"] = tonumber(0),
	["torso"] = tonumber(0),
	["threshhold"] = tonumber(1000),
}

rime.curing["queue"] = {
	["pill"] = "nothing",
	["poultice"] = "nothing",
	["pipe"] = "nothing",
	["sip"] = "nothing",
	["anabiotic"] = "nothing",
}



rime.curing["curesByAff"] = {
	["impairment"] = "eat decongestant",
	["insulation"] = "press caloric",
	["ice_encased"] = "press caloric",
	["rebounding"] = "smoke reishi",
	["deaf"] = "eat ototoxin",
	["blind"] = "eat amaurosis",
	["ablaze"] = "press mending to torso",
	["addiction"] = "eat antipsychotic",
	["aeon"] = "smoke willow",
	["agoraphobia"] = "eat depressant",
	["amnesia"] = "relax",
	["anorexia"] = "press epidermal to torso",
	["asleep"] = "wake",
	["asthma"] = "eat decongestant",
	["attuned"] = "none",
	["backstrain"] = "press soothing to torso",
	["baldness"] = "eat decongestant",
	["battle_hunger"] = "none",
	["berserking"] = "eat depressant",
	["blackout"] = "none",
	["blighted"] = "eat antipsychotic",
	["blisters"] = "eat opiate",
	["blood_curse"] = "eat antipsychotic",
	["blood_poison"] = "eat decongestant",
	["bloodlust"] = "none",
	["blurry_vision"] = "press epidermal to head",
	["body_odor"] = "eat coagulation",
	["burnt_eyes"] = "press epidermal to head",
	["resonance"] = "none",
	["burnt_skin"] = "press restoration to torso",
	["broken_legs"] = "press mending to legs",
	["broken_arms"] = "press mending to arms",
	["broken_any"] = "press mending",
	["claustrophobia"] = "eat depressant",
	["clumsiness"] = "eat decongestant",
	["collapsed_lung"] = "press restoration to torso",
	["commitment_fear"] = "eat depressant",
	["confusion"] = "eat antipsychotic",
	["conviction"] = "none",
	["cracked_ribs"] = "press mending to torso",
	["crushed_chest"] = "press restoration to torso",
	["crippled"] = "eat opiate",
	["crippled_body"] = "eat opiate",
	["crippled_throat"] = "press mending to head",
	["chest"] = "press restoration to torso",
	["dazed"] = "recoup",
	["deadening"] = "smoke willow",
	["deepwound"] = "press restoration to torso",
	["dementia"] = "eat antipsychotic",
	["density"] = "press mass",
	["destroyed_throat"] = "press mending to head",
	["disfigurement"] = "smoke yarrow",
	["disrupted"] = "concentrate",
	["dissonance"] = "eat euphoriant",
	["disturb_confidence"] = "none",
	["disturb_impulse"] = "none",
	["disturb_inhibition"] = "none",
	["disturb_sanity"] = "none",
	["dizziness"] = "eat euphoriant",
	["blood"] = "press epidermal to torso",
	["phlegm"] = "press epidermal to torso",
	["yellowbile"] = "press epidermal to torso",
	["emberbrand"] = "none",
	["effused_blood"] = "press epidermal to torso",
	["epilepsy"] = "eat euphoriant",
	["exhausted"] = "eat coagulation",
	["faintness"] = "eat euphoriant",
	["fear"] = "compose",
	["forestbrand"] = "none",
	["frozen"] = "press caloric to torso",
	["frozenfeet"] = "none",
	["generosity"] = "eat steroid",
	["gorged"] = "press epidermal to torso",
	["writhe_grappled"] = "writhe from grapple",
	["writhe_gunk"] = "writhe from gunk",
	["haemophilia"] = "eat coagulation",
	["hallucinations"] = "eat antipsychotic",
	["hatred"] = "eat antipsychotic",
	["head_bruised"] = "press mending to head",
	["head_bruised_critical"] = "press mending to head",
	["head_bruised_moderate"] = "press mending to head",
	["head_damaged"] = "press restoration to head",
	["head_mangled"] = "press restoration to head",
	["heartflutter"] = "eat opiate",
	["heatspear"] = "press restoration to torso",
	["hellsight"] = "smoke willow",
	["hepafarin"] = "none",
	["hubris"] = "eat steroid",
	["hypersomnia"] = "eat antipsychotic",
	["hypochondria"] = "eat decongestant",
	["hypothermia"] = "press caloric to torso",
	["idiocy"] = "eat anabiotic",
	["impatience"] = "eat euphoriant",
	["indifference"] = "press epidermal to head",
	["instawake"] = "eat stimulant",
	["infested"] = "eat euphoriant",
	["justice"] = "eat steroid",
	["muscle_spasms"] = "press soothing to torso",
	["patterns"] = "eat panacea",
	["pre_restore_left_arm"] = "press restoration to left arm",
	["pre_restore_head"] = "press restoration to head",
	["pre_restore_right_leg"] = "press restoration to right leg",
	["pre_restore_left_leg"] = "press restoration to left leg",
	["pre_restore_torso"] = "press restoration to torso",
	["pre_restore_right_arm"] = "press restoration to right arm",
	["left_arm_amputated"] = "press restoration to left arm",
	["left_arm_broken"] = "press mending to left arm",
	["left_arm_bruised"] = "press mending to left arm",
	["left_arm_bruised_critical"] = "press mending to left arm",
	["left_arm_bruised_moderate"] = "press mending to left arm",
	["left_arm_damaged"] = "press restoration to left arm",
	["left_arm_dislocated"] = "press mending to left arm",
	["left_arm_mangled"] = "press restoration to left arm",
	["left_arm_missing"] = "none",
	["left_arm_numbed"] = "none",
	["lightwound"] = "press mending to torso",
	["right_arm_amputated"] = "press restoration to right arm",
	["right_arm_broken"] = "press mending to right arm",
	["right_arm_bruised"] = "press mending to right arm",
	["right_arm_bruised_critical"] = "press mending to right arm",
	["right_arm_bruised_moderate"] = "press mending to right arm",
	["right_arm_damaged"] = "press restoration to right arm",
	["right_arm_dislocated"] = "press mending to right arm",
	["right_arm_mangled"] = "press restoration to right arm",
	["right_arm_missing"] = "none",
	["right_arm_numbed"] = "none",
	["left_leg_amputated"] = "press restoration to left leg",
	["left_leg_broken"] = "press mending to left leg",
	["left_leg_bruised"] = "press mending to left leg",
	["left_leg_bruised_critical"] = "press mending to left leg",
	["left_leg_bruised_moderate"] = "press mending to left leg",
	["left_leg_damaged"] = "press restoration to left leg",
	["left_leg_dislocated"] = "press mending to left leg",
	["left_leg_mangled"] = "press restoration to left leg",
	["left_leg_missing"] = "none",
	["left_leg_numbed"] = "none",
	["right_leg_amputated"] = "press restoration to right leg",
	["right_leg_broken"] = "press mending to right leg",
	["right_leg_bruised"] = "press mending to right leg",
	["right_leg_bruised_critical"] = "press mending to right leg",
	["right_leg_bruised_moderate"] = "press mending to right leg",
	["right_leg_damaged"] = "press restoration to right leg",
	["right_leg_dislocated"] = "press mending to right leg",
	["right_leg_mangled"] = "press restoration to right leg",
	["right_leg_missing"] = "none",
	["right_leg_numbed"] = "none",
	["torso_bruised_critical"] = "press mending to torso",
	["torso_bruised_moderate"] = "press mending to torso",
	["torso_bruised"] = "press mending to torso",
	["torso_damaged"] = "press restoration to torso",
	["torso_mangled"] = "press restoration to torso",
	["torso_elevation"] = "press restoration to torso",
	["fire_elevation"] = "press mending to torso",
	["laxity"] = "eat steroid",
	["lethargy"] = "eat coagulation",
	["lifebane"] = "none",
	["limp_veins"] = "eat steroid",
	["loneliness"] = "eat depressant",
	["lovers_effect"] = "eat steroid",
	["magnanimity"] = "eat steroid",
	["masochism"] = "eat depressant",
	["mauled_face"] = "press restoration to head",
	["mental_disruption"] = "eat coagulation",
	["mental_fatigue"] = "none",
	["merciful"] = "eat depressant",
	["migraine"] = "smoke yarrow",
	["mindclamped"] = "none",
	["mirroring"] = "eat opiate",
	["mistbrand"] = "none",
	["mob_impaled"] = "writhe",
	["muddled"] = "none",
	["numb_arms"] = "none",
	["nyctophobia"] = "eat depressant",
	["oiled"] = "scrub",
	["omen"] = "none",
	["patterns"] = "eat panacea",
	["paralysis"] = "eat opiate",
	["pacifism"] = "eat steroid",
	["paranoia"] = "eat antipsychotic",
	["paresis"] = "eat opiate",
	["peace"] = "eat steroid",
	["penance"] = "none",
	["petrified"] = "none",
	["physical_disruption"] = "eat coagulation",
	["plodding"] = "eat anabiotic",
	["premonition"] = "none",
	["quicksand"] = "none",
	["recklessness"] = "eat depressant",
	["rend"] = "eat coagulation",
	["resin_glauxe"] = "none",
	["ringing_ears"] = "eat decongestant",
	["ripped_groin"] = "none",
	["ripped_spleen"] = "none",
	["ripped_throat"] = "none",
	["sadness"] = "eat antipsychotic",
	["sandrot"] = "eat opiate",
	["squelched"] = "smoke yarrow",
	["selarnia"] = "press mending to torso",
	["selfpity"] = "eat euphoriant",
	["sensitivity"] = "eat decongestant",
	["shaderot_benign"] = "eat panacea",
	["shaderot_body"] = "eat panacea",
	["shaderot_heat"] = "eat panacea",
	["shaderot_spirit"] = "eat panacea",
	["shaderot_wither"] = "eat panacea",
	["shadowcoat"] = "none",
	["shadowbrand"] = "none",
	["shivering"] = "press caloric to torso",
	["shyness"] = "eat euphoriant",
	["slickness"] = "smoke yarrow",
	["slickness2"] = "eat opiate",
	["smashed_throat"] = "press restoration to head",
	["sore_wrist"] = "press soothing to arms",
	["sore_ankle"] = "press soothing to legs",
	["soul_poison"] = "none",
	["agony"] = "eat steroid",
	["accursed"] = "eat steroid",
	["spinal_rip"] = "press restoration to torso",
	["spiritbane"] = "none",
	["spiritbrand"] = "none",
	["stiffness"] = "press soothing to torso",
	["stonebrand"] = "none",
	["stonevice"] = "none",
	["stormtouched"] = "panacea",
	["stun"] = "none",
	["stupidity"] = "eat euphoriant",
	["stuttering"] = "press epidermal to head",
	["allergies"] = "eat coagulation",
	["superstition"] = "eat steroid",
	["thin_blood"] = "eat coagulation",
	["thorns"] = "none",
	["writhe_transfix"] = "writhe from transfix",
	["troubledbreathing"] = "none",
	["unconscious"] = "none",
	["vertigo"] = "eat depressant",
	["vinethorns"] = "pull thorn from body",
	["vitalbane"] = "none",
	["vomiting"] = "eat coagulation",
	["wasting"] = "eat coagulation",
	["weak_grip"] = "press soothing to arms",
	["weariness"] = "eat decongestant",
	["windbrand"] = "none",
	["withering"] = "smoke yarrow",
	["whiplash"] = "press soothing to head",
	["worrywart"] = "eat eucrasia",
	["writhe_armpitlock"] = "writhe from armpitlock",
	["writhe_bind"] = "writhe from bind",
	["writhe_impaled"] = "writhe from impale",
	["writhe_necklock"] = "writhe from necklock",
	["writhe_ropes"] = "writhe from ropes",
	["writhe_thighlock"] = "writhe from thighlock",
	["writhe_vines"] = "writhe from vines",
	["writhe_web"] = "writhe from web",
	["mob_impaled"] = "writhe",
	["writhe_stasis"] = "writhe",
	["voyria"] = "sip immunity",
	["levitation"] = "sip levitation",
	["venom_resistance"] = "sip antivenin",
	["speed"] = "sip speed",
	["waterbreathing"] = "eat waterbreathing",
	["yellowbile"] = "press epidermal to torso",
	["void"] = "press caloric",
	["voidgaze"] = "press restoration to head",
	["weakvoid"] = "press caloric",
	["gloom"] = "press epidermal to head",
	
}

rime.curing["affsByType"] = {
	["herb"]= {
		"addiction",
		"deaf",
		"blind",
		"agoraphobia",
		"asthma",
		"baldness",
		"berserking",
		"blood_curse",
		"blood_poison",
		"body_odor",
		"claustrophobia",
		"clumsiness",
		"commitment_fear",
		"confusion",
		"crippled",
		"crippled_body",
		"dementia",
		"dissonance",
		"dizziness",
		"epilepsy",
		"generosity",
		"faintness",
		"haemophilia",
		"hallucinations",
		"hatred",
		"blighted",
		"infested",
		"heartflutter",
		"hubris",
		"hypersomnia",
		"hypochondria",
		"impatience",
		"impairment",
		"justice",
		"lethargy",
		"limp_veins",
		"loneliness",
		"lovers_effect",
		"magnanimity",
		"masochism",
		"mental_disruption",
		"merciful",
		"nyctophobia",
		"patterns",
		"pacifism",
		"paralysis",
		"paresis",
		"paranoia",
		"peace",
		"physical_disruption",
		"ringing_ears",
		"recklessness",
		"rend",
		"sadness",
		"sandrot",
		"selfpity",
		"sensitivity",
		"shyness",
		"accursed",
		"agony",
		"stormtouched",
		"stupidity",
		"superstition",
		"allergies",
		"thin_blood",
		"vertigo",
		"vomiting",
		"weariness",
		"waterbreathing",
		"worrywart",
		},

	["poultice"] = {
		"pre_restore_right_arm",
		"pre_restore_left_arm",
		"pre_restore_head",
		"pre_restore_right_leg",
		"pre_restore_left_leg",
		"pre_restore_torso",
		"left_arm_amputated",
		"left_arm_broken",
		"left_arm_bruised",
		"left_arm_bruised_critical",
		"left_arm_bruised_moderate",
		"left_arm_damaged",
		"left_arm_dislocated",
		"left_arm_mangled",
		"left_arm_missing",
		"left_arm_numbed",
		"left_leg_amputated",
		"broken_arms",
		"broken_legs",
		"broken_any",
		"left_leg_broken",
		"left_leg_bruised",
		"left_leg_bruised_critical",
		"left_leg_bruised_moderate",
		"left_leg_damaged",
		"left_leg_dislocated",
		"left_leg_mangled",
		"left_leg_numbed",
		"right_arm_amputated",
		"right_arm_broken",
		"right_arm_bruised",
		"right_arm_bruised_critical",
		"right_arm_bruised_moderate",
		"right_arm_damaged",
		"right_arm_dislocated",
		"right_arm_mangled",
		"right_arm_missing",
		"right_arm_numbed",
		"right_leg_amputated",
		"right_leg_broken",
		"right_leg_bruised",
		"right_leg_bruised_critical",
		"right_leg_bruised_moderate",
		"right_leg_damaged",
		"right_leg_dislocated",
		"right_leg_mangled",
		"right_leg_numbed",
		"right_leg_amputated",
		"right_leg_broken",
		"right_leg_bruised",
		"right_leg_bruised_critical",
		"right_leg_bruised_moderate",
		"right_leg_damaged",
		"right_leg_dislocated",
		"right_leg_mangled",
		"right_leg_missing",
		"right_leg_numbed",
		"right_leg_amputated",
		"right_leg_broken",
		"right_leg_bruised",
		"right_leg_bruised_critical",
		"right_leg_bruised_moderate",
		"right_leg_damaged",
		"right_leg_dislocated",
		"right_leg_mangled",
		"right_leg_numbed",
 		"left_leg_amputated",
		"left_leg_broken",
		"left_leg_bruised",
		"head_bruised",
		"head_bruised_critical",
		"head_bruised_moderate",
		"head_damaged",
		"head_mangled",
		"heatspear",
		"anorexia",
		"blurry_vision",
		"burnt_eyes",
		"cracked_ribs",
		"crippled_throat",
		"crushed_chest",
		"destroyed_throat",
		"blood",
		"phlegm",
		"yellowbile",
		"frozen",
		"ice_encased",
		"gorged",
		"indifference",
		"mauled_face",
		"selarnia",
		"shivering",
		"density",
		"insulation",
		"smashed_throat",
		"spinal_rip",
		"stuttering",
		"effused_blood",
		"yellowbile",
		"burnt_skin",
		"void",
		"weakvoid",
		"hypothermia",
		"torso_elevation",
		"fire_elevation",
		"whiplash",
		"backstrain",
		"muscle_spasms",
		"stiffness",
		"sore_ankle",
		"sore_wrist",
		"weak_grip",
	},
	["pipe"] = {
		"deadening",
		"withering",
		"disfigurement",
		"slickness",
		"aeon",
		"migraine",
		"squelched",
		"hellsight",
		},
	["elixir"] = {
		"voyria",
		"levitation",
		"venom_resistance",
		"temperance",
		},
	["tree"] = {
		"itchy",
		"ablaze",
		"addiction",
		"agoraphobia",
		"anorexia",
		"asthma",
		"belonephobia",
		"berserking",
		"blighted",
		"blood_curse",
		"blood_poison",
		"blurry_vision",
		"broken_arms",
		"broken_legs",
		"broken_any",
		"claustrophobia",
		"clumsiness",
		"commitment_fear",
		"confusion",
		"cracked_ribs",
		"crippled",
		"crippled_body",
		"crippled_throat",
		"dementia",
		"dissonance",
		"dizziness",
		"epilepsy",
		"faintness",
		"frozen",
		"generosity",
		"gorged",
		"haemophilia",
		"hallucinations",
		"hatred",
		"heartflutter",
		"hiddenanxiety",
		"hypersomnia",
		"hypochondria",
		"impatience",
		"indifference",
		"infested",
		"justice",
		"left_arm_broken",
		"left_arm_dislocated",
		"left_leg_broken",
		"left_leg_dislocated",
		"lethargy",
		"limp_veins",
		"loki",
		"loneliness",
		"lovers_effect",
		"magnanimity",
		"masochism",
		"mental_disruption",
		"merciful",
		"mirroring",
		"nyctophobia",
		"patterns",
		"pacifism",
		"paralysis",
		"paranoia",
		"paresis",
		"peace",
		"physical_disruption",
		"recklessness",
		"rend",
		"right_arm_broken",
		"right_arm_dislocated",
		"right_leg_broken",
		"right_leg_dislocated",
		"sandrot",
		"selarnia",
		"sensitivity",
		"shivering",
		"shyness",
		"slickness",
		"stupidity",
		"stuttering",
		"allergies",
		"superstition",
		"thin_blood",
		"vertigo",
		"vomiting",
		"weariness"
	},
	["renew"] = {
		"addiction",
		"agoraphobia",
		"asthma",
		"berserking",
		"blood_curse",
		"blood_poison",
		"claustrophobia",
		"clumsiness",
		"confusion",
		"crippled",
		"crippled_body",
		"dementia",
		"dissonance",
		"dizziness",
		"epilepsy",
		"faintness",
		"generosity",
		"haemophilia",
		"hallucinations",
		"hatred",
		"heartflutter",
		"hypersomnia",
		"hypochondria",
		"impatience",
		"justice",
		"lethargy",
		"limp_veins",
		"loneliness",
		"lovers_effect",
		"magnanimity",
		"magicimpaired",
		"masochism",
		"mental_disruption",
		"merciful",
		"nyctophobia",
		"patterns",
		"pacifism",
		"paranoia",
		"peace",
		"physical_disruption",
		"recklessness",
		"rend",
		"sandrot",
		"selfpity",
		"sensitivity",
		"shyness",
		"stupidity",
		"allergies",
		"thin_blood",
		"vertigo",
		"vomiting",
		"weariness",
		"burning",
		"anorexia",
		"belonephobia",
		"blurry_vision",
		"burnt_eyes",
		"cracked_ribs",
		"crippled_throat",
		"destroyed_throat",
		"gorged",
		"indifference",
		"left_arm_broken",
		"left_leg_broken",
		"right_arm_broken",
		"right_leg_broken",
		"selarnia",
		"shivering",
		"smasheded_throat", 
		"stuttering",
		"superstition",
		"throatclaw",
		"deadening",
		"withering",
		"disfigurement",
		"slickness",
		"hellsight"
	},
	["focus"] = {
		"egocentric",
		"stupidity",
		"anorexia",
		"epilepsy",
		"mirroring",
		"mental_disruption",
		"peace",
		"paranoia",
		"hallucinations",
		"dizziness",
		"indifference",
		"berserking",
		"pacifism",
		"lovers_effect",
		"laxity",
		"hatred",
		"generosity",
		"claustrophobia",
		"vertigo",
		"faintness",
		"loneliness",
		"agoraphobia",
		"masochism",
		"recklessness",
		"weariness",
		"confusion",
		"dementia",
		"nyctophobia",
		"premonition"
	},
	["writhe"] = {
		"mob_impaled",
		"writhe_vines",
		"writhe_impaled",
		"writhe_grappled",
		"writhe_web",
		"writhe_armpitlock",
		"writhe_necklock",
		"writhe_thighlock",
		"writhe_feed",
		"writhe_transfix",
		"writhe_bind",
		"writhe_noose",
		"writhe_ropes",
		"writhe_stasis",
		"writhe_gunk",
	},

	["special"] = {
		"speed",
		"disrupted",
		"dazed",
		"fear",
		"asleep",
	},
	
	["physical"] = {
		"paresis",
		"paralysis",
		"left_leg_broken",
		"left_arm_broken",
		"broken_arms",
		"right_leg_broken",
		"right_arm_broken",
		"broken_legs",
		"broken_any",
		"haemophilia",
		"hypochondria",
		"asthma",
		"impairment",
		"clumsiness",
		"vomiting",
		"sensitivity",
		"ringing_ears",
		"limp_veins",
		"lethargy",
		"blood_poison",
		"blood_curse",
		"crippled_throat",
		"sandrot",
		"disfigurement",
		"ablaze",
		"hypothermia",
		"shivering",
		"frozen",
		"rend",
		"exhausted",
		"blisters",
		"allergies",
		"addiction",
		"hypersomnia",
		"heartflutter",
		"burnt_eyes",
		"blurry_vision",
		"migraine",
		"deadening",
		"physical_disruption"
	}
		
}

rime.curing["affsByCure"] = {
	["stimulant"] = {
		"instawake",
	},
	["waterbreathing"] = {
		"waterbreathing",
	},
	["amaurosis"] = {
		"blind",
	},
	["ototoxin"] = {
		"deaf",
	},
	["euphoriant"] = {
		"selfpity",
		"stupidity",
		"dizziness",
		"faintness",
		"shyness",
		"epilepsy",
		"impatience",
		"dissonance",
		"infested"
	},
	["eucrasia"] = {
		"worrywart",
	},
	["antipsychotic"] = {
		"sadness",
		"confusion",
		"dementia",
		"hallucinations",
		"paranoia",
		"hatred",
		"addiction",
		"hypersomnia",
		"blood_curse",
		"blighted"
	},
	["decongestant"] = {
		"baldness",
		"clumsiness",
		"hypochondria",
		"weariness",
		"asthma",
		"sensitivity",
		"ringing_ears",
		"impairment",
		"blood_poison",
	},
	["depressant"] = {
		"commitment_fear",
		"merciful",
		"recklessness",
		"masochism",
		"agoraphobia",
		"loneliness",
		"berserking",
		"vertigo",
		"claustrophobia",
		"nyctophobia",
	},
	["coagulation"] = {
		"body_odor",
		"lethargy",
		"allergies",
		"mental_disruption",
		"physical_disruption",
		"vomiting",
		"exhausted",
		"thin_blood",
		"rend",
		"haemophilia",
	},
	["panacea"] = {
		"stormtouched",
		"patterns",
		"shaderot_body",
		"shaderot_wither",
		"shaderot_heat",
		"shaderot_spirit",
		"shaderot_benign",
	},
	["steroid"] = {
		"hubris",
		"pacifism",
		"peace",
		"accursed",
		"agony",
		"limp_veins",
		"lovers_effect",
		"laxity",
		"superstition",
		"generosity",
		"justice",
		"magnanimity",
	},
	["opiate"] = {
		"paresis",
		"paralysis",
		"mirroring",
		"crippled_body",
		"crippled",
		"blisters",
		"slickness2",
		"heartflutter",
		"sandrot",
	},
	["anabiotic"] = {
		"plodding",
		"idiocy",
	},
	["yarrow"] = {
		"slickness",
		"withering",
		"disfigurement",
		"migraine",
		"squelched",
	},
	["willow"] = {
		"aeon",
		"hellsight",
		"deadening",
	},
	["reishi"] = {
		"rebounding",
	},
	["immunity"] = {
		"voyria",
	},
	["speed"] = {
		"speed",
	},
	["antivenin"] = {
		"venom_resistance",
	},
	["levitation"] = {
		"levitation",
	},
	["frost"] = {
		"temperance",
	},

	["soothingskin"] = {
		"whiplash",
		"backstrain",
		"muscle_spasms",
		"stiffness",
		"sore_wrist",
		"weak_grip",
		"sore_ankle",
	},
	["soothinghead"] = {
		"whiplash",
	},
	["soothingtorso"] = {
		"backstrain",
		"muscle_spasms",
		"stiffness",
	},
	["soothingarms"] = {
		"sore_wrist",
		"weak_grip",
	},
	["soothinglegs"] = {
		"sore_ankle",
	},
	["epidermalskin"] = {
		"indifference",
		"stuttering",
		"blurry_vision",
		"burnt_eyes",
		"anorexia",
		"gorged",
		"effused_blood",
		"blind",
		"gloom",
		"deaf",
	},
	["epidermalhead"] = {
		"indifference",
		"stuttering",
		"blurry_vision",
		"burnt_eyes",
		"blind",
		"gloom",
		"deaf",
	},
	["epidermaltorso"] = {
		"anorexia",
		"gorged",
		"effused_blood",
	},
	["restorationhead"] = {
		"mauled_face",
		"head_mangled",
		"head_damaged",
		"smashed_throat",
		"voidgaze",
		"pre_restore_head",
	},
	["restorationtorso"] = {
		"collapsed_lung",
		"spinal_rip",
		"burnt_skin",
		"torso_mangled",
		"torso_damaged",
		"crushed_chest",
		"heatspear",
		"deepwound",
		"pre_restore_torso",
	},
	["restorationright arm"] = {
		"right_arm_amputated",
		"right_arm_mangled",
		"right_arm_damaged",
		"pre_restore_right_arm",
	},
	["restorationright leg"] = {
		"right_leg_amputated",
		"right_leg_mangled",
		"right_leg_damaged",
		"pre_restore_right_leg",
	},
	["restorationleft arm"] = {
		"left_arm_amputated",
		"left_arm_mangled",
		"left_arm_damaged",
		"pre_restore_left_arm",
	},
	["restorationleft leg"] = {
		"left_leg_amputated",
		"left_leg_mangled",
		"left_leg_damaged",
		"pre_restore_left_leg",
	},
	["mendinghead"] = {
		"head_bruised_critical",
		"destroyed_throat",
		"crippled_throat",
		"head_bruised_moderate",
		"head_bruised",
	},
	["mendingtorso"] = {
		"torso_bruised_critical",
		"lightwound",
		"ablaze",
		"cracked_ribs",
		"torso_bruised_moderate",
		"torso_bruised",
	},
	["mendingleft leg"] = {
		"left_leg_bruised_critical",
		"left_leg_broken",
		"left_leg_bruised_moderate",
		"left_leg_bruised",
		"left_leg_dislocated",
	},
	["mendingleft arm"] = {
		"left_arm_bruised_critical",
		"left_arm_broken",
		"left_arm_bruised_moderate",
		"left_arm_bruised",
		"left_arm_dislocated",
	},
	["mendingright leg"] = {
		"right_leg_bruised_critical",
		"right_leg_broken",
		"right_leg_bruised_moderate",
		"right_leg_bruised",
		"right_leg_dislocated",
	},
	["mendingright arm"] = {
		"right_arm_bruised_critical",
		"right_arm_broken",
		"right_arm_bruised_moderate",
		"right_arm_bruised",
		"right_arm_dislocated",
	},
	["mendingarms"] = {
		"right_arm_bruised_critical",
		"right_arm_broken",
		"right_arm_bruised_moderate",
		"right_arm_bruised",
		"right_arm_dislocated",
		"left_arm_bruised_critical",
		"left_arm_broken",
		"left_arm_bruised_moderate",
		"left_arm_bruised",
		"left_arm_dislocated",
	},
	["mendinglegs"] = {
		"right_leg_bruised_critical",
		"right_leg_broken",
		"right_leg_bruised_moderate",
		"right_leg_bruised",
		"right_leg_dislocated",
		"left_leg_bruised_critical",
		"left_leg_broken",
		"left_leg_bruised_moderate",
		"left_leg_bruised",
		"left_leg_dislocated",
	},
	--#Danger
	["mendingskin"] = {
		"head_bruised_critical",
		"destroyed_throat",
		"crippled_throat",
		"head_bruised_moderate",
		"head_bruised",
		"torso_bruised_critical",
		"lightwound",
		"ablaze",
		"cracked_ribs",
		"torso_bruised_moderate",
		"torso_bruised",
		"left_arm_bruised_critical",
		"left_arm_broken",
		"left_arm_bruised_moderate",
		"left_arm_bruised",
		"left_arm_dislocated",
		"right_arm_bruised_critical",
		"right_arm_broken",
		"right_arm_bruised_moderate",
		"right_arm_bruised",
		"right_arm_dislocated",
		"left_leg_bruised_critical",
		"left_leg_broken",
		"left_leg_bruised_moderate",
		"left_leg_bruised",
		"left_leg_dislocated",
		"right_leg_bruised_critical",
		"right_leg_broken",
		"right_leg_bruised_moderate",
		"right_leg_bruised",
		"right_leg_dislocated",
	},
}
