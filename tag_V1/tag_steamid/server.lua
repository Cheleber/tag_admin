local tagon = {}
local tagoncheck = {}
local index = 0 -- DONT TOUCH PLEASE!

RegisterServerEvent("Cheleber:SVstarttag")
AddEventHandler('Cheleber:SVstarttag', function(playerId)
    if isAdmin(playerId) then
	    dprint('Allowed: ' .. playerId)
	    index = index + 1
	    tagon[index] = {
	        ['id'] = playerId,
	    }
	    CheleberRestartTag1()
	end
end)
	
RegisterServerEvent("Cheleber:SVstarttagjoin")
AddEventHandler('Cheleber:SVstarttagjoin', function(playerId)
    if isAdmin(playerId) then
	    dprint('Allowed: ' .. playerId)
	    index = index + 1
	    tagoncheck[playerId] = true
	    tagon[index] = {
	        ['id'] = playerId,
	    }
	    CheleberRestartTag1()
	end
end)

function CheleberRestartTag1()
    dprint('Restarting...')
    for i = 1, #tagon,1 do
        if tagoncheck[tagon[i].id] == true then	
    	    TriggerClientEvent("Cheleber:tag1", -1, tagon[i].id, 'true')
	        dprint('Restarted ID: ' .. tagon[i].id)
        else
    	    TriggerClientEvent("Cheleber:tag1", -1, tagon[i].id, 'false')
	        dprint('Restarted ID: ' .. tagon[i].id)
		end
	end
end

function CheleberCleanTagTable()
    dprint("Cleaning...")
    index = 0
	if ModoDebug then
	    for i = 1, #tagon,1 do
		    dprint("Cleaned ID: "  .. tagon[i].id)
	    end
	end
	for k in pairs (tagon) do
        tagon [k] = nil
    end
	TriggerClientEvent("Cheleber:tagclean", -1)
end


AddEventHandler('chatMessage', function(source, color, msg)
	cm = stringsplit(msg, " ")
	
	if cm[1] == "/tag" then
		CancelEvent()
		if isAdmin(source) then
	        if tagoncheck[source] == true  then
			    tagoncheck[source] = false
		        index = 0
			    for k in pairs (tagon) do
        		    tagon [k] = nil
    		    end
			    TriggerClientEvent("Cheleber:tagclean", -1)
				TriggerClientEvent('chatMessage', source, "Tag OFF!")
		    else
			    tagoncheck[source] = true
			    index = 0
			    for k in pairs (tagon) do
        		    tagon [k] = nil
    		    end
			    TriggerClientEvent("Cheleber:tagclean", -1)
			    TriggerClientEvent('chatMessage', source, "Tag ON!")
			end
		end
	end	
end)


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

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

function dprint(msg)
	if ModoDebug then
		print(msg)
	end
end

---THIS CLEAN THE TABLE EVERY MINUTE, YOU CAN CHANGE THIS THIME, OPTIONAL. 
function cleantagstable()
	SetTimeout(60000, CheleberCleanTagTable)  
	SetTimeout(60000, cleantagstable) 
end

cleantagstable()