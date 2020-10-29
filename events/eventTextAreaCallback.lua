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