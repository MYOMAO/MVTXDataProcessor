#!/bin/csh
setenv HOME /star/u/$LOGNAME
#setenv HOME /sphenix/user/$LOGNAME

source /etc/csh.login
foreach i (/etc/profile.d/*.csh)
 source $i
end

source $HOME/.login
#source /direct/star+u/zshi/.login

#source /cvmfs/sphenix.sdcc.bnl.gov/x8664_sl7/opt/sphenix/core/bin/sphenix_setup.csh -n ana.141

#source /cvmfs/sphenix.sdcc.bnl.gov/x8664_sl7/opt/sphenix/core/bin/sphenix_setup.csh -n
#source /cvmfs/sphenix.sdcc.bnl.gov/x8664_sl7/opt/sphenix/core/bin/setup_root6.csh

#source /opt/sphenix/core/bin/sphenix_setup.csh -n
#source /opt/sphenix/core/bin/setup_root6.csh

#source /opt/sphenix/core/bin/setup_root6_include_path.csh


echo "START PRINT ENV"

#printenv


echo "DONE PRINt ENV"

set Run=$argv[1]
set Name=$argv[2]




#source /opt/sphenix/core/bin/sphenix_setup.csh -n





#source Build.sh


echo "Now PWD"

pwd

ls

echo "DONE CHECK"

cd workdir

mkdir ${Name}

#source Reconnect.sh


cp -r ../Decoder/ ${Name}/ 
cp ../FileLists/${Run}.txt ${Name}/Decoder/



cd ${Name}/Decoder/

echo "NowList"


sh RunList.sh ${Run}

hadd  /sphenix/tg/tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Runs/${Run}.root /sphenix/tg/tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Run${Run}/*root

rm -rf /sphenix/tg/tg01/hf/zshi/MVTXDecoded/FullCosmicJob/Run${Run}/*root


cd ../../../

rm -rf workdir/${Name}


