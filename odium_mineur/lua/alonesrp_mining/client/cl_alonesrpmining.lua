local AlonesRPMiningFont1 = AlonesRP.CreateFont("AlonesRPMiningFont1", "Roboto", 28, {weight = 800})
local gradient = Material("odium_general_logo/gradienntt.png")

hook.Add("HUDPaint", "AlonesRP:Mining:HUD", function()
    local trace = LocalPlayer():GetEyeTrace()
    if not IsValid(trace.Entity) then return end
    if trace.Entity:GetClass() == "alonesrp_rock" then
        if LocalPlayer():GetPos():DistToSqr(trace.Entity:GetPos()) > 100000 then return end
        if not AlonesRP_Mining.TeamAutorize[LocalPlayer():getDarkRPVar("job")] then return end

        --draw.SimpleTextOutlined("Vie du rocher :", AlonesRPMiningFont1, ScrW()/2, AlonesRP.RY(20), color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
		surface.SetDrawColor(color_white)
                surface.SetMaterial(gradient)
                surface.DrawTexturedRect(RX(500), RY(443), RX(2500), RY(200))
				surface.SetDrawColor(color_black)
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(535), RY(570), RX(2500), RY(15))
		draw.SimpleTextOutlined("Vie du rocher : " ..trace.Entity:GetRockHealth().. " PV", AlonesRPMiningFont1, RespX(1750), RespY(540), Color(32,122,100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(32, 32, 32))	
        --draw.SimpleTextOutlined(trace.Entity:GetRockHealth().." PV", AlonesRPMiningFont1, ScrW()/2, AlonesRP.RY(60), color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
    end
end)