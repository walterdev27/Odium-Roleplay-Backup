local actionsNetworks = {}

actionsNetworks["ATMOpenFrame"] = function()
    OdiumATM:AtmFrame()
end

net.Receive("OdiumATM::Networking", function()
	local act = net.ReadString()
	
	if isfunction(actionsNetworks[act]) then
		actionsNetworks[act]()
	end
end)