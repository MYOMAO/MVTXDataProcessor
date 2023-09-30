RunID=$1

for j in `cat ${RunID}.txt`

do
	echo "Now Running File: "  $j

	mkdir /sphenix/tg/tg01/hf/zshi/MVTXDecoded/Clus/Run${RunID}/

	sh rundatafilefeeid.sh $j $RunID

	#	mv fhrana_tree/fhrana_.root /sphenix/tg/tg01/hf/zshi/MVTXDecoded/Cosmic/Run${i}/datafeeid"$feeid"set"$last_four_numbers".root


done


