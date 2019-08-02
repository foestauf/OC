print("Say Hello to Lampy!")
while true do
local lightlevel = component.redstone.getInput(sides.north)
term.write(lightlevel)
