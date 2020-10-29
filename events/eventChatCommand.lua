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