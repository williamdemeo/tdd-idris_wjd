module Vehicle

data PowerSource = Petrol | Pedal | Electric

-- the fuel field holds the current fuel level
data Vehicle : PowerSource -> Type where
     Bicycle : Vehicle Pedal
     Car : (fuel : Nat) -> Vehicle Petrol
     Bus : (fuel : Nat) -> Vehicle Petrol
     Motorcycle : (fuel : Nat) -> Vehicle Petrol
     Unicycle : Vehicle Pedal

wheels : Vehicle power -> Nat
wheels Bicycle = 2
wheels (Car fuel) = 4
wheels (Bus fuel) = 4
wheels (Motorcycle fuel) = 2
wheels Unicycle = 1

refuel : Vehicle Petrol -> Vehicle Petrol
refuel (Car fuel) = Car 100
refuel (Bus fuel) = Bus 200
refuel Bicycle impossible
refuel (Motorcycle fuel) = Motorcycle 20
refuel Unicycle impossible

{-- Notes: Dependent data types like Vehicle are sometimes referred to as
    "FAMILIES OF TYPES" or "TYPE CLASSES", because we're defining multiple
    related types at the same time. In this case, the power source (Petrol
    or Pedal) is an index of the Vehicle family. The index tells you exactly
    which Vehicle type you mean. --}
