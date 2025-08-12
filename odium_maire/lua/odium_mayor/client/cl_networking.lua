net.Receive("Odium:Mayor:TabletOpeningDerma", function()
    local regime = net.ReadString()
    Odium_Mayor:TabletDerma(regime)
end)

net.Receive("Odium:Mayor:LockerOpeningDerma", function()
    local ent, taxes = net.ReadEntity(), net.ReadFloat()
    Odium_Mayor:LockerDerma(ent, math.Round(taxes, 2))
end)