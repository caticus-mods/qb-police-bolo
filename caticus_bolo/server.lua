local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('caticus_bolo:addBolo')
AddEventHandler('caticus_bolo:addBolo', function(vehiclePlate)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local reportedBy = xPlayer.PlayerData.citizenid

        local query = "INSERT INTO caticus_bolo (vehicle_plate, reported_by) VALUES (?, ?)"
        MySQL.Async.execute(query, {vehiclePlate, reportedBy}, function(rowsChanged)
            if rowsChanged then
                print("Bolo added successfully")
            else
                print("Failed to add bolo")
            end
        end)
    end
end)

RegisterServerEvent('caticus_bolo:searchBolo')
AddEventHandler('caticus_bolo:searchBolo', function(vehiclePlate)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        local query = "SELECT * FROM caticus_bolo WHERE vehicle_plate = ?"
        MySQL.Async.fetchAll(query, {vehiclePlate}, function(result)
            if result and #result > 0 then
                TriggerClientEvent('QBCore:Notify', src, 'WANTED VEHICLE', 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'No Records Found', 'error')
            end
        end)
    end
end)

RegisterServerEvent('caticus_bolo:deleteBolo')
AddEventHandler('caticus_bolo:deleteBolo', function(vehiclePlate)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        local query = "DELETE FROM caticus_bolo WHERE vehicle_plate = ?"
        MySQL.Async.execute(query, {vehiclePlate}, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('QBCore:Notify', src, 'Bolo record deleted successfully', 'success')
            else
                TriggerClientEvent('QBCore:Notify', src, 'No matching record found for deletion', 'error')
            end
        end)
    end
end)
