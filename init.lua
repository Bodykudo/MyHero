VERSION = "2.0.0"

submodes={
    "maps", --submode tool to try the new #Myhero maps, made by Bodykudo#0000
    "artking", --submode minigame, made by Aron#6810
    "mouse", --submode minigame inspired from #Myhero, made by Bodykudo#0000
    "auto", --submode minigame inspired from #Myhero, made by Bodykudo#0000
    
}
tfmcnns=1718

function isMode(submode)
    return string.find(tfm.get.room.name, "^[a-z][a-z2]%-#myhero%d+"..submode.."%d*$") or string.find(tfm.get.room.name, "^%*?#myhero%d+"..submode.."%d*$")
end

if isMode("maps") and tfm.get.room.playerList["Bodykudo#0000"] then
{% require-file "modes/maps.lua" %}
elseif isMode("artking") then
{% require-file "modes/artking.lua" %}
elseif isMode("mouse") then
{% require-file "modes/mouse.lua" %}
else
local translations={}
{% require-file "main.lua" %}
{% require-file "changelog.lua" %}
{% require-dir "functions" %}
{% require-dir "tables" %}
{% require-dir "translations" %}
{% require-dir "systems" %}
{% require-dir "menus" %}
{% require-dir "events" %}
{% require-file "end.lua" %}
end