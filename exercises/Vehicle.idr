module Vehicle

data PowerSource = Petrol | Pedal | Electric

-- the fuel field holds the current fuel level
data Vehicle : PowerSource -> Type where
     Car : (fuel : Nat) -> Vehicle Petrol
     Ecar : (charge : Nat) -> Vehicle Electric
     Bus : (fuel : Nat) -> Vehicle Petrol
     Motorcycle : (fuel : Nat) -> Vehicle Petrol
     Tram : (charge : Nat) -> Vehicle Electric
     Bicycle : Vehicle Pedal
     Unicycle : Vehicle Pedal

wheels : Vehicle power -> Nat
wheels (Car fuel) = 4
wheels (Ecar charge) = 4
wheels (Bus fuel) = 4
wheels (Motorcycle fuel) = 2
wheels (Tram charge) = 0
wheels Bicycle = 2
wheels Unicycle = 1

recharge : Vehicle Electric -> Vehicle Electric
recharge (Car fuel) impossible
recharge (Ecar charge) = Ecar 10
recharge (Bus fuel) impossible
recharge (Motorcycle fuel) impossible
recharge (Tram charge) = Tram 40
recharge Bicycle impossible
recharge Unicycle impossible

refuel : Vehicle Petrol -> Vehicle Petrol
refuel (Car fuel) = Car 100
refuel (Ecar charge) impossible
refuel (Bus fuel) = Bus 200
refuel (Motorcycle fuel) = Motorcycle 20
refuel (Tram charge) impossible
refuel Bicycle impossible
refuel Unicycle impossible

{-- Notes: Dependent data types like Vehicle are sometimes referred to as
    "FAMILIES OF TYPES" or "TYPE CLASSES", because we're defining multiple
    related types at the same time. In this case, the power source (Petrol
    or Pedal) is an index of the Vehicle family. The index tells you exactly
    which Vehicle type you mean. --}
