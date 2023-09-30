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


cp -r ../Pix/macros/ ${Name}/ 
cp ../FileLists/${Run}.txt ${Name}/macros/detectors/sPHENIX/FileList.txt
cp ../Reconnect.sh  ${Name}/


cd ${Name}

source Reconnect.sh


cd macros/detectors/sPHENIX/


echo "NowList"



root -b -l -q Fun4All_G4_sPHENIX.C'('1')'

echo "Now LS see what we have"

ls OutFile/MVTX/*

mv OutFile/MVTX/3DHitTree_0.root /sphenix/tg/tg01/hf/zshi/MVTXDecoded/Pix/${Run}.root



cd ../../../../../

rm -rf workdir/${Name}


