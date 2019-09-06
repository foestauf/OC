local component = require("component")
local fusion = component.nc_fusion_reactor
local gpu = component.gpu

function buildStatus()
	return fusion.isComplete()
end

function buildInfo()
	bool = buildStatus()
	
	if bool == true then
		fusion.activate()
	else
		why = fusion.getProblem()
		io.write("I am not complete because ", why)
	end
end

function currentTemp()
	return fusion.getTemperature()
end
	
function currentEnergy()
	return fusion.getEnergyStored()
end

function overheat()
	temp = currentTemp()
	local maxtemp = fusion.getMaxTemperature()
	overtemp = 0.75*maxtemp
	overheatStatus = false
	
	if temp > overtemp then
		io.write("Overheating: Current Temp = ", temp)
		overheatStatus = true
		fusion.deactivate()
	end
	
	return overheatStatus
	
end
		
function energyfull()	
	energy = currentEnergy()
	local maxenergy = fusion.getMaxEnergyStored()
	almostFull = 0.75*maxenergy
	energyStatus = false
	
	if energy > almostFull  then
		io.write("Current Power Storage = ", energy)
		energyStatus = false
		fusion.deactivate()
	end
	
	return energyStatus	
	
end	

function start()
if buildInfo() == true and overheat() == false and energyfull() == false then
fusion.activate()
elseif overheat() == true then io.write("Overheat Condition")
elseif energyfull() == true then io.write("Internal Buffer Full")
elseif buildInfo() == false then io.write("Not built properly?")
end
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

