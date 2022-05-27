
local job = false
local job2 = false


------------Coords------------
local coords = { x = -1668.32, y = -289.95, z = 52.02}
-------------------------------

ESX = nil 
Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(10)
    end 
end)  

Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(0)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    DrawMarker(27, coords.x, coords.y, coords.z - 1 , 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,52,155,0, 200, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords.x, coords.y, coords.z - 1, x,y,z) < 1.5 then 
    ESX.ShowHelpNotification("Pulsa ~r~[E]~w~ para empezar a craftear")
    if IsControlJustPressed(0, 38) then 
         ExecuteCommand("me Coge todos los utensilios y empieza a construir algo...")
         ExecuteCommand("do Se verian sus manos hacer movimientos con objetos")
            ESX.ShowNotification("Se está comprobando tu inventario...")
            Citizen.Wait(500)
                ESX.TriggerServerCallback('roy:craftclip', function(has)
                    if has then
                        local job = true
                        if not IsEntityPlayingAnim(GetPlayerPed(-1), 'mini@repair', 'fixing_a_player', 3) then
                            ESX.Streaming.RequestAnimDict('mini@repair', function()
                                TaskPlayAnim(GetPlayerPed(-1), 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            end)
                        end
                        exports['progressBars']:startUI(10000, 'Crafteando cargador...')
                        Citizen.Wait(10000)
                        print("Crafteando cargador...")
                        TriggerServerEvent('roy_craft:addclip')
                        TriggerServerEvent('roy_craft:removeitems')
                        local job = false
                    end
                end) 
            end
        end
     end
end)



function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
