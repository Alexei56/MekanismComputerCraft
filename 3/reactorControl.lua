
local reactorProcess = {}

local reactorModel = require("reactorModel")
local reactorSecurity = require("reactorSecurity")

local modemSide1 = "back"
local modemSide2 = "top"

rednet.open(modemSide1)
rednet.open(modemSide2)

function KelvinToCelcius(kelvin)
  kelvin = kelvin - 273.15
  return kelvin
 end

 function reactorSender()
  local reactorDataControl = textutils.serialize(reactorModel.securitySysStatus[1])
  local idR = 2
  rednet.send(idR , reactorDataControl)

 end

 function reactorReceiver()

   
  local id, data = rednet.receive()
  data2 = textutils.unserialise(data)
    
  if data2.idE == 1 then
    reactorModel.reactorData[1].idE = data2.idE
    reactorModel.reactorData[1].rtemp = KelvinToCelcius(data2.rtemp)
    reactorModel.reactorData[1].rstatus = data2.rstatus
    reactorModel.reactorData[1].rdamage = data2.rdamage
    reactorSecurity.reactorSecuritySys(1)
 
 elseif data2.idE == 2 then
    reactorModel.reactorData[2].idE = data2.idE
    reactorModel.reactorData[2].rtemp = KelvinToCelcius(data2.rtemp)
    reactorModel.reactorData[2].rstatus = data2.rstatus
    reactorModel.reactorData[2].rdamage = data2.rdamage
    reactorSecurity.reactorSecuritySys(2)
   
 elseif data2.idE == 3 then
    reactorModel.reactorData[3].idE = data2.idE
    reactorModel.reactorData[3].rtemp = KelvinToCelcius(data2.rtemp)
    reactorModel.reactorData[3].rstatus = data2.rstatus
    reactorModel.reactorData[3].rdamage = data2.rdamage
    reactorSecurity.reactorSecuritySys(3)
   
 end

 end

function reactorProcessSecurity()
  
    if(reactorModel.securitySysStatus[1].reacHighTemp == true) then
       reactorModel.securitySysStatus[1].scram = true
    end
  
end


 function reactorProcess.MainProcess()

   while true do
     reactorReceiver()
     reactorProcessSecurity()
     reactorSender()
     print(" Operacional")
   end

 end

 return reactorProcess