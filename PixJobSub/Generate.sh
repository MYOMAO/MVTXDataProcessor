for i in `cat Sort2.txt`
do

	echo  "Run" ${i}

	ls /sphenix/tg/tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Runs/${i}.root > FileLists/${i}.txt

	 

done
