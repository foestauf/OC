print("Say Hello to Lampy!")
local component = require("component")
local term = require("term")
while true do
    local lightlevel = component.redstone.getInput(sides.north)
    term.write(lightlevel)
    if lightlevel > 6 then
      component.redstone.setOutput(sides.west, 15)
    else component.redstone.setOutput(sides.west, 0)
    end
  os.sleep(5)
end

