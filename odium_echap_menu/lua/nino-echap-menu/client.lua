ODIUMECHAP = ODIUMECHAP or {}

ODIUMECHAP.iW = ScrW()
ODIUMECHAP.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMECHAP.iW
end

function RY(y)
    return y / 2160 * ODIUMECHAP.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMECHAP.iW = ScrW()
    ODIUMECHAP.iH = ScrH()

end)

local gradientsOne = Material("odium_general_logo/gradientsOne.png", "smooth")
local neon = Material("odium_general_logo/neon.png", "smooth")
local neons = Material("odium_general_logo/neons.png", "smooth")
local rondneon = Material("odium_general_logo/rondneon.png", "smooth")
local Gradients = Material("odium_general_logo/Gradients.png", "smooth")
local odiumlo = Material("odium_general_logo/odiumlogo.png", "smooth")
local discordnos = Material("odium_general_logo/discordnos.png", "smooth")
local pourquoinous = Material("odium_general_logo/pourquoinous.png", "smooth")
local Deconnexion = Material("odium_general_logo/Deconnexion.png", "smooth")
local Option = Material("odium_general_logo/Option.png", "smooth")
local disordbutton = Material("odium_general_logo/disordbutton.png", "smooth")
local odiumlogo2 = Material("odium_atm_icons/icon_odium_frame.png", "smooth")
local disssscogm = Material("odium_general_logo/gmggmgmptit.png", "smooth")
local reprendre = Material("odium_general_logo/reprendre.png", "smooth")
local maintelboutique = Material("odium_general_logo/maintelboutique.png", "smooth")
local boutique = Material("odium_general_logo/boutique.png", "smooth")
local workshoptwo = Material("odium_general_logo/workshoptwo.png", "smooth")
local serveurdiscordodium = Material("odium_general_logo/serveurdiscordodium.png", "smooth")
local pnjboutique = Material("odium_general_logo/pnjboutique.png", "smooth")
local forumregle = Material("odium_general_logo/forumregle.png", "smooth")
local regless = Material("odium_general_logo/regless.png", "smooth")
local forum = Material("odium_general_logo/forum.png", "smooth")
local pourboutique = Material("odium_general_logo/pourboutique.png", "smooth")

local function createFrame()
    local frame = vgui.Create("DFrame")
    frame:SetSize(ODIUMECHAP.iW, ODIUMECHAP.iH)
    frame:Center() 
    frame:MakePopup()
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(true)
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MyLib.ColorServer["BlackSeconde"])
    end
end

hook.Add("PlayerBindPress", "Odium:PlayerBindPress", function(ply, bind, pressed)
    if bind == "cancelselect" and pressed then
        createFrame()
        return true
    end
end)

