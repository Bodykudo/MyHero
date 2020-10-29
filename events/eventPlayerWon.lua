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