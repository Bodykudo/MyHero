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