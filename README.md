# VIROS
VIROS project

Repository for ongoing simulations for DOST-UP DILIMAN "V2X Initiatives for Road Safety" (VIROS) Project.

4 way Intersection with 2/3/4 lanes

Simulation with 4 way intersection with 2/3/4 lanes.

1 vehicle type: car

Manual change of stoplight Yellow time: 
variable "j" in "multiple_run.sh" file
phase duration in "stoplight_phase.add.xml" file

Variables for multiple simulations:
Vehicles per Hour (Arrival Rate): 40:40:200
Phase (Stoplight): 40:40:240
Random Seed: 1:1:5

Run the bash file for multiple simulations:
./multiple_run.sh
