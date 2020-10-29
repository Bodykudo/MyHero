function ui.addToggle(id, player, x, y, state, button)
    ui.addTextArea(id, "", player, x, y, 20, 7, 0x232a35, 0x232a35, 1, true)
    if not state then
        ui.addTextArea(id + 1, "", player, x + 3, y + 3, 1, 1, 0xd23c2c, 0xd23c2c, 1, true)
    else
        ui.addTextArea(id + 1, "", player, x + 16, y + 3, 1, 1, 0x8fd032, 0x8fd032, 1, true)
    end
    ui.addTextArea(id + 2, "<a href='event:"..button.."'>\n\n\n", player, x - 7, y - 7, 30, 20, 1, 1, 0, true)
end

function ui.addTimerImage(img,x,y,n,time)
    time=time or 5
    local img=tfm.exec.addImage(img..".png","&0",x,y,n)
    system.newTimer(function()
        tfm.exec.removeImage(img,n)
    end,time*1000,false)
end