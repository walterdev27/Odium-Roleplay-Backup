--[[ Receives a message from the server and show it in the chat ]]--
net.Receive("NinoTime:ClientChat", function()
    local sMsg = net.ReadString()
    chat.AddText((NinoTime.Config.ChatColor or color_white), sMsg)
end)