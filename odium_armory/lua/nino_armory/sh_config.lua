NAR = NAR or {}

NAR.PoliceToRob = 3

NAR.NotifyRepetitions = 10

NAR.TimeToCrack = 30 -- en secondes

NAR.TimeUntilRob = 1200

NAR.TimeUntilRobWhenFailure = 100

NAR.AlarmSoundLevel = 75

NAR.DistanceToRob = 15000

NAR.KeyToCrackString = "E"

NAR.WeaponCount = 5

NAR.Weapons = {
    [1] = {
        ["Name"] = "L85",
        ["Class"] = "m9k_l85",
        ["Model"] = "models/weapons/w_l85a2.mdl",
    },
    [2] = {
        ["Name"] = "G36C",
        ["Class"] = "m9k_g36",
        ["Model"] = "models/weapons/w_hk_g36c.mdl",
    },
    [3] = {
        ["Name"] = "AMD65",
        ["Class"] = "m9k_amd65",
        ["Model"] = "models/weapons/w_amd_65.mdl",
    },
    [4] = {
        ["Name"] = "SCAR",
        ["Class"] = "m9k_scar",
        ["Model"] = "models/weapons/w_fn_scar_h.mdl",
    },
    [5] = {
        ["Name"] = "MP7",
        ["Class"] = "m9k_mp7",
        ["Model"] = "models/weapons/w_mp7_silenced.mdl",
    },
	[6] = {
        ["Name"] = "Vector",
        ["Class"] = "m9k_vector",
        ["Model"] = "models/weapons/w_kriss_vector.mdl",
    },
	[7] = {
        ["Name"] = "M4A1",
        ["Class"] = "m9k_m4a1",
        ["Model"] = "models/weapons/w_rif_m4a1.mdl",
    },
    [8] = {
        ["Name"] = "HK416",
        ["Class"] = "m9k_m416",
        ["Model"] = "models/weapons/w_hk_416.mdl",
    },
}

-- FONCTIONS NE PAS TOUCHER
function NAR.GetTeamPlayers(teamsTable)
    if not istable(teamsTable) then return end

    local players = {}
    for k, v in ipairs(player.GetAll()) do
        if IsValid(v) then
            if teamsTable[team.GetName(v:Team())] then
                table.insert(players, v)
            end
        end
    end

    return players
end