MyLib = MyLib or {}

-- Color du serveur

    MyLib.ColorServer = {
        ["Green"] = Color(32, 122, 100),
        ["GreentSecond"] = Color(32, 105, 100),
        ["GreenClaire"] = Color(75, 225, 105),
        ["GreenBlueClaire"] = Color(69, 209, 180),
        ["Black"] = Color(32, 32, 32),
        ["BlackSeconde"] = Color(32, 32, 32, 230),
        ["white"] = Color(255, 255, 255),
        ["Red"] = Color(241, 68, 68),
        ["grey"] = Color(210, 210, 210),
        --peut etre des couleur du hud ou autre
        ["BlackTranspa"] = Color(35, 35, 35, 235),
        ["BlackTranspa2"] = Color(35, 35, 35, 225),
        ["GreenTranspa"] = Color(32, 122, 100, 235),
        --peut etre des couleur du F4 ou autre
        ["BlackF4"] = Color(45, 45, 45),
        ["BlackF4Second"] = Color(56, 56, 56),
        ["GreenSecondF4"] = Color(45, 158, 130),
	    ["GreenSecond2F4"] = Color(37, 83, 72),
    }

-- Logo du serveur

    MyLib.logoOdium = {
    	["OdiumBaseLogoRond"] = Material("odium_echap_menu/odium_echap.png", "noclamp smooth"),
        ["OdiumBase"] = Material("odium_hud_icon/odiumiconhud.png", "noclamp smooth"),
        ["GradientBas"] = Material("odium_general_logo/gradientsOne.png", "noclamp smooth"),
        ["GradientHaut"] = Material("odium_general_logo/gradients.png", "noclamp smooth"),
        ["GradientRond"] = Material("odium_general_logo/rondneon.png", "noclamp smooth"),
    }

-- Job qui peuvent braquer banque, armory, micromania ect

    MyLib.RobGeneralTeam = {
        ["Chef du Cartel"] = true,
        ["Cartel"] = true,
        ["Cartel V.I.P"] = true,
        ["Chef des Gangster"] = true,
        ["Gangster"] = true,
        ["Gangster V.I.P"] = true,
        ["Parrain"] = true,
        ["Mafieux"] = true,
        ["Mafieux V.I.P"] = true,
        ["Chef des Bandidos"] = true,
        ["Bandidos"] = true,
        ["Bandidos V.I.P"] = true,
        ["Chef des Ballas"] = true,
        ["Ballas"] = true,
        ["Ballas V.I.P"] = true,
        ["Chef des Families"] = true,
        ["Families"] = true,
        ["Families V.I.P"] = true,
        ["Ottoman"] = true,
        ["Azarov"] = true,
        ["Parkinson"] = true
    }

    MyLib.PoliceTeams = {
        ["Cadets"] = true,
        ["Police"] = true,
        ["SWAT"] = true,
        ["Chef Police"] = true,
        ["Chef SWAT"] = true,
        ["FBI"] = true,
        ["ERI"] = true,
    }

    -- Mrs Logo en haut à gauche et autre

    MyLib.MrsLogoHautGauche = {
        ["Cadets"] = true,
        ["Police"] = true,
        ["SWAT"] = true,
        ["FBI"] = true,
        ["ERI"] = true,
        ["Chef Police"] = true,
        ["Chef SWAT"] = true,
        ["Azarov"] = true,
        ["Parkinson"] = true,
        ["Ottoman"] = true,
        ["Cartel de Medellín"] = true
    }

    -- Perm staff avec menu C

    MyLib.StaffGeneralPrincipalePerm = {
        ["superadmin"] = true,
        ["Chef Serveur"] = true,
        ["Gérant Staff"] = true,
        ["superadministrateur"] = true,
        ["admin"] = true,
        ["Moderateur"] = true,
        ["Moderateur Test"] = true,
        ["Helpeur"] = true,
    }

    --Pour voire les job dans le tab et commande dans le tab
    MyLib.AllPerm = {
        ["superadmin"] = true,
        ["Chef Serveur"] = true,
        ["Gérant Staff"] = true,
        ["superadministrateur"] = true,
    }

                
------------------------------- Config Lien 

--Discord odium : 
MyLib.discordbase = "https://discord.gg/TGxpzv7jPT"
--Discord Police : 
MyLib.discordpolice = "https://discord.gg/HuatJKHGsJ"
--Lien forum : 
MyLib.forum = "https://odium-roleplay.fr/forum"
--Lien Regle : 
MyLib.regle = "https://odium-roleplay.fr/forum"

                 
------------------------------- Config Lien 
    



------------------------------- Config TAB 

    --Job Visible dans le tab joueur
    MyLib.JobsVisibleTab = {"Police", "Cadets", "SWAT", "Chef Police", "Chef SWAT", "ERI", "Samu", "Armurier", "Maire", "Cuisinier"}

    --Job Tab et commande mute
    MyLib.AllGroupsTab = {
        ["superadmin"] = true,
        ["Chef Serveur"] = true,
        ["Gérant Staff"] = true,
        ["superadministrateur"] = true,
        ["admin"] = true,
        ["Moderateur"] = true,
        ["Moderateur Test"] = true,
        ["Helpeur"] = true,
        ["VIPEmeraude"] = true,
        ["VIPEtoile"] = true,
        ["VIPSaphir"] = true,
        ["VIP+"] = true,
        ["VIP"] = true,
        ["user"] = true,
    }

    -- Commmande Helpeur et les autre 
    MyLib.commandeHelpeur = {
        ["Helpeur"] = true,
        ["Moderateur Test"] = true,
        ["Moderateur"] = true,
        ["admin"] = true,
        ["superadministrateur"] = true,
        ["Gérant Staff"] = true,
        ["Chef Serveur"] = true,
        ["superadmin"] = true,
        
    }

    -- Commmande ModerateurTest et meme Helpeur et les autre 
    MyLib.commandeModerateurTestHelpeurEct = {
        ["Helpeur"] = true,
        ["Moderateur Test"] = true,
        ["Moderateur"] = true,
        ["admin"] = true,
        ["superadministrateur"] = true,
        ["Gérant Staff"] = true,
        ["Chef Serveur"] = true,
        ["superadmin"] = true,
        
    }

    -- Commande Moderateur et les autre
    MyLib.commandeModerateur = {
        ["Moderateur"] = true,
        ["admin"] = true,
        ["superadministrateur"] = true,
        ["Gérant Staff"] = true,
        ["Chef Serveur"] = true,
        ["superadmin"] = true,
        
    }

    -- Commande Admin et les autre
    MyLib.commandeAdmin = {
        ["admin"] = true,
        ["superadministrateur"] = true,
        ["Chef Serveur"] = true,
        ["Gérant Staff"] = true,
        ["superadmin"] = true,
        
    }

------------------------------- Job dans le tab 
                

