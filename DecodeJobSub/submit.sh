q=1
final=385

for i in `cat Sort2.txt`

do
	echo "Index: "  $q

	echo "Now Running FileList: "  $i

	sed -i "13s/.*/RunID=${i}/" condor.sh

	condor_submit condor.sh

	q=$((q+1))


	if [ $q -gt $final ]; then
		break
	fi

done

