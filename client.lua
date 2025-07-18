local shown = false

CreateThread(function()
    RequestModel(Config.Shop.npcModel)
    while not HasModelLoaded(Config.Shop.npcModel) do Wait(0) end

    local npc = CreatePed(0, Config.Shop.npcModel, Config.Shop.coords.x, Config.Shop.coords.y, Config.Shop.coords.z - 1, 0.0, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    if Config.Shop.blip.enabled then
        local blip = AddBlipForCoord(Config.Shop.coords)
        SetBlipSprite(blip, Config.Shop.blip.sprite)
        SetBlipColour(blip, Config.Shop.blip.color)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Shop.blip.label)
        EndTextCommandSetBlipName(blip)
    end

    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist = #(coords - Config.Shop.coords)

        if dist < 2.0 then
            sleep = 0
            if not shown then
                shown = true
                lib.showTextUI("[E] Shop öffnen")
            end

            if IsControlJustReleased(0, 38) then -- E
                TriggerServerEvent('licensedshop:checkLicense')
            end
        else
            if shown then
                shown = false
                lib.hideTextUI()
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('licensedshop:openMenu', function()
    local options = {}

    for _, v in pairs(Config.Weapons) do
        table.insert(options, {
            title = v.label .. " - $" .. v.price,
            icon = "gun",
            onSelect = function()
                TriggerServerEvent("licensedshop:buyItem", "weapon", v)
            end
        })
    end

    for _, v in pairs(Config.Items) do
        table.insert(options, {
            title = v.label .. " - $" .. v.price,
            icon = "box",
            onSelect = function()
                TriggerServerEvent("licensedshop:buyItem", "item", v)
            end
        })
    end

    lib.registerContext({
        id = 'licensedshop_menu',
        title = 'Blackmarket',
        options = options
    })

    lib.showContext('licensedshop_menu')
end)
