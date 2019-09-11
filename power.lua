local component = require("component")
local fusion = component.nc_fusion_reactor
local gpu = component.gpu
local running = true
local term = require("term")
local energy = 0
local status = Normal
local startX = 1
local startY = 1


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

function printEnergy()
	local width, height = gpu.getResolution()
	term.setCursor(startX + 1, startY + 4)
	term.clearLine()
	term.setCursor(startX + 1, startY + 4)
	io.write("Current RF/t: ", math.floor(fusion.getReactorProcessPower()))
	term.setCursor(startX + 1, startY + 2)
	term.clearLine()
	term.setCursor(startX + 1, startY + 2)
	io.write("Current Energy Level: ", energy)
end

function printTemp()
	local width, height = gpu.getResolution()
	term.setCursor(startX + 1, startY + 3)
	term.clearLine()
	term.setCursor(startX + 1, startY + 3)
	if temp > 1000000 then
		temp = temp/1000000
		tempMeas = "MK"
	else
		temp = temp/1000
		tempMeas = "kK"
	end
	io.write("Temperature: ", math.floor(temp))
	io.write(tempMeas)
end

local function printEfficiency()
	local width, height = gpu.getResolution()
	term.setCursor(startX + 1, startY + 1)
	term.clearLine()
	term.setCursor(startX + 1, startY + 1)
	io.write("Current Efficiency: ", math.floor(fusion.getEfficiency()), "%")
end

local function normalStatus()
	io.write("TCRM Reactor Status\n")
	-- io.write("Status")
	printTemp()
	printEnergy()
	printEfficiency()
end

-- Energy Full State

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
	while energyStatus == true do
		local width, height = gpu.getResolution()
		energyfull()
		printEnergy()
		term.setCursor(width/5 + 1, startY + 4)
		term.write("Internal buffer is full\n")
		os.sleep(10)
		if energyStatus == false then
		restart()
		end
	end
	while overheat == true do
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

