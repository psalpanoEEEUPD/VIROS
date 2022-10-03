#!/bin/bash

echo "Batch Run"
j=3
for ((g = 40; g <= 600; g+=40))
do
	sed -i "s+vehsPerHour=.*+vehsPerHour=\"${g}\"/>+" "4wayint.rou.xml"
	for ((h = 40, k=10-$j; h <= 240; h+=40, k+=10))
	do
		sed -i "s+period=.*+period=\"${h}\"/>+" "edge.add.xml"
		sed -i "s+period=.*+period=\"${h}\"/>+" "lane.add.xml"
		sed -i "s+freq=.*+freq=\"${h}\">+" "stoplight_info.add.xml"
		sed -i "3s+duration=.*+duration=\"${k}\"/>+" "stoplight_phase.add.xml"
		sed -i "5s+duration=.*+duration=\"${k}\"/>+" "stoplight_phase.add.xml"
		sed -i "7s+duration=.*+duration=\"${k}\"/>+" "stoplight_phase.add.xml"
		sed -i "9s+duration=.*+duration=\"${k}\"/>+" "stoplight_phase.add.xml"
		for ((i = 1; i <= 5; i++))
		do
			echo "Run vehicles: ${g}, phase: ${h}, yellow light: ${j}, seed: ${i}"
			sumo -c 4wayint.sumocfg --seed $i
			mv "edge_data.xml" "v${g}_p${h}_y${j}_s${i}_edge_data.xml"
			mv "lane_data.xml" "v${g}_p${h}_y${j}_s${i}_lane_data.xml"
			mv "summary_data.xml" "v${g}_p${h}_y${j}_s${i}_summary_data.xml"
			mv "stoplight_data.xml" "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml"
			python ~/src/sumo-1.11.0/tools/xml/xml2csv.py "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml" --output "v${g}_p${h}_y${j}_s${i}_stoplight_data.csv"
			mv "v${g}_p${h}_y${j}_s${i}_edge_data.xml" /home/veins/Desktop/VIROS_4way_car_2lanes/data/
			mv "v${g}_p${h}_y${j}_s${i}_lane_data.xml" /home/veins/Desktop/VIROS_4way_car_2lanes/data/
			mv "v${g}_p${h}_y${j}_s${i}_summary_data.xml" /home/veins/Desktop/VIROS_4way_car_2lanes/data/
			mv "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml" /home/veins/Desktop/VIROS_4way_car_2lanes/data/
			mv "v${g}_p${h}_y${j}_s${i}_stoplight_data.csv" /home/veins/Desktop/VIROS_4way_car_2lanes/data/
			sleep 2
		done
		let i--
		echo "Run vehicles: ${g}, phase: ${h}, yellow light: ${j}, seed: ${i} DONE!!!"
	done
done
