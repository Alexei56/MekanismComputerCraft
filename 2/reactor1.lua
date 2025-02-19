
local monitor = peripheral.wrap("left")

local modemSide1 = "back"
local modemSide2 = "top"

rednet.open(modemSide1)
rednet.open(modemSide2)

local r1 = peripheral.find("fissionReactorLogicAdapter")

local rdata = {
  idE = 1,         -- Identificação do reator
  rstatus = false,    -- Recebe estado do reator (Operacional ou Desligado)
  rtemp = nil,          -- Recebe dados de temperatura do reator
  rdamage = nil,        -- Recebe dados de danos do reator
  rfuel = nil          -- Recebe dados do combustível do reator
}

function reac1()
   
   rdata.rtemp = r1.getTemperature()
   rdata.rstatus = r1.getStatus()
   rdata.rdamage = r1.getDamagePercent()
   rdata.rfuel = r1.getFuel()
   
end

function R1sender()
    local rdataS = textutils.serialize(rdata)
    local idR = 3
    rednet.send(idR , rdataS)

end

function R1receiver()
  local id, data = rednet.receive()
  data2 = textutils.unserialise(data)

  if data2.idE == 1 and rdata.rstatus == true  then
   if data2.scram == true then
      r1.scram()
   end
     
  end
end


function mainReactor()
  
   while true do
       
       reac1()
       R1sender()
       R1receiver()
   end
  
end

mainReactor()
