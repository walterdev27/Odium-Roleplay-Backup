function RX(x) return x/1920*ScrW() end
function RY(y) return y/1080*ScrH() end

function Odium_Mayor:GetCountLaws()
    local count = 0
    for k, v in pairs(DarkRP.getLaws()) do
        count = count + 1
    end
    return tonumber(count)
end

surface.CreateFont( "OdiumMayor_Font1", {
	font = "Righteous",
	extended = false,
	size = 50,
	weight = 1000
})
surface.CreateFont( "OdiumMayor_Font2", {
	font = "Roboto",
	extended = false,
	size = 30,
	weight = 800
})   
surface.CreateFont( "OdiumMayor_Font11", {
	font = "Righteous",
	extended = false,
	size = 30,
	weight = 800
})   
surface.CreateFont( "OdiumMayor_Font3", {
	font = "Roboto",
	extended = false,
	size = 25,
	weight = 800
})  
surface.CreateFont( "OdiumMayor_Font4", {
	font = "Roboto",
	extended = false,
	size = 20,
	weight = 800
})  
surface.CreateFont( "OdiumMayor_FontA3D2D", {
	font = "Roboto",
	extended = false,
	size = 20,
	weight = 700
})
surface.CreateFont( "OdiumMayor_FontB3D2D", {
	font = "Roboto",
	extended = false,
	size = 35,
	weight = 700
})
surface.CreateFont( "OdiumMayor_FontC3D2D", {
	font = "Roboto",
	extended = false,
	size = 35,
	weight = 500
})
surface.CreateFont( "OdiumMayor_FontD3D2D", {
	font = "Roboto",
	extended = false,
	size = 80,
	weight = 700
})
surface.CreateFont( "OdiumMayor_Font", {
	font = "Roboto",
	extended = false,
	size = 25,
	weight = 500
})

