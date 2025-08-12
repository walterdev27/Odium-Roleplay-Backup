function NAR.NotifyPolice(policeTable, notifyMsg, repitions)
    if not istable(policeTable) or not isstring(notifyMsg) or not isnumber(repitions) then return end

    for k, v in ipairs(player.GetAll()) do
        if IsValid(v) then
            if policeTable[team.GetName(v:Team())] then
                for i = 1, repitions do
                    DarkRP.notify(v, 0, 4, notifyMsg)
                end
            end
        end
    end
end

function NAR.GiveRewards(ply, ent)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if not IsValid(ent) or ent:GetClass() != "odium_armory" then return end

    timer.Create("NAR:Timer:GiveRewards", 2, NAR.WeaponCount, function()
        local randomWeapon = NAR.Weapons[math.random(#NAR.Weapons)]
        if not randomWeapon then return end

        local weaponEnt = ents.Create("odium_weapon")
        weaponEnt:SetModel(randomWeapon["Model"])
        weaponEnt:SetPos(ent:GetPos() + ent:GetForward() * 20)
        weaponEnt:SetAngles(ent:GetAngles())
        weaponEnt:SetClasss(randomWeapon["Class"])
        weaponEnt:SetWeaponName(randomWeapon["Name"])

        weaponEnt:Spawn()
        weaponEnt:Activate()

        weaponEnt:DropToFloor()
    end)
end

function NAR.TimerCreate(self, timerName, time)
    if not timer.Exists(timerName) then
        timer.Create(timerName, time, 0, function()
            self:SetIsRobable(true)
            self:SetReload(false)

            timer.Remove(timerName)
        end)
    end
end