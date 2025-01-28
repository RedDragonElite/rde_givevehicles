RegisterNetEvent('rde_givevehicles:spawnVehicle')
AddEventHandler('rde_givevehicles:spawnVehicle', function(vehicleModel)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    print("Attempting to spawn: " .. vehicleModel)

    local hash = GetHashKey(vehicleModel)
    print("Hash: " .. hash)
    print("Model in cdimage: " .. tostring(IsModelInCdimage(hash)))

    if not IsModelValid(hash) then
        lib.notify({type = 'error', description = 'Invalid vehicle model'})
        return
    end

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
        print("Loading model...")
    end

    local vehicle = CreateVehicle(hash, coords.x + 2.0, coords.y + 2.0, coords.z, GetEntityHeading(playerPed), true, true)

    if DoesEntityExist(vehicle) then
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(hash)
        lib.notify({type = 'success', description = 'Vehicle spawned'})
    else
        lib.notify({type = 'error', description = 'Failed to spawn vehicle'})
    end
end)
