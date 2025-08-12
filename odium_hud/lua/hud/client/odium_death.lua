ODIUMRPDEATH = ODIUMRPDEATH or {}

ODIUMRPDEATH.iW = ScrW()
ODIUMRPDEATH.iH = ScrH()

function RX(x)
    return x / 3840 * ODIUMRPDEATH.iW
end

function RY(y)
    return y / 2160 * ODIUMRPDEATH.iH
end

hook.Add("OnScreenSizeChanged", "Odium:OnScreenSizeChanged", function()

    ODIUMRPDEATH.iW = ScrW()
    ODIUMRPDEATH.iH = ScrH()

end)

surface.CreateFont("NinoDeath1", {
    font = "Righteous",
     extended = false,
      size = RX(200),
       weight = RY(1000),
})

surface.CreateFont("NinoDeath2", {
    font = "Righteous",
     extended = false,
      size = RX(70),
       weight = RY(1000),
})

surface.CreateFont("NinoDeath3", {
    font = "Righteous",
     extended = false,
      size = RX(50),
       weight = RY(1000),
})

local deathScreenAlpha = 0
local respawnTime = 10
local logoAlpha = 0
local logoStartTime = 0
local Death = Material("odium_hud_icon/deathscreen.png", "noclamp smooth")

local deathTime = 0

local function DrawDeathScreen()
    local ply = LocalPlayer()
    
    if not ply:Alive() and deathScreenAlpha < 255 then
        deathScreenAlpha = math.min(deathScreenAlpha + 5, 255)
    elseif ply:Alive() and deathScreenAlpha > 0 then
        deathScreenAlpha = math.max(deathScreenAlpha - 5, 0)
    end

    if deathScreenAlpha > 0 then
        local scrW, scrH = ScrW(), ScrH()
        local boxW, boxH = scrW, scrH
        local xPos, yPos = 0, 0

        draw.RoundedBox(0, xPos, yPos, boxW, boxH, Color(255, 0, 0, 60, deathScreenAlpha))

        local elapsedTime = CurTime() - deathTime
        if elapsedTime > 2 then
            logoAlpha = math.min((elapsedTime - 2) * 50, 255)
        end

        draw.SimpleTextOutlined("VOUS ETES MORT !", "NinoDeath1", RX(1890), RY(1300), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("Clique gauche pour respawn", "NinoDeath2", RX(1890), RY(1500), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, MyLib.ColorServer["Black"])
        draw.SimpleTextOutlined("/afk dans le chat si vous êtes afk", "NinoDeath3", RX(1890), RY(2125), MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MyLib.ColorServer["Black"])

        if logoAlpha > 0 then
            surface.SetMaterial(Death)
            surface.SetDrawColor(255, 255, 255, logoAlpha)
            surface.DrawTexturedRect(RX(1650), RY(600), RX(500), RY(500))
        end
    else
        logoAlpha = 0
    end
end



local function DeathCamera(ply, pos, angles, fov)
    if not ply:Alive() then
        local view = {}
        local timeElapsed = CurTime() - deathTime

        local distance = 150 + 50 * math.sin(CurTime() * 0.90)
        local angle = Angle(angles.p + 15, angles.y + timeElapsed * 20, angles.r)

        local ragdoll = ply:GetRagdollEntity()
        if IsValid(ragdoll) then
            local ragdollPos = ragdoll:GetPos()
            view.origin = ragdollPos + angle:Forward() * -distance + Vector(0, 0, 10)
        else
            view.origin = pos + angle:Forward() * -distance + Vector(0, 0, 10)
        end

        view.angles = angle
        view.fov = fov
        view.drawviewer = true

        return view
    end
end

local function PlayerDeath(ply)
    if ply == LocalPlayer() then
        deathTime = CurTime()
        timer.Simple(respawnTime, function()
            if IsValid(ply) then
                ply:ConCommand("say /wake")
            end
        end)
    end
end

local playerIsAFK = false



hook.Add("HUDPaint", "DeathScreen_Draw", DrawDeathScreen)
hook.Add("PostPlayerDeath", "DeathScreen_PlayerDeath", PlayerDeath)
hook.Add("CalcView", "DeathScreen_CalcView", DeathCamera)