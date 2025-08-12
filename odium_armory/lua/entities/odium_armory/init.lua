AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/sterling/weapon_locker_v2.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self:SetIsRobable(true)
    self:SetStatus(0)
    self:SetReload(false)
end

function ENT:Use(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:GetPos():DistToSqr(self:GetPos()) > NAR.DistanceToRob then return end

    if not self:GetIsRobable() then 
        if timer.Exists("NAR:Timer:RobCooldown:"..self:EntIndex()) and timer.TimeLeft("NAR:Timer:RobCooldown:"..self:EntIndex()) > 0 then 
            DarkRP.notify(ply, 1, 4, "Vous devez attendre "..math.Round(timer.TimeLeft("NAR:Timer:RobCooldown:"..self:EntIndex())).." secondes avant de rebraquer l'armurerie.")
        elseif timer.Exists("NAR:Timer:RobCooldownFailure:"..self:EntIndex()) and timer.TimeLeft("NAR:Timer:RobCooldownFailure:"..self:EntIndex()) > 0 then
            DarkRP.notify(ply, 1, 4, "Vous devez attendre "..math.Round(timer.TimeLeft("NAR:Timer:RobCooldownFailure:"..self:EntIndex())).." secondes avant de rebraquer l'armurerie.")
        else
            DarkRP.notify(ply, 1, 4, "Vous ne pouvez pas braquer l'armurerie.")
        end
        return
    end

    if not MyLib.RobGeneralTeam[team.GetName(ply:Team())] then 
        DarkRP.notify(ply, 1, 4, "Vous n'avez pas le bon métier pour braquer.")
        return 
    end

    if #NAR.GetTeamPlayers(MyLib.PoliceTeams) < NAR.PoliceToRob then
        DarkRP.notify(ply, 1, 4, "Il n'y assez pas de policier.")
        return
    end

    DarkRP.notify(ply, 0, 4, "Le braquage a commencé ne vous éloigné pas trop de l'armurerie !")
    self:SetIsRobable(false)

    self:EmitSound("ambient/alarms/alarm1.wav", NAR.AlarmSoundLevel)

    NAR.NotifyPolice(MyLib.PoliceTeams, "Braquage de l'armurerie en cours !", NAR.NotifyRepetitions)

    timer.Create("NAR:Timer:Status:"..self:EntIndex(), 1, 0, function()
        if IsValid(self) and IsValid(ply) then
            if ply:GetPos():DistToSqr(self:GetPos()) <= NAR.DistanceToRob then
                if self:GetStatus() >= NAR.TimeToCrack then

                    DarkRP.notify(ply, 0, 4, "Vous avez réussi le braquage !")
                    timer.Remove("NAR:Timer:Status:"..self:EntIndex())

                    self:SetStatus(0)
                    self:SetReload(true)

                    self:StopSound("ambient/alarms/alarm1.wav")

                    NAR.TimerCreate(self, "NAR:Timer:RobCooldown:"..self:EntIndex(), NAR.TimeUntilRob)

                    NAR.GiveRewards(ply, self)
                else
                    self:SetStatus(self:GetStatus() + 1)
                end
            else
                DarkRP.notify(ply, 1, 4, "Vous avez raté le braquage !")
                timer.Remove("NAR:Timer:Status:"..self:EntIndex())
                
                self:SetStatus(0)
                self:SetReload(true)

                self:StopSound("ambient/alarms/alarm1.wav")

                NAR.TimerCreate(self, "NAR:Timer:RobCooldownFailure:"..self:EntIndex(), NAR.TimeUntilRobWhenFailure)
            end
        else
            timer.Remove("NAR:Timer:Status:"..self:EntIndex())
        end
    end)
end