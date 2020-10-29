function eventKeyboard(n,k,d,x,y)
    if (k==0 or k==1 or k==2 or k==3) and p[n].afk then
        p[n].afk=false
    end
    if k==2 and started2 and play and map~="@7796992" then
        p[n].right=true
        if cat~=5 then ms.spawnPoint(n,x,y) end
    elseif k==0 and started2 and play and map~="@7796992" then
        p[n].right=false
        if cat~=5 then ms.spawnPoint(n,x,y) end
    elseif (month==months.stones[1] or month==months.stones[2]) and k==3 and started2 and started and play and map~="@7796992" and mapSet.gems then
        if math.sqrt(math.pow(x - mapSet.gems[data[n][2]].x, 2) + math.pow(y - mapSet.gems[data[n][2]].y, 2)) <= 30 then
            if id.gem[n] then tfm.exec.removeImage(id.gem[n],n) id.gem[n]=nil end
            id.gem[n]=tfm.exec.addImage(stones.inVis[mapSet.gems[data[n][2]].id]..".png","_666",mapSet.gems[data[n][2]].x,mapSet.gems[data[n][2]].y,n)
            p[n].hasGem=true
        end
    elseif keys[k] and p[n].timeToOpen < os.time()-1000 then
        ms.close(n)
        p[n].timeToOpen=os.time()
        p[n].cnn=0
        p[n].cnnPage=1
        p[n].cnnSub={1,2,3,4,5,6,7,8,9}
        p[n].lbPage=1
        p[n].globalPage=1
        if p[n].opened==keys[k] then
            ms.close(n)
            p[n].opened=""
            p[n].cnn=0
            p[n].cnnPage=1
            p[n].cnnSub={1,2,3,4,5,6,7,8,9}
        else
            if data[n][3]==1 then
                ms[keys[k]](n,keys[k]=="openProfile" and n or (keys[k]=="openRank" and p[n].lbPage or (keys[k]=="openHelp" and "help" or true)),false,false)
                p[n].opened=keys[k]
            else
                tfm.exec.chatMessage("<R>"..text[n].wrong,n)
            end
        end
    elseif k==32 and not tfm.get.room.playerList[n].isDead and started and play and not teams[data[n][2]].isWinner and cat~=5 and not p[n].stopped then
        if not d and p[n].timetohold < os.time()-1000 then
            if p[n].power > (cat==4 and 8 or 14) then
                if cat~=4 then
                    local dir, angle = p[n].right and 1 or -1, p[n].angle-90
                    p[n].objectid=tfm.exec.addShamanObject(mapSet.canRetro and 17 or roles[data[n][4]].id,x+(p[n].right and data[n][8] or -data[n][8]),y+data[n][9],(angle+90)*dir,0,0,teams[data[n][2]].coolodown)
                    tfm.exec.moveObject(p[n].objectid, 0, 0, true, 2*p[n].power*math.cos(math.rad(angle))*dir,2*p[n].power*math.sin(math.rad(angle)), false, (angle+90)*dir )
                    table.insert(toDespawn,{os.time(),p[n].objectid})
                else
                    local X=math.floor(math.cos(math.rad(p[n].angle2))*25)
                    local Y=math.floor(math.sin(math.rad(p[n].angle2))*25) 
                    local xLim=(p[n].right and -X or X)
                    local angle=p[n].right and 180-p[n].angle2 or p[n].angle2
                    p[n].objectid=tfm.exec.addShamanObject(35,x + xLim,y + Y,angle,math.cos(math.rad(p[n].angle2))*(p[n].right and -p[n].power or p[n].power),math.sin(math.rad(p[n].angle2))*p[n].power,teams[data[n][2]].coolodown)
                    table.insert(toDespawn,{os.time(),p[n].objectid})
                end
                if data[n][10]~=1 and cat~=4 and not mapSet.canRetro and cannons[p[n].usedCnn] then
					local v=cannons[p[n].usedCnn]
					local cannonImage=cat~=8 and (p[n].right and v.right..".png" or v.left..".png") or (p[n].right and "16566f3cf07.png" or "16566f3b1c2.png")
					tfm.exec.addImage(cannonImage, "#"..tostring(p[n].objectid),cat~=8 and (v.x and (p[n].right and v.x or v.xl) or -17.5) or -21,cat~=8 and (v.y and (p[n].right and v.y or v.yl) or -17.5) or -21)
                elseif cat==8 then
                    tfm.exec.addImage(p[n].right and "16566f3cf07.png" or "16566f3b1c2.png", "#"..tostring(p[n].objectid),-21,-21)
                end
                ui.removeTextArea(4,n)
            end
            p[n].timetohold=os.time()
        end
        p[n].power=0
        p[n].isHolding=d
    elseif k==86 and (p[n].angle < 120) and started and play  and not tfm.get.room.playerList[n].isDead and not teams[data[n][2]].isWinner and cat~=5 and not p[n].stopped then
        ms.changeAngle(n,cat==4 and 5 or 10,x,y)
    elseif k==67 and (p[n].angle > 60) and started and play and not tfm.get.room.playerList[n].isDead and not teams[data[n][2]].isWinner and cat~=5 and not p[n].stopped then
        ms.changeAngle(n,cat==4 and -5 or -10,x,y)
	elseif k==88 and p[n].kit~=0 and started and play and not tfm.get.room.playerList[n].isDead and not teams[data[n][2]].isWinner and not p[n].trapped and not p[n].stopped and p[n].kit~=44 then
		if p[n].timeToKit < os.time()-kits[p[n].kit][2] then
			if id.kit[n] then tfm.exec.removeImage(id.kit[n],n) id.kit[n]=nil end
			p[n].kitImg=false
			p[n].timeToKit=os.time()
			kits[p[n].kit][1](n,x,y)
		end
    elseif k==69 and started and play and not tfm.get.room.playerList[n].isDead and not teams[data[n][2]].isWinner and not p[n].stopped then
        if data[n][4]=="p" and cat~=5 and cat~=7 and p[n].timeToSkill < os.time()-30000 then
            if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
            roles.p.skill[1](n,x,y)
        end
        if (data[n][4]=="c" or data[n][4]=="w" or data[n][4]=="i") and p[n].timeToSkill < os.time()-(roles[data[n][4]].time*1000) and cat~=5 and ((cat~=4 and cat~=7) or ((cat==4 and roles[data[n][4]].aie) or (cat==7 and roles[data[n][4]].sham))) then
            p[n].timeToSkill=os.time()
            if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
            p[n].skillImg=false
            local oppTeam=data[n][2]=="h" and "v" or "h"
            local oppTable={}
            for n in pairs(teams[oppTeam].inRoomMembers) do
                if not tfm.get.room.playerList[n].isDead and not p[n].trapped and not p[n].stopped and not p[n].afk then
                    oppTable[#oppTable+1]=n
                end
            end
            local thingPlayer=oppTable[math.random(#oppTable)]
            if #oppTable==0 and data[n][4]~="i" and data[n][4]~="r" then
                p[n].timeToSkill=os.time()-60000
                id.skill[n]=tfm.exec.addImage(roles[data[n][4]].skillImg..".png","&0",roles[data[n][4]].xs[data[n][2]],roles[data[n][4]].ys,n)
                p[n].skillImg=true
            end
            if data[n][4]=="c" and #oppTable>0 and not teams[data[n][2]].coolodown then
                roles.c.skill[1](n,x,y,thingPlayer)
            elseif data[n][4]=="i" then
                roles.i.skill[1](n,x,y)
            elseif data[n][4]=="w" and #oppTable>0 then
                roles.w.skill[1](n,x,y,thingPlayer)
            end
        elseif data[n][4]=="he" and cat~=5 and teams[data[n][2]].hp <= 80 and not teams[data[n][2]].coolodown and p[n].timeToSkill < os.time()-(180*1000) then
            if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
            roles.he.skill[1](n,x,y)
        end
    end
end

