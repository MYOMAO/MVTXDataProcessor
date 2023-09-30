for i in `cat Sort2.txt`

do
#	echo "Index: "  $q

#	echo "Now Running FileList: "  $i

#	sed -i "13s/.*/RunID=${i}/" condor.sh

#	condor_submit condor.sh

	File=$(ls /direct/sphenix+tg+tg01/hf/zshi/MVTXDecoded/Pix/${i}.root | tr -d -c 0-9)

	if [ -z "$File" ]
	then
		echo "Run: "  $i   " Has No File Decoded"	
	else
		
		echo "Run: "  $i   " Has File Decoded"	

		sed -i "13s/.*/RunID=${i}/" condor.sh
		condor_submit condor.sh

	fi



	

#	q=$((q+1))


#	if [ $q -gt $final ]; then
#		break
#	fi

done

