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