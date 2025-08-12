AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(AlonesRP_Mining.RockModels[math.random(1, #AlonesRP_Mining.RockModels)])
	self:PhysicsInit(SOLID_VPHYSICS) 
	self:SetMoveType(MOVETYPE_NONE) 
	self:SetSolid(SOLID_VPHYSICS) 

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetRockHealth(100)
	self.Replace = false
end

function ENT:SpawnFunction(ply, tr, class)
	if not tr.Hit then return end
	
	local spawnAng = ply:EyeAngles()
	spawnAng.p = 0
	spawnAng.y = spawnAng.y + 180

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(spawnAng)
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Think()
	if (!self.Replace) and (self:GetRockHealth() <= 0)  then
		self:EmitSound( "ambient/levels/dog_v_strider/dvs_rockslide.wav" )
		self.Replace = true
		self.ReplaceTime = CurTime() + AlonesRP_Mining.TimeRespawn
		self.Pos = self:GetPos()
		self:SetPos(self:GetPos() + Vector(0,0,-300))
		
		local rock = ents.Create("alonesrp_minirock")
		rock:SetPos(self.Pos + Vector(0,0,30))
		rock:Spawn()
		local rock2 = ents.Create("alonesrp_minirock")
		rock2:SetPos(self.Pos + Vector(0,0,100))
		rock2:Spawn()
		local rock3 = ents.Create("alonesrp_minirock")
		rock3:SetPos(self.Pos + Vector(0,0,170))
		rock3:Spawn()
		local rock4 = ents.Create("alonesrp_minirock")
		rock4:SetPos(self.Pos + Vector(0,0,220))
		rock4:Spawn()
		constraint.Weld(rock, rock2, 0, 0, 500, true, false)
		constraint.Weld(rock2, rock3, 0, 0, 500, true, false)
		constraint.Weld(rock3, rock4, 0, 0, 500, true, false)

		if math.random(1, 100) <= AlonesRP_Mining.DiamondLuck then
			local diamond = ents.Create("alonesrp_diamond")
			diamond:SetPos(self.Pos + Vector(0,0,60))
			diamond:Spawn()
		end
	end 
		
	if (self.Replace) and (self.ReplaceTime < CurTime())  then
		self:SetRockHealth(100)
		self.Replace = false
		self:SetPos(self.Pos)
	end
end 	

function ENT:OnTakeDamage(dmg)
	local ply = dmg:GetAttacker()
	if not ply:IsValid() then return end
	if (dmg:GetInflictor():GetClass() == "alonesrp_pickaxe") or (dmg:GetAttacker():GetActiveWeapon():GetClass() == "alonesrp_pickaxe") then
		self:SetRockHealth(self:GetRockHealth() -  math.random(8, 16))
	end
end