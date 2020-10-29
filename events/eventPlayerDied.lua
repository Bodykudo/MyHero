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