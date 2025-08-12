local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

local shopod = Material("odium_boutique/shopOD.png", "smooth")
local buttonshops = Material("odium_boutique/shopbut.png", "smooth")

local frameBoutique = nil

surface.CreateFont("Nino3:font:hud:25", {
    font = "Righteous",
     extended = false,
      size = RX(20),
       weight = RY(1000),
})


local function Nino_DeathScreenShow()
    if LocalPlayer():Alive() and not frameBoutique then
        frameBoutique = vgui.Create("DFrame")
        frameBoutique:SetSize(ScrW() * 0.6, ScrH() * 0.65)
        frameBoutique:Center()
        frameBoutique:SetTitle("")
        frameBoutique:MakePopup()
        frameBoutique:ShowCloseButton(false)
        frameBoutique:SetDraggable(false)
        frameBoutique.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
            surface.SetMaterial(shopod)
            surface.SetDrawColor(MyLib.ColorServer["white"])
            surface.DrawTexturedRect(ScrW() * 0.002, ScrH() * 0.003, ScrW() * 0.597, ScrH() * 0.644)
        end
        
        buttonshop = vgui.Create("DButton", frameBoutique)
        buttonshop:SetPos(ScrW()*0.280, ScrH()*0.54)
        buttonshop:SetSize(ScrW()*.050, ScrH()*.081)
        buttonshop:SetText("")
        buttonshop.isSound = false
        buttonshop.Paint = function(self, w, h)
            surface.SetMaterial(buttonshops)
            surface.SetDrawColor(MyLib.ColorServer["white"])
            surface.DrawTexturedRect(0, 0, w, h)
        end
        buttonshop.DoClick = function()
            frameBoutique:Remove()
            gui.OpenURL( "https://odiumlibrary.com/shop" )
        end

        closelashop = vgui.Create("DButton", frameBoutique)
        closelashop:SetPos(ScrW()*0.582, ScrH()*0.01)
        closelashop:SetSize(ScrW()*.013, ScrH()*.023)
        closelashop:SetText("")
        closelashop.isSound = false
        closelashop.Paint = function(self, w, h)
            if closelashop:IsHovered() then
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["grey"])
                draw.SimpleText("✕", "Nino3:font:hud:25", w/2-1, h/2-1, MyLib.ColorServer["grey"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if not closelashop.isSound then
                    surface.PlaySound("UI/buttonrollover.wav")
                    closelashop.isSound = true
                end    
            else
                draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["Black"])
                draw.SimpleText("✕", "Nino3:font:hud:25", w/2-1, h/2-1, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                closelashop.isSound = false
            end
        end
        closelashop.DoClick = function()
            frameBoutique:Remove()
        end

    elseif not LocalPlayer():Alive() and frameBoutique then
        frameBoutique:Remove()
        frameBoutique = nil
    end
end

hook.Add("HUDPaint", "Nino_DeathScreenShow", Nino_DeathScreenShow)