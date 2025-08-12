--[[
    RESPONSIVE
]]
function OdiumATM:RespX(x) return x/1920*ScrW() end
function OdiumATM:RespY(y) return y/1080*ScrH() end

--[[
    ANIMATION PANEL
]]

local PANEL = FindMetaTable("Panel")

function PANEL:FadeIn(duration, callback)
    duration = duration or 0.3

    self:SetAlpha(0)
    self:AlphaTo(255, duration, 0, function()
        if callback and isfunction(callback) then
            callback()
        end
    end)
end

function PANEL:FadeOut(duration, callback)
    duration = duration or 0.3

    self:AlphaTo(0, duration, 0, function()
        self:Remove()

        if callback and isfunction(callback) then
            callback()
        end
    end)
end

--[[
    CIRCLE DRAW
]]

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

--[[
    MATERIAL DRAW
]]

function OdiumATM:DrawMaterial(x, y, w, h, mat)
    surface.SetMaterial(mat)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(x, y, w, h)
end

function OdiumATM:MaterialRotated(x, y, w, h, mat, ang, color)
	surface.SetMaterial(mat)
	surface.SetDrawColor(color or color_white)
	surface.DrawTexturedRectRotated(x, y, w, h, ang)
end
