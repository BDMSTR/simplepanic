
local cops = {}


-- Run this when a user enters a message in chat
RegisterServerEvent('sendChatMessage')
AddEventHandler('sendChatMessage', function(message)
	-- Sets variable 'player' to the players SteamId
	player = GetPlayerIdentifiers(source)[1]
	-- Fetches all rows from the database table 'users' where the column 'identifier' equals the players SteamId
	local result = MySQL.Sync.fetchAll(
	  'SELECT * FROM users WHERE identifier = @identifier',
	  {
		['@identifier'] = player
	  }
	)
	-- Loops through the result and allows you to call from the database results
	for i=1, #result, 1 do
	
		if #cops == 0 then
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions!")
		else
			-- If the resulted user is a police officer then do the following
			if result[i].job == 'police' then
				-- Loop through the table cops
				for _,id in ipairs(cops) do
					-- Sent a chat message to all id's in the table cops 
					TriggerClientEvent('chatMessage', id, '', {255,255,255}, message)
					CancelEvent()
					TriggerClientEvent('playSound', id)
				end
			-- If the resulted user is not a police officer then do the following
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions!")
			end
		end
	end
end)


-- Client triggers this event after they load in correctly

RegisterServerEvent('properload')
AddEventHandler('properload', function()
	-- Sets variable 'id' to the source 'id'
	local id = source
	-- Sets variable 'player' to the players SteamId
	local player = GetPlayerIdentifiers(id)[1]
	-- Fetches all rows from the database table 'users' where the column 'identifier' equals the players SteamId
	local result = MySQL.Sync.fetchAll(
	  'SELECT * FROM users WHERE identifier = @identifier',
	  {
		['@identifier'] = player
	  }
	)
	
	-- Loops through the results and if the users column 'job' equals police it inserts the users id into the table 'cops'
	for i=1, #result, 1 do
		if result[i].job == 'police' then
			table.insert(cops, id)
		end
	end
end)

