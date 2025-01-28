local vehicles = {}

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    -- Create a lookup table with model names
    for _, vehicle in ipairs(Config.Vehicles) do
        vehicles[vehicle.name:lower()] = vehicle.name
    end
end)

-- Placeholder for IsModelInCdimage function
function IsModelInCdimage(hash)
    -- Implement the actual check here
    -- This is just a placeholder and should be replaced with the actual implementation
    return true
end

RegisterCommand('giveownedvehicle', function(source, args, rawCommand)
    local src = source

    if not IsPlayerAceAllowed(source, "command.givecustomvehicle") then
        lib.notify(src, {type = 'error', description = 'No permission'})
        return
    end

    if #args < 2 then
        lib.notify(src, {type = 'inform', description = 'Usage: /giveownedvehicle [playerId] [modelName]'})
        return
    end

    local targetId = tonumber(args[1])
    local vehicleModel = args[2]:lower() -- Take only the model name

    -- Direct check of the model name
    local hash = GetHashKey(vehicleModel)
    if not IsModelInCdimage(hash) then
        lib.notify(src, {type = 'error', description = 'Invalid vehicle model'})
        return
    end

    TriggerClientEvent('rde_givevehicles:spawnVehicle', targetId, vehicleModel)
    lib.notify(src, {type = 'success', description = 'Vehicle spawned for player ' .. targetId})

    -- Save the vehicle to the owned_vehicles table
    local xPlayer = ESX.GetPlayerFromId(targetId)
    if xPlayer then
        local plate = GeneratePlate()
        local vehicleData = json.encode({model = vehicleModel, plate = plate})
        exports.oxmysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored) VALUES (@owner, @plate, @vehicle, @type, @job, @stored)', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate,
            ['@vehicle'] = vehicleData,
            ['@type'] = 'car',
            ['@job'] = 'civ',
            ['@stored'] = 1
        }, function(rows)
            if rows.affectedRows > 0 then
                lib.notify(src, {type = 'success', description = 'Vehicle saved to garage'})
            else
                lib.notify(src, {type = 'error', description = 'Failed to save vehicle to garage'})
            end
        end)
    end
end, false)

-- Function to generate a random plate in the format "YBB 123"
function GeneratePlate()
    local characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    -- Generate three random letters - use the same position for start and end
    local pos1 = math.random(1, 26)
    local pos2 = math.random(1, 26)
    local pos3 = math.random(1, 26)
    
    local letter1 = characters:sub(pos1, pos1)
    local letter2 = characters:sub(pos2, pos2)
    local letter3 = characters:sub(pos3, pos3)
    
    -- Generate three random numbers
    local num1 = tostring(math.random(0, 9))
    local num2 = tostring(math.random(0, 9))
    local num3 = tostring(math.random(0, 9))
    
    return letter1 .. letter2 .. letter3 .. ' ' .. num1 .. num2 .. num3
end