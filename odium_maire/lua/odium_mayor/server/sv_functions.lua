function Odium_Mayor:StartWarningState()
    for k, v in ipairs(player.GetAll()) do
        if Odium_Mayor.Config.CopsJobs[v:getDarkRPVar("job")] then
            DarkRP.notify(v, 1, 4, "Le Maire vient de signaler un danger !")
            v:SetNWBool("OdiumMayorWarning", true)
        end
    end
end

function Odium_Mayor:StopWarningState()
    for k, v in ipairs(player.GetAll()) do
        if Odium_Mayor.Config.CopsJobs[v:getDarkRPVar("job")] then
            DarkRP.notify(v, 0, 4, "Le Maire vient d'arrêter le signal de danger.")
            v:SetNWBool("OdiumMayorWarning", false)
        end
    end
end

function AlonesRP.GetPickedPlayers(ent)
    if IsValid(ent) then
        -- Physicsgun
        if IsValid(ent.m_HoldingPlayer) then
            return ent.m_HoldingPlayer
        end

        -- Gravitygun
        local data = ent:GetSaveTable()

        if IsValid(data.m_hOwnerEntity) then
            return data.m_hOwnerEntity
        end
    end

    return NULL

end

hook.Add("PhysgunPickup", "AlonesRP:Lib:PhysgunPick", function(ply, ent)
    if not IsValid(ply) or not IsValid(ent) then return end
    ent.m_HoldingPlayer = ply
end)

hook.Add("PhysgunDrop", "AlonesRP:Lib:PhysgunDrop", function(ply, ent)
    if not IsValid(ply) or not IsValid(ent) then return end
    ent.m_HoldingPlayer = nil
end)

function Odium_Mayor:ChangePoliticalRegime(newRegime)
    Odium_Mayor.DataTable["Regime"] = newRegime
    
    return Odium_Mayor.DataTable["Regime"]
end

function Odium_Mayor:GetPoliticalRegime()
    return Odium_Mayor.DataTable["Regime"]
end

function Odium_Mayor:RemovePoliticalRegime()
    Odium_Mayor.DataTable["Regime"] = ""

    for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
        v:SetPoliticalRegime("")
    end

    return Odium_Mayor.DataTable["Regime"]
end

function Odium_Mayor:SetTaxe(taxe)
    Odium_Mayor.DataTable["Taxe"] = taxe

    return math.Round(Odium_Mayor.DataTable["Taxe"], 1) 
end

function Odium_Mayor:GetTaxe()
    return math.Round(Odium_Mayor.DataTable["Taxe"], 1) 
end

function Odium_Mayor:ResetTaxe()
    Odium_Mayor.DataTable["Taxe"] = 0.99

    for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
        v:SetMayorTaxes(0.99)
    end

    return math.Round(Odium_Mayor.DataTable["Taxe"], 1) 
end