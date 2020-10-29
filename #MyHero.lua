VERSION = "2.0.0"

submodes={
    "maps", --submode tool to try the new #Myhero maps, made by Bodykudo#0000
    "artking", --submode minigame, made by Aron#6810
    "mouse", --submode minigame inspired from #Myhero, made by Bodykudo#0000
    "auto", --submode minigame inspired from #Myhero, made by Bodykudo#0000
    
}
tfmcnns=1718

function isMode(submode)
    return string.find(tfm.get.room.name, "^[a-z][a-z2]%-#myhero%d+"..submode.."%d*$") or string.find(tfm.get.room.name, "^%*?#myhero%d+"..submode.."%d*$")
end

if isMode("maps") and tfm.get.room.playerList["Bodykudo#0000"] then
--[[ File modes/maps.lua ]]--
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
--[[ End of file modes/maps.lua ]]--
elseif isMode("artking") then
--[[ File modes/artking.lua ]]--
-- artking script by Aron#6810
for _,modulo in next,{"disableAfkDeath","disableAutoNewGame","disableAutoScore","disableAutoShaman","disableAutoTimeLeft","disablePhysicalConsumables"} do
    tfm.exec[modulo](true)
end
admins = {["Aron#6810"] = true , ["Wassim_pro#1386"] = true , ["Crawen#1820"] = true , ["Walllid#0000"] = true , ["Buu#1879"] = true}
p = {}
banned = {}
drow = {}
subjects = {"زهرة","شمس","قمر","انسان","علبة","ماء","قارورة عصير","شاحنة","سيارة","مدرسة","كلب","قطة","قرد","فار","كوكب الارض","كرسي","باب","نافذة","اشارة مرور","اسفنجة","طائرة","هاتف","شجرة","تفاحة","موزة","فراولة","عملة نقدية","كاس","دمية","سرير","منزل","قبعة","قرش","برجر","حذاء","غيوم","جبنة","هلال","نمر","شاورما"}
tfm.exec.newGame("@7783037")
canAns = false
candr = false
local drawer = 0
local sub =  0
function module()
    players = {}
    for name , player in next, tfm.get.room.playerList do
        table.insert(players,name)
        drow[name] = false
    end
    tfm.exec.setUIMapName("<ch> يتم إختيار رسام ... </ch>")
end

chose = 0
function eventLoop(past,left)
    chose = chose + 1
    if left < 1000 then
        tfm.exec.newGame("@7783037")
    end
    if chose == 20 then
        drower()
    end
end

function drower()
    drawer = math.random(#players)
    sub = math.random(#subjects)
    if not banned[players[drawer]] then
        drow[players[drawer]] = true
        tfm.exec.killPlayer(players[drawer])
        tfm.exec.chatMessage("<vp> حان وقت تخمين الرسمة التي سيرسمها الرسام !!!")
        tfm.exec.setUIMapName("<ch>الرسام :</ch>".. " " .. players[drawer])
        ui.addTextArea(0, "<p align='center'><font size='23'> الرسمة التي يجب عليك رسمها هي " .. " " .. subjects[sub] , players[drawer], 7, 34, 788, 56, 0x0d171c, 0x000000, 1, true)
        ui.addTextArea(2, "<a href='event:clear'><p align='center'>C", players[drawer], 11, 316, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", players[drawer], 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
        ui.addTextArea(3, "<a href='event:-'><p align='center'><b>-", players[drawer], 11, 287, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        ui.addTextArea(4, "<a href='event:+'><p align='center'><b>+", players[drawer], 11, 260, 21, 20, 0x0d1214, 0xc9db00, 1, true)
        system.bindMouse(players[drawer],true)
        canAns = true
        candr = true
    else
        tfm.exec.setUIMapName("<ch>الرسام : الرسام محظور</ch>")
        tfm.exec.setGameTime(0,true)
    end
end

function eventNewGame()
    for name , player in next, tfm.get.room.playerList do
        system.bindMouse(name,false)
        if admins[name] then
            tfm.exec.setNameColor(name,0xFF0000)
        end
    end
    for _,remove in next,{0,1,2,3,4} do
        ui.removeTextArea(remove,nil)
    end
    for id = 4,id do
        ui.removeTextArea(id,nil)
    end
    sub = math.random(#subjects)
    module()
    chose = 0
    votes = 0
    canAns = false
    candr = false
end

sub = math.random(#subjects)

function eventChatMessage(name,message)
    if message == subjects[sub] then
        p[name].ban = p[name].ban + 1
        if p[name].ban == 1 then
            tfm.exec.chatMessage("<r> تحذير : لايمكنك مشاركة الأجوبة مع باقي الاشخاص (1/2)",name)
        end
        if p[name].ban == 2 then
            tfm.exec.chatMessage("<r> تحذير : لايمكنك مشاركة الأجوبة مع باقي الاشخاص (2/2) تم حظرك !",name)
            ui.addTextArea(999910009, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
            banned[name] = true
        end
    end
end

id = 6
size1 = 14
size2 = 16
function eventMouse(name,x,y)
    id = id + 1
    ui.addTextArea(id, "", nil, x , y , size1, size2, uicolor, uicolor, 1, false)
end

votes = 0
function eventChatCommand(name,command)
    local args = {}
    for name in command:gmatch("%S+") do
        table.insert(args, name)
    end
    if admins[name] then
        if args[1] == "time" then
            tfm.exec.setGameTime(tonumber(args[2]),true)
        elseif args[1] == "ban" then
            banned[args[2]] = true
            ui.addTextArea(1000000000000000000, "",args[2], -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
            tfm.exec.chatMessage("<r>لقد تم حظر اللاعب :" .. "  " .. args[2] .. "\n" .. " " .. "بسبب : " .. " " .. args[3])
        elseif args[1] == "warn" then
            tfm.exec.chatMessage("<r> لقد تم تحذيرك لأنك خالفت احد قوانين النمط",args[2])
        end
    end
    if not drow[name] then
        if command == "an" then
            ui.addPopup(1,2,"<p align='center'> اكتب هنا توقعك هنا !",name, 7, 34, 788,true)
        end
    else
        tfm.exec.chatMessage("<r> انت الرسام لايمكنك الإجابة نوب !!!",name)
    end 
end

click = os.time()
clear_time = os.time()
function eventTextAreaCallback(id,name,callback)
    if callback ==  "color" then
        ui.showColorPicker(1,name,0,"إختر لون الرسام الخاص بك")
    elseif callback == "+" then
        size1 = size1 + 3
        size2 = size2 + 3
    elseif callback == "-" then
        if click+2000 < os.time() then
            size1 = size1 - 3
            size2 = size2 - 3
            if size1 == -4 then
                size1 = 11
            end
            if size2 == -2 then
                size2 = 13
            end
            click = os.time()
        end
    elseif callback == "clear" then
        if clear_time+2000 < os.time() then
            for id = 5,999 do
                ui.removeTextArea(id,nil)
            end
            id = 5
            clear_time = os.time()
        end
    end
end


sub = math.random(#subjects)
function eventPopupAnswer(id, name, answer)
    if id == 1 then
        if answer == subjects[sub] then
            tfm.exec.chatMessage("<vp> لقد أجاب بشكل صحيح مبرووك ! "..name.."",nil)
            tfm.exec.giveCheese(name)
            tfm.exec.playerVictory(name)
        else
            tfm.exec.chatMessage("<r> إجابة خطأ ! نوب </r>",name)
        end
    end
end

function eventColorPicked(id, name, color)
    uicolor = color
    if candr == true then
        ui.addTextArea(1, "<a href='event:color'>                                                                 \n                                                                                          \n                                          ", name, 9, 343, 40, 52,uicolor, 0xc9db00, 1, true)
    end
end

function eventNewPlayer(name)
    if not p[name] then
        p[name] = {ban = 0}
    end
    tfm.exec.chatMessage("<vp> مرحبا بك في النمط ! \n سيختار النمط شخصا عشوائيا للرسم وعليك عند تخمين الرسمة \n كتابة الإيعاز التالي : !an \n وكتابة تخمينك \n تم صناعة النمط من قبل Aron#6810",name)
    if banned[name] then
        ui.addTextArea(1000000000000000000, "",name, -404, -137, 1576, 874, 0x040505, 0x000000, 1, true)
    end
    if admins[name] then
        tfm.exec.setNameColor(name,0xFF0000)
    end
end

function eventPlayerLeft(name)
    if drow[name] then
        tfm.exec.chatMessage("<r> لقد غادر الرسام الغرفة جاري الإنتقال الى الجولة التالية ...")
        tfm.exec.setGameTime(0,true)
        drow[name] = false
    end
end

function eventPlayerWon(name)
    local alive = 0
    for name, player in next, tfm.get.room.playerList do
        if not player.isDead then
            alive = alive + 1
        end
    end
    if alive == 0 then
        tfm.exec.setGameTime(0,true)
        tfm.exec.chatMessage("<r> تحذير : لايوجد عدد لاعبيين كافي للإستمرار")
    end
end

function eventPlayerDied(name)
    local alive = 0
    for name, player in next, tfm.get.room.playerList do
        if not player.isDead then
            alive = alive + 1
        end
    end
    if alive == 0 then
        tfm.exec.setGameTime(0,true)
        tfm.exec.chatMessage("<r> تحذير : لايوجد عدد لاعبيين كافي للإستمرار")
    end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
--[[ End of file modes/artking.lua ]]--
elseif isMode("mouse") then
--[[ File modes/mouse.lua ]]--
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
--[[ End of file modes/mouse.lua ]]--
else
local translations={}
--[[ File main.lua ]]--
month=tonumber(os.date("%m"))
teams={
    h={
        arm={
            right="174a835a5fe",
            left="174a83ab9f9"
        },
        members={},
        inRoomMembers={},
        notInRoom={},
        coolodown=false,
        isWinner=false,
        color=0x61B6BD,
        color2='61B6BD',
        ir=0,
        ig=0,
        hp=100,
        timer=30,
        lbx=600,
        lby=374,
    },
    v={
        arm={
            right="174a83632f9",
            left="174a83b18d5"
        },
        members={},
        inRoomMembers={},
        notInRoom={},
        coolodown=false,
        isWinner=false,
        color=0xAD2428,
        color2='AD2428',
        ir=0,
        ig=0,
        hp=100,
        timer=30,
        lbx=200,
        lby=374,
        wins=0
    }
}

powerColors={norm={[0]=0x0CA027,[1]=0x11D835,[2]=0x02FF17,[3]=0x37FF04,[4]=0x4FFF07,[5]=0xB6FF0D,[6]=0xFFE811,[7]=0xFFB414,[8]=0xFF8315,[9]=0xFF570D,[10]=0xFF1504,[11]=0xC61003},aie={[0]=0x0CA027,[1]=0x02FF17,[2]=0x4FFF07,[3]=0xFFE811,[4]=0xFF8315,[5]=0xFF1504,[6]=0xC61003}}
times={"17464d4a350","17464d2c2c8","17464d4eaa9","17464d3dd73","17464d3b3a1","17464d413f7"}
commus={bg="16501fe9900",br="16501feb767",es="16502016f7e",en="16502014e66",e2="16502014e66",ch="16502014e66",az="16502014e66",ee="16502012786",de="16502010d54",cz="1650200f889",cn="1650200dcb8",he="1650201cd14",fr="1650201ae36",fi="16502018f27",hu="1650202c454",hr="16502029140",it="165020300f6",id="1650202ed53",jp="165020338b5",lt="16502035415",lv="16502037161",nl="1650203a27f",pl="16502046783",ph="16502043268",pt="1650204a49f",ro="1650204bfab",ru="1650204f3c4",ar="165020563f3",sk="16502069482",vk="1650206ff15",xx="16502071c3a",tr="1650206d73c"}

testTime=31
particles={
    [1]={9,13,14,21,23,29,33},
    [2]={21,30,31,43,44},
    [3]={1,2,9,11,13},
    [4]={2,11,24,32,33,34},
    [5]={1,2,9,11,13},
    [6]={1,2,9,11,13},
    [7]={1,2,9,11,13},
    [8]={1,2,9,11,13},
    [9]={1,2,9,11,13},
    [10]={1,13,21,38,39,40},
    [11]={1,13,21,38,39,40},
    [12]={9,13,14,21,23,29,33},
}

months={
    avd={8,9},
    stones={4,5},
    halloween={10,11},
}

UpdateFileTime=os.time()
play=false
started=false
started2=false
nextMap=0
lastMap=1
rounds=0
cat=0
startCool=true
winImg=""
data={}
p={}
toDespawn={}
portals={}
ob={}
ms={}

id={
    help={{},{},{},{},{},{}},
    sKit={{},{},{},{},{},{},{}},
	teams={{},{}},
    kit={},
    bow={},
    gem={},
    bar={{},{},{}},
    skill={},
    shoot={},
    icon={},
    licon={},
    bg={},
    shop={{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}},
    profile={{},{},{},{},{},{},{}},
    lb={{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}
}

links={
    maps="https://atelier801.com/topic?f=6&t=880237",
    donate="https://a801-luadev.github.io/?redirect=myhero",
    code="https://github.com/Bodykudo/MyHero",
    discord="https://discord.gg/eXNvcEz",
}

grounds={}

keys={[79]="openShop",[80]="openProfile",[76]="openRank",[72]="openHelp"}
helpC={"Creativemice#7925","Austinbacky#0010","Tocutoeltuco<#0000","Extremq#0000","Stefanmocarz#0000","Syc#1270","Uvfn#0000","Vigo#4765","Sebafrancuz#0000","Lunartear#6947","Smutny_nalesnik#0000","Kariina#2631","Sonicyss#0000","Bodykudo#0000","Mouny#6831","Error_404#0000","Urook#1131","Rkubi#0000","Liiliiith#0000","Maroidofli#0000","Turkitutu#0000","Massi#0015","Bolodefchoco#0000","Heniyengui#0000"}
mapC={"Zhouajie#0000","Keselekcabe#0000","Ikke#0095","Dextech#0000","Lucahappy#0000","Merahmuda#0000","Bestgameplay#0000","Veredar#0000","Arber#0000","Shamousey#0015","Xaxadoooooo#0000","Obsyt#0000","Sazd#0148","Obsyt#0000","Alsalam_alaikum#5209","Urook#1131","Error_404#0000","Ace#1270","O_o#8507","Miminou1#0000","Nohkr#0000","Uvfn#0000","Amrtast#0000","Tennis#8153","Madaryagah#0000","Virtini#0000","Naegi#9945","Meshia#9096","Stefanmocarz#0000","Vintage#0246","Mega#8623","Eyux#0000","Guga#7697","Tytnc#0000","Aron#6810","Dariusseby_y#1467","Weafle#5669","Lunartear#6947","Avaelle#7027","Artgir#0000","Smutny_nalesnik#0000","Viniciusdara#0000","Perfecteca#0000","Refused#6163","Sekui#0000","Alarobzein#0000","Ifo#4275","Brpiy#6028","B0wl#7075"}

artists={
	l="Liiliiith#0000",
	k="Kariina#2631",
	s="Sonicyss#0000",
	m="Mouny#6831",
    u="Lunartear#6947",
    r="Ricardinhotv#0000",
}

text={}
translations={}

for _,v in pairs ({'disableAutoScore','disablePhysicalConsumables','disableAutoNewGame','disableMinimalistMode','disableMortCommand','disableAutoTimeLeft','disableAutoShaman','disableDebugCommand'}) do
    tfm.exec[v](true)
end
tfm.exec.setRoomMaxPlayers(26)

stones={
    vis={"169dbcc27a3","169dbcc90fb","169dbcc73e8","169dbccdf1e","169dbcbb22a","169dbcbecb7"},
    inVis={"169dbcc4503","169dbcc09de","169dbcd1974","169dbccfc35","169dbccb80b","169dbcbcf83"}
}

function ms.close(n)
    for i=100,150 do
        ui.removeTextArea(i,n)
    end
    for i=1,15 do
        if id.shop[i][n] then
            tfm.exec.removeImage(id.shop[i][n],n)
            id.shop[i][n]=nil
        end
    end
    for i=1,6 do
        if id.profile[i][n] then
            tfm.exec.removeImage(id.profile[i][n],n)
            id.profile[i][n]=nil
        end
    end
    for i=1,5 do
        if id.help[i][n] then
            tfm.exec.removeImage(id.help[i][n],n)
            id.help[i][n]=nil
        end
    end
    for i=1,14 do
        if id.lb[i][n] then
            tfm.exec.removeImage(id.lb[i][n],n)
            id.lb[i][n]=nil
        end
    end
end
--[[ End of file main.lua ]]--
--[[ File changelog.lua ]]--
updates={
    ["2.0.0"]={
        text=[[
            #MyHero Version 2.0.0
                Welcome to the all new all different #MyHero, the module has been remade in a new look!
                What's new?
                    • The module's UI has been updated.
                    • Kits System has been implented.
                    • Halloween event is back.
                    • New special halloween cannons have been added.
                    • New game mode is introduced: Retro Maps.
        ]],
        img="",
    },
}
--[[ End of file changelog.lua ]]--
--[[ Directory functions ]]--
--[[ File functions/otherFunctions.lua ]]--
function math.rotate(x,y,centerx, centery, ang)
    ang = ang/(180/math.pi)
    return centerx + (x - centerx) * math.cos(ang) - (y - centery) * math.sin(ang) , centery + (x - centerx) * math.sin(ang) + (y - centery) * math.cos(ang)
end

function string.split(str,pattern,f)
    local out = {}
    for value in string.gmatch(str, pattern) do
        out[#out + 1] = not f and value or f(value)
    end
    return out
end
--[[ End of file functions/otherFunctions.lua ]]--
--[[ File functions/tableFunctions.lua ]]--
function table.indexesConcat(list,sep,f,i,j)
    local txt = ""
    sep = sep or ""
    i,j = i or 1,j or #list
    for k,v in next,list do
        if type(k) ~= "number" and true or (k >= i and k <= j) then
            txt = txt .. (f and f(k,v) or v) .. sep
        end
    end
    return string.sub(txt,1,-1-#sep)
end

function table.find(list,value,index,f)
    for k,v in next,list do
        local i = (type(v) == "table" and index and v[index] or v)
        if (not f and i or f(i)) == value then
            return true,k
        end
    end
    return false,0
end

function table.count(tbl)
    local out = 0
    for k in next, tbl do
        out = out + 1
    end
    return out
end
--[[ End of file functions/tableFunctions.lua ]]--
--[[ End of directory functions ]]--
--[[ Directory tables ]]--
--[[ File tables/chars.lua ]]--
charsList={h={"super","bat","wonder"},v={"joker","dark"}}
chars={
    h={
        super="Superman",
        bat="Batman",
        wonder="Wonder Woman",
    },
    v={
        joker="Joker",
        dark="Darkseid",
    }
}
--[[ End of file tables/chars.lua ]]--
--[[ File tables/kits.lua ]]--
kits={
	[41]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,p[n].right and 90 or -90,0,false)
			for i = 1,10 do
				tfm.exec.displayParticle(35,p[n].right and x or x+100,y,(p[n].righ and 15 or -15),math.random(-3,3))
			end
		end,7000,"174605a2318",
		img="17427798f8b",
		price=15,
		max=20,
	},
	[42]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,0,-70,false)
			tfm.exec.displayParticle(12,x,y+30)
		end,7000,"1746059d7be",
		img="17427796adb",
		price=20,
		max=20,
    },
	[43]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,0,-90,false)
			for i = 0,15,.25 do
				tfm.exec.displayParticle(({1,9})[((i*4)%2)+1],x+math.sin(i*1.1)*20,y+40+-i*3.5)
			end
		end,7000,"174605a5d53",
		img="1742779ac77",
		price=25,
		max=20,
	},
    [44]={
		img="1742778d002",
		price=35,
		max=20,
    }
}
--[[ End of file tables/kits.lua ]]--
--[[ File tables/maps.lua ]]--
--@3872590
--[[Small maps
Bodykudo#0000 - @7562882 - 0 - 100% - P22
Bodykudo#0000 - @7563081 - 0 - 100% - P22
Bodykudo#0000 - @7563085 - 0 - 100% - P22
Bodykudo#0000 - @7563168 - 0 - 100% - P22
Bodykudo#0000 - @7563170 - 0 - 100% - P22

<C><P F="0" /><Z><S><S H="400" L="170" o="6a7495" X="716" c="4" Y="200" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="170" o="6a7495" X="85" c="4" Y="200" T="12" H="400" /><S X="407" L="3000" o="6a7495" H="50" c="3" Y="25" T="12" P="0,0,0.3,0.2,0,0,0,0" /></S><D /><O /></Z></C>
]]

maps={
    {code="@7446759",x={h=679,v=119},y={h=113,v=113},category=1,noAuto=true},
    --{code="@7447518",x={h=558,v=244},y={h=323,v=323},i=true,img="163e102a725",category=0,noAuto=true},
    {code="@7448303",x={h=644,v=170},y={h=164,v=164},category=1},

    {code="@7454155",x={h=500,v=288},y={h=220,v=220},category=0,noAuto=true},
    {code="@7455348",x={h=580,v=220},y={h=265,v=265},category=0,noAuto=true,}, --RETRO
    {code="@7454955",x={h=538,v=170},y={h=143,v=164},category=0},

    {code="@7471745",x={h=645,v=280},y={h=265,v=225},category=4,noAuto=true},
    {code="@7471761",x={h=760,v=180},y={h=145,v=120},category=0},
    {code="@7473422",x={h=622,v=182},y={h=82 ,v=82},category=8},

    {code="@7363014",x={h=590,v=200},y={h=46,v=46},category=0},
    {code="@6796647",x={h=770,v=24},y={h=152,v=151},category=2},
    {code="@7475859",x={h=665,v=130},y={h=260,v=260},category=3,noAuto=true},
    {code="@7301151",x={h=592,v=210},y={h=52,v=52},category=0},

    {code="@7477238",x={h=570,v=232},y={h=185,v=185},category=8,noAuto=true},
    {code="@7473855",x={h=650,v=235},y={h=305,v=325},m=true,category=0},
    {code="@7173018",x={h=620,v=178},y={h=196,v=196},category=0,noAuto=true},
    {code="@6840774",x={h=533,v=271},y={h=369,v=369},category=3,noAuto=true},
    {code="@7477433",x={h=730,v=70},y={h=95,v=95},category=1},
    {code="@7475958",x={h=685,v=120},y={h=119,v=119},category=3,noAuto=true},
    {code="@7492057",x={h=680,v=125},y={h=325,v=325},category=4,noAuto=true},
    {code="@7377403",x={h=595,v=200},y={h=210,v=210},category=0},
    {code="@7373690",x={h=424,v=375},y={h=200,v=200},category=3,noAuto=true},
    {code="@7377552",x={h=690,v=100},y={h=295,v=295},category=4,noAuto=true},
    {code="@7175000",x={h=575,v=225},y={h=225,v=225},category=1},
    {code="@6563485",x={h=460,v=340},y={h=355,v=355},category=3,noAuto=true},
    {code="@7499711",x={h=630,v=155},y={h=294,v=293},category=4,noAuto=true},
    {code="@7226782",x={h=441,v=358},y={h=270,v=270},category=6,noAuto=true},
    {code="@7225259",x={h=760,v=46},y={h=108,v=108},category=6,noAuto=true},
    {code="@7503295",x={h=675,v=115},y={h=83,v=85},category=6,noAuto=true},
    {code="@7223467",x={h=460,v=335},y={h=373,v=373},category=1,noAuto=true},
    {code="@7506242",x={h=725,v=106},y={h=164,v=164},category=4,noAuto=true},
    {code="@7222447",x={h=602,v=202},y={h=245,v=245},category=4,noAuto=true},
    {code="@7470893",x={h=485,v=310},y={h=95,v=95},category=6,noAuto=true},
    {code="@7515987",x={h=650,v=155},y={h=207,v=207},category=8},
    {code="@7515989",x={h=525,v=270},y={h=242,v=242},category=8,noAuto=true},
    {code="@7519468",x={h=650,v=150},y={h=150,v=150},category=4,noAuto=true},
    {code="@7519105",x={h=615,v=180},y={h=240,v=240},category=8},
    {code="@7521008",x={h=485,v=305},y={h=100,v=100},category=8},
    {code="@7519753",x={h=700,v=98},y={h=154,v=154},category=3,noAuto=true},
    {code="@7562992",x={h=770,v=25},y={h=85,v=85},category=1},
    {code="@7563892",x={h=650,v=150},y={h=165,v=165},category=4,noAuto=true},
    {code="@7568883",x={h=720,v=80},y={h=203,v=203},category=6,noAuto=true},
    {code="@7570476",x={h=590,v=215},y={h=275,v=275},category=0},

    {code="@7583880",x={h=600,v=200},y={h=140,v=140},category=4,noAuto=true,}, --RETRO
    {code="@1159080",x={h=530,v=135},y={h=237,v=147},category=2},
    {code="@3385128",x={h=760,v=30},y={h=315,v=315},category=1},
    {code="@1623117",x={h=565,v=198},y={h=174,v=213},category=0},
    {code="@4649979",x={h=505,v=295},y={h=105,v=135},category=1,noAuto=true},
    {code="@7625536",x={h=435,v=365},y={h=355,v=355},category=1},
    {code="@7210386",x={h=450,v=350},y={h=291,v=291},category=4,noAuto=true},
    {code="@7625946",x={h=680,v=85},y={h=140,v=140},category=2},
    {code="@6828230",x={h=560,v=240},y={h=238,v=238},category=4,noAuto=true},
    {code="@4790522",x={h=650,v=150},y={h=85,v=85},category=6,noAuto=true},
    {code="@5093704",x={h=600,v=200},y={h=300,v=300},category=0,}, --RETRO
    {code="@6920848",x={h=713,v=97},y={h=233,v=274},category=7,noAuto=true},
    {code="@7136101",x={h=528,v=289},y={h=70,v=70},category=7,noAuto=true},
    {code="@7217866",x={h=544,v=274},y={h=116,v=115},category=7,noAuto=true},
    {code="@7147188",x={h=450,v=350},y={h=77,v=77},category=7,noAuto=true},
    {code="@6828154",x={h=520,v=280},y={h=172,v=172},category=7,noAuto=true},
    {code="@7278878",x={h=420,v=380},y={h=204,v=204},category=1,m="random"},

    {code="@7128027",x={h=620,v=180},y={h=262,v=280},category=2,noAuto=true},
    {code="@7607345",x={h=680,v=115},y={h=162,v=136},category=2,noAuto=true},
    
    {code="@7690057",x={h=500,v=300},y={h=645,v=645},category=3,noAuto=true},
	{code="@7690161",x={h=500,v=300},y={h=645,v=645},category=1,noAuto=true},
	{code="@7759100",x={h=650,v=210},y={h=455,v=455},category=0},
	{code="@7759318",x={h=660,v=140},y={h=655,v=655},category=0,}, --RETRO
	{code="@7759383",x={h=633,v=166},y={h=376,v=374},category=0,}, --RETRO
	{code="@7760270",x={h=600,v=200},y={h=705,v=705},category=0},
	{code="@7759514",x={h=585,v=215},y={h=240,v=240},category=3,noAuto=true},
	{code="@7760010",x={h=610,v=190},y={h=492,v=493},category=3},
	{code="@7759324",x={h=530,v=270},y={h=352,v=352},category=6,noAuto=true},
	{code="@7759862",x={h=502,v=297},y={h=362,v=362},category=6,noAuto=true},
	{code="@7760042",x={h=636,v=163},y={h=134,v=134},category=7,noAuto=true},
	{code="@7760971",x={h=570,v=200},y={h=285,v=294},category=3,noAuto=true},
	{code="@7761255",x={h=725,v=155},y={h=156,v=194},category=0,noAuto=true},
	{code="@7761489",x={h=470,v=330},y={h=350,v=350},category=0,}, --RETRO
	{code="@7761560",x={h=595,v=205},y={h=247,v=247},category=3,noAuto=true},
	{code="@7760990",x={h=550,v=250},y={h=220,v=220},category=3},
	{code="@7761920",x={h=510,v=290},y={h=305,v=305},category=3},
	{code="@7761959",x={h=612,v=188},y={h=190,v=190},category=3,noAuto=true},
    {code="@7761967",x={h=700,v=100},y={h=355,v=355},category=1},
    {code="@7762233",x={h=560,v=240},y={h=605,v=605},category=3},
    {code="@7762357",x={h=424,v=375},y={h=125,v=126},category=0},
    {code="@7683748",x={h=490,v=310},y={h=181,v=181},category=0,}, --RETRO
    {code="@7754965",x={h=500,v=300},y={h=236,v=236},category=4,noAuto=true},
    {code="@7766309",x={h=580,v=220},y={h=75,v=75},category=1},
    {code="@7766292",x={h=520,v=280},y={h=344,v=344},category=0},
    {code="@7765915",x={h=750,v=130},y={h=346,v=345},category=0},
    {code="@7766524",x={h=740,v=60},y={h=57,v=57},category=7,noAuto=true},
    {code="@7765653",x={h=680,v=120},y={h=254,v=254},category=6,noAuto=true},
    {code="@7765614",x={h=460,v=340},y={h=396,v=396},category=4,noAuto=true},
    {code="@7767452",x={h=570,v=230},y={h=163,v=163},category=0},
    {code="@2650870",x={h=700,v=100},y={h=77,v=77},category=0},
    {code="@2478198",x={h=720,v=80},y={h=115,v=115},category=0},
    {code="@2533074",x={h=429,v=370},y={h=355,v=355},category=2},
    {code="@1757679",x={h=424,v=375},y={h=224,v=250},category=0,noAuto=true},
    {code="@1947457",x={h=520,v=261},y={h=221,v=102},category=3,noAuto=true},

    --Retro maps
    {code="@7442984",x={h=780,v=20},y={h=205,v=205},category=0,retro="168e2fc7ff4"},
    {code="@7452156",x={h=630,v=210},y={h=77,v=77},category=0,retro="168e2fcaed5"},
    {code="@7452608",x={h=527,v=270},y={h=103,v=103},category=0,retro="168e2fccbf4"},
    {code="@7454225",x={h=600,v=210},y={h=126,v=126},category=0,retro="168e2fce91b",noAuto=true},
    {code="@7454922",x={h=495,v=305},y={h=355,v=355},category=0,noAuto=true,retro="168e2fd2370"},
    {code="@7463115",x={h=660,v=150},y={h=356,v=356},category=0,retro="168e2fd471f"},
    {code="@7463399",x={h=745,v=65},y={h=258,v=258},category=0,retro="168e2fd6434"},
    {code="@7473404",x={h=438,v=365},y={h=60,v=90},category=0,retro="168e2fd8169"},
    {code="@7473501",x={h=600,v=295},y={h=75,v=205},category=0,retro="168e2fda649"},
    {code="@7475857",x={h=620,v=180},y={h=285,v=285},category=0,noAuto=true,retro="168e2fdc355"},
    {code="@7378652",x={h=650,v=275},y={h=164,v=164},category=0,retro="168e2fde06a"},
    {code="@7473860",x={h=510,v=290},y={h=185,v=185},category=0,retro="168e2fdfd8b"},
    {code="@7477224",x={h=548,v=250},y={h=174,v=165},category=0,retro="168e2fe1a9a"},
    {code="@6562339",x={h=588,v=210},y={h=253,v=253},category=0,noAuto=true,retro="168e2fe39de"},
    {code="@7502946",x={h=683,v=125},y={h=134,v=134},category=6,noAuto=true,retro="168e2fe56fb"},
    
    --Halloween maps
    {code="@6892641",x={h=523,v=275},y={h=136,v=145},category=6,noAuto=true,halloween=true},
    {code="@6760150",x={h=760,v=40},y={h=156,v=156},category=2,halloween=true},
    {code="@7223031",x={h=650,v=148},y={h=310,v=310},category=4,halloween=true,noAuto=true},
    {code="@7079197",x={h=763,v=36},y={h=364,v=364},category=7,halloween=true,noAuto=true},
    {code="@7334600",x={h=717,v=83},y={h=85,v=85},category=1,halloween=true,noAuto=true},
	{code="@7759604",x={h=635,v=165},y={h=354,v=354},category=1,halloween=true},
    {code="@7222891",x={h=606,v=194},y={h=207,v=207},category=1,halloween=true,noAuto=true},
    {code="@7208215",x={h=509,v=295},y={h=271,v=270},category=2,m="random",halloween=true,noAuto=true},
    {code="@7218320",x={h=592,v=213},y={h=249,v=249},category=1,halloween=true},
    {code="@7509872",x={h=570,v=250},y={h=150,v=150},category=2,halloween=true},
    {code="@7500705",x={h=748,v=58},y={h=131,v=126},category=1,halloween=true},
    {code="@7198879",x={h=526,v=267},y={h=137,v=136},category=2,noAuto=true,halloween=true,noAuto=true},
    {code="@7224585",x={h=530,v=270},y={h=55,v=55},category=1,halloween=true,noAuto=true},
    {code="@6887138",x={h=545,v=245},y={h=195,v=240},category=6,noAuto=true,halloween=true},
    {code="@7221873",x={h=586,v=214},y={h=144,v=145},category=0,noAuto=true,halloween=true},
    {code="@7447980",x={h=670,v=245},y={h=65,v=70},category=6,noAuto=true,halloween=true,}, --RETRO
    {code="@7519505",x={h=565,v=240},y={h=315,v=315},category=0,halloween=true},
    {code="@7506957",x={h=638,v=150},y={h=240,v=240},category=0,halloween=true},

    --Angel vs Demons maps
    {code="@7455252",x={h=760,v=40},y={h=173,v=173},m=true,category=2,avd=true},
    {code="@7455383",x={h=720,v=85},y={h=310,v=310},category=2,avd=true},
    {code="@7276061",x={h=625,v=170},y={h=90,v=90},category=2,noAuto=true,avd=true},
    {code="@7228271",x={h=600,v=196},y={h=150,v=150},m=true,category=2,avd=true},
    {code="@7455081",x={h=668,v=144},y={h=145,v=145},category=2,avd=true,noAuto=true},
    {code="@7579933",x={h=549,v=240},y={h=165,v=169},i=true,img="16941718617",category=2,avd=true,noAuto=true},
    {code="@7248933",x={h=540,v=290},y={h=146,v=146},i=true,img="168a06b666a",category=2,avd=true,avid=1,noAuto=true},
    {code="@7309528",x={h=460,v=340},y={h=132,v=132},i=true,img="168aeea0412",category=2,avd=true,avid=2,noAuto=true},
    {code="@6698426",x={h=720,v=80},y={h=346,v=346},i=true,img="168ce3bb80e",category=6,noAuto=true,avd=true,avid=3},
    {code="@7579532",x={h=735,v=65},y={h=88,v=88},i=true,img="1693f1a36dd",category=6,noAuto=true,avd=true,avid=4},
    {code="@7579572",x={h=730,v=65},y={h=73,v=70},i=true,img="1693f1c4f2e",category=2,noAuto=true,avd=true,avid=5},

}

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
mapSet={noAuto=nil,canRetro=false,retro="",hs={x=0,y=0},vs={x=0,y=0},image={false,""},halloween=false,title="",time=63,timeLeft=os.time()}

categories={
    [0]={"Nromal","164dc8ede60",y=374,color="#477238"},
    [1]={"Mech","164dc8efe37",y=374,color="#868B86"},
    [2]={"Art","164dc9f31bd",y=372,color="#b25266"},
    [3]={"Defilante","164dc8f5738",y=372,color="#f8f644"},
    [4]={"Aie","164df18afef",y=374,color="#586335"},
    [5]={"Survivor","164dc8f9726",y=372,color="#b9451d"},
    [6]={"Mirrored","16567048d4d",y=372,color="#d480bb"},
    [7]={"Shaman","164ed7eaf62",y=371,color="#42bfe8"},
    [8]={"Discodance","16566f5d1c4",y=372,color="#9052bc"},
}

mapCats={
    [0]={},
    [1]={},
    [2]={},
    [3]={},
    [4]={},
    [6]={},
    [7]={},
    [8]={},
}

for i,v in pairs(maps) do
    mapCats[v.category][#mapCats[v.category]+1]=i
end
--[[ End of file tables/maps.lua ]]--
--[[ File tables/roles.lua ]]--
roles={
    a={
        icon="173f967697b",
        id=1708,
        color='E6254E',
        xs={
            h=742,
            v=32
        },
        ys=55,
        aie=true,
        sham=true
    },
    p={
        icon="173f966dc3d",
        x=-10,
        y=-85,
        id=1709,
        color='2D93ED',
        time=30,
        skillImg="173f9671ca0",
        aie=true,
        sham=false,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                p[n].skillImg=false
                p[n].timeToSkill=os.time()
                local id=#grounds+1
                id=tfm.exec.addPhysicObject(id,x+(p[n].right and 10 or -10),y+4,{type=12,width=10,height=90,foreground=false,friction=0,restitution=00,angle=0,color=nil,miceCollision=true,groundCollision=true})
                local img=""
                --if data[n][35]==1 then
                img=tfm.exec.addImage(p[n].right and teams[data[n][2]].arm.right..".png" or teams[data[n][2]].arm.left..".png","!999",x+(p[n].right and 5 or -25),y-40)
                --[[else
                    for k,v in pairs(shields) do
                        if v.id==data[n][35] then
                            img=tfm.exec.addImage(p[n].right and v.right..".png" or v.left..".png","!999",x+(p[n].right and v.xr or v.xl),y+v.y)
                        end
                    end
                end]]
                table.insert(grounds,{os.time(),id,img})
            end,
        },
    },
    he={
        icon="173f96844f4",
        id=1701,
        color='2ED748',
        time=180,
        skillImg="173f9666724",
        aie=true,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
                p[n].timeToSkill=os.time()
                teams[data[n][2]].hp=teams[data[n][2]].hp+math.random(7,15)
                ms.hpBar(nil)
                local oppTeam=data[n][2]=="h" and "v" or "h"
                teams[oppTeam].coolodown=true
                system.newTimer(function() teams[oppTeam].coolodown=false end,math.random(6000,7500),false)
            end,
        },
    },
    w={
        icon="173f9679ed5",
        id=1702,
        color='902BDD',
        time=45,
        skillImg="173f967022d",
        aie=false,
        sham=false,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y,target)
                if tfm.get.room.playerList[target] then
                    local X,Y=tfm.get.room.playerList[target].x,tfm.get.room.playerList[target].y
                    tfm.exec.movePlayer(target,X,Y)
                    trap=tfm.exec.addShamanObject(68,X,Y)
                    balloon=tfm.exec.addShamanObject(28,X,Y,0,0,0,true)
                    p[target].trapped=true
                    tfm.exec.addImage("1739d89da14.png","#"..tostring(trap),-45,-25)
                    tfm.exec.addImage("174c861009f.png","#"..tostring(balloon),0,0)
                    tfm.exec.movePlayer(target,X,Y)
                    system.newTimer(function()
                        tfm.exec.removeObject(trap)
                        p[target].trapped=false
                    end,math.random(10000,11500),false)
                end
            end,
        },
    },
    c={
        icon="173f96863d7",
        id=1712,
        color='CF21C9',
        time=45,
        skillImg="173f967378b",
        aie=true,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y,target)
                p[target].stopped=true
                local stoppedImg=tfm.exec.addImage("174a8360e98.png","$"..target,-22,-25)
                system.newTimer(function()
                    p[target].stopped=false
                    if stoppedImg then
                        tfm.exec.removeImage(stoppedImg)
                    end
                end,math.random(10000,11500),false)
            end,
        },
    },
    i={
        icon="173f966b035",
        id=1704,
        color='E0E100',
        time=50,
        skillImg="173f968296b",
        aie=false,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                local t=data[n][2]
                for k in pairs(tfm.get.room.playerList) do
                    if data[k][2]~=data[n][2] and not p[k].afk then
                        tfm.exec.movePlayer(k,0,0,false,t=="h" and -100 or 100,-85,false)
                    end
                end
                for i=1,10 do
                    tfm.exec.displayParticle(26,t=="h" and math.random(0,300) or math.random(500,800),math.random(50,400), ({-5,5})[math.random(1,2)],0,0,0,nil)
                    tfm.exec.displayParticle(27,t=="h" and math.random(0,300) or math.random(500,800) ,math.random(50,400), ({-5,5})[math.random(1,2)],0,0,0,nil)
                end
            end,
        },
    },
}
--[[ End of file tables/roles.lua ]]--
--[[ File tables/shopTables.lua ]]--
--Ids: [1:99]
--NO: 4,5,6,7,8,9,10,11,12,46,47,48,49,50,51,76,77,78
cannons={
	{id=1,inShop="163e2f4401c",text="def"},
	{id=2,inShop="163e2f2388f",right="163e2ef025c",left="1647a500d1b",text="help"},
	{id=3,inShop="163e2f281b0",right="163e2ef7cfb",left="16489307635",text="map"},
	{id=19,inShop="1655eb613c0",right="1655eb6443a",left="1655eb62f0d",text="global",req=1},
	{id=20,inShop="1655ebdb141",right="1655ebd9d8a",left="1655ebd8031",text="global",req=2},
	{id=21,inShop="1655ebdce6f",right="1655ebe04da",left="1655ebde837",text="global",req=3},

	{id=28,inShop="165c0d6530d",right="165c0d63bfa",left="165c0d6243c",req=15,text="halloween",toCounter=32,artist="s"},
	{id=29,inShop="165c0d60ee8",right="165c0d5f986",left="165c0d5e6c5",req=30,text="halloween",toCounter=32,artist="s"},
	{id=30,inShop="165c0d5ab79",right="165c0d594f0",left="165c0d57da4",req=45,text="halloween",toCounter=32,artist="s"},
	{id=67,inShop="16b274657aa",right="16b27463a81",left="16b27461d33",req=50,text="halloween",toCounter=32,artist="m"},
	{id=68,inShop="16b27455120",xs=38,ys=43,right="16b27453408",left="16b274516f1",x=-21,y=-18,xl=-18,yl=-18,req=75,xp=-6,yp=-4,text="halloween",toCounter=32,artist="m"},
	{id=69,inShop="16bd86f98a6",xs=51,ys=41,right="16bd86d510d",left="16bd86d3397",x=-18,y=-23,xl=-18,yl=-23,req=100,xp=-8,yp=-2,text="halloween",toCounter=32,artist="u"},
	{id=97,inShop="1740c939ba0",right="1740c937db1",left="1740c935ff2",req=125,text="halloween",toCounter=32,artist="r"},
	{id=98,inShop="1740c912ee3",xs=35,ys=41,right="1740c91117e",left="1740c90f41a",x=-25,y=-17,xl=-17,yl=-17,yp=-7,req=150,text="halloween",toCounter=32,artist="r"},
	{id=99,inShop="1740c94cd1e",xs=40,ys=35,right="1740c94afb4",left="1740c949253",x=-18,y=-18,xl=-18,yl=-18,req=200,xp=-4,text="halloween",toCounter=32,artist="r"},

	{id=94,inShop="1740c9237a8",right="1740c921a38",left="1740c91fcd7",req=50,text="winRetro",toCounter="we",artist="r"},
	{id=95,inShop="1740c929016",right="1740c9272a4",left="1740c925516",req=100,text="winRetro",toCounter="we",artist="r"},
	{id=96,inShop="1740c907d20",right="1740c905f11",left="1740c92ad91",req=150,text="winRetro",toCounter="we",artist="r"},

	--[[{id=16,inShop="1655e6d0974",right="1655e6ce8f9",left="1655e6d2bb6",req=30,text="win",toCounter=6,artist="l"},
	{id=17,inShop="164f88d9467",xs=38,right="164f88e4562",left="164f88f1afd",req=60,text="win",toCounter=6,artist="l"},
	{id=18,inShop="164f88db013",right="164f88e61fc",left="164f88f35f1",req=100,text="win",toCounter=6,artist="l"},]]

	{id=25,inShop="16572c81fae",right="16572c85475",left="16572c8013d",req=30,text="win",toCounter=6,artist="s"},
	{id=26,inShop="16572c7c79f",right="16572c7e398",left="16572c79eba",req=60,text="win",toCounter=6,artist="s"},
	{id=27,inShop="16572c6872a",right="16572c6a5bc",left="16572c6645f",req=100,text="win",toCounter=6,artist="s"},
	{id=55,inShop="16a21934872",right="16a21932ada",left="16a21930d6f",req=150,text="win",toCounter=6,artist="u"},
	{id=56,inShop="16a2192eff6",right="16a2192d27d",left="16a2192b4f9",req=200,text="win",toCounter=6,artist="u"},
	{id=57,inShop="16a2193f94b",right="16a2193dbd1",left="16a2193be4c",req=250,text="win",toCounter=6,artist="u"},
	{id=58,inShop="16bd871762a",xs=37,ys=42,right="16bd87158e9",left="16bd8713a62",x=-19,y=-17,xl=-18,yl=-18,req=300,text="win",toCounter=6,artist="u"},
	{id=59,inShop="16bd870fb50",xs=37,ys=42,right="16bd870d940",left="16bd870bbd7",x=-18,y=-17,xl=-18,yl=-16,req=350,text="win",toCounter=6,artist="u"},
	{id=60,inShop="16bd86b6a90",xs=37,ys=42,right="16bd86b4d58",left="16bd86b255f",x=-17,y=-17,xl=-17,yl=-17,req=400,text="win",toCounter=6,artist="u"},
	{id=85,inShop="16bd2cbef3b",xs=37,ys=42,right="16bd2cbcffc",left="16bd2cbabfd",x=-17,y=-17,xl=-17,yl=-16,req=600,text="win",toCounter=6,artist="u"},
	{id=86,inShop="16bd2c6aa95",xs=44,ys=49,right="16bd2c68562",left="16bd2c61b1c",x=-26,y=-21,xl=-17,yl=-19,req=800,xp=-4,yp=-10,text="win",toCounter=6,artist="u"},
	{id=87,inShop="16bd2c71ffc",xs=46,ys=51,right="16bd2c6fa19",left="16bd2c6c85c",x=-25,y=-24,xl=-18,yl=-21,req=1000,xp=-3,text="win",toCounter=6,artist="u"},
	{id=88,inShop="16bd2c3cfe9",xs=39,ys=48,right="16bd2c3aad1",left="16bd2c38d99",x=-19,y=-20,xl=-22,yl=-18,req=1250,xp=-3,yp=-2,text="win",toCounter=6,artist="u"},
	{id=89,inShop="16bd2cb87a1",right="16bd2cb6457",left="16bd2cb451e",x=-16,y=-17,xl=-17,yl=-15,req=1500,text="win",toCounter=6,artist="u"},
	{id=90,inShop="16bd2cb2205",xs=60,ys=51,right="16bd2caff99",left="16bd2cadfbe",x=-18,y=-29,xl=-26,yl=-29,req=2000,xp=-13,text="win",toCounter=6,artist="u"},
	
	{id=22,inShop="16572c76cc8",right="16572c78548",left="16572c75564",req=100,text="points",toCounter=7,artist="s"},
	{id=23,inShop="16572c70946",right="16572c71b2d",left="16572c6d4ec",req=200,text="points",toCounter=7,artist="s"},
	{id=24,inShop="16572c6ec36",right="16572c73861",left="16572c6b7e7",req=300,text="points",toCounter=7,artist="s"},
	{id=34,inShop="167b262343b",right="167b25bdd62",left="167b25bc4ec",req=500,text="points",toCounter=7,artist="k"},
	{id=35,inShop="167b2620d9b",right="167b25b6bf8",left="167b25b50bf",req=800,text="points",toCounter=7,artist="k"},
	{id=36,inShop="167b2624ba6",xs=45,ys=51,right="167b25b9b95",left="167b25b860c",req=1000,text="points",toCounter=7,xp=-6,yp=-11,x=-27,y=-24,xl=-17.5,yl=-17.5,artist="k"},
	{id=61,inShop="16bd870119b",xs=35,ys=40,right="16bd86ff443",left="16bd86fd353",x=-18,y=-16,xl=-16,yl=-18,req=1300,text="points",toCounter=7,artist="u"},
	{id=62,inShop="16bd86caffa",xs=37,ys=42,right="16bd86c8ec5",left="16bd86c70bf",x=-18,y=-18,xl=-17,yl=-17,req=1600,text="points",toCounter=7,artist="u"},
	{id=63,inShop="16bd8709efb",xs=37,ys=42,right="16bd8706b96",left="16bd8703605",x=-18,y=-18,xl=-18,yl=-18,req=2000,text="points",toCounter=7,artist="u"},
	{id=91,inShop="16bd2c7c092",xs=45,ys=50,right="16bd2c7a041",left="16bd2c74ba1",x=-22,y=-22,xl=-20,yl=-22,req=2300,xp=-5,yp=-8,text="points",toCounter=7,artist="u"},
	{id=92,inShop="16bd2ca7035",xs=50,ys=55,right="16bd2ca4f5a",left="16bd2ca2f52",x=-35,y=-24,xl=-14,yl=-24,req=3600,xp=-8,yp=-16,text="points",toCounter=7,artist="u"},
	{id=93,inShop="16bd2ca0f3b",xs=43,ys=48,right="16bd2c9e797",left="16bd2c9b628",x=-27,y=-19,xl=-16,yl=-20,req=4000,xp=-5,yp=-11,text="points",toCounter=7,artist="u"},
	
	--{id=31,inShop="16601bb763f",right="16601bb5e85",left="16601bb41d3",req=50,role="a",text="winrole",toFormat="role",toCounter="wa",artist="s"},
	--{id=32,inShop="16601bbbf04",right="16601bba5be",left="16601bb92ed",req=50,role="p",text="winrole",toFormat="role",toCounter="wp",artist="s"},
	--{id=33,inShop="16601bc04e8",right="16601bbea5e",left="16601bbd7e6",req=50,role="he",text="winrole",toFormat="role",toCounter="whe",artist="s"},

	{id=42,inShop="1683915aa1f",right="16839158cd7",left="16839156f9d",req=50,role="a",text="winrole",toCounter="wa",toFormat="role",artist="m"},
	{id=41,inShop="168391601f6",right="1683915e4a3",left="1683915c765",req=50,role="p",text="winrole",toCounter="wp",toFormat="role",artist="m"},
	{id=40,inShop="16839165afb",right="16839163c7f",left="16839161f2f",req=50,role="he",text="winrole",toCounter="whe",toFormat="role",artist="m"},
	{id=64,inShop="16b2743f0b4",right="16b2743d389",left="16b2743b67a",req=100,role="a",text="winrole",toCounter="wa",toFormat="role",artist="m"},
	{id=65,inShop="16bd2c43298",xs=36,ys=41,right="16bd2c413fc",left="16bd2c3f4ba",x=-18,y=-18,xl=-19,yl=-16,req=100,role="p",text="winrole",toCounter="wp",toFormat="role",artist="u"},
	{id=66,inShop="16bd2c94af5",xs=63,ys=44,right="16bd2c92cea",left="16bd2c90551",x=-21,y=-31,xl=-18,yl=-31,req=100,xp=-15,yp=-3,role="he",text="winrole",toCounter="whe",toFormat="role",artist="u"},

	{id=71,inShop="16bd8cf79e5",xs=50,ys=60,right="16bd8cf5591",left="16bd8cf3473",x=-29,y=-27,xl=-17,yl=-26,req=50,xp=-10,yp=-14,role="w",text="winrole",toCounter="ww",toFormat="role",artist="u"},
	{id=72,inShop="16bd86a9e56",xs=39,ys=45,right="16bd86a80f0",left="16bd86a63ad",x=-19,y=-19,xl=-19,yl=-17,req=50,xp=-2,yp=-2,role="c",text="winrole",toCounter="wc",toFormat="role",artist="u"},
	{id=70,inShop="16bd86c34fd",xs=41,ys=46,right="16bd86c1684",left="16bd86bf452",x=-20,y=-18,xl=-22,yl=-19,req=50,xp=-3,yp=-3,role="i",text="winrole",toCounter="wi",toFormat="role",artist="u"}, 
    {id=80,inShop="16b2744a239",right="16b274484fb",left="16b274467a8",x=-17,y=-16,xl=-16,yl=-17,req=50,role="w",text="winrole",toCounter="ww",toFormat="role",artist="m"},
	{id=81,xs=42,ys=45,inShop="16b274341ff",right="16b274324e8",left="16b27430798",x=-24,y=-20,xl=-22,yl=-18,req=50,xp=-5,yp=-8,role="c",text="winrole",toCounter="wc",toFormat="role",artist="m"},
	{id=79,xs=37,ys=35,inShop="16b2742ea86",right="16b2742cd5c",left="16b2742b04e",x=-16,y=-18,xl=-17,yl=-17,req=50,role="i",text="winrole",toCounter="wi",toFormat="role",artist="m"},
	
	{id=37,inShop="16837e9efa0",right="16837dde712",left="16837ddc86d",req=20,text="winMouse",toCounter="wm",artist="k"},
	{id=38,inShop="16837ea0cd4",right="16837de2181",left="16837de044f",req=50,text="winMouse",toCounter="wm",artist="k"},
	{id=39,inShop="16837ea4763",right="16837de9a45",left="16837de7d16",req=80,text="winMouse",toCounter="wm",artist="k"},
	{id=13,inShop="173d9ce5a46",xs=95,ys=90,right="1647a0da582",left="1647a4e5ae4",req=100,text="winMouse",toCounter="wm",x=-49,y=-16,xl=-17.5,yl=-17.5,xp=-40,yp=-32,artist="l"},
	{id=14,inShop="173d9ce71fa",xs=95,ys=90,right="16479fe7efe",left="1647a4e828c",req=130,text="winMouse",toCounter="wm",x=-49,y=-16,xl=-17.5,yl=-17.5,xp=-40,yp=-32,artist="l"},
	{id=15,inShop="173d518fd4d",xs=95,ys=90,right="1647a0a3730",left="1647a4ba3c1",req=160,text="winMouse",toCounter="wm",x=-49,y=-16,xl=-17.5,yl=-17.5,xp=-40,yp=-32,artist="l"},
	{id=82,inShop="16b2745a89e",right="16b27458b4f",left="16b27456e36",req=200,text="winMouse",toCounter="wm",artist="m"},
	{id=83,inShop="16b2744f9cb",right="16b2744dcb3",left="16b2744bfa7",req=250,text="winMouse",toCounter="wm",artist="m"},
	{id=84,inShop="16b27439960",right="16b27437c4f",left="16b27435f40",req=300,text="winMouse",toCounter="wm",artist="m"},
	

	{id=44,inShop="173d9cfd01a",xs=50,ys=60,right="16881d0a6e6",left="16881d06c62",req=15,text="avd",toCounter=36,x=-32,y=-23,xl=-35,yl=-23,xp=-10,yp=-15,artist="k"},
	{id=45,inShop="173d9cff27f",xs=50,ys=60,right="16881d10823",left="16881d0cdf9",req=30,text="avd",toCounter=36,x=-32,y=-23,xl=-35,yl=-23,xp=-10,yp=-15,artist="k"},
	{id=43,inShop="173d9d012f7",xs=50,ys=60,right="1687567eceb",left="16875684563",req=45,text="avd",toCounter=36,x=-30,y=-28,xl=-33,yl=-31,xp=-10,yp=-15,artist="k"},
	
	{id=52,inShop="16a21923e92",right="16a219220d4",left="16a2191fb49",req=30,text="inf",toCounter=39,artist="u"},
	{id=53,inShop="16a2192977d",xs=50,ys=55,right="16a219279a7",left="16a21925c3e",req=60,text="inf",toCounter=39,x=-34,y=-18,xl=-17,yl=-19,xp=-10,yp=-10,artist="u"},
	{id=54,inShop="16a2193a0d6",xs=50,ys=55,right="16a2193836b",left="16a219365f6",req=100,text="inf",toCounter=39,x=-21,y=-26,xl=-29,yl=-28,xp=-15,yp=-8,artist="u"},
	


	--[[Christmas cannons
	--{id=73,inShop="16bd2c5f3fd",xs=42,ys=47,right="16bd2c5a3a0",left="16bd2c5809b",x=-19,y=-21,xl=-22,yl=-17,req=600,text="win",toCounter=6,artist="u"},
	--{id=74,inShop="16bd2c82bde",xs=38,ys=42,right="16bd2c80b22",left="16bd2c7ea9d",x=-17,y=-18,xl=-17,yl=-17,req=800,text="win",toCounter=6,artist="u"},
	--{id=75,inShop="16bd2c35ba9",xs=46,ys=52,right="16bd2c321f6",left="16bd2c3004a",x=-24,y=-25,xl=-18,yl=-24,req=1000,xp=-4,yp=-10,text="win",toCounter=6,artist="u"},]]
}

--[[cannons={
{id=1,inShop="163e2f4401c",text="def"},
{id=2,inShop="163e2f2388f",right="163e2ef025c",left="1647a500d1b",text="help"},
{id=3,inShop="163e2f281b0",right="163e2ef7cfb",left="16489307635",text="map"},

{id=4,inShop="1740c941292",right="1740c93d944",left="1740c93bb35",req=1,text="global",x=-18,y=-37,xl=-18,yl=-37,xs=78,ys=35},
{id=5,inShop="1740c91df77",right="1740c91c21f",left="1740c91a4b9",req=2,text="global",x=-18,y=-37,xl=-18,yl=-37,xs=78,ys=35},
{id=6,inShop="1740c90d6c2",right="1740c90b968",left="1740c909aa0",req=3,text="global",x=-18,y=-37,xl=-18,yl=-37,xs=78,ys=35},

{id=9,inShop="1740c92e883",right="1740c92cb12",left="1740c92ad91",req=300,text="win",toCount=3}, --Volley

{id=11,inShop="1740c952596",right="1740c950831",left="1740c94eaa3",req=100,text="kill",toCount=6}, --Gem
{id=12,inShop="1740c907d20",right="1740c905f11",left="1740c90414a",req=80,text="winMouse",toCount=4}, --Gold

{id=14,inShop="1740c918754",right="1740c9169d1",left="1740c914c50",req=200,text="winMouse",toCount=4,x=-25,y=-18,xl=-16,yl=-18,xs=42,ys=42}, --Spring
{id=15,inShop="1740c9340f4",right="1740c932377",left="1740c9305ee",req=50,text="winSniper",toCount=5,x=-23,y=-17,xl=-17,yl=-17,xs=36,ys=41}, --Ice

{id=16,inShop="1740c947500",right="1740c9455be",left="1740c943023",req=100,text="winSniper",toCount=5,x=-16,y=-21,xl=-16,yl=-22,xs=39,ys=41}, --Wood
{id=17,inShop="1740c94cd1e",right="1740c94afb4",left="1740c949253",req=200,text="winSniper",toCount=5,x=-18,y=-18,xl=-18,yl=-18,xs=40,ys=35}, --Big Mommy
{id=18,inShop="1740c9340f4",right="1740c932377",left="1740c9305ee",req=399,text="winSniper",toCount=5,x=-23,y=-17,xl=-17,yl=-17,xs=36,ys=41}, --Ice

}]]

--IDS: [1001:1012]
randomCannons={}

cnnsIds={}
for i,v in pairs(cannons) do
	table.insert(cnnsIds,v.id)
end

shields={
    {id=1,shop="16838c46f61",text="def"},
    {id=2,shop="16838b1fcc1",right="16838065e00",left="1683806405a",text="help",xr=-37,xl=-10,y=-37},
    {id=3,shop="16838b3696f",right="16838c48f55",left="16838c4a985",text="map",xr=-37,xl=-10,y=-37},
    {id=4,shop="16838c271d8",right="16838091ab9",left="168380938af",text="global",req=1,xr=-37,xl=-10,y=-37},
    {id=5,shop="16838b3af8e",right="1683808df4a",left="1683808fd22",text="global",req=2,xr=-37,xl=-10,y=-37},
    {id=6,shop="16838b38db9",right="1683808a3ae",left="1683808c166",text="global",req=3,xr=-37,xl=-10,y=-37},
    {id=7,shop="16838b27ec5",right="168380731ed",left="16838074f9f",text="points",req=50,toCounter=7,xr=-10,xl=-15,y=-37,artist="m"},
    {id=8,shop="16838b25c07",right="1683806f68d",left="16838071421",text="points",req=150,toCounter=7,xr=-8,xl=-22,y=-37,artist="m"},
    {id=9,shop="16838b2b70d",right="168380795f6",left="168380776b3",text="points",req=300,toCounter=7,xr=-10,xl=-18,y=-37,artist="m"},
    {id=10,shop="16838c45609",right="1683809ebab",left="1683809cde6",text="win",req=25,toCounter=6,xr=-17,xl=-13,y=-37,artist="m"},
    {id=11,shop="16838c2ae0d",right="16838097628",left="1683809566b",text="win",req=50,toCounter=6,xr=-15,xl=-15,y=-37,artist="m"},
    {id=12,shop="16838c4234f",right="1683809b00c",left="16838099225",text="win",req=100,toCounter=6,xr=-17,xl=-17,y=-37,artist="m"},
    {id=13,shop="16838b342d3",right="168380867e3",left="168380885bf",text="win",req=150,toCounter=6,xr=-15,xl=-15,y=-37,artist="m"},
    {id=14,shop="16838b321d6",right="16838082a97",left="16838084a18",text="win",req=200,toCounter=6,xr=-15,xl=-15,y=-37,artist="m"},
    {id=15,shop="16838b2faea",right="16838080cd9",left="1683807ef0d",text="win",req=250,toCounter=6,xr=-15,xl=-15,y=-37,artist="m"},
    {id=16,shop="16838b239cd",right="1683806b6d8",left="1683806d488",role="he",text="winrole",toFormat="role",req=25,toCounter="whe",xr=-15,xl=-15,y=-37,artist="m"},
    {id=17,shop="16838b219eb",right="16838ef46ca",left="16838ef5e07",role="a",text="winrole",toFormat="role",req=25,toCounter="wa",xr=-37,xl=-10,y=-37,artist="m"},
    {id=18,shop="16838b1a03d",right="16838ef14ee",left="16838ef2c3c",role="p",text="winrole",toFormat="role",req=30,toCounter="wp",xr=-37,xl=-10,y=-37,artist="m"},
    {id=19,shop="169a1bc6869",right="169a1bae31e",left="169a1bac5a5",role="w",text="winrole",toFormat="role",req=20,toCounter="ww",xr=-5,xl=-20,y=-40,artist="m"},
    {id=20,shop="169a1bc8605",right="169a1bb1e1e",left="169a1bb00a3",role="c",text="winrole",toFormat="role",req=20,toCounter="wc",xr=-5,xl=-20,y=-40,artist="m"},
    {id=21,shop="169a1bc4add",right="169a1ba4f6b",left="169a1ba31e8",role="b",text="winrole",toFormat="role",req=20,toCounter="wb",xr=-5,xl=-20,y=-40,artist="m"},
}
--[[ End of file tables/shopTables.lua ]]--
--[[ End of directory tables ]]--
--[[ Directory translations ]]--
--[[ File translations/ar.lua ]]--
--You don't have to translate the story={ } part!

translations.ar={
	donate="اكتب <b>!donate</b> إذا أردت التبرع لهذا النمط!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Welcome to <font color='#2b4e95'><b>#MyHero</b></font>, in this game your aim is to help your team to fight the opponent team, choose your team, and your role and FIGHT!\n You can charge up your attack by holding <font color='#2b4e95'><b>Space Bar</b></font> and release it to shoot.\n You can change your attack's direction by using the buttons <font color='#2b4e95'><b>C and V</b></font>.\n\n You can submit your maps for the module in our <u><a href='event:link_maps'>Forums Thread</a></u>.\n You can join our <u><a href='event:link_discord'>Discord Server</a></u> to report bugs and give suggestions.",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Commands</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t You can open your profile by using the button <font color='#2b4e95'><b>P</b></font> or typing <font color='#2b4e95'><b>!profile [<V>Nickname#Tag</V>]</b></font>\n\n You can open the shop where you can buy Elixirs and Cannons by using the button <font color='#2b4e95'><b>O</b></font> or typing <font color='#2b4e95'><b>!shop</b></font>\n\n You can open the leaderboard by usnig the button <font color='#2b4e95'><b>L</b></font> or typing <font color='#2b4e95'><b>!leaderboard</b></font>\n\n You can open the help menu by usnig the button <font color='#2b4e95'><b>H</b></font> or typing <font color='#2b4e95'><b>!help</b></font>\n\n You can change the module's language by typing <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Credits</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> was created by <font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Developer) and <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Artist)\n\nIt was translated into English by <font color='#42bfe8'>Bodykudo</font><font size='10'>#0000</font>",
			[2]="\n\n<font size='12' color='#040028' face='Lucida console'><p align='center'>All those people helped somehow to develop this module\nSome codes, ideas, etc:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Helped with codes).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Helped with arts).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Donations</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> Staff love Open Source! You can view and modify the source code on <u><a href='event:link_code'>GitHub</a></u>.\nMaintaning the module is voluntary, so any help regarding code, bug, reports, suggestions and creating maps is always <u>welcome and appreciated</u>.\n\nYou can submit your maps for the module in our <u><a href='event:link_maps'>Forums Thread</a></u>.\nYou can join our <u><a href='event:link_discord'>Discord Server</a></u> to report bugs and give suggestions.",
			[2]="\n\n\t <font face='Lucida console'><font size='12' color='#040028'>Maintaning <b>MyHero</b> isn't expensive, but it isn't free either.\n\n<p align='center'>We'd love if you could help us by <font color='#2b4e95'><b>donating any amount</b></font> <u><b><a href='event:link_donate'>HERE</a></b></u>\n\n<u>All donations will go towards improving the module.</u></p>",
		},
		new={
			[1]="<font face='Lucida console'><p align='center'><font size='16' color='#2b4e95'><b>#MyHero Version 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Welcome to the all new all different <font color='#2b4e95'><b>#MyHero</b></font>, the module has been remade in a new look!\n\nWhat's new?\n  • The module's UI has been updated.\n  • Kits System has been implented.\n  • Halloween event is back.\n  • New special halloween cannons have been added.\n  • New game mode is introduced: Retro Maps.",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"أيها الأبطال، أنتم ستغيرون العالم!",
				"أيها الأبطال، أنتم أقوى بكثير مما تعتقدون, ثقوا بي.",
				"يوجد بطل خارق بداخل كلٍ منا، نحن فقط بحاجة إلى الشجاعة لارتداء العباءة.",
			},
			bat={
				"أيها الأبطال، تذكروا العدالة لا الانتقام!",
				"البطل يمكن أن يكون أي شخص.",
				"الأبطال ليس لديهم حدود.",
				"الليل يكون أحلك ما يمكن قبل الفجر. وأنا أعدكم، الفجر قادم!",
				"أنا باتمان!",
			},
			wonder={
				"أيها الأبطال، لديكم قوى أعظم مما تتوقعونها!",
				"لو لن ينقذ أحد آخر العالم، إذًا يجب على الأبطال ذلك.",
				"يمكنني إنقاذ اليوم، لكن الأبطال يمكنهم إنقاذ العالم",
			},
		},
		v={
			joker={
				"هاهاهاهاهاها!",
				"أنا دائمًا أبتسم.",
				"الأشرار ليسوا وحوشًا، ولكنهم مختلفون.",
				"أنا أثق، بأن ما لا يقتلك، ببساطة يجعلك أقوى.",
			},
			dark={
				"الأشرار سينالون الفوز!",
			},
		}
	},
	soon="قريبًا!",
	Elixir="لا يمكنك شراء أكثر من 20 من هذا الإكسير!",
	kits={
		[41]="سرعة مضاعفة: هذا الإكسير سيجعلك أسرع من البرق!",
		[42]="مفرقعات: هذا الإكسير سيجعلك قادرًا على صنع مفرقعات مقدسة.",
		[43]="قفزة عالية: هذه الإكسير سيجعلك قادرًا على القفز مثل القرد.",
		[44]="قنابل: هذا الإكسير قد يجعل قذائفك متفجرة عندما تلمس خصمًا ما.",
	},
	team="فريقك",
	role="تخصصك",
	settings={
		"إظهار أيقونات تخصصات اللاعبين",
		"إظهار قائمة الأكاسير تلقائيًا بعد الخسارة/الفوز.",
		"اللغة",
		"تغيير الفريق",
		"تغيير التخصص",
	},
	damageB="الضرر",
    eve="الأحداث",
    info="المعلومات",
    sett="الإعدادات",
	auto="<J>تحذير: سيتم إطلاق كرات عشوائية في كلا الجانبين</J>",
	events={
		"<font color='#f5602a'>الهالوين</font>",
		"<font color='#61B6BD'>الملائكة</font> <V>ضد</V> <font color='#AD2428'>الشياطين</font>",
		"<font color='#E429F2'>الأحجار اللانهائية</font>"
	},
	story={
		"\t<V>Everything is quiet here in the heaven, The Angels live their normal lives with no troubles,</V>\n\t<font color='#AD2428'>OMG, The Demons have just attacked the heaven!</font>\n\t\"<J>You Angels, Never Give up, do your best to fight the demons!!</J>\" --<font color='#61B6BD'>Said The God Mouse</font>",
		"\t<V>What a great war between the Angels and the Demons. Both of the Heaven and the Hell got destroyed!!</V>\n\t\"<R>Grr, Grr, You noob demons, can't you defeat some angels? Grrr</R>\" --<font color='#AD2428'>Said The Demon Cat</font>\n\t<font color='#61B6BD'>It has started, the biggest war, The God Mouse just entered and started to attack the Demons, but, The Demon Cat won't allow that...</font>",
		"\t<V>Both of <font color='#61B6BD'>The God Mouse</font> and <font color='#AD2428'>The Demon Cat</font> died in the great battle...</V>\n\t<font color='#AD2428'>Before dying, The Demon Cat used his last power to break the wall between the Heaven and the Hell, The Demons broke into the heaven!</font>\n\t<V>The Angels are losing the battle,</V>\t\n\"<J>NEVER GIVE UP, I'LL GIVE YOU ALL MY POWER, BUT NEVER GIVE UP!</J>\" --<font color='#61B6BD'>Shouted The God Mouse Before his Death</font>",
		"\t<font color='#61B6BD'>With The God Mouse's last power, the angels could protect their heaven, they could break into the hell, inside the Demons Volcano</font>\n\t<V>And here is a great explosion, the volcano was destroyed, The Demons are losing this battle</V>\n\t<font color='#AD2428'>But, Demons aren't going to lose easily, The Demons are strong, they could preotect themselves in this great war...</font>",
		"\t<V>The Demons Volcano was destroyed, The Heaven was destroyed too,\n\tThe last survivor Angels, and The last survivor Demons are fighting each other in their last battle,</V>\n\t<J>Who won? Who lost? That's an eternal mystery, eternal adventure.</J>"
	},
	cannons="الكرات",
	shields="الدروع",
	discord="لا تنسى الانضمام إلى مخدمنا الرسمي على ديسكورد:",
    disco="ارقص!! أبواب الديسكو مفتوحة! تعالى، اتبع لونك المحدد، وأرنا حركاتك في الرقص!",
	submit="يمكنك عرض خرائطك هنا:",
	leaderRoom="الغرفة",
	leaderGlobal="العالمية",
	name="الاسم",
	winsB="الفوز",
	commu="المجتمع",
	rolesHelp={
		i="الحكيم يمكنه أن يرمي الأعداء بعيدًا بعمل عاصفة، بالضغط على زر E",
		c="عالم النباتات يمكنه أن يوقف أحد الخصوم العشوائيين عن الهجوم بالضغط على زر E، يدوم التأثير لمدة 10 ثوانٍ",
		w="الساحر يمكنه أن يضع أحد الخصوم العشوائيين في قفص بالضغط على زر E، يدوم لمدة 10 ثوانٍ",
		a="هجوم المقاتل أقوى وأسرع من البقية، وكذلك يمكنه أن يحدث ضررًا أكثر.",
		p="صحة فريق المدافع تنقص بمقدار أقل عندما يتم الهجوم عليه، ويُمكنه أيضًا أن يدع درعًا بالضغط على زر E",
		he="المعالج يمكنه أن يزيد من صحة فريقه بمقدار 15% وكذلك إيقاف جميع الخصوم عن الهجوم بالضغط على زر E"
	},
	welcome="<VP>مرحبًا في <b><J>#MyHero</J></b>, انضم لأحد <b><J>الفريقين</J></b> ثم اختر <b><J>تخصصك</J></b>, ثم <b><J>قاتل</J></b>, اكتب <b><J>!help</J></b> أو اضغط زر <b><J>H</J></b> للحصول على مزيد من المعلومات حول هذه اللعبة الصغيرة.",
	helped="<BL>All those people helped somehow to develop this module\nSome codes, Ideas, Translations, Testing the module, etc.\n",
	lgs="اللغات المتاحة هي",
	help={
		"<p align='center'><font size='30' face='Soopafresh'><J>#MyHero</J></font>\n\n<p align='left'><font size='12'>Welcome to <b><J>#MyHero</J></b>, in this game your aim is to fight the opposite team, you have to <b><J>hold clicking</J></b> at <b><J>Space Button</J></b> to charge up your <b><J>attack</J></b> and <b><J>release</J></b> it to <b><J>attack</J></b>, use the buttons <b><J>C</J></b>,<b><J>V</J></b> to <b><J>change your attack's angle</J></b>, if the cannon hits you, your team will lose <b><J>HP</J></b>, if your team's HP is <b><J>0%</J></b>, all the team's members will die, and the opposite team will win",
		"<p align='center'><font size='30' face='Soopafresh'><J>Commands</J></font>\n\n<p align='left'><font size='12'>\n<b><J>!help</J></b> or <b><J>K</J></b> - Displays info about the game.\n<b><J>!shop</J></b> or <b><J>O</J></b> - Displays the shop.\n<b><J>!profile </J></b>[<b>Name#0000</b>] or <b><J>P</J></b>  - Displays your or someone's profile.\n<b><J>!leaderboard</J></b> or <b><J>L</J></b> - Displays the room/global ranking.",
		"<p align='center'><font size='30' face='Soopafresh'><J>Commands</J></font>\n<p align='left'><font size='12'>\n<b><J>!X</J></b> - Changes your attack's angle <font size='10'>-30 : 30</font>\n<b><J>!off</J></b> [x] [y] - Changes your x,y offset.\n<b><J>!team members</J></b> - Displays your team's members\n<b><J>!team change</J></b> - Changes your team.\n<b><J>!c</J></b> [Message] - Sends a message to your team's members\n<b><J>!icons</J></b> - Displays/Hides the players' icons.\n<b><J>!lang</J></b> [<BV><a href='event:lgs'>xx</a></BV>] - Changes the current language.",
		"<p align='center'><font size='30' face='Soopafresh'><J>Credits</J></font>\n<p align='left'><font size='12'>\nThis game was made by <BV><b>Bodykudo</b></BV><V><font size='10'>#0000</font></V> <font size='10'>(Developer)</font> and <BV><b>Liiliiith</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Sonicyss</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Kariina</b></BV><V><font size='10'>#2631</font></V>, <BV><b>Mouny</b></BV><V><font size='10'>#6831</font></V>, <BV><b>Smutny_nalesnik</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Lunartear</b></BV><V><font size='10'>#6947</font></V> <font size='10'>(Artist)</font>\n<p align='center'>All those people helped somehow to develop this module\nSome codes, Ideas, Translations, Testing the module, etc.\n<BV><b>Bolodefchoco</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Heniyengui</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Turkitutu</b></BV><V><font size='10'>#0000</font></V>, <BV><b>Unlocker001</b></BV><V><font size='10'>#0000</font></V>\nType <b><J>!credits</J></b> to see the whole credits menu."
	},
	changed="<VP>مكان إطلاق كراتك قد تغير إلى (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
	toSave="يجب أن يتواجد على الأقل 3 أبطال و3 أشرار لحفظ البيانات.",
	wins={
		"عدد مرات الفوز",
		"عدد مرات الفوز كمقاتل",
		"عدد مرات الفوز كمدافع",
		"عدد مرات الفوز كمعالج",
		"عدد مرات الفوز كساحر",
		"عدد مرات الفوز كعالم نباتات",
		"عدد مرات الفوز كحكيم",
		"عدد مرات الفوز في طور الفأر المجنون",
		"عدد مرات الفوز في الطور الكلاسيكي"
	},
	damage="الضرر الكلي",
	wrong="يجب أن تختار فريقًا لتتمكن من استخدام هذه الميزة",
	enough="ليس لديك مالًا كافيًا :(",
	tm="أعضاء فريقك هم",
	disabled="غير متاحة",
    eq="ارتداء",
    eqd="مرتدى",
	use="استخدام",
	buy="شراء",
	close="إغلاق",
	next="التالي",
	pre="السابق",
	quests={
		inf="اجمع <FC>%s</FC> أحجار لا نهائية.",
		avd="اجمع <FC>%s</FC> نقطة في حدث الملائكة ضد الشياطين.",
		halloween="اجمع <FC>%s</FC> نقطة في حدث الهالوين",
		global="لتصبح رقم #<FC>%s</FC> في قائمة الصدارة العالمية",
		winMouse="اكسب <FC>%s</FC> جولة في طور الفأر المجنون",
		def="ابدأ لعب <FC>#MyHero</F>.",
		help="ساعد لتطوير هذه اللعبة الصغيرة\nساعد بالأكواد - الترجمة - الرسومات .. إلخ ..",
		map="اصنع خريطة واحدة ل <FC>#MyHero</FC>.",
		win="اكسب <FC>%s</FC> جولة.",
		winRetro="اكسب <FC>%s</FC> جولة في الطور الكلاسيكي.",
		winrole="اكسب <FC>%s</FC> جولة بينما أنت <FC>%s</FC>.",
		points="أحدث <FC>%s</FC> ضررًا كليًا على الفريق الخصم."
	},
	h="بطل",
	v="شرير",
	roles={
		i="حكيم",
		c="عالم نباتات",
		w="ساحر",
		he="معالج",
		a="مقاتل",
		p="مدافع"
	},
	yes="Yes",
	no="No",
	full="هذا الفريق ممتلئ بالأعضاء",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>؟ %s هل أنت متاكد من أنك تريد تغيير\n\n<font color='#FFCD46'>هذا سيكلفك %s $\n\nأنت تملك حاليًا %s $"
}
--[[ End of file translations/ar.lua ]]--
--[[ File translations/br.lua ]]--
--You don't have to translate the story={ } part!

translations.br={
	donate="Digite <b>!donate</b> se deseja doar para o criador do module!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Bem-vindo(a) ao <font color='#2b4e95'><b>#MyHero</b></font>, o objetivo desse jogo é ajudar seu time a lutar contra o time inimigo, escolha seu time, seu cargo e LUTE!\n Você pode carregar seu ataque segurando a <font color='#2b4e95'><b>Barra de Espaço</b></font> e soltar para atirar.\n Você pode alterar a direção do ataque utilizando as teclas <font color='#2b4e95'><b>C e V</b></font>.\n\n Você pode submeter seu mapa para o módule no nosso <u><a href='event:link_maps'>tópico no fórum</a></u>.\n Você pode se juntar a nosso <u><a href='event:link_discord'>Servidor no discord</a></u> para reportar bugs e dar sugestões.",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Comandos</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Você pode abrir o seu perfil utilizando a tecla: <font color='#2b4e95'><b>P</b></font> ou digitando <font color='#2b4e95'><b>!profile [<V>Nickname#Tag</V>]</b></font>\n\n Você pode abrir a loja onde você pode comprar Elixir e Canhões usando a tecla: <font color='#2b4e95'><b>O</b></font> ou digitando <font color='#2b4e95'><b>!shop</b></font>\n\n Você pode abrir o leaderboard usando a tecla: <font color='#2b4e95'><b>L</b></font> ou digitando <font color='#2b4e95'><b>!leaderboard</b></font>\n\n Você pode abrir o menu de ajuda utilizando a tecla: <font color='#2b4e95'><b>H</b></font> ou digitando <font color='#2b4e95'><b>!help</b></font>\n\n Você pode alterar o idioma do module digitando: <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Créditos</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> foi criado por <font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Developer) e <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Artist)\n\nTraduzido para o Português por <font color='#42bfe8'>Austinbacky</font><font size='10'>#0010</font>",
			[2]="\n\n<font size='12' color='#040028' face='Lucida console'><p align='center'>Toda essa gente ajudou de alguma forma a desenvolver esse módule\nAlguns códigos, ideias, etc:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Ajudaram com os códigos).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Ajudaram com a arte).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Doações</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> Staff love Open Source! Você pode ver e modificar o código no <u><a href='event:link_code'>GitHub</a></u>.\nA manutenção desse módule é voluntária, qualquer ajuda com o código, bugs, reportes, sugestões e criação de mapas é sempre <u>bem-vinda</u>.\n\nVocê pode submeter seus mapas para o módule no nosso <u><a href='event:link_maps'>tópico no fórum</a></u>.\nVocê pode se juntar ao nosso <u><a href='event:link_discord'>servidor no discord</a></u> para reportar bugs e dar sugestões.",
			[2]="\n\n\t <font face='Lucida console'><font size='12' color='#040028'>Manter o <b>MyHero</b> não é caro, mas também não é grátis.\n\n<p align='center'>Adorariamos se você nos ajudasse <font color='#2b4e95'><b>doando qualquer quantia</b></font> <u><b><a href='event:link_donate'>HERE</a></b></u>\n\n<u>Toda doação será destinada a manutenção do módule.</u></p>",
		},
		new={
			[1]="<font face='Lucida console'><p align='center'><font size='18' color='#2b4e95'><b>#MyHero Version 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Bem-vindo(a) para o novo <font color='#2b4e95'><b>#MyHero</b></font>, o módule recebeu um novo look!\n\nO que mudou?\n  • A interface do módule foi atualizada.\n  • Sistema de kits foi implementado.\n  • O evento de Halloween está de volta.\n  • Novos canhões de Halloween foram adicionados.\n  • Novo modo de jogo: Retro Maps.",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"Heróis, vocês vão mudar o mundo!",
				"Heróis, vocês são muito mais fortes do que pensam que são, acredite.",
				"Há um super-herói em todos nós, só precisamos de coragem para colocar a capa.",
			},
			bat={
				"Heróis, lembrem-se, justiça, não vingança!",
				"Qualquer um pode ser um herói.",
				"Heróis não tem limites.",
				"A noite é mais escura antes de amanhecer, e eu te prometo, o amanhecer está chegando!",
				"Eu sou o BATMAN!",
			},
			wonder={
				"Heróis, vocês tem um poder maior do que imagina!",
				"Se ninguém vai defender o mundo, os heróis irão.",
				"Eu posso salvar hoje, mas os heróis salvarão o mundo.",
			},
		},
		v={
			joker={
				"Hahahahahaha!",
				"Estou sempre sorrindo.",
				"Vilões não são monstros, são apenas diferentes.",
				"Acredito que o que não te mata, te deixa mais forte.",
			},
			dark={
				"Os vilões terão a vitória!",
			},
		}
	},
	soon="Em breve!",
	maxEx="Você não pode comprar mais que 20 slots desse Elixir!",
	kits={
		[41]="Dobrar velocidade: Esse Elixir irá fazer você ser mais rápido que o Flash!",
		[42]="Espíritos: Esse Elixir irá permitir que você invoque espíritos sagrados.",
		[43]="Super pulo: Esse Elixir irá te permitir pular bem alto.",
		[44]="BOMBA: Esse Elixir irá fazer com que seus canhões explodam ao tocar em algum opontente.",
	},
	team="Equipe",
	role="Cargo",
	settings={
		"Mostra o ícone dos cargos dos jogadores.",
		"Mostra a lista de Elixir automaticamente após a derrota/vitória.",
		"Idioma",
		"Mudar de time",
		"Mudar o cargo",
	},
	damageB="Dano",
    eve="Eventos",
	info="Informação",
	sett="Configurações",
	auto="<J>AVISO: Canhões serão invocados aleatóriamente em ambos os lados.</J>",
	events={
		"<font color='#f5602a'>Halloween</font>",
		"<font color='#61B6BD'>Anjos</font> <V>vs</V> <font color='#AD2428'>Demônios</font>",
		"<font color='#FF6347'>Ro</font><font color='#12E772'>ch</font><font color='#FF8B00'>as </font><font color='#266EF6'>In</font><font color='#E429F2'>fi</font><font color='#DC143C'>ni</font><font color='#FF0130'>tas</font>"
	},
    story={
        "\t<V>Tudo está quieto aqui no Céu, os anjos vivem suas vidas normais sem problemas... </V>\n\t<font color='#AD2428'>OMG, os demônios acabaram de atacar o céu!</font>\n\t\"<J>Vocês, anjos, nunca desistam, deem o seu melhor para lutarem contra os demônios!!</J>\" --<font color='#61B6BD'>Disse o rato deus</font>",
        "\t<V>Que grande guerra essa entre anjos e demônios. O céu e o Inferno foram destruídos!!</V>\n\t\"<R>Grr, Grr, seus demônios inúteis, não conseguem derrotar alguns anjos? Grrr</R>\" --<font color='#AD2428'>Disse o gato demoníaco</font>\n\t<font color='#61B6BD'>Começou! A grande guerra! O rato deus acaba de entrar e atacar os demônios, mas o gato demoníaco não permitirá isso...</font>",
        "\t<V>Tanto <font color='#61B6BD'>o rato deus</font> quanto <font color='#AD2428'>o gato demoníaco</font> morreram na grande batalha...</V>\n\t<font color='#AD2428'>Antes de morrer, o gato demoníaco usou seu último poder para destruir o muro entre o Céu e o Inferno... Os demônios invadiram o céu!</font>\n\t<V>Os anjos estão perdendo a batalha.</V>\t\n\"<J>NUNCA DESISTAM, DAREI TODO O MEU PODER A VOCÊS, MAS NÃO DESISTAM!</J>\" --<font color='#61B6BD'>Disse o rato deus antes de sua morte</font>",
        "\t<font color='#61B6BD'>Com o último poder do rato deus, os anjos puderam proteger o Céu, também invadiram o Inferno, dentro do vulcão dos demônios.</font>\n\t<V>E assim ouve uma grande explosão, o vulcão fora destruído, os demônios estão perdendo a batalha</V>\n\t<font color='#AD2428'>Mas os demônios não desistirão tão facilmente, eles são fortes, podiam se proteger...</font>",
        "\t<V>O vulcão dos demônios foi destruído, o céu também.\n\tOs últimos anjos e demônios sobreviventes lutam entre si em sua última batalha.</V>\n\t<J>Quem venceu? Quem perdeu? Esse é um mistério eterno, uma aventura eterna.</J>"
    },
    cannons="Canhões",
    shields="Escudos",
    discord="Não se esqueça de entrar em nosso Servidor do Discord oficial:",
    disco="Dance!! As portas da balada estão abertas! Venha, siga sua cor específica, mostre seus movimentos de dança!",
    submit="Você pode enviar mapas aqui:",
    leaderRoom="Sala",
    leaderGlobal="Global",
    name="Nome",
    winsB="Vitórias",
    commu="Comunidade",
	rolesHelp={
		i="O sábio pode lançar os oponentes para longe com uma tempestade, usando a tecla E.",
		c="O botânico pode impedir o ataque de um inimigo aleatório usando a tecla E, isso dura 10 segundos.",
		w="O mago pode colocar um inimigo aleatório em uma cela usando a tecla E, isso dura 10 segundos.",
		a="O ataque do lutador é mais forte e rápido que o dos outros, causando mais dano.",
		p="O protetor do time perde menos HP quando é atacado, ele também pode adicionar um escudo usando a tecla E.",
		he="O curandeiro aumenta o HP de seu time em 15% e impede os inimigos de atacarem usando a tecla E."
	},
	welcome="<VP>Bem-vindo(a) ao <b><J>#MyHero</J></b>, junte-se a um dos <b><J>dois times</J></b>, selecione seu <b><J>cargo</J></b>, e <b><J>LUTE</J></b>, digite <b><J>!help</J></b> ou use a tecla <b><J>H</J></b> para mais informações sobre o minigame.",
    helped="<BL>ATodas essas pessoas ajudaram de alguma forma o desenvolvimento desse módulo\nAlguns códigos, ideias, traduções, testes, etc.\n",
    lgs="Os idiomas disponíveis são:",
    changed="<VP>A posição de tiro de seus canhões foi alterada para (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
    toSave="Devem haver pelo menos 3 heróis e 3 vilões para o salvamento de dados.",
	wins={
        "Vitórias:",
        "Vitórias como Lutador:",
        "Vitórias como Protetor:",
        "Vitórias como Curandeiro:",
        "Vitórias como um Mago:",
		"Vitórias como um Botânico:",
        "Vitórias como um Alquimista:",
		"Vitórias no modo do crazy mouse:",
		"Vitórias no modo retro maps:"
	},
    damage="Danos totais",
    wrong="Você deve escolher uma equipe para poder usar esse poder",
    enough="Você não tem dinheiro o suficiente :(",
    tm="Os membros da sua equipe são:",
    disabled="Desativado",
    eq="Equipar",
    eqd="Equipado",
	use="Utilizar",
	buy="Comprar",
    close="Fechar",
    next="Próxima",
    pre="Anterior",
	icons={
		on="Os ícones irão aparecer na próxima partida.",
		off="Os ícones irão desaparecer na próxima partida."
	},
	quests={
        inf="Colete <FC>%s</FC> pedras do infinito",
        avd="Pontue <FC>%s</FC> no evento Anjos x Demônios",
        auto="Vença <FC>%s</FC> partidas no <a href='event:auto'><BV>#Myhero0Auto</a>",
        halloween="Pontue <FC>%s</FC> no evento de Halloween",
        global="Chegue no top <FC>#%s</FC> no ranking global",
		winMouse="Vença <FC>%s</FC> partidas no modo crazy mouse.",
        def="Comece a jogar em <FC>#MyHero</FC> .",
        help="Ajude a completar esse minigame\nAjude com código - tradução - arte .. etc.",
        map="Crie um mapa para o <FC>#MyHero</FC> .",
        win="Vença <FC>%s</FC> partidas.",
        winrole="Vença <FC>%s</FC>  partidas enquanto você é <FC>%s</FC>.",
        points="Faça um total de danos de <FC>%s</FC> na outra equipe.",
		winRetro="Ganhe <FC>%s</FC> partidas no modo retro maps.",
    },
    h="Herói",
    v="Vilão",
	roles={
        i="Sábio",
		c="Botânico",
        w="Mago",
        he="Curandeiro",
        a="Lutador",
        p="Protetor"
	},
    yes="Sim",
    no="Não",
    full="Essa equipe já está cheia!",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>Tem certeza que quer alterar seu %s?\n\n<font color='#FFCD46'>Isso irá custar %s $ \n\nVocê tem atualmente %s $"
}
--[[ End of file translations/br.lua ]]--
--[[ File translations/en.lua ]]--
--You don't have to translate the story={ } part!

translations.en={
	donate="Type <b>!donate</b> if you would like to donate for this module!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Welcome to <font color='#2b4e95'><b>#MyHero</b></font>, in this game your aim is to help your team to fight the opponent team, choose your team, and your role and FIGHT!\n You can charge up your attack by holding <font color='#2b4e95'><b>Space Bar</b></font> and release it to shoot.\n You can change your attack's direction by using the buttons <font color='#2b4e95'><b>C and V</b></font>.\n\n You can submit your maps for the module in our <u><a href='event:link_maps'>Forums Thread</a></u>.\n You can join our <u><a href='event:link_discord'>Discord Server</a></u> to report bugs and give suggestions.",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Commands</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t You can open your profile by using the button <font color='#2b4e95'><b>P</b></font> or typing <font color='#2b4e95'><b>!profile [<V>Nickname#Tag</V>]</b></font>\n\n You can open the shop where you can buy Elixirs and Cannons by using the button <font color='#2b4e95'><b>O</b></font> or typing <font color='#2b4e95'><b>!shop</b></font>\n\n You can open the leaderboard by using the button <font color='#2b4e95'><b>L</b></font> or typing <font color='#2b4e95'><b>!leaderboard</b></font>\n\n You can open the help menu by using the button <font color='#2b4e95'><b>H</b></font> or typing <font color='#2b4e95'><b>!help</b></font>\n\n You can change the module's language by typing <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Credits</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> was created by <font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Developer) and <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Artist)\n\nIt was translated into English by <font color='#42bfe8'>Bodykudo</font><font size='10'>#0000</font>",
			[2]="\n\n<font size='12' color='#040028' face='Lucida console'><p align='center'>All those people helped somehow to develop this module\nSome codes, ideas, etc:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Helped with codes).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Helped with arts).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Donations</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> Staff love Open Source! You can view and modify the source code on <u><a href='event:link_code'>GitHub</a></u>.\nMaintaning the module is voluntary, so any help regarding code, bug, reports, suggestions and creating maps is always <u>welcome and appreciated</u>.\n\nYou can submit your maps for the module in our <u><a href='event:link_maps'>Forums Thread</a></u>.\nYou can join our <u><a href='event:link_discord'>Discord Server</a></u> to report bugs and give suggestions.",
			[2]="\n\n\t <font face='Lucida console'><font size='12' color='#040028'>Maintaning <b>MyHero</b> isn't expensive, but it isn't free either.\n\n<p align='center'>We'd love if you could help us by <font color='#2b4e95'><b>donating any amount</b></font> <u><b><a href='event:link_donate'>HERE</a></b></u>\n\n<u>All donations will go towards improving the module.</u></p>",
		},
		new={
			[1]="<font face='Lucida console'><p align='center'><font size='16' color='#2b4e95'><b>#MyHero Version 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Welcome to the all new all different <font color='#2b4e95'><b>#MyHero</b></font>, the module has been remade in a new look!\n\nWhat's new?\n  • The module's UI has been updated.\n  • Kits System has been implented.\n  • Halloween event is back.\n  • New special halloween cannons have been added.\n  • New game mode is introduced: Retro Maps.",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"Heroes, you’re going to change the world!",
				"Heroes, you’re much stronger than you think you are, trust me.",
				"There is a superhero in all of us, we just need the courage to put on the cape.",
			},
			bat={
				"Heroes, remember, justice not vengeance!",
				"A hero can be anyone.",
				"Heroes have no limits.",
				"The night is darkest just before the dawn. And I promise you, the dawn is coming!",
				"I'm BATMAN!",
			},
			wonder={
				"Heroes, you have greater powers than you know!",
				"If no one else will defend the world, then heroes must.",
				"I can save today, but heroes can save the world.",
			},
		},
		v={
			joker={
				"Hahahahahaha!",
				"I'm always smiling.",
				"Villains are not monsters, but they are different.",
				"I believe, whatever doesn’t kill you, simply makes you stranger.",
			},
			dark={
				"Villains will have victory!",
			},
		}
	},
	soon="Soon!",
	maxEx="You can't buy more than 20 of this Elixir!",
	kits={
		[41]="Dobule Speed: This Elixir will make you faster than the Flash!",
		[42]="Spirits: This Elixir will make you able to spawn holy spirits.",
		[43]="High Jump: This Elixir will make you able to jump like a monkey.",
		[44]="BOMBS: This Elixir might make your cannons auto bombed when it touch an opponent.",
	},
	team="Team",
	role="Role",
	settings={
		"Show the icons of players' roles.",
		"Show the Elixirs list automatically after losing/winning.",
		"Language",
		"Change Teams",
		"Change Role",
	},
	damageB="Damage",
	eve="Events",
	info="Info",
	sett="Settings",
	auto="<J>WARNING: Random Cannons will be shot in both sides.</J>",
	events={
		"<font color='#f5602a'>Halloween</font>",
		"<font color='#61B6BD'>Angels</font> <V>vs</V> <font color='#AD2428'>Demons</font>",
		"<font color='#266EF6'>In</font><font color='#E429F2'>fi</font><font color='#DC143C'>ni</font><font color='#FF0130'>ty </font><font color='#FF6347'>St</font><font color='#12E772'>on</font><font color='#FF8B00'>es</font>"
	},
	story={
		"\t<V>Everything is quiet here in the heaven, The Angels live their normal lives with no troubles,</V>\n\t<font color='#AD2428'>OMG, The Demons have just attacked the heaven!</font>\n\t\"<J>You Angels, Never Give up, do your best to fight the demons!!</J>\" --<font color='#61B6BD'>Said The God Mouse</font>",
		"\t<V>What a great war between the Angels and the Demons. Both of the Heaven and the Hell got destroyed!!</V>\n\t\"<R>Grr, Grr, You noob demons, can't you defeat some angels? Grrr</R>\" --<font color='#AD2428'>Said The Demon Cat</font>\n\t<font color='#61B6BD'>It has started, the biggest war, The God Mouse just entered and started to attack the Demons, but, The Demon Cat won't allow that...</font>",
		"\t<V>Both of <font color='#61B6BD'>The God Mouse</font> and <font color='#AD2428'>The Demon Cat</font> died in the great battle...</V>\n\t<font color='#AD2428'>Before dying, The Demon Cat used his last power to break the wall between the Heaven and the Hell, The Demons broke into the heaven!</font>\n\t<V>The Angels are losing the battle,</V>\t\n\"<J>NEVER GIVE UP, I'LL GIVE YOU ALL MY POWER, BUT NEVER GIVE UP!</J>\" --<font color='#61B6BD'>Shouted The God Mouse Before his Death</font>",
		"\t<font color='#61B6BD'>With The God Mouse's last power, the angels could protect their heaven, they could break into the hell, inside the Demons Volcano</font>\n\t<V>And here is a great explosion, the volcano was destroyed, The Demons are losing this battle</V>\n\t<font color='#AD2428'>But, Demons aren't going to lose easily, The Demons are strong, they could preotect themselves in this great war...</font>",
		"\t<V>The Demons Volcano was destroyed, The Heaven was destroyed too,\n\tThe last survivor Angels, and The last survivor Demons are fighting each other in their last battle,</V>\n\t<J>Who won? Who lost? That's an eternal mystery, eternal adventure.</J>"
	},
	cannons="Cannons",
	shields="Shields",
	discord="Don't forget to join our official Discord Server:",
	disco="Dance!! The disco's doors are open! Come, follow your specific color, show us your dacing moves!",
	submit="You can submit your maps here:",
	leaderRoom="Room",
	leaderGlobal="Global",
	name="Name",
	winsB="Wins",
	commu="Community",
	rolesHelp={
		i="The Wise can throw the opponents away by setting up a storm, by pressing E button.",
		c="The Botanist can stop random one of the opponents of attacking by pressing E button, it lasts for 10 seconds.",
		w="The Wizard can put random one of the opponents in a cage by pressing E button, it lasts for 10 seconds.",
		a="The Fighter's attack is stronger and faster than the others, also it causes more damage.",
		p="Protector's team's looses less HP when being attacked, and he also can put a shield by pressing E button.",
		he="The Healer can increase his team's HP 15% and stopping all opponents from attacking by pressing E button."
	},
	welcome="<VP>Welcome to <b><J>#MyHero</J></b>, join one of the <b><J>two teams</J></b> and choose your <b><J>role</J></b>, and <b><J>FIGHT</J></b>, type <b><J>!help</J></b> or click at <b><J>H</J></b> to get more information about the minigame.",
	helped="<BL>All those people helped somehow to develop this module\nSome codes, Ideas, Translations, Testing the module, etc.\n",
	lgs="The available languages are",
	changed="<VP>Your cannons' shooting position has been changed to (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
	toSave="There should be at least 3 Heroes and 3 Villains to save the data.",
	wins={
		"Wins",
		"Wins as a Fighter",
		"Wins as a Protector",
		"Wins as a Healer",
		"Wins as a Wizard",
		"Wins as a Botanist",
		"Wins as a Wise",
		"Wins in the crazy Mouse mode",
		"Wins in the Retro mode"
	},
	damage="Total damage",
	wrong="You must choose a team to be able to use this feature.",
	enough="You don't have enough money :(",
	tm="Your team's members are",
	disabled="Disabled",
    eq="Equip",
    eqd="Equipped",
	use="Use",
	buy="Buy",
	close="Close",
	next="Next",
	pre="Previous",
	icons={
		on="Icons will appear in the next round.",
		off="Icons will disappear in the next round."
	},
	quests={
		inf="Collect <FC>%s</FC> Infinity Stones.",
		avd="Score <FC>%s</FC> points in the Angels vs Demons event.",
		halloween="Score <FC>%s</FC> points in the Halloween event.",
		global="Become the <FC>#%s</FC> position in the global leaderboard.",
		winMouse="Win <FC>%s</FC> rounds in the crazy mouse mode.",
		def="Start playing <FC>#MyHero</FC> .",
		help="Help to complete this minigame\nHelp with code - translation - arts .. etc.",
		map="Create one map for <FC>#MyHero</FC> .",
		win="Win <FC>%s</FC> rounds.",
		winRetro="Win <FC>%s</FC> rounds in the Retro maps.",
		winrole="Win <FC>%s</FC> rounds while you're a <FC>%s</FC>.",
		points="Do totally <FC>%s</FC> damage on the other team."
	},
	h="Hero",
	v="Villain",
	roles={
		i="Wise",
		c="Botanist",
		w="Wizard",
		he="Healer",
		a="Fighter",
		p="Protector"
	},
	yes="Yes",
	no="No",
	full="This team is full of players!",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>Are you sure that you want to change your %s?\n\n<font color='#FFCD46'>It will cost you %s $ \n\nYou currently have %s $"
}
--[[ End of file translations/en.lua ]]--
--[[ File translations/es.lua ]]--
--You don't have to translate the story={ } part!

translations.es={
    donate="Escriba <b>!donate</b> ¡Si desea donar para este módulo!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Bienvenido a <font color='#2b4e95'><b>#MyHero</b></font>, en este juego tu objetivo es ayudar a tu equipo a luchar contra el equipo oponente, elije tu equipo, tu rol y ¡LUCHA! \n Puedes cargar tu ataque sosteniendo <font color='#2b4e95'><b>Espacio</b></font> y suéltalo para disparar.\n uedes cambiar la dirección de tu ataque usando los botones <font color='#2b4e95'><b>C and V</b></font>.\n\n Puede enviar sus mapas para el módulo en nuestro our <u><a href='event:link_maps'>Hilo del foro</a></u>.\n Puede unirse al <u><a href='event:link_discord'>Servidor de Discord</a></u> para reportar errores y dar sugerencias..",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Comandos</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Puede abrir su perfil usando el botón <font color='#2b4e95'><b>P</b></font> o escribiendo <font color='#2b4e95'><b>!profile [<V>Nickname#Tag</V>]</b></font>\n\n You Puede abrir la tiendadonde pueda comprar Elixires y Cañones usando el botón <font color='#2b4e95'><b>O</b></font> o escribiendo <font color='#2b4e95'><b>!shop</b></font>\n\n Puede abrir la tabla de clasificación presionando el botón <font color='#2b4e95'><b>L</b></font> o escribiendo <font color='#2b4e95'><b>!leaderboard</b></font>\n\n Puede abrir el menú de ayuda presionando el botón <font color='#2b4e95'><b>H</b></font> o escribiendo <font color='#2b4e95'><b>!help</b></font>\n\n Puede cambiar el idioma del módulo escribiendo  <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Créditos</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> Fue creador por <font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Desarrollador) y <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Artista)\n\nEsto fue traducido al Español por<font color='#42bfe8'>Verdomice</font><font size='10'>#0095</font>",
			[2]="\n\n<font size='12' color='#040028' face='Lucida console'><p align='center'>Todas estás personas ayudaron de alguna manera a desarrollar este módulo \ nCon algunos códigos, ideas, etc:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Helped with codes).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Ayudaron con el arte).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Donar</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> ¡Al Staff del módulo le encanta el código abierto! Puede ver y modificar el código fuente en <u><a href='event:link_code'>GitHub</a></u>.\nEl mantenimiento del módulo es voluntario, por lo que cualquier ayuda con respecto al código, errores, reportes, sugerencias y creación de mapas es siempre <u>bienvenido y apreciado</u>.\n\nPuedes enviar tus mapas para el módulo en nuestro  <u><a href='event:link_maps'>Hilo del foro</a></u>.\nPuedes unirte a nuestro <u><a href='event:link_discord'>Servidor de Discord</a></u> para reportar errores y dar sugerencias.",
			[2]="\n\n\t <font face='Lucida console'><font size='12' color='#040028'>Mantener<b>MyHero</b> no es caro, pero tampoco es gratuito.\n\n<p align='center'>Nos encantaría que nos ayudara <font color='#2b4e95'><b>donando cualquier cantidad que su corazón desee</b></font> <u><b><a href='event:link_donate'>AQUÍ</a></b></u>\n\n<u>Todas las donaciones se destinarán a mejorar el módulo</u></p>",
		},
		new={
            [1]="<font face='Lucida console'><p align='center'><font size='16' color='#2b4e95'><b>#MyHero Version 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t ¡Bienvenido a todo lo nuevo y diferente <font color='#2b4e95'><b>#MyHero</b></font>, el módulo ha sido rehecho con una nueva apariencia!\n\n¿Qué hay de nuevo?\n  • Se actualizó la interfaz de usuario del módulo.\n  • Se ha implementado el sistema de kits.\n  • El evento de Halloween está de vuelta.\n  • Se han agregado nuevos cañones especiales de Halloween..\n  • Se introdujo un nuevo modo de juego: Mapas retro. ",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"¡Héroes, van a cambiar el mundo",
				"Héroes, son mucho más fuertes de lo que creen, créanme.",
				"Hay un superhéroe en todos nosotros, solo necesitamos el coraje para ponernos la capa.",
			},
			bat={
				"¡Héroes, recuerden, justicia no venganza!",
				"Un héroe puede ser cualquiera.",
				"Los héroes no tienen límites.",
				"La noche es más oscura justo antes del amanecer. Y te lo prometo, ¡Se acerca el amanecer!",
				"¡Yo soy BATMAN!",
			},
			wonder={
				"¡Héroes, tienen mayores poderes de los que ustedes creen!",
				"Si nadie más defenderá el mundo, entonces los héroes deben hacerlo.",
				"Puedo salvar hoy, pero los héroes pueden salvar el mundo.",
			},
		},
		v={
			joker={
				"¡Jajajajajaja!",
				"Siempre estoy sonriendo.",
				"Los villanos no son monstruos, pero son diferentes.",
				"Yo creo que todo lo que no te mata, simplemente te vuelve extraño.",
			},
			dark={
				"¡Los villanos tendrán la victoria!",
			},
		}
	},
	soon="¡Pronto!",
	maxEx="¡No puedes comprar más de 20 de este Elixir!",
	kits={
		[41]="Doble velocidad: ¡Este elixir te hará más rápido que Flash!",
		[42]="Espíritus: este elixir te permitirá engendrar espíritus sagrados.",
		[43]="Saltar alto: este elixir te permitirá saltar como un mono.",
		[44]="BOMBAS: Este Elixir puede hacer que tus cañones sean bombardeados automáticamente cuando tocan a un oponente..",
	},
	team="Equipo",
	role="Rol",
	settings={
		"Muestra los iconos de los roles de los jugadores.",
		"Muestra la lista de Elixires automáticamente después de perder/ganar.",
		"Lenguaje",
		"Cambiar equipo",
		"Cambiar rol",
	},
	damageB="Daño",
	eve="Eventos",
	info="Información",
	sett="Ajustes",
	auto="<J>ADVERTENCIA: Se dispararán cañones aleatorios en ambos lados.</J>",
	events={
		"<font color='#f5602a'>Halloween</font>",
		"<font color='#61B6BD'>Ángeles</font> <V>vs</V> <font color='#AD2428'>Demonios</font>",
		"<font color='#266EF6'>In</font><font color='#E429F2'>fi</font><font color='#DC143C'>ni</font><font color='#FF0130'>ty </font><font color='#FF6347'>St</font><font color='#12E772'>on</font><font color='#FF8B00'>es</font>"
	},
	story={
		"\t<V>Todo está tranquilo aquí en el cielo, Los Ángeles viven su vida normal sin problemas</font>\n\t\"<J¡¡Ángeles, nunca se rindan, hagan su mejor esfuerzo para luchar contra los demonios!!</J>\" --<font color='#61B6BD'>Dijo el Dios ratón</font>",
		"\t<V>Qué gran guerra entre los ángeles y los demonios. ¡¡Tanto el Cielo como el Infierno fueron destruidos !!</V>\n\t\"<R>Grr, Grr, Demonios novatos, ¿No pueden derrotar a algunos ángeles?? Grrr</R>\" --<font color='#AD2428'>Dijo la gata demonio</font>\n\t<font color='#61B6BD'>Ha comenzado, la guerra más grande, el Dios ratón acaba de entrar y comenzó a atacar a los Demonios, pero El demonio gato no lo permitirá...</font>",
		"\t<V>Ambos <font color='#61B6BD'>El Dios ratón</font> y <font color='#AD2428'>El gato demonio</font> murieron en esta gran batalla..</V>\n\t<font color='#AD2428'>Antes de morir, el gato demonio usó su último poder para romper el muro entre el cielo y el infierno, ¡Los demonios irrumpieron en el cielo! </font>\n\t<V>Los ángeles están perdiendo la batalla,</V>\t\n\"<J>¡NUNCA TE RINDAS, TE DARÉ TODO MI PODER PERO NUNCA TE RINDAS!</J>\" --<font color='#61B6BD'>Gritó el Dios ratón antes de su muerte</font>",
		"\t<font color='#61B6BD'>Con el último poder del Ratón Dios, los ángeles podrían proteger su cielo, podrían irrumpir en el infierno, dentro del volcán de los demonios</font>\n\t<V>Y aquí hay una gran explosión, el volcán fue destruido, los demonios están perdiendo esta batalla</V>\n\t<font color='#AD2428'>Pero, los demonios no van a perder fácilmente, los demonios son fuertes, podrían protegerse en esta gran guerra...</font>",
		"\t<V>El volcán de los demonios fue destruido, el cielo también fue destruido,\n\tLos últimos ángeles sobrevivientes y los últimos demonios sobrevivientes luchan entre sí en su última batalla.</V>\n\t<J>¿Quién ganó? ¿Quién perdió? Eso es un misterio eterno, una aventura eterna.</J>"
	},
	cannons="Cañones",
	shields="Escudos",
	discord="No olvide unirse a nuestro servidor Discord oficial::",
	disco = "¡¡Baila!! ¡Las puertas de la discoteca están abiertas! ¡Ven, sigue tu color favorito, muéstranos tus movimientos de baile!",
	submit="Puedes enviar tus mapas aquí:",
	leaderRoom="Sala",
	leaderGlobal="Global",
	name="Nombre",
	winsB="Victorias",
	commu="Comunidad",
	rolesHelp={
		i="El Sabio puede tirar a los oponentes preparando una tormenta, presionando el botón E.",
		c="El botánico puede detener aleatoriamente a uno de los oponentes de uno de sus ataque presionando el botón E, durante 10 segundos.",
		w="El mago puede poner al azar a uno de los oponentes en una jaula presionando el botón E, durante 10 segundos.",
		a="El ataque del luchador es más fuerte y rápido que los demás, además causa más daño.",
		p="Los equipos de Protección pierden menos HP cuando son atacados, y también puede poner un escudo presionando el botón E.",
		he="El curador puede aumentar el HP de su equipo en un 15% y evitar que todos los oponentes ataquen presionando el botón E."
	},
	welcome="<VP>Bienvenido a <b><J>#MyHero</J></b>, únete a uno de los <b><J>dos equipos</J></b> y elige tu <b><J>rol</J></b>, y <b><J>LUCHA</J></b>, escribe <b><J>!help</J></b> o haga clic en <b><J>H</J></b> para obtener más información sobre el minijuego.",
	helped="<BL>Todas estás personas ayudaron de alguna manera a desarrollar este módulo\nCon algunos códigos, Ideas, Traducciones, Probando el módulo, etc..\n",
	lgs="Idiomas disponibles",
	changed="<VP> La posición de disparo de sus cañones ha sido cambiada a (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
	toSave="Debe haber al menos 3 héroes y 3 villanos para guardar los datos.",
	wins={
		"Victorias",
		"Victorias como Luchador",
		"Victorias como Protector",
		"Victorias como Curador",
		"Victorias como Mago",
		"Victorias como Botánico",
		"Victorias como sabio",
		"Victorias en el modo ratón loco",
		"Victorias en el modo retro"
	},
	damage="Total de daño",
	wrong="Debes elegir un equipo para poder utilizar esta función.",
	enough="No tienes suficiente dinero :(",
	tm="Los miembros de tu equipo son",
	disabled="Deshabilitado",
    eq="Equipar",
    eqd="Equipado",
	use="Utilizar",
	buy="Comprar",
	close="Cerrar",
	next="Siguiente",
	pre="Anterior",
	icons={
		on="Los iconos aparecerán en la próxima ronda.",
		off="Los iconos desaparecerán en la siguiente ronda."
	},
	quests={
		inf="Recoge <FC>%s</FC> piedras infinitas.",
		avd="Obtén <FC>%s</FC> puntos en el evento Ángeles vs Demonios.",
		halloween="Obtén <FC>%s</FC> puntos en el evento de Halloween.",
		global="Llega a estar <FC>#%s</FC> en la clasificación mundial.",
		winMouse="Asegura <FC>%s</FC> rondas en el modo ratón loco.",
		def="Empezar a jugar <FC>#MyHero</FC> .",
		help="Ayuda a completar este minijuego\nAyuda con el código - traducción - arte... Etc.",
		map="Crea un mapa para <FC>#MyHero</FC> .",
		win="Victorias <FC>%s</FC> rondas.",
		winRetro="Victorias <FC>%s</FC> rondas en los mapas retro.",
		winrole="Victorias <FC>%s</FC> Rondas mientras eres un <FC>%s</FC>.",
		points="Daño total <FC>%s</FC> al otro equipo."
	},
	h="Héroe",
	v="Villano",
	roles={
		i="Sabio",
		c="Botánico",
		w="Mago",
		he="Curador",
		a="Peleador",
		p="Protector"
	},
	yes="Sí",
	no="No",
	full="¡Este equipo está lleno de jugadores!",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>¿Estás seguro de que quieres cambiar tu %s?\n\n<font color='#FFCD46'>Te costará %s $ \n\nActualmente tienes %s $"
}
--[[ End of file translations/es.lua ]]--
--[[ File translations/fr.lua ]]--
--You don't have to translate the story={ } part!

translations.fr={
	donate="Tape <b>!donate</b> si tu souhaites faire un don à ce module!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Bienvenue à <font color='#2b4e95'><b>#MyHero</b></font>, dans ce jeu, le but est d'aider ton équipe à battre l'équipe adverse. Choisi ton équipe, ton rôle et BATS-TOI!\n Tu peux charger ton attaque en appuyant sur la <font color='#2b4e95'><b>Barre d'Espace</b></font> et relâche-là pour tirer.\n Tu peux changer la direction de ton attaque en appuyant sur les boutons <font color='#2b4e95'><b>C et V</b></font>.\n\n Tu peux soumettre tes maps pour le module sur le <u><a href='event:link_maps'>Forum</a></u>.\n Tu peux également rejoindre notre <u><a href='event:link_discord'>Serveur Discord</a></u> pour signaler un bug et donner des suggestions.",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Commandes</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Tu peux ouvrir ton profil en appuyant sur la touche <font color='#2b4e95'><b>P</b></font> ou en écrivant <font color='#2b4e95'><b>!profile [<V>Pseudo#Tag</V>]</b></font>\n\n Tu peux ouvrir le magasin du module où tu peux acheter des Élixirs et des Cannons en appuyant sur la touche <font color='#2b4e95'><b>O</b></font> ou avec la commande<font color='#2b4e95'><b>!shop</b></font>\n\n Tu peux ouvrir le classement avec la touche <font color='#2b4e95'><b>L</b></font> ou la commande <font color='#2b4e95'><b>!leaderboard</b></font>\n\n Tu peux ouvrir le menu d'aide en appuyant sur la touche <font color='#2b4e95'><b>H</b></font> ou en tapant <font color='#2b4e95'><b>!help</b></font>\n\n Tu peux Changer la langue du module à l'aide de la commande <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Crédits</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> a été créé par<font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Développer) et <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Artiste)\n\nLe module a été traduit en français par <font color='#42bfe8'>Athesdrake</font><font size='10'>#0000</font>",
			[2]="\n\n<font size='12' color='#040028'><p align='center'>Toutes les personnes qui ont aidé d'une manière ou d'une autre le développement du module\nProgrammation, idées, etc:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Programmation).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Illustrations/Images).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Donations</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'>L'équipe de <b>MyHero</b></font> adore l'Open Source! Tu peux voir et modifier le code source sur <u><a href='event:link_code'>GitHub</a></u>.\nEntretenir le module est strictement bénévole, donc toute aide apportée à concernant le code, les signalements de bugs, les suggestions et la création de carte est toujours <u>appréciée et la bienvenue</u>.\n\nTu peux proposer tes cartes sur le <u><a href='event:link_maps'>Forum</a></u>.\nTue peux rejoindre notre <u><a href='event:link_discord'>Serveur Discord</a></u> pour signaler des bugs et donner des suggestions.",
			[2]="\n\n\t <font size='12' color='#040028'>Entretenir <b>MyHero</b> n'est pas cher, mais n'est pas non plus gratuit.\n\n<p align='center'>Nous apprécierions si vous pouvez nous aider en <font color='#2b4e95'><b>faisant un don de n'importe quel montant</b></font> <u><b><a href='event:link_donate'>ICI</a></b></u>\n\n<u>Toute donation ira dans l'amélioration du module.</u></p>",
        },
		new={
            [1]="<font face='Lucida console'><p align='center'><font size='18' color='#2b4e95'><b>#MyHero Version 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Dites bonjour au tout nouveau <font color='#2b4e95'><b>#MyHero</b></font>, le module a été refait avec un nouveau design !\n\nNouveautés\n  • L'interface graphique du module a été mise à jour.\n  • Les Kits Systèmes ont été ajouté.\n  • L'événement Halloween est de retour.\n  • Les cannons spécial halloween ont été rajoutés.\n  • Introduction d'un nouveau mode de jeu: les cartes Retro.",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"Héros, vous êtes en train de changer le monde !",
				"Héros, vous êtes bien plus fort que vous ne le croyez, faites-moi confiance.",
				"Il y a un super-héro dans chacun de nous, nous avons juste besoin d'avoir le courage de mettre la cape.",
			},
			bat={
				"Héros, souviens-toi, justice n'est vengeance!",
				"Un héro peut être n'importe qui.",
				"Les héros n'ont pas de limite.",
				"La nuit est plus sombre juste avant aube. Et je te le promets, l'aube arrive!",
				"Je suis BATMAN!",
			},
			wonder={
				"Héros, vous avez de plus grands pouvoirs que vous ne le pensez !",
				"Si personne d'autre ne défend le monde, alors les héros le doivent.",
				"Je peux sauver aujourd'hui, mais héros peuvent sauver le monde.",
			},
		},
		v={
			joker={
				"Hahahahahaha !",
				"Je suis toujours souriant.",
				"Les méchants ne sont pas des monstres, ils sont juste différents.",
				"Je crois que tout ce qui ne tue pas, te rend simplement étranger.",
			},
			dark={
				"Les méchants auront la victoire !",
			},
		}
	},
	soon="Bientôt!",
	maxEx="Vous ne pouvez pas acheter plus de 20 de cet Élixir!",
	kits={
		[41]="Rapidité: Cet Élixir te rendra plus rapide que l'éclair !",
		[42]="Esprit: Cet Élixir donne la capacité d'invoquer des esprits sacrés.",
		[43]="Sauts Améliorés: Cet Élixir te rend capable de sauter comme un singe.",
		[44]="BOMBES: Cet Élixir peut faire exploser tes cannons lorsqu'ils toucheront un adversaire.",
	},
	team="Équipe",
	role="Rôle",
	settings={
		"Afficher les icônes des rôles des joueurs.",
		"Afficher automatiquement la liste des Élixirs après avoir perdu/gagné une partie.",
		"Langage",
		"Changer d'Équipe",
		"Changer de Rôle",
	},
	damageB="Dégâts",
	eve="Événements",
	info="Info",
	sett="Paramètres",
	auto="<J>ATTENTION: Des Cannons Aléatoires vont être tirés de chaque côté.</J>",
	events={
		"<font color='#f5602a'>Halloween</font>",
		"<font color='#61B6BD'>Anges</font> <V>vs</V> <font color='#AD2428'>Démons</font>",
		"<font color='#FF6347'>Pi</font><font color='#12E772'>er</font><font color='#FF8B00'>res</font> de l' <font color='#266EF6'>In</font><font color='#E429F2'>fi</font><font color='#DC143C'>ni</font><font color='#FF0130'></font>"
	},
	story={
		"\t<V>Everything is quiet here in the heaven, The Angels live their normal lives with no troubles,</V>\n\t<font color='#AD2428'>OMG, The Demons have just attacked the heaven!</font>\n\t\"<J>You Angels, Never Give up, do your best to fight the demons!!</J>\" --<font color='#61B6BD'>Said The God Mouse</font>",
		"\t<V>What a great war between the Angels and the Demons. Both of the Heaven and the Hell got destroyed!!</V>\n\t\"<R>Grr, Grr, You noob demons, can't you defeat some angels? Grrr</R>\" --<font color='#AD2428'>Said The Demon Cat</font>\n\t<font color='#61B6BD'>It has started, the biggest war, The God Mouse just entered and started to attack the Demons, but, The Demon Cat won't allow that...</font>",
		"\t<V>Both of <font color='#61B6BD'>The God Mouse</font> and <font color='#AD2428'>The Demon Cat</font> died in the great battle...</V>\n\t<font color='#AD2428'>Before dying, The Demon Cat used his last power to break the wall between the Heaven and the Hell, The Demons broke into the heaven!</font>\n\t<V>The Angels are losing the battle,</V>\t\n\"<J>NEVER GIVE UP, I'LL GIVE YOU ALL MY POWER, BUT NEVER GIVE UP!</J>\" --<font color='#61B6BD'>Shouted The God Mouse Before his Death</font>",
		"\t<font color='#61B6BD'>With The God Mouse's last power, the angels could protect their heaven, they could break into the hell, inside the Demons Volcano</font>\n\t<V>And here is a great explosion, the volcano was destroyed, The Demons are losing this battle</V>\n\t<font color='#AD2428'>But, Demons aren't going to lose easily, The Demons are strong, they could preotect themselves in this great war...</font>",
		"\t<V>The Demons Volcano was destroyed, The Heaven was destroyed too,\n\tThe last survivor Angels, and The last survivor Demons are fighting each other in their last battle,</V>\n\t<J>Who won? Who lost? That's an eternal mystery, eternal adventure.</J>"
	},
	cannons="Cannons",
	shields="Boucliers",
	discord="N'oublie pas de rejoindre notre Discord Officiel:",
	disco="Danse!! Les portes de la discothèque sont ouvertes ! Vient, suit la couleur spécifique, montre-nous tes pas de danse !",
	submit="Tu peux proposer tes cartes ici:",
	leaderRoom="Salon",
	leaderGlobal="Global",
	name="Nom",
	winsB="Gagné",
	commu="Communauté",
	rolesHelp={
		i="Le Sage peut lancer ses adversaires en provoquant une tempête, en appuyant sur la touche E.",
		c="Le Botaniste peut arrêter aléatoirement les attaques de ses adversaires en appuyant sur la touche E, l'effet dure 10 secondes.",
		w="Le Mage peut mettre des adversaires aléatoires dans des cages en appuyant sur la touche E, pendant 10 secondes.",
		a="L'attaque du Combattant est plus forte et plus rapide, il fait également plus de dégâts.",
		p="L'équipe du Protecteur perd moins de PV lorsqu'elle est attaquée. Il peut également mettre un bouclier en appuyant sur la touche E.",
		he="Le Guérisseur peut augmenter les PV de son équipe de 15% et stopper toutes les attaques de ses adversaires en appuyant sur la touche E."
	},
	welcome="<VP>Bienvenue dans <b><J>#MyHero</J></b>, rejoins une des <b><J>deux équipes</J></b> et choisis ton <b><J>rôle</J></b>, et <b><J>BATS-TOI</J></b>, écris <b><J>!help</J></b> ou appuies sur <b><J>H</J></b> pour obtenir plus d'informations à propos du du mini-jeu.",
	helped="<BL>Toutes ces personnes ont aidé au développement du module d'une façon ou d'une autre\nPour le code, des idées, la traduction, le test du module, etc.\n",
	lgs="Les langues disponibles sont",
	changed="<VP>La position des cannons ont bien été changé en (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
	toSave="Il doit y avoir minimum 3 Héros et 3 Méchants pour sauvegarder les données.",
	wins={
		"Parties gagnées",
		"Parties gagnées en tant que Combattant",
		"Parties gagnées en tant que Protecteur",
		"Parties gagnées en tant que Guérisseur",
		"Parties gagnées en tant que Mage",
		"Parties gagnées en tant que Botaniste",
		"Parties gagnées en tant que Sage",
		"Parties gagnées dans le mode crazy Mouse",
		"Parties gagnées dans le mode Rétro"
	},
	damage="Dégâts total",
	wrong="Tu dois choisir une équipe pour pouvoir utiliser cette fonctionnalité.",
	enough="Tu n'as pas assez d'argent :(",
	tm="Les membres de ton équipe sont",
	disabled="Désactivé",
    eq="Équiper",
    eqd="Équipé",
	use="Utiliser",
	buy="Acheter",
	close="Fermer",
	next="Prochain",
	pre="Précédant",
	icons={
		on="Les icônes apparaîtrons à la partie suivante.",
		off="Les icônes disparaîtrons à la partie suivante."
	},
	quests={
		inf="Récupère <FC>%s</FC> Pierres de l'Infini.",
		avd="Marque <FC>%s</FC> points à l’événement Anges vs Démons.",
		halloween="Marque <FC>%s</FC> points à l’événement Halloween.",
		global="Obtient la position <FC>#%s</FC> dans le classement global.",
		winMouse="Gagne <FC>%s</FC> parties dans le mode crazy mouse.",
		def="Commence à jouer à <FC>#MyHero</FC>.",
		help="Aide à terminer ce mini-jeu\nAide avec le code - la traduction - les dessins ... etc.",
		map="Crée une carte pour <FC>#MyHero</FC> .",
		win="Gagne <FC>%s</FC> parties.",
		winRetro="Gagne <FC>%s</FC> parties dans les cartes Rétro.",
		winrole="Gagne <FC>%s</FC> parties en étant <FC>%s</FC>.",
		points="Inflige un total de <FC>%s</FC> dégâts à l'autre équipe."
	},
	h="Héro",
	v="Méchant",
	roles={
		i="Sage",
		c="Botaniste",
		w="Mage",
		he="Guérisseur",
		a="Combattant",
		p="Protecteur"
	},
	yes="Oui",
	no="Non",
	full="Cette équipe est complète !",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>Es-tu sûr de vouloir te changer en %s?\n\n<font color='#FFCD46'>Ça te coûtera %s $ \n\nTu as actuellement %s $"
}
--[[ End of file translations/fr.lua ]]--
--[[ File translations/pl.lua ]]--
--You don't have to translate the story={ } part!

translations.pl={
	donate="Wpisz komendę <b>!donate</b> jakbyś chciał wesprzeć twórcę tego modułu!",
	hMenu={
		help={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>#MyHero</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Witaj na <font color='#2b4e95'><b>#MyHero</b></font>, wraz ze swoją drużyną zwalcz przeciwników, wybierz drużynę, klasę i WALCZ!\n Możesz ładować swój atak przetrzymując <font color='#2b4e95'><b>Spację</b></font>, później puść ją żeby zaatakować.\n Możesz też zmienić kierunek, w którą stronę atakujesz za pomocą klawiszy <font color='#2b4e95'><b>C i V</b></font>.\n\n Pamiętaj, że możesz też zgłosić swoją mapę w naszym <u><a href='event:link_maps'>Wątku na forum</a></u>.\n Możesz też dolączyć na nasz <u><a href='event:link_discord'>Serwer Discord</a></u>, aby zgłosić błędy, bądź podać swoje pomysły.",
			[2]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Komendy</b></font></p>\n<p align='left'><font size='12' color='#040028'>\t Możesz otworzyć swój profil klikając klawisz <font color='#2b4e95'><b>P</b></font>, bądź wpisując komendę <font color='#2b4e95'><b>!profile [<V>NazwaUżytkownika#Tag</V>]</b></font>\n\n Możesz otworzyć sklep, w którym możesz kupić Elixiry i Cannony, klikając klawisz <font color='#2b4e95'><b>O</b></font>, bądź wpisując komendę <font color='#2b4e95'><b>!shop</b></font>\n\n Możesz otworzyć ranking używając klawisz <font color='#2b4e95'><b>L</b></font>, albo wpisujac komendę <font color='#2b4e95'><b>!leaderboard</b></font>\n\n Możesz otworzyć pomoć używając klawisz <font color='#2b4e95'><b>H</b></font>, albo wpisująć komendę <font color='#2b4e95'><b>!help</b></font>\n\n Możesz też zmienić język modułu wpisując komendę <font color='#2b4e95'><b>!lang </font>[<BV><a href='event:lgs'>XX</a></BV>]</b></font>",
		},
		credits={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Twórcy</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t <font color='#2b4e95'><b>MyHero</b></font> został stworzony przez <font color='#f1641f'>Bodykudo</font><font size='10'>#0000</font> (Developer) i <font color='#9052bc'>Mouny</font><font size='10'>#6831</font> (Grafik)\n\nModuł na język polski przetłumaczył <font color='#42bfe8'>Sebafrancuz</font><font size='10'>#0000</font>",
			[2]="\n\n<font size='12' color='#040028' face='Lucida console'><p align='center'>Chciałbym szczególnie podziękować osobom, które pomogły mi w jakimś stopniu w rozwijaniu tego modułu.\nKody, pomysły itp.:</p>\n\n<font color='#b25266'>Bolodefchoco</font><font size='10'>#0000</font>, <font color='#b25266'>Tocutoeltuco</font><font size='10'>#0000</font>, <font color='#b25266'>Extremq</font><font size='10'>#0000</font>, <font color='#b25266'>Heniyengui</font><font size='10'>#0000</font> (Pomoc w kodzie).\n\n<font color='#9052bc'>Creativemice</font><font size='10'>#7925</font>, <font color='#9052bc'>Liiliiith</font><font size='10'>#0000</font>, <font color='#9052bc'>Sonicyss</font><font size='10'>#0000</font>, <font color='#9052bc'>Kariina</font><font size='10'>#2631</font>, <font color='#9052bc'>Smutny_nalesnik</font><font size='10'>#0000</font>, <font color='#9052bc'>Lunartear</font><font size='10'>#6947</font> (Pomoc w grafice).",
		},
		donate={
			[1]="<font face='Lucida console'><p align='center'><font size='30' color='#2b4e95'><b>Donacje</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Zespół <font color='#2b4e95'><b>MyHero</b></font> kocha Otwarty Kod Źródłowy! Możesz przyjrzeć sie, bądź modyfikować kod na <u><a href='event:link_code'>GitHubie</a></u>.\nJesteśmy wolontariuszami, więc jakakolwiek pomoc w kodzie, w zgłaszaniu błędów, sugestii oraz pomoc przy tworzeniu map jest zawsze <u>mile widziana i doceniana</u>.\n\nMożesz zgłaszać swoje mapy w <u><a href='event:link_maps'>Wątku na Forum</a></u>.\nMożesz też dołączyć na nasz <u><a href='event:link_discord'>Serwer Discord</a></u>, aby zgłosić błędy, bądź podać swoje pomysły .",
			[2]="\n\n\t <font face='Lucida console'><font size='12' color='#040028'>Rozwój <b>MyHero</b> nie jest drogi, ale nie oznacza, że nic nie kosztuje.\n\n<p align='center'>Bylibyśmy bardzo wdzięczni, gdybyście wsparli nas <font color='#2b4e95'><b>jakąkolwiek kwotą</b></font> <u><b><a href='event:link_donate'>KLIK</a></b></u>\n\n<u>Wszystkie donacje pomogą w rozwoju minigry.</u></p>",
		},
		new={
            [1]="<font face='Lucida console'><p align='center'><font size='16' color='#2b4e95'><b>#MyHero Wersja 2.0.0</b></font></p>\n\n<p align='left'><font size='12' color='#040028'>\t Witajcie na nowym <font color='#2b4e95'><b>#MyHero</b></font>, moduł został całkowicie odnowiony!\n\nCo nowego?\n  • Interfejs został całkowicie odnowiony.\n  • Został zaimplementowany system ekwipunktu.\n  • Powrócił event halloweenowy.\n  • Nowe, specjalne, Halloweenowe cannony zostały dodane do gry.\n  • Został przedstawiony nowy tryb gry: Mapy Retro.",
			[2]=""
		},
	},
	messages={
		h={
			super={
				"Bohaterowie, niedługo świat już będzie lepszy!",
				"Bohaterowie, jesteście o wiele silniejsi niż wam się wydaje.",
				"Wszyscy jesteśmy superbohaterami, odwaga jest najważniejsza.",
			},
			bat={
				"Bohaterowi, pamiętajcie, sprawiedliwość, nie przemoc!",
				"Każdy może być bohaterem.",
				"Bohaterowie są wieczni.",
				"Po nocy zawsze następuje świt. Przysięgam, ten świt jest już blisko!",
				"Ja jestem BATMAN!",
			},
			wonder={
				"Bohaterowie, jesteście potężniejsi niż wam się wydaje!",
				"Jeżeli nikt nie potrafi uratować świata, to muszą zająć się tym bohaterowie.",
				"Ja mogę uratować wszystkich już dzisiaj, ale bohaterowie muszą uratować świat.",
			},
		},
		v={
			joker={
				"Hahahahahaha!",
				"Ja zawsze się śmieję.",
				"Złoczyńcy nie są potworami, są czymś innym.",
				"Wierzę, cokolwiek ciebie nie zabije, powoduje że stajesz się silniejszy.",
			},
			dark={
				"Złoczyńcy to wygrają!",
			},
		}
	},
	soon="Wkrótce!",
	maxEx="Nie możesz kupić więcej niż 20 Elixirów!",
	kits={
		[41]="Podwójna Prędkość: Elixir sprawi, że będziesz szybszy/-a niż światło!",
		[42]="Duchy: Elixir pozwoli ci wezwać święte duchy.",
		[43]="Wysoki Skok: Elixir pozwoli ci wysoko skakać.",
		[44]="BOMBY: Elixir sprawi, że twoje cannony będą wybuchały po zetchnięciu z przeciwnikiem.",
	},
	team="Drużyna",
	role="Klasa",
	settings={
		"Pokaż ikony klas graczy.",
		"Pokaż automatycznie listę Elixirów po każdym meczu.",
		"Język",
		"Zmień Drużynę",
		"Zmień Klasę",
	},
	damageB="Obrażenia",
	eve="Eventy",
	info="Informacje",
	sett="Ustawienia",
	auto="<J>UWAGA: Cannony będą wystrzeliwały losowo w obie strony.</J>",
	events={
		"<font color='#f5602a'>Halloween</font>",
		"<font color='#61B6BD'>Anioły</font> <V>vs</V> <font color='#AD2428'>Demony</font>",
		"<font color='#266EF6'>Ka</font><font color='#E429F2'>mie</font><font color='#DC143C'>nie</font><font color='#FF0130'> Nie</font><font color='#FF6347'>skoń</font><font color='#12E772'>czo</font><font color='#FF8B00'>ności</font>"
	},
	story={
		"\t<V>Anioły żyją w całkowitym pokoju, bez żadnych problemów.</V>\n\t<font color='#AD2428'>OMG, Domony właśnie zaatakowały Niebo!</font>\n\t\"<J>Anioły, pamiętajcie, aby się nie poddawać, powstrzymajcie Demony!!</J>\" --<font color='#61B6BD'>Powiedział Bóg Myszek</font>",
		"\t<V>Cóż za bitwa. Niebo tak samo jak Piekło zostały zniszczone!!</V>\n\t\"<R>Grr, Grr, Wy słabe Demonki, nie potraficie nawet zniszczyć kilka Aniołków? Grrr</R>\" --<font color='#AD2428'>Powiedział Kot Demon</font>\n\t<font color='#61B6BD'>To się zaczęła, największa bitwa, Bóg Myszek dołączył do bitwy i atakuje Demony, ale Kot Demon nie dopuści do tego...</font>",
		"\t<V><font color='#61B6BD'>Bóg Myszek</font> i <font color='#AD2428'>Kot Demon</font> ponieśli klęskę...</V>\n\t<font color='#AD2428'>Tóż przed śmiercią, Kot Demon użył swojej mocy, aby zniszczyć ścianę dzielącą Niebo i Piekło, Demony dostały się do Nieba!</font>\n\t<V>Anioły przegrywają tę wojnę,</V>\t\n\"<J>PAMIĘTAJCIE NIE PODDAWAJCIE SIĘ, ODDAM WAM MOJĄ CAŁĄ MOC!</J>\" --<font color='#61B6BD'>Wykrzyknął Bóg Myszek tóż przed śmiercią</font>",
		"\t<font color='#61B6BD'>Z potęgą Boga Myszek, Anioły są w stanie uratować Niebo, mogą dostać się do Piekła, do Wulkanu Demonów</font>\n\t<V>Ależ wybuch, Wulkan został zniszczony, Demony ponoszą klęskę</V>\n\t<font color='#AD2428'>Demony nie poddają się tak szybko, Demony są bardzo silne, mogą się wspierać i jeszcze wygrać tę bitwę...</font>",
		"\t<V>Niebo i Piekło są zniszczone.\n\tOstatni Aniołowie i Demony walczą o władzę,</V>\n\t<J>Kto wygra? Kto przegra? To są odwieczne pytania.</J>"
	},
	cannons="Cannony",
	shields="Tarcze",
	discord="Nie zapomnij dołączyć na nasz serwer Discord:",
	disco="Tańcz!! Drzwi otwarte! Przyjdź, podążaj za swoim kolorem, pokaż swoje taneczne ruchy!",
	submit="Możesz zgłaszać swoje mapy tutaj:",
	leaderRoom="Lokalny",
	leaderGlobal="Globalny",
	name="Nazwa",
	winsB="Wygrane",
	commu="Społeczność",
	rolesHelp={
		i="Mędrzec może popchnąć przeciwników używając siły burzy, klikając klawisz E.",
		c="Botanik może powstrzymać atak losowego przeciwnika, klikając klawisz E, przeciwnik nie może atakować przez 10 sekund.",
		w="Czarodziej może uwięzić przeciwnika w klatce, klikając klawisz E, klatka działa na 10 sekund.",
		a="Atak Wojownika jest silniejszy i szybszy, co powoduje że zadaje więcej obrażen.",
		p="Drużyna Obrońcy traci mniej PZ i może włączyć tarczę, klikając klawisz E.",
		he="Uzdrowiciel zwiększa PZ członkom swojej drużyny o 15% i powstrzymać przeciwników od ataku, klikając klawisz E."
	},
	welcome="<VP>Witaj na <b><J>#MyHero</J></b>, dołącz do jednej z <b><J>dwóch drużyn</J></b>, wybierz swoją <b><J>klasę</J></b>, i <b><J>WALCZ</J></b>, wpisz <b><J>!help</J></b> albo kliknij w klawisz <b><J>H</J></b>, aby otrzymać więcej informacji o minigrze.",
	helped="<BL>Chciałbym szczególnie podziękować osobom, które pomogły mi w jakimś stopniu w rozwijaniu tego modułu.\nKody, pomysły, tłumaczenia, testowanie modułu, itp.\n",
	lgs="Lista dostępnych języków:",
	changed="<VP>Pozycja startowa wystrzału twoich cannonów została zmieniona (<FC>X: <N>%s <FC>Y: <N>%s<VP>)",
	toSave="Musi być co najmniej 3 Bohaterów i 3 Złoczyńców, aby twoje dane się zapisały.",
	wins={
		"Wygrane",
		"Wygrane jako Wojownik",
		"Wygrane jako Obrońca",
		"Wygrane jako Uzdrowiciel",
		"Wygrane jako Czarodziej",
		"Wygrane jako Botanik",
		"Wygrane jako Mędrzec",
		"Wygrane w trybie crazy Mouse",
		"Wygrane w trybie Retro"
	},
	damage="Całkowite obrażenia",
	wrong="Musisz wybrać jakąkolwiek drużynę, aby móc to użyć.",
	enough="Nie posiadasz wystarczającej ilości pieniędzy :(",
	tm="W twojej drużynie są",
	disabled="Wyłączony",
    eq="Załóż",
    eqd="Założony",
	use="Użyj",
	buy="Kup",
	close="Zamknij",
	next="Następny",
	pre="Poprzedni",
	icons={
		on="Ikony pojawią się na początku następnej rundy.",
		off="Ikony znikną na początku następnej rundy."
	},
	quests={
		inf="Zdobądź <FC>%s</FC> Kamieni Nieskończoności.",
		avd="Zdobądź <FC>%s</FC> punktów w evencie Anioły vs Demony.",
		halloween="Zdobądx <FC>%s</FC> punktów w evencie Halloweenowym.",
		global="Zajmij <FC>#%s</FC> pozycję w globalnym rankingu.",
		winMouse="Wygraj <FC>%s</FC> rund w crazy mouse mode.",
		def="Rozpocznij swoją grę w <FC>#MyHero</FC> .",
		help="Pomóż przy tworzeniu modułu\nZaliczają się do tego, pomoc w kodzie - tłumaczeniach - grafice .. itp.",
		map="Stwórz mapę dla modułu <FC>#MyHero</FC> .",
		win="Wygraj <FC>%s</FC> rund.",
		winRetro="Wygraj <FC>%s</FC> rund na mapach Retro.",
		winrole="Wygraj <FC>%s</FC> rund, kiedy twoja klasa to <FC>%s</FC>.",
		points="Zadaj <FC>%s</FC> całkowitych obrażeń przeciwnej drużynie."
	},
	h="Bohater",
	v="Złoczyńca",
	roles={
		i="Mędrzec",
		c="Botanik",
		w="Czarodziej",
		he="Uzdrowiciel",
		a="Wojownik",
		p="Obrońca"
	},
	yes="Tak",
	no="Nie",
	full="Ta drużyna jest już pełna!",
	change="<p align='center'><b><font face='Lucida console' color='#7B415C'>Czy jesteś pewny/-a, że chcesz wymienić %s?\n\n<font color='#FFCD46'>Będzie to ciebie kosztowało %s $ \n\nAktualnie posiadasz %s $"
}
--[[ End of file translations/pl.lua ]]--
--[[ End of directory translations ]]--
--[[ Directory systems ]]--
--[[ File systems/dataSystem.lua ]]--
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
--[[ End of file systems/dataSystem.lua ]]--
--[[ File systems/gameplay.lua ]]--
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
--[[ End of file systems/gameplay.lua ]]--
--[[ File systems/mapsSystem.lua ]]--
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
--[[ End of file systems/mapsSystem.lua ]]--
--[[ File systems/rankingSystem.lua ]]--
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

gbPl=deepcopy(data)
lb_gbPl={}
function sort_gb(t)
    local lb1, lb = {} , {}
    for name in next, t do
        lb1[#lb1 + 1] = {name, t[name][2]}
    end
    repeat
        local a, max_Val = -math.huge , 1
        for i = 1, #lb1 do
            if lb1[i][2] > a then
                a = lb1[i][2]
                max_Val = i
            end
        end
        table.insert(lb, lb1[max_Val][1])
        table.remove(lb1, max_Val)
    until #lb1 == 0
    return lb
end

function eventFileLoaded(fN, fD)
    if fN=="1" then
        gbPl=deepcopy(data)
        for n in pairs(gbPl) do
            gbPl[n][1]=gbPl[n][31]
            gbPl[n][2]=gbPl[n][6]
            gbPl[n][3]=gbPl[n][7]
        end
        for n in fD:gmatch("[^$]+") do 
            local t={}
            for k in n:gmatch("[^,]+") do
                table.insert(t,k)
            end
            if not gbPl[t[1]] then
                gbPl[t[1]]={t[2],tonumber(t[3]),tonumber(t[4])}
            end
        end
        lb_gbPl=sort_gb(gbPl)
        local t=""
        for i=1,50 do
            if lb_gbPl[i] then
                local n=lb_gbPl[i]
                if n:sub(0,1)~="*" then
                    t=t..""..n..","..gbPl[n][1]..","..gbPl[n][2]..","..gbPl[n][3].."$"
                end
            end
        end
        t=t:sub(#t)=="$" and t:sub(0,#t-1) or t
        if inRoomModule and table.count(teams["h"].inRoomMembers) > 0 and table.count(teams["v"].inRoomMembers) > 0 then
            system.saveFile(t,1)
        end
    end
end

function ms.rankPlayers()
    prs={}
    for n in pairs(data) do
        if tfm.get.room.playerList[n] and n:sub(0,1)~="*" then
            table.insert(prs,n)
        end
    end
    maxPlayers={}
    while (#prs~=0) do
        mS=-1
        mp=nil
        for i,n in pairs (prs) do
            if mS < data[n][6] then
                mS=data[n][6]
                mP=n
                idRa=i
            end
        end
        table.insert(maxPlayers,{mP,mS})
        table.remove(prs,idRa)
    end
    return maxPlayers
end
--[[ End of file systems/rankingSystem.lua ]]--
--[[ File systems/translateSystem.lua ]]--
function ms.setLang(n)
    text[n]=translations[tfm.get.room.playerList[n].community] or translations.en
end
--[[ End of file systems/translateSystem.lua ]]--
--[[ File systems/UI.lua ]]--
function ui.addToggle(id, player, x, y, state, button)
    ui.addTextArea(id, "", player, x, y, 20, 7, 0x232a35, 0x232a35, 1, true)
    if not state then
        ui.addTextArea(id + 1, "", player, x + 3, y + 3, 1, 1, 0xd23c2c, 0xd23c2c, 1, true)
    else
        ui.addTextArea(id + 1, "", player, x + 16, y + 3, 1, 1, 0x8fd032, 0x8fd032, 1, true)
    end
    ui.addTextArea(id + 2, "<a href='event:"..button.."'>\n\n\n", player, x - 7, y - 7, 30, 20, 1, 1, 0, true)
end

function ui.addTimerImage(img,x,y,n,time)
    time=time or 5
    local img=tfm.exec.addImage(img..".png","&0",x,y,n)
    system.newTimer(function()
        tfm.exec.removeImage(img,n)
    end,time*1000,false)
end
--[[ End of file systems/UI.lua ]]--
--[[ End of directory systems ]]--
--[[ Directory menus ]]--
--[[ File menus/help.lua ]]--
function ms.openHelp(n,type)
    if data[n][3]==1 then
        id.help[1][n]=tfm.exec.addImage("1748a9c39b0.png",":100",83,56,n) --Book
        id.help[2][n]=tfm.exec.addImage("1748a9c79d3.png",":100",83,56,type=="help" and "Random" or n) --Help
        id.help[3][n]=tfm.exec.addImage("1748a9cb932.png",":100",83,56,type=="credits" and "Random" or n) --Credits
        id.help[4][n]=tfm.exec.addImage("1748a9cde35.png",":100",83,56,type=="donate" and "Random" or n) --Donate
        id.help[5][n]=tfm.exec.addImage("175179cfea5.png",":100",80,105,type=="new" and "Random" or n) --New
        ui.addTextArea(101, "<a href='event:close'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 647, 62, 50, 47, 0x0, 0x0, 0, true)
        ui.addTextArea(102, "<a href='event:type_help'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="help" and "Random" or n, 157, 65, 45, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(103, "<a href='event:type_credits'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="credits" and "Random" or n, 219, 63, 45, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(104, "<a href='event:type_donate'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="donate" and "Random" or n, 281, 60, 46, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(107, "<a href='event:type_new'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="new" and "Random" or n, 92, 111, 30, 45, 0x0, 0x0, 0, true)
        ui.addTextArea(105, text[n].hMenu[type][1], n, 130, 105, 260, 260, 0x0, 0x0, 0, true)
        ui.addTextArea(106, text[n].hMenu[type][2], n, 404, 105, 260, 260, 0x0, 0x0, 0, true)
        if type=="new" then
            id.help[6][n]=tfm.exec.addImage(updates[VERSION].img..".png",":100",404,105,type=="new" and "Random" or n)
        end
    else
        tfm.exec.chatMessage("<R>"..text[n].wrong,n)
    end
end
--[[ End of file menus/help.lua ]]--
--[[ File menus/kitsMenu.lua ]]--
function ms.kits(n,page)
    local x=data[n][2]=="h" and -625 or 0
    id.sKit[1][n]=tfm.exec.addImage("1742850495e.png",":100",625+x,305,n)
    id.sKit[7][n]=tfm.exec.addImage("1745fb9155a.png",":100",745+x,305,n)
    ui.addTextArea(205,"<a href='event:closeKits'>\n\n\n\n\n\n\n\n\n\n",n,750+x,307,15,15,0x0,0x0,0,true) 

    if page==1 then
        id.sKit[2][n]=tfm.exec.addImage(kits[41].img..".png",":100",650+x,365-24,n)
        id.sKit[3][n]=tfm.exec.addImage(kits[42].img..".png",":100",720+x,365-24,n)
        id.sKit[4][n]=tfm.exec.addImage("17428502c2a.png",":100",640+x,400-24,n)
        id.sKit[5][n]=tfm.exec.addImage("17428502c2a.png",":100",710+x,400-24,n)
        id.sKit[6][n]=tfm.exec.addImage("17428506658.png",":100",625+x,327-24,n)

        ui.addTextArea(200,"<a href='event:nextKit'>\n\n\n\n\n\n\n\n\n\n",n,778+x,363-24,15,17,0x0,0x0,0,true) 
        ui.addTextArea(201,data[n][41] > 0 and "<a href='event:use_41'>\n\n\n\n\n\n\n\n\n\n" or "",n,653+x,365-24,50,50,0x0,0x0,0,true)
        ui.addTextArea(202,data[n][42] > 0 and "<a href='event:use_42'>\n\n\n\n\n\n\n\n\n\n" or "",n,723+x,365-24,50,50,0x0,0x0,0,true)
        ui.addTextArea(203,"<b><font color='#4B1406'>"..data[n][41].."X",n,642+x,402-24,30,20,0x0,0x0,0,true)
        ui.addTextArea(204,"<b><font color='#4B1406'>"..data[n][42].."X",n,712+x,402-24,30,20,0x0,0x0,0,true)
    else
        id.sKit[2][n]=tfm.exec.addImage(kits[43].img..".png",":100",650+x,365-24,n)
        id.sKit[3][n]=tfm.exec.addImage(kits[44].img..".png",":100",720+x,365-24,n)
        id.sKit[4][n]=tfm.exec.addImage("17428502c2a.png",":100",640+x,400-24,n)
        id.sKit[5][n]=tfm.exec.addImage("17428502c2a.png",":100",710+x,400-24,n)
        id.sKit[6][n]=tfm.exec.addImage("17428508350.png",":100",625+x,327-24,n)


        ui.addTextArea(200,"<a href='event:preKit'>\n\n\n\n\n\n\n\n\n\n",n,631+x,363-24,15,17,0x0,0x0,0,true)
        ui.addTextArea(201,data[n][43] > 0 and "<a href='event:use_43'>\n\n\n\n\n\n\n\n\n\n" or "",n,653+x,365-24,50,50,0x0,0x0,0,true)
        ui.addTextArea(202,data[n][44] > 0 and "<a href='event:use_44'>\n\n\n\n\n\n\n\n\n\n" or "",n,723+x,365-24,50,50,0x0,0x0,0,true)
        ui.addTextArea(203,"<b><font color='#4B1406'>"..data[n][43].."X",n,642+x,402-24,30,20,0x0,0x0,0,true)
        ui.addTextArea(204,"<b><font color='#4B1406'>"..data[n][44].."X",n,712+x,402-24,30,20,0x0,0x0,0,true)
    end
end

function ms.closeKits(n)
    for i=200,205 do
        ui.removeTextArea(i,n)
    end
    for i=1,7 do
        if id.sKit[i][n] then tfm.exec.removeImage(id.sKit[i][n],n) id.sKit[i][n]=nil end
    end
end
--[[ End of file menus/kitsMenu.lua ]]--
--[[ File menus/leaderboard.lua ]]--
function ms.openRank(n,page,global)
    if data[n][3]==1 then
        local names=""
        local wins=""
        local ids=""
        local damage=""
        local lbCommus={}
        if global then
            local page=p[n].globalPage*10
            for i=page-9,page do
                local player=lb_gbPl[i]
                local playerName=mini(player,8,"#d480bb")
                names=names..playerName.."\n"
                wins=wins.."<font color='#8fd032'>"..gbPl[player][2].."</ROSE>\n"
                damage=gbPl[player][3]==0 and damage.."<font color='#d23c2c'>"..gbPl[player][2]*5 .."<font color='#d23c2c'>\n" or damage.."<font color='#d23c2c'>"..gbPl[player][3].."\n"
                ids=ids.."<font color='#b47538'>#</font><J>"..i.."</J>\n"
                lbCommus[#lbCommus+1]=gbPl[player][1]
            end
        else
            p_B=page*10
            p_A=p_B-9
            lbData=ms.rankPlayers()
            if #lbData < p_B then
                p_B=#lbData
            end
            for a=p_A,p_B do
                names=names..""..tostring(mini(lbData[a][1],8,"#d480bb")).."\n"
                wins=wins.."<font color='#8fd032'>"..tostring(lbData[a][2]).."</ROSE>\n"
                damage=damage.."<font color='#d23c2c'>"..data[lbData[a][1]][7].."</R>\n"
                ids=ids.."<font color='#b47538'>#</font><J>"..a.."</J>\n"
                lbCommus[#lbCommus+1]=data[lbData[a][1]][31]
            end
            if math.ceil(#lbData/10) == 0 then
                npage=1
            else
                npage=math.ceil(#lbData/10)
            end
        end
        id.lb[11][n]=tfm.exec.addImage("173e9663175.png",":100",162,40,n)
        if (global and p[n].globalPage > 1) or (not global and p[n].lbPage > 1) then
            id.lb[12][n]=tfm.exec.addImage("173e9700861.png",":100",162,10,n) --prev
            local prevButt=global and "prevGlobal" or "prevLeader"
            ui.addTextArea(113, "<a href='event:"..prevButt.."'>\n\n\n\n\n\n\n\n", n, 313, 363, 27, 27, 0x0, 0x0, 0, true)
        end
        if (global and p[n].globalPage~=5) or (not global and p[n].lbPage~=npage) then
            id.lb[13][n]=tfm.exec.addImage("173e96fd280.png",":100",162,10,n) --next
            local nexButt=global and "nextGlobal" or "nextLeader"
            ui.addTextArea(112, "<a href='event:"..nexButt.."'>\n\n\n\n\n\n\n\n", n, 454, 363, 27, 27, 0x0, 0x0, 0, true)
        end
        id.lb[14][n]=tfm.exec.addImage("173e9703227.png",":100",162,10,n) --close
        ui.addTextArea(111, "<a href='event:close'>\n\n\n\n\n\n\n\n", n, 383, 363, 27, 27, 0x0, 0x0, 0, true)
        ui.addTextArea(110, global and "<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:roomLeader'>"..text[n].leaderRoom.."</a></p>" or "<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:globalLeader'>"..text[n].leaderGlobal.."</a></p>", n, 225, 60, 100, 100, 0x0, 0x0, 0, true)
        ui.addTextArea(100, "<p align='center'>"..names, n, 235, 200, 140, 150, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(101, "<p align='center'>"..ids, n, 190, 200, 30, 150, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(102, "<p align='center'>"..wins, n, 390, 200, 50, 150, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(103, "<p align='center'>"..damage, n, 455, 200, 70, 150, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(104, "", n, 540, 200, 70, 150, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(105, "<p align='center'><font color='#b47538'>#</font><J>X</J>", n, 190, 165, 30, 20, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(106, "<p align='center'>"..text[n].name, n, 235, 165, 140, 20, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(107, "<p align='center'><font color='#8fd032'>"..text[n].winsB, n, 390, 165, 50, 20, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(108, "<p align='center'><font color='#d23c2c'>Damage", n, 455, 165, 70, 20, 0x613f24, 0x613f24, 1, true)
        ui.addTextArea(109, "<p align='center'><font color='#4572e3'>"..text[n].commu, n, 540, 165, 70, 20, 0x613f24, 0x613f24, 1, true)
        local Y=206
        for i=1,#lbCommus do
            if commus[lbCommus[i]] then
                if commus[lbCommus[i]]~=nil then
                    id.lb[i][n]=tfm.exec.addImage(commus[lbCommus[i]]..".png","&999",567,Y,n)
                else
                    id.lb[i][n]=tfm.exec.addImage(commus.en..".png","&999",567,Y,n)
                end
            end
            Y=Y+13.5
        end
    else
        tfm.exec.chatMessage("<R>"..text[n].wrong,n)
    end
end
--[[ End of file menus/leaderboard.lua ]]--
--[[ File menus/profile.lua ]]--
function mini(pr,size,color)
    return pr:sub(0,1)=="*" and (pr:len() > 12 and ""..pr:sub(0,12).."</font>.." or ""..pr.."</font>") or pr:len()-5 > 12 and ""..pr:sub(0,12).."</font><font color='"..color.."'>..</font><font size='"..size.."' color='"..color.."'>"..pr:sub(-5).."</font>" or ""..pr:sub(1,pr:len()-5).."</font><font size='"..size.."' color='"..color.."'>"..pr:sub(-5).."</font>"
end

function ms.openProfile(n,pr,events,sett)
    if data[n][3]==1 then
        id.profile[1][n]=tfm.exec.addImage("173cbaf28f3.png",":100",175,50,n)
        id.profile[2][n]=tfm.exec.addImage(data[pr][2]=="h" and "173cbaf4021.png" or "173cbaf5633.png",":101",175,50,n)
        id.profile[3][n]=tfm.exec.addImage(roles[data[pr][4]].icon..".png",":102",500,75,n)
        id.profile[4][n]=tfm.exec.addImage("173e832f195.png",":102",175,50,n)
        id.profile[5][n]=tfm.exec.addImage("173e8330927.png",":102",175,50,n==pr and n or "NONE")
        local d=data[pr]
        local t=text[n]
        local col=d[2]=="h" and '#6266FD' or '#FD6262' 
        if events then
            ui.addTextArea(100,"<font color='#040028' size='12' face='Lucida console'><b><p align='left'>\n"..t.events[1]..": <VP>"..d[32].."</VP>\n\n"..t.events[2]..": <VP>"..d[36].."</VP>\n\n"..t.events[3]..": <VP>"..d[39],n,230,112,380,210,0x0,0x0,0,true)
            ui.addTextArea(103,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:info_"..pr.."'>"..text[n].info,n,438,340,150,100,0x0,0x0,0,true)
            ui.addTextArea(104,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:sett'>"..text[n].sett,n==pr and n or "none",314,340,150,100,0x0,0x0,0,true)
        elseif sett then
            ui.addTextArea(103,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:events_"..pr.."'>"..text[n].eve,n,438,340,150,100,0x0,0x0,0,true)
            ui.addTextArea(104,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:info_"..pr.."'>"..text[n].info,n,314,340,150,100,0x0,0x0,0,true)
            local lang=p[n].lang:upper()
            ui.addTextArea(100,"<font color='#040028' size='12' face='Lucida console'><b><p align='left'>\n"..t.settings[1].."\n\n\n"..t.settings[3]..": ["..lang.."]\n\n\n<a href='event:change_team'>"..t.settings[4].."</a>\n<a href='event:change_role'>"..t.settings[5].."</a>",n,230,112,380,210,0x0,0x0,0,true)
            ui.addToggle(105,n,520,128,data[n][46]==1,"icons")
        else
            ui.addTextArea(100,"<font color='#040028' size='12' face='Lucida console'><b><p align='left'>"..t.wins[1]..": <font color='#FF6347'>"..d[6].."</font>\n"..t.damage..": <font color='#8B0000'>"..d[7].."</font>\n\n"..t.wins[2]..": <font color='#FF0000'>"..d.wa.."</font>\n"..t.wins[3]..": <font color='#0000CD'>"..d.wp.."</font>\n"..t.wins[4]..": <font color='#008000'>"..d.whe.."</font>\n"..t.wins[5]..": <font color='#8B008B'>"..d.ww.."</font>\n"..t.wins[6]..": <font color='#6B8E23'>"..d.wc.."</font>\n"..t.wins[7]..": <font color='#00CED1'>"..d.wi.."</font>\n\n"..t.wins[8]..": <font color='#800000'>"..d.wm.."</font>\n"..t.wins[9]..": <font color='#696969'>"..d.we,n,230,112,380,210,0x0,0x0,0,true)
            ui.addTextArea(103,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:events_"..pr.."'>"..text[n].eve,n,438,340,150,100,0x0,0x0,0,true)
            ui.addTextArea(104,"<p align='center'><font color='#040028' size='20' face='Lucida console'><b><a href='event:sett'>"..text[n].sett,n==pr and n or "none",314,340,150,100,0x0,0x0,0,true)
        end
        ui.addTextArea(101, "<a href='event:close'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 195, 62, 35, 35, 0 ,0, 0, true)
        ui.addTextArea(102, "<p align='center'><b><font size='22' face='Lucida console' color='"..col.."'>"..mini(pr,12,col), n, 245, 68, 225, 30, 0 ,0, 0, true)
    else
        tfm.exec.chatMessage("<R>"..text[n].wrong,n)
    end
end

function ms.changeThing(n,toChange)
    ui.removeTextArea(100,n)
    for i=105,115 do
        ui.removeTextArea(i,n)
    end
    id.profile[6][n]=tfm.exec.addImage("173f42b4751.png",":103",228,95,n)
    local cost=toChange=="team" and 20 or 10
    ui.addTextArea(105,string.format(text[n].change,text[n][toChange],cost,data[n][40]),n,320,165,200,100,0,0,0,true)
    ui.addTextArea(106,"<a href='event:yes_"..toChange.."'>\n\n\n\n\n\n\n\n\n\n\n\n",n,367,264,40,30,0,0,0,true)
    ui.addTextArea(107,"<a href='event:no'>\n\n\n\n\n\n\n\n\n\n\n\n",n,430,264,40,30,0,0,0,true)
end
--[[ End of file menus/profile.lua ]]--
--[[ File menus/shop.lua ]]--
function ms.openShop(n,cnns,kits,shield)
    if data[n][3]==1 then
        if cnns then
            ui.addTextArea(112, "<a href='event:edit_8_+'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 444, 219, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(113, "<a href='event:edit_8_D'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 548, 222, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(114, "<a href='event:edit_8_-'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 521, 222, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(115, "<a href='event:edit_9_-'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 590, 167, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(116, "<a href='event:edit_9_D'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 590, 194, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(117, "<a href='event:edit_9_+'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 590, 90, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(118, "<p align='center'><b><font color='#52902d'>X: "..data[n][8], n, 464, 219, 50, 30, 0 ,0, 0, true)
            ui.addTextArea(119, "<p align='center'><b><font color='#52902d'>Y:\n"..data[n][9], n, 580, 120, 30, 50, 0 ,0, 0, true)
            local cnn=p[n].cnnSub
            local page=p[n].cnnPage
            id.shop[1][n]=tfm.exec.addImage("173d9c10b1f.png", ":100", 158, 35, n)
            id.shop[14][n]=tfm.exec.addImage("17520eddbfb.png", ":100", 158, 35, n) --1745fb9ef30

            local v=p[n].cnn==0 and cannons[p[n].usedCnn] or cannons[p[n].cnn]
            id.shop[11][n]=tfm.exec.addImage(v.inShop..".png",":100",460+(data[n][8]+20+(v.xp and v.xp or 0)),100+(data[n][9]+20+(v.yp and v.yp or 0)), n) --Cannon
            id.shop[12][n]=tfm.exec.addImage("15fa9a33e5f.png",":100",460,100,n) --Mouse

            ui.addTextArea(122, "<a href='event:close'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 587, 64, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(123, "<a href='event:kiShop'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 611, 132, 30, 30, 0 ,0, 0, true)
            --ui.addTextArea(124, "<a href='event:shieldShop'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 611, 177, 30, 30, 0 ,0, 0, true)

            ui.addTextArea(101, page==1 and "" or "<a href='event:prev'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 165, 254, 21, 32, 0 ,0, 0, true)
            ui.addTextArea(102, page>=#cannons/9 and "" or "<a href='event:next'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 421, 255, 21, 21, 0 ,0, 0, true)

            ui.addTextArea(103, "<a href='event:cnn_"..cnn[1].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 205, 95, 50, 50, 0 ,0, 0, true)
            ui.addTextArea(104, "<a href='event:cnn_"..cnn[2].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 275, 95, 50, 50, 0 ,0, 0, true)
            ui.addTextArea(105, "<a href='event:cnn_"..cnn[3].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 345, 95, 50, 50, 0 ,0, 0, true)
            id.shop[2][n]=tfm.exec.addImage(cannons[cnn[1]].inShop..".png", ":101", 180+((50-(cannons[cnn[1]].xs and cannons[cnn[1]].xs or 35)/2)), 70+((50-(cannons[cnn[1]].ys and cannons[cnn[1]].ys or 35)/2)), n)
            id.shop[3][n]=tfm.exec.addImage(cannons[cnn[2]].inShop..".png", ":102", 250+((50-(cannons[cnn[2]].xs and cannons[cnn[2]].xs or 35)/2)), 70+((50-(cannons[cnn[2]].ys and cannons[cnn[2]].ys or 35)/2)), n)
            id.shop[4][n]=tfm.exec.addImage(cannons[cnn[3]].inShop..".png", ":103", 320+((50-(cannons[cnn[3]].xs and cannons[cnn[3]].xs or 35)/2)), 70+((50-(cannons[cnn[3]].ys and cannons[cnn[3]].ys or 35)/2)), n)

            if cannons[cnn[4]] then
                ui.addTextArea(106, "<a href='event:cnn_"..cnn[4].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 205, 170, 50, 50, 0 ,0, 0, true)
                ui.addTextArea(107, "<a href='event:cnn_"..cnn[5].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 275, 170, 50, 50, 0 ,0, 0, true)
                ui.addTextArea(108, "<a href='event:cnn_"..cnn[6].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 345, 170, 50, 50, 0 ,0, 0, true)
                id.shop[5][n]=tfm.exec.addImage(cannons[cnn[4]].inShop..".png", ":104", 180+((50-(cannons[cnn[4]].xs and cannons[cnn[4]].xs or 35)/2)), 145+((50-(cannons[cnn[4]].ys and cannons[cnn[4]].ys or 35)/2)), n)
                id.shop[6][n]=tfm.exec.addImage(cannons[cnn[5]].inShop..".png", ":105", 250+((50-(cannons[cnn[5]].xs and cannons[cnn[5]].xs or 35)/2)), 145+((50-(cannons[cnn[5]].ys and cannons[cnn[5]].ys or 35)/2)), n)
                id.shop[7][n]=tfm.exec.addImage(cannons[cnn[6]].inShop..".png", ":106", 320+((50-(cannons[cnn[6]].xs and cannons[cnn[6]].xs or 35)/2)), 145+((50-(cannons[cnn[6]].ys and cannons[cnn[6]].ys or 35)/2)), n)
            end

            if cannons[cnn[7]] then
                ui.addTextArea(109, "<a href='event:cnn_"..cnn[7].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 205, 245, 50, 50, 0 ,0, 0, true)
                ui.addTextArea(110, "<a href='event:cnn_"..cnn[8].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 275, 245, 50, 50, 0 ,0, 0, true)
                ui.addTextArea(111, "<a href='event:cnn_"..cnn[9].."'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 345, 245, 50, 50, 0 ,0, 0, true)
                id.shop[8][n]=tfm.exec.addImage(cannons[cnn[7]].inShop..".png", ":107", 180+((50-(cannons[cnn[7]].xs and cannons[cnn[7]].xs or 35)/2)), 220+((50-(cannons[cnn[7]].ys and cannons[cnn[7]].ys or 35)/2)), n)
                id.shop[9][n]=tfm.exec.addImage(cannons[cnn[8]].inShop..".png", ":108", 250+((50-(cannons[cnn[8]].xs and cannons[cnn[8]].xs or 35)/2)), 220+((50-(cannons[cnn[8]].ys and cannons[cnn[8]].ys or 35)/2)), n)
                id.shop[10][n]=tfm.exec.addImage(cannons[cnn[9]].inShop..".png", ":109", 320+((50-(cannons[cnn[9]].xs and cannons[cnn[9]].xs or 35)/2)), 220+((50-(cannons[cnn[9]].ys and cannons[cnn[9]].ys or 35)/2)), n)
            end

        end
        
        if shield then
        end
        
        if kits then
            id.shop[1][n]=tfm.exec.addImage("1742779311c.png",":100",158,85-50,n)
            id.shop[2][n]=tfm.exec.addImage("17520edba13.png",":100",158,85-50,n) --1745fba3b9c

            id.shop[3][n]=tfm.exec.addImage("17427798f8b.png",":100",204,141-50,n) --speed
            id.shop[4][n]=tfm.exec.addImage("17427796adb.png",":100",270,141-50,n) --spirit
            id.shop[5][n]=tfm.exec.addImage("1742779ac77.png",":100",336,141-50,n) --jump
            id.shop[6][n]=tfm.exec.addImage("1742778d002.png",":100",204,226-50,n) --bomb
            ui.addTextArea(100, "<a href='event:close'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 545, 95-50, 15, 15, 0 ,0, 0, true)
            ui.addTextArea(101, "<a href='event:oriShop'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 579, 131-50, 30, 30, 0 ,0, 0, true)
            --ui.addTextArea(102, "<a href='event:shieldShop'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 579, 218-50, 30, 30, 0 ,0, 0, true)

            ui.addTextArea(103, "<a href='event:kit_41'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 211, 146-50, 40, 40, 0 ,0, 0, true)
            ui.addTextArea(104, "<a href='event:kit_42'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 277, 146-50, 40, 40, 0 ,0, 0, true)
            ui.addTextArea(105, "<a href='event:kit_43'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 343, 146-50, 40, 40, 0 ,0, 0, true)
            ui.addTextArea(106, "<a href='event:kit_44'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 211, 231-50, 40, 40, 0 ,0, 0, true)

        end
    else
        tfm.exec.chatMessage("<R>"..text[n].wrong,n)
    end
end
--[[ End of file menus/shop.lua ]]--
--[[ File menus/teamsRoles.lua ]]--
function ms.openTeams(n)
    id.teams[1][n]=tfm.exec.addImage("173fe652833.png",":100",0,0,n)
    ui.addTextArea(5, "<p align='center'><b><font size='20' color='#14004a'>"..text[n].h, n, 497, 200, 160, 30, 0x0, 0x0, 0, true)
    ui.addTextArea(7, "<a href='event:h'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 497, 200, 160, 30, 0x0, 0x0, 0, true)
    ui.addTextArea(6, "<p align='center'><b><font size='20' color='#4a0000'>"..text[n].v, n, 147, 200, 160, 30, 0x0, 0x0, 0, true)
    ui.addTextArea(8, "<a href='event:v'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 147, 200, 160, 30, 0x0, 0x0, 0, true)
end

function ms.openRoles(n)
    id.teams[1][n]=tfm.exec.addImage("173fe3e582f.png",":100",260,100,n)
    ui.addTextArea(23, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.a, n, 280, 121, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(5, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.a, n, 279, 120, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(24, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.p, n, 280, 185, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(6, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.p, n, 279, 184, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(25, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.he, n, 280, 249, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(7, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.he, n, 279, 248, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(26, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.w, n, 428, 121, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(8, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.w, n, 427, 120, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(27, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.c, n, 428, 185, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(9, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.c, n, 427, 184, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(28, "<p align='center'><b><font size='15' color='#000000'>"..text[n].roles.i, n, 428, 249, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(10, "<p align='center'><b><font size='15' color='#311d13'><D>"..text[n].roles.i, n, 427, 248, 100, 25, 0x0, 0x0, 0, true)

    ui.addTextArea(17, "<p align='center'><b><a href='event:a'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 279, 120, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(18, "<p align='center'><b><a href='event:p'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 279, 184, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(19, "<p align='center'><b><a href='event:he'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 279, 248, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(20, "<p align='center'><b><a href='event:w'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 427, 120, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(21, "<p align='center'><b><a href='event:c'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 427, 184, 100, 25, 0x0, 0x0, 0, true)
    ui.addTextArea(22, "<p align='center'><b><a href='event:i'>\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", n, 427, 248, 100, 25, 0x0, 0x0, 0, true)

    ui.addTextArea(11, "<a href='event:roleHelp_a'>\n\n\n\n\n\n\n\n\n\n\n", n, 364, 149, 15, 15, 0x0, 0x0, 0, true)
    ui.addTextArea(12, "<a href='event:roleHelp_p'>\n\n\n\n\n\n\n\n\n\n\n", n, 364, 214, 15, 15, 0x0, 0x0, 0, true)
    ui.addTextArea(13, "<a href='event:roleHelp_he'>\n\n\n\n\n\n\n\n\n\n\n", n, 364, 279, 15, 15, 0x0, 0x0, 0, true)
    ui.addTextArea(14, "<a href='event:roleHelp_w'>\n\n\n\n\n\n\n\n\n\n\n", n, 512, 149, 15, 15, 0x0, 0x0, 0, true)
    ui.addTextArea(15, "<a href='event:roleHelp_c'>\n\n\n\n\n\n\n\n\n\n\n", n, 512, 214, 15, 15, 0x0, 0x0, 0, true)
    ui.addTextArea(16, "<a href='event:roleHelp_i'>\n\n\n\n\n\n\n\n\n\n\n", n, 512, 279, 15, 15, 0x0, 0x0, 0, true)

end
--[[ End of file menus/teamsRoles.lua ]]--
--[[ End of directory menus ]]--
--[[ Directory events ]]--
--[[ File events/eventChatCommand.lua ]]--
local c={"month","map","shop","rank","leaderboard","ranking","profile","pr","p","profil","pw","off","lang"}
function eventChatCommand(n,cmd)
    local c={}
    for i in string.gmatch(cmd,'[^%s]+') do
        table.insert(c,i)
    end
    c[1]=string.lower(c[1])
    if n=="Bodykudo#0000" then
        if c[1]=="map" then
            if c[2] then
                if c[2]:sub(0,1)=="@" then
                    local id=0
                    for i,v in pairs(maps) do
                        if c[2]==v.code then
                            id=i
                        end
                    end
                    if id~=0 then
                        rounds=4
                        ms.removeMapImages()
                        ms.newMap(id)
                    else
                        ms.removeMapImages()
                        tfm.exec.newGame(c[2])
                    end
                elseif c[2]:sub(0,1)=="#" and tonumber(c[2]:sub(2)) then
                    if maps[tonumber(c[2]:sub(2))] then
                        rounds=4
                        ms.removeMapImages()
                        ms.newMap(tonumber(c[2]:sub(2)))
                    end
                elseif (c[2]:sub(0,1)=="M" or c[2]:sub(0,1)=="m") and tonumber(c[2]:sub(2)) then
                    local cate=tonumber(c[2]:sub(2))
                    if cate <= 8 then
                        if cate~=5 then
                            rounds=4
                            local id=math.random(#mapCats[cate])
                            ms.removeMapImages()
                            ms.newMap(mapCats[cate][id])
                        else
                            rounds=5
                            ms.removeMapImages()
                            ms.newMap()
                        end
                    end
                end
            else
                ms.newGame()
            end
        elseif c[1]=="exit" then
            system.exit()
        elseif c[1]=="pw" then
            if c[2] then
                tfm.exec.setRoomPassword(cmd:sub(c[1]:len()+2))
                tfm.exec.chatMessage("pw: "..cmd:sub(c[1]:len()+2),n)
            else
                tfm.exec.setRoomPassword("")
            end
        elseif c[1]=="month" and c[2] and tonumber(c[2]) then
            month=tonumber(c[2])
        end
    end
    if c[1]=="lang" and c[2] then
        text[n]=translations[c[2]] or text[n]
        p[n].lang=translations[c[2]] and c[2] or (translations[c[2]] and c[2] or p[n].translations)
    elseif c[1]=="donate" then
        tfm.exec.chatMessage("<ROSE>"..links.donate.."</ROSE>",n)
    elseif c[1]=="off" and c[2] and c[3] and tonumber(c[2]) and tonumber(c[3]) and (tonumber(c[2]) <= 25 and  tonumber(c[2]) >= -25) and (tonumber(c[3]) <= 25 and  tonumber(c[3]) >= -25) then
            data[n][8]=tonumber(c[2])
            data[n][9]=tonumber(c[3])
            tfm.exec.chatMessage(string.format(text[n].changed,tonumber(c[2]),tonumber(c[3])),n)
            saveData(n)
    elseif c[1]=="c" and c[2] and data[n][3]==1 then
        for i in pairs(teams[data[n][2]].inRoomMembers) do
            local p=n:find("#") and "<BV>"..n:sub(1, n:len()-5).."</BV><font color='#606090' size='10'><V>"..n:sub(-5).."</V></font>"
            tfm.exec.chatMessage("<BL>(</BL>"..p.."<BL>)</BL> <font color='#"..teams[data[n][2]].color2.."'>".. cmd:sub(c[1]:len()+2) .."",i)
        end
    elseif c[1]=="shop" then
        ms.close(n)
        p[n].cnn=0
        p[n].cnnPage=1
        p[n].cnnSub={1,2,3,4,5,6,7,8,9}
        p[n].opened="openShop"
        ms.openShop(n,true,false,false)
    elseif c[1]=="rank" or c[1]=="leaderboard" or c[1]=="ranking" then
        ms.close(n)
        p[n].lbPage=1
        p[n].globalPage=1
        p[n].opened="openRank"
        ms.openRank(n,1,false)
    elseif c[1]=="help" then
        p[n].opened="openHelp"
        ms.close(n)
        ms.openHelp(n,"help")
    elseif c[1]=="profile" or c[1]=="profil" or c[1]=="pr" or c[1]=="p" then
        if c[2] then
            local P=string.gsub(c[2]:lower(),"%a",string.upper,1)
            if data[P] and data[P][3]==1 and tfm.get.room.playerList[P] then
                p[n].opened="openProfile"
                ms.close(n)
                ms.openProfile(n,P,false,false)
            end
        else
            p[n].opened="openProfile"
            ms.close(n)
            ms.openProfile(n,n,false,false)
        end
	end
end

for i=1,#c do
    system.disableChatCommandDisplay(c[i],true)
end
--[[ End of file events/eventChatCommand.lua ]]--
--[[ File events/eventKeyboard.lua ]]--
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
--[[ End of file events/eventKeyboard.lua ]]--
--[[ File events/eventLoop.lua ]]--
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
--[[ End of file events/eventLoop.lua ]]--
--[[ File events/eventNewGame.lua ]]--
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
--[[ End of file events/eventNewGame.lua ]]--
--[[ File events/eventNewPlayer.lua ]]--
function eventNewPlayer(n)
    ms.setLang(n)
    if not data[n] then
        data[n]={
            [1]=0, --1 InTeam
            [2]="", --2 Team
            [3]=0, --3   HasRole
            [4]="", --4 Role
            [6]=0, --6 Wins
            [7]=0, --7 Damage
            [8]=10, --8 X
            [9]=0, --9 Y
            [10]=1, --10 Cannon
            [31]=tfm.get.room.playerList[n].community, --Commu
            [32]=0, --Halloween
            [35]=1, --Shield
            [36]=0, --AvD
            [39]=0, --Gems
			[40]=15, --Coins
			[41]=0, --speedKits
			[42]=0, --jumpKits
			[43]=0, --spiritKits
            [44]=0, --bombKits
            [45]="", --RandomCannons
            [46]=1, --ICONS
            wa=0,
            wp=0,
            whe=0,
            ww=0,
            wc=0,
            wm=0,
            wi=0,
			we=0
        }
        system.loadPlayerData(n)
    end
    if data[n][1]==0 then
		tfm.exec.chatMessage(text[n].welcome.."\n<J>"..text[n].donate.."</J>\n<J>"..text[n].submit.." <ROSE>"..links.maps.."</ROSE>\n<J>"..text[n].discord.."</J> <ROSE>"..links.discord.."</ROSE>",n)
        ms.openTeams(n)
    else
        if data[n][3]==1 then
            ms.editTeam(n,1,nil,true)
            tfm.exec.chatMessage("<J>"..text[n].donate.."</J>\n<J>"..text[n].submit.." <ROSE>"..links.maps.."</ROSE>\n<J>"..text[n].discord.."</J> <ROSE>"..links.discord.."</ROSE>",n)
        else
            tfm.exec.chatMessage(text[n].welcome.."\n<J>"..text[n].donate.."</J>\n<J>"..text[n].submit.." <ROSE>"..links.maps.."</ROSE>\n<J>"..text[n].discord.."</J> <ROSE>"..links.discord.."</ROSE>",n)
			ms.openRoles(n)
        end
    end
    if not p[n] then
        p[n]={
            timeToOpen=os.time(),
            aligned=tfm.get.room.playerList[n].community=="ar" and "right" or "left",
            opened="",
            cnn=0,
            usedCnn=1,
			timeToKit=os.time(),
			timeToJump=os.time(),
			eq_doubleSpeed=false,
			eq_highJump=false,
			eq_spirit=false,
			eq_bomb=false,
            kit=0,
            tKits=0,
			skillImg=false,
			afk=true,
			trapped=false,
			stopped=false,
			shPage=1,
			shSub={1,2,3},
			lbPage=1,
			globalPage=1,
			angle2=180,
			right=false,
			isHolding=false,
			icons=true,
			timetoshoot=os.time(),
			power=0,
			HPpower=0,
			objectid=0,
			r=0,
			cnnPage=1,
			cnnSub={1,2,3,4,5,6,7,8,9},
			angle=90,
			shop=false,
			timeToSkill=os.time(),
            timetohold=os.time(),
            lang=translations[tfm.get.room.playerList[n].community] and tfm.get.room.playerList[n].community or "en",
            hasGem=false
		}
    end
    for k=0,100 do
        system.bindKeyboard(n,k,true,true)
    end
    system.bindKeyboard(n,32,false,true)
    system.bindMouse(n,true)
    if play and teams["h"].hp > 0 and teams["v"].hp > 0 and cat~=5 then
        ms.hpBar(n)
		id.bar[1][n]=tfm.exec.addImage("173aa781642.png","&1",685,23,n)
		id.bar[2][n]=tfm.exec.addImage("173aa780072.png","&2",0,23,n)
    end 
    if tfm.get.room.currentMap=="@7796992" then
        tfm.exec.respawnPlayer(n)
        if lobbyImg then tfm.exec.removeImage(lobbyImg) end
        lobbyImg=tfm.exec.addImage("17574daaa75.png","?666",0,0)
        if data[n][3]==1 then
            tfm.exec.movePlayer(n,teams[data[n][2]].lbx,teams[data[n][2]].lby)
        end
    end
    ui.addTimerImage("175363c2641",-80,50,n,5)
end
--[[ End of file events/eventNewPlayer.lua ]]--
--[[ File events/eventPlayerDied.lua ]]--
function eventPlayerDied(n)
    p[n].isHolding=false
    saveData(n)
    ms.closeKits(n)
    if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
	if id.kit[n] then tfm.exec.removeImage(id.kit[n],n) id.kit[n]=nil end
    if play and map~="@7796992" then
        if data[n][1]==1 and data[n][3]==1 then
            ui.removeTextArea(4,n)
            if started and not p[n].afk then
                teams[data[n][2]].hp=teams[data[n][2]].hp-math.ceil(100/teams[data[n][2]].ig)
            end
            if not teams[data[n][2]].isWinner and teams[data[n][2]].hp > 0 and cat~=5 and not auto then
                ms.hpBar(nil)
            end
        end
        local t={h=0,v=0}
        for n in pairs(tfm.get.room.playerList) do
            if not tfm.get.room.playerList[n].isDead and data[n][1]==1 and data[n][3]==1 then
                t[data[n][2]]=t[data[n][2]]+1
            end
        end
        if t["h"]==0 and cat~=5 and not teamWon then
			if winImg then tfm.exec.removeImage(winImg) end
			teamWon=true
            teams["v"].isWinner=true
            tfm.exec.setGameTime(10)
            winImg=tfm.exec.addImage("174605f6988.png",":666",0,0)
            local speaker=charsList.v[math.random(#charsList.v)]
            for k in pairs(tfm.get.room.playerList) do
                tfm.exec.chatMessage("<V>["..chars.v[speaker].."]</V> <N>"..text[k].messages.v[speaker][math.random(#text[k].messages.v)],k)
            end
        elseif t["v"]==0 and cat~=5 and not teamWon then
			if winImg then tfm.exec.removeImage(winImg) end
			teamWon=true
            teams["h"].isWinner=true
            tfm.exec.setGameTime(10)
            winImg=tfm.exec.addImage("174605fb453.png",":666",0,0)
            local speaker=charsList.h[math.random(#charsList.h)]
            for k in pairs(tfm.get.room.playerList) do
                tfm.exec.chatMessage("<V>["..chars.h[speaker].."]</V> <N>"..text[k].messages.h[speaker][math.random(#text[k].messages.h)],k)
            end
        end
    end
    ms.toStart()
end
--[[ End of file events/eventPlayerDied.lua ]]--
--[[ File events/eventPlayerLeft.lua ]]--
function eventPlayerLeft(n)
    if data[n][1]==1 and data[n][3]==1 then
        ms.editTeam(n,-1,true,nil)
    end
end
--[[ End of file events/eventPlayerLeft.lua ]]--
--[[ File events/eventPlayerWon.lua ]]--
function eventPlayerWon(n)
    tfm.exec.setPlayerScore(n,5,true)
    ms.closeKits(n)
    if inRoomModule and table.count(teams["h"].inRoomMembers) > 2 and table.count(teams["v"].inRoomMembers) > 2 and tfm.get.room.uniquePlayers >= 6 then
		data[n][40]=data[n][40]+math.random(1,3)
		data[n][6]=data[n][6]+1
		if (month==months.halloween[1] or month==months.halloween[2]) and mapSet.halloween then
			data[n][32]=data[n][32]+1
        end
		if mapSet.canRetro then
			data[n].we=data[n].we+1
        end
        if mapSet.avd then
            data[n][36]=data[n][36]+1
        end
        if p[n].hasGem then
            data[n][39]=data[n][39]+1
        end
        if cat==5 then
            data[n].wm=data[n].wm+1
        else
			data[n]["w"..data[n][4]]=data[n]["w"..data[n][4]]+1
        end
    end
    p[n].isHolding=false
    saveData(n)
    ms.toStart()
end
--[[ End of file events/eventPlayerWon.lua ]]--
--[[ File events/eventTextAreaCallback.lua ]]--
--@4060984
local team=""
function eventTextAreaCallback(ids,n,cb)
    if teams[cb] then
        team=cb=="h" and "v" or "h"
        if table.count(teams[cb].inRoomMembers) > table.count(teams[team].inRoomMembers) then
            tfm.exec.chatMessage("<R>"..text[n].full,n)
        else
			ms.joinTeam(n,cb,1)
			for i=5,50 do
				ui.removeTextArea(i,n)
			end
			if id.teams[1][n] then tfm.exec.removeImage(id.teams[1][n],n) id.teams[1][n]=nil end
			if id.teams[2][n] then tfm.exec.removeImage(id.teams[2][n],n) id.teams[2][n]=nil end
			ms.openRoles(n)
        end
    elseif roles[cb] then
        tfm.exec.setNameColor(n,teams[data[n][2]].color)
        ms.joinTeam(n,data[n][2],1,1,cb,1,true,true)
        tfm.exec.movePlayer(n,teams[data[n][2]].lbx,teams[data[n][2]].lby)
        for i=5,50 do
            ui.removeTextArea(i,n)
        end
        if id.teams[1][n] then tfm.exec.removeImage(id.teams[1][n],n) id.teams[1][n]=nil end
        ms.close(n)
        p[n].opened="openHelp"
        ms.openHelp(n,"help")
    elseif string.sub(cb,0,8)=="roleHelp" then
        tfm.exec.chatMessage("<font color='#"..roles[string.sub(cb,10)].color.."'>"..text[n].rolesHelp[string.sub(cb,10)].."</font>",n)
    elseif cb=="close" then
        p[n].cnn=0
        p[n].cnnPage=1
        p[n].cnnSub={1,2,3,4,5,6,7,8,9}
        p[n].opened=""
        ms.close(n)
    elseif cb=="next" and p[n].cnnPage<#cannons/9 then
        p[n].cnn=0
        p[n].cnnPage=p[n].cnnPage+1
        for i=1,9 do
            p[n].cnnSub[i]=p[n].cnnSub[i]+9
        end
        ms.close(n)
        ms.openShop(n,true,false,false)
    elseif cb=="prev" and p[n].cnnPage~=1 then
        p[n].cnn=0
        p[n].cnnPage=p[n].cnnPage-1
        for i=1,9 do
            p[n].cnnSub[i]=p[n].cnnSub[i]-9
        end
        ms.close(n)
        ms.openShop(n,true,false,false)
    elseif cb=="nextKit" then
        ms.closeKits(n)
        ms.kits(n,2)
    elseif cb=="preKit" then
        ms.closeKits(n)
        ms.kits(n,1)
    elseif cb=="closeKits" then
        ms.closeKits(n)
    elseif string.sub(cb,0,3)=="use" then
        local idd=tonumber(string.sub(cb,5))
        ms.closeKits(n)
        p[n].kit=idd
        data[n][idd]=data[n][idd]-1
        saveData(n)
    elseif cb=="oriShop" then
        eventChatCommand(n,"shop")
    elseif cb=="kiShop" then
        ms.close(n)
        ms.openShop(n,false,true,false)
    elseif cb=="shieldShop" then
        tfm.exec.chatMessage("<R><b>"..text[n].soon.."</b></R>",n)
    elseif string.sub(cb,0,3)=="kit" then
        local idd=tonumber(string.sub(cb,5))
        if id.shop[7][n] then tfm.exec.removeImage(id.shop[7][n],n) id.shop[7][n]=nil end
        if id.shop[8][n] then tfm.exec.removeImage(id.shop[8][n],n) id.shop[8][n]=nil end
        id.shop[7][n]=tfm.exec.addImage(kits[idd].img..".png",":100",473,154-50,n)
        id.shop[8][n]=tfm.exec.addImage("1742778ecf2.png",":100",158,85-50,n)
        ui.addTextArea(107,""..data[n][40].."$\n"..kits[idd].price.."$\n"..data[n][idd].."X",n,435,125-50,70,50,0x0,0x0,0,true)
        ui.addTextArea(108, "<p align='center'><b><b><font color='#1e0519' face='Lucida console'><a href='event:buy_"..idd.."'>"..text[n].buy, n, 421,325-50, 95, 25, 0x0, 0x0, 0, true)
        ui.addTextArea(109, "<p align='left'><font size='10' color='#52902d' face='Lucida console'>"..text[n].kits[idd], n, 230, 322-50, 166, 45, 0 ,0, 0, true)
    elseif string.sub(cb,0,3)=="buy" then
        local idd=tonumber(string.sub(cb,5))
        if n=="Bodykudo#0000" then
            data[n][idd]=data[n][idd]+1
        else
            if data[n][40] >= kits[idd].price then
                if data[n][idd]==kits[idd].max then
                    tfm.exec.chatMessage("<R>"..text[n].maxEx,n)
                else
                    data[n][40]=data[n][40]-kits[idd].price
                    data[n][idd]=data[n][idd]+1
                    saveData(n)
                    ui.addTextArea(107,""..data[n][40].."$\n"..kits[idd].price.."$\n"..data[n][idd].."X",n,435,125-50,70,50,0x0,0x0,0,true)
                end
            else
                tfm.exec.chatMessage("<R>"..text[n].enough,n)
            end
        end
    elseif string.sub(cb,0,3)=="cnn" then
        local idd=tonumber(string.sub(cb,5,6))
        p[n].cnn=idd
        if id.shop[11][n] then tfm.exec.removeImage(id.shop[11][n],n) id.shop[11][n]=nil end
        if id.shop[12][n] then tfm.exec.removeImage(id.shop[12][n],n) id.shop[12][n]=nil end
        if id.shop[13][n] then tfm.exec.removeImage(id.shop[13][n],n) id.shop[13][n]=nil end
        local v=cannons[p[n].cnn]
        id.shop[11][n]=tfm.exec.addImage(v.inShop..".png",":100",460+(data[n][8]+20+(v.xp and v.xp or 0)),100+(data[n][9]+20+(v.yp and v.yp or 0)), n) --Cannon
        id.shop[12][n]=tfm.exec.addImage("15fa9a33e5f.png",":100",460,100,n) --Mouse
        id.shop[13][n]=tfm.exec.addImage("173d9c790c1.png",":100",158,35,n) --Quest and Equip]]
        if p[n].cnn==4 or p[n].cnn==5 or p[n].cnn==6 then
            ui.addTextArea(120, "<p align='left'><font size='10' color='#52902d' face='Lucida console'>"..string.format(text[n].quests[cannons[p[n].cnn].text],cannons[p[n].cnn].req,cannons[p[n].cnn].req), n, 230, 322, 166, 45, 0 ,0, 0, true)
        elseif p[n].cnn==1 or p[n].cnn==2 or p[n].cnn==3 then
            ui.addTextArea(120, "<p align='left'><font size='10' color='#52902d' face='Lucida console'>"..text[n].quests[cannons[p[n].cnn].text], n, 230, 322, 166, 45, 0 ,0, 0, true)
        else
            if data[n][cannons[p[n].cnn].toCounter] >= cannons[p[n].cnn].req then
                ui.addTextArea(120, "<p align='left'><font size='10' color='#52902d' face='Lucida console'>"..string.format(text[n].quests[cannons[p[n].cnn].text],cannons[p[n].cnn].req,text[n].roles[cannons[p[n].cnn][cannons[p[n].cnn].toFormat]]).."\n<font color='#ea944f'>"..data[n][cannons[p[n].cnn].toCounter].." / "..cannons[p[n].cnn].req, n, 230, 322, 166, 45, 0 ,0, 0, true)
            else
                ui.addTextArea(120, "<p align='left'><font size='10' color='#52902d' face='Lucida console'>"..string.format(text[n].quests[cannons[p[n].cnn].text],cannons[p[n].cnn].req,text[n].roles[cannons[p[n].cnn][cannons[p[n].cnn].toFormat]]).."\n<font color='#bb3426'>"..data[n][cannons[p[n].cnn].toCounter].." / "..cannons[p[n].cnn].req, n, 230, 322, 166, 45, 0 ,0, 0, true)
            end
        end
        textt=""
        if p[n].cnn==1 then
            textt="<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq
        elseif p[n].cnn==2 then
            textt=table.find(helpC,n) and "<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq or "<b><font color='#bb3426' face='Lucida console'><p align='center'>"..text[n].disabled
        elseif p[n].cnn==3 then
            textt=table.find(mapC,n) and "<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq or "<b><font color='#bb3426' face='Lucida console'><p align='center'>"..text[n].disabled
        elseif p[n].cnn==4 or p[n].cnn==5 or p[n].cnn==6 then
            textt=n==lb_gbPl[p[n].cnn-3] and "<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq or "<p align='center'><b><font color='#bb3426' face='Lucida console'>"..text[n].disabled
        else
            textt=n==artists[cannons[p[n].cnn].artist] and ("<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq) or (data[n][cannons[p[n].cnn].toCounter] >= cannons[p[n].cnn].req and "<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq or "<p align='center'><b><font color='#bb3426' face='Lucida console'>"..text[n].disabled)
        end
        if n=="Bodykudo#0000" then
            textt="<p align='center'><b><font color='#1e0519' face='Lucida console'><a href='event:eq_"..cannons[p[n].cnn].id.."'>"..text[n].eq
        end
        ui.addTextArea(121, textt, n, 421,325, 95, 25, 0x0, 0x0, 0, true)

        if data[n][10]==cannons[p[n].cnn].id then
            ui.addTextArea(121, "<p align='center'><b><font color='#1e0519' face='Lucida console'>"..text[n].eqd, n, 421,325, 95, 25, 0x0, 0x0, 0, true)
        end
    elseif string.sub(cb,0,2)=="eq" then
        num=tonumber(string.sub(cb,4,5))
        data[n][10]=num
        ui.addTextArea(121, "<p align='center'><b><font color='#1e0519' face='Lucida console'>"..text[n].eqd, n, 421,325, 95, 25, 0x0, 0x0, 0, true)
        if id.shop[11][n] then tfm.exec.removeImage(id.shop[11][n],n) id.shop[11][n]=nil end
        if id.shop[12][n] then tfm.exec.removeImage(id.shop[12][n],n) id.shop[12][n]=nil end
        p[n].usedCnn=p[n].cnn
        p[n].cnn=0
        local v=cannons[p[n].usedCnn]
        id.shop[11][n]=tfm.exec.addImage(v.inShop..".png",":100",460+(data[n][8]+20+(v.xp and v.xp or 0)),100+(data[n][9]+20+(v.yp and v.yp or 0)), n) --Cannon
        id.shop[12][n]=tfm.exec.addImage("15fa9a33e5f.png",":100",460,100,n) --Mouse
        saveData(n)
    elseif string.sub(cb,0,4)=="type" then
        ms.close(n)
        ms.openHelp(n,string.sub(cb,6))
    elseif string.sub(cb,0,4)=="link" then
        local link=links[string.sub(cb,6)]
        tfm.exec.chatMessage("<ROSE>"..link.."</ROSE>",n)
    elseif cb=="lgs" then
        tfm.exec.chatMessage("<J>"..text[n].lgs.."</J>\n<ROSE><b>"..table.indexesConcat(translations,"</b></ROSE>,<ROSE><b> ",tostring).."</b>",n)
    elseif string.sub(cb,0,4)=="edit" then
        local po=tonumber(string.sub(cb,6,6))
        local ma=string.sub(cb,8,8)
        data[n][po]=data[n][po]+(ma=="+" and (data[n][po]<25 and 1 or 0) or ma=="-" and (data[n][po]>-25 and -1 or 0) or 0)
        if ma=="D" then
            data[n][po]=po==8 and 10 or 0
        end
        ui.addTextArea(118, "<p align='center'><b><font color='#52902d'>X: "..data[n][8], n, 464, 219, 50, 30, 0 ,0, 0, true)
        ui.addTextArea(119, "<p align='center'><b><font color='#52902d'>Y:\n"..data[n][9], n, 580, 120, 30, 50, 0 ,0, 0, true)
        if id.shop[11][n] then tfm.exec.removeImage(id.shop[11][n],n) id.shop[11][n]=nil end
        if id.shop[12][n] then tfm.exec.removeImage(id.shop[12][n],n) id.shop[12][n]=nil end
        local v=p[n].cnn==0 and cannons[p[n].usedCnn] or cannons[p[n].cnn]
        id.shop[11][n]=tfm.exec.addImage(v.inShop..".png",":100",460+(data[n][8]+20+(v.xp and v.xp or 0)),100+(data[n][9]+20+(v.yp and v.yp or 0)), n) --Cannon
        id.shop[12][n]=tfm.exec.addImage("15fa9a33e5f.png",":100",460,100,n) --Mouse
        saveData(n)
    elseif string.sub(cb,0,6)=="events" then
        local pr=string.sub(cb,8)
        ms.close(n)
        ms.openProfile(n,pr,true,false)
    elseif string.sub(cb,0,4)=="info" then
        local pr=string.sub(cb,6)
        ms.close(n)
        ms.openProfile(n,pr,false,false)
    elseif cb=="sett" then
        ms.close(n)
        ms.openProfile(n,n,false,true)
    elseif cb=="icons" then
        if data[n][46]==1 then
            data[n][46]=0
        else
            data[n][46]=1
        end
        ui.addToggle(105,n,520,128,data[n][46]==1,"icons")
        saveData(n)
    elseif string.sub(cb,0,6)=="change" then
        local toChange=string.sub(cb,8)
        ms.changeThing(n,toChange)
    elseif cb=="no" then
        ms.close(n)
        ms.openProfile(n,n,false,true)
    elseif string.sub(cb,0,3)=="yes" then
        local toChange=string.sub(cb,5)
        if data[n][40] >= (toChange=="team" and 20 or 10) then
            if play and map~="@7796992" then
                tfm.exec.killPlayer(n)
            end
            ms.close(n)
            system.newTimer(function()
                if toChange=="team" then
                    ms.joinTeam(n,data[n][2],0,0,"",-1,nil,nil)
                    data[n][40]=data[n][40]-20
                    saveData(n)
                    ms.openTeams(n)
                else
                    ms.joinTeam(n,data[n][2],1,0,"",-1,nil,nil)
                    data[n][40]=data[n][40]-10
                    saveData(n)
                    ms.openRoles(n)
                end
            end,1000,false)
            if map=="@7796992" then
                tfm.exec.movePlayer(n,400,350)
            end
            saveData(n)
        else
            ms.close(n)
            ms.openProfile(n,n,false,true)
            tfm.exec.chatMessage("<R>"..text[n].enough,n)
        end
    elseif cb=="nextLeader" and p[n].lbPage < 3 then
        ms.close(n)
        p[n].lbPage=p[n].lbPage+1
        ms.openRank(n,p[n].lbPage,false)
    elseif cb=="nextGlobal" and p[n].globalPage < 5 then
        ms.close(n)
        p[n].globalPage=p[n].globalPage+1
        ms.openRank(n,p[n].lbPage,true)
    elseif cb=="prevGlobal" and p[n].globalPage > 1 then
        ms.close(n)
        p[n].globalPage=p[n].globalPage-1
        ms.openRank(n,p[n].lbPage,true)
    elseif cb=="prevLeader" and p[n].lbPage > 1 then
        ms.close(n)
        p[n].lbPage=p[n].lbPage-1
        ms.openRank(n,p[n].lbPage,false)
    elseif cb=="roomLeader" then
        ms.close(n)
        p[n].lbPage=1
        ms.openRank(n,p[n].lbPage,false)
    elseif cb=="globalLeader" then
        ms.close(n)
        p[n].globalPage=1
        ms.openRank(n,1,true)
	end
end
--[[ End of file events/eventTextAreaCallback.lua ]]--
--[[ End of directory events ]]--
--[[ File end.lua ]]--
ms.newGame()
table.foreach(tfm.get.room.playerList,function(a,b) eventNewPlayer(a) tfm.exec.setPlayerScore(a,0) end)
system.loadFile(1)
--[[ End of file end.lua ]]--
end