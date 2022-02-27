local QBCore = exports["qb-core"]:GetCoreObject()
local currentClass = "A"
local vaildveh = false
local player = QBCore.Functions.GetPlayerData()
PlayerJob = {}
PlayerJob = player.job


CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local plyVehicle = GetVehiclePedIsIn(plyPed)
                    if validVehicle(GetEntityModel(plyVehicle)) and DoesEntityExist(plyVehicle) then
                        if PlayerJob and PlayerJob.name == "police" then
                            vaildveh = true
                            SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                            SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                            SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                            SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                            SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                            if IsControlPressed(0, Config.KeyBind) then
                                changeClass()
                                QBCore.Functions.Notify("Changed class to " .. currentClass)
                                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                            end
                        else
                            vaildveh = false
                            Wait(10000)
                        end

                    end      
                        else
                            vaildveh = false
                            currentClass = "A"
                        end
        
        Wait(1000)
    end
end)




RegisterCommand("carhash", function()
    print(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), -1)))
end)



function validVehicle(vehicleModel)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return true
        end
    end

    return false
end


function getHandlingConfig(vehicleModel, type)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return Config.VehiclesConfig[k][currentClass][type]
        end
    end
end

function changeClass()
    if currentClass == "A" then
        currentClass = "A+"
        print("its working!")
    elseif currentClass == "A+" then
        currentClass = "S+"
        SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId()), 0)
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, true)
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, true) 
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 11, 2, false) 
        SetVehicleXenonLightsColor(GetVehiclePedIsIn(PlayerPedId()), 1) 
        print("its working!")
    elseif currentClass == "S+" then
        currentClass = "A"
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, false) 
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, false) 
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 11, -1, false) 
       print("its working!")
    end
end