admin="Bodykudo#0000"

function eventNewPlayer(n)
    for k=0,100 do
        system.bindKeyboard(n,k,true,true)
    end
    system.bindMouse(n,true)
	tfm.exec.addImage("173aa781642.png","&1",685,23,n)
	tfm.exec.addImage("173aa780072.png","&2",0,23,n)
	tfm.exec.addImage("173ab1909d1.png","&3",324,20,n)
	ui.addTextArea(0, "", n, 6, 28, 100, 18, 0xFD6262, 0x4A0000, 1, true)
	ui.addTextArea(2, "", n, 694, 28, 100, 18, 0x6266FD, 0x14004A, 1, true)
end

function eventNewGame()
	set={h={x=0,y=0},v={x=0,y=0},cat=0,noAuto=false}
end

function eventKeyboard(n,k,d,x,y)
	if k==32 and n==admin then
		tfm.exec.chatMessage("<J>X: <ROSE>"..x.."</ROSE>\nY: <ROSE>"..y.."</ROSE></J>")
	end
end

function eventMouse(n,x,y)
	tfm.exec.movePlayer(n,x,y)
end

for _,v in pairs ({'disableAfkDeath','disablePhysicalConsumables','disableAutoNewGame','disableMinimalistMode','disableAutoTimeLeft','disableAutoShaman','disableDebugCommand'}) do
    tfm.exec[v](true)
end

set={h={x=0,y=0},v={x=0,y=0},cat=0,noAuto=false}
function eventChatCommand(n,cmd)
    local c={}
    for i in string.gmatch(cmd,'[^%s]+') do
        table.insert(c,i)
    end
    c[1]=string.lower(c[1])
	if n==admin then
		if c[1]=="map" then
			if c[2] then
				tfm.exec.newGame(c[2])
			end
		elseif c[1]=="h" then
			set.h.x=tonumber(c[2])
			set.h.y=tonumber(c[3])
		elseif c[1]=="v" then
			set.v.x=tonumber(c[2])
			set.v.y=tonumber(c[3])
		elseif c[1]=="cat" then
			set.cat=tonumber(c[2])
			if set.cat==4 or cat==6 or cat==7 then
				set.noAuto=true
			end
		elseif c[1]=="noauto" then
			set.noAuto=true
		elseif c[1]=="auto" then
			set.noAuto=false
		elseif c[1]=="print" then
			local h=set.h
			local v=set.v
			local map=""
			if set.noAuto then
				map="{code=\""..tfm.get.room.currentMap.."\",x={h="..h.x..",v="..v.x.."},y={h="..h.y..",v="..v.y.."},category="..set.cat..",noAuto="..tostring(set.noAuto).."},"
			else
				map="{code=\""..tfm.get.room.currentMap.."\",x={h="..h.x..",v="..v.x.."},y={h="..h.y..",v="..v.y.."},category="..set.cat.."},"
			end
			tfm.exec.chatMessage("<VP>"..map.."</VP>")
		elseif c[1]=="move" then
			tfm.exec.movePlayer(n,tonumber(c[2]),tonumber(c[3]))
        elseif c[1]=="pw" then
            if c[2] then
                tfm.exec.setRoomPassword(cmd:sub(c[1]:len()+2))
                tfm.exec.chatMessage("pw: "..cmd:sub(c[1]:len()+2),n)
            else
                tfm.exec.setRoomPassword("")
            end
		end
	end
end

eventPlayerDied=tfm.exec.respawnPlayer
table.foreach(tfm.get.room.playerList,eventNewPlayer)