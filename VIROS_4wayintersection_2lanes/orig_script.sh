#!/bin/bash

echo "Batch Run"
g=40
h=40
j=5
for ((i = 1; i <= 5; i++))
do
	echo "Run vehicles: ${g} phase: ${h} yellow light: ${j} seed: ${i}"
	sumo -c 4wayint.sumocfg --seed $i
	mv "edge_data.xml" "v${g}_p${h}_y${j}_s${i}_edge_data.xml"
	mv "lane_data.xml" "v${g}_p${h}_y${j}_s${i}_lane_data.xml"
	mv "summary_data.xml" "v${g}_p${h}_y${j}_s${i}_summary_data.xml"
	mv "stoplight_data.xml" "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml"
	python ~/src/sumo-1.11.0/tools/xml/xml2csv.py "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml" --output "v${g}_p${h}_y${j}_s${i}_stoplight_data.csv"
	mv "v${g}_p${h}_y${j}_s${i}_edge_data.xml" /home/veins/Desktop/VIROS_4way_car_3lanes/data/
	mv "v${g}_p${h}_y${j}_s${i}_lane_data.xml" /home/veins/Desktop/VIROS_4way_car_3lanes/data/
	mv "v${g}_p${h}_y${j}_s${i}_summary_data.xml" /home/veins/Desktop/VIROS_4way_car_3lanes/data/
	mv "v${g}_p${h}_y${j}_s${i}_stoplight_data.xml" /home/veins/Desktop/VIROS_4way_car_3lanes/data/
	mv "v${g}_p${h}_y${j}_s${i}_stoplight_data.csv" /home/veins/Desktop/VIROS_4way_car_3lanes/data/
done


:'
for ((g = 10; g <= 200; g+10))
	do
	vehsum=$(expr ${g} - 10)
	echo "Vehicle = ${g}"
	echo "vehsum = ${vehsum}"
	sed -i "s/${vehsum}/${g}/g" "4wayint.rou.xml"
	for ((h = 40; h <= 240; h+40))
		do
		phasesum=$(expr ${h} - 40)
		echo "Phase = ${h}"
		echo "phasesum = ${phasesum}"
		sed -i "s/${phasesum}/${h}/g" "edge.add.xml"
		sed -i "s/${phasesum}/${h}/g" "lane.add.xml"
		sed -i "2s/${phasesum}/${h}/g" "stoplight_info.add.xml"
		sed -i "10s/${phasesum}/${h}/g" "stoplight_info.add.xml"
		sed -i "18s/${phasesum}/${h}/g" "stoplight_info.add.xml"
		sed -i "26s/${phasesum}/${h}/g" "stoplight_info.add.xml"
		for ((i = 1; i <= 2; i++))
		do
			echo "Run vehicles: ${g} phase: ${h} seed ${i}"
			sumo -c 4wayint.sumocfg --seed $i
			mv "edge_data.xml" "v${g}_p${h}_s${i}_edge_data.xml"
			mv "lane_data.xml" "v${g}_p${h}_s${i}_lane_data.xml"
			mv "summary_data.xml" "v${g}_p${h}_s${i}_summary_data.xml"
			mv "stoplight_data.xml" "v${g}_p${h}_s${i}_stoplight_data.xml"
			python ~/src/sumo-1.11.0/tools/xml/xml2csv.py "v${g}_p${h}_s${i}_stoplight_data.xml" --output "v${g}_p${h}_s${i}_stoplight_data.csv"
			mv "v${g}_p${h}_s${i}_edge_data.xml" /home/veins/Desktop/VIROS_4way_car_only/data/
			mv "v${g}_p${h}_s${i}_lane_data.xml" /home/veins/Desktop/VIROS_4way_car_only/data/
			mv "v${g}_p${h}_s${i}_summary_data.xml" /home/veins/Desktop/VIROS_4way_car_only/data/
			mv "v${g}_p${h}_s${i}_stoplight_data.xml" /home/veins/Desktop/VIROS_4way_car_only/data/
			mv "v${g}_p${h}_s${i}_stoplight_data.csv" /home/veins/Desktop/VIROS_4way_car_only/data/
		done
	done
done
'
