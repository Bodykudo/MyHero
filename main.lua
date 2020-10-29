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