hook.Add("PlayerButtonDown", "NUB:Hook:PlayerButtonDown", function(ply, key)
    if not IsValid(ply) then return end

    ply.NUBCountdown = ply.NUBCountdown or CurTime()
    if ply.NUBCountdown > CurTime() then return end
    ply.NUBCountdown = CurTime() + NUB.Countdown

    local trace = ply:GetEyeTrace()
    if not IsValid(trace.Entity) then return end

    if ply:InVehicle() then return end

    if trace.Entity:GetClass() == "prop_vehicle_jeep" and trace.Entity:GetPos():DistToSqr(ply:GetPos()) <= 30000 then
        if not NUB.RanksWhoCanPass[ply:GetUserGroup()] then
            if not trace.Entity:getDoorOwner() == ply then return end
        end

        local entPhys = trace.Entity:GetPhysicsObject()
        if not IsValid(entPhys) then return end

        local obbMax = entPhys:LocalToWorld(trace.Entity:OBBMaxs()) //ang.y >= 100 and ang.y <= 180, ang.y >= -50 and ang.y <= 0
        local obbMin = entPhys:LocalToWorld(trace.Entity:OBBMins())

        if key == NUB.Key then
            local distMax, distMin = obbMax:DistToSqr(ply:GetPos()), obbMin:DistToSqr(ply:GetPos())

            local coef = 0
            if distMax >= 96000 and distMin <= 26000 then
                coef = -NUB.Coef
            elseif distMax <= 40000 and distMin >= 35000 then
                coef = NUB.Coef
            end 

            local vec = trace.Entity:GetAngles():Right() * coef

            local velocity = vec * NUB.Force

            entPhys:AddVelocity(velocity) 
        end

    
    end

end )