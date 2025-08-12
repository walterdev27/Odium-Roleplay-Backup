surface.CreateFont("NUB:Font:1", {
	font = NUB.Font,
	extended = false,
	size = 35,
	weight = 500,
})

hook.Add("HUDPaint", "NUB:Hook:HUDPaint", function()
    local trace = LocalPlayer():GetEyeTrace().Entity
    if not IsValid(trace) then return end

    if LocalPlayer():InVehicle() then return end

    if trace:GetClass() == "prop_vehicle_jeep" and trace:GetPos():DistToSqr(LocalPlayer():GetPos()) <= 30000 then
        if not NUB.RanksWhoCanPass[LocalPlayer():GetUserGroup()] then
            if not trace:isKeysOwnedBy(LocalPlayer()) then return end
        end

        local obbMax = trace:LocalToWorld(trace:OBBMaxs()) //ang.y >= 100 and ang.y <= 180, ang.y >= -50 and ang.y <= 0
        local obbMin = trace:LocalToWorld(trace:OBBMins())

        local distMax, distMin = obbMax:DistToSqr(LocalPlayer():GetPos()), obbMin:DistToSqr(LocalPlayer():GetPos())

        if (distMax >= 96000 and distMin <= 26000) or (distMax <= 96000 and distMin >= 26000) then //if (distMax >= 96000 and distMin <= 26000) or (distMax <= 40000 and distMin >= 35000) then

            draw.SimpleTextOutlined("Faite "..NUB.StringKey.." pour pousser la voiture", "NUB:Font:1", ScrW() / 1.99, ScrH() / 1.75, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0))
            
        end
        

    end
end)