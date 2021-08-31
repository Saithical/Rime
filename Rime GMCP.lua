rime.vitals.max_health = 0
rime.vitals.max_mana = 0
rime.vitals.current_health = 0
rime.vitals.current_mana = 0
rime.vitals.percent_health = 0
rime.vitals.percent_mana = 0
rime.vitals.wielded_left = 0
rime.vitals.wielded_right = 0
rime.vitals.bleeding = 0

function rime.gmcp.getVitals()

	rime.vitals.max_health = tonumber(gmcp.Char.Vitals.maxhp) or 0
	rime.vitals.max_mana = tonumber(gmcp.Char.Vitals.maxmp) or 0
	rime.vitals.current_health = tonumber(gmcp.Char.Vitals.hp) or 0
    rime.vitals.current_mana = tonumber(gmcp.Char.Vitals.mp) or 0
	rime.vitals.percent_health = returnPercent(rime.vitals.current_health, rime.vitals.max_health) or 0
	rime.vitals.percent_mana = returnPercent(rime.vitals.current_mana, rime.vitals.max_mana) or 0
	rime.vitals.wielded_left = gmcp.Char.Vitals.wield_left or 0
	rime.vitals.wielded_right = gmcp.Char.Vitals.wield_right or 0
	rime.vitals.bleeding = tonumber(gmcp.Char.Vitals.bleeding) or 0
	if gmcp.Char.Vitals.cloak == "1" then rime.defences.general.cloak.deffed = true else rime.defences.general.cloak.deffed = false end

	if rime.vitals.current_health == tonumber(0) then
		rime.vitals.dead = true
	else
		rime.vitals.dead = false
	end

	if gmcp.Char.Status.class == "Revenant" then
		rime.vitals.left_charge =  tonumber(gmcp.Char.Vitals.charge_left)
		rime.vitals.right_charge =  tonumber(gmcp.Char.Vitals.charge_right)
	end

	if gmcp.Char.Status.class == "Teradrim" then

		local stats = gmcp.Char.Vitals.charstats
		local spec = ""
		for i,v in ipairs(stats) do
			stat = string.split(v, ": ")
			if stat[1] == "Sandstorm" then
				rime.vitals.sandstorm = tonumber(stat[2])
			end
		end

	end

if gmcp.Char.Status.class == "Sciomancer" then

	rime.vitals.shadowprice = tonumber(gmcp.Char.Vitals.shadowprice)

end

if gmcp.Char.Vitals.ability_bal == "1" then
	rime.balances.ability = true
else
	rime.balances.ability = false
end

if gmcp.Char.Vitals.balance == "1" then
	rime.balances.balance = true
else
	rime.balances.balance = false
end

if gmcp.Char.Vitals.equilibrium == "1" then
	rime.balances.equilibrium = true
else
	rime.balances.equilibrium = false
end

if gmcp.Char.Vitals.herb == "1" then
	rime.balances.pill = true
else
	rime.balances.pill = false
end

if gmcp.Char.Vitals.renew == "1" then
	rime.balances.renew = true
else
	rime.balances.renew = false
end

if gmcp.Char.Vitals.salve == "1" then
	rime.balances.salve = true
else
	rime.balances.salve = false
end

if gmcp.Char.Vitals.tree == "1" then
	rime.balances.tree = true
else
	rime.balances.tree = false
end

if gmcp.Char.Vitals.elixir == "1" then
	rime.balances.elixir = true
else
	rime.balances.elixir = false
end

if gmcp.Char.Vitals.pipe == "1" then
	rime.balances.pipe = true
else
	rime.balances.pipe = false
end

if gmcp.Char.Vitals.affelixir == "1" then
	rime.balances.affelixir = true
else
	rime.balances.affelixir = false
end

if gmcp.Char.Vitals.fangbarrier == "1" then
	rime.defences.general.fangbarrier.deffed = true
else
	rime.defences.general.fangbarrier.deffed = false
end

if gmcp.Char.Vitals.focus == "1" then
	rime.balances.focus = true
else
	rime.balances.focus = false
end

if gmcp.Char.Vitals.prone == "1" then
	rime.vitals.prone = true
else
	rime.vitals.prone = false
end

local writhes = {"mob_impaled", "writhe_vines", "writhe_impaled", "writhe_grappled", "writhe_web", "writhe_armpitlock", "writhe_necklock", "writhe_thighlock", "writhe_feed", "writhe_transfix", "writhe_bind", "writhe_noose", "writhe_ropes", "writhe_stasis", "writhe_gunk",}
local foundWrithe = false
for k,v in pairs(writhes) do
	if rime.has_aff(v) then
		foundWrithe = true
	end
end

if (rime.has_possible_aff("indifference") or rime.cure_set == "zealot" or rime.cure_set == "group") 
	and gmcp.Char.Vitals.mounted == rime.saved.mount and rime.vitals.prone 
	and not foundWrithe and not rime.has_aff("paralysis") and not rime.has_aff("asleep") and not rime.has_aff("stun") then
	rime.silent_addAff("indifference")
elseif not rime.vitals.prone and rime.has_aff("indifference") then
	rime.echo("maybe?")
	if rime.has_aff("indifference") then rime.silent_remAff("indifference") end
end

if gmcp.Char.Vitals.moss == "1" then
	rime.balances.moss = true
else
	rime.balances.moss = false
end

if gmcp.Char.Vitals.deaf == "1" then
	if rime.has_aff("deaf") then rime.silent_remAff("deaf") end
	rime.remove_possible_aff("deaf", "no_echo")
else
	if rime.hidden_affs_total > 1 and rime.has_possible_aff("deaf") then
		rime.add_aff("deaf", "discovered")
	else
		rime.silent_addAff("deaf")
	end
end

if gmcp.Char.Vitals.blind == "1" then
	if rime.has_aff("blind") then rime.silent_remAff("blind") end
	rime.remove_possible_aff("blind", "no_echo")
else
	if rime.hidden_affs_total > 1 and rime.has_possible_aff("blind") then
		rime.add_aff("blind", "discovered")
	else
		rime.silent_addAff("blind")
	end
end



rime.balances.writhing = rime.balances.writhing or false

clot()

end