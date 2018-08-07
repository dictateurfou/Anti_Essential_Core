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

RegisterNetEvent('AntiEssentialCore:sendNotif')
AddEventHandler('AntiEssentialCore:sendNotif', function(mess)

sendnotif(mess)

end)

RegisterNetEvent('AntiEssentialCore:initializeinfo')
AddEventHandler('AntiEssentialCore:initializeinfo', function(money,dirtymoney,bankbalance)

SendNUIMessage({
       initialise = true,
       money = money,
       dirtymoney = dirtymoney,
       bankbalanceinfo = bankbalance
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
	addDirtyMoney = tonumber(rslt)
})

end)


RegisterNetEvent('AntiEssentialCore:rmvDirtyMoney')
AddEventHandler('AntiEssentialCore:rmvDirtyMoney', function(rslt)

SendNUIMessage({
	rmvDirtyMoney = rslt
})

end)


RegisterNetEvent('AntiEssentialCore:setDirtyMoney')
AddEventHandler('AntiEssentialCore:setDirtyMoney', function(rslt)

SendNUIMessage({
	dirtymoneyinfo = rslt
})

end)


function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end



Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', 'Emperor - Discord obligatoire : https://discord.gg/g9k2b5n')
end)



function GetVehicleInDirection(coordFrom, coordTo)
  local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
  local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
  sendnotif(tostring(vehicle))
  return vehicle
end

function GetVehicleLookByPlayer(dist)
  local playerPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 0.0 )
  local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, dist, -0.8)
  return GetVehicleInDirection(playerPos, inFrontOfPlayer)
end

function getArroundPed()
  player = 0
  tabevent = {}
  for id = 0, 32 do

    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) then

      ped = GetPlayerPed(id)

      cord1 = GetEntityCoords(GetPlayerPed(-1),true)
      cord2 = GetEntityCoords(GetPlayerPed(id),true)
      distance = GetDistanceBetweenCoords(cord1.x, cord1.y, cord1.z, cord2.x, cord2.y, cord2.z, true)
      if distance < 1 then 
        if player == 0 then
          playerserverid = GetPlayerServerId(id)
        end
        player = player + 1
      end
    end
  end

  if player == 1 then
    playid = playerserverid
  elseif player > 1 then
    sendnotif('~r~trop de joueur autour')
    playid = 0
  else
    sendnotif('~g~personne autour')
    playid = 0
  end
  return playid
end

function NoWeaponDrops() -- This function will set the closest entity to you as the variable entity.

    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat
        if not IsEntityDead(ped) then
            pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false)
        end
    end

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        NoWeaponDrops()
        DisablePlayerVehicleRewards(PlayerId())

    end
end)

--[[

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(5000)
		local vehicle = GetVehicleLookByPlayer(3.0)
		local vehicleLookedPlate = GetVehicleNumberPlateText(vehicle)
		sendnotif(tostring(vehicleLookedPlate))
		if vehicle ~= 0 then
			sendnotif(tostring(vehicle))
		end
	end
end)]]--