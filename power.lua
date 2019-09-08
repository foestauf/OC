local component = require("component")
local fusion = component.nc_fusion_reactor
local gpu = component.gpu
local running = true
local term = require("term")
local energy = 0
local status = Normal

-- Status Functions
function buildStatus()
	return fusion.isComplete()
end

function currentTemp()
	return fusion.getTemperature()
end
	
function currentEnergy()
	return fusion.getEnergyStored()
end

local function normalStatus()
	term.clear()
	io.write("TCRM Reactor Status\n")
	-- io.write("Status")
	io.write("\n Current Energy Level: ", energy)
	if temp > 1000000 then
		temp = temp/1000000
		tempMeas = "MK"
	else
		temp = temp/1000
		tempMeas = "kK"
	end
	io.write("\n Temperature: ", math.floor(temp))
	io.write("\n Current RF/t: ", math.floor(fusion.getReactorProcessPower()))
	io.write(tempMeas)
	local efficiency = fusion.getEfficiency()
	efficiency = math.floor(efficiency)
	io.write("\n Current Efficiency: ", efficiency, "%")
end

-- Check Current Status --
function buildInfo()
	bool = buildStatus()
	
	if bool == false then
		why = fusion.getProblem()
		exit_msg(why)
	end
	
	return bool
end


function safety()
	overheat()
	energyfull()
	io.write("\n Safeguardian Enabled\n")
	if energyStatus == true then
		term.write("\nInternal buffer is full\n")
		os.sleep(10)
		energyfull()
		if energyStatus == false then
		restart()
		end
	end
	if overheat == true then
		io.write("OVERHEATED!")
		os.sleep(10)
		overheat()
		if overheatStatus == false then
			restart()
		end
	end
end

function restart()
	io.write("Attempting to restart reactor\n")
	if buildInfo() == true and overheat() == false and energyfull() == false then
		fusion.activate()
		status = Normal
	end
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
		-- io.write("Current Power Storage = ", energy)
		energyStatus = true
		fusion.deactivate()
	end
	
	return energyStatus	
	
end	

function start()
	if buildInfo() == true and overheat() == false and energyfull() == false then
		fusion.activate()
		status = Normal
	elseif overheat() == true then
		term.clear()
		io.write("Overheat Condition")
	elseif energyfull() == true then
		term.clear()	
		io.write("Internal Buffer Full")
	elseif buildInfo() == false then
		term.clear()	
		io.write("Not built properly?")
	end
end
	

-- Exit Message
function exit_msg(msg)
  term.clear()
  fusion.deactivate()
  term.write("TCRM Exiting!\n")
  print(msg)
  os.exit()
end
-- Start Reactor
start()

-- Main Loop
while running do
	term.clear()
	if status == Normal then
		normalStatus()
		safety()
	end
	os.sleep(1)
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

