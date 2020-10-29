roles={
    a={
        icon="173f967697b",
        id=1708,
        color='E6254E',
        xs={
            h=742,
            v=32
        },
        ys=55,
        aie=true,
        sham=true
    },
    p={
        icon="173f966dc3d",
        x=-10,
        y=-85,
        id=1709,
        color='2D93ED',
        time=30,
        skillImg="173f9671ca0",
        aie=true,
        sham=false,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                p[n].skillImg=false
                p[n].timeToSkill=os.time()
                local id=#grounds+1
                id=tfm.exec.addPhysicObject(id,x+(p[n].right and 10 or -10),y+4,{type=12,width=10,height=90,foreground=false,friction=0,restitution=00,angle=0,color=nil,miceCollision=true,groundCollision=true})
                local img=""
                --if data[n][35]==1 then
                img=tfm.exec.addImage(p[n].right and teams[data[n][2]].arm.right..".png" or teams[data[n][2]].arm.left..".png","!999",x+(p[n].right and 5 or -25),y-40)
                --[[else
                    for k,v in pairs(shields) do
                        if v.id==data[n][35] then
                            img=tfm.exec.addImage(p[n].right and v.right..".png" or v.left..".png","!999",x+(p[n].right and v.xr or v.xl),y+v.y)
                        end
                    end
                end]]
                table.insert(grounds,{os.time(),id,img})
            end,
        },
    },
    he={
        icon="173f96844f4",
        id=1701,
        color='2ED748',
        time=180,
        skillImg="173f9666724",
        aie=true,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                if id.skill[n] then tfm.exec.removeImage(id.skill[n],n) id.skill[n]=nil end
                p[n].timeToSkill=os.time()
                teams[data[n][2]].hp=teams[data[n][2]].hp+math.random(7,15)
                ms.hpBar(nil)
                local oppTeam=data[n][2]=="h" and "v" or "h"
                teams[oppTeam].coolodown=true
                system.newTimer(function() teams[oppTeam].coolodown=false end,math.random(6000,7500),false)
            end,
        },
    },
    w={
        icon="173f9679ed5",
        id=1702,
        color='902BDD',
        time=45,
        skillImg="173f967022d",
        aie=false,
        sham=false,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y,target)
                if tfm.get.room.playerList[target] then
                    local X,Y=tfm.get.room.playerList[target].x,tfm.get.room.playerList[target].y
                    tfm.exec.movePlayer(target,X,Y)
                    trap=tfm.exec.addShamanObject(68,X,Y)
                    balloon=tfm.exec.addShamanObject(28,X,Y,0,0,0,true)
                    p[target].trapped=true
                    tfm.exec.addImage("1739d89da14.png","#"..tostring(trap),-45,-25)
                    tfm.exec.addImage("174c861009f.png","#"..tostring(balloon),0,0)
                    tfm.exec.movePlayer(target,X,Y)
                    system.newTimer(function()
                        tfm.exec.removeObject(trap)
                        p[target].trapped=false
                    end,math.random(10000,11500),false)
                end
            end,
        },
    },
    c={
        icon="173f96863d7",
        id=1712,
        color='CF21C9',
        time=45,
        skillImg="173f967378b",
        aie=true,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y,target)
                p[target].stopped=true
                local stoppedImg=tfm.exec.addImage("174a8360e98.png","$"..target,-22,-25)
                system.newTimer(function()
                    p[target].stopped=false
                    if stoppedImg then
                        tfm.exec.removeImage(stoppedImg)
                    end
                end,math.random(10000,11500),false)
            end,
        },
    },
    i={
        icon="173f966b035",
        id=1704,
        color='E0E100',
        time=50,
        skillImg="173f968296b",
        aie=false,
        sham=true,
        xs={
            h=742,
            v=32
        },
        ys=55,
        skill={
            function(n,x,y)
                local t=data[n][2]
                for k in pairs(tfm.get.room.playerList) do
                    if data[k][2]~=data[n][2] and not p[k].afk then
                        tfm.exec.movePlayer(k,0,0,false,t=="h" and -100 or 100,-85,false)
                    end
                end
                for i=1,10 do
                    tfm.exec.displayParticle(26,t=="h" and math.random(0,300) or math.random(500,800),math.random(50,400), ({-5,5})[math.random(1,2)],0,0,0,nil)
                    tfm.exec.displayParticle(27,t=="h" and math.random(0,300) or math.random(500,800) ,math.random(50,400), ({-5,5})[math.random(1,2)],0,0,0,nil)
                end
            end,
        },
    },
}