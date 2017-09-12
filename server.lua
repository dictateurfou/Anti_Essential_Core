--[[
###################################################
# Author:dictateurfou							  #
# plugin_name:AntiEssentialCore					  #
# description:All Event for server                #
###################################################
]]--


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



RegisterServerEvent('AntiEssentialCore:spawn')
AddEventHandler('AntiEssentialCore:spawn', function()
	local source = source
	local player = getPlayerInfo(source)
	print('passe ici')
	if player[1] ~= nil then
		print('testmoney'..player[1].money)
		TriggerClientEvent('AntiEssentialCore:initializeinfo', source,player[1].money,player[1].dirtymoney,player[1].bankbalance)	
	end
end)


AddEventHandler('playerConnecting', function(playerName, setKickReason)
	local source = source
	local player = getPlayerInfo(source)
	if player[1] == nil then
		createUser(source)
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


