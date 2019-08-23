print("Say Hello to Lampy!")
local component = require("component")
local term = require("term")
local sides = require("sides")
local colors = require("colors")
local redstone = require("redstone")
while true do
    local lightlevel = component.redstone.getbundledInput(sides.west,colors.pink)
    term.write(lightlevel)
    if lightlevel < 8 then
      component.redstone.setbundledOutput(sides.east,colors.white, 255)
    else component.redstone.setbundledOutput(sides.east,colors.white, 0)
    end
  os.sleep(5)
end

