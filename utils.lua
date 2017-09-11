--[[
###################################################
# Author:Dictateurfou							  #
# plugin_name:AntiEssentialCore					  #
# description:All function 					 	  #
###################################################
]]--

config = {
	money = 5000,
	bankbalance = 5000,
	dirtymoney = 0
}

local playerInfoMoney = {}


function getIdentifiant(id)

  for _, v in ipairs(id) do
      return v
  end

end

function getIdentifier(id)
    local identifiers = GetPlayerIdentifiers(id)
    local player = getIdentifiant(identifiers)
    return player
end

--return not work dont use this function
function getPlayerInfo(id)
	local player = getIdentifier(id)

	local info = MySQL.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = player
    })


	if playerInfoMoney[player] == nil and info[1] ~= nil then
		playerInfoMoney[player] = {["money"] = info[1].money,["bankbalance"] = info[1].bankbalance,["dirtymoney"] = info[1].dirtymoney}
	end


    return info
end

function getPlayerAllMoney(id)
	local player = getIdentifier(id)

	if playerInfoMoney[player] == nil then
		local info = MySQL.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = player
    	})	
		playerInfoMoney[player] = {["money"] = info[1].money,["bankbalance"] = info[1].bankbalance,["dirtymoney"] = info[1].dirtymoney}
	end

	return playerInfoMoney[player]

end


function createUser(id)
	local player = getIdentifier(id)

	MySQL.Async.execute("INSERT INTO `users` (`identifier`, `group`, `permission_level`, `money`, `bankbalance`,`dirtymoney`) VALUES (@identifier,'user', '0', @money, @bankbalance, @dirtymoney) ", {
		['@identifier'] = player,
		['@money'] = tonumber(config.money),
		['@bankbalance'] = tonumber(config.bankbalance),
		['@dirtymoney'] = tonumber(config.dirtymoney)
    })
	playerInfoMoney[player] = {["money"] = config.money,["bankbalance"] = config.bankbalance,["dirtymoney"] = config.dirtymoney}
    print('nouvel user '..player..' enrengistrer')
end

function removeMoney(id,rmv)
	local player = getIdentifier(id)
	playerInfoMoney[player].money = tonumber(playerInfoMoney[player].money - rmv)
	MySQL.Async.execute("UPDATE users SET money = money - @rmv WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@rmv'] = tonumber(rmv)
    })

    TriggerClientEvent('AntiEssentialCore:rmvMoney',id,rmv)
end

function AddMoney(id,add)
	local player = getIdentifier(id)
	playerInfoMoney[player].money = tonumber(playerInfoMoney[player].money + add)
	MySQL.Async.execute("UPDATE users SET money = money + @add WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@add'] = tonumber(add)
    })
    print('AddMoney playerid = '..player..' et money '.. add)
    TriggerClientEvent('AntiEssentialCore:addMoney',id,add)
end

function addBank(id,add)
	local player = getIdentifier(id)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].bankbalance + add)
	MySQL.Async.execute("UPDATE users SET bankbalance = bankbalance + @add WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@add'] = tonumber(add)
    })
    TriggerClientEvent('AntiEssentialCore:addBank',id,add)
end

function removeBank(id,rmv)
	local player = getIdentifier(id)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].bankbalance - rmv)
	MySQL.Async.execute("UPDATE users SET bankbalance = bankbalance - @rmv WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@rmv'] = tonumber(rmv)
    })
    TriggerClientEvent('AntiEssentialCore:rmvMoney',id,rmv)
end

function removeMoneyForBank(id,rmv)
	local player = getIdentifier(id)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].money - rmv)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].bankbalance + rmv)
	MySQL.Async.execute("UPDATE users SET bankbalance = bankbalance + @rmv, money = money - @rmv WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@rmv'] = tonumber(rmv)
    })
    TriggerClientEvent('AntiEssentialCore:removeMoneyForBank',id,rmv)
end

function removeBankForMoney(id,rmv)
	local player = getIdentifier(id)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].money + rmv)
	playerInfoMoney[player].bankbalance = tonumber(playerInfoMoney[player].bankbalance - rmv)
	MySQL.Async.execute("UPDATE users SET bankbalance = bankbalance - @rmv, money = money + @rmv WHERE identifier = @identifier", {
		['@identifier'] = player,
		['@rmv'] = tonumber(rmv)
    })
    TriggerClientEvent('AntiEssentialCore:removeBankForMoney',id,rmv)
end

