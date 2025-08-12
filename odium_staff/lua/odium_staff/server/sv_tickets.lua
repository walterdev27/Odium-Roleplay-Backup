if SERVER then
    util.AddNetworkString("reportTicketSubmit")
    util.AddNetworkString("reportTicketToStaff")
    util.AddNetworkString("removeTicketFromStaff")
    util.AddNetworkString("addFinishedTicket")
    util.AddNetworkString("refreshFinishedTickets")
    util.AddNetworkString("updateFinishedTickets")


end

if SERVER then
    net.Receive("reportTicketSubmit", function(len, ply)
        local reason = net.ReadString()
        for _, v in ipairs(player.GetAll()) do
            if v:Team() == TEAM_STAFF then
                v:ChatPrint(ply:Nick() .. " a soumis un ticket avec la raison: " .. reason)
            end
        end
    end)
end

if SERVER then
    net.Receive("reportTicketSubmit", function(len, ply)
        local reason = net.ReadString()
        for _, v in ipairs(player.GetAll()) do
            if v:Team() == TEAM_STAFF then
                net.Start("reportTicketToStaff")
                net.WriteEntity(ply)
                net.WriteString(reason)
                net.Send(v)
            end
        end
    end)
end

if SERVER then
    net.Receive("removeTicketFromStaff", function(len, ply)
        local ticketNumber = net.ReadUInt(32)
        for _, v in ipairs(player.GetAll()) do
            if v:Team() == TEAM_STAFF and v ~= ply then
                net.Start("removeTicketFromStaff")
                net.WriteUInt(ticketNumber, 32)
                net.Send(v)
            end
        end
    end)
end

sql.Query("CREATE TABLE IF NOT EXISTS finished_tickets (author TEXT, date TEXT, count INTEGER)")

function incrementFinishedTicketsForPlayer(ply)
    local plyName = ply:Nick()
    local ticketDate = os.date("%Y-%m-%d")
    local ticketCount = 1

    local existingEntry = sql.Query("SELECT * FROM finished_tickets WHERE author = '" .. plyName .. "' AND date = '" .. ticketDate .. "'")
    if existingEntry then
        ticketCount = tonumber(existingEntry[1].count) + 1
        sql.Query("UPDATE finished_tickets SET count = " .. ticketCount .. " WHERE author = '" .. plyName .. "' AND date = '" .. ticketDate .. "'")
    else
        local allRows = sql.Query("SELECT * FROM finished_tickets WHERE author = '" .. plyName .. "'")
        if allRows then
            for _, row in ipairs(allRows) do
                sql.Query("DELETE FROM finished_tickets WHERE author = '" .. plyName .. "' AND date = '" .. row.date .. "'")
            end
        end
        sql.Query("INSERT INTO finished_tickets (author, date, count) VALUES ('" .. plyName .. "', '" .. ticketDate .. "', " .. ticketCount .. ")")
    end

    local allFinishedTickets = sql.Query("SELECT * FROM finished_tickets WHERE date = '" .. ticketDate .. "'")
    return allFinishedTickets
end


if SERVER then
    net.Receive("addFinishedTicket", function(len, ply)
        if not ply:IsAdmin() then return end
    
        local finishedTickets = incrementFinishedTicketsForPlayer(ply)
    
        net.Start("updateFinishedTickets")
        net.WriteTable(finishedTickets)
        net.Send(ply)
    end)

    net.Receive("refreshFinishedTickets", function(len, ply)
        if not ply:IsAdmin() then return end

        local finishedTickets = sql.Query("SELECT * FROM finished_tickets")
        if finishedTickets then
            net.Start("updateFinishedTickets")
            net.WriteTable(finishedTickets)
            net.Send(ply)
        end
    end)

end


