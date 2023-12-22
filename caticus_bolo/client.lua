local display = false
local QBCore = exports['qb-core']:GetCoreObject()

function SetDisplay(bool)
  display = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({ type = "ui", status = bool })
end


RegisterCommand("bolo", function()
  local player = PlayerId()
  local ped = PlayerPedId()


  if QBCore.Functions.GetPlayerData().job.name == "police" then
      SetDisplay(not display)
  else

      TriggerEvent("chatMessage", "^1Error", {255, 0, 0}, "You must be a police officer to use this command.")
  end
end, false)

RegisterNUICallback('exit', function(data)
    SetDisplay(false)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if display then
            DisableControlAction(0, 1, true) 
            DisableControlAction(0, 2, true) 
            DisableControlAction(0, 142, true) 
            DisableControlAction(0, 18, true) 
            DisableControlAction(0, 322, true)
            DisableControlAction(0, 106, true) 
        end
    end
end)

function openDashboard()
  SetDisplay(true)
end

exports("openDashboard", openDashboard)





RegisterNUICallback('deleteBolo', function(data, cb)
  TriggerServerEvent('caticus_bolo:deleteBolo', data.vehiclePlate)
end)

RegisterNUICallback('addBolo', function(data, cb)
  TriggerServerEvent('caticus_bolo:addBolo', data.vehiclePlate)
  cb('ok')
end)


RegisterNUICallback('searchBolo', function(data, cb)
  TriggerServerEvent('caticus_bolo:searchBolo', data.vehiclePlate)
  cb('ok')
end)



















