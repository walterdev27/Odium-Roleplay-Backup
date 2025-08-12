include("shared.lua")

local barStatus = 0

function ENT:Draw()
    self:DrawModel()

    barStatus = Lerp(FrameTime() * 1, barStatus, math.Clamp(self:GetStatus(), 0, NAR.TimeToCrack))

    if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 190000 then return end
    cam.Start3D2D(self:LocalToWorld(Vector(10, -10, 20)), self:LocalToWorldAngles(Angle(0, 90, 90)), 0.05)

		--draw.SimpleTextOutlined(NGS.NPCName, "NGS:Font:Npc", 0, 0, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, Color(0, 0, 0))

        surface.SetDrawColor(MyLib.ColorServer["Black"])
        surface.DrawRect(-150, -10, 700, 200)

        surface.SetDrawColor(MyLib.ColorServer["Green"])
        surface.DrawRect(-150, -10, 700, 50)

        surface.SetDrawColor(color_white)
        surface.DrawRect(-150, -10, 700, 3)
        surface.DrawRect(-150, 190, 700, 3)
        surface.DrawRect(-150, -10, 3, 200)
        surface.DrawRect(550, -10, 3, 200)

        draw.SimpleText("Appuyer sur "..NAR.KeyToCrackString.." et rester dans cette zone !", "NAR:Font:3", -135, 15, MyLib.ColorServer["Black"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(MyLib.ColorServer["white"])
        surface.DrawRect(-133, 52, 670, 125)

        -- Progress Bar
        surface.SetDrawColor(MyLib.ColorServer["Green"])
        surface.DrawRect(-128, 57, barStatus * (740 / NAR.TimeToCrack), 115) -- RespX(320) 267 53.4 * (267 / NAR.TimeToCrack - 1)
		
		draw.SimpleTextOutlined("Braquage d'armurie", "NAR:Font:4", 200, -750, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 10, MyLib.ColorServer["Black"])


        if self:GetStatus() >= 1 and not self:GetReload() then
            draw.SimpleText((self:GetStatus() < NAR.TimeToCrack and "Braquage en cours..." or "Braquage terminé."), "NAR:Font:1", 185, 112, MyLib.ColorServer["Black"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText((not self:GetIsRobable() and "Vous devez attendre..." or "Braquage disponnible."), "NAR:Font:1", 185, 112, MyLib.ColorServer["Black"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        
    cam.End3D2D()
end