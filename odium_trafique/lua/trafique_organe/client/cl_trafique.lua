local sentKillMessage = false

-- Font
surface.CreateFont("RighteousFont", {
    font = "Righteous",
    size = 40,
    weight = 500,
    antialias = true,
})


if CLIENT then
    hook.Add("PlayerBindPress", "DisableCleaverClicks", function(ply, bind, pressed)
        if not IsValid(ply) or not ply:Alive() then return end
        local weapon = ply:GetActiveWeapon()
        if not IsValid(weapon) or weapon:GetClass() ~= "tfa_nmrih_cleaver" then return end

        if bind == "+attack" then
            local traceEntity = ply:GetEyeTrace().Entity
            if IsValid(traceEntity) and traceEntity:IsPlayer() then
                isGreen = ply:EyePos():Distance(traceEntity:EyePos()) <= 150
            else
                isGreen = false
            end

            if isGreen and not isCharcuting then
                print("Lerp started") -- Debug message
                lerpStartTime = CurTime()
                isCharcuting = true
                charcutingTarget = traceEntity
            end
        elseif bind == "+attack2" then
            return true
        end
    end)
end

if isCharcuting and charcutingTarget ~= traceEntity then
    sentKillMessage = false
end


local function DrawTargetZones(ply, target)
    local eyes = ply:EyePos()
    local headPos = target:LookupBone("ValveBiped.Bip01_Head1")
    local heartPos = target:LookupBone("ValveBiped.Bip01_Spine2")
    local lungPos = target:LookupBone("ValveBiped.Bip01_Spine1")

    if headPos then
        headPos = target:GetBonePosition(headPos)
        local headDistance = eyes:Distance(headPos)
        local headColor = (ply:GetEyeTrace().Entity == target and headDistance <= 100) and Color(255, 0, 0) or Color(0, 255, 182)
        halo.Add({target}, headColor, 2, 2, 1, true, ply:KeyDown(IN_ATTACK))
    end

    if heartPos then
        heartPos = target:GetBonePosition(heartPos)
        local heartDistance = eyes:Distance(heartPos)
        local heartColor = (ply:GetEyeTrace().Entity == target and heartDistance <= 100) and Color(255, 0, 0) or Color(0, 255, 182)
        halo.Add({target}, heartColor, 2, 2, 1, true, ply:KeyDown(IN_ATTACK))
    end

    if lungPos then
        lungPos = target:GetBonePosition(lungPos)
        local lungDistance = eyes:Distance(lungPos)
        local lungColor = (ply:GetEyeTrace().Entity == target and lungDistance <= 100) and Color(255, 0, 0) or Color(0, 255, 182)
        halo.Add({target}, lungColor, 2, 2, 1, true, ply:KeyDown(IN_ATTACK))
    end
end

local function DrawCharcuterText(ply, target)
    local headPos = target:LookupBone("ValveBiped.Bip01_Head1")
    if headPos then
        headPos = target:GetBonePosition(headPos)
        local pos = headPos + Vector(0, 0, 15)
        local screenPos = pos:ToScreen()

        draw.SimpleTextOutlined("Clique gauche pour charcuter", "RighteousFont", screenPos.x, screenPos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(32, 32, 32))
    end
end

local function CreateBloodParticle(pos)
    local emitter = ParticleEmitter(pos)
    local particle = emitter:Add("effects/yellowflare", pos)

    if not particle then return end

    -- Configurez les propriétés de la particule ici, par exemple :
    particle:SetVelocity(VectorRand() * 50)
    particle:SetLifeTime(0)
    particle:SetDieTime(0.5)
    particle:SetStartAlpha(255)
    particle:SetEndAlpha(0)
    particle:SetStartSize(5)
    particle:SetEndSize(10)
    particle:SetRoll(math.Rand(-180, 180))
    particle:SetRollDelta(math.Rand(-0.2, 0.2))
    particle:SetColor(255, 0, 0) -- Couleur rouge pour le sang

    emitter:Finish()
end


if CLIENT then
    local isGreen = false
    hook.Add("PreDrawHalos", "TestHalo", function()
        local ply = LocalPlayer()
        local weapon = ply:GetActiveWeapon()
        if not IsValid(weapon) or weapon:GetClass() ~= "tfa_nmrih_cleaver" then return end

        local trace = ply:GetEyeTrace()
        if not IsValid(trace.Entity) or not trace.Entity:IsPlayer() then return end

        local target = trace.Entity
        if target ~= ply and target:Alive() and ply:EyePos():Distance(target:EyePos()) <= 150 then
            halo.Add({target}, Color(255, 0, 0), 4, 4, 4, true, true)
            isGreen = true
        else
            isGreen = false
        end
    end)

    local pointTimer = 0
    local pointCount = 1

    if CLIENT then
        hook.Add("HUDPaint", "DrawCharcuterText3D2D", function()
            local ply = LocalPlayer()
            local weapon = ply:GetActiveWeapon()
    
            if not IsValid(weapon) or weapon:GetClass() ~= "tfa_nmrih_cleaver" then return end
    
            local trace = ply:GetEyeTrace()
            if not IsValid(trace.Entity) or not trace.Entity:IsPlayer() then
                if isCharcuting then
                    isCharcuting = false
                    charcutingTarget = nil
                end
                return
            end
    
            local target = trace.Entity
            if target ~= ply and target:Alive() and isGreen then
                if isCharcuting then
                    local bloodPos = target:GetPos() + Vector(0, 0, 50) -- Ajoutez un décalage en hauteur si nécessaire
                    CreateBloodParticle(bloodPos)
                    local lerpFraction = math.Clamp((CurTime() - lerpStartTime) / OdiumTrafique.TimeLerp, 0, 1)
                    draw.RoundedBox(0, ScrW() / 2.1 - 100, ScrH() - 550, 350, 55, Color(35, 35, 35, 225))
                    draw.RoundedBox(0, ScrW() / 2.089 - 98, ScrH() - 543, 340 * lerpFraction, 40, Color(32, 122, 100, 235))
    
                    if lerpFraction >= 1 then
                        if not sentKillMessage and IsValid(charcutingTarget) then
                            net.Start("KillCharcutingTarget")
                            net.WriteEntity(charcutingTarget)
                            net.SendToServer()
                            sentKillMessage = true
                        end
                    
                        isCharcuting = false
                        charcutingTarget = nil
                    end
    
                    if lerpFraction >= 1 then
                        isCharcuting = false
                        charcutingTarget = nil
                        net.Start("FinishCharcutage")
                        net.WriteEntity(target)
                        net.SendToServer()
                    end
    
                    if CurTime() >= pointTimer then
                        pointCount = pointCount + 1
                        if pointCount > 3 then
                            pointCount = 1
                        end
                        pointTimer = CurTime() + 0.5 -- intervalle entre les changements de points (en secondes)
    
                        -- Ajout des sons
                        if pointCount == 1 then
                            ply:EmitSound("nmrihimpact/blunt_heavy1.wav")
                        elseif pointCount == 2 then
                            ply:EmitSound("nmrihimpact/blunt_light1.wav")
                        elseif pointCount == 3 then
                            ply:EmitSound("nmrihimpact/sharp_heavy1.wav")
                        elseif pointCount == 4 then
                            ply:EmitSound("nmrihimpact/sharp_light3.wav")
                        elseif pointCount == 5 then
                            ply:EmitSound("nmrihimpact/blunt_heavy6.wav")
                        end
                    end
                
                    local points = string.rep(".", pointCount)
                    draw.SimpleTextOutlined("Charcutage en cours" .. points, "Nino3:font:hud:65", ScrW() / 1.930, ScrH() - 523, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(32, 32, 32))
                end
    
                DrawCharcuterText(ply, target)
            end
        end)
    end    
end


