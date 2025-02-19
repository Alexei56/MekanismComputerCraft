    
   
   local reactorSecurity = {}

   local reactorModel = require("reactorModel")

   local modemSide1 = "top"

  rednet.open(modemSide1)

 
  function KelvinToCelcius(kelvin)
    kelvin = kelvin - 273.15
    return kelvin
   end

  function reacReceiver()
    
        local id, data = rednet.receive()
        data2 = textutils.unserialise(data)
    
         if data2.idE == 1 then
            reactorModel.reactorData[1].idE = data2.idE
            reactorModel.reactorData[1].rtemp = KelvinToCelcius(data2.rtemp)
            reactorModel.reactorData[1].rstatus = data2.rstatus
            reactorModel.reactorData[1].rdamage = data2.rdamage      
         
         elseif data2.idE == 2 then
            reactorModel.reactorData[2].idE = data2.idE
            reactorModel.reactorData[2].rtemp = KelvinToCelcius(data2.rtemp)
            reactorModel.reactorData[2].rstatus = data2.rstatus
            reactorModel.reactorData[2].rdamage = data2.rdamage
           
         elseif data2.idE == 3 then
            reactorModel.reactorData[3].idE = data2.idE
            reactorModel.reactorData[3].rtemp = KelvinToCelcius(data2.rtemp)
            reactorModel.reactorData[3].rstatus = data2.rstatus
            reactorModel.reactorData[3].rdamage = data2.rdamage
           
         end
  end

  function reactorSecurity.reactorSecuritySys(i)
  
        -- Resetando status antes de verificar as condições
        reactorModel.securitySysStatus[i].reacOverheat = false
        reactorModel.securitySysStatus[i].reacHighTemp = false
        reactorModel.securitySysStatus[i].reacLowFuel = false
        reactorModel.securitySysStatus[i].reacDamage = false
        reactorModel.securitySysStatus[i].reacRedAlert = false
        reactorModel.securitySysStatus[i].reacYellowAlert = false
        reactorModel.securitySysStatus[i].reacSafe = true

        if reactorModel.reactorData[i] then
            if reactorModel.reactorData[i].rtemp > 100 then
                reactorModel.securitySysStatus[i].reacHighTemp = true
                reactorModel.securitySysStatus[i].reacYellowAlert = true
                reactorModel.securitySysStatus[i].reacSafe = false  -- Temperatura muito baixa não é segura
              
            else 
                reactorModel.securitySysStatus[i].reacHighTemp = false
            end



            if reactorModel.reactorData[i].rtemp < 100 then
                reactorModel.securitySysStatus[i].reacOverheat = true
                reactorModel.securitySysStatus[i].reacRedAlert = true
                reactorModel.securitySysStatus[i].reacHighTemp = false -- Também é um caso de alta temperatura
                reactorModel.securitySysStatus[i].reacSafe = false
               
            end
            if reactorModel.reactorData[i].rdamage >= 5 then
                reactorModel.securitySysStatus[i].reacRedAlert = true
                reactorModel.securitySysStatus[i].reacDamage = true
                reactorModel.securitySysStatus[i].reacSafe = false
                
            end
        end
   end
  
   return reactorSecurity