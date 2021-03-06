AddEventHandler("properload", function()
    -- Let the server know that the player has joined properly.
    TriggerServerEvent( "properload")
end)

RegisterNetEvent('playSound')
AddEventHandler('playSound', function()
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 0,0,1)
end)

function SetBlipOnLocation(x, y, z)
    local blip1 = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip1, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('10-13')
    SetBlipColour(blip1, 1)
    EndTextCommandSetBlipName(blip1)
    Citizen.Wait(100000)
    RemoveBlip(blip1)
end


RegisterNetEvent('displayblip')
AddEventHandler('displayblip', function()
    local pos=GetEntityCoords(GetPlayerPed(-1), true)
    TriggerServerEvent('activateblip', pos.x,pos.y,pos.z)	
end)

RegisterNetEvent('bliplocation')
AddEventHandler('bliplocation', function(x,y,z)
    SetBlipOnLocation(x,y,z)
end)

-- Make a new command "13"
RegisterCommand('13', function(source, args, rawCommand)
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped, false))
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
	local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
    local current_zone = zones[GetNameOfZone(x, y, z)]
    local message = ""
	if crossing ~= nil then
        crossing = GetStreetNameFromHashKey(crossing)
        message = "^1 10-13 at " .. streetName .. " ^1and " .. crossing .. " ^1 in " .. current_zone .. ""
    else
        message = "^1 10-13 near " .. streetName .. " ^1 in " .. current_zone .. ""
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