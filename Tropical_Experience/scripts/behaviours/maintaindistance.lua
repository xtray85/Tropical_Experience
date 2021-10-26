MaintainDistance = Class(BehaviourNode, function(self, inst, find_avoidance_object_fn, min_distance, max_distance, on_within_distance_fn)
    BehaviourNode._ctor(self, "MaintainDistance")
    self.inst = inst
    self.min_distance = min_distance or 6
    self.max_distance = max_distance or 8
    self.find_avoidance_object_fn = find_avoidance_object_fn
    self.on_within_distance_fn = on_within_distance_fn
end)

function MaintainDistance:__tostring()
    return string.format("target %s", tostring(self.inst.components.combat.target))
end

function MaintainDistance:OnStop()

end

function MaintainDistance:CheckDistance(distance_to_avoided_object_sq)
    local buffer_distance = math.max(self.inst:GetPhysicsRadius(0), 0.15)
    local min_distance = self.min_distance - buffer_distance
    local max_distance = self.max_distance + buffer_distance
    if distance_to_avoided_object_sq > max_distance * max_distance then
        return false, self.max_distance
    elseif distance_to_avoided_object_sq < min_distance * min_distance then
        return false, self.min_distance 
    else
        return true
    end
end

function MaintainDistance:Visit()
    if self.status == READY then
        if self.find_avoidance_object_fn(self.inst) then
            self.status = RUNNING
        else
            self.status = FAILED
        end
    end

    if self.status == RUNNING then
        local avoided_object = self.find_avoidance_object_fn(self.inst)
        if not avoided_object then
            self.status = FAILED
            self.inst.components.locomotor:Stop()
        else
            local current_pos = self.inst:GetPosition()
            local avoided_object_pos = avoided_object:GetPosition()
            local distance_to_avoided_object_sq = distsq(current_pos, avoided_object_pos)
            local is_within_distance, offset = self:CheckDistance(distance_to_avoided_object_sq)

            if is_within_distance then
                self.inst.components.locomotor:Stop()
                if self.on_within_distance_fn(self.inst) then
                    self.status = SUCCESS
                end
            else
                local angle_to_avoided_object = self.inst:GetAngleToPoint(avoided_object_pos) * DEGREES
                local offset_pos = Point(offset * math.cos(angle_to_avoided_object), 0, offset * math.sin(angle_to_avoided_object))
                local target_pos = avoided_object_pos + offset_pos
                self.inst.components.locomotor:GoToPoint(avoided_object_pos + offset_pos, nil, true)
            end
        end
    end
end
