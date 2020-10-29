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