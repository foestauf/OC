local component = require("component")
local term = require("term")
local sides = require("sides")
local colors = require("colors")
local gpu = component.gpu


local function status(x,y)
    term.clear()
	io.write("Current light level: ",x, "\n")
	if y > 100 then y = "Yes"
        else y = "No"
	end
	io.write("Is it raining?: ")
	gpu.setForeground(0xFF0000) -- Red
	io.write(y)
	gpu.setForeground(0xFFFFFF) -- White
	end
while true do
    local lightlevel = component.redstone.getBundledInput(sides.east,colors.pink)
	local raining = component.redstone.getBundledInput(sides.east,colors.cyan)
	status(lightlevel,raining)
    if lightlevel < 150 then
      component.redstone.setBundledOutput(sides.east,colors.white, 255)
	elseif raining > 100 then
	component.redstone.setBundledOutput(sides.east,colors.white, 255)
    else component.redstone.setBundledOutput(sides.east,colors.white, 0)
    end
  os.sleep(5)
end

