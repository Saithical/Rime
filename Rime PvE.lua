function rime.pve.bash_attack()

	local class = gmcp.Char.Status.class
	local sep = rime.saved.separator
	local que = rime.pvp.queue_handle()
	local pre = ""
	local action = ""
	local mount = false
	local name = gmcp.Char.Status.name
	local agroCount = 0
	for k,v in pairs(rime.pve.mobs) do
		if v.icon == "monster" or string.find(v.name, "slaver") then
			agroCount = agroCount+1
		end
		if v.name == "a foul spiderling" then
			agroCount = agroCount-1
		end
		if v.name == "a vast ochre ooze" then
			agroCount = agroCount+4
		end
		if string.find(v.name, "eld") then agroCount=agroCount-1 end
	end
	
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "the Bloodwood" then pre = "get essence" end
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "Xaanhal" then pre = "get fragment" end
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "the Shattered Vortex" then pre = "get piece" end
	if not has_def("vigor") then pre = "drink vigor" .. sep .. pre end
	if agroCount >= 4 then pre = pre .. sep .. "blow horn" end
	if string.len(pre) > 3 then action = pre end
	if rime.pve.counter then
		action = "soul shield"
	elseif class == "Praenomen" then
		action = "frenzy "..rime.target
	elseif class == "Syssin" then
		if has_def("hiding") or has_def("phased") then
			action = "quickwield right dirk" .. sep .. "backstab "..rime.target
		else
			action = "quickwield right whip" .. sep .. "garrote "..rime.target
		end
    elseif class == "Teradrim" then
        if rime.vitals.percent_health <= 50 then
            local defenseAction = "blow horn"..sep.."sand shield"
          if has_def("shielded") then
            defenseAction = "blow horn"..sep.."golem recover"
          end
          if rime.vitals.percent_health <= 30 then
            defenseAction = "blow horn"..sep.."touch crystal"..sep..defenseAction
          end
          if rime.vitals.current_health < rime.vitals.current_mana and rime.vitals.current_mana > 4500 then
            action = "blow horn"..sep.."shift"
          else
            action = defenseAction
          end
        else
            action = "earth momentum" .. sep .. "earth batter "..rime.target .. sep .. "golem recover"
        end
	elseif class == "Shapeshifter" then
		action = "combo "..rime.target.." slash slash"
	elseif class == "Sentinel" then
		action = "dhuriv combo "..rime.target.." crosscut thrust"
	elseif class == "Carnifex" then
		if rime.vitals.percent_health <= 50 then
			local defenseAction = "blow horn"..sep.."soul shield"
			if gmcp.Room.Info.area == "the forgotten depths of Mount Helba" then
				defenseAction = "blow horn"..sep.."soul consume for health"
			end
			if has_def("shielded") then
				defenseAction = "blow horn"..sep.."soul consume for health"
			end
			if rime.vitals.percent_health <= 30 then
				defenseAction = "blow horn"..sep.."touch crystal"..sep..defenseAction
			end
			if rime.vitals.current_health < rime.vitals.current_mana and rime.vitals.current_mana > 4500 then
				action = "blow horn"..sep.."shift"
			else
				action = defenseAction
			end
		elseif rime.pve.need_ents then
			action = "hound whistle all"
		elseif not rime.pve.openings then
			action = "hound openings"
		else
			action = "furor"..sep.."pole spinslash "..rime.target
		end
	elseif class == "Indorani" then
		action = "flick bonedagger at "..rime.target
	elseif class == "Archivist" then
		action = "incite crux "..rime.target
	elseif class == "Sciomancer" then
        if rime.vitals.percent_health <= 60 then
            local defenseAction = "cast reflection"

            if rime.vitals.percent_health <= 50 then
                defenseAction = "cast reflection"
            end
            if rime.vitals.percent_health <= 30 then
                defenseAction = "touch crystal"..sep..defenseAction
            end
            if rime.vitals.current_mana <= 2500 then
                defenseAction = "touch wand"..sep..defenseAction
            end
            if rime.vitals.current_health < rime.vitals.current_mana and rime.vitals.current_mana > 4500 then
                action = "shift"
            else
                action = defenseAction
            end
        elseif has_def("spectre") then
            action = "shadowprice gloom "..rime.target..sep.."cast blast "..rime.target
        else
            action = "shadowprice gloom "..rime.target..sep.."cast fever "..rime.target
        end


	elseif class == "Monk" then
		action = "quickdismount" .. sep .. "sdk " .. rime.target .. sep .. "ucp " .. rime.target .. sep .. "ucp " .. rime.target

	elseif class == "Templar" then
		action = "strike " .. rime.target .. " sacrifice"
	elseif class == "Revenant" then
		if rime.vitals.percent_health <= 50 then
			local defenseAction = "blow horn"..sep.."touch shield"
			if gmcp.Room.Info.area == "the forgotten depths of Mount Helba" then
				defenseAction = "blow horn"..sep.."riving fell ".. rime.target.." duskosa duskosa"..sep.."phantasm metabolize"
			end
			if has_def("shielded") then
				defenseAction = "blow horn"..sep.."riving fell ".. rime.target.." duskosa duskosa"..sep.."phantasm metabolize"
			end
			if rime.vitals.percent_health <= 30 then
				defenseAction = "blow horn"..sep.."touch crystal"..sep..defenseAction
			end
			if rime.vitals.current_health < rime.vitals.current_mana and rime.vitals.current_mana > 4500 then
				action = "blow horn"..sep.."shift"
			else
				action = defenseAction
			end
		else
			action = "riving fell ".. rime.target.." duskosa duskosa"
		end
	end

	if gmcp.Char.Status.name == "Bulrok" then
		mount = "recall mount" .. sep .. "recall 54899" .. sep .. "quickmount 54899"
	elseif name == "Mjoll" then
		if string.len(pre) > 1 then
			action = que .. sep .. pre .. sep .. action .. sep .. "absorb ylem" .. sep .. def_up("queue")
		else
			action = que .. sep .. action .. sep .. "absorb ylem" .. sep .. def_up("queue")
		end
	else
		action = que .. sep .. pre .. sep .. "absorb ylem" .. sep .. action
	end
	action = action:gsub(sep..sep, sep)
	act(action)

end

rime.pve.auto_fishing = false
rime.pve.line_cast = false
rime.pve.fish_str = 100
rime.pve.need_discern = true
rime.pve.area = "nowhere"
rime.pve.can_fish = false
rime.pve.fish_hooked = false
rime.pve.auto_walk_fish = false
rime.pve.fish_moving = false
rime.pve.bashing_paused = false
rime.pve.corpse_turn_in = false
rime.pve.fishing = rime.pve.fishing or {}
rime.pve.hack_check = false
debugMode = false

function rime.pve.auto_fish()

	local action = ""
	local sep = rime.saved.separator

	if rime.pve.fish_moving then return end

	if rime.pve.auto_fishing then

		if rime.pve.need_discern then

			action = "fishing discern"

		elseif rime.pve.can_fish then

			if rime.pve.line_cast and rime.pve.fish_hooked then
				if rime.pve.fish_str < 60 then
					action = "fishing reel"
				else
					action = "fishing lead"
				end
			elseif not rime.pve.line_cast then
				action = "fishing cast"
			end

		elseif rime.pve.auto_walk_fish then

			rime.pve.fish_moving = true
			rime.pve.auto_walker_fishing()

		end

	elseif not rime.pve.auto_fishing and rime.pve.line_cast then

		action = "fishing cut"

	end

	act("qeb "..action)


end

function rime.pve.auto_walker_fishing()

	local current_room = tostring(gmcp.Room.Info.num)
	local index_count = 0

	for k,v in pairs(rime.pve.fishing.fishing_holes) do

		if v == current_room then

			index_count = k+1

			expandAlias("goto "..rime.pve.fishing.fishing_holes[index_count])
			rime.pve.need_discern = true
			break

		end

	end

end


rime.pve.quests = rime.pve.quests or {}

function rime.pve.get_quests()

	for k,v in ipairs(gmcp.IRE.Tasks.List) do
		if v.type == "quests" and not rime.pve.quests[v.name] then
			rime.pve.quests[v.name] = {
				id = v.id,
				group = v.group,
				status = v.status,
				desc = v.desc,
                }
			rime.echo("New quest \(<green>"..v.name.."<white>\) added!", "pve")
		end
	end
end

function rime.pve.existing_quest(quest)

	if table.is_empty(rime.pve.quest) then return false end

	for k,v in ipairs(rime.pve.quest) do
		if v.name == quest then
			return true
		else
			return false
		end
	end

end

rime.pve.bashing = rime.pve.bashing or false
rime.pve.botMode = rime.pve.botMode or false
rime.pve.autowalking = rime.pve.autowalking or false
rime.pve.walking = rime.pve.walking or 1
rime.pve.autowalk = rime.pve.autowalk or false

function rime.pve.addMob_event()
	if gmcp.Char.Items.Add.location ~= "room" then return end
	if not gmcp.Char.Items.Add.item.attrib then return end
	if string.find(gmcp.Char.Items.Add.item.attrib, "x") then return end

	rime.pve.mobs = rime.pve.mobs or {}
	
	if gmcp.Char.Items.Add.location == "room" then
		if gmcp.Char.Items.Add.item.attrib ~= nil and not string.find(gmcp.Char.Items.Add.item.attrib, "x") and string.find(gmcp.Char.Items.Add.item.attrib, "m") then
			table.insert(rime.pve.mobs, gmcp.Char.Items.Add.item)
		end
		if gmcp.Room.Info.area:gsub("an unstable section of ","") == "Dovan Hollow" and string.find(gmcp.Char.Items.Add.item.name, "chain") then
			table.insert(rime.pve.mobs, gmcp.Char.Items.Add.item)
		end
	end
	if rime.pve.bashing and rime.target:lower() == "nothing" then
		rime.pve.autoBash("addMob")
	end
end

function rime.pve.removeMob_event()
	if gmcp.Char.Items.Remove.location ~= "room" then return end

	if gmcp.Char.Items.Remove.location == "room" and rime.pve.bashing then
		local removeIndex
		rime.pve.mobs = rime.pve.mobs or {}
		for k,v in pairs(rime.pve.mobs) do
			if gmcp.Char.Items.Remove.item.id == v.id then
				removeIndex = tonumber(k)
			end
		end
		table.remove(rime.pve.mobs, removeIndex)
		if rime.pve.bashing and gmcp.Char.Items.Remove.item.id == rime.target then
			rime.target = "Nothing"
			local agroFound = false
			if rime.pve.area_targets == nil then rime.pve.area_targets = {"eld"} end
			for k,v in ipairs(rime.pve.area_targets) do
				for kMob, vMob in ipairs(rime.pve.mobs) do
					if vMob.icon == "monster" then
						rime.pve.target(vMob)
						agroFound = true
					end
				end
				if agroFound then
					break
				end
				for kMob, vMob in ipairs(rime.pve.mobs) do
					if string.find(vMob.name, v) and not string.find(vMob.name, "corpse") and not string.find(vMob.name, "A dead%, purple-hued swordfish") and vMob.icon ~= "pet" then
						rime.pve.target(vMob)
						break
					end
				end
			end
		end

		if rime.pve.bashing then rime.pve.autoBash("removeMob") end
	end
end

function rime.pve.getRoom_event()

	if gmcp.Char.Items.List == nil then return end
	if gmcp.Char.Items.List.location ~= "room" then return end
	
	rime.pve.setArea()
	rime.pve.mobs = {}

	for k,v in ipairs(gmcp.Char.Items.List.items) do
		if v.attrib ~= nil and not string.find(v.attrib, "x") and string.find(v.attrib, "m") then
			table.insert(rime.pve.mobs, v)
		end
		if gmcp.Room.Info.area:gsub("an unstable section of ","") == "Dovan Hollow" and string.find(v.name, "chain") then
			table.insert(rime.pve.mobs, v)
		end
	end
	if rime.pve.bashing then
		rime.target = "Nothing"
		local agroFound = false
		if rime.pve.area_targets == nil then rime.pve.area_targets = {"eld"} end
		for k,v in ipairs(rime.pve.area_targets) do
			for kMob, vMob in ipairs(rime.pve.mobs) do
				if vMob.icon == "monster" then
					rime.pve.target(vMob)
					agroFound = true
				end
			end
			if agroFound then break end
			for kMob, vMob in ipairs(rime.pve.mobs) do
				if string.find(vMob.name, v) and not string.find(vMob.name, "corpse") and vMob.icon ~= "pet" then
					rime.pve.target(vMob)
					break
				end
			end
		end

		rime.pve.autoBash("getRoom")

	end

	if rime.pve.auto_fishing then

		rime.pve.auto_fish()

	end

end

function rime.pve.autoBash(where)

	if where and debugMode then rime.echo(where) end

	local class = gmcp.Char.Status.class
	local sep = rime.saved.separator

	local pre = ""
			
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "the Bloodwood" then pre = "get essence" end
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "Xaanhal" then pre = "get fragment" end
	if gmcp.Room.Info.area:gsub("an unstable section of ","") == "the Shattered Vortex" then pre = "get piece" end
	if string.len(pre) > 1 then
		pre = "absorb ylem" .. sep .. pre
	else
		pre = "absorb ylem"
	end

	if rime.pve.bashing then
		if room_skip() and not rime.pve.autowalking then
			room_walker("room_skip")		
		elseif lastRoom() and string.title(rime.target) == "Nothing" then
			if rime.vitals.current_mana < math.floor(rime.vitals.max_mana*.7) then
				if class == "Carnifex" then
					act("qeb soul consume for mana")
				elseif class == "Revenant" then 
					act("phantasm metabolize")
				else
					act("touch worrystone")
				end
			elseif rime.vitals.current_health < math.floor(rime.vitals.max_health*.6) then
				act("qeb soul consume for health")
			else
				act("qeb " .. pre .. sep .. def_up("queue"))
				room_walker("lastRoom")
			end
		elseif rime.target == "nothing" or string.title(rime.target) == "Nothing" then
			if rime.vitals.current_mana < math.floor(rime.vitals.max_mana*.7) then
				if class == "Carnifex" then
					act("qeb soul consume for mana")
				elseif class == "Revenant" then 
					act("phantasm metabolize")
				else
					act("touch worrystone")
				end
			elseif rime.vitals.current_health < math.floor(rime.vitals.max_health*.6) then
				if class == "Carnifex" then
					act("qeb soul consume for mana")
				elseif class == "Revenant" then 
					act("phantasm metabolize")
				else
					act("touch worrystone")
				end
			else
				act("qeb " .. pre .. sep .. def_up("queue"))
				room_walker("lastRoom")
			end
		else
			rime.pve.bash_attack()
		end
	end

end

function rime.pve.target(mobTable)
    local mobName = mobTable.name
    local mobID = mobTable.id
    for k,v in ipairs(rime.pve.area_targets) do
		if string.findPattern(mobName, v) and mobID ~= "162498" then
			rime.target = mobID
			if id then killTrigger(id) end
			if id2 then killTrigger(id2) end
   			id2 = tempTrigger(v, [[selectString("]] .. v .. [[", 1) fg("red") resetFormat()]])
 		end		
	end
end

function rime.pve.setArea()

	if rime.pve.target_list[gmcp.Room.Info.area:gsub("an unstable section of ","")] == nil then rime.pve.area_targets = {} return end
	if rime.pve.area_targets ~= rime.pve.target_list[gmcp.Room.Info.area:gsub("an unstable section of ","")] then
		rime.pve.area_targets = rime.pve.target_list[gmcp.Room.Info.area:gsub("an unstable section of ","")]
		for k,v in pairs(rime.pve.target_list.global_targets) do
			table.insert(rime.pve.area_targets, v)
		end
		rime.pve.area = rime.pve.directions_mapper[gmcp.Room.Info.area:gsub("an unstable section of ","")]
		rime.pve.area_name = gmcp.Room.Info.area:gsub("an unstable section of ","")
		rime.pve.walking = 1
		rime.echo("Entered <cyan>"..gmcp.Room.Info.area:gsub("an unstable section of ","").."<white>. Changing Target List.", "pve")
		rime.echo("Walking directions updated.", "pve")
	end

end

function room_walker(where)

	if where and debugMode then rime.echo(where) end
	
	if not rime.pve.autowalk then rime.echo ("not moving because of rime.pve.autowalk") return end	
	if rime.pve.autowalking then rime.echo("not moving because of rime.pve.autowalking") return end
	local name = gmcp.Char.Status.name
	local sep = rime.saved.separator

	if 	lastRoom() then 
		rime.echo("Area cleared.", "pve")
		local sep = rime.saved.separator
		local mount = rime.saved.mount
		if tonumber(gmcp.Char.Vitals.mounted) == 0 then
			act("qeb recall " .. mount .. sep .. "recall mount" .. sep .. "quickmount "..mount)
		end
		if rime.pve.area ~= nil and rime.pve.botMode and #rime.pve.area == rime.pve.walking then
			rime.pve.autowalking = true
			if rime.pve.area_name == "Drakuum" and not rime.pve.bashing_paused then
				act("qeb sac corpses")
--				expandAlias("goto salma")
--			elseif rime.pve.area_name == "the Salma Settlement" then
--				act("qeb sac corpses")
--				expandAlias("goto three rock")
--			elseif rime.pve.area_name == "the Three Rock Outpost" and not rime.pve.bashing_paused then
				--placeholder
--				rime.pve.bashing = false
--				rime.pve.autowalk = false
--				rime.pve.botMode = false
--				rime.pve.bashing_paused = true
--				rime.pve.corpse_turn_in = true
--				expandAlias("goto 20330")
--			elseif rime.pve.bashing_paused and rime.pve.area_name == "the Three Rock Outpost" then
--				rime.pve.bashing_paused = false
				expandAlias("goto ayhesa")
			elseif rime.pve.area_name == "the Ayhesa Cliffs" and not rime.pve.bashing_paused then
				rime.pve.bashing = false
				rime.pve.autowalk = false
				rime.pve.botMode = false
				rime.pve.bashing_paused = true
				rime.pve.corpse_turn_in = true
				expandAlias("goto 19996")
			elseif rime.pve.bashing_paused and rime.pve.area_name == "the Ayhesa Cliffs" then
				rime.pve.bashing_paused = false
				act("qeb sac corpses")
--				expandAlias("goto caldera")
--			elseif rime.pve.area_name == "the Teshen Caldera" and not rime.pve.bashing_paused then
--				rime.pve.bashing = false
--				rime.pve.autowalk = false
--				rime.pve.botMode = false
--				rime.pve.bashing_paused = true
--				rime.pve.corpse_turn_in = true
--				expandAlias("goto 4147")
--			elseif rime.pve.area_name == "the desert village of El'Jazira" and rime.pve.bashing_paused then
--				rime.pve.bashing_paused = false 
--				act("give 50 teshen to horace"..sep.."give 50 teshen to horace"..sep.."give 50 teshen to horace"..sep.."give 50 teshen to horace"..sep.."give 50 teshen to horace"..sep.."give 50 teshen to horace")
				expandAlias("goto forgotten dome")
			elseif rime.pve.area_name == "the Forgotten Dome" and not rime.pve.bashing_paused then
				rime.pve.bashing = false
				rime.pve.autowalk = false
				rime.pve.botMode = false
				rime.pve.bashing_paused = true
				rime.pve.corpse_turn_in = true
				expandAlias("goto 56106")
			elseif rime.pve.area_name == "the Forgotten Dome" and rime.pve.bashing_paused then
				rime.pve.bashing_paused = false
				act("qeb sac corpses")
				expandAlias("goto nal'jin")
			elseif rime.pve.area_name == "the Nal'jin Depths" then
				act("qeb sac corpses")
				expandAlias("goto arbothia")
			elseif rime.pve.area_name == "Arbothia" then
				act("qeb sac corpses")
				expandAlias("goto spiral")
			elseif rime.pve.area_name == "Spiral of the Corrupt" then
--				act("qeb sac corpses")
--				expandAlias("goto caverns of mor")
--			elseif rime.pve.area_name == "the Caverns of Mor" then
--				act("qeb sac corpses")
--				expandAlias("goto dolbodi")
--			elseif rime.pve.area_name == "the Dolbodi Campsite" then
				act("qeb sac corpses")
				expandAlias("goto tiyen es")
			elseif rime.pve.area_name == "Tiyen Esityi" then
				act("qeb sac corpses")
				expandAlias("goto illdon")
			elseif rime.pve.area_name == "the Bastion of Illdon" then
				act("qeb sac corpses")
				expandAlias("goto luzith")
			elseif rime.pve.area_name == "Luzith's Lair" then
				act("qeb sac corpses")
				expandAlias("goto xaanhal")
			elseif rime.pve.area_name == "Xaanhal" then
				act("qeb sac corpses")
				expandAlias("goto yuzurai")
			elseif rime.pve.area_name == "Yuzurai village" then
				act("qeb give 50 rojalli to dakun"..rime.saved.separator.."give 50 rojalli to dakun"..rime.saved.separator.."sac corpses")
--				expandAlias("goto eresh")
--			elseif rime.pve.area_name == "the Eresh Mines" then
--				act("qeb sac corpses")
				expandAlias("goto dovan")
			elseif rime.pve.area_name == "Dovan Hollow" then
				act("qeb sac corpses")
				expandAlias("goto clawhook range")
			elseif rime.pve.area_name == "Clawhook Range" then
				act("qeb sac corpses")
				expandAlias("goto the maul")
			elseif rime.pve.area_name == "the Maul" then
--				act("qeb sac corpses")
--				expandAlias("goto a basilisk lair")
--			elseif rime.pve.area_name == "a basilisk lair" then
				act("qeb sac corpses")
				expandAlias("goto 5517")
			elseif rime.pve.area_name == "the Ia'shal Barrow" and not rime.pve.bashing_paused then
				rime.pve.bashing = false
				rime.pve.autowalk = false
				rime.pve.botMode = false
				rime.pve.bashing_paused = true
				rime.pve.corpse_turn_in = true
				rime.pve.autowalking = false
				act("greet guard")
			elseif rime.pve.area_name == "the Ia'shal Barrow" and rime.pve.bashing_paused then
				rime.pve.bashing_paused = false
				act("qeb sac corpses")
				expandAlias("goto the forgotten depths of Mount Helba")
			elseif rime.pve.area_name == "the forgotten depths of Mount Helba" then
				act("qeb sac corpses")
				act("path track drakuum")
			end
		end
		return
	end

	if not rime.pve.bashing then rime.echo("not doing shit because of this check") return end
	if rime.target == "nothing" or rime.target == "Nothing" or room_skip() then
		if not rime.pve.walking then rime.pve.walking = 1 end
		rime.pve.walking = rime.pve.walking+1
		expandAlias("goto "..rime.pve.area[rime.pve.walking])
		if not rime.pve.bashing_paused then rime.pve.autowalking = true end
		return
	end

end

function lastRoom()
	if rime.pve.area == nil then return true end
	if rime.pve.area[#rime.pve.area] == nil then return true end

	return #rime.pve.area == rime.pve.walking

end

function room_skip()

	local players = gmcp.Room.Players
	
	if #players > 0 then
		for k,v in pairs(players) do
			if not table.contains(bashingGroup, v.name) then
				rime.echo("You're not alone", "pve")
				return true
			end
		end
	end
	return false

end

function rime.pve.bash_reset()

	rime.pve.bashing =  false
	rime.pve.autowalking =  false
	rime.pve.walking = 1
	rime.pve.autowalk = false
	rime.echo("Bashing Reset", "pve")
	rime.pve.goldTracking = {}
	rime.pve.MistTracking = {}
end

rime.pve.goldTracking = rime.pve.goldTracking or {}
rime.pve.MistTracking = rime.pve.MistTracking or {}

function rime.pve.goldUpdate(amount)
	local where = gmcp.Room.Info
	local when = os.time()

	local goldLog = {
		["where"] = {
			["roomNum"] = where.num,
			["area"] = where.area,
		},
		["when"] = when,
		["amount"] = amount,
	}

	table.insert(rime.pve.goldTracking, goldLog)

end

function rime.pve.MistUpdate(amount)
	local where = gmcp.Room.Info
	local when = os.time()

	local MistLog = {
		["where"] = {
			["roomNum"] = where.num,
			["area"] = where.area,
		},
		["when"] = when,
		["amount"] = amount,
	}

	table.insert(rime.pve.MistTracking, MistLog)

end

function rime.pve.goldCheck()

	local total = 0
	local startTime = nil
	local endTime = nil
	local thisArea = gmcp.Room.Info.area:gsub("an unstable section of ","")
	local thisRoom = gmcp.Room.Info.num
	local areaGold = 0
	local roomGold = 0
	for _, log in ipairs(rime.pve.goldTracking) do
		if not startTime or log.when < startTime then
			startTime = log.when
		end
		if not endTime or log.when > endTime then
			endTime = log.when
		end
		if log.where.area == thisArea then
			areaGold = areaGold + log.amount
		end
		if log.where.roomNum == thisRoom then
			roomGold = roomGold + log.amount
		end
		total = total + log.amount
	end

	if not (endTime or startTime) then return end

	local duration = endTime - startTime

	local days = math.floor(duration/60/60/24)
	local hours = math.floor((duration - (days*60*60*24))/60/60)
	local minutes = math.floor((duration - (hours*60*60) - (days*60*60*24))/60)
	local seconds = math.floor((duration - (minutes*60) - (hours*60*60) - (days*60*60*24)))

	local timeString = (days and tostring(days).." days ")..(hours and tostring(hours).." hours ")..
(minutes and tostring(minutes).." minutes ")..(seconds and tostring(seconds).." seconds")

	local gps = total / duration
	local gph = total / (duration/60/60)

	cecho("\n<yellow>Gold in "..thisArea.." is: "..(areaGold<1 and "<red>" or "<green>")..tostring(areaGold))
	cecho("\n<yellow>Gold at v"..thisRoom.." is: "..(roomGold<1 and "<red>" or "<green>")..tostring(roomGold))
	cecho("\n<yellow>Gold change is: "..(total<=0 and "<red>" or "<green>")..tostring(total).."<yellow> over "..timeString)
	cecho("\n<yellow>Gold Per Second is: "..(gps<=0 and "<red>" or "<green>")..string.format("%.2f",gps))
	cecho("<yellow> Gold Per Hour is: "..(gph<=0 and "<red>" or "<green>")..string.format("%.2f",gph))


end

function rime.pve.MistCheck()

	local total = 0
	local startTime = nil
	local endTime = nil
	local thisArea = gmcp.Room.Info.area:gsub("an unstable section of ","")
	local thisRoom = gmcp.Room.Info.num
	local areaMist = 0
	local roomMist = 0
	for _, log in ipairs(rime.pve.MistTracking) do
		if not startTime or log.when < startTime then
			startTime = log.when
		end
		if not endTime or log.when > endTime then
			endTime = log.when
		end
		if log.where.area == thisArea then
			areaMist = areaMist + log.amount
		end
		if log.where.roomNum == thisRoom then
			roomMist = roomMist + log.amount
		end
		total = total + log.amount
	end

	if not (endTime or startTime) then return end

	local duration = endTime - startTime

	local days = math.floor(duration/60/60/24)
	local hours = math.floor((duration - (days*60*60*24))/60/60)
	local minutes = math.floor((duration - (hours*60*60) - (days*60*60*24))/60)
	local seconds = math.floor((duration - (minutes*60) - (hours*60*60) - (days*60*60*24)))

	local timeString = (days and tostring(days).." days ")..(hours and tostring(hours).." hours ")..
(minutes and tostring(minutes).." minutes ")..(seconds and tostring(seconds).." seconds")

	local gps = total / duration
	local gph = total / (duration/60/60)

	cecho("\n<yellow>Mist in "..thisArea.." is: "..(areaMist<1 and "<red>" or "<green>")..tostring(areaMist))
	cecho("\n<yellow>Mist at v"..thisRoom.." is: "..(roomMist<1 and "<red>" or "<green>")..tostring(roomMist))
	cecho("\n<yellow>Mist change is: "..(total<=0 and "<red>" or "<green>")..tostring(total).."<yellow> over "..timeString)
	cecho("\n<yellow>Mist Per Second is: "..(gps<=0 and "<red>" or "<green>")..string.format("%.2f",gps))
	cecho("<yellow> Mist Per Hour is: "..(gph<=0 and "<red>" or "<green>")..string.format("%.2f",gph))


end



rime.pve.fishing.fishing_holes = {
	"2781", "1041", "57566", "36264", "14469", "787", "23899", "23892", "1590", "1603", "9704", "16540", "989", "60034",
	"13114", "8109", "58866", "3005", "42876", "3416", "32909",
}

rime.pve.exploration = rime.pve.exploration or {}

rime.pve.exploration.area = rime.pve.exploration.area or "none"
rime.pve.exploration.area_rooms = rime.pve.exploration.area_rooms or "none"
rime.pve.exploration.auto_exploring = rime.pve.exploration.auto_exploring or false
rime.pve.exploration.room_count = rime.pve.exploration.room_count or 0
rime.pve.exploration.percent_explored = 0

function rime.pve.exploration.area_set(area)


	if #rime.pve.exploration.area_rooms ~= #getAreaRooms(mmp.findAreaID(area, "exact")) then

		rime.pve.exploration.area_rooms = getAreaRooms(mmp.findAreaID(area, "exact"))
		rime.pve.exploration.area = area
		rime.pve.exploration.room_count = 0
		rime.echo("Exploration area set to <green>"..area.."<white>. Thank you for travelling with Rime Exploration LLC.", "explorer")

	end

end

function rime.pve.exploration.auto_explore()


	if tonumber(rime.pve.exploration.percent_explored) < 100 and rime.pve.exploration.auto_exploring and rime.pve.exploration.room_count <= #rime.pve.exploration.area_rooms then

		mmp.gotoRoom(rime.pve.exploration.area_rooms[rime.pve.exploration.room_count])

	elseif rime.pve.exploration.auto_exploring then

		rime.pve.exploration.auto_exploring = false
		rime.pve.exploration.room_count = 0

		rime.echo("Explored 100% of the area! Or as much of it as you can", "explorer")

	end

end



rime.pve.target_list = {
	["the desert village of El'Jazira"] = {},
	["the Central Wilderness"] = {"a mottled green bullfrog"},
	["global_targets"] = {"eld", "hobgobbler"},
	["Difohr Passage"] = {"a skittering onyx eld","a fragmented eld of shadowy onyx","a shattered eld monstrosity"},
	["Myesian Run"] = {"a skittering verdant eld"},
	["Cinderbreach Mine"] = {"a fiery crimson fragmented eld", "a shattered eld monstrosity", "a skittering crimson eld"},
	["Radial Dig Shaft #15"] = {"a shattered eld monstrosity", "an icy azure fragmented eld", "a skittering azure eld"},
	["Trapped within a mirror"] = {"a fragment of living glass"},
	["the Kingdom of New Sehal"] = {"a soulless pixie", "a stern Imp warrior", "a boisterous Imp boy", "a charming Imp girl", "a fluffy white sheep", "a fuzzy grey rabbit"},
	["the Valley of Lodi"] = {"a cave bat", "a sheep", "a white hen", "a juvenile wildcat", "an adult wildcat"},
	["the Village of Gorshire"] = {"a guard pig", "a portly gnome sentry", "a gnome man", "a gnome woman", "a little gnome boy", "a gnome sentry", "a little gnome girl", "a skinny gnome sentry", "a deputy constable", "a lithe weasel", "a large grey goose", "a large gray goose"},
	["the Tarean Caverns"] = {"a small%, black bat", "an unkempt Trog", "a chubby Trog woman", "a rambunctious young Trog", "a hulking Trog man", "a rotting rattlesnake", "an irritable, rabid zebra", "a blood%-spattered leopard", "a frothing%, manic buffalo", "a gigantic cave bear"},
	["the Crags"] = {"a light grey stone worm", "a dark grey stone worm", "an infant%-like cragling", "a steady cragling", "a vile snatcher", "a hulking snatcher"},
	["the village of Rahveir"] = {"a disgustingly warped missionary", "a malevolent poltergeist", "a corrupted spirit"},
	["Forsaken Evlasu"] = {"an unnaturally lithe%, shadowy aberration", "a hideous winged aberration", "a grotesque%, warped aberration", "a corrupted cultist"},
	["Yohanan Village"] = {"a fleshless skeleton", "a female villager", "a villager", "an old guard", "a small girl", "a young village guard", "a mangy rat", "a cave bat"},
	["Raim Vale"] = {"a mutilated creature","a disfigured woman","a rabid dog","a deformed man","a diseased man","Midolo Raim%, the failed experiment","a misshapen woman"},
	["the Centipede Cave"] = {"a large centipede", "a skittering centipede", "a chitinous centipede", "a venomous centipede", "a juvenile centipede", "a massive centipede queen"},
	["Riparium"] = {"a large red crab", "a moray eel", "a mantaglow fish", "a large%, deepwater salmon", "an angler fish"},
	["the Siroccian Mountains"] = {"a vicious wolverine", "a powerful wolverine"},
	["the Festering Wastes"] = {"a darkly patterned sand viper", "a gray%, spotted bobcat", "a ragged brown coyote", "a tiny black scorpion", "a deep green lizard", "a shivering jackrabbit", "a small yellow rattlesnake"},
	["Halls of Tornos"] = {"a speckled tinyok", "a snowy armadilleon", "a malformed beast", "a botched phase%-hound", "a rabid blood%-fiend", "a crazed blood%-fiend", "a mutated blood%-fiend"},
	["Rebels' Ridge"] = {"a tenacious tough", "a rebellious rancher", "a former farmer", "a naive neo%-Ankyrean", "a seditious scholar", "a dingy dog", "a gamey goat", "a chittering chicken"},
--	["Scidve"] = {"a large gray and black dugger", "a rock devil", "a Drakt guard"},
	["the Vilimo Fields"] = {"a field monitor", "a field harvester", "a decaying donkey", "a semi%-conscious elderly man", "a semi%-conscious elderly woman", "a semi%-conscious child"},
	["the Central Wilderness"] = {"a gnat", "a mottled green bullfrog", "a dragonfly"},
	["the Cathedral of Gloaming"] = {"a Dwarven priest", "a vengeful spirit"},
	["Mount Humgurd"] = {"a black%-spotted cow"},
	["the Western Itzatl Rainforest"] = {"an orange, black%-striped tiger","an iridescent tizapez","a menacing black rojalli","a colorful toucan","a crooked%-beaked jicocte","a beautiful quetzal bird","a swarm of tsetse flies","an enormous anaconda","a rojalli cub","a razor nahuac","an ecru axolotl","a xenosaurus lizard","a furry coatimundi","a playful oniro","an ocelot","a shadow bat","a white stone oyster","a firemouth cichlid","a lithe black panther","a poisonous purple lora","a frilled lizard","a cricket"},
	["the Village of Torston"] = {"an enormous blue%-green crocodile","a frail Xorani man","a dark%-skinned Grook woman","a dusky%-skinned Grook man","a tall Horkvali woman","the Torstonite chef","a stalwart Horkvali guard","a wary Xorani guard","a carefree Grook boy","a mottled brown frog","a little Grook girl",},
	["the Azdun dungeon"] = {"a huge pulsating spider", "medium pulsating spider", "a large pulsating spider"},
	["the Temple of Sonn"] = {"a choke creeper","a giant mosquito","a giant fly","a giant moth","a glossy black silk%-spinner","Urrith%, a sea wyvern",},
	["the Dolbodi Campsite"] = {"a brawny hunter", "a slender forager", "a burly lumberjack", "a grizzly foreman", "a lithe buckawn"},
	["Three Widows"] = {"a white%-coated chinchilla","a short%-horned chamois",},
	["Dun Fortress"] = {"an orc guard","a demonic screamer","an ogre bowman","a slime%-encrusted spitter","an orc soldier","a large catfish","a dangerous water snake","an ogre knight","a prisoner","an orc sergeant","an orc archer","an ogre sentry", "an orc cook","an orc captain","an ogre captain",},
	["the Arurer Haven"] = {"an aged priest","a young celestial angel","a striking supernal angel","a youthful priest","a budding priestess","a savvy priestess","a young celestial angel","Tisian%, a young priest","Father Garron%, the priest"},
	["a snake pit"] = {"a venenigol snake", "an andragil snake", "a tiny hatchling", "a large sertag snake", "a grassel snake","a muselon snake",},
	["the Ruins of Farsai"] = {"an unctuous creepling", "a shadowdrop", "a darkling"},
	["Asper"] = {"a fearsome icewyrm", "a malevolent spectre", "a failed experiment", "an animated golem of flesh", "a wild bobcat", "a snowshoe hare"},
	["the Khauskin Mines"] = {"a statuesque Dwarven guard", "a burly Dwarven miner", "a Dwarven girl", "a Dwarven boy", "a stocky Dwarven woman", "a stout Dwarven man", "a powerful Dwarven warrior", "a soft%-shelled klikkin", "a grotesque fangtooth"},
	["City of Djeir"] = {"a gargantuan spider"},
	["the Three Rock Outpost"] = {"a huge%, scarred wildcat","a beautiful wild horse","a mountain wildcat","a wildcat kitten", "a long%-haired buffalo", "an enormous Troll bandit","a shifty bandit", "the cave bear%, White Ghost"},
	["the village of Bihrkaen"] = {"a grotesque snapping turtle", "a mire hound", "a bog hound", "a mire pup", "an alpha female hound", "a slender mud adder", "a speckled%, brown turtle", "an alpha male hound"},
	["the Augerweald"] = {"an agitated direwolf", "a large bhfaol", "silver%-feathered orel", "a gargantuan Augerweald rabbit", "a tall%, white elk", "a large%, snowy fox"},
	["the Teshen Caldera"] = {"a Teshen raider", "a Teshen scout", "a Teshen reaver", "a Teshen worker"},
	["the Fractal Bloom"] = {"a towering crystalline entity", "a slender crystalline entity", "a radiant crystalline entity", "a squat crystalline entity", "a fractured crystalline entity", "a faceted crystalline entity"}, 
	["the Kalydian Forest"] = {"a gaunt elk",  "a rabid rabbit", "a ravenous squirrel"},
	["the Maghuir Fissure"] = {"an amorphous black umbra","a darkly robed priest"},
	["the Torturers' Caverns"] = {"Mellias%, an elegant Tsol'aa consanguine", "Tuera%, the torturer", "Sentinel Rozhirr", "a rank ghoul", "a vampiric overseer", "a maggot%-ridden skeleton", "a flesh golem sentry", "a vile inquisitor", "a hulking ghast", "a scheming terramancer"},
	["the Salma Settlement"] = {"a Salmati warrior","a Salmati guard","an unclean miner","a common man","an ordinary woman","an engrossed scholar","a busy mage","a hooded scholar","Dima%, Captain of the Salmati Guard","a robust blacksmith","an energetic child",},
	["the Caverns of Mor"] = {"a ravenous%, shadowy ghast", "a robed%, skeletal lich", "a stench%-ridden ghoul", "a skeletal warrior", "a vampiric warrior", "a vampiric sentry"},
	["the Sparklight Rift"] = {"an oversized efreeti","a churning fire elemental","a fire elemental minion","a greater fire elemental","a colossal elemental"},
	["the Mamashi Tunnels"] = {"a greater nalas", "a young nalas", "a mature nalas","a Mit'olk bladesman", "a Mit'olk axeman", "a Mit'olk illusionist","a Githani master","a Githani grappler","a Githani inscriber",},
	["the Lich Gardens"] = {"a dissected child", "a commanding lich scientist", "a dark Cabalist scholar", "a monstrous Carnifex guard", "a mindless experiment", "a guardian wraith", "a tattered Bahkatu experiment", "a student of the lich"},
	["Raugol Fissure"] = {"a scything skitterer","a stonescale ravager","a stonescale mephit",},
	["the Isle of Ollin"] = {"a ferocious Alpha Syll","a giant%, rabid Syll", "a massive%, verdant%-furred Syll", "a young Syll cub", "a blackened%, ravenous shark", "a massive black crab", "a dark%-furred%, rabid boar", "a towering Nazetu guard", "a stinking Nazetu soldier", "a rotting Nazetu ghoul", "a Nazetu comfort woman", "a boisterous Nazetu child", "a sharp%-clawed Boru prowler", "a fiendish%, tainted Syll", "a diligent Boru harvester"},
	["the Itzatl Morass"] = {"an oversized fly", "an oversized earthworm", "a capybara", "a poisonous water moccasin", "a green slime toad", "a silent reed cat", "a vicious snapping turtle", "a long%-toothed beaver"},
	["Saliltul Swamp"] = {"a rabid direwolf", "a mutilated humanoid", "a red%-eyed water snake"},
	["the Iernian Fracture"] = {"an unstable white eld", "a colossal crystalline eld", "a churning%, unstable eld", "an enormous%, three%-cored eld", "an effulgent platinum eld", "a discordant%, buzzing eld", "a cacophonous cluster of eld", "a shrieking mass of eld", "a flickering green eld", "a coruscating swarm of eld"},
	["Drakuum"] = {"a savage shade", "a blackened darkwalker", "a hideous lich",  "a misty apparition","a gnarled spirit"}, 
	["the Ia'shal Barrow"] = { "a foul spiderling", "a ravenous cave spider", "a bulbous cave spider", "an egg%-laden spider"},
	["Arbothia"] = {"an enraged female servant", "an enraged male servant", "an enraged female villager", "an enraged male villager"},
	["the Eresh Mines"] = {"a slimy brown salamander", "an angry vampire bat", "a blind wolf spider", "a swarm of black beetles"},
	["the Fengard Keep"] = {"a massive argobole", "a fiery phenkyre", "an ogre berserker", "a horrid basilwyrm", "a shrieking grimshrill", "a vicious horned garwhol", "a brawny glaive knight", "a tall chempala", "a radiant lumore", "a pious invoker", "a pungent lichosphere", "an ethereal construct"},
	["the Ayhesa Cliffs"] = {"a Spellshaper Archon", "a Spellshaper Master", "a Spellshaper Adept"},
	["Yuzurai village"] = {"a massive rojalli matriarch", "a sleek black rojalli", "a savage rojalli"},
	["the Dramedo Warrens"] = {"a vast ochre ooze", "a winged fungal horror","a shambling fungal abomination", "a gigantic fungal strider","a cloud of fungal spores"}, 
	["the Isle of Despair"] = {"a darkened soul", "a severed male head"},
	["the Shattered Vortex"] = {"a petrified treant", "Sentinel Voiel", "a solemn luminary", "a chimera", "a pathfinder", "a sharp%-toothed gremlin", "a minion of chaos", "a chaos orb", "a bloodleech", "a bubonis", "a humbug", "a chaos hound", "a green slime", "an ethereal firelord", "a simpering Sycophant", "a soulmaster", "a dervish", "a withered crone", "a chaos storm", "a warped turtle", "a warrior of the Demonsbane", "a reinforcement warrior of the demonsbane", "a fetish%-decorated shaman", "a guardian angel", "a nimble sentinel", "a stalwart templar", "an agile Sentaari monk", "a battle%-worn Ascendril", "an Ascendril mage"},
	["Tiyen Esityi"] = {"a massive, sacred serpent", "a tangible malevolence", "Commander Marakhi", "Tirahl the Necromancer", "Lieutenant Gharvoi", "a ball of chitinous legs", "insubstantial whispers", "Quartermaster Kuius", "Lieutenant Chiakhi", "a crazed Nazetu cutter", "a mutated Nazetu intercessor", "a Nazetu cook", "a Nazetu halberdier", "a Nazetu provost", "a deformed Nazetu priest", "a Nazetu crossbowman", "a bound shade", "a Nazetu corrupter", "a Nazetu necromancer", "a supply officer", "a victimised intruder", "a Nazetu captain",},
	["the Nal'jin Depths"] = {"an enormous spinelash fish", "a sinewy Nal'jin eel", "a shadow ray", "a serpentine jawsnapper"},
	["the Forgotten Dome"] = {"a gibbering kelki reaver", "a deformed kelki ravener", "a mutated kelki ravager", "a vile kelki prowler"},
	["Luzith's Lair"] = {"a mass of deadly trap spiders", "a deadly trap spider", "a monstrous arachnid", "a vicious little spider", "a large%, crystalline spider", "a flying spider", "a sentinel spider", "a slender%, female arachnoid",},
	["the Bastion of Illdon"] = {"a trapped soul", "a rabid plant", "a rabid hound", "a nightmare shadow", "a shadowy%, mindless demon", "a mutated experiment"},
	["Spiral of the Corrupt"] = {"an ethereal%, scarred jellyfish", "a rot%-infested swordfish", "a five%-tentacled octopus of jade", "a taint%-infested shark", "a miasma%-wreathed electric eel"},
	["the Shastaan Warrens"] = {"an aberrant%, obscenely deformed Kelki", "a wild%-eyed Kelki cultist", "a ragged Kelki cultist"},
	["the Bloodwood"] = {"a distressed spirit", "a wailing spirit", "a lingering spirit"},
	["Dovan Hollow"] = {"a haughty Caentoi slaver", "a hulking Ursal brute", "a grim Aslinn slaver", "a gaunt Aslinn slaver", "a scarred Aslinn slaver", "a sinewy Aslinn slaver", "rusted iron chains"},
	["the Feral Caves"] = {"a small green blob", "a slimy green blob", "a massive green blob", "a gigantic green blob"},
	["The Forgotten Mausoleum"] = {"a reanimated Dwarf woman", "a rotting Dwarf archer", "a decomposing Dwarf", "a robed reanimated Dwarf"},
	["Tcanna Island"] = {"a brown and tan python", "a blue crab", "a box jellyfish", "a large capybara", "a small ocelot", "a spotted leopard", "a howler monkey", "a striped tiger", "a water buffalo", "an enormous elephant", "a vicious copperhead snake", "an oversized tortoise", "a diseased raccoon", "a white%-tailed deer", "a lithe cougar", "a black bear", "a black and white badger","a great white stag", "a spotted jaguar","a long billed toucan", "a scarlet macaw", "a bald eagle", "a gray wolf", "a ragged coyote", "a Troll guard", "a Troll cook","a white goose", "a Nazetu officer"},
	["Xaanhal"] = {"a suspicious Xorani patrol", "a wiry Xorani guard", "a cautious Xorani guard", "a merciless Xorani warrior", "a willowy nest guardian"},
	["the Maul"] = {" a lithe Aslinn houndmaster", "a cruel Aslinn guard", "a menacing Aslinn gladiator", "a scarred Aslinn gladiator", "a ravenous vakmut warhound","a lithe Aslinn houndmaster","a wary Aslinn slaver","a gaunt Aslinn guard","an Aslinn slave catcher","a wretched Aslinn slaver"},
	["the forgotten depths of Mount Helba"] = {"a towering fungal abomination", "a withered fungal abomination",},
	["the Bakal Chasm"] = {"a grey and brown basilisk", "an oversized, grey basilisk", "a juvenile basilisk", },
	["Clawhook Range"] = {"a sabre%-toothed abosvi", "a mottled grey mountain goat", "a worried%-looking mangy goat", "a shaggy, white mountain goat", "an oversized, grey basilisk", "an armored, brown basilisk", "a grey and brown basilisk", "a spiked basilisk", "a spine%-necked arrex", },
	["a basilisk lair"] = {"a cave basilisk",},
	}