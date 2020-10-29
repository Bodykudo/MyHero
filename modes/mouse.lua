month=tonumber(os.date("%m"))
lastMap,nextMap="0","1"
toDespawn={}
object=0
started=false
for _,v in pairs ({'disableAutoScore','disablePhysicalConsumables','disableAutoNewGame','disableDebugCommand','disableMinimalistMode','disableMortCommand','disableAutoTimeLeft','disableAutoShaman'}) do
    tfm.exec[v](true)
end

specialMaps={
    {code="@4036170",category=5,x=135,y={310,345}},
    {code="@4028489",category=5,x=125,y={300,330}},
    {code="@4036102",category=5,x=125,y={300,330}},
    {code="@4068909",category=5,x=235,y={290,320}},
    {code="@4057145",category=5,x=130,y={300,325}},
    {code="@4064435",category=5,x=95,y={280,310}},
    {code="@4213786",category=5,x=130,y={130,145}},
    {code="@4090781",category=5,x=170,y={310,340}},
    {code="@4053523",category=5,x=55,y={280,310}},
    {code="@4057160",category=5,x=200,y={255,275}},
    {code="@4058137",category=5,x=130,y={240,260}},
    {code="@4051654",category=5,x=155,y={215,235}},
    {code="@4051629",category=5,x=168,y={290,325}},
    {code="@4057519",category=5,x=170,y={145,175}},
    {code="@4059310",category=5,x=265,y={300,325}},
    {code="@4058929",category=5,x=135,y={210,250}},
    {code="@4065563",category=5,x=160,y={240,285}},
    {code="@1322871",category=5,x=95,y={295,335}},
    {code="@4039444",category=5,x=185,y={280,330}},
    {code="@4035181",category=5,x=120,y={290,330}},
    {code="@3819320",category=5,x=180,y={140,175}},
    {code="@4040260",category=5,x=165,y={155,195}},
    {code="@4050961",category=5,x=130,y={285,325}},
    {code="@1855453",category=5,x=100,y={122,135}},
    {code="@6640622",category=5,x=200,y={205,245}},
    {code="@7515828",category=5,x=110,y={225,260}},
    {code="@7583879",category=5,x=205,y={295,330}},
}

function newMap()
    map={}
    i=0
    for _,v in pairs(specialMaps) do
        i=i+1
        map[i]=v.code
    end
    nextMap=math.random(#map)
    while nextMap==lastMap do
        nextMap=math.random(#map)
    end
    lastMap=nextMap
    tfm.exec.newGame(map[nextMap])
end

function eventNewGame()
    map=tfm.get.room.currentMap
    started=false
    tfm.exec.setGameTime(63)
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
    if month==10 or month==11 then
        for i=1,#cheeses do
            table.insert(cheesesImages, tfm.exec.addImage("1595145f956.png","!1",cheeses[i].x-34,cheeses[i].y-41))
        end
    end
    table.foreach(tfm.get.room.playerList,tfm.exec.freezePlayer)
end

local t=0
function eventLoop(time,remaining)
    for i,cannon in ipairs(toDespawn) do
        if cannon[1] <= os.time()-3000 then
            tfm.exec.removeObject(cannon[2])
            table.remove(toDespawn,i)
        end
    end
    if time >= 3000 and not started then
        started=true
        for n in pairs(tfm.get.room.playerList) do
            tfm.exec.freezePlayer(n,false)
        end
    end
    if remaining <= 0 then
        newMap()
    end
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

function toStart(n)
    local i=0
    for n,p in pairs(tfm.get.room.playerList) do
        if not p.isDead then
            i=i+1
        end
    end
    if i==0 then
        newMap()
    elseif i==1 then
        tfm.exec.setGameTime(5)
    end
end
eventPlayerDied=toStart
eventPlayerWon=toStart
newMap()