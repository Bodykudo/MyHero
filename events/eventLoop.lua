cannonInfo={{},{}}
local t=0
function eventLoop(time,remaining)
    if time >= 3000 and not started and not started2 and play then
        if cat==5 then
            started=true
        end
        started2=true
    end
    if time >= 8000 and play and not started and cat~=5 and map~="@7796992" then
        started=true
        teams["h"].ig=0
        teams["v"].ig=0
        for n in pairs(tfm.get.room.playerList) do
            if data[n][1] and data[n][2]~="" and data[n][3] and data[n][4]~="" and not tfm.get.room.playerList[n].isDead then
                teams[data[n][2]].ig=teams[data[n][2]].ig+1
            end
        end
        if newTimer then
            system.removeTimer(newTimer)
        end
    end
    if time >= 9000 and timerImg then
        tfm.exec.removeImage(timerImg)
    end
    if play and map=="@7796992" and startCool then
        tfm.exec.setGameTime(testTime)
        startCool=false
    end
    if remaining <= 0 then
        teams["h"].hp=100
        teams["v"].hp=100
        ms.newGame()
    end
    for i in pairs(grounds) do
        if grounds[i][1] <= os.time()-5000 then
            tfm.exec.removePhysicObject(i)
            tfm.exec.removeImage(grounds[i][3])
        end
    end
    for i,cannon in ipairs(toDespawn) do
        if cannon[1] <= os.time()-(cat==5 and 3000 or 1500) then
            tfm.exec.moveObject(cannon[2],2000,2000)
            tfm.exec.removeObject(cannon[2])
            table.remove(toDespawn,i)
        end
    end
    for o,i in pairs(teams) do
        if i.isWinner and i.timer>0 then
            i.timer=i.timer-0.5
            ms.teamWin(o)
        end
    end

    for n,k in pairs(tfm.get.room.playerList) do
        if teams["h"].isWinner or teams["v"].isWinner then
            ms.removeBar(n)
        end
        if p[n].isHolding then
            if cat==4 then
                p[n].power=p[n].power+(data[n][4]=="a" and 8 or 4)
            else
                p[n].power=p[n].power+(data[n][4]=="a" and 20 or 10)
                p[n].HPpower=p[n].power/20
            end
            ui.addTextArea(4, "", n, 350, 30, cat==4 and p[n].power*2.5 or p[n].power/2, 15, cat==4 and powerColors.aie[math.floor(p[n].power/8)] or powerColors.norm[math.floor(p[n].power/20)], 0x66556F, 1, true)
            if p[n].power > (cat==4 and 40 or 200) then
                p[n].power=0
                p[n].HPpower=0
                ui.removeTextArea(4,n)
            end
            for i=1,2 do
                tfm.exec.displayParticle(particles[month][math.random(#particles[month])],k.x,k.y-math.random(5, 15),math.random(-2, 2),math.random(-2, 2))
            end
        else
            ui.removeTextArea(4,n)
        end
        if data[n][1]==1 and data[n][3]==1 and teams[data[n][2]].hp <= 0 and not teams[data[n][2]].isWinner and cat~=5 and time >= 8000 then
            tfm.exec.killPlayer(n)
        end
		if p[n].kit~=0 and play and started  and started2 and not teams[data[n][2]].isWinner and cat~=5 and not tfm.get.room.playerList[n].isDead and p[n].kit~=44 then
			if p[n].timeToKit < os.time()-kits[p[n].kit][2] and not p[n].kitImg then
				p[n].kitImg=true
				if data[n][4]~="a" then
					if ((cat~=4 and cat~=7) or ((cat==4 and roles[data[n][4]].aie) or (cat==7 and roles[data[n][4]].sham))) then
						id.kit[n]=tfm.exec.addImage(kits[p[n].kit][3]..".png","&0",roles[data[n][4]].xs[data[n][2]]+(data[n][2]=="h" and -40 or 40),roles[data[n][4]].ys,n)
					else
						id.kit[n]=tfm.exec.addImage(kits[p[n].kit][3]..".png","&0",roles[data[n][4]].xs[data[n][2]],roles[data[n][4]].ys,n)
					end
				else
					id.kit[n]=tfm.exec.addImage(kits[p[n].kit][3]..".png","&0",roles[data[n][4]].xs[data[n][2]],roles[data[n][4]].ys,n)
				end
			end
		end
        if data[n][3]==1 and play and started2 and started and not teams[data[n][2]].isWinner and roles[data[n][4]].time~=nil and cat~=5 and not tfm.get.room.playerList[n].isDead and ((cat~=4 and cat~=7) or ((cat==4 and roles[data[n][4]].aie) or (cat==8 and roles[data[n][4]].sham))) then
            if p[n].timeToSkill < os.time()-(roles[data[n][4]].time*1000) and not p[n].skillImg then
                if data[n][4]=="he" then
                    if teams[data[n][2]].hp <= 80 then
                        p[n].skillImg=true
                        id.skill[n]=tfm.exec.addImage(roles[data[n][4]].skillImg..".png","&0",roles[data[n][4]].xs[data[n][2]],roles[data[n][4]].ys,n)
                    end
                else
                    p[n].skillImg=true
                    id.skill[n]=tfm.exec.addImage(roles[data[n][4]].skillImg..".png","&0",roles[data[n][4]].xs[data[n][2]],roles[data[n][4]].ys,n)
                end
            end
        end
        for v in pairs(tfm.get.room.playerList) do
            local i=p[v].objectid
            local o=tfm.get.room.objectList[i]
            if o and p[n].objectid~=i and (k.x-o.x)^2 + (k.y-o.y)^2 <= 55^2 and data[n][2]~=data[v][2] and not tfm.get.room.playerList[n].isDead and cat~=4 and not teams[data[v][2]].coolodown then
                if data[n][1]==1 and data[n][3]==1 and not ob[i] and not p[n].afk then
                    teams[data[n][2]].hp=data[n][4]=="p" and teams[data[n][2]].hp-math.floor(0.5*p[v].HPpower) or teams[data[n][2]].hp-math.floor(p[v].HPpower)
                    if inRoomModule and inRoom.h > 2 and inRoom.v > 2 and tfm.get.room.uniquePlayers >= 6 then
                        data[v][7]=data[v][7]+math.floor(0.5*p[v].HPpower)
                    end
                    if p[v].kit==44 then
                        local bombChance=math.random(1,3)
                        if bombChance==1 or bombChance==2 then
                            local nums={{0,0},{20,0},{-20,0},{0,15},{0,-15}}
                            for i=1,5 do
                                tfm.exec.displayParticle(3,k.x+nums[i][1],k.y+nums[i][2])
                                tfm.exec.displayParticle(particles[month][math.random(#particles[month])],k.x,k.y-math.random(5, 15),math.random(-2, 2),math.random(-2, 2))
                            end
                            tfm.exec.explosion(k.x,k.y,40,100,false)
                        end
                    end
                    ob[i]=true
                    ms.hpBar(nil)
                    break
                end
            end
        end
    end

	if play and time >= 75*1000 and not mapSet.noAuto and cat~=5 and not teams["h"].isWinner and not teams["v"].isWinner and map~="@7796992" then
		timeToAuto=timeToAuto+0.5
		if firstAuto then
            firstAuto=false
            for n in pairs(tfm.get.room.playerList) do 
                tfm.exec.chatMessage(text[n].auto,n)
            end
		end
		if timeToAuto==8 then
			timeToAuto=0
			aliveH,aliveV={},{}
		for n,p in pairs(tfm.get.room.playerList) do
			if data[n][2]=="h" and not p.isDead then
				aliveH[#aliveH+1]=n
			elseif data[n][2]=="v" and not p.isDead then
				aliveV[#aliveV+1]=n
			end
		end
        if #aliveH~=0 and #aliveV~=0 then
            local skin=math.random(1701,tfmcnns)
			cannonInfo[1]=ms.spawnCannon(aliveH[math.random(#aliveH)])
			tfm.exec.addShamanObject(skin, cannonInfo[1][1], cannonInfo[1][2], cannonInfo[1][3]-90)
			cannonInfo[2]=ms.spawnCannon(aliveV[math.random(#aliveV)])
			tfm.exec.addShamanObject(skin, cannonInfo[2][1], cannonInfo[2][2], cannonInfo[2][3]-90)
		end
		cannonInfo={{},{}}
		end
	end


    if cat==5 then
		for i,v in pairs(specialMaps) do
            if v.code==map and started then
                t=t+0.5
                if t >= 1.5 then
                    t=0
                    local id=tfm.exec.addShamanObject(math.random(1701,tfmcnns),v.x,math.random(v.y[1],v.y[2]),90,15)
                    table.insert(toDespawn,{os.time(),id})
                end
            end
        end
    end

    if os.time()-120000 > UpdateFileTime then
        system.loadFile(1)
        UpdateFileTime=os.time()
    end

end