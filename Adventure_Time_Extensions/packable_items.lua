local PACKABLE = {
    "icemaker", "saltbox", "madscience_lab"
}

for item in PACKABLE do		
    if inst.prefab == item then
            inst:AddTag("packable")    
        return
    end
end
