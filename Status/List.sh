rm Status.txt

for i in `cat Sort2.txt`
do

	Decode=0
	Pix=0
	Clus=0

	echo  "Run" ${i}

	RunID=$(echo ${i} | sed 's/^[0-9]\{3\}//')


	echo  "Run" ${i}   "  RunID "  ${RunID}


	Decode=$(ls /direct/sphenix+tg+tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Runs/${i}.root | tr -d -c 0-9)


	Pix=$(ls /direct/sphenix+tg+tg01/hf/zshi/MVTXDecoded/Pix/${i}.root | tr -d -c 0-9)


	Clus=$(ls /direct/sphenix+tg+tg01/hf/zshi/MVTXDecoded/Clus/Run${RunID}.root | tr -d -c 0-9)


	Decoded="NO"
	if [ -z "$Decode" ]
	then
		Decoded="NO"	
	else
		Decoded="YES"	
	fi



	Pixed="NO"
	if [ -z "$Pix" ]
	then
		Pixed="NO"	
	else
		Pixed="YES"	
	fi


	Clused="NO"
	if [ -z "$Clus" ]
	then
		Clused="NO"	
	else
		Clused="YES"	
	fi



	#echo "Decoded:   " ${Decoded}


	


	echo "RunID = " ${RunID} "       "  "Decoded: "  ${Decoded}   "       "  "Pixed:  "  ${Pixed}  "       "   "Clused:  "  ${Clused} >> Status.txt



	#echo ""  >> Status.txt 

done





