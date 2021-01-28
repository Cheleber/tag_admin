
local TagSuperAdmin = 'nil' -- DONT TOUCH PLEASE 
local TagAdmin = 'nil' -- DONT TOUCH PLEASE 
local TagMod = 'nil'  -- DONT TOUCH PLEASE 
local TagHelper = 'nil' -- DONT TOUCH PLEASE
--DONT TOUCH PLEASE-------------DONT TOUCH PLEASE-------------DONT TOUCH PLEASE-------------DONT TOUCH PLEASE-------------

--local correu = false

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
			TriggerServerEvent('Cheleber:SVstarttagjoin')
			break
		end
	end
end)

RegisterNetEvent('Cheleber:tagsuperadmin')
AddEventHandler('Cheleber:tagsuperadmin', function(id, tag) 
    if TagSuperAdmin == 'nil' then
	    if tag == 'true' then
		    TagSuperAdmin = id .. ''
	    end
	else
	    if tag == 'true' then
		    TagSuperAdmin = TagSuperAdmin ..'\n'.. id
	    end
    end
end) 


RegisterNetEvent('Cheleber:tagadmin')
AddEventHandler('Cheleber:tagadmin', function(id, tag) 
    if TagAdmin == 'nil' then
	    if tag == 'true' then
		    TagAdmin = id .. ''
	    end
	else
	    if tag == 'true' then
		    TagAdmin = TagAdmin ..'\n'.. id
	    end
    end
end) 


RegisterNetEvent('Cheleber:tagmod')
AddEventHandler('Cheleber:tagmod', function(id, tag) 
    if TagMod == 'nil' then
	    if tag == 'true' then
		    TagMod = id .. ''
	    end
	else
	    if tag == 'true' then
		    TagMod = TagMod ..'\n'.. id
	    end
    end
end) 


RegisterNetEvent('Cheleber:taghelper')
AddEventHandler('Cheleber:taghelper', function(id, tag) 
    if TagHelper == 'nil' then
	    if tag == 'true' then
		    TagHelper = id .. ''
	    end
	else
	    if tag == 'true' then
		    TagHelper = TagHelper ..'\n'.. id
	    end
    end
end) 

RegisterNetEvent('Cheleber:tagclean')
AddEventHandler('Cheleber:tagclean', function() 
    TagSuperAdmin = 'nil'
    TagAdmin = 'nil'
	TagMod = 'nil'
	TagHelper = 'nil'
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
			local x2, y2, z2 = table.unpack(GetEntityCoords(ped))
			local offset = 0.8 + displayTAGHeight * 0.1
			z2 = z2 + offset
			
			if not SeeSelfTag then 
                if ped ~= playerped then
				    if ignorePlayerNameDistance then
						for i,l in ipairs(stringsplit(TagSuperAdmin, "\n")) do
			            	for i = 1, #l do
						    	if l == tostring(GetPlayerServerId(player)) then
		                        	DrawText3DTag(vector3(x2, y2, z2), "SUPER ADMIN")
								end
							end
			       	    end
						for i,l in ipairs(stringsplit(TagAdmin, "\n")) do
			           	    for i = 1, #l do
						    	if l == tostring(GetPlayerServerId(player)) then
		                        	DrawText3DTag(vector3(x2, y2, z2), "ADMIN")
								end
							end
			        	end
						for i,l in ipairs(stringsplit(TagMod, "\n")) do
			            	for i = 1, #l do
						    	if l == tostring(GetPlayerServerId(player)) then
		                        	DrawText3DTag(vector3(x2, y2, z2), "MOD")
								end
							end
			        	end
						for i,l in ipairs(stringsplit(TagHelper, "\n")) do
			            	for i = 1, #l do
						    	if l == tostring(GetPlayerServerId(player)) then
		                        	DrawText3DTag(vector3(x2, y2, z2), "HELPER")
								end
							end
			        	end
					else
					    if distance < playerNamesDist then
                    	    if not ignorePlayerNameDistance then
					            for i,l in ipairs(stringsplit(TagSuperAdmin, "\n")) do
			                        for i = 1, #l do
						                if l == tostring(GetPlayerServerId(player)) then
		                                    DrawText3DTag(vector3(x2, y2, z2), "SUPER ADMIN")
							            end
						            end
								end
						        for i,l in ipairs(stringsplit(TagAdmin, "\n")) do
			                        for i = 1, #l do
						                if l == tostring(GetPlayerServerId(player)) then
		                                    DrawText3DTag(vector3(x2, y2, z2), "ADMIN")
							            end
						            end
								end
						        for i,l in ipairs(stringsplit(TagMod, "\n")) do
			                        for i = 1, #l do
						                if l == tostring(GetPlayerServerId(player)) then
		                                    DrawText3DTag(vector3(x2, y2, z2), "MOD")
							            end
									end
						        end
						        for i,l in ipairs(stringsplit(TagHelper, "\n")) do
			                        for i = 1, #l do
						                if l == tostring(GetPlayerServerId(player)) then
		                                    DrawText3DTag(vector3(x2, y2, z2), "HELPER")
										end
									end
							    end
						    end
			            end
			        end
                end  
            else
                if ignorePlayerNameDistance then
					for i,l in ipairs(stringsplit(TagSuperAdmin, "\n")) do
			            for i = 1, #l do
						    if l == tostring(GetPlayerServerId(player)) then
		                        DrawText3DTag(vector3(x2, y2, z2), "SUPER ADMIN")
							end
						end
			        end
				
				    for i,l in ipairs(stringsplit(TagAdmin, "\n")) do
			            for i = 1, #l do
						    if l == tostring(GetPlayerServerId(player)) then
		                        DrawText3DTag(vector3(x2, y2, z2), "ADMIN")
							end
						end
			        end
				
				    for i,l in ipairs(stringsplit(TagMod, "\n")) do
			            for i = 1, #l do
						    if l == tostring(GetPlayerServerId(player)) then
		                        DrawText3DTag(vector3(x2, y2, z2), "MOD")
							end
						end
			        end
				
				    for i,l in ipairs(stringsplit(TagHelper, "\n")) do
			            for i = 1, #l do
						    if l == tostring(GetPlayerServerId(player)) then
		                        DrawText3DTag(vector3(x2, y2, z2), "HELPER")
							end
						end
			        end
				else
                    if distance < playerNamesDist then
                        if not ignorePlayerNameDistance then
					        for i,l in ipairs(stringsplit(TagSuperAdmin, "\n")) do
                                for i = 1, #l do
						            if l == tostring(GetPlayerServerId(player)) then
		                                DrawText3DTag(vector3(x2, y2, z2), "SUPER ADMIN")
			                        end
								end
							end
						end
						for i,l in ipairs(stringsplit(TagAdmin, "\n")) do
			                for i = 1, #l do
						        if l == tostring(GetPlayerServerId(player)) then
		                            DrawText3DTag(vector3(x2, y2, z2),  "ADMIN")
							    end
						    end
			            end
						for i,l in ipairs(stringsplit(TagMod, "\n")) do
			                for i = 1, #l do
						        if l == tostring(GetPlayerServerId(player)) then
		                            DrawText3DTag(vector3(x2, y2, z2), "MOD")
							    end
						    end
			            end
						for i,l in ipairs(stringsplit(TagHelper, "\n")) do
			                for i = 1, #l do
						        if l == tostring(GetPlayerServerId(player)) then
		                            DrawText3DTag(vector3(x2, y2, z2), "HELPER")
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



function DrawText3DTag(coords, text)
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
