local actionsNetworks = {}

actionsNetworks["ATMDepositMoney"] = function(ply)
	local plyMoneyDeposit = net.ReadInt(32)

	if plyMoneyDeposit <= 0 then OdiumATM:Notify(ply, 1, 5, "Vous ne pouvez pas déposer un montant nul") return end
	
	if ply:canAfford(plyMoneyDeposit) then
		ply:SetNWInt("playerBankAccount", ply:GetNWInt("playerBankAccount") + plyMoneyDeposit)
		ply:addMoney(-plyMoneyDeposit)
		OdiumATM:SavePlayerToDataBase(ply, ply:GetNWInt("playerBankAccount"))
		OdiumATM:Notify(ply, 0, 5, "Vous venez de déposer "..DarkRP.formatMoney(plyMoneyDeposit).." dans votre compte en banque")
	else
		OdiumATM:Notify(ply, 1, 5, "Vous n'avez pas assez d'argent pour déposer "..DarkRP.formatMoney(plyMoneyDeposit))
	end
end

actionsNetworks["ATMWithdrawMoney"] = function(ply)
	local plyMoneyWithdraw = net.ReadInt(32)

	if plyMoneyWithdraw <= 0 then OdiumATM:Notify(ply, 1, 5, "Vous ne pouvez pas retirer un montant nul") return end

	if plyMoneyWithdraw <= tonumber(ply:GetNWInt("playerBankAccount")) then
		ply:SetNWInt("playerBankAccount", ply:GetNWInt("playerBankAccount") - plyMoneyWithdraw)
		ply:addMoney(plyMoneyWithdraw)
		OdiumATM:SavePlayerToDataBase(ply, ply:GetNWInt("playerBankAccount"))
		OdiumATM:Notify(ply, 0, 5, "Vous venez de retirer "..DarkRP.formatMoney(plyMoneyWithdraw).." de votre compte en banque")
	else
		OdiumATM:Notify(ply, 1, 5, "Votre compte ne contient pas assez d'argent pour retirer")
	end
end

actionsNetworks["ATMTransfertMoney"] = function(ply)
	local toTransfert, plyMoneyTransfert = net.ReadString(), net.ReadInt(32)

	if toTransfert == ply:GetName() then OdiumATM:Notify(ply, 1, 5, "Vous ne pouvez pas vous transférer de l'argent à vous même") return end
	if plyMoneyTransfert <= 0 then OdiumATM:Notify(ply, 1, 5, "Vous ne pouvez pas transferer un montant nul") return end

	if tonumber (ply:GetNWInt("playerBankAccount")) >= plyMoneyTransfert then
		ply:SetNWInt("playerBankAccount", ply:GetNWInt("playerBankAccount") - plyMoneyTransfert)
		OdiumATM:SavePlayerToDataBase(ply, ply:GetNWInt("playerBankAccount"))
		OdiumATM:Notify(ply, 0, 5, "Vous venez de transférer "..DarkRP.formatMoney(plyMoneyTransfert).." de votre compte sur celui de "..toTransfert)
		for _, v in ipairs(player.GetAll()) do
			if v:GetName() == toTransfert then
				if !v:IsConnected() then OdiumATM:Notify(ply, 1, 5, "Le destinataire n'est pas connecté") return end
				v:SetNWInt("playerBankAccount", v:GetNWInt("playerBankAccount") + plyMoneyTransfert)
				OdiumATM:Notify(v, 0, 5, "Vous avez reçu "..DarkRP.formatMoney(plyMoneyTransfert).." sur votre compte de la part de "..ply:GetName())
			end
		end
	else
		OdiumATM:Notify(ply, 1, 5, "Votre compte ne contient pas assez d'argent pour ce transfert")
	end
end

util.AddNetworkString("OdiumATM::Networking")
net.Receive("OdiumATM::Networking", function(_, ply)
	if !IsValid(ply) or !ply:IsPlayer() then return end
	local act = net.ReadString()
    
    ply.checkSpamB = ply.checkSpamB or 0
	if ply.checkSpamB > CurTime() then return end
	ply.checkSpamB = CurTime() + 2

	if isfunction(actionsNetworks[act]) then
		actionsNetworks[act](ply)
	end
end)
