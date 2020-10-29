function ms.newMap(ids)
    rounds=rounds+1
    nextMap=ids and ids or (rounds==6 and math.random(#specialMaps) or math.random(#maps))
    if not ids then
        while nextMap==lastMap do
            nextMap=rounds==6 and math.random(#specialMaps) or math.random(#maps)
        end
    end
    lastMap=nextMap
    cat=rounds==6 and 5 or maps[nextMap].category
    local code=rounds==6 and specialMaps[nextMap].code or maps[nextMap].code
    if rounds==6 then
        rounds=0
    end
    local chanceToMirror=math.random(0,1)
    local mirrored=chanceToMirror==1
    if cat==5 then
        tfm.exec.newGame(code,false)
    else
        tfm.exec.newGame(code,maps[nextMap].m=="random" and mirrored or maps[nextMap].m)
    end
    if cat~=5 then
        local settings=maps[nextMap]
        mapSet={
            noAuto=settings.noAuto,
            canRetro=false,
            retro=settings.retro,
            hs={
                x=settings.x.h,
                y=settings.y.h
            },
            vs={
                x=settings.x.v,
                y=settings.y.v
            },
            image={
                settings.i,
                settings.img
            },
            halloween=(month==months.halloween[1] or month==months.halloween[2]) and settings.halloween or false,
            avd=(month==months.avd[1] or month==months.avd[2]) and settings.avd or false,
            noLeader=settings.noLeader,
            title=settings.name,
            gems=nil,
        }
    end
	if mapSet.retro then
		retroChance=math.random(0,3)
		if retroChance==0 then
			mapSet.canRetro=true
		end
    end
    if cat==5 then
        mapSet.halloween=false
        mapSet.avd=false
        mapSet.canRetro=false
    end
    if (month==months.stones[1] or month==months.stones[2]) and cat~=5 and not mapSet.canRetro then
        mapSet.gems={h={id=math.random(1,6),x=math.random(450,750),y=math.random(100,350)},v={id=math.random(1,6),x=math.random(50,350),y=math.random(100,350)}}
        for n in pairs(tfm.get.room.playerList) do
            if data[n][1]==1 and data[n][3]==1 then
                id.gem[n]=tfm.exec.addImage(stones.vis[mapSet.gems[data[n][2]].id]..".png","_666",mapSet.gems[data[n][2]].x,mapSet.gems[data[n][2]].y,n)
            end
        end
    end
end

function ms.removeMapImages()
    if winImg then
        tfm.exec.removeImage(winImg)
    end
end

lobbyImg=""
function ms.newGame()
    ms.removeMapImages()
    if play then
        startCool=false
        ms.newMap()
        if lobbyImg then
            tfm.exec.removeImage(lobbyImg)
        end
    else
        startCool=true
        tfm.exec.newGame("@7796992")
        lobbyImg=tfm.exec.addImage("17574daaa75.png","?666",0,0)
        for n in pairs(tfm.get.room.playerList) do
            if data[n] and data[n][1]==1 and data[n][3]==1 then
                tfm.exec.movePlayer(n,teams[data[n][2]].lbx,teams[data[n][2]].lby)
            end
        end
    end
end

function ms.toStart()
    local i=0
    for n,p in pairs(tfm.get.room.playerList) do
        if not p.isDead then
            i=i+1
        end
    end
    if i==0 then
        teams["h"].hp=100
        teams["v"].hp=100
        tfm.exec.setGameTime(6)
    end
end

function ms.changeGroundColor()
    for i=0,-100 do
        tfm.exec.removePhysicObject(i)
    end
    local xml=tfm.get.room.xmlMapInfo.xml
    local groundsInf={}
    local luaInf={}
    local colors={"030951","FF0054","FF00E4","5500FF","00bfff","00c602","FEFF00","D4AF37","FF3B00","FFF780","BAFF97","0000ff","ff3030","F2F3F4","222222","ff8e38","8564ad","00dd75","A1CAF1","BE0032","C2B280","848482","008856","00ffbb","0080d1","F99379","604E97","d13838","99375a","2f5003","882D17","8DB600","654522","E25822","57754f"}
    for ground in string.gmatch(xml, '<S .-/>') do
        if ground:find("disco")~=nil then
            local groundTable=string.split(ground, "[^,]+")
            local friction=groundTable[3]
            local restitution=groundTable[4]
            local angle=groundTable[5]
            groundsInf[#groundsInf+1]={a=angle,f=friction,r=restitution,id=tonumber(ground:match('T="(.-)"')),l=tonumber(ground:match('L="(.-)"')),h=tonumber(ground:match('H="(.-)"')),x=tonumber(ground:match('X="(.-)"')),y=tonumber(ground:match('Y="(.-)"'))}
        end
        if ground:find("lua")~=nil then
            local groundTable=string.split(ground, "[^,]+")
            local friction=groundTable[3]
            local restitution=groundTable[4]
            local angle=groundTable[5]
            luaInf[#luaInf+1]={color=ground:match('o="(.-)"'),a=angle,f=friction,r=restitution,id=tonumber(ground:match('T="(.-)"')),l=tonumber(ground:match('L="(.-)"')),h=tonumber(ground:match('H="(.-)"')),x=tonumber(ground:match('X="(.-)"')),y=tonumber(ground:match('Y="(.-)"'))}
        end
    end
    local id=0
    for i=1,#luaInf do
        id=id-1
        tfm.exec.addPhysicObject(id,luaInf[i].x,luaInf[i].y,{type=luaInf[i].id,width=luaInf[i].l,height=luaInf[i].h,foreground=false,friction=luaInf[i].f,restitution=luaInf[i].r,angle=luaInf[i].a,miceCollision=true,color="0x"..luaInf[i].color,groundCollision=false})
    end
    for i=1,#groundsInf do
        id=id-1
        tfm.exec.addPhysicObject(id,groundsInf[i].x,groundsInf[i].y,{type=groundsInf[i].id,width=groundsInf[i].l,height=groundsInf[i].h,foreground=false,friction=groundsInf[i].f,restitution=groundsInf[i].r,angle=groundsInf[i].a,miceCollision=true,color="0x"..colors[math.random(#colors)],groundCollision=false})
    end
end