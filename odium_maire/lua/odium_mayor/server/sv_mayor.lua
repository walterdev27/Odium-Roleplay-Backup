hook.Add("PlayerDeath", "Odium:Mayor:PlayerDeath", function(ply)
    local lastJob = ply:getDarkRPVar("job")
    if Odium_Mayor.Config.MayorJobName == lastJob then
        Odium_Mayor:RemovePoliticalRegime()
        Odium_Mayor:ResetTaxe()

        timer.Remove("Odium:Mayor:TaxeTimer")
        DarkRP.resetLaws()

        for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
            v:SetLockerMoney(0)
        end
        for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
            v:SetMoney(0)
        end
    end
end)

hook.Add("PlayerDisconnected", "Odium:Mayor:PlayerDeath", function(ply)
    local lastJob = ply:getDarkRPVar("job")
    if Odium_Mayor.Config.MayorJobName == lastJob then
        Odium_Mayor:RemovePoliticalRegime()
        Odium_Mayor:ResetTaxe()

        timer.Remove("Odium:Mayor:TaxeTimer")
        DarkRP.resetLaws()

        for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
            v:SetLockerMoney(0)
        end
        for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
            v:SetMoney(0)
        end
    end
end)

hook.Add("OnPlayerChangedTeam", "Odium:Mayor:PCT", function(ply, before, after)
	print(team.GetName(before), "AEZJFHJZAHUGZAHGEZKGJEAZKGEAJGFEZKGKEZAK")
    if team.GetName(before) == Odium_Mayor.Config.MayorJobName then
		print("OK")
        Odium_Mayor:RemovePoliticalRegime()
        Odium_Mayor:ResetTaxe()

        timer.Remove("Odium:Mayor:TaxeTimer")
        DarkRP.resetLaws()

        for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
            v:SetLockerMoney(0)
        end
        for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
            v:SetMoney(0)
        end
    end
end)

hook.Add("PostCleanupMap", "Odium:Mayor:PostCleanup", function()
  Odium_Mayor:RemovePoliticalRegime()
  Odium_Mayor:ResetTaxe()

  timer.Remove("Odium:Mayor:TaxeTimer")
  DarkRP.resetLaws()

  for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
       v:SetLockerMoney(0)
  end
  for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
       v:SetMoney(0)
  end
end)

hook.Add("Initialize", "Odium:Mayor:Initialize", function()
    Odium_Mayor.DataTable = Odium_Mayor.DataTable or {}

    Odium_Mayor.DataTable["Regime"] = ""
    Odium_Mayor.DataTable["Taxe"] = 0.99
    Odium_Mayor.DataTable["LockerMoney"] = 0
end)
--[[
local function SavingEnts()
    timer.Simple(.1, function()
        for _, v in pairs(ents.FindByClass("odiummayor_locker")) do v:Remove() end
        for _, v in pairs(ents.FindByClass("odiummayor_resellnpc")) do v:Remove() end
        for _, v in pairs(ents.FindByClass("odiummayor_board")) do v:Remove() end
        for _, v in pairs(ents.FindByClass("odiummayor_tablet")) do v:Remove() end

        local tabspawn = sql.Query("SELECT * FROM OdiumMayorSQL")
        if not tabspawn then return end
        for _, val in pairs(tabspawn) do 
            local falsepos, falseang = val.pos, val.ang
            local pos, ang = string.Explode(",", falsepos), string.Explode(",", falseang)
            local newEnt = ents.Create(val.ent == "odiummayor_locker" and "odiummayor_locker" or val.ent == "odiummayor_resellnpc" and "odiummayor_resellnpc" or val.ent == "odiummayor_board" and "odiummayor_board" or val.ent == "odiummayor_tablet" and "odiummayor_tablet")
            if !IsValid(newEnt) then return end
            newEnt:SetPos(Vector(tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3])))
            newEnt:SetAngles(Angle(tonumber(ang[1]), tonumber(ang[2]), tonumber(ang[3])))
            newEnt:PhysicsInit(SOLID_NONE)
            newEnt:Spawn()
            newEnt:Activate()
        end
    end)
end

hook.Add("InitPostEntity", "Odium:Mayor:IPE", SavingEnts)
hook.Add("PostCleanupMap", "Odium:Mayor:Cleanup", SavingEnts)

concommand.Add("odiummayor_saveents", function(ply)
    if not ply:IsSuperAdmin() then DarkRP.notify(ply, 1, 5, "Vous n'avez pas les permissions pour cela") return end

    if sql.TableExists("OdiumMayorSQL") then 
        sql.Query("DELETE FROM OdiumMayorSQL")
    else
        sql.Query("CREATE TABLE OdiumMayorSQL(ent TEXT, pos TEXT, ang TEXT)")
    end

    for _, ent in pairs(ents.FindByClass("odiummayor_locker")) do
        local falsepos, falseang = ent:GetPos(), ent:GetAngles()
        local pos, ang = falsepos.x..","..falsepos.y..",".. falsepos.z, falseang.p..","..falseang.y..","..falseang.r
        sql.Query("INSERT INTO OdiumMayorSQL(ent, pos, ang) VALUES ('odiummayor_locker', '"..pos.."', '"..ang.."')")
    end
    for _, ent in pairs(ents.FindByClass("odiummayor_resellnpc")) do
        local falsepos, falseang = ent:GetPos(), ent:GetAngles()
        local pos, ang = falsepos.x..","..falsepos.y..",".. falsepos.z, falseang.p..","..falseang.y..","..falseang.r
        sql.Query("INSERT INTO OdiumMayorSQL(ent, pos, ang) VALUES ('odiummayor_resellnpc', '"..pos.."', '"..ang.."')")
    end
    for _, ent in pairs(ents.FindByClass("odiummayor_board")) do
        local falsepos, falseang = ent:GetPos(), ent:GetAngles()
        local pos, ang = falsepos.x..","..falsepos.y..",".. falsepos.z, falseang.p..","..falseang.y..","..falseang.r
        sql.Query("INSERT INTO OdiumMayorSQL(ent, pos, ang) VALUES ('odiummayor_board', '"..pos.."', '"..ang.."')")
    end
    for _, ent in pairs(ents.FindByClass("odiummayor_tablet")) do
        local falsepos, falseang = ent:GetPos(), ent:GetAngles()
        local pos, ang = falsepos.x..","..falsepos.y..",".. falsepos.z, falseang.p..","..falseang.y..","..falseang.r
        sql.Query("INSERT INTO OdiumMayorSQL(ent, pos, ang) VALUES ('odiummayor_tablet', '"..pos.."', '"..ang.."')")
    end
    SavingEnts()

    DarkRP.notify(ply, 1, 5, "Les entités ont été sauvegardées")
end)]]