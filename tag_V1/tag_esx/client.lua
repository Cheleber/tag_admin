local TagAdmin1 = 'nil' -- DONT TOUCH PLEASE
local correu = false

--[[AddEventHandler("playerSpawned", function ()
	if not correu then
		TriggerServerEvent('Cheleber:SVstarttagjoin')
		correu = true
		--break
	end
end)]]--

Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 100 )

		if NetworkIsSessionStarted() then
			TriggerServerEvent('Cheleber:SVstarttagjoin', GetPlayerServerId(PlayerId()))
			break
		end
	end
end)

RegisterNetEvent('Cheleber:tag1')
AddEventHandler('Cheleber:tag1', function(id, tag) 
    if TagAdmin1 == 'nil' then
	    if tag == 'true' then
		    TagAdmin1 = id .. ''
	    end
	else
	    if tag == 'true' then
		    TagAdmin1 = TagAdmin1 ..'\n'.. id
	    end
    end
end) 

RegisterNetEvent('Cheleber:tagclean')
AddEventHandler('Cheleber:tagclean', function() 
    TagAdmin1 = 'nil'
	TriggerServerEvent('Cheleber:SVstarttag')
end)


Citizen.CreateThread(function ()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
		
		    local ped = GetPlayerPed(player)
			local playerped = PlayerPedId()
            local pedpos = GetEntityCoords(ped)
			local playerpedpos = GetEntityCoords(playerped)
			local distance = #(playerpedpos - pedpos)
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local offset = 0.8 + displayTAGHeight * 0.1
			z = z + offset
			
			if not SeeSelfTag then 
			    if ped ~= playerped then
                    if ignorePlayerNameDistance then
						for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			            	for i = 1, #l do
						    	if l == tostring(GetPlayerServerId(player)) then
		                        	DrawText3D(vector3(x, y, z), "ADMIN")
								end
							end
			        	end
					else 
                        if distance < playerNamesDist then
                    	    if not ignorePlayerNameDistance then
					    	    for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			                	    for i = 1, #l do
						        	    if l == tostring(GetPlayerServerId(player)) then
		                          	        DrawText3D(vector3(x, y, z), "ADMIN")
							    	    end
									end
						    	end
			            	end
			       	    end
                	end 
                end					
            else
                if ignorePlayerNameDistance then
					for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			            for i = 1, #l do
						    if l == tostring(GetPlayerServerId(player)) then
		                        DrawText3D(vector3(x, y, z), "ADMIN")
							end
						end
			        end
				else
                    if distance < playerNamesDist then
                        if not ignorePlayerNameDistance then
					        for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			                    for i = 1, #l do
						            if l == tostring(GetPlayerServerId(player)) then
		                                DrawText3D(vector3(x, y, z), "ADMIN")
							        end
								end
						    end
			            end
			        end
                end  
            end
        end
		Citizen.Wait(0)
    end
end)



function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    SetTextColour(250, 250, 250, 250)
    SetTextScale(0.0, 0.7 * scale)
    SetTextFont(2)
	SetTextColour(220, 220, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextOutline()
	SetTextCentre(1)
	SetTextProportional(1)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end


function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
