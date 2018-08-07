--[[
###################################################
# Author:dictateurfou							  #
# plugin_name:AntiEssentialCore					  #
# description:All Event for server                #
###################################################
]]--

config = {
	money = 0,
	bankbalance = 20000,
	dirtymoney = 0,
	defaultFood = 50,
	defaultWater = 50
}

whiteliste = false

playerInfoMoney = {}

players = {}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function test()
	print(dump(config))
end

RegisterServerEvent('AntiEssentialCore:spawn')
AddEventHandler('AntiEssentialCore:spawn', function()
	local source = source
	local player = getPlayerInfo(source)
	print('passe ici')
	if player[1] ~= nil then
		print('testmoney'..player[1].money)
		TriggerClientEvent('AntiEssentialCore:initializeinfo', source,player[1].money,player[1].dirtymoney,player[1].bankbalance)
		--exemple en dessous
		TriggerClientEvent('setNeed', source,player[1].food,player[1].water)

	else
		TriggerClientEvent('setNeed', source,config.defaultFood,config.defaultWater)
	end
end)


AddEventHandler('playerConnecting', function(playerName, setKickReason)
	local source = source
	local player = getPlayerInfo(source)
	local identifier = getIdentifier(source)
	local playerwl = MySQL.Sync.fetchAll("SELECT * FROM whitelist WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
	
	if player[1] == nil and whiteliste == false then
		createUser(source)
	elseif player[1] == nil and playerwl[1] ~= nil and whiteliste == true then
		createUser(source)
	elseif whiteliste == true and playerwl[1] == nil then
		setKickReason("vous n'étes pas whitlister")
		print("pas whiteliste!")
		CancelEvent()
	end
end)



AddEventHandler('AntiEssentialCore:log', function(log)
	ecrireLog(log)
end)

RegisterNetEvent('testMoney')
AddEventHandler('testMoney', function()
	local source = source
	AddMoney(source,2000)
end)


AddEventHandler('playerDropped', function()
	local source = source
	local player = getIdentifier(source)
    players[player] = nil
    playerInfoMoney[player] = nil
end)

