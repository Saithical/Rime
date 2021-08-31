
rime.mercantile = rime.mercantile or {}

rime.mercantile.enchantment = {

	["meteor_wanted"] = 0,
	["meteor"] = 0,
	["worrystone_wanted"] = 0,
	["worrystone"] = 0,
	["discernment_wanted"] = 0,
	["discernment"] = 0,
	["whirlwind_wanted"] = 0,
	["whirlwind"] = 0,

}

function rime.mercantile.enchant(number, item)

	rime.mercantile.enchantment[item.."_wanted"] = tonumber(number)

	rime.echo("<red>" .. number .. "<purple> " .. item .." <white>queued to enchant.")

end


function priceItems(type, price, shelf)
	priceprice = price
	priceshelf = shelf
	for k, v in pairs(priceItem) do
		if v == type then 
			send("drop " .. k)
			send("shop price item " .. k .. " " .. price .. " shelf " .. shelf)
		end
	end 
end


function priceCache(price, shelf)
	for k,v in pairs(curativePills) do
		send("shop price cache " .. v .. " ".. price .. " shelf " .. shelf)
	end
end


function priceFurniture()
	local timertime = 0
    for shelf in ipairs(furnitureDesigns) do
        for k,v in pairs(furnitureDesigns[shelf]) do
        	tempTimer(timertime, function() send("shop unprice design " .. k) end)
        	timertime = timertime+.2
			tempTimer(timertime, function() send("shop price design "..k.." "..v.." shelf "..shelf) end)
        end
    end
end

function priceFood()
	local timertime = 0
    for shelf in ipairs(foodDesigns) do
        for k,v in pairs(foodDesigns[shelf]) do
        	tempTimer(timertime, function() send("shop unprice design " .. k) end)
        	timertime = timertime+.2
			tempTimer(timertime, function() send("shop price design "..k.." "..v.." shelf "..shelf) end)
        end
    end
end

function priceClothing()
    for shelf in ipairs(clothingDesigns) do
        for k,v in pairs(clothingDesigns[shelf]) do
            send ("shop unprice design " .. k)
						send ("shop price design "..k.." "..v.." shelf "..shelf)
        end
    end
end