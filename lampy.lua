print("Say Hello to Lampy!")
local component = require("component")
local term = require("term")
local sides = require("sides")
local colors = require("colors")
while true do
    local lightlevel = component.redstone.getbundledInput(sides.east,colors.pink)
    term.write(lightlevel)
    if lightlevel < 150 then
      component.redstone.setBundledOutput(sides.east,colors.white, 255)
    else component.redstone.setBundledOutput(sides.east,colors.white, 0)
    end
  os.sleep(5)
end

