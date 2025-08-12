AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    
    if not ply:HasWeapon(self:GetClasss()) then
        if IsValid(self) then
            ply:Give(self:GetClasss())
            self:Remove()
        end
    else
        DarkRP.notify(ply, 1, 4, "Vous avez déjà cette arme sur vous.")
    end
end