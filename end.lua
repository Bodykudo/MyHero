ms.newGame()
table.foreach(tfm.get.room.playerList,function(a,b) eventNewPlayer(a) tfm.exec.setPlayerScore(a,0) end)
system.loadFile(1)