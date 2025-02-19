
local monitor = peripheral.wrap("left")

local modemSide1 = "back"
local modemSide2 = "top"

rednet.open(modemSide1)
rednet.open(modemSide2)

local r3 = peripheral.find("fissionReactorLogicAdapter")

local rdata = {
  idE = 3,              -- Identificação do reator
  rstatus = false,      -- Recebe estado do reator (Operacional ou Desligado)
  rtemp = nil,          -- Recebe dados de temperatura do reator
  rdamage = nil,        -- Recebe dados de danos do reator
  rfuel = nil           -- Recebe dados do combustível do reator
}

function reac3()
   
   rdata.rtemp = r3.getTemperature()
   rdata.rstatus = r3.getStatus()
   rdata.rdamage = r3.getDamagePercent()
   rdata.rfuel = r3.getFuel()
   
end

function R3sender()
    local rdataS = textutils.serialize(rdata)
    local idR = 3
    rednet.send(idR , rdataS)

end

function mainReactor()
  
   while true do
       reac3()
       R3sender()
       sleep(math.random(0.1, 0.3))
   end
  
end

mainReactor()
