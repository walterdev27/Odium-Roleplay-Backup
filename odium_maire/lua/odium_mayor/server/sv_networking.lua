-- Opening derma
util.AddNetworkString("Odium:Mayor:TabletOpeningDerma")
util.AddNetworkString("Odium:Mayor:LockerOpeningDerma")

-- Regime political
util.AddNetworkString("Odium:Mayor:RegimePoliticalChange")

-- Lockdown
util.AddNetworkString("Odium:Mayor:SetLockdown")

-- Guard
util.AddNetworkString("Odium:Mayor:FiredGuard")

-- Signal system
util.AddNetworkString("Odium:Mayor:LoadWarning")

-- Taxes
util.AddNetworkString("Odium:Mayor:SetTaxe")
util.AddNetworkString("Odium:Mayor:TakeLockerMoney")


net.Receive("Odium:Mayor:RegimePoliticalChange", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local regime = net.ReadString()

    for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
        v:SetPoliticalRegime(regime)
    end

    Odium_Mayor:ChangePoliticalRegime(regime)

    DarkRP.notify(ply, 0, 4, "Vous venez de changer le régime politique en "..regime)
end)

-- Lockdown part
net.Receive("Odium:Mayor:SetLockdown", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local state = net.ReadBool()

    if state then
        DarkRP.lockdown(ply)
    else
        DarkRP.unlockdown(ply)
    end
end)

-- Guard part
net.Receive("Odium:Mayor:FiredGuard", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local guard = net.ReadEntity()
    if not IsValid(guard) or not guard:IsPlayer() then return end

    guard:changeTeam(Odium_Mayor.Config.BaseJob, true, true)

    DarkRP.notify(ply, 0, 5, "Vous venez de virer " .. guard:Nick() .. " de la garde.")
    DarkRP.notify(guard, 0, 5, "Vous venez d'être virer par " .. ply:Nick() .. ".")
end)

-- Signal part
net.Receive("Odium:Mayor:LoadWarning", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local state = net.ReadBool()

    if state then
        Odium_Mayor:StartWarningState()
        DarkRP.notify(ply, 0, 5, "Vous venez de lancer un signal de danger.")
    else
        Odium_Mayor:StopWarningState()
        DarkRP.notify(ply, 0, 5, "Vous venez de cesser un signal de danger.")
    end
end)

-- Taxes part
net.Receive("Odium:Mayor:SetTaxe", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local taxe = net.ReadFloat()

    for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
        v:SetMayorTaxes(taxe)
    end
    for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
        v:SetRestrictAccess(1)
	    v:SetRestrictAccessTimer(CurTime() + Odium_Mayor.Config.MayorLockerTimerRecup)
    end

    Odium_Mayor:SetTaxe(math.Round(taxe, 1))

    DarkRP.notify(ply, 0, 5, "Vous venez de changer la taxe à "..math.Round(taxe, 1).."%")

    timer.Create("Odium:Mayor:TaxeTimer", Odium_Mayor.Config.TaxesDelay, 0, function()
        local count = 0
        for k, v in ipairs(player.GetAll()) do
            if not IsValid(v) or not v:IsPlayer() then continue end
            if Odium_Mayor.Config.RestrictedTaxesJobs[v:getDarkRPVar("job")] then continue end

            local taxeReturn = Odium_Mayor.Config.Taxes[math.Round(taxe, 1)]
            v:addMoney(-(taxeReturn/100*v:getDarkRPVar("money")))
            count = count + (taxeReturn/100*v:getDarkRPVar("money"))

            DarkRP.notify(v, 0, 5, "Vous venez de payer une taxe de "..taxeReturn.."%")
        end

        for k, v in ipairs(ents.FindByClass("odiummayor_locker")) do
            v:SetMoney(v:GetMoney() + count)
        end
        for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
            v:SetLockerMoney(v:GetLockerMoney() + count)
        end

        count = 0
    end)
end)
net.Receive("Odium:Mayor:TakeLockerMoney", function(_, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local locker = net.ReadEntity()
    
    ply:addMoney(locker:GetMoney())
    DarkRP.notify(ply, 0, 5, "Vous venez de prendre "..DarkRP.formatMoney(locker:GetMoney()).." dans le coffre du maire")
    locker:SetMoney(0)

    for k, v in ipairs(ents.FindByClass("odiummayor_board")) do
        v:SetLockerMoney(0)
    end
end)