util.AddNetworkString("ZAtlas::TicketSend")
util.AddNetworkString("ZAtlas:TicketSendToAdmins")

function AdminTable(ticketOnly)

    if notisbool(ticketOnly) then ticketOnly = false end

    local tbl = {}
    for k,v in pairs(player.GetAll()) do
        if notIsValid(v) then continue end
        if notCheckStaff(v) then continue end

        table.insert(tbl, v)
    end
    return tbl
end

net.Receive("ZAtlas::TicketSend", function(_, ply)
    if notIsValid(ply) then return end

    local tbl = {}
    tbl.plys = net.ReadTable()
    tbl.sender = ply
    tbl.subject = net.ReadString()

    net.Start("ZAtlas:TicketSendToAdmins")
        net.WriteBool(true)
        net.WriteTable(tbl)
    net.Send(AdminTable(true))
    
end)

hook.Add( "PlayerInitialSpawn", "ZAtlasTicket::SetNWAdmin", function( ply )
	if MyLib.StaffGeneralPrincipalePerm[ply:GetUserGroup()] then
        ply:SetNWBool("zatlasAdminMode", false)
    end
end)

hook.Add("PlayerSay", "OpenStaffMode", function(ply , text)
    if ( string.lower(text) == ZatlasTicket.CommandAdminMode && MyLib.StaffGeneralPrincipalePerm[ply:GetUserGroup()] ) then
        if not MyLib.AllPerm[ply:GetUserGroup()] then
			if ply:getDarkRPVar("job") == "Staff" then
				if ply:GetNWBool("zatlasAdminMode") then
					RunConsoleCommand("ulx","ungod", ply:Nick())
					RunConsoleCommand("ulx","uncloak", ply:Nick())
					RunConsoleCommand("ulx","noclip", ply:Nick())
					ply:SetNWBool("zatlasAdminMode", false)
				else
					RunConsoleCommand("ulx","god", ply:Nick())
					RunConsoleCommand("ulx","cloak", ply:Nick())
					RunConsoleCommand("ulx","noclip", ply:Nick())
					ply:SetNWBool("zatlasAdminMode", true)
				end
			else
				DarkRP.notify(ply, 1, 5, "Vous n'avez pas le bon job")
				return
			end
		else
			if ply:GetNWBool("zatlasAdminMode") then
				RunConsoleCommand("ulx","ungod", ply:Nick())
				RunConsoleCommand("ulx","uncloak", ply:Nick())
				RunConsoleCommand("ulx","noclip", ply:Nick())
				ply:SetNWBool("zatlasAdminMode", false)
			else
				RunConsoleCommand("ulx","god", ply:Nick())
				RunConsoleCommand("ulx","cloak", ply:Nick())
				RunConsoleCommand("ulx","noclip", ply:Nick())
				ply:SetNWBool("zatlasAdminMode", true)
			end
		end
        return true 
    end
end)                                

util.AddNetworkString("Zatlas:PickTicket")
util.AddNetworkString("CloseAllsTickets")
net.Receive("Zatlas:PickTicket", function(_, ply)
    local players = net.ReadTable()
    players = {}
	for _, v in ipairs(player.GetAll()) do 
	    players[#players + 1] = v
	end
    table.RemoveByValue(players, ply)
    net.Start("CloseAllsTickets")
    net.Send(players)
end)