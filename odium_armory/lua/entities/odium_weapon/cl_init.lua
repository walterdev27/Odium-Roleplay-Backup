include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    cam.Start3D2D(self:LocalToWorld(Vector(1, -3, 0)), self:LocalToWorldAngles(Angle(0, 90, 90)), 0.05)
        draw.SimpleTextOutlined(self:GetWeaponName(), "NAR:Font:2", 0, 0, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
    cam.End3D2D()
    cam.Start3D2D(self:LocalToWorld(Vector(-3, -3, 0)), self:LocalToWorldAngles(Angle(180, 90, 270)), 0.05)
        draw.SimpleTextOutlined(self:GetWeaponName(), "NAR:Font:2", 0, 0, MyLib.ColorServer["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MyLib.ColorServer["Black"])
    cam.End3D2D()
end