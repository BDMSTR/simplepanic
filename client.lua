AddEventHandler("properload", function()
    -- Let the server know that the player has joined properly.
    TriggerServerEvent( "properload")
end)


-- Make a new command "13"
RegisterCommand('13', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped, false))
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
    local message = ""
    if crossing ~= nil then
        crossing = GetStreetNameFromHashKey(crossing)
        message = "^1 10-13 near ^3" .. streetName .. " ^1and ^3" .. crossing .. " ^1all units break and roll code 3."
    else
        message = "^1 10-13 near ^3" .. streetName .. " ^1all units break and roll code 3."
    end
    TriggerServerEvent('sendChatMessage', message)
end, false)

Citizen.CreateThread(function()
    while true do
        -- Wait 5 seconds after player has loaded in and trigger the event.
        Citizen.Wait( 5000 )

        if NetworkIsSessionStarted() then
            TriggerEvent('properload')
            return
        end
    end
end )