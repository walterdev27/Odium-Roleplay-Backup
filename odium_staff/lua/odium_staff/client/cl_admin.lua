net.Receive("MonAddonAdmin:HealPlayer", function() end)
net.Receive("MonAddonAdmin:FeedPlayer", function() end)
net.Receive("MonAddonAdmin:KillPlayer", function() end)
net.Receive("MonAddonAdmin:FreezePlayer", function() end)
net.Receive("MonAddonAdmin:SetPlayerJob", function() end)
local freezeButtons = {}

local function ShowPlayerMenu(ply)
    if MyLib.StaffGeneralPrincipalePerm[LocalPlayer():GetUserGroup()] then
            local menu = DermaMenu()

        if MyLib.AllPerm[LocalPlayer():GetUserGroup()] or LocalPlayer():IsSuperAdmin() then
            local healButton = menu:AddOption("Nombre de ticket", function()
                hook.Run("AdminTicketButtonClicked", selectedPlayer)
            end)
            healButton:SetImage("icon16/drive.png")
        end

        -- Bouton Sanctions
        local sanctionButton = menu:AddOption("Sanctions")
        sanctionButton:SetImage("icon16/exclamation.png")
        local sanctionMenu = DermaMenu(sanctionButton)
        sanctionButton:SetSubMenu(sanctionMenu)

        -- Sous-menu Sanctions - Avertissement
        warnButton = sanctionMenu:AddOption("Avertissement", function()
            hook.Run("AdminWarningButtonClicked", selectedPlayer)
        end)
        warnButton:SetImage("icon16/page_white_delete.png")
        banButton = sanctionMenu:AddOption("Bannissement", function()
            hook.Run("AdminBanButtonClicked", selectedPlayer)
        end)
        banButton:SetImage("icon16/user_delete.png")

        menu:AddSpacer()

        --Bouton Soigner
        local healButton = menu:AddOption("Soigner", function()
            net.Start("MonAddonAdmin:HealPlayer")
            net.WriteEntity(ply)
            net.SendToServer()
        end)
        healButton:SetImage("icon16/heart.png")

        -- Bouton Nourrir
        local feedButton = menu:AddOption("Nourrir", function()
            net.Start("MonAddonAdmin:FeedPlayer")
            net.WriteEntity(ply)
            net.SendToServer()
        end)
        feedButton:SetImage("icon16/cup.png")

        -- Bouton Tuer
        local killButton = menu:AddOption("Tuer le joueur", function()
            net.Start("MonAddonAdmin:KillPlayer")
            net.WriteEntity(ply)
            net.SendToServer()
        end)
        killButton:SetImage("icon16/cross.png")

        -- Bouton Geler
        local isFrozen = ply:IsFrozen()
        freezeButtons[ply] = menu:AddOption(isFrozen and "Dégeler" or "Geler", function()
            net.Start("MonAddonAdmin:FreezePlayer")
            net.WriteEntity(ply)
            net.SendToServer()
        end)
        freezeButtons[ply]:SetImage("icon16/weather_snow.png")

        menu:AddSpacer()

        -- Bouton Changer de métier
        local jobsButton = menu:AddOption("Changer de métier")
        jobsButton:SetImage("icon16/user_go.png")
        local jobsMenu = DermaMenu(jobsButton)
        jobsButton:SetSubMenu(jobsMenu)

        for _, job in ipairs(RPExtraTeams) do
            jobsMenu:AddOption(job.name, function()
                net.Start("MonAddonAdmin:SetPlayerJob")
                net.WriteEntity(ply)
                net.WriteUInt(job.team, 16)
                net.SendToServer()
            end)
        end

        -- Ouvrir le sous-menu au bon endroit
        jobsButton.DoClick = function()
            local x, y = menu:GetPos()
            jobsMenu:SetPos(x + menu:GetWide(), y)
            jobsMenu:MoveToFront()
            jobsMenu:Open()
        end

        -- Bouton Téléportation
        local teleportButton = menu:AddOption("Téléportation")
        teleportButton:SetImage("icon16/arrow_out.png")
        local teleportMenu = DermaMenu(teleportButton)
        teleportButton:SetSubMenu(teleportMenu)

        -- Sous-menu Téléportation - Voiture
        local teleportToCarButton = teleportMenu:AddOption("Voiture", function()
            net.Start("MonAddonAdmin:TeleportToCar")
            net.WriteEntity(ply)
            net.SendToServer()
        end)
        teleportToCarButton:SetImage("icon16/car.png")

        -- Sous-menu Téléportation - Joueur
        local teleportToPlayerButton = teleportMenu:AddOption("Joueur")
        teleportToPlayerButton:SetImage("icon16/user_go.png")
        local teleportToPlayerMenu = DermaMenu(teleportToPlayerButton)
        teleportToPlayerButton:SetSubMenu(teleportToPlayerMenu)

        for _, target in ipairs(player.GetAll()) do
            if target ~= ply then
                local option = teleportToPlayerMenu:AddOption(target:Nick(), function()
                    net.Start("MonAddonAdmin:TeleportToPlayer")
                    net.WriteEntity(ply)
                    net.WriteEntity(target)
                    net.SendToServer()
                end)
            end
        end  

        menu:Open()
    end

end

net.Receive("MonAddonAdmin:UpdateFreezeState", function()
    local target = net.ReadEntity()
    local isFrozen = net.ReadBool()

    if IsValid(target) and target:IsPlayer() then
        local freezeText = isFrozen and "Dégeler" or "Geler"
        local freezeButton = freezeButtons[target:EntIndex()]

        if IsValid(freezeButton) then
            freezeButton:SetText(freezeText)
        end
    end
end)

hook.Add("GUIMousePressed", "MonAddonAdmin:OpenPlayerMenu", function(mouseCode, aimVector)
    if mouseCode == MOUSE_RIGHT and input.IsKeyDown(KEY_C) then
        local tr = LocalPlayer():GetEyeTrace()
        if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
            ShowPlayerMenu(tr.Entity)
            return false 
        end
    end
end)

--hook.Add("GUIMousePressed", "MonAddonAdmin:OpenMenu", function(mouseCode, aimVector)
--    if mouseCode == MOUSE_RIGHT then 
--        local tr = LocalPlayer():GetEyeTrace()
--        ShowMenu()
--        return false 
--    end
--end)

hook.Add("PlayerBindPress", "MonAddonAdmin:CloseJobPanel", function(ply, bind, pressed)
    if not pressed and string.lower(bind) == "noclip" then
        local jobPanel = gmod.GetGamemode().DarkRPMenu
        if jobPanel and jobPanel:IsVisible() then
            jobPanel:Close()
        end
    end
end)
