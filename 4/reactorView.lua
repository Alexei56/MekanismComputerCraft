
  

  local reators = {
    {idE = 1, rstatus = true, rtemp = 0, rdamage = 0, rfuel = 0}, -- Reator 1
    {idE = 2, rstatus = true, rtemp = 0, rdamage = 0, rfuel = 0}, -- Reator 2
    {idE = 3, rstatus = true, rtemp = 0, rdamage = 0, rfuel = 0}  -- Reator 3
  }

  rednet.open("Back")
  
  function reacReceiver()
     
    local id, data = rednet.receive(3)
    local data2 = textutils.unserialise(data)

      reators[1].idE = data2.idE
      reators[1].rtemp = data2.rtemp
      reators[1].rstatus = data2.rstatus
      reators[1].rdamage = data2.rdamage

  end

  function reacStatus()
    statusView = "Operacional"

    if reators[1].rstatus == false then
        statusView = "Desligado"
    end
      
  end
 
  function reac1View()
      reacReceiver()
      reacStatus()
       print("    - Reator 1 -    \n")
       print(" Temperatura: ", string.format("%.2f", reators[1].rtemp), "°C")
       print(" Status: ", statusView)
       print(" Relatorio de danos: ", reators[1].rdamage ,"%")
  end
  
 function reacViewMain ()
    
    while true do
        reac1View()
        sleep(1)
        term.setCursorPos(1,1)
    end
    
 end

 reacViewMain ()