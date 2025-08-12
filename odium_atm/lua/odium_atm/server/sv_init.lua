hook.Add("PlayerInitialSpawn", "OdiumATM::MoneyLoad", function(ply)
    OdiumATM:CreateTable()
    ply:SetNWInt("playerBankAccount", OdiumATM:LoadPlayerToDataBase(ply))   
end)