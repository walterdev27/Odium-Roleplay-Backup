odpoints.Inventory = {}

local pMeta = FindMetaTable( "Player" )

function pMeta:SetOdpoints(amount)
    self:SetNWInt('odpoints', amount)
    self:SetPData( "odpoints", amount )
end

function pMeta:AddOdpoints(amount)
    self:SetOdpoints(amount + self:GetOdpoints())
end

function RemoveAllOdpoints()
    self:RemovePData("odpoints")
end

hook.Add("PlayerInitialSpawn", "Odium:RecupOdpoints", function(ply)
    ply:SetNWInt("odpoints", ply:GetPData("odpoints", 0))
    //ply:SetOdpoints(odpoints.Config.StartedPoint)
end)



concommand.Add("odium_add_coin",function(ply)
    local points = 10000
    if !ply:IsSuperAdmin() then return end
    ply:AddOdpoints(10000000)
    ply:ChatPrint(points.." Odpoints vous ont était ajouter ")
    ply:ChatPrint("Vous êtes maintenant a "..string.Comma(ply:GetOdpoints(),",").." ODPoints")
end)

concommand.Add("odium_getcoin",function(ply)
    print(ply:GetOdpoints())
    ply:ChatPrint("Vous avez actuellement "..ply:GetOdpoints().." ODpoint sur le serveur")
end)

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
////////////////////// INVENTORY ACTION /////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

function odpoints.Inventory:GetInventory(ply)
    local inventory =  odpoints.Inventory:Load(ply)
    PrintTable(inventory)
end


function odpoints.Inventory:Save(ply,inventory)
    local jsonInventory = util.TableToJSON(inventory)
    ply:SetPData("inventory",jsonInventory)
end


function odpoints.Inventory:Load(ply)
    local jsonInventory = ply:GetPData("inventory","")
    local inventory = util.JSONToTable(jsonInventory) || {}
    return inventory
end



function odpoints.Inventory:BuyWeapon(ply,weaponName)
    local inventory =  odpoints.Inventory:Load(ply)
    if not table.HasValue(inventory,weaponName) then
        table.insert(inventory,weaponName)
        SaveInventory(ply,inventory)
        print(ply:Nick().." a acheter "..weaponName)
    else
        print(ply:Nick().."possède deja "..weaponName)
    end
end

function odpoints.Inventory:EquipWeapon(ply,weaponName)
    local inventory =  odpoints.Inventory:Load(ply)
    if table.HasValue(inventory,weaponName) then
        print(ply:Nick().."a équipé "..weaponName)
    else
        print(ply:Nick().." ne possède pas "..weaponName)
    end
end

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
///////////////////////// ADMIN ACTION //////////////////////////
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

odpoints.Inventory.AdminAction = {}

function odpoints.Inventory.AdminAction:RemoveToInventory(ply,cmd,args)
    if ! ply:IsAdmin() then
        print("You are not allowed to acces this command ! ")
        return 
    end
    local targetPlayer = FindPlayerByName(args[1])
    local weaponName = args[2]

    if !IsValid(targetPlayer) then
        print("Joueur introuvable")
        return 
    end

    local inventory = odpoints.Inventory:Load(targetPlayer)

    if table.HasValue(inventory,weaponName) then
        table.RemoveByValue(inventory,weaponName)
        SaveInventory(targetPlayer,inventory)
        print("arme retirer de l'inventaire de "..targetPlayer:Nick())
    else
        print(targetPlayer:Nick().."ne possède pas "..weaponName)
    end
end

function odpoints.Inventory.AdminAction:AddToInventory(ply, cmd, args)
    if not ply:IsAdmin() then
        print("You are not allowed to acces this command ! ")
        return
    end
    local targetPlayer = FindPlayerByName(args[1])
    local weaponName = args[2]
    if not IsValid(targetPlayer) then
        print("Joueur introuvable.")
        return
    end
    local inventory = odpoints.Inventory:Load(targetPlayer)
    if not table.HasValue(inventory, weaponName) then
        table.insert(inventory, weaponName)
        SaveInventory(targetPlayer, inventory)
        print("Arme ajoutée à l'inventaire de " .. targetPlayer:Nick() .. ": " .. weaponName)
    else
        print(targetPlayer:Nick() .. " possède déjà cette arme dans son inventaire.")
    end
end 