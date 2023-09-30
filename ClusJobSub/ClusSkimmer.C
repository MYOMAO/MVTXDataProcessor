#include "TROOT.h"
#include "TH1.h"
#include "TTree.h"
#include "TH2.h"
#include "TAxis.h"
#include "TF1.h"
#include "TFile.h"
#include "TMath.h"
#include "TSystem.h"
#include "TVector2.h"
#include "TLorentzVector.h"
#include "TVector3.h"
#include "TRandom.h"
#include <iostream>
#include <fstream>
#include "TMath.h"

using namespace std;

using std::cout;
using std::endl;

void ClusSkimmer(int RunNum){




	//	TString infile = "/sphenix/user/zshi/NewCameron/MVTXINTTEvtDisplay/macros/detectors/sPHENIX/OutFile/MVTX/3DHitTree_0.root";


	int Index = 0;

	ifstream FileList("FileList.txt");
	string line;

	while (getline(FileList, line))
	{

		TFile * fin = new TFile(line.c_str());
		fin->cd();

		TTree * MVTXPixelTree = (TTree *) fin->Get("MVTXPixelTree");

		std::map<ULong_t,std::tuple<int,bool,ULong_t,int,int,std::vector<int>,std::vector<float>,std::vector<float>,std::vector<float>>> MVTXHitMap;


		std::vector<float> * ClusX = 0;
		std::vector<float> * ClusY = 0;
		std::vector<float> * ClusZ = 0;
		std::vector<int> * nPixInCluster = 0;





		Long_t L1TrigBCO;
		Long_t StrobeBCO;
		bool L1Trig;

		int EventID;
		int Event;

		int NClus;
		int NPix;

		int TotalClus;
		int TotalPix;

		int NumberHits;

		std::vector<float> ClusXFinal;
		std::vector<float> ClusYFinal;
		std::vector<float> ClusZFinal;
		std::vector<int> nPixInClusterFinal;


		MVTXPixelTree->SetBranchAddress("EventID",&EventID);
		MVTXPixelTree->SetBranchAddress("L1TrigBCOSave",&L1TrigBCO);
		MVTXPixelTree->SetBranchAddress("L1TrigSave",&L1Trig);
		MVTXPixelTree->SetBranchAddress("Strobe_BCO",&StrobeBCO);
		MVTXPixelTree->SetBranchAddress("ClusX",&ClusX);
		MVTXPixelTree->SetBranchAddress("ClusY",&ClusY);
		MVTXPixelTree->SetBranchAddress("ClusZ",&ClusZ);
		MVTXPixelTree->SetBranchAddress("NumberHits",&NumberHits);
		MVTXPixelTree->SetBranchAddress("nPixInCluster",&nPixInCluster);



		int NEvents = MVTXPixelTree->GetEntries();

		for(int i = 0; i < NEvents; i++){

			if(i%100000 == 0) cout << "Now Working on Entry: i  = " << i << "   out of  " <<  NEvents << "   Entries " << endl;

			MVTXPixelTree->GetEntry(i);

			NClus = ClusX->size();


			if (MVTXHitMap.find(L1TrigBCO) != MVTXHitMap.end()){
				TotalPix = std::get<3>(MVTXHitMap.find(L1TrigBCO)->second);
				TotalPix = TotalPix + NumberHits;

				TotalClus = std::get<4>(MVTXHitMap.find(L1TrigBCO)->second);
				TotalClus = TotalClus + NClus;

				nPixInClusterFinal = std::get<5>(MVTXHitMap.find(L1TrigBCO)->second);
				ClusXFinal = std::get<6>(MVTXHitMap.find(L1TrigBCO)->second);
				ClusYFinal = std::get<7>(MVTXHitMap.find(L1TrigBCO)->second);
				ClusZFinal = std::get<8>(MVTXHitMap.find(L1TrigBCO)->second);

				for(int j = 0; j < NClus; j++){

					nPixInClusterFinal.push_back(nPixInCluster->at(j));
					ClusXFinal.push_back(ClusX->at(j));
					ClusYFinal.push_back(ClusY->at(j));
					ClusZFinal.push_back(ClusZ->at(j));

				}

				MVTXHitMap.erase(L1TrigBCO); //Delete the existing for re-insertion		

				//		MVTXHitMap.insert({L1TrigBCO,make_tuple(TotalHits,L1Trig)});
				MVTXHitMap.insert({L1TrigBCO,make_tuple(EventID,L1Trig,StrobeBCO,TotalPix,TotalClus,nPixInClusterFinal,ClusXFinal,ClusYFinal,ClusZFinal)});

			}else{
				//	cout << "BCO = " << BCO << "   is not there yet. Now I add it there" << endl;
				TotalPix = NumberHits + 0;
				TotalClus = NClus + 0;

				for(int j = 0; j < NClus; j++){

					nPixInClusterFinal.push_back(nPixInCluster->at(j));
					ClusXFinal.push_back(ClusX->at(j));
					ClusYFinal.push_back(ClusY->at(j));
					ClusZFinal.push_back(ClusZ->at(j));

				}

				MVTXHitMap.insert({L1TrigBCO,make_tuple(EventID,L1Trig,StrobeBCO,TotalPix,TotalClus,nPixInClusterFinal,ClusXFinal,ClusYFinal,ClusZFinal)});

			}


			ClusXFinal.clear();
			ClusYFinal.clear();
			ClusZFinal.clear();
			nPixInClusterFinal.clear();
			ClusX->clear();
			ClusY->clear();
			ClusZ->clear();
			nPixInCluster->clear();

		}


		cout << "Now Writing this into a Tree" << endl;



		TFile * fout = new TFile(Form("Run%d.root",RunNum),"RECREATE");
		fout->cd();
		TTree * MVTXClusTree = new TTree("MVTXClusTree","MVTXClusTree");
	
		Event = 0;


		int EventIDNew;
		bool L1TrigNew;
		Long_t L1TrigBCONew;
		Long_t StrobeBCONew;
		int TotalPixNew;
		int TotalClusNew;
		std::vector<float> ClusXFinalNew;
		std::vector<float> ClusYFinalNew;
		std::vector<float> ClusZFinalNew;
		std::vector<int> nPixInClusterFinalNew;





		int EventIDNew2;
		bool L1TrigNew2;
		Long_t L1TrigBCONew2;
		Long_t StrobeBCONew2;
		int TotalPixNew2;
		int TotalClusNew2;
		std::vector<float> ClusXFinalNew2;
		std::vector<float> ClusYFinalNew2;
		std::vector<float> ClusZFinalNew2;
		std::vector<int> nPixInClusterFinalNew2;


		MVTXClusTree->Branch("Event",&Event);
		MVTXClusTree->Branch("EventID",&EventIDNew2);
		MVTXClusTree->Branch("L1Trig",&L1TrigNew2);
		MVTXClusTree->Branch("L1TrigBCO",&L1TrigBCONew2);
		MVTXClusTree->Branch("StrobeBCO",&StrobeBCONew2);
		MVTXClusTree->Branch("TotalPix",&TotalPixNew2);
		MVTXClusTree->Branch("TotalClus",&TotalClusNew2);
		MVTXClusTree->Branch("nPixInClusterFinal",&nPixInClusterFinalNew2);
		MVTXClusTree->Branch("ClusXFinal",&ClusXFinalNew2);
		MVTXClusTree->Branch("ClusYFinal",&ClusYFinalNew2);
		MVTXClusTree->Branch("ClusZFinal",&ClusZFinalNew2);


		int TotalCleanClus;
		std::vector<int> nPixInCleanCluster;
		std::vector<float> CleanClusX;
		std::vector<float> CleanClusY;
		std::vector<float> CleanClusZ;

		MVTXClusTree->Branch("TotalCleanClus",&TotalCleanClus);
		MVTXClusTree->Branch("CleanClusX",&CleanClusX);
		MVTXClusTree->Branch("CleanClusY",&CleanClusY);
		MVTXClusTree->Branch("CleanClusZ",&CleanClusZ);


		for ( std::map<ULong_t,std::tuple<int,bool,ULong_t,int,int,std::vector<int>,std::vector<float>,std::vector<float>,std::vector<float>>>::iterator it = MVTXHitMap.begin(); it != MVTXHitMap.end(); ++it ) 
		{


			L1TrigBCONew = it->first;
			EventIDNew = std::get<0>(it->second);
			L1TrigNew = std::get<1>(it->second);
			StrobeBCONew = std::get<2>(it->second);
			TotalPixNew = std::get<3>(it->second);
			TotalClusNew = std::get<4>(it->second);
			nPixInClusterFinalNew = std::get<5>(it->second);
			ClusXFinalNew = std::get<6>(it->second);
			ClusYFinalNew = std::get<7>(it->second);
			ClusZFinalNew = std::get<8>(it->second);


			L1TrigBCONew2 = L1TrigBCONew;
			EventIDNew2 = EventIDNew;
			L1TrigNew2 = L1TrigNew;
			StrobeBCONew2 = StrobeBCONew;
			TotalPixNew2 = TotalPixNew;		
			TotalClusNew2 = TotalClusNew;
			nPixInClusterFinalNew2 = nPixInClusterFinalNew;
			ClusXFinalNew2 = ClusXFinalNew;
			ClusYFinalNew2 = ClusYFinalNew;
			ClusZFinalNew2 = ClusZFinalNew;

			int NClusSize = ClusXFinalNew.size();

			TotalCleanClus = 0;

			for(int q = 0; q < NClusSize; q++){


				if(nPixInClusterFinalNew2[q] > 1){

					TotalCleanClus = TotalCleanClus + 1;
					nPixInCleanCluster.push_back(nPixInClusterFinalNew2[q]);
					CleanClusX.push_back(ClusXFinalNew2[q]);
					CleanClusY.push_back(ClusYFinalNew2[q]);
					CleanClusZ.push_back(ClusZFinalNew2[q]);

				}

			}


			MVTXClusTree->Fill();

			nPixInCleanCluster.clear();
			CleanClusX.clear();
			CleanClusY.clear();
			CleanClusZ.clear();


			Event = Event + 1;
		}



		fout->cd();
		MVTXClusTree->Write();
		fout->Close();



	}

}



