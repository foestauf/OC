print("Say Hello to Lampy!")
local component = require("component")
local term = require("term")
local sides = require("sides")
while true do
    local lightlevel = component.redstone.getInput(sides.north)
    term.write(lightlevel)
    if lightlevel < 8 then
      component.redstone.setOutput(sides.west, 15)
    else component.redstone.setOutput(sides.west, 0)
    end
  os.sleep(5)
end

