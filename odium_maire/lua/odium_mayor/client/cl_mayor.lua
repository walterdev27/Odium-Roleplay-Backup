local signalMat = Material("odium_mayor/alert.png", "smooth")
local gradient = Material("odium_general_logo/gradienntt.png")

hook.Add("HUDPaint", "Odium:Mayor:HUDPaint", function()
    if LocalPlayer():GetNWBool("OdiumMayorWarning") then 
        for _, ent in ipairs(player.GetAll()) do
            if ent:getDarkRPVar("job") == Odium_Mayor.Config.MayorJobName then
                local point = ent:GetPos() + ent:OBBCenter()
                local data2D = point:ToScreen()
        
                if not data2D.visible then continue end
        
                surface.SetDrawColor(color_white)
                surface.SetMaterial(signalMat)
                surface.DrawTexturedRect(data2D.x-25, data2D.y-25, 50, 50)
            end
        end
    end
    
    if not LocalPlayer():Alive() then
        return
    end
    if not IsValid(LocalPlayer()) then return end
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    if LocalPlayer():GetActiveWeapon():GetClass() == "tfa_nmrih_asaw" then	
	surface.SetDrawColor(color_white)
    surface.SetMaterial(gradient)
	surface.DrawTexturedRect(RX(425), RY(440), RX(2500), RY(100))	
	surface.SetDrawColor(color_black)
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(463), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
	draw.SimpleTextOutlined("Appuyez sur [R] pour scier", "OdiumMayor_Font", RespX(1770), RespY(487), Color(32,122,100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(32, 32, 32))		
        local trace = LocalPlayer():GetEyeTrace()
        if not IsValid(trace.Entity) then return end
        if trace.Entity:GetClass() == "odiummayor_locker" then
            if LocalPlayer():GetPos():DistToSqr(trace.Entity:GetPos()) < 100000 then 
				surface.SetDrawColor(color_white)
                surface.SetMaterial(gradient)
                surface.DrawTexturedRect(RX(425), RY(443), RX(2500), RY(200))
				surface.SetDrawColor(color_black)
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(500), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
				surface.DrawTexturedRect(RX(525), RY(570), RX(2500), RY(15))
                --draw.SimpleText("Vie du coffre : "..trace.Entity:GetLockerHealth().." PV", "OdiumMayor_FontC3D2D", ScrW()-RX(310), ScrH()/2, color_white, 0, TEXT_ALIGN_CENTER)
				draw.SimpleTextOutlined("Vie du coffre : "..trace.Entity:GetLockerHealth().." PV", "OdiumMayor_FontC3D2D", RespX(1750), RespY(540), Color(32,122,100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(32, 32, 32))			
            end
        end
    end
end)

local model = ClientsideModel("models/bag/bag.mdl")
model:SetNoDraw(true)

hook.Add("PostPlayerDraw" , "Odium:Mayor:PostPlayerDraw" , function(ply)
    if not IsValid(ply) then return end
    if not ply:GetNWBool("LockerRobbed") then return end
    if not Odium_Mayor.Config.RobJob[ply:getDarkRPVar("job")] then return end
    if not model or not IsValid(model) then return end

    local boneid = ply:LookupBone("ValveBiped.Bip01_Spine2")
    
    if not boneid then
        return
    end
    
    local matrix = ply:GetBoneMatrix( boneid )
    
    if not matrix then 
        return 
    end

    
    local offsetvec = Vector(0, -10, 0)
    local offsetang = Angle(180, 180, -90)

    model:SetModelScale(0.9, 0)
    
    local newpos, newang = LocalToWorld(offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles())
    
    model:SetPos(newpos)
    model:SetAngles(newang)
    model:SetupBones()
    model:DrawModel()
end)