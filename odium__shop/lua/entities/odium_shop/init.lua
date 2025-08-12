util.AddNetworkString("ODium::FrameShop")
util.AddNetworkString("ODium::BuyWeapon")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:SetModel("models/player/gman_high.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetSequence(self:LookupSequence("cower"))
end

function ENT:Use(ply, act)
    if IsValid(ply) and ply:IsPlayer() then
        net.Start("ODium::FrameShop")
        net.Send(ply)
    end
end

net.Receive("ODium::BuyWeapon", function(len, ply)
    local weaponClass = net.ReadString()
    local weaponPrice = net.ReadInt(32)
    if weaponPrice < 0 then return end

    if ply:getDarkRPVar("money") >= weaponPrice then
        ply:addMoney(-weaponPrice)
        ply:Give(weaponClass)
end)