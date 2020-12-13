print('^3Fat par Sinistre^3')
print('^4Discord : Sinistre#9906^4')
print('^5 Merci a Kadir^5')
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)
local Pos = {
    posjerome = {
        {posj = vector3(-245.46, -342.86, 29.98)}
    }
}


local Jerome = {
    menu = false,
    boucle = true
}
local pricebread = 9
local price = 1000
local priceWater = 3
local array = {
    "Blista",
    "panto",
    "faggio"
}

local arrayIndex = 1

Citizen.CreateThread(function()
        Jerome.menu = false
        -- Menu
        RMenu.Add('JeromeRevender', 'main', RageUI.CreateMenu("Jerome Revendeur", "~b~Jerome"))
        RMenu.Add('JeromeRevender', 'boisson', RageUI.CreateSubMenu(RMenu:Get('JeromeRevender', 'main'), "Boisson", "Menu Boisson"))
        RMenu.Add('JeromeRevender', 'Bouffe', RageUI.CreateSubMenu(RMenu:Get('JeromeRevender', 'main'), "Bouffe", "Menu Bouffe"))
        RMenu.Add('JeromeRevender', 'Alcool', RageUI.CreateSubMenu(RMenu:Get('JeromeRevender', 'main'), "Bouffe", "Menu Alcool"))
        RMenu.Add('JeromeRevender', 'Car', RageUI.CreateSubMenu(RMenu:Get('JeromeRevender', 'main'), "Car", "Choisir votre Voitures :"))
        -- Close menu
        RMenu:Get("JeromeRevender", "main").Closed = function() Jerome.menu = false FreezeEntityPosition(PlayerPedId(), false) end
        -- Couleur
        RMenu:Get("JeromeRevender", "main"):SetRectangleBanner(7, 246, 251, 50)
        RMenu:Get("JeromeRevender", "boisson"):SetRectangleBanner(7, 246, 251, 50)
        RMenu:Get("JeromeRevender", "Bouffe"):SetRectangleBanner(7, 246, 251, 50)
        RMenu:Get("JeromeRevender", "Alcool"):SetRectangleBanner(7, 246, 251, 50)
        RMenu:Get("JeromeRevender", "Car"):SetRectangleBanner(7, 246, 251, 50)
end)

function openMenuJerome()
    if Jerome.menu then
        Jerome.menu = false
    else
        Jerome.menu = true
        FreezeEntityPosition(PlayerPedId(), true)
        RageUI.Visible(RMenu:Get('JeromeRevender', 'main'), true)
            Citizen.CreateThread(function()
                while Jerome.menu do
                    RageUI.IsVisible(RMenu:Get('JeromeRevender', 'main'), true, true, true, function()
                        RageUI.Button("Boisson", "~Clique pour Choisir ta Boisson !!!", {RightLabel = "→→→"},true, function()
                        end, RMenu:Get('JeromeRevender', 'boisson'))
                        RageUI.Button("Alcool", "Clique pour Choisir ton Alcool!!!", {RightLabel = "→→→"},true, function()
                        end, RMenu:Get('JeromeRevender', 'Alcool'))
                        RageUI.Button("Bouffe", "Clique pour Choisir ta Bouffe !!!", {RightLabel = "→→→"},true, function()
                        end, RMenu:Get('JeromeRevender', 'Bouffe'))
                        RageUI.Separator("")
                        RageUI.List("Voitures :",  array, arrayIndex, "Choix du véhicule", {},  true, function(h, a, s, i) arrayIndex = i end)
                        RageUI.Button("Prendre le véhicule ~o~"..array[arrayIndex],nil, {RightLabel = "Prix : ~g~$"..price},true, function(Hovered, Active, Selected)
                            if (Selected) then 
                            TriggerServerEvent("loc:achat",price)
                            end 
                        end)
                    end, function()
                    end)
                    RageUI.IsVisible(RMenu:Get('JeromeRevender', 'boisson'), true, true, true, function()
                        RageUI.Button("Eau", "Cliquer pour Acheter a Boire", {RightLabel = "~g~"..priceWater.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TriggerServerEvent("shop:items",priceWater,'water','Eau',2)
                            end
                        end)
                    end, function()
                    end)
                    RageUI.IsVisible(RMenu:Get('JeromeRevender', 'Alcool'), true, true, true, function()
                        RageUI.Button("tequila", "Cliquer pour Acheter a Boire", {RightLabel = "~g~5$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                TriggerServerEvent("shop:items",9,'bread','Pain',5)
                            end
                        end)              
                    end, function()
                    end)
                        RageUI.IsVisible(RMenu:Get('JeromeRevender', 'Bouffe'), true, true, true, function()

                            RageUI.Button("Pain", "Cliquer pour Acheter a Boire", {RightLabel = "~g~"..pricebread.."$"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    TriggerServerEvent("shop:items",pricebread,'bread','Pain',5)
                                end
                            end)        
                        end, function()
                            ---Panels
                        end, 1)
                        Citizen.Wait(0)
                    end
                end)
            end
        end
        Citizen.CreateThread(function()
            while Jerome.boucle do
                local pCoords2 = GetEntityCoords(GetPlayerPed(-1))
                local activerfps = false
                local dst = GetDistanceBetweenCoords(pCoords2, true)
                for k,v in pairs(Pos.posjerome) do
                    if #(pCoords2 - v.posj) < 1.0 then
                        activerfps = true
                        RageUI.Text({ message = "Appuyer sur ~b~E~s~ pour parler avec ~b~Jerome .", time_display = 1, })
                        if IsControlJustReleased(1, 51) then
                            openMenuJerome()
                        end
                    elseif #(pCoords2 - v.posj) < 4.25 then
                        activerfps = true
                        DrawMarker(22, v.posj, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
                    end
                end
                if activerfps then
                    Wait(1)
                else
                    Wait(1800)
                end
            end
        end) 
        Citizen.CreateThread(function()
            for k,v in pairs(Pos.posjerome) do
                local kblip = AddBlipForCoord(v.posj)
                SetBlipSprite (kblip, 47)
                SetBlipDisplay(kblip, 4)
                SetBlipScale  (kblip, 0.8)
                SetBlipColour (kblip, 48)
                SetBlipAsShortRange(kblip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Jerome | ~y~vendeur & locataire")
                EndTextCommandSetBlipName(kblip)
            end
        end)
DecorRegister("Salut", 4)
pedHash = "a_c_chimp"
zone = vector4(-245.11, -344.28, 28.98, 8.00)
Heading = 149.7
Ped = nil
HeadingSpawn = 250.61288452148
Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Salut", 5431)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end)
function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end



---pay--
RegisterNetEvent("Spawn:veh")
AddEventHandler("Spawn:veh", function()
            veh = true
            FreezeEntityPosition(PlayerPedId(), false)
            RageUI.CloseAll()
            local model = GetHashKey(array[arrayIndex])
            RequestModel(model)
            while not HasModelLoaded(model) do Citizen.Wait(10) end
            local pos = vector3(-255.24, -340.19, 29.82)
            local jeromeveh = CreateVehicle(model, pos.x, pos.y, pos.z, 1.32, true, false)
            SetVehicleNumberPlateText(jeromeveh, "JEROME"..math.random(1,10))
            Jerome.menu = false
            ESX.ShowAdvancedNotification("Jerome","~o~Dialogue","Vous venez de prendre un/e ~b~"..array[arrayIndex],"CHAR_BANK_MAZE",8)
end)

