ESX = nil

print"Created by itsRoyal#7294"

Discord = {}
Discord.Webhook = ""
Discord.Avatar = ""
Discord.Colour = 343201


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('roy:craftclip', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    
        
    if xPlayer.getInventoryItem('polvora').count >= 5 then
        SendLog('🛑DETECTADO UN CRAFTEO🛑', 'Identificador : '.. xPlayer.identifier .. '\n Nombre del jugador : ' ..xPlayer.name.. '\n Id del jugador : ' ..xPlayer.source.. '')
        cb(true)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification',source, 'No tienes lo suficiente para craftear, necesitas polvora y un cargador vacío')
        SendLog('🛑DETECTADO UN INTENTO DE CRAFTEO🛑', 'Identificador : '.. xPlayer.identifier .. '\n Nombre del jugador : ' ..xPlayer.name.. '\n Id del jugador : ' ..xPlayer.source.. '')
    end
end)
   

RegisterServerEvent('roy_craft:addclip')
AddEventHandler('roy_craft:addclip', function()
    local xPlayer = ESX.GetPlayerFromId(src)
    local user = ESX.GetPlayerFromId(source)
    user.addInventoryItem('clip', 1)
    TriggerClientEvent('esx:showNotification',source, 'Acabas de crafter un cargador, aqui tienes.')
end)

RegisterServerEvent('roy_craft:removeitems')
AddEventHandler('roy_craft:removeitems', function()
    local xPlayer = ESX.GetPlayerFromId(src)
    local user = ESX.GetPlayerFromId(source)
    user.removeInventoryItem('polvora', 5)
    TriggerClientEvent('esx:showNotification',source, 'Acabas de crafter un cargador, aqui tienes.')
end)

function SendLog(title, message) 
    local embedMsg = {}
    embedMsg = {
        {
            ["color"] = Discord.Colour,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = os.date("%c"),
            },
        }
    }
    PerformHttpRequest(Discord.Webhook, function(err, text, headers)end, 'POST', json.encode({username = "Royal Crafter", avatar_url= Discord.Avatar ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end
