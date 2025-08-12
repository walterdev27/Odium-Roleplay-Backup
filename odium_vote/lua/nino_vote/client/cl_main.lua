local function RespX(x)
    return x / 1920 * ScrW()
end
local function RespY(y)
    return y / 1080 * ScrH()
end

surface.CreateFont("NVT:Font:1", {
	font = "Righteous",
	extended = false,
	size = 20,
	weight = 1000,
})

surface.CreateFont("NVT:Font:4", {
	font = "Righteous",
	extended = false,
	size = 25,
	weight = 1000,
})

surface.CreateFont("NVT:Font:2", {
	font = "Righteous",
	extended = false,
	size = 20,
	weight = 500,
})

surface.CreateFont("NVT:Font:3", {
	font = "Righteous",
	extended = false,
	size = 30,
	weight = 500,
})

local votes = {}

local function NVTDrawVotes()
    if IsValid(mainPanel) then mainPanel:Remove() end

    mainPanel = vgui.Create("DPanel")
    mainPanel:SetSize(RespX(200), RespY(200))
    mainPanel:SetPos(RespX(15), RespY(200))
    mainPanel.Paint = nil 

    local scrollPanel = vgui.Create("DScrollPanel", mainPanel)
    scrollPanel:Dock(FILL)

    local vBar = scrollPanel:GetVBar()
    vBar:SetWide(0)

    for k, v in ipairs(votes) do
        if not timer.Exists("NVT:Timer:Votes:"..v.Player:SteamID64()) then return end

        local timeLeft = timer.TimeLeft("NVT:Timer:Votes:"..v.Player:SteamID64())

        local votePanel = vgui.Create("DPanel", scrollPanel)
        votePanel:SetSize(RespX(250), RespY(250))
        votePanel:Dock(TOP)
        votePanel:DockMargin(0, 0, 0, 5)
        votePanel.Paint = function(self, w, h)
            surface.SetDrawColor(NVT.Colors["Black"])
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(NVT.Colors["Green"])
            surface.DrawRect(0, 0, w, RespY(50))

            draw.SimpleText("Time : "..math.Round(timeLeft), "NVT:Font:4", RespX(50), RespY(13), NVT.Colors["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText(v.Player:Nick(), "NVT:Font:3", w / 2, RespY(75), NVT.Colors["Green"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.DrawText("Souhaiterais devenir\n"..team.GetName(v.TeamIndex)..".", "NVT:Font:2", RespX(10), RespY(100), NVT.Colors["White"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.RoundedBox(0, RespX(0), RespY(0), w, RespY(3), Color(255, 255, 255))
            draw.RoundedBox(0, RespX(0), RespY(197), w, RespY(3), Color(255, 255, 255))
            draw.RoundedBox(0, RespX(0), RespY(0), RespX(3), h, Color(255, 255, 255))
            draw.RoundedBox(0, RespX(197), RespY(0), RespX(3), h, Color(255, 255, 255))
        end
        votePanel.Think = function()
            timeLeft = timer.TimeLeft("NVT:Timer:Votes:"..v.Player:SteamID64())
        end

        local voteFor = vgui.Create("DButton", votePanel)
        voteFor:SetSize(RespX(50), RespY(30))
        voteFor:SetPos(RespX(15), RespY(160))
        voteFor:SetText("")
        voteFor.Paint = function(self, w, h)
            surface.SetDrawColor(NVT.Colors["Green"])
            surface.DrawRect(0, 0, w, h)

            --draw.SimpleText("Oui", "NVT:Font:1", w / 2, h / 2, NVT.Colors["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			if voteFor:IsHovered() then
              draw.RoundedBox(0, 0, 0, w, h, Color(32, 105, 100))
              draw.RoundedBox(0, RespX(0), RespY(0), w, RespY(2), Color(255, 255, 255))
              draw.RoundedBox(0, RespX(0), RespY(28), w, RespY(2), Color(255, 255, 255))
              draw.RoundedBox(0, RespX(0), RespY(0), RespX(2), h, Color(255, 255, 255))
              draw.RoundedBox(0, RespX(48), RespY(0), RespX(2), h, Color(255, 255, 255))
			  draw.SimpleText("Oui", "NVT:Font:1", w / 2, h / 2, Color(32, 32, 32), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
			draw.RoundedBox(0, 0, RespY(35), w, RespY(5), Color(32, 105, 100))
            draw.SimpleText("Oui", "NVT:Font:1", w / 2, h / 2, NVT.Colors["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        end
        voteFor.DoClick = function()
            if v.PlayersVotes[LocalPlayer():SteamID64()] then return end
            net.Start("NVT:Net:Votes")
                net.WriteUInt(1, 5)
                net.WriteUInt(k, 32)
            net.SendToServer()

            if IsValid(votePanel) then votePanel:Remove() end
            table.insert(v.PlayersVotes, LocalPlayer():SteamID64())
        end

        local voteAgainst = vgui.Create("DButton", votePanel)
        voteAgainst:SetSize(RespX(50), RespY(30))
        voteAgainst:SetPos(RespX(135), RespY(160))
        voteAgainst:SetText("")
        voteAgainst.Paint = function(self, w, h)
            surface.SetDrawColor(NVT.Colors["Green"])
            surface.DrawRect(0, 0, w, h)

            --draw.SimpleText("Non", "NVT:Font:1", w / 2, h / 2, NVT.Colors["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			if voteAgainst:IsHovered() then
              draw.RoundedBox(0, 0, 0, w, h, Color(32, 105, 100))
              draw.RoundedBox(0, RespX(0), RespY(0), w, RespY(2), Color(255, 255, 255))
              draw.RoundedBox(0, RespX(0), RespY(28), w, RespY(2), Color(255, 255, 255))
              draw.RoundedBox(0, RespX(0), RespY(0), RespX(2), h, Color(255, 255, 255))
              draw.RoundedBox(0, RespX(48), RespY(0), RespX(2), h, Color(255, 255, 255))
			  draw.SimpleText("Non", "NVT:Font:1", w / 2, h / 2, Color(32, 32, 32), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
			draw.RoundedBox(0, 0, RespY(35), w, RespY(5), Color(32, 105, 100))
            draw.SimpleText("Non", "NVT:Font:1", w / 2, h / 2, NVT.Colors["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        end
        voteAgainst.DoClick = function()
            if v.PlayersVotes[LocalPlayer():SteamID64()] then return end
            net.Start("NVT:Net:Votes")
                net.WriteUInt(2, 5)
                net.WriteUInt(k, 32)
            net.SendToServer()

            if IsValid(votePanel) then votePanel:Remove() end
            table.insert(v.PlayersVotes, LocalPlayer():SteamID64())
        end

    end
end

net.Receive("NVT:Net:Vote", function()

    local votesTable = net.ReadTable()
    for k, v in ipairs(votesTable) do
        if not IsValid(v.Player) or not v.Player:IsPlayer() then return end

        timer.Create("NVT:Timer:Votes:"..v.Player:SteamID64(), NVT.DelayToVote, 0, function()
            table.remove(votes, k)

            NVTDrawVotes()

            timer.Remove("NVT:Timer:Votes:"..v.Player:SteamID64())
        end)
    end

    votes = votesTable

    NVTDrawVotes()

end)