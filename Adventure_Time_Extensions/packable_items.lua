local PACKABLE = {

}

for item in PACKABLE do		
    if inst.prefab == item then
            inst:AddTag("packable")    
        return
    end
end
