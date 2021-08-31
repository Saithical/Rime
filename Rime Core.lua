rime = rime or {}
rime.targets = rime.targets or {}
	if file_exists(getMudletHomeDir().."/rime.targets.lua") then
		table.load(getMudletHomeDir().."/rime.targets.lua", rime.targets)
	else
		table.save(getMudletHomeDir().."/rime.targets.lua", rime.targets)
	end
rime.saved = rime.saved or {}
	if file_exists(getMudletHomeDir().."/rime.saved.lua") then
		table.load(getMudletHomeDir().."/rime.saved.lua", rime.saved)
	else
		rime_initial_setup()
	end
rime.firstaid = false
rime.pve = rime.pve or {}
rime.pvp = rime.pvp or {}
rime.curing = rime.curing or {}
rime.defences = rime.defences or {}
rime.afflictions = rime.afflictions or {}
rime.hidden_afflictions = rime.hidden_afflictions or {}
rime.hidden_affs_total = 0
rime.vitals = rime.vitals or {}
rime.gmcp = rime.gmcp or {}
rime.balances = rime.balances or {}
rime.balances.nimbleness = rime.balances.nimbleness or true
rime.vitals.dead = false
rime.death_check = false
rime.paused = false
rime.movement = rime.movement or {}
rime.movement.mode = "nothing"
rime.target = rime.target or "none"
sendGMCP('Core.Supports.Add ["IRE.Tasks 1"]')
sendGMCP('Core.Supports.Add ["Comm.Channel 1"]')


function rime.echo(msg, type)

    if not type then
    
        cecho("\n<DeepPink>\(<CornflowerBlue>Rime<DeepPink>\)<white> "..msg)
        
    elseif type == "pvp" then
    
        cecho("\n<"..rime.saved.echo_colors.pvp.parenthesis..">\(<"..rime.saved.echo_colors.pvp.title..">PvP<"..rime.saved.echo_colors.pvp.parenthesis..">\)<white> "..msg)
        
    elseif type == "pve" then
    
        cecho("\n<"..rime.saved.echo_colors.pve.parenthesis..">\(<"..rime.saved.echo_colors.pve.title..">PvE<"..rime.saved.echo_colors.pve.parenthesis..">\)<white> "..msg)
        
    elseif type == "def" then
    
        cecho("\n<"..rime.saved.echo_colors.def.parenthesis..">\(<"..rime.saved.echo_colors.def.title..">Defence<"..rime.saved.echo_colors.def.parenthesis..">\)<white> "..msg)
        
    elseif type == "curing" then
    
        cecho("\n<"..rime.saved.echo_colors.curing.parenthesis..">\(<"..rime.saved.echo_colors.curing.title..">Curing<"..rime.saved.echo_colors.curing.parenthesis..">\)<white> "..msg)

    elseif type == "order" then

        cecho("\n<"..rime.saved.echo_colors.order.parenthesis..">\(<"..rime.saved.echo_colors.order.title..">Chakrasul<"..rime.saved.echo_colors.order.parenthesis..">\)<white> "..msg)

    elseif type == "war" then

        cecho("\n<"..rime.saved.echo_colors.war.parenthesis..">\(<"..rime.saved.echo_colors.war.title..">War<"..rime.saved.echo_colors.war.parenthesis..">\)<white> "..msg)

    end



end


function class_color()

	local class = gmcp.Char.Status.class
	
	if class == "Syssin" then
	
		return "<DarkSlateGrey>"
		
	elseif class == "Praenomen" then
	
		return "<red>"

	elseif class == "Teradrim" then

		return "<burlywood>"
		
	elseif class == "Shapeshifter" then

		return "<BlueViolet>"

	elseif class == "Sentinel" then

		return "<NavajoWhite>"
		
	elseif class == "Carnifex" then
	
		return "<red>"

	elseif class == "Indorani" then

		return "<magenta>"

	elseif class == "Archivist" then

		return "<SeaGreen>"

	elseif class == "Sciomancer" then

		return "<DarkTurquoise>"

	elseif class == "Monk" then

		return "<khaki>"

	elseif class == "Templar" then

		return "<gold>"

	elseif class == "Wayfarer" then

		return "<SlateGrey>"

	elseif class == "Revenant" then

		return "<midnight_blue>"

	elseif class == "Shaman" then

		return "<forest_green>"

	end
	
end

--Custom send function. Send everything through this by default. Will expand upon it later for things like channels.


function act(...)
    local sep = rime.saved.separator
    local action = table.concat(arg, sep)
    if action == nil or action  == "" then return end
    if rime.vitals.dead or rime.paused or has_def("barrier") then return end

    if rime.saved.gag_command then
        send(action, false)
    else
        send(action)
    end
end

function rime.target_track(name)

    if rime.target == name:lower() then return end
    rime.target = string.lower(name)
    if id2 then killTrigger(id2) end
        id2 = tempTrigger(rime.target, [[selectString("]] .. rime.target .. [[", 1) fg("]]..rime.saved.echo_colors.target.title..[[") resetFormat()]])
        rime.target = string.title(name)
    if id then killTrigger(id) end
        id = tempTrigger(rime.target, [[selectString("]] .. rime.target .. [[", 1) fg("]]..rime.saved.echo_colors.target.title..[[") resetFormat()]])
        rime.echo("Now targetting <DodgerBlue>"..rime.target)
        local class = gmcp.Char.Status.class
    if class == "Indorani" then
        act("leech release")
    elseif class == "Syssin" then
        syssin.suggests_added = {}
        syssin.sealed = false
    end

    if rime.checkTime("focus", name) == nil then rime.time("focus", name) end
    if rime.checkTime("lockbreaker", name) == nil then rime.time("lockbreaker", name) end

    if rime.pvp.calling and not targetCalled then send("wt Target: "..rime.target) end

    GUI.target_aff()

end

rime.last_hit = rime.last_hit or "nothing"

rime.timer = rime.timer or {}
rime.limit = rime.limit or {}

function limitStart(action, time, person)

	--if person then
		
	if not time then

		if rime.timer[action] then killTimer(rime.timer[action]) end
		rime.limit[action] = true
		rime.timer[action] = tempTimer(.4, [[limitEnd("]]..action..[[")]])
		
	else

		if string.find(action, "restore") and rime.pvp.has_aff("shaderot_body", rime.target) then
			time = tonumber(time)*2
		end
	
		if rime.timer[action] then killTimer(rime.timer[action]) end
		rime.limit[action] = true
		rime.timer[action] = tempTimer(time, [[limitEnd("]]..action..[[")]])
		
	end

end

function limitEnd(action, person)

	if rime.timer[action] then killTimer(rime.timer[action]) end
	rime.limit[action] = false
	
	if string.find(action, "rev_crippled") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local shmuck = action:gsub("rev_crippled_","")
		rime.pvp.remove_aff("crippled", shmuck)
	end

	if string.find(action, "resonance") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local shmuck = action:gsub("resonance_","")
		rime.pvp.remove_aff("resonance", shmuck)
	end

	if string.find(action, "rev_crippled_body") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local shmuck = action:gsub("rev_crippled_body_","")
		rime.pvp.remove_aff("crippled_body", shmuck)
	end

	if string.find(action, "_numbed_") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local shmuck = action:gsub("%a+_%a+_numbed_","")
		rime.pvp.remove_aff(action:gsub("_"..shmuck, ""), shmuck)
	end

	if string.find(action, "flared_") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local shmuck = action:gsub("flared_","")
		rime.pvp.remove_aff("flared", shmuck)
	end

	if string.find(action, "weak_void") then
		action = action:gsub("weak_void_", "")
		rime.pvp.remove_aff("weak_void", action)
	end

	if string.find(action, "crushed_elbows") then
		action = action:gsub("crushed_elbows_", "")
		rime.pvp.remove_aff("crushed_elbows", action)
	end

	if action == "hypnosis" then
		if #syssin.suggests_added ~= 0 then
			syssin.suggests_added = {}
			syssin.sealed = false
			rime.echo("NEW HYPNOSIS CHAIN INCOMING", "pvp")
		end
	end

	if string.find(action, "stonevice") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		action = action:gsub("_stonevice", "")
		action = string.title(action)
		rime.pvp.remove_aff("stonevice", action)
	end
  
  	if string.find(action, "feast") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		action = action:gsub("_feast", "")
		action = string.title(action)
		rime.pvp.remove_aff("blood_feast", action)
	end
  
	if string.find(action, "sandrot") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		action = action:gsub("_sandrot", "")
		action = string.title(action)
		rime.pvp.remove_aff("sandrot", action)
	end

	if action == "gloom_cure" then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		if not rime.pvp.has_def("blind", rime.target) then
			rime.pvp.remove_aff("gloom", rime.target)
		end
	end

	if action == "soul_master" then
		rime.pvp.soul_master = true
		rime.echo("Need to lose the soulmaster!")
	end

	if string.find(action, "restore") then
		rime.limit[action] = false
		killTimer(rime.timer[action])
		local limb = action:gsub("_restore", "")
		if limb == "torso" and rime.pvp.has_aff("collapsed_lung", rime.target) then
			rime.pvp.remove_aff("collapsed_lung", rime.target) 
		elseif rime.pvp.has_aff(limb.."_amputated", rime.target) then
			rime.pvp.remove_aff(limb.."_amputated", rime.target)
		else
			if rime.pvp.regenerate then
				if rime.pvp.has_aff(limb.."_mangled", rime.target) then
					rime.pvp.remove_limb(limb, 4500, rime.target)
				elseif rime.pvp.has_aff(limb.."_damaged", rime.target) then
					rime.pvp.remove_limb(limb, 4000, rime.target)
				end
			else
				rime.pvp.remove_limb(limb, 3000, rime.target)
			end
			if limb == "head" and rime.pvp.has_aff("voidgaze", rime.target) then
				rime.pvp.remove_aff("voidgaze", rime.target)
			elseif rime.pvp.has_aff(limb.."_mangled", rime.target) then
				rime.pvp.remove_aff(limb.."_mangled", rime.target)
			elseif rime.pvp.has_aff(limb.."_damaged", rime.target) then
				rime.pvp.remove_aff(limb.."_damaged", rime.target)
				if limb == "torso" and rime.pvp.has_aff("soulpuncture", rime.target) then
					rime.pvp.remove_aff("soulpuncture", rime.target)
				end
			end
		end
	end
	
end

function add_target(target)

	target = string.title(target)

	if not rime.targets[target] then
			
		rime.targets[target] = {
			parry = "nothing",
     		["mana"] = 100,
     		aggro = 0,
     		adder = false,
     		["deliverance"] = false,
			["cooldowns"] = {
				focus = false,
			},
			["time"] = {
				poulticeBalance = 0,
			},
			["limbs"] = {
				head = 0,
				torso = 0,
				left_arm = 0,
				right_arm = 0,
				left_leg = 0,
				right_leg = 0,
			},
			["stacks"] = {
				gravity = 0,
				shaderot = 0,
				ablaze = 0,
				gloom = 0,
				stonevice = 0,
			},
			["soul"] = 100,
			["bloodburstCount"] = 0,
			["afflictions"] = {
			},
			["defences"] = {
				blind = true,
				deaf = true,
				firefly = true,
				fangbarrier = true,
				cloak = true,
				speed = true,
				rebounding = true,
				shielded = false,
				prismatic = false,
				clarity = true,
				fitness = true,
				insulation = true,
				instawake = true,
				insomnia = true,
				metawake = false,
				venom_resistance = true,
				temperance = true,	
				lightform = false,
				
			},
		}
		
		rime.echo("<DeepPink>"..target.."<white> added to target list.")
		
	end

end

rime.stopwatch = rime.stopwatch or {}

function rime.time(thing, player)

	if player then

		player = string.title(player)
		if rime.targets[player] == nil then return end

		rime.targets[player].time[thing] = rime.targets[player].time[thing] or createStopWatch()

		resetStopWatch(rime.targets[player].time[thing])

		startStopWatch(rime.targets[player].time[thing])

	else

		rime.stopwatch[thing] = rime.stopwatch[thing] or createStopWatch()

		resetStopWatch(rime.stopwatch[thing])

		startStopWatch(rime.stopwatch[thing])

	end

end


function rime.checkTime(thing, player)

	if player then
		if rime.targets[player] == nil then return 0 end

		player = string.title(player)

		if rime.targets[player].time[thing] == nil then rime.echo("Wasn't being timed!") rime.time(thing, player) end

		rime.echo("Time on "..player.."'s "..thing.." is "..getStopWatchTime(rime.targets[player].time[thing]))

		if thing == "focus" then

			if rime.getTime("focus", player) > 4.9 then

				rime.targets[player].cooldowns.focus = false

			end

		end

	else

		rime.echo("Time on <SandyBrown>"..thing.."<white> is <SandyBrown>"..getStopWatchTime(rime.stopwatch[thing]))

	end

end

function rime.getTime(thing, player)

	if player then

		player = string.title(player)
		if rime.targets[player].time[thing] == nil then return 0 end

		return tonumber(getStopWatchTime(rime.targets[player].time[thing]))

	else

		return tonumber(getStopWatchTime(rime.stopwatch[thing]))

	end

end

function rime.stopTime(thing, player)

	if player then

		player = string.title(player)

		resetStopWatch(rime.targets[player].time[thing])

		rime.echo("Time on "..player.."'s "..thing.." is "..getStopwatchTime(rime.targets[player].time[thing]))

	else

		resetStopWatch(rime.stopwatch[thing])

		rime.echo("Time on <SandyBrown>" .. thing .. "<white> is <SandyBrown>" .. getStopWatchTime(rime.stopwatch[thing]))

	end

end

GUI = {}

function GUI.target_aff()
	local enemyAffTable = {}
	local target = rime.target

	clearWindow("targetafflictionDisplay")

	if rime.targets[target] == nil then
		cecho("targetafflictionDisplay", "\n <DodgerBlue>Target cannot have afflictions.")
	else
    	for k,v in pairs(rime.targets[target].afflictions) do
        	if v then
        		if not rime.saved.affColors[k] then
        			table.insert(enemyAffTable, k)
        		else
        			table.insert(enemyAffTable, rime.saved.affColors[k])
        		end
        	end
    	end
	  	if #enemyAffTable >= 1 then
	    	for i=1, table.size(enemyAffTable), 1 do
	      		cecho("targetafflictionDisplay", enemyAffTable[i].."\n")
	    	end
	  	else
	    	cecho("targetafflictionDisplay", "\n <DodgerBlue>"..rime.target.." has no afflictions.")
	  	end
	end
  
end

function rime.movement.direction(dir)

    local sep = rime.saved.separator
    local monolith = "monolith"
    local cube = "cubesigil"
    if rime.saved.monolith then
        monolith = rime.saved.monolith
    end
    if rime.saved.cube then
        cube = rime.saved.cube
    end
    

    if rime.movement.mode == "sigil" then
        act("get " .. monolith .. sep .. "get " .. cube .. sep .. dir .. sep .. "drop " .. monolith .. sep .. "drop " .. cube)
    else
        act(dir)
    end

end

function rime.artifact_toggle(arti, status)

  arti = arti:lower()
  if arti == "goggles" then status = tonumber(status) else status = status:lower() end
  if status == "off" then status = "no" end
  if status == "on" then status = "yes" end
  if status == "true" then status = "on" end
  if status == "false" then status = "off" end
  local hit_one = false
  
  if arti == "pipes" or arti == "pipe" then
    hit_one = true
    if status == "yes" then
      rime.saved.arti_pipes = true
      rime.echo("Will no longer try to light pipes!")
      rime.echo("<red>ONLY USE THIS SETTING IF YOU HAVE THREE (3) ARTIFACT PIPES!")
    else
      rime.saved.arti_pipes = false
      rime.echo("Will now keep your pipes lit!")
    end
  end

  if arti == "web" or arti == "webspray" then
    hit_one = true
    if status == "yes" then
      rime.saved.webspray = true
      rime.echo("Will use webspray instead of web tattoo now!")
    else
      rime.saved.webspray = false
      rime.echo("Will now use the web tattoo!")
    end
  end
  
  if arti == "mass" or arti == "density" or arti == "stability" then
    hit_one = true
    if status == "yes" then
    	rime.saved.stability = true
    	rime.echo("Will use artifact stability!")
    else
    	rime.saved.stability = false
    	rime.echo("Will use mass salve!")
    end
  end
  
  if arti == "mana_boon" or arti == "manaboon" then
    hit_one = true
    if status == "yes" then
    	rime.saved.mana_boon = true
    	rime.echo("Enabled mana_boon costs for clot!")
    else
    	rime.saved.mana_boon = false
    	rime.echo("Disabled mana_boon costs for clot!")
    end
  end

  if arti == "lifevision" then
    hit_one = true
    if status == "yes" then
    	rime.saved.lifevision = true
    	rime.echo("Will use artifact lifevision!")
    else
    	rime.saved.lifevision = false
    	rime.echo("Will not use artifact lifevision!")
    end
  end
  
  if arti == "lifesense" then
    hit_one = true
    if status == "yes" then
    	rime.saved.lifesense = true
    	rime.echo("Enabled lifesense defense!")
    else
    	rime.saved.lifesense = false
    	rime.echo("Disabled lifesense defense!")
    end
  end

  if arti == "zephyr" then
    hit_one = true
    if status == "yes" then
    	rime.saved.zephyr = true
    	rime.echo("Enabled zephyr defense!")
    else
    	rime.saved.zephyr = false
    	rime.echo("Disabled zephyr defense!")
    end
  end
  
  if arti == "mindseye" then
    hit_one = true
    if status == "yes" then
    	rime.saved.mindseye = true
    	rime.echo("Will ignore mindseye defense!")
    else
    	rime.saved.mindseye = false
    	rime.echo("Will use allsight or mindseye!")
    end
  end
  
  if arti == "goggles" then
    hit_one = true
    if status == 0 then
    	rime.saved.goggles = 0
    	rime.echo("Removing goggle toggles")
    else
    	rime.saved.goggles = status
    	rime.echo("Goggle toggle set to level "..status)
    end
  end

  if arti == "bracer" then
      hit_one = true
      if status == "yes" then
          rime.saved.bracer = true
          rime.echo("Rime now supports remote diagnose in its offenses!")
      else
          rime.saved.bracer = false
          rime.echo("Rime will now skip any remote diagnosing built into offenses!")
      end
  end
  
  if not hit_one then 
    rime.echo("That artifact currently isn't supported by Rime! Maybe if Mjoll or Bulrok magically found one in their inventories, they'd be motivated to add it!")
  else
   table.save(getMudletHomeDir().."/rime.saved.lua", rime.saved)
  end 

end