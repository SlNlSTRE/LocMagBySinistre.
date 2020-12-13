ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('shop:items')
AddEventHandler('shop:items', function(thePrice,theItem,theLabel,theQuantity)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    local xMoney = xPlayer.getMoney()

    if xMoney >= thePrice then

        xPlayer.removeMoney(thePrice)
        xPlayer.addInventoryItem(theItem, theQuantity)
        TriggerClientEvent('esx:showAdvancedNotification', source, "Banque", "Achat", "Vous venez de acheter ~b~x"..theQuantity.." un "..theLabel.."~s~ pour ~g~$"..thePrice, "CHAR_BANK_MAZE")
    else
         TriggerClientEvent('esx:showAdvancedNotification', source, "Achat", "Argent insuffisante", "~b~Vous avez pas assez d'argent~s~ ~r~$"..thePrice, "CHAR_BANK_MAZE")
    end
end)


ShowHelpNotification = function(msg)
	AddTextEntry('rLocationHelpNotif', msg)
	DisplayHelpTextThisFrame('rLocationHelpNotif', false)
end

ShowNotification = function(msg)
	AddTextEntry('rLocationNotif', msg)
	BeginTextCommandThefeedPost('rLocationNotif')
	EndTextCommandThefeedPostTicker(false, false)
end

RegisterServerEvent('loc:achat')
AddEventHandler('loc:achat', function(thePrice)
     local _source = source
     local xPlayer = ESX.GetPlayerFromId(source)
 
  
     if xPlayer.getMoney() >= thePrice then
            TriggerClientEvent("Spawn:veh", source)
          TriggerClientEvent('esx:showNotification', source, "~o~Transaction~s~ :\npaiement ~g~accepté~s~\nvous avez payer ~g~".. thePrice .."$") 
           xPlayer.removeMoney(thePrice)
      else
           TriggerClientEvent('esx:showNotification', source, "~o~Transaction~s~ :\npaiement ~r~non accepté argent insuffisante !")
     end
end)