odiumshop = odiumshop or {}

-- Que pour la category arme 
odiumshop.Arme = "Armes"

odiumshop.sheets = {
    {name = odiumshop.Arme, icon = "icon16/error.png"},
    {name = "Munitions", icon = "icon16/information.png"},
    {name = "Objets", icon = "icon16/information.png"},
}

odiumshop.Categories = {
    [1] = {
        ["Name"] = odiumshop.Arme,
        ["Weapons"] = {
            [1] = {
                ["Name"] = "Beretta M92",
                ["Desc"] = "Arme de poings / Pistolet / Chargeur 15 balles",
                ["Class"] = "m9k_m92beretta",
                ["Model"] = "models/weapons/w_beretta_m92.mdl",
                ["Price"] = 45000,
            },     
            [2] = {
                ["Name"] = "HK45C",
                ["Desc"] = "Arme de poings / Pistolet / Chargeur 8 balles",
                ["Class"] = "m9k_hk45",
                ["Model"] = "models/weapons/w_hk45c.mdl",
                ["Price"] = 55000,       
            },
            [3] = {
                ["Name"] = "Raging Bull",
                ["Desc"] = "Arme de poings / Magnum / Chargeur 6 balles",
                ["Class"] = "m9k_deagle",
                ["Model"] = "models/weapons/w_taurus_raging_bull.mdl",
                ["Price"] = 65000,       
            },
            [4] = {
                ["Name"] = "Desert Eagle",
                ["Desc"] = "Arme de poings / Magnum / Chargeur 7 balles",
                ["Class"] = "m9k_deagle",
                ["Model"] = "models/weapons/w_tcom_deagle.mdl",
                ["Price"] = 85000,       
            },      
            [5] = {
                ["Name"] = "UZI",
                ["Desc"] = "Arme Légère / Pistolet-Mitrailleur / Chargeur 32 balles",
                ["Class"] = "m9k_uzi",
                ["Model"] = "models/weapons/w_uzi_imi.mdl",
                ["Price"] = 90000,       
            },
            [6] = {
                ["Name"] = "Kriss Vector",
                ["Desc"] = "Arme Légère / Pistolet-Mitrailleur / Chargeur 30 balles",
                ["Class"] = "m9k_vector",
                ["Model"] = "models/weapons/w_kriss_vector.mdl",
                ["Price"] = 125000,
            },
            [7] = {
                ["Name"] = "Mossberg 590",
                ["Desc"] = "Arme Lourde / Fusil à pompe / Chargeur 8 balles",
                ["Class"] = "m9k_mossberg590",
                ["Model"] = "models/weapons/w_mossberg_590.mdl",
                ["Price"] = 185000,
            },
            [8] = {
                ["Name"] = "AK-47",
                ["Desc"] = "Arme Lourde / Fusil d'assaut / Chargeur 30 balles",
                ["Class"] = "m9k_ak47",
                ["Model"] = "models/weapons/w_ak47_m9k.mdl",
                ["Price"] = 180000,
            },
            [9] = {
                ["Name"] = "AS VAL",
                ["Desc"] = "Arme Lourde / Fusil d'assaut / Chargeur 20 balles",
                ["Class"] = "m9k_val",
                ["Model"] = "models/weapons/w_dmg_vally.mdl",
                ["Price"] = 155000,
            },
        }
    },
    [2] = {
        ["Name"] = "Munitions",
        ["Weapons"] = {
            [1] = {
                ["Name"] = "Fusil d'assaut",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_ar2",
                ["Model"] = "models/items/boxmrounds.mdl",
                ["Price"] = 5000,       
            },
            [2] = {
                ["Name"] = "Fusil à pompe",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_buckshot",
                ["Model"] = "models/items/boxbuckshot.mdl",
                ["Price"] = 6500,       
            },
            [3] = {
                ["Name"] = "Pistolet-Mitrailleur",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_smg",
                ["Model"] = "models/weapons/w_ammobox_thrown.mdl",
                ["Price"] = 3500,       
            },
            [4] = {
                ["Name"] = "Sniper",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_sniper_rounds",
                ["Model"] = "models/items/sniper_round_box.mdl",
                ["Price"] = 8500,       
            },
            [5] = {
                ["Name"] = "357 Magnum",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_357",
                ["Model"] = "models/items/357ammo.mdl",
                ["Price"] = 2500,       
            },
            [6] = {
                ["Name"] = "Pistolet",
                ["Desc"] = "↑",
                ["Class"] = "m9k_ammo_pistol",
                ["Model"] = "models/weapons/w_ammobox_thrown.mdl",
                ["Price"] = 2000,       
            },
            [7] = {
                ["Name"] = "CW Warface",
                ["Desc"] = "↑",
                ["Class"] = "cw_ammo_kit_regular",
                ["Model"] = "models/items/boxmrounds.mdl",
                ["Price"] = 10000,       
            },
        }
    },
    [3] = {
        ["Name"] = "Objets",
        ["Weapons"] = {
            [1] = {
                ["Name"] = "Scie",
                ["Desc"] = "Découpe tes concurrents et/ou défonce les portes",
                ["Class"] = "tfa_nmrih_asaw",
                ["Model"] = "models/weapons/tfa_nmrih/w_me_abrasivesaw.mdl",
                ["Price"] = 30000,       
            },
            [2] = {
                ["Name"] = "Serflex",
                ["Desc"] = "Permet d'attacher un individu / bâillonner / bander les yeux / traîner",
                ["Class"] = "weapon_r_restrains",
                ["Model"] = "models/tobadforyou/flexcuffs_deployed.mdl",
                ["Price"] = 55000,       
            },
            [3] = {
                ["Name"] = "Bâton",
                ["Desc"] = "Permet d'assomer un individu en le frappant dans le dos",
                ["Class"] = "weapon_r_baton",
                ["Model"] = "models/weapons/w_stunbaton.mdl",
                ["Price"] = 50000,       
            },
            [4] = {
                ["Name"] = "LockPick",
                ["Desc"] = "Permet de crocheter des serrures",
                ["Class"] = "lockpick",
                ["Model"] = "models/weapons/w_crowbar.mdl",
                ["Price"] = 60000,       
            },
            [5] = {
                ["Name"] = "Keypad Cracker",
                ["Desc"] = "Permet de pirater des keypads",
                ["Class"] = "keypad_cracker",
                ["Model"] = "models/weapons/w_c4.mdl",
                ["Price"] = 60000,       
            },
            [6] = {
                ["Name"] = "Kevlar 100",
                ["Desc"] = "Gilet Léger",
                ["Class"] = "light kevlar armor",
                ["Model"] = "models/cpk_kevlar/kevlar_bluecamo.mdl",
                ["Price"] = 60000,       
            },
            [7] = {
                ["Name"] = "Kevlar 150",
                ["Desc"] = "Gilet Lourd",
                ["Class"] = "medium kevlar armor",
                ["Model"] = "models/cpk_kevlar/kevlar_camo.mdl",
                ["Price"] = 80000,       
            },
        }
    },
}
