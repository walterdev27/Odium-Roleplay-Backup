AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("SellOrgansToNPC")
util.AddNetworkString("RequestSellOrgansToPNJ")

function ENT:Initialize()
    self:SetModel("models/Humans/Group01/male_01.mdl")
    --self:SetHullSizeNormal()
    self:SetSolid(SOLID_BBOX)
    self:SetMoveType(MOVETYPE_STEP)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
    self:SetMaxYawSpeed(90)
    self:SetHealth(100)
    self:SetUseType(SIMPLE_USE)
end



function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then
        local totalValue = 0

        for itemName, priceRange in pairs(itemPrices) do
            local count = caller:GetNWInt(itemName, 0)
            if count > 0 then
                local itemPrice = caller:GetNWInt(itemName .. "_price", 0)
                if itemPrice == 0 then
                    itemPrice = math.random(priceRange.min, priceRange.max)
                end
                local organValue = count * itemPrice
                totalValue = totalValue + organValue
                
                -- Retirer les organes du joueur après la vente
                caller:SetNWInt(itemName, 0)
                caller:SetNWInt(itemName .. "_price", 0)

                -- Informer le joueur de la vente individuelle des organes
                caller:ChatPrint("Vous avez vendu " .. count .. " " .. itemName .. " pour " .. DarkRP.formatMoney(organValue) .. ".")
            end
        end

        if totalValue > 0 then
            -- Donner l'argent au joueur
            caller:addMoney(totalValue)

            -- Envoyer un message au joueur pour lui dire combien il a gagné
            net.Start("SellOrgansToNPC")
            net.WriteInt(totalValue, 32)
            net.Send(caller)
        else    
                caller:ChatPrint("Vous n'avez pas d'organes à vendre.")
        end
    end
end



