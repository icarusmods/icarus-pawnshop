    QBCore = exports['qb-core']:GetCoreObject()

-- Event for paying the player upon successful sale
RegisterNetEvent('icaruspawn:sellItem')
AddEventHandler('icaruspawn:sellItem', function(source, item, quantity, sellValue)
    local source = source
    local player = GetPlayer(source)
    if player then
            if quantity <= 0 then
                return
            else
                RemoveItem(source, item, quantity)
                AddMoney(source, 'cash', sellValue)
                ServerNotify(source, Notify.soldItems.. sellValue, 'success')
            end
        else
        end

end)

	GetPlayer = function(source)
        return QBCore.Functions.GetPlayer(source)
	end

RemoveItem = function(source, item, count, slot, metadata)
    local player = GetPlayer(source)
            player.Functions.RemoveItem(item, count, slot, metadata)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "remove")
end

AddMoney = function(source, moneyType, amount)
    local player = GetPlayer(source)
            player.Functions.AddMoney(moneyType, amount)
end

ServerNotify = function(source, message, type)
    TriggerClientEvent('ox_lib:notify', source, {
        title = Notify.title,
        description = message,
        icon = Notify.icon,
        type = type,
        position = Notify.position
    })
end