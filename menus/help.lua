function ms.openHelp(n,type)
    if data[n][3]==1 then
        id.help[1][n]=tfm.exec.addImage("1748a9c39b0.png",":100",83,56,n) --Book
        id.help[2][n]=tfm.exec.addImage("1748a9c79d3.png",":100",83,56,type=="help" and "Random" or n) --Help
        id.help[3][n]=tfm.exec.addImage("1748a9cb932.png",":100",83,56,type=="credits" and "Random" or n) --Credits
        id.help[4][n]=tfm.exec.addImage("1748a9cde35.png",":100",83,56,type=="donate" and "Random" or n) --Donate
        id.help[5][n]=tfm.exec.addImage("175179cfea5.png",":100",80,105,type=="new" and "Random" or n) --New
        ui.addTextArea(101, "<a href='event:close'>\n\n\n\n\n\n\n\n\n\n\n\n", n, 647, 62, 50, 47, 0x0, 0x0, 0, true)
        ui.addTextArea(102, "<a href='event:type_help'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="help" and "Random" or n, 157, 65, 45, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(103, "<a href='event:type_credits'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="credits" and "Random" or n, 219, 63, 45, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(104, "<a href='event:type_donate'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="donate" and "Random" or n, 281, 60, 46, 30, 0x0, 0x0, 0, true)
        ui.addTextArea(107, "<a href='event:type_new'>\n\n\n\n\n\n\n\n\n\n\n\n", type=="new" and "Random" or n, 92, 111, 30, 45, 0x0, 0x0, 0, true)
        ui.addTextArea(105, text[n].hMenu[type][1], n, 130, 105, 260, 260, 0x0, 0x0, 0, true)
        ui.addTextArea(106, text[n].hMenu[type][2], n, 404, 105, 260, 260, 0x0, 0x0, 0, true)
        if type=="new" then
            id.help[6][n]=tfm.exec.addImage(updates[VERSION].img..".png",":100",404,105,type=="new" and "Random" or n)
        end
    else
        tfm.exec.chatMessage("<R>"..text[n].wrong,n)
    end
end