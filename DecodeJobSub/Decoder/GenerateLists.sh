for i in `cat NumOnly.txt`

do
	echo "i = " $i
	ls -1 /sphenix/lustre01/sphnxpro/commissioning/MVTX/cosmics/cosmics_mvtx-flx*-*$i*-*evt > FileLists/${i}.txt
	#echo "-------------------------"
		
done
