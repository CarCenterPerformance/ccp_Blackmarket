ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('licensedshop:checkLicense')
AddEventHandler('licensedshop:checkLicense', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    exports.oxmysql:query('SELECT type FROM user_licenses WHERE owner = ? AND type = ?', {
        xPlayer.identifier,
        Config.RequiredLicense
    }, function(result)
        if result and result[1] then
            TriggerClientEvent('licensedshop:openMenu', src)
        else
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Black Market',
                description = 'Du hast nicht die benötigte Lizenz!',
                type = 'error'
            })
        end
    end)
end)

RegisterServerEvent('licensedshop:buyItem')
AddEventHandler('licensedshop:buyItem', function(itemType, data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if xPlayer.getMoney() >= data.price then
        xPlayer.removeMoney(data.price)

        if itemType == "item" and data.item then
            xPlayer.addInventoryItem(data.item, 1)
        elseif itemType == "weapon" and data.weapon then
            xPlayer.addWeapon(data.weapon, 250)
        else
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Fehler',
                description = 'Ungültige Item-Daten!',
                type = 'error'
            })
            return
        end

        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Black Market',
            description = 'Kauf erfolgreich!',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Black Market',
            description = 'Nicht genug Geld!',
            type = 'error'
        })
    end
end)
