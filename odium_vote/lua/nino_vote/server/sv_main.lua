/*
* @Author: Diesel
* @Date:   2023-02-01 18:10:45
* @Last Modified time: 2023-02-01 20:50:44
* @File: sv_main.lua
*/
util.AddNetworkString("NVT:Net:Vote")
util.AddNetworkString("NVT:Net:Votes")

local votes = {}

hook.Add("playerCanChangeTeam", "NVT:Hook:PlayerCanJoinTeam", function(ply, teamIndex, force)
    if not IsValid(ply) then return end

    if GAS.JobWhitelist:IsWhitelistEnabled(teamIndex) then
        if not GAS.JobWhitelist:IsWhitelisted(ply, teamIndex) then
            DarkRP.notify(ply, 1, 4, "Vous n'êtes pas whitelist !")
            return false, "Vous n'êtes pas whitelist !"
        end
    end

    for k,v in pairs(votes) do
        if v.TeamIndex == teamIndex then
            return false, "Un vote est en cours pour ce métier !"
        end
    end

    for k, v in ipairs(votes) do
        if v.Player == ply then
            return false, "Vous êtes déjà en vote, vous ne pouvez pas changer de métier !"
        end
    end

    if RPExtraTeams[teamIndex].nvtvote and not NVT.ByPassRanks[ply:GetUserGroup()] then

        table.insert(votes, {
            Player = ply,
            TeamIndex = teamIndex,
            PlayersVotes = {},
            VoteFor = 0,
            VoteAgainst = 0,
        })

        timer.Create("NVT:Timer:Votes:"..ply:SteamID64(), NVT.DelayToVote, 1, function()
            for k, v in ipairs(votes) do
                if v.Player == ply then
                    if v.VoteFor >= v.VoteAgainst then

                        ply:SetTeam(v.TeamIndex, true)
                        ply:setDarkRPVar("job", team.GetName(v.TeamIndex))
                        ply:StripWeapons()
                        ply:SetHealth(100)
                        ply:Spawn()
                        timer.Simple(0.1, function()
                            ply:StripWeapon("weapon_357")
                        end)

                        DarkRP.notify(ply, 0, 4, "Vous avez gagner le vote, félicitation !")
                    else
                        DarkRP.notify(ply, 1, 4, "Vous avez perdu le vote !")
                    end
                    
                    table.remove(votes, k)
                end
            end
        end)

        net.Start("NVT:Net:Vote")
            net.WriteTable(votes)
        net.Broadcast()

        return false

    end

    return true
end)

net.Receive("NVT:Net:Votes", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local uInt = net.ReadUInt(5)
    local k = net.ReadUInt(32)

    if not istable(votes[k]) then return end
    for k, v in ipairs(votes[k].PlayersVotes) do
        if v == ply:SteamID64() then return end
    end

    if uInt == 1 then
        votes[k].VoteFor = votes[k].VoteFor + 1
    elseif uInt == 2 then
        votes[k].VoteAgainst = votes[k].VoteAgainst + 1
    end

    DarkRP.notify(ply, 0, 4, "Votre vote a été comptabilisé.")
    table.insert(votes[k].PlayersVotes, ply:SteamID64())
end)