--[[
###################################################
# Author:dictateurfou							  #
# plugin_name:AntiEssentialCore					  #
# description:All Event And ui Gestion for client #
###################################################
]]--

local firstSpawn = true


local function sendnotif(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)	
end

AddEventHandler("playerSpawned", function(spawn)

    if firstSpawn == true then
    TriggerServerEvent('AntiEssentialCore:spawn')
    firstSpawn = false
    end
end)

RegisterNetEvent('AntiEssentialCore:initializeinfo')
AddEventHandler('AntiEssentialCore:initializeinfo', function(money,dirtymoney,bankbalance)

SendNUIMessage({
       initialise = true,
       money = money,
       dirtymoney = dirtymoney,
       bankbalance = bankbalance
})

end)

RegisterNetEvent('AntiEssentialCore:bankbalance')
AddEventHandler('AntiEssentialCore:bankbalance', function(rslt) 

SendNUIMessage({
    bankbalanceinfo = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:dirtymoney')
AddEventHandler('AntiEssentialCore:dirtymoney', function(rslt) 

SendNUIMessage({
    dirtymoneyinfo = rlst
})

end)

RegisterNetEvent('AntiEssentialCore:money')
AddEventHandler('AntiEssentialCore:money', function(rslt) 

SendNUIMessage({
	moneyinfo = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:rmvMoney')
AddEventHandler('AntiEssentialCore:rmvMoney', function(rslt) 

SendNUIMessage({
	rmvMoney = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:addMoney')
AddEventHandler('AntiEssentialCore:addMoney', function(rslt) 

SendNUIMessage({
	addMoney = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:rmvBank')
AddEventHandler('AntiEssentialCore:rmvBank', function(rslt) 

SendNUIMessage({
	rmvBank = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:addBank')
AddEventHandler('AntiEssentialCore:addBank', function(rslt) 

SendNUIMessage({
	addBank = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:removeMoneyForBank')
AddEventHandler('AntiEssentialCore:removeMoneyForBank', function(rslt) 

SendNUIMessage({
	rmvMoneyForBank = rslt
})

end)

RegisterNetEvent('AntiEssentialCore:removeBankForMoney')
AddEventHandler('AntiEssentialCore:removeBankForMoney', function(rslt) 

SendNUIMessage({
	rmvBankForMoney = rslt
})

end)


RegisterNetEvent('AntiEssentialCore:addDirtyMoney')
AddEventHandler('AntiEssentialCore:addDirtyMoney', function(rslt)

SendNUIMessage({
	addDirtyMoney = rslt
})

end)


RegisterNetEvent('AntiEssentialCore:rmvDirtyMoney')
AddEventHandler('AntiEssentialCore:rmvDirtyMoney', function(rslt)

SendNUIMessage({
	rmvDirtyMoney = rslt
})

end)



--Citizen.CreateThread(function ()
--	while true do
--		Citizen.Wait(5000)
--		TriggerServerEvent('testMoney')
--	end
--end)