local component = require("component")
local term = require("term")
local sides = require("sides")
local colors = require("colors")
local gpu = component.gpu
local redstone = component.redstone
w, h = component.gpu.getResolution()

function status()
	term.clear()
	local rain = " "
	-- gpu.setBackground(0xB9B9B9) -- Gray Background
	gpu.fill(1,1,w,h, " ")
	lights()
	io.write("Current light level: ",lightlevel, "\n")
	if raining > 100 then rain = "Yes"
        else rain = "No"
	end
	-- drawButton(25,25,"Goof")
	updateRain(rain)
end

function updateRain(x)
	local startX = w/5
	local startY = h/5
	term.setCursor(startX,startY)
	term.clearLine()
	term.setCursor(startX,startY)
	io.write("Is it raining?: ")
	gpu.setForeground(0xFF0000) -- Red
	io.write(x)
	gpu.setForeground(0xFFFFFF) -- White
end

function lights()
    lightlevel = redstone.getBundledInput(sides.east,colors.pink)
	raining = redstone.getBundledInput(sides.east,colors.cyan)
    if lightlevel < 150 then
        redstone.setBundledOutput(sides.east,colors.white, 255)
	    elseif raining > 100 then
	    redstone.setBundledOutput(sides.east,colors.white, 255)
        else redstone.setBundledOutput(sides.east,colors.white, 0)
    end
end

function drawButton(x,y,name)
	gpu.setBackground(0x45EF11)
	gpu.fill(x-2,y-2,8,5, " ")
	term.setCursor(x,y)
	gpu.setForeground(0xFF0000)
	io.write(name)
	gpu.setBackground(0x000000)
	gpu.setForeground(0xFFFFFF)
end

while true do
    status()
    os.sleep(5)
end