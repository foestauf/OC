local component = require("component")
local fusion = component.nc_fusion_reactor
local complete = fusion.isComplete()
local gpu = component.gpu

if complete == true then
	fusion.activate()
else
	why = fusion.getProblem()
	io.write("I am not complete because ", why)
end
-- AM I COMPLETE

-- YES/NO WHY NOT

-- CAN I START?

-- turn on/turn off

-- HOW BIG AM I

-- WHAT IS ENERGY CHANGE RATE

-- WHAT IS COOLING RATE

-- WHAT IS MY EFFICIENCY

-- BASED ON FUEL what is deal temperature vs max temperature

-- HOW MUCH POWER

-- AM I OVERHEATED

-- AM I FULL ON POWER

