timerTimer,timerImg=""
inRoom={h=0,v=0}
function eventNewGame()
	teamWon=false
    if month==12 or month==1 then
        tfm.exec.snow(300)
    end
    tfm.exec.disableAfkDeath(tfm.get.room.currentMap=="@7796992")
    if timerImg then tfm.exec.removeImage(timerImg) end
    if timerTimer then system.removeTimer(timerTimer) end
    if newTimer then system.removeTimer(newTimer) end
    if kitTimer then system.removeTimer(kitTimer) end
    grounds={}
    tfm.exec.removePhysicObject(1)
    map,started,started2,timeToAuto=tfm.get.room.currentMap,false,false,0
	firstAuto=cat~=4
    if cat~=5 then
        tfm.exec.addPhysicObject(10000,0,0,{type=14,width=5000,height=10,foreground=true,friction=0,restitution=0,angle=0,miceCollision=true,color=nil,groundCollision=false})
    end
    tfm.exec.setGameTime(cat==5 and 63 or 158)
    for o,i in pairs(teams) do
        i.hp,i.isWinner,i.ig,i.timer,i.coolodown=100,false,0,5,false
	end
    for n in pairs(tfm.get.room.playerList) do
        p[n].kit=0
        p[n].hasGem=false
        ms.closeKits(n)
        ms.removeBar(n)
		tfm.exec.setVampirePlayer(n,false)
        if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
		if id.kit[n] then tfm.exec.removeImage(id.kit[n],n) id.kit[n]=nil end
        if cat~=5 and cat~=4 and play then
            ms.kits(n,1)
			p[n].timeToKit=os.time()
            for k,v in pairs(kits) do
                if data[n][k] > 0 then
                    p[n].tKits=p[n].tKits+1
                end
            end
		end
        p[n].angle,p[n].angle2,p[n].right,p[n].isHolding,p[n].power,p[n].HPpower,p[n].stopped,p[n].trapped,p[n].afk,p[n].skillImg=90,180,true,false,0,0,false,false,true,false
        
        if play then
			if mapSet.halloween and (month==10 or month==11) then
				tfm.exec.setVampirePlayer(n)
            end
            if cat~=5 then
                id.bar[1][n]=tfm.exec.addImage("173aa781642.png","&1",685,23,n)
                id.bar[2][n]=tfm.exec.addImage("173aa780072.png","&2",0,23,n)
            end
			p[n].kitImg=false
            ms.spawnPoint(n,tfm.get.room.playerList[n].x,tfm.get.room.playerList[n].y)
            if (table.count(teams["h"].inRoomMembers) < 3 or table.count(teams["v"].inRoomMembers) < 3) and inRoomModule and not pvp then
                tfm.exec.chatMessage("<R>"..text[n].toSave,n)
            end
            p[n].timeToSkill=os.time()-180000
            if cat~=5 then
                if mapSet.image[1] then
                    if id.bg[n] then tfm.exec.removeImage(id.bg[n],n) id.bg[n]=nil end
                    id.bg[n]=tfm.exec.addImage(mapSet.image[2]..".png","?1",0,0,n)
                end
				if mapSet.canRetro then
                    if id.bg[n] then tfm.exec.removeImage(id.bg[n],n) id.bg[n]=nil end
                    id.bg[n]=tfm.exec.addImage(mapSet.retro..".png","_666",0,0,n)
                end
            end
            if data[n][1]==1 and data[n][3]==1 and teams[data[n][2]].inRoomMembers[n] then
				ui.removeTextArea(4,n)
                tfm.exec.setNameColor(n,teams[data[n][2]].color)
				if cat~=5 then
					tfm.exec.movePlayer(n,mapSet[data[n][2].."s"].x,mapSet[data[n][2].."s"].y)
					id.bar[3][n]=tfm.exec.addImage("173ab1909d1.png","&3",324,20,n)
					if id.icon[n] then tfm.exec.removeImage(id.icon[n]) id.icon[n]=nil end
					if data[n][46]==1 then
						for k in pairs(tfm.get.room.playerList) do
							if data[k][3]==1 then
								id.icon[n]=tfm.exec.addImage(roles[data[k][4]].icon..".png","$"..k,-13,-55,n)
							end
						end
					end
				end
            else
                tfm.exec.killPlayer(n)
            end
            saveData(n)
            if cat==8 then
                tfm.exec.chatMessage("<ROSE>"..text[n].disco.." /room #discodance",n)
            end
        end
    end
    if play then
        if month==10 or month==11 and not mapSet.canRetro then
            local xml=tfm.get.room.xmlMapInfo.xml
            local cheeses={}
            local cheesesImages={}
            for cheese in string.gmatch(xml, '<F .-/>') do
                table.insert(cheeses, {x=tonumber(cheese:match('X="(.-)"')), y=tonumber(cheese:match('Y="(.-)"'))})
            end
            for i=1,#cheesesImages do
                if cheesesImages[i] then
                    tfm.exec.removeImage(cheesesImages[i])
                end
            end
			if not xml:find("dodue") then
				for i=1,#cheeses do
					table.insert(cheesesImages, tfm.exec.addImage("1595145f956.png","!1",cheeses[i].x-34,cheeses[i].y-41))
				end
			end
        end
        inRoom.h,inRoom.v=table.count(teams["h"].inRoomMembers),table.count(teams["v"].inRoomMembers)
        local currImg=0
        if cat~=5 and cat~=4 then
            kitTimer=system.newTimer(function()
                for n in pairs(tfm.get.room.playerList) do
                    ms.closeKits(n)
                end
            end,20*1000,false)
        end
        if cat~=5 then
            timerTimer=system.newTimer(function()
                newTimer=system.newTimer(function()
                    if currImg~=6 then
                        currImg=currImg+1
                    end
                    if timerImg then tfm.exec.removeImage(timerImg) end
                    timerImg=tfm.exec.addImage(times[currImg]..".png",":999",0,0)
                end,1000,true)
            end,2000,false)
        end
        if mapSet.title then
            ui.setMapName("<font color='"..categories[cat].color.."'>M"..cat.."   <G>|   <J>"..mapSet.title.."</J>")
        else
            if mapSet.halloween then
                ui.setMapName("<font color='#f5602a'>Halloween</font>   <G>|   <J>"..tfm.get.room.xmlMapInfo.author.."</J> <BL>- "..map)
            elseif mapSet.avd then
                ui.setMapName("<font color='#61B6BD'>Angels</font> <V>vs</V> <font color='#AD2428'>Demons</font>   <G>|   <J>"..tfm.get.room.xmlMapInfo.author.."</J> <BL>- "..map)
            else
                ui.setMapName("<font color='"..categories[cat].color.."'>M"..categories[cat][1].."   <G>|   <J>"..tfm.get.room.xmlMapInfo.author.."</J> <BL>- "..map)
            end
        end
        if cat~=5 then
            ms.hpBar(nil)
        end
        if cat==8 then
            ms.changeGroundColor()
            groundsTimer=system.newTimer(function()
                if cat==8 then
                    ms.changeGroundColor()
                end
            end,5000,true)
        else
            if groundsTimer then
                system.removeTimer(groundsTimer)
            end
        end
        for n in pairs(tfm.get.room.playerList) do

        end
    end
end