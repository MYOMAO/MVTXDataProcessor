q=1
final=3

for i in `cat Sort2.txt`

do
#	echo "Index: "  $q

	File=$(ls /direct/sphenix+tg+tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Runs/${i}.root | tr -d -c 0-9)
	
	if [ -z "$File" ]
	then
		echo "Run: "  $i   " Has No File Decoded"	
	else
		

		echo "Run: "  $i   " Has File Decoded"	

		sed -i "13s/.*/RunID=${i}/" condor.sh
		condor_submit condor.sh
		q=$((q+1))

	fi



#	q=$((q+1))


	if [ $q -gt $final ]; then
		break
	fi

done

