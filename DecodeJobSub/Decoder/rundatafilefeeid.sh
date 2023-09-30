if [ "$#" -ne 2 ]; then
    echo "Please provide the data file as an argument."
    echo "Usage: $0 <data_file>"
    exit 1
fi

data_file="$1"
runid=$2
data_file_name=$(basename "$data_file")
#echo "Data file name: $data_file_name"
last_four_numbers=$(echo "$data_file_name" | grep -oE '[0-9]{4}' | tail -n 1)
#echo "Run numbers: $last_four_numbers"

#run_desc="include-predescript-to-make-data-unique"

packet_numbers=($(dlist "$data_file" | awk '/^Packet/ {print $2}'))

packet_dir="packet_root_files"
mkdir -p "$packet_dir"

for packet_number in "${packet_numbers[@]}"
do
	#current_packet_dir="$packet_dir/packet_$packet_number"
    	#mkdir -p "$current_packet_dir"
	echo "Processing packet: $packet_number"

    	output=$(ddump -s -g -n 0 -p "$packet_number" "$data_file" | mvtx-decoder -t 0)
    	feeids=($(echo "$output" | grep -oP '(?<=\[).*?(?=\])' | tr -d ' ' | tr ',' '\n'))

	for feeid in "${feeids[@]}"
	do
	    echo "Processing feeid: $feeid"
	    #ddump -s -g -n 0 -p "$packet_number" "$data_file" | /sphenix/user/aillari/zzcopycode/decoder -t 0 -f "$feeid"
	    ddump -s -g -n 0 -p "$packet_number" "$data_file" | mvtx-decoder -t 0 -f "$feeid"	

	#    mv ./data/testing.root "$packet_dir/datafeeid"$feeid"set"$last_four_numbers".root"
	#mv fhrana_tree/fhrana_.root  "/sphenix/tg/tg01/hf/zshi/MVTXDecoded/Cosmic/Run${runid}/datafeeid"$feeid"set"$last_four_numbers".root"
	mv fhrana_tree/fhrana_.root  "/sphenix/tg/tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Run${runid}/datafeeid"$feeid"set"$last_four_numbers".root"
	done    

	#hadd -f "$packet_dir/mergedpacket"$packet_number"data"$last_four_numbers".root" "$current_packet_dir"/datafeeid*.root
	#rm -r "$current_packet_dir"
done



