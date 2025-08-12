ZLS.JobTimer.Config = ZLS.JobTimer.Config or {}

-- Job list for the time system
ZLS.JobTimer.Config.JobsList = {
    ["Chef SWAT"] = {
        ['name'] = 'SWAT',
        ['jobs'] = {
            ["Chef SWAT"] = true,
            ["SWAT"] = true,
        }
    },
    ["Chef Police"] = {
        ['name'] = 'Police',
        ['jobs'] = {
            ["Chef Police"] = true,
            ["Police"] = true,
        }
    },
    ["Chef Police"] = {
        ['name'] = 'ERI',
        ['jobs'] = {
            ["ERI"] = true,
        }
    },
	["Staff"] = {
        ['name'] = 'Staff',
        ['jobs'] = {
            ["Staff"] = true,
		}
	},
    ["Parkinson"] = {
        ['name'] = 'Famille Parkinson',
        ['jobs'] = {
            ["Parkinson"] = true,
        }
    },
    ["Azarov"] = {
        ['name'] = 'Famille Azarov',
        ['jobs'] = {
            ["Azarov"] = true,
        }
    },
}

-- Admin ranks for view all job times
ZLS.JobTimer.Config.AdminRanks = {
	["Fondateur"] = true,
    ["superadmin"] = true,
    ["Chef Serveur"] = true,
	["Gérant Staff"] = true
}

-- Command for open the menu
ZLS.JobTimer.Config.Command = "!odtime"