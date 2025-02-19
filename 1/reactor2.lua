local monitor = peripheral.wrap("left")

local modemSide1 = "back"
local modemSide2 = "top"

rednet.open(modemSide1)
rednet.open(modemSide2)

local r2 = peripheral.find("fissionReactorLogicAdapter")

local rdata = {
  idE = 2,         -- Identificação do reator
  rstatus = false,    -- Recebe estado do reator (Operacional ou Desligado)
  rtemp = nil,          -- Recebe dados de temperatura do reator
  rdamage = nil,        -- Recebe dados de danos do reator
  rfuel = nil           -- Recebe dados do combustível do reator
}

function reac1()
   
   rdata.rtemp = r2.getTemperature()
   rdata.rstatus = r2.getStatus()
   rdata.rdamage = r2.getDamagePercent()
   rdata.rfuel = r2.getFuel()
   
end

function R2sender()
    local rdataS = textutils.serialize(rdata)
    local idR = 3
    rednet.send(idR , rdataS)

end

function mainReactor()
  
   while true do
       reac1()
       R2sender()
       sleep(math.random(0.1, 0.3))
   end
  
end

mainReactor()