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