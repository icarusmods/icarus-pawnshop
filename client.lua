local qtarget = exports.qtarget
QBCore = exports['qb-core']:GetCoreObject()
local sellingNPCLocation = lib.points.new(Config.Ped.coords, 40)
local textUI, smeltStarted, failedAntiCheat = false, false, false
local sellingInputOptions = {}
libState = 'started'

    for k, v in pairs(Config.sellableitems) do
        if v.sellable then
            local label = v.label
            if string.sub(k, 1, 4) == "raw_" then
                label = string.sub(v.label, 5)
            end
            table.insert(sellingInputOptions, { value = k, label = label })
    end
end

-- Checks if the TextUI should be displayed or not and responds
local function checkTextUI()
    if textUI then
        lib.showTextUI(TextUI.label, {
            position = TextUI.position,
            icon = TextUI.icon
        })
    else
        lib.hideTextUI()
    end
end

	HasItem = function(items, amount)
            local PlayerData = QBCore.Functions.GetPlayerData()
            if not PlayerData or not PlayerData.items then
                return 0
            end
            for i = 1, #PlayerData.items do
                local itemData = PlayerData.items[i]
                if itemData and itemData.name == items and itemData.amount >= amount then
                    return itemData.amount
                end
            end
end

    AddStateBagChangeHandler('isLoggedIn', '', function(_bagName, _key, value, _reserved, _replicated)
        if value then
            PlayerData = QBCore.Functions.GetPlayerData()
        else
            table.wipe(PlayerData)
        end
        PlayerLoaded = value
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then
            return
        end
        PlayerData = QBCore.Functions.GetPlayerData()
        PlayerLoaded = true
    end)

            local PlayerData = QBCore.Functions.GetPlayerData()
            if not PlayerData or not PlayerData.items then
                return 0
            end
            for i = 1, #PlayerData.items do
                local itemData = PlayerData.items[i]
                if itemData and itemData.name == items and itemData.amount >= amount then
                    return itemData.amount
                end
            end


Citizen.CreateThread(function()
    for k,v in pairs(Config.Blip) do
        local blip = AddBlipForCoord(v.Coords.x,v.Coords.y,v.Coords.z)
        SetBlipSprite(blip, v.Sprite)
        SetBlipScale(blip, v.Size)
        SetBlipColour(blip, v.Color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(k)
        EndTextCommandSetBlipName(blip)
    end
end)

    function startSelling()
        local sellInput = lib.inputDialog(InputDialog.sellTitle, {
            {type = 'select', label = InputDialog.sellSelectMaterial, description = InputDialog.sellSelectMaterialDesc, required = true, icon = InputDialog.sellSelectMaterialIcon, options = sellingInputOptions},
            {type = 'number', label = InputDialog.sellSelectQuantity, description = InputDialog.sellSelectQuantityDesc, icon = InputDialog.sellSelectQuantityIcon, required = true}
        })
        if sellInput == nil then
            return -- Something went wrong?
        else
            local checkItem = sellInput[1]:gsub('raw_', '')
            local hasItem = HasItem(checkItem, sellInput[2])
            if hasItem ~= nil and hasItem >= sellInput[2] and sellInput[2] ~= 0 and sellInput[2] > 0 then
                local price = nil
                for k, v in pairs(Config.sellableitems) do
                    if k == sellInput[1] then
                        price = v.price
                    end
                end
                price = price * sellInput[2]
                local sellItem = checkItem
                if lib.progressCircle({
                    duration = math.random(1500, 2500),
                    label = ProgressCircle.sellingLabel,
                    position = ProgressCircle.position,
                    useWhileDead = false,
                    canCancel = true,
                    anim = {dict = 'mp_common', clip = 'givetake1_a'},
                    disable = {move = true, car = true, combat = true}
                }) then
                    TriggerServerEvent('icaruspawn:sellItem', cache.serverId, sellItem, sellInput[2], price)
                else
                    ShowNotification(Notify.cancelledSell, 'error')
                end
            else
                ShowNotification(Notify.missingItemSell, 'error')
            end
        end
    end

    function sellingNPCLocation:onEnter()
        spawnSellingNPC()
        qtarget:AddTargetEntity(npc, {
            options = {
                {
                    icon = Target.sellIcon,
                    label = Target.sellLabel,
                    action = function()
                        startSelling()
                    end,
                    distance = 2
                }
            }
        })
    end
    function sellingNPCLocation:onExit()
        DeleteEntity(npc)
        qtarget:RemoveTargetEntity(npc, nil)
    end
    function spawnSellingNPC()
        lib.RequestModel(Config.Ped.model)
        npc = CreatePed(0, Config.Ped.model, Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z, Config.Ped.coords.w, false, true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetEntityInvincible(npc, true)
    end

ShowNotification = function(message, type)
    if libState == 'started' then
        lib.notify({
            title = Notify.title,
            description = message,
            icon = Notify.icon,
            type = type,
            position = Notify.position
        })
    else
end
end
