local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

function OdiumATM:ATMHomeSide()
    local plyName = LocalPlayer():GetName()

    local depositMat = Material("odium_atm_icons/deposit.png")
    local withdrawMat = Material("odium_atm_icons/withdraw.png")
    local transfertMat = Material("odium_atm_icons/transfert.png")

    local COLORSATM = {
        [1] = Color(32, 122, 100),
        [2] = Color(32, 122, 100),
        [3] = Color(200, 200, 200),
        [4] = Color(0, 0, 0, 0),
        [5] = Color(32, 122, 100),
        [6] = Color(32, 122, 100),
        [7] = Color(32, 122, 100),
        [8] = Color(32, 105, 100),
        [9] = Color(32, 105, 100),
        [10] = Color(32, 105, 100),
        [11] = Color(32, 122, 100),
        [12] = Color(0, 0, 0, 0)
    }

    local activitiesBtn = {
        {
            name = "Déposer",
            posX = RespX(100),
            posY = RespY(250),
            color = {
                ["base"] = COLORSATM[5],
                ["footer"] = COLORSATM[8]
            },
            mat = depositMat,
            func = function() 
                atmHomePanel:FadeOut()
                OdiumATM:ATMDepositSide()
            end
        },
        {
            name = "Retirer",
            posX = RespX(550),
            posY = RespY(250),
            color = {
                ["base"] = COLORSATM[6],
                ["footer"] = COLORSATM[9]
            },
            mat = withdrawMat,
            func = function() 
                atmHomePanel:FadeOut()
                OdiumATM:ATMWithdrawSide()
            end
        },
        {
            name = "Transférer",
            posX = RespX(325),
            posY = RespY(430),
            color = {
                ["base"] = COLORSATM[7],
                ["footer"] = COLORSATM[10]
            },
            mat = transfertMat,
            func = function()
                atmHomePanel:FadeOut()
                OdiumATM:ATMTransfertSide()
            end
        }
    }

    atmHomePanel = vgui.Create("DPanel", atmFrame)
    atmHomePanel:SetSize(atmFrame:GetWide(), atmFrame:GetTall()-RespY(70))
    atmHomePanel:SetPos(0, RespY(70))
    atmHomePanel:FadeIn()
    function atmHomePanel:Paint(w, h) 
        surface.SetDrawColor(COLORSATM[4])

        surface.SetDrawColor(Color(255, 255, 255))
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(42), RespY(100))

        surface.SetDrawColor(COLORSATM[2])
        draw.NoTexture()
        draw.Circle(RespX(62), RespY(572), RespX(40), RespY(100))

        draw.RoundedBox(6, (w/2)-RespX(90), RespY(55), surface.GetTextSize('OdiumATM_Font4'), RespY(50), Color(7, 56, 89))
        draw.SimpleText("Bonjour "..plyName.." !", "OdiumATM_Font3", w/2, RespY(10), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(DarkRP.formatMoney(tonumber(LocalPlayer():GetNWInt("playerBankAccount"))), "OdiumATM_Font4", w/2, RespY(60), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText("Quelle action souhaitez-vous effectuer ?", "OdiumATM_Font5", w/2, RespY(150), color_white, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(color_white)
        surface.DrawRect(RespX(205), RespY(185), RespX(590), RespY(2))
    end

    local exitHomeButton = vgui.Create("DButton", atmHomePanel)
    exitHomeButton:SetSize(RespX(80), RespY(80))
    exitHomeButton:SetPos(RespX(20), RespY(530))
    exitHomeButton:SetText("◀")
    exitHomeButton:SetFont("OdiumATM_FontCross")
	exitHomeButton.isSound = false
    function exitHomeButton:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, COLORSATM[4])
        if exitHomeButton:IsHovered() then
            exitHomeButton:SetTextColor(Color(32, 32, 32)) 
			if not exitHomeButton.isSound then
				surface.PlaySound("UI/buttonrollover.wav")
				exitHomeButton.isSound = true
			end			
        else
            exitHomeButton:SetTextColor(color_white)
			exitHomeButton.isSound = false
        end
    end
    function exitHomeButton:DoClick()
        atmFrame:FadeOut()
    end

    for _, btn in ipairs(activitiesBtn) do
        local buttonAct = vgui.Create("DButton", atmHomePanel)
        buttonAct:SetSize(RespX(325), RespY(90))
        buttonAct:SetPos(btn.posX, btn.posY)
        buttonAct:SetText(btn.name)
        buttonAct:SetFont("OdiumATM_Font4")
		buttonAct.isSound = false
        function buttonAct:Paint(w, h)
            if buttonAct:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, Color(32, 105, 100))
                buttonAct:SetTextColor(Color(32, 32, 32))
                draw.RoundedBox(0, 0, h-RespY(2), w, RespY(2), Color(255, 255, 255))
                draw.RoundedBox(0, 0, h-RespY(90), w, RespY(2), Color(255, 255, 255))
                draw.RoundedBox(0, 0, h-RespY(90), RespY(2), h, Color(255, 255, 255))
                draw.RoundedBox(0, RespY(323), h-RespY(90), RespY(2), h, Color(255, 255, 255))
				if not buttonAct.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					buttonAct.isSound = true
				end			
            else
                draw.RoundedBox(0, 0, 0, w, h, Color(32, 122, 100))
                draw.RoundedBox(0, 0, h-RespY(11), w, RespY(10), Color(32, 105, 100))
                buttonAct:SetTextColor(color_white)
				buttonAct.isSound = false
            end
            OdiumATM:DrawMaterial(RespX(50), RespY(20), RespX(50), RespY(50), btn.mat)
        end
        buttonAct.DoClick = btn.func
    end  
end