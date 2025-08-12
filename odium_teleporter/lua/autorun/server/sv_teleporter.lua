--[[
  _____ ___    _      ___         _   __              ___        _  _ _          
 |_   _| _ \  (_)    / __|_  _ __| |_ \_\ _ __  ___  | _ )_  _  | \| (_)_ _  ___ 
   | | |  _/   _     \__ \ || (_-<  _/ -_) '  \/ -_) | _ \ || | | .` | | ' \/ _ \
   |_| |_|    (_)    |___/\_, /__/\__\___|_|_|_\___| |___/\_, | |_|\_|_|_||_\___/
                          |__/                            |__/                   
--]]

------------
-- Config --
------------

-- Pour le spawn a Tacos Bell
Nino_Teleporter_HospitalPos = Vector(-15.131528, 2110.443604, 600.031250)

-- Pour le spawn a la mairie
Nino_Teleporter_TownHallPos = Vector(-4640.383301, -5541.966309, 128.031448)

----------------
-- Fin Config --
----------------

function Nino_Teleporter_TeleportToHospital(ent) 
    ent:SetPos(Nino_Teleporter_HospitalPos)
end

function Nino_Teleporter_TeleportToTownHall(ent) 
    ent:SetPos(Nino_Teleporter_TownHallPos)
end