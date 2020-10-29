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