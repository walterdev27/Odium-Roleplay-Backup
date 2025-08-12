ODIUMtra = ODIUMtra or {}

-- Automatic responsive functions
ODIUMtra.iW = ScrW()
ODIUMtra.iH = ScrH()

local function RX(x)
    return x / 1920 * ODIUMtra.iW
end

local function RY(y)
    return y / 1080 * ODIUMtra.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMtra.iW = ScrW()
    ODIUMtra.iH = ScrH()

end)

-- Font
surface.CreateFont("RighteousFont", {
    font = "Righteous",
    size = 40,
    weight = 500,
    antialias = true,
})

local logoTrafique = Material("odium_hud_icon/trafiquecoeur.png", "smooth")
local argent = Material("odium_hud_icon/argent.png", "smooth")

local itemPrices = {
    odium_coeursale = {min = 15000, max = 20000},
    odium_coeur = {min = 60000, max = 100000},
    odium_cervellsale = {min = 15000, max = 20000},
    odium_cervell = {min = 60000, max = 100000},
    odium_poumon = {min = 60000, max = 100000},
    odium_poumonsale = {min = 15000, max = 20000}
}

hook.Add("HUDPaint", "OrgansHUD", function()
    local ply = LocalPlayer()
    local totalOrgans = 0
    local totalValue = 0

    for itemName, priceRange in pairs(itemPrices) do
        local count = ply:GetNWInt(itemName, 0)
        if count > 0 then
            totalOrgans = totalOrgans + count
            local itemPrice = ply:GetNWInt(itemName .. "_price", 0) 
            totalValue = totalValue + (count * itemPrice)
        end
    end

    local organText = "Organes : " .. totalOrgans
    local valueText = "Valeur totale : " .. DarkRP.formatMoney(totalValue)

    --draw.SimpleText(organText, "RighteousFont", 10, ScrH() * 0.8, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    --draw.SimpleText(valueText, "RighteousFont", 10, ScrH() * 0.8 + 30, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    if totalOrgans > 0 then
        draw.RoundedBox(0, RX(1677), RY(500), RX(180), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(1557), RY(543), RX(300), RY(37), Color(35, 35, 35, 225))
        draw.RoundedBox(0, RX(1860), RY(497), RX(44), RY(85), Color(35, 35, 35, 235))
        draw.SimpleTextOutlined(organText, "Nino3:font:hud:65", RX(1780), RY(519), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        draw.SimpleTextOutlined(valueText, "Nino3:font:hud:65", RX(1710), RY(560), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
        surface.SetMaterial(logoTrafique)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(1864), RY(501), RX(37), RY(37))
        surface.SetMaterial(argent)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(RX(1864), RY(540), RX(37), RY(37))
    end
end)    

