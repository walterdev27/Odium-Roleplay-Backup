resource.AddFile("materials/nino-echap-menu/discord.png")
resource.AddFile("materials/nino-echap-menu/logo.png")

util.AddNetworkString("NinoEchapMenu::Nets::CreateAdd")
util.AddNetworkString("NinoEchapMenu::Nets::OpenAdd")
util.AddNetworkString("NinoEchapMenu::Nets::Update")
util.AddNetworkString("NinoEchapMenu::Nets::DeleteAdd")
hook.Add("PlayerSay", "NinoEchapMenu::Hooks::PlayerSay", function(ply, text)
    if not IsValid(ply) then return end

    if NinoEchapMenu.Command == text and NinoEchapMenu.Admin[ply:GetUserGroup()] then
        net.Start("NinoEchapMenu::Nets::OpenAdd")
        net.Send(ply)

        return " "
    end
end)

function NinoEchapMenu.MakeSQLRequest(query)
    if not sql.TableExists("ninoechapmenu") then
        sql.Query("CREATE TABLE IF NOT EXISTS ninoechapmenu (Nom TEXT, Description TEXT, Date TEXT)")
    end

    return sql.Query(query)
end

function NinoEchapMenu.Send(ply)
    local data = NinoEchapMenu.MakeSQLRequest("SELECT * FROM ninoechapmenu")
    if data then
        timer.Simple(1, function()
            net.Start("NinoEchapMenu::Nets::Update")
                net.WriteTable(data)
            net.Send(ply)
        end)
    end
end 

hook.Add("PlayerInitialSpawn", "NinoEchapMenu::Hooks::PlayerInitialSpawn", NinoEchapMenu.Send)
hook.Add("PlayerSpawn", "NinoEchapMenu::Hooks::PlayerSpawn", NinoEchapMenu.Send)

net.Receive("NinoEchapMenu::Nets::CreateAdd", function(len, ply)
    if not IsValid(ply) then return end
    if not NinoEchapMenu.Admin[ply:GetUserGroup()] then return end

    local data = net.ReadTable()
    if data then
        NinoEchapMenu.MakeSQLRequest("INSERT INTO ninoechapmenu (Nom, Description, Date) VALUES(" .. sql.SQLStr(data["nom"]) ..", " .. sql.SQLStr(data["description"]) .. ", " .. sql.SQLStr(os.time()) .. ")")

        for key, value in ipairs(player.GetAll()) do
            NinoEchapMenu.Send(value)
        end
    end
end)

net.Receive("NinoEchapMenu::Nets::DeleteAdd", function(len, ply)
    if not IsValid(ply) then return end
    if not NinoEchapMenu.Admin[ply:GetUserGroup()] then return end

    local data = net.ReadString()
    if data then
        NinoEchapMenu.MakeSQLRequest("DELETE FROM ninoechapmenu WHERE Date = " .. sql.SQLStr(data) ..";")
    end

    for key, value in ipairs(player.GetAll()) do
        NinoEchapMenu.Send(value)
    end
end)