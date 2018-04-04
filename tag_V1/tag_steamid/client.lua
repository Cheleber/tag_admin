local TagAdmin1 = 'nil' -- DONT TOUCH PLEASE

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
	TriggerServerEvent('Cheleber:SVstarttag', GetPlayerServerId(PlayerId()))
end) 


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



Citizen.CreateThread(function ()
    while true do
        for id = 0, 31 do
            if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) and SeeSelfTag == false then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			            for i = 1, #l do
						    if string.sub(l,i,i) == tostring(GetPlayerServerId(id)) then
		                        DrawText3DTag(x2, y2, z2 + displayTAGHeight, "ADMIN")
							end
						end
			        end
				end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
					    for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			                for i = 1, #l do
						        if string.sub(l,i,i) == tostring(GetPlayerServerId(id)) then
		                            DrawText3DTag(x2, y2, z2 + displayTAGHeight, "ADMIN")
							    end
						    end
			            end
			        end
                end  
            end
			if SeeSelfTag == true then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped ) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
					for i,l in ipairs(stringsplit(TagAdmin1, "\n")) do
			            for i = 1, #l do
						    if string.sub(l,i,i) == tostring(GetPlayerServerId(id)) then
		                        DrawText3DTag(x2, y2, z2 + displayTAGHeight, "ADMIN")
							end
						end
			        end
				end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
					    for i,l in ipairs(stringsplit(TagAdmin, "\n")) do
			                for i = 1, #l do
						        if string.sub(l,i,i) == tostring(GetPlayerServerId(id)) then
		                            DrawText3DTag(x2, y2, z2 + displayTAGHeight, "ADMIN")
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



function DrawText3DTag(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.7*scale, 1.2*scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(220, 220, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
	    World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
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
