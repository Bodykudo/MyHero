function eventPlayerLeft(n)
    if data[n][1]==1 and data[n][3]==1 then
        ms.editTeam(n,-1,true,nil)
    end
end