kits={
	[41]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,p[n].right and 90 or -90,0,false)
			for i = 1,10 do
				tfm.exec.displayParticle(35,p[n].right and x or x+100,y,(p[n].righ and 15 or -15),math.random(-3,3))
			end
		end,7000,"174605a2318",
		img="17427798f8b",
		price=15,
		max=20,
	},
	[42]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,0,-70,false)
			tfm.exec.displayParticle(12,x,y+30)
		end,7000,"1746059d7be",
		img="17427796adb",
		price=20,
		max=20,
    },
	[43]={
		function(n,x,y)
			tfm.exec.movePlayer(n,0,0,true,0,-90,false)
			for i = 0,15,.25 do
				tfm.exec.displayParticle(({1,9})[((i*4)%2)+1],x+math.sin(i*1.1)*20,y+40+-i*3.5)
			end
		end,7000,"174605a5d53",
		img="1742779ac77",
		price=25,
		max=20,
	},
    [44]={
		img="1742778d002",
		price=35,
		max=20,
    }
}