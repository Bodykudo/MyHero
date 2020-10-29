arrows={
    right={
        [150]={"1746a759ed0",45,-21},
        [155]={"1746a75e5b5",47,-20},
        [160]={"1746a760bfc",49,-18},
        [165]={"1746a7681a0",50,-17},
        [170]={"1746a76b197",51,-15},
        [175]={"1746a76cf66",51,-12},
        [180]={"1746a76ecb7",50,-10},
        [185]={"1746a770d06",51,-9},
        [190]={"1746a772ad7",51,-7},
        [195]={"1746a776cb1",50,-4},
        [200]={"1746a778bf1",49,-3},
        [205]={"1746a77d7e2",47,-2},
        [210]={"1746a787fd9",45,-2},
    },
    left={
        [150]={"1746a71ecd1",45,-21},
        [155]={"1746a724afe",47,-20},
        [160]={"1746a726805",49,-18},
        [165]={"1746a729c88",50,-17},
        [170]={"1746a72e369",51,-15},
        [175]={"1746a730065",51,-12},
        [180]={"1746a731d76",50,-10},
        [185]={"1746a733a5c",51,-9},
        [190]={"1746a735d57",51,-7},
        [195]={"1746a7379ce",50,-4},
        [200]={"1746a7396d2",49,-3},
        [205]={"1746a73bf92",47,-2},
        [210]={"1746a73e411",45,-2},
    },
}

function ms.teamWin(team)
    for n in pairs(teams[team].members) do
        p[n].isHolding=false
        tfm.exec.setVampirePlayer(n,false)
        if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
		if id.kit[n] then tfm.exec.removeImage(id.kit[n],n) id.kit[n]=nil end
        if teams[team].timer <= 0 then
            tfm.exec.giveCheese(n)
            tfm.exec.playerVictory(n)
        end
    end
    for n in pairs(tfm.get.room.playerList) do
        ms.removeBar(n)
    end
end

function ms.spawnCannon(name)
    local info={}
    local px=tfm.get.room.playerList[name].x
    local py=tfm.get.room.playerList[name].y
    local cnnx=math.random()*800
    local cnny=math.random()*400
    if cnny > py then
        cnny=py-math.random(50)-20
    end
    if math.abs(cnnx-px) > 300 then
        cnnx=px+math.random(-50, 50)
    end
    local right=math.atan2(cnny-py,cnnx-px) < (-2) and true or false
    local ang=math.deg(math.atan2(cnny-py, cnnx-px))
    tfm.exec.addShamanObject(0, cnnx, cnny, ang+90)
    info[1]=cnnx
    info[2]=cnny
    info[3]=ang
    info[4]=right
    return info
end

function ms.spawnPoint(n,x,y)
    if cat~=5 then
        local angle=math.abs(p[n].angle2)
        local direct=p[n].right and "right" or "left"
        local i=arrows[direct][angle]
        if id.shoot[n] then tfm.exec.removeImage(id.shoot[n],n) id.shoot[n]=nil end
        id.shoot[n]=tfm.exec.addImage(i[1]..".png","$"..n,-(i[2]/2)+(p[n].right and 60 or -60),i[3],n)
		if id.bow[n] then tfm.exec.removeImage(id.bow[n],n) id.bow[n]=nil end
        if cat==4 then
			id.bow[n]=tfm.exec.addImage(p[n].right and (data[n][2]=="h" and "174a835c2e8.png" or "174a835dfec.png") or (data[n][2]=="h" and "174a83ad708.png" or "174a83af41a.png"),"$"..n,p[n].right and 20 or -30,-37,n)
		end
    end
end

function ms.changeAngle(n,v,x,y)
    p[n].angle=p[n].angle+v
    p[n].angle2=-p[n].angle-90
    ms.spawnPoint(n,x,y)
end

function ms.editTeam(n,num,NOT,IN)
    teams[data[n][2]].notInRoom[n]=NOT
    teams[data[n][2]].inRoomMembers[n]=IN
    teams[data[n][2]].ir=table.count(teams[data[n][2]].inRoomMembers)
    if teams["h"].ir > 0 and teams["v"].ir > 0 and not play then
        play=true
    end
    if (teams.h.ir==0 or teams.v.ir==0) and play then
        play=false
    end
end

function ms.joinTeam(n,team,inT,inR,role,num,inRoom,member)
    teams[team].inRoomMembers[n]=inRoom or nil
    teams[team].members[n]=member or nil
    teams[team].ir=table.count(teams[team].inRoomMembers)
    data[n][1]=inT or 0
    data[n][2]=team or ""
    data[n][3]=inR or 0
    data[n][4]=role or ""
    if teams["h"].ir > 0 and teams["v"].ir > 0 and not play then
        play=true
    end
    if (teams.h.ir==0 or teams.v.ir==0) and play then
        play=false
    end
end

function ms.hpBar(n)
    if teams["v"].hp > 0 and not teams["v"].isWinner then
        ui.addTextArea(0, "", n, 6, 28, teams["v"].hp, 18, 0xFD6262, 0x4A0000, 1, true)
    end
    ui.addTextArea(1, teams["v"].hp < 0 and "<p align='center'><b><font size='13'><font color='#4A0000'>0%" or "<font color='#4A0000'><p align='center'><b><font size='13'>"..teams["v"].hp.."%", n, 6, 27, 100, 18, 0 ,0, 0, true)
    if teams["h"].hp > 0 and not teams["h"].isWinner then
        ui.addTextArea(2, "", n, 694+(100-teams["h"].hp), 28, teams["h"].hp, 18, 0x6266FD, 0x14004A, 1, true)
    end
    ui.addTextArea(3, teams["h"].hp < 0 and "<p align='center'><b><font size='13'><font color='#14004A'>0%" or "<font color='#14004A'><p align='center'><b><font size='13'>"..teams["h"].hp.."%", n, 694, 27, 100, 18, 0 ,0, 0, true)
end

function ms.removeBar(n)
    for i=0,4 do
        ui.removeTextArea(i,n)
    end
    for i=1,3 do
        if id.bar[i][n] then
            tfm.exec.removeImage(id.bar[i][n],n)
            id.bar[i][n]=nil
        end
    end
end