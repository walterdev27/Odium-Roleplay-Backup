ODIUM = ODIUM or {}

-- Automatic responsive functions
ODIUM.iW = ScrW()
ODIUM.iH = ScrH()

local function RX(x)
    return x / 3840 * ODIUM.iW
end

local function RY(y)
    return y / 2160 * ODIUM.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUM.iW = ScrW()
    ODIUM.iH = ScrH()

end)

_G.hasClickedCommencer = false
local characterModel

hook.Add("OpenNewDFrame", "CreateNewDFrameOnDemand", function()
    local ply = LocalPlayer()

    -- Ajoute une liste de modèles de personnages
    local characterModels = {
        --"models/skin_walter_piru/male_01.mdl",
        "models/skin_walter_piru/male_03.mdl",
        --"models/dorian_/player/nygs/nygs_01.mdl",
        "models/dorian_/player/nygs/nygs_03.mdl",
       -- "models/dorian_/player/nygs/nygs_02.mdl",
        --"models/dorian_/player/nygs/nygs_04.mdl",
        --"models/dorian_/player/nygs/nygs_05.mdl",
        --"models/dorian_/player/nygs/nygs_06.mdl",
        --"models/dorian_/player/nygs/nygs_07.mdl",
        --"models/dorian_/player/nygs/nygs_08.mdl",
        --"models/dorian_/player/nygs/nygs_09.mdl",
        -- Ajoute d'autres modèles ici
    }

    local characterUpperBodies = {
        ["models/dorian_/player/nygs/nygs_03.mdl"] = {
            "lor_2s",
            "lowr_2s",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lor_2s",
            "lowr_2s",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
        },
        ["models/skin_walter_piru/male_03.mdl"] = {
            "lor_2s",
            "lowr_2s",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lor_2s",
            "lowr_2s",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
            "lowr_2",
        },
        -- Ajoutez d'autres modèles de personnages et leurs hauts ici
    }
    local currentIndex = 1
    local upperBodyIndex = 1

    local frame = vgui.Create("DFrame")
    frame:SetSize(RX(3840), RY(2160))
    frame:Center()
    frame:SetTitle("")
    frame:SetVisible(true)
    frame:SetDraggable(true)
    frame:ShowCloseButton(true)
    frame.Paint = function(self, w, h)
    end

    local frame2 = vgui.Create("DFrame", frame)
    frame2:SetSize(RX(1200), RY(1600))
    frame2:SetPos(RX(2300), RY(250))
    frame2:SetTitle("")
    frame2:SetVisible(true)
    frame2:SetDraggable(true)
    frame2:ShowCloseButton(true)
    frame2.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, RY(0), w, h, MyLib.ColorServer["Black"])
        draw.RoundedBox(0, RX(20), RY(20), RX(1160), RY(165), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(0), w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(0), RX(10), h, MyLib.ColorServer["Green"])
        draw.RoundedBox(0, 0, RY(1590), w, RY(10), MyLib.ColorServer["Green"])
        draw.RoundedBox(0, RX(1190), RY(0), RX(10), h, MyLib.ColorServer["Green"])
    end

    local EnvoyerFrame = vgui.Create("DButton", frame2)
        EnvoyerFrame:SetPos(RX(20), RY(1500))
		EnvoyerFrame:SetSize(RX(1160), RY(80))
		EnvoyerFrame:SetText("");
		EnvoyerFrame.isSound = false
		EnvoyerFrame.Paint = function(s,w,h)
			if EnvoyerFrame:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["GreentSecond"])
				if not EnvoyerFrame.isSound then
					surface.PlaySound("UI/buttonrollover.wav")
					EnvoyerFrame.isSound = true
				end
				draw.SimpleText("Terminer", "fontStaff2", RX(500), RY(10), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			else
				EnvoyerFrame:SetTextColor(color_white)
				draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Green"])
				EnvoyerFrame.isSound = false
				draw.SimpleText("Terminer", "fontStaff2", RX(500), RY(10), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end

		end
		EnvoyerFrame.DoClick = function()
			
		end

        local characterModel = vgui.Create("DModelPanel", frame)
        characterModel:SetSize(RX(800), RY(2160)) 
        characterModel:SetPos(RX(600), RY(2160 - 2160))
        characterModel:SetModel(ply:GetModel())

        local mn, mx = characterModel.Entity:GetRenderBounds()
        local size = 0
        size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
        size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
        size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
        characterModel:SetCamPos(Vector(size, size, size))
        characterModel:SetFOV(15)

        -- Mets à jour le modèle du personnage
        local function updateCharacterModel()
            characterModel:SetModel(characterModels[currentIndex])
            ply:SetModel(characterModels[currentIndex])
        end

        local function createUpperBodyButtons(parent, x, y)
            -- Efface tous les boutons de hauts existants
            if parent.upperBodyButtons then
                for _, button in ipairs(parent.upperBodyButtons) do
                    button:Remove()
                end
            end
            parent.upperBodyButtons = {}
        
            local currentModel = characterModels[currentIndex]
            local upperBodies = characterUpperBodies[currentModel]
        
            -- Si le modèle actuel dispose de hauts, créez les boutons
            if upperBodies then
                for i, upperBodyModel in ipairs(upperBodies) do
                    local button = vgui.Create("DButton", parent)
                    button:SetSize(RX(50), RY(50))
                    button:SetPos(x + (i - 1) * RX(60), y)
                    button:SetText(tostring(i))
                    button.DoClick = function()
                        upperBodyIndex = i
                        characterModel.Entity:SetBodygroup(1, upperBodyIndex)
                    end
        
                    table.insert(parent.upperBodyButtons, button)
                end
            end
        end           

    -- Crée le bouton flèche gauche
    local leftArrow = vgui.Create("DButton", frame2)
    leftArrow:SetSize(RX(100), RY(100))
    leftArrow:SetPos(RX(100), RY(300))
    leftArrow:SetText("<")
    leftArrow.DoClick = function()
        currentIndex = currentIndex - 1
        if currentIndex < 1 then currentIndex = #characterModels end
        updateCharacterModel()
        createUpperBodyButtons(frame2, RX(20), RY(500))
    end

    -- Crée le bouton flèche droite
    local rightArrow = vgui.Create("DButton", frame2)
    rightArrow:SetSize(RX(100), RY(100))
    rightArrow:SetPos(RX(200), RY(300))
    rightArrow:SetText(">")
    rightArrow.DoClick = function()
        currentIndex = currentIndex + 1
        if currentIndex > #characterModels then currentIndex = 1 end
        updateCharacterModel()
        createUpperBodyButtons(frame2, RX(20), RY(500))
    end
    createUpperBodyButtons(frame2, RX(20), RY(500))
end)