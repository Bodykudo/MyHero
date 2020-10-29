inRoomModule=not tfm.get.room.isTribeHouse
moduleName = "m"
loadedData = {}

local gmatch, sub, match = string.gmatch, string.sub, string.match
local splitter = "\1"

function stringToTable(str, tab, splitChar)
    local split = splitter..string.char(splitChar)
    for i in gmatch(str, '[^'..split..']+') do
        local index, value = match(i, '(.-)=(.*)')
        local indexType, index, valueType, value = sub(index, 1, 1), sub(index, 2), sub(value, 1, 1), sub(value, 2)
        if indexType == "s" then
            index = tostring(index)
        elseif indexType == "n" then
            index = tonumber(index)
        end
        if valueType == 's' then
            tab[index] = tostring(value)
        elseif valueType == 'n' then
            tab[index] = tonumber(value)
        elseif valueType == 'b' then
            tab[index] = value == '1'
        elseif valueType == 't' then
            tab[index] = {}
            stringToTable(value,tab[index], splitChar + 1)
        end
    end
end

function tableToString(index, value, splitChar)
    local sep = splitter..string.char(splitChar)
    local str = type(index) == 'string' and 's'..index..'=' or 'n'..index..'=' 
    if type(value) == 'table' then
        local tab = {}
        for i, v in next, value do
            tab[#tab + 1] = tableToString(i,v,splitChar+1)
        end
        str = str .. 't' .. table.concat(tab, sep)
    elseif type(value) == 'number' then
        str = str .. 'n' .. tostring(value)
    elseif type(value) == 'boolean' then
        str = str .. 'b' .. (value and '1' or '0')
    elseif type(value) == 'string' then
        str = str .. 's' .. value
    end
    return str
end

function eventPlayerDataLoaded(n,playerData)
    if playerData:find("hunter")~=nil or playerData:find("myhero")~=nil or playerData:find("sniper")~=nil or playerData:find("*m") then
        system.savePlayerData(n,"")
        playerData=""
    end
    loadedData[n] = {}
    for i in gmatch(playerData, "[^\0]+") do
        local moduleName = match(i, "s([^=]+)")
        local str = sub(i, #moduleName+4)
        loadedData[n][moduleName] = {}
        stringToTable(str,loadedData[n][moduleName], 1)
    end
    if loadedData[n]["f"] then loadedData[n]["f"]=nil end
    if loadedData[n]["w"] then loadedData[n]["w"]=nil end
    if loadedData[n]["z"] then loadedData[n]["z"]=nil end
    for i, v in next, loadedData[n][moduleName] or {} do
        data[n][i] =  v 
    end
    loadedData[n][moduleName]=data[n]
    data[n][1]=0
    data[n][2]=""
    data[n][3]=0
    data[n][4]=""
    if tfm.get.room.playerList[n] then
        data[n][31]=tfm.get.room.playerList[n].community
    end
    for i=11,30 do
        if data[n][i] then
            data[n][i]=nil
        end
    end
    data[n][33]=nil
    data[n][34]=nil
	data[n][37]=nil
	data[n][38]=nil
    if data[n][10]==19 and n~=lb_gbPl[1] then
        data[n][10]=1
    elseif data[n][10]==20 and n~=lb_gbPl[2] then
        data[n][10]=1
    elseif data[n][10]==21 and n~=lb_gbPl[3] then
        data[n][10]=1
    end
	if not table.find(cnnsIds,data[n][10]) then
		data[n][10]=1
    end
    for k,v in pairs(cannons) do
        if v.id==data[n][10] then
            p[n].usedCnn=k
        end
    end
    saveData(n)
end

function saveData(name)
    if loadedData[name] then
        local res = {}
        for module, data in next, loadedData[name] do
            res[#res + 1] = tableToString(module,data,1)
        end
        system.savePlayerData(name, table.concat(res, "\0"))
    end
end