local QBCore = exports["qb-core"]:GetCoreObject()
local currentClass = "A"
local vaildveh = false
local player = QBCore.Functions.GetPlayerData()
local PlayerJob = {}
PlayerJob = player.job

local function validVehicle(vehicleModel)
    local isValid = false
    if Config.VehiclesConfig[vehicleModel] then isValid = true end
    return isValid
end

local function getHandlingConfig(vehicleModel)
    if Config.VehiclesConfig[vehicleModel] then
        return Config.VehiclesConfig[vehicleModel][currentClass]
    end
end

local function changeClass()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if currentClass == "A" then
        currentClass = "A+"
    elseif currentClass == "A+" then
        currentClass = "S+"
        SetVehicleModKit(vehicle, 0)
        ToggleVehicleMod(vehicle, 22, true)
        ToggleVehicleMod(vehicle, 18, true)
        SetVehicleMod(vehicle, 11, 2, false)
        SetVehicleXenonLightsColor(vehicle, 1)
    elseif currentClass == "S+" then
        currentClass = "A"
        ToggleVehicleMod(vehicle, 22, false)
        ToggleVehicleMod(vehicle, 18, false)
        SetVehicleMod(vehicle, 11, -1, false)
    end
end

local updateHandliong = function(vehicle)
    for k,v in piars(getHandlingConfig(GetEntityModel(vehicle))) do
        SetVehicleHandlingFloat(vehicle, "CHandlingData", k, v)
    end
end

CreateThread(function()
    while true do
        local Sleeper = 1000
        local plyPed = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local plyVehicle = GetVehiclePedIsIn(plyPed)
            if DoesEntityExist(plyVehicle) and validVehicle(GetEntityModel(plyVehicle)) then
                if PlayerJob and PlayerJob.name == "police" then
                    vaildveh = true
                    updateHandliong(plyVehicle)
                    if IsControlPressed(0, Config.KeyBind) then
                        changeClass()
                        QBCore.Functions.Notify("Changed class to " .. currentClass)
                        updateHandliong(plyVehicle)
                    end
                else
                    vaildveh = false
                    currentClass = "A"
                    Sleeper = 10000
                end
            end
        else
            vaildveh = false
            currentClass = "A"
        end
        Wait(Sleeper)
    end
end)

RegisterCommand("carhash", function()
    print(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), -1)))
end)
