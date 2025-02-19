

 local reactorModel = {}

  reactorModel.securitySysStatus = {
    {idE = 1, reacOverheat = false, reacHighTemp = false, reacLowFuel = false, reacDamage = false, reacRedAlert = false, reacYellowAlert = false, reacSafe = true, scram = false},
    {idE = 2, reacOverheat = false, reacHighTemp = false, reacLowFuel = false, reacDamage = false, reacRedAlert = false, reacYellowAlert = false, reacSafe = true, scram = false},
    {idE = 3, reacOverheat = false, reacHighTemp = false, reacLowFuel = false, reacDamage = false, reacRedAlert = false, reacYellowAlert = false, reacSafe = true, scram = false}
   }

  reactorModel.reactorData = {
    {idE = 1 ,rtemp = nil, rstatus = nil, rdamage = nil,},
    {idE = 2 ,rtemp = nil, rstatus = nil, rdamage = nil},
    {idE = 3 ,rtemp = 0, rstatus = 0, rdamage = 0}
   }

 return reactorModel