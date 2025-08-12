local function RespX(x)
    return x / 1920 * ScrW()
end
local function RespY(y)
    return y / 1080 * ScrH()
end

surface.CreateFont("NAR:Font:1", {
	font = "Righteous",
	extended = false,
	size = 50,
	weight = 500,
})

surface.CreateFont("NAR:Font:2", {
	font = "Righteous",
	extended = false,
	size = 100,
	weight = 500,
})

surface.CreateFont("NAR:Font:3", {
	font = "Righteous",
	extended = false,
	size = 30,
	weight = 500,
})

surface.CreateFont("NAR:Font:4", {
	font = "Righteous",
	extended = false,
	size = 155,
	weight = 500,
})