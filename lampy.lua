print("Say Hello to Lampy!")
while true do
    local lightlevel = component.redstone.getInput(sides.north)
    term.write(lightlevel)
    if lightlevel > 6 then
      component.redstone.setOutput(sides.west, 15)
    else component.redstone.setOutput(sides.west, 0)
    end
end

