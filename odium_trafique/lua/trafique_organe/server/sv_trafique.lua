util.AddNetworkString("KillCharcutingTarget")
util.AddNetworkString("FinishCharcutage")

local itemPrices = {
    odium_coeursale = {min = 15000, max = 20000},
    odium_coeur = {min = 60000, max = 100000},
    odium_cervellsale = {min = 15000, max = 20000},
    odium_cervell = {min = 60000, max = 100000},
    odium_poumon = {min = 60000, max = 100000},
    odium_poumonsale = {min = 15000, max = 20000}
}


if SERVER then
    net.Receive("FinishCharcutage", function(len, ply)
        local target = net.ReadEntity()

        if not IsValid(target) or not target:IsPlayer() then return end

        -- Tuer le joueur après le charcutage
        target:Kill()

        -- Faire tomber les objets après le charcutage
        local itemNames = {
            coeur = {"odium_coeursale", "odium_coeur"},
            cervell = {"odium_cervellsale", "odium_cervell"},
            poumon = {"odium_poumonsale", "odium_poumon"}
        }

        local organKeys = table.GetKeys(itemNames)

        for i = 1, 3 do
            local organKey = organKeys[i]
            local itemName = table.Random(itemNames[organKey])
            local item = ents.Create(itemName)
            if IsValid(item) then
                item:SetPos(target:GetPos() + Vector(0, 0, 10))
                item:Spawn()
                
                local priceRange = itemPrices[itemName]
                local organPrice = math.random(priceRange.min, priceRange.max)
                item:SetNWInt("organPrice", organPrice)
            end
        end
    end)
end

hook.Add("PlayerDeath", "ResetOrgansOnDeath", function(victim, inflictor, attacker)
    for itemName, _ in pairs(itemPrices) do
        victim:SetNWInt(itemName, 0)
        victim:SetNWInt(itemName .. "_price", 0)
    end
end)
