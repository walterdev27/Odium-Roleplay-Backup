AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/poumonsmort/poumonsmort.mdl")
	local priceRange = itemPrices[self:GetClass()]
    self.price = math.random(priceRange.min, priceRange.max)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then
        local itemName = self:GetClass()
        caller:SetNWInt(itemName, caller:GetNWInt(itemName, 0) + 1)
        caller:SetNWInt(itemName .. "_price", self:GetNWInt("organPrice"))
        self:Remove()
    end
end