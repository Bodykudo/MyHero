function math.rotate(x,y,centerx, centery, ang)
    ang = ang/(180/math.pi)
    return centerx + (x - centerx) * math.cos(ang) - (y - centery) * math.sin(ang) , centery + (x - centerx) * math.sin(ang) + (y - centery) * math.cos(ang)
end

function string.split(str,pattern,f)
    local out = {}
    for value in string.gmatch(str, pattern) do
        out[#out + 1] = not f and value or f(value)
    end
    return out
end