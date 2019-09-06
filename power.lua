local component = require("component")
local fusion = component.nc_fusion_reactor
local complete = fusion.isComplete()
local gpu = component.gpu

function buildStatus()
	local complete = fusion.isComplete()
	return complete
end

function buildInfo()
	bool = buildStatus()
	if bool == true then
		fusion.activate()
	else
		why = fusion.getProblem()
		io.write("I am not complete because ", why)
end

function currentTemp()
	return fusion.getTemperature()
end
	
function currentEnergy()
	return fusion.getEnergyStored()
end

function overheat()
	temp = currentTemp()
	maxtemp = fusion.getMaxTemperature()
	overtemp = 0.75*maxtemp
	overheatStatus = false
	if currentTemp > overtemp then
		io.write("Overheating: Current Temp = ", temp)
		overheatStatus = true
		return overheatStatus
		fusion.deactivate()
	else
		overheatStatus = false
		return overheatStatus
	end
end
		
function energyfull()	
	energy = currentEnergy()
	maxenergy = fusion.getMaxEnergyStored()
	overenergy = 0.75*maxenergy
	energyStatus = false
	if currentTemp > overenergy then
		io.write("Current Power Storagy = ", energy)
		overheatStatus = false
		return energyStatus
		fusion.deactivate()
	else
		energyStatus = false
		return energyStatus
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

