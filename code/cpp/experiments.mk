data/BIZ_SC_quick.txt: experiments BIZ.cpp problems/SC.dat
	./experiments BIZ problems/SC.dat 500 > data/BIZ_SC_quick.txt

data/BIZ_SC_final.txt: experiments BIZ.cpp problems/SC.dat
	./experiments BIZ problems/SC.dat 10000 > data/BIZ_SC_final.txt

data/BIZ_MDM_quick.txt: experiments BIZ.cpp problems/MDM.dat
	./experiments BIZ problems/MDM.dat 500 > data/BIZ_MDM_quick.txt

data/BIZ_MDM_final.txt: experiments BIZ.cpp problems/MDM.dat
	./experiments BIZ problems/MDM.dat 10000 > data/BIZ_MDM_final.txt

data/BIZ_RPI_quick.txt: experiments BIZ.cpp problems/RPI.dat
	./experiments BIZ problems/RPI.dat 500 > data/BIZ_RPI_quick.txt

data/BIZ_RPI_final.txt: experiments BIZ.cpp problems/RPI.dat
	./experiments BIZ problems/RPI.dat 10000 > data/BIZ_RPI_final.txt

data/KN_SC_quick.txt: experiments KN.cpp problems/SC.dat
	./experiments KN problems/SC.dat 500 > data/KN_SC_quick.txt

data/KN_SC_final.txt: experiments KN.cpp problems/SC.dat
	./experiments KN problems/SC.dat 10000 > data/KN_SC_final.txt

data/KN_MDM_quick.txt: experiments KN.cpp problems/MDM.dat
	./experiments KN problems/MDM.dat 500 > data/KN_MDM_quick.txt

data/KN_MDM_final.txt: experiments KN.cpp problems/MDM.dat
	./experiments KN problems/MDM.dat 10000 > data/KN_MDM_final.txt

data/KN_RPI_quick.txt: experiments KN.cpp problems/RPI.dat
	./experiments KN problems/RPI.dat 500 > data/KN_RPI_quick.txt

data/KN_RPI_final.txt: experiments KN.cpp problems/RPI.dat
	./experiments KN problems/RPI.dat 10000 > data/KN_RPI_final.txt

data/BKS_SC_quick.txt: experiments BKS.cpp problems/SC.dat
	./experiments BKS problems/SC.dat 500 > data/BKS_SC_quick.txt

data/BKS_SC_final.txt: experiments BKS.cpp problems/SC.dat
	./experiments BKS problems/SC.dat 10000 > data/BKS_SC_final.txt

data/BKS_MDM_quick.txt: experiments BKS.cpp problems/MDM.dat
	./experiments BKS problems/MDM.dat 500 > data/BKS_MDM_quick.txt

data/BKS_MDM_final.txt: experiments BKS.cpp problems/MDM.dat
	./experiments BKS problems/MDM.dat 10000 > data/BKS_MDM_final.txt

data/BKS_RPI_quick.txt: experiments BKS.cpp problems/RPI.dat
	./experiments BKS problems/RPI.dat 500 > data/BKS_RPI_quick.txt

data/BKS_RPI_final.txt: experiments BKS.cpp problems/RPI.dat
	./experiments BKS problems/RPI.dat 10000 > data/BKS_RPI_final.txt

data/Paulson_SC_quick.txt: experiments Paulson.cpp problems/SC.dat
	./experiments Paulson problems/SC.dat 500 > data/Paulson_SC_quick.txt

data/Paulson_SC_final.txt: experiments Paulson.cpp problems/SC.dat
	./experiments Paulson problems/SC.dat 10000 > data/Paulson_SC_final.txt

data/Paulson_MDM_quick.txt: experiments Paulson.cpp problems/MDM.dat
	./experiments Paulson problems/MDM.dat 500 > data/Paulson_MDM_quick.txt

data/Paulson_MDM_final.txt: experiments Paulson.cpp problems/MDM.dat
	./experiments Paulson problems/MDM.dat 10000 > data/Paulson_MDM_final.txt

data/Paulson_RPI_quick.txt: experiments Paulson.cpp problems/RPI.dat
	./experiments Paulson problems/RPI.dat 500 > data/Paulson_RPI_quick.txt

data/Paulson_RPI_final.txt: experiments Paulson.cpp problems/RPI.dat
	./experiments Paulson problems/RPI.dat 10000 > data/Paulson_RPI_final.txt

data/BIZHET_SC_INC_quick.txt: experiments BIZHET.cpp problems/SC_INC.dat
	./experiments BIZHET problems/SC_INC.dat 500 > data/BIZHET_SC_INC_quick.txt

data/BIZHET_SC_INC_final.txt: experiments BIZHET.cpp problems/SC_INC.dat
	./experiments BIZHET problems/SC_INC.dat 10000 > data/BIZHET_SC_INC_final.txt

data/BIZHET_SC_DEC_quick.txt: experiments BIZHET.cpp problems/SC_DEC.dat
	./experiments BIZHET problems/SC_DEC.dat 500 > data/BIZHET_SC_DEC_quick.txt

data/BIZHET_SC_DEC_final.txt: experiments BIZHET.cpp problems/SC_DEC.dat
	./experiments BIZHET problems/SC_DEC.dat 10000 > data/BIZHET_SC_DEC_final.txt

data/BIZHET_MDM_INC_quick.txt: experiments BIZHET.cpp problems/MDM_INC.dat
	./experiments BIZHET problems/MDM_INC.dat 500 > data/BIZHET_MDM_INC_quick.txt

data/BIZHET_MDM_INC_final.txt: experiments BIZHET.cpp problems/MDM_INC.dat
	./experiments BIZHET problems/MDM_INC.dat 10000 > data/BIZHET_MDM_INC_final.txt

data/BIZHET_MDM_DEC_quick.txt: experiments BIZHET.cpp problems/MDM_DEC.dat
	./experiments BIZHET problems/MDM_DEC.dat 500 > data/BIZHET_MDM_DEC_quick.txt

data/BIZHET_MDM_DEC_final.txt: experiments BIZHET.cpp problems/MDM_DEC.dat
	./experiments BIZHET problems/MDM_DEC.dat 10000 > data/BIZHET_MDM_DEC_final.txt

data/BIZHET_RPI_hetero_quick.txt: experiments BIZHET.cpp problems/RPI_hetero.dat
	./experiments BIZHET problems/RPI_hetero.dat 500 > data/BIZHET_RPI_hetero_quick.txt

data/BIZHET_RPI_hetero_final.txt: experiments BIZHET.cpp problems/RPI_hetero.dat
	./experiments BIZHET problems/RPI_hetero.dat 10000 > data/BIZHET_RPI_hetero_final.txt

data/BIZHET_SC_INCA_quick.txt: experiments BIZHET.cpp problems/SC_INCA.dat
	./experiments BIZHET problems/SC_INCA.dat 500 > data/BIZHET_SC_INCA_quick.txt

data/BIZHET_SC_INCA_final.txt: experiments BIZHET.cpp problems/SC_INCA.dat
	./experiments BIZHET problems/SC_INCA.dat 10000 > data/BIZHET_SC_INCA_final.txt

data/BIZHET_SC_DECA_quick.txt: experiments BIZHET.cpp problems/SC_DECA.dat
	./experiments BIZHET problems/SC_DECA.dat 500 > data/BIZHET_SC_DECA_quick.txt

data/BIZHET_SC_DECA_final.txt: experiments BIZHET.cpp problems/SC_DECA.dat
	./experiments BIZHET problems/SC_DECA.dat 10000 > data/BIZHET_SC_DECA_final.txt

data/BIZHET_MDM_INCA_quick.txt: experiments BIZHET.cpp problems/MDM_INCA.dat
	./experiments BIZHET problems/MDM_INCA.dat 500 > data/BIZHET_MDM_INCA_quick.txt

data/BIZHET_MDM_INCA_final.txt: experiments BIZHET.cpp problems/MDM_INCA.dat
	./experiments BIZHET problems/MDM_INCA.dat 10000 > data/BIZHET_MDM_INCA_final.txt

data/BIZHET_MDM_DECA_quick.txt: experiments BIZHET.cpp problems/MDM_DECA.dat
	./experiments BIZHET problems/MDM_DECA.dat 500 > data/BIZHET_MDM_DECA_quick.txt

data/BIZHET_MDM_DECA_final.txt: experiments BIZHET.cpp problems/MDM_DECA.dat
	./experiments BIZHET problems/MDM_DECA.dat 10000 > data/BIZHET_MDM_DECA_final.txt

data/BIZHET_RPI_heteroA_quick.txt: experiments BIZHET.cpp problems/RPI_heteroA.dat
	./experiments BIZHET problems/RPI_heteroA.dat 500 > data/BIZHET_RPI_heteroA_quick.txt

data/BIZHET_RPI_heteroA_final.txt: experiments BIZHET.cpp problems/RPI_heteroA.dat
	./experiments BIZHET problems/RPI_heteroA.dat 10000 > data/BIZHET_RPI_heteroA_final.txt

data/KNHET_SC_INC_quick.txt: experiments KNHET.cpp problems/SC_INC.dat
	./experiments KNHET problems/SC_INC.dat 500 > data/KNHET_SC_INC_quick.txt

data/KNHET_SC_INC_final.txt: experiments KNHET.cpp problems/SC_INC.dat
	./experiments KNHET problems/SC_INC.dat 10000 > data/KNHET_SC_INC_final.txt

data/KNHET_SC_DEC_quick.txt: experiments KNHET.cpp problems/SC_DEC.dat
	./experiments KNHET problems/SC_DEC.dat 500 > data/KNHET_SC_DEC_quick.txt

data/KNHET_SC_DEC_final.txt: experiments KNHET.cpp problems/SC_DEC.dat
	./experiments KNHET problems/SC_DEC.dat 10000 > data/KNHET_SC_DEC_final.txt

data/KNHET_MDM_INC_quick.txt: experiments KNHET.cpp problems/MDM_INC.dat
	./experiments KNHET problems/MDM_INC.dat 500 > data/KNHET_MDM_INC_quick.txt

data/KNHET_MDM_INC_final.txt: experiments KNHET.cpp problems/MDM_INC.dat
	./experiments KNHET problems/MDM_INC.dat 10000 > data/KNHET_MDM_INC_final.txt

data/KNHET_MDM_DEC_quick.txt: experiments KNHET.cpp problems/MDM_DEC.dat
	./experiments KNHET problems/MDM_DEC.dat 500 > data/KNHET_MDM_DEC_quick.txt

data/KNHET_MDM_DEC_final.txt: experiments KNHET.cpp problems/MDM_DEC.dat
	./experiments KNHET problems/MDM_DEC.dat 10000 > data/KNHET_MDM_DEC_final.txt

data/KNHET_RPI_hetero_quick.txt: experiments KNHET.cpp problems/RPI_hetero.dat
	./experiments KNHET problems/RPI_hetero.dat 500 > data/KNHET_RPI_hetero_quick.txt

data/KNHET_RPI_hetero_final.txt: experiments KNHET.cpp problems/RPI_hetero.dat
	./experiments KNHET problems/RPI_hetero.dat 10000 > data/KNHET_RPI_hetero_final.txt

data/KNHET_SC_INCA_quick.txt: experiments KNHET.cpp problems/SC_INCA.dat
	./experiments KNHET problems/SC_INCA.dat 500 > data/KNHET_SC_INCA_quick.txt

data/KNHET_SC_INCA_final.txt: experiments KNHET.cpp problems/SC_INCA.dat
	./experiments KNHET problems/SC_INCA.dat 10000 > data/KNHET_SC_INCA_final.txt

data/KNHET_SC_DECA_quick.txt: experiments KNHET.cpp problems/SC_DECA.dat
	./experiments KNHET problems/SC_DECA.dat 500 > data/KNHET_SC_DECA_quick.txt

data/KNHET_SC_DECA_final.txt: experiments KNHET.cpp problems/SC_DECA.dat
	./experiments KNHET problems/SC_DECA.dat 10000 > data/KNHET_SC_DECA_final.txt

data/KNHET_MDM_INCA_quick.txt: experiments KNHET.cpp problems/MDM_INCA.dat
	./experiments KNHET problems/MDM_INCA.dat 500 > data/KNHET_MDM_INCA_quick.txt

data/KNHET_MDM_INCA_final.txt: experiments KNHET.cpp problems/MDM_INCA.dat
	./experiments KNHET problems/MDM_INCA.dat 10000 > data/KNHET_MDM_INCA_final.txt

data/KNHET_MDM_DECA_quick.txt: experiments KNHET.cpp problems/MDM_DECA.dat
	./experiments KNHET problems/MDM_DECA.dat 500 > data/KNHET_MDM_DECA_quick.txt

data/KNHET_MDM_DECA_final.txt: experiments KNHET.cpp problems/MDM_DECA.dat
	./experiments KNHET problems/MDM_DECA.dat 10000 > data/KNHET_MDM_DECA_final.txt

data/KNHET_RPI_heteroA_quick.txt: experiments KNHET.cpp problems/RPI_heteroA.dat
	./experiments KNHET problems/RPI_heteroA.dat 500 > data/KNHET_RPI_heteroA_quick.txt

data/KNHET_RPI_heteroA_final.txt: experiments KNHET.cpp problems/RPI_heteroA.dat
	./experiments KNHET problems/RPI_heteroA.dat 10000 > data/KNHET_RPI_heteroA_final.txt

data/BIZUNK_SC_quick.txt: experiments BIZUNK.cpp problems/SC.dat
	./experiments BIZUNK problems/SC.dat 500 > data/BIZUNK_SC_quick.txt

data/BIZUNK_SC_final.txt: experiments BIZUNK.cpp problems/SC.dat
	./experiments BIZUNK problems/SC.dat 10000 > data/BIZUNK_SC_final.txt

data/BIZUNK_MDM_quick.txt: experiments BIZUNK.cpp problems/MDM.dat
	./experiments BIZUNK problems/MDM.dat 500 > data/BIZUNK_MDM_quick.txt

data/BIZUNK_MDM_final.txt: experiments BIZUNK.cpp problems/MDM.dat
	./experiments BIZUNK problems/MDM.dat 10000 > data/BIZUNK_MDM_final.txt

data/BIZUNK_RPI_quick.txt: experiments BIZUNK.cpp problems/RPI.dat
	./experiments BIZUNK problems/RPI.dat 500 > data/BIZUNK_RPI_quick.txt

data/BIZUNK_RPI_final.txt: experiments BIZUNK.cpp problems/RPI.dat
	./experiments BIZUNK problems/RPI.dat 10000 > data/BIZUNK_RPI_final.txt

data/BIZUNK_SC_INC_quick.txt: experiments BIZUNK.cpp problems/SC_INC.dat
	./experiments BIZUNK problems/SC_INC.dat 500 > data/BIZUNK_SC_INC_quick.txt

data/BIZUNK_SC_INC_final.txt: experiments BIZUNK.cpp problems/SC_INC.dat
	./experiments BIZUNK problems/SC_INC.dat 10000 > data/BIZUNK_SC_INC_final.txt

data/BIZUNK_SC_DEC_quick.txt: experiments BIZUNK.cpp problems/SC_DEC.dat
	./experiments BIZUNK problems/SC_DEC.dat 500 > data/BIZUNK_SC_DEC_quick.txt

data/BIZUNK_SC_DEC_final.txt: experiments BIZUNK.cpp problems/SC_DEC.dat
	./experiments BIZUNK problems/SC_DEC.dat 10000 > data/BIZUNK_SC_DEC_final.txt

data/BIZUNK_MDM_INC_quick.txt: experiments BIZUNK.cpp problems/MDM_INC.dat
	./experiments BIZUNK problems/MDM_INC.dat 500 > data/BIZUNK_MDM_INC_quick.txt

data/BIZUNK_MDM_INC_final.txt: experiments BIZUNK.cpp problems/MDM_INC.dat
	./experiments BIZUNK problems/MDM_INC.dat 10000 > data/BIZUNK_MDM_INC_final.txt

data/BIZUNK_MDM_DEC_quick.txt: experiments BIZUNK.cpp problems/MDM_DEC.dat
	./experiments BIZUNK problems/MDM_DEC.dat 500 > data/BIZUNK_MDM_DEC_quick.txt

data/BIZUNK_MDM_DEC_final.txt: experiments BIZUNK.cpp problems/MDM_DEC.dat
	./experiments BIZUNK problems/MDM_DEC.dat 10000 > data/BIZUNK_MDM_DEC_final.txt

data/BIZUNK_RPI_hetero_quick.txt: experiments BIZUNK.cpp problems/RPI_hetero.dat
	./experiments BIZUNK problems/RPI_hetero.dat 500 > data/BIZUNK_RPI_hetero_quick.txt

data/BIZUNK_RPI_hetero_final.txt: experiments BIZUNK.cpp problems/RPI_hetero.dat
	./experiments BIZUNK problems/RPI_hetero.dat 10000 > data/BIZUNK_RPI_hetero_final.txt

data/BIZUNK_SC_INCA_quick.txt: experiments BIZUNK.cpp problems/SC_INCA.dat
	./experiments BIZUNK problems/SC_INCA.dat 500 > data/BIZUNK_SC_INCA_quick.txt

data/BIZUNK_SC_INCA_final.txt: experiments BIZUNK.cpp problems/SC_INCA.dat
	./experiments BIZUNK problems/SC_INCA.dat 10000 > data/BIZUNK_SC_INCA_final.txt

data/BIZUNK_SC_DECA_quick.txt: experiments BIZUNK.cpp problems/SC_DECA.dat
	./experiments BIZUNK problems/SC_DECA.dat 500 > data/BIZUNK_SC_DECA_quick.txt

data/BIZUNK_SC_DECA_final.txt: experiments BIZUNK.cpp problems/SC_DECA.dat
	./experiments BIZUNK problems/SC_DECA.dat 10000 > data/BIZUNK_SC_DECA_final.txt

data/BIZUNK_MDM_INCA_quick.txt: experiments BIZUNK.cpp problems/MDM_INCA.dat
	./experiments BIZUNK problems/MDM_INCA.dat 500 > data/BIZUNK_MDM_INCA_quick.txt

data/BIZUNK_MDM_INCA_final.txt: experiments BIZUNK.cpp problems/MDM_INCA.dat
	./experiments BIZUNK problems/MDM_INCA.dat 10000 > data/BIZUNK_MDM_INCA_final.txt

data/BIZUNK_MDM_DECA_quick.txt: experiments BIZUNK.cpp problems/MDM_DECA.dat
	./experiments BIZUNK problems/MDM_DECA.dat 500 > data/BIZUNK_MDM_DECA_quick.txt

data/BIZUNK_MDM_DECA_final.txt: experiments BIZUNK.cpp problems/MDM_DECA.dat
	./experiments BIZUNK problems/MDM_DECA.dat 10000 > data/BIZUNK_MDM_DECA_final.txt

data/BIZUNK_RPI_heteroA_quick.txt: experiments BIZUNK.cpp problems/RPI_heteroA.dat
	./experiments BIZUNK problems/RPI_heteroA.dat 500 > data/BIZUNK_RPI_heteroA_quick.txt

data/BIZUNK_RPI_heteroA_final.txt: experiments BIZUNK.cpp problems/RPI_heteroA.dat
	./experiments BIZUNK problems/RPI_heteroA.dat 10000 > data/BIZUNK_RPI_heteroA_final.txt

data/KNUNK_SC_quick.txt: experiments KNUNK.cpp problems/SC.dat
	./experiments KNUNK problems/SC.dat 500 > data/KNUNK_SC_quick.txt

data/KNUNK_SC_final.txt: experiments KNUNK.cpp problems/SC.dat
	./experiments KNUNK problems/SC.dat 10000 > data/KNUNK_SC_final.txt

data/KNUNK_MDM_quick.txt: experiments KNUNK.cpp problems/MDM.dat
	./experiments KNUNK problems/MDM.dat 500 > data/KNUNK_MDM_quick.txt

data/KNUNK_MDM_final.txt: experiments KNUNK.cpp problems/MDM.dat
	./experiments KNUNK problems/MDM.dat 10000 > data/KNUNK_MDM_final.txt

data/KNUNK_RPI_quick.txt: experiments KNUNK.cpp problems/RPI.dat
	./experiments KNUNK problems/RPI.dat 500 > data/KNUNK_RPI_quick.txt

data/KNUNK_RPI_final.txt: experiments KNUNK.cpp problems/RPI.dat
	./experiments KNUNK problems/RPI.dat 10000 > data/KNUNK_RPI_final.txt

data/KNUNK_SC_INC_quick.txt: experiments KNUNK.cpp problems/SC_INC.dat
	./experiments KNUNK problems/SC_INC.dat 500 > data/KNUNK_SC_INC_quick.txt

data/KNUNK_SC_INC_final.txt: experiments KNUNK.cpp problems/SC_INC.dat
	./experiments KNUNK problems/SC_INC.dat 10000 > data/KNUNK_SC_INC_final.txt

data/KNUNK_SC_DEC_quick.txt: experiments KNUNK.cpp problems/SC_DEC.dat
	./experiments KNUNK problems/SC_DEC.dat 500 > data/KNUNK_SC_DEC_quick.txt

data/KNUNK_SC_DEC_final.txt: experiments KNUNK.cpp problems/SC_DEC.dat
	./experiments KNUNK problems/SC_DEC.dat 10000 > data/KNUNK_SC_DEC_final.txt

data/KNUNK_MDM_INC_quick.txt: experiments KNUNK.cpp problems/MDM_INC.dat
	./experiments KNUNK problems/MDM_INC.dat 500 > data/KNUNK_MDM_INC_quick.txt

data/KNUNK_MDM_INC_final.txt: experiments KNUNK.cpp problems/MDM_INC.dat
	./experiments KNUNK problems/MDM_INC.dat 10000 > data/KNUNK_MDM_INC_final.txt

data/KNUNK_MDM_DEC_quick.txt: experiments KNUNK.cpp problems/MDM_DEC.dat
	./experiments KNUNK problems/MDM_DEC.dat 500 > data/KNUNK_MDM_DEC_quick.txt

data/KNUNK_MDM_DEC_final.txt: experiments KNUNK.cpp problems/MDM_DEC.dat
	./experiments KNUNK problems/MDM_DEC.dat 10000 > data/KNUNK_MDM_DEC_final.txt

data/KNUNK_RPI_hetero_quick.txt: experiments KNUNK.cpp problems/RPI_hetero.dat
	./experiments KNUNK problems/RPI_hetero.dat 500 > data/KNUNK_RPI_hetero_quick.txt

data/KNUNK_RPI_hetero_final.txt: experiments KNUNK.cpp problems/RPI_hetero.dat
	./experiments KNUNK problems/RPI_hetero.dat 10000 > data/KNUNK_RPI_hetero_final.txt

data/KNUNK_SC_INCA_quick.txt: experiments KNUNK.cpp problems/SC_INCA.dat
	./experiments KNUNK problems/SC_INCA.dat 500 > data/KNUNK_SC_INCA_quick.txt

data/KNUNK_SC_INCA_final.txt: experiments KNUNK.cpp problems/SC_INCA.dat
	./experiments KNUNK problems/SC_INCA.dat 10000 > data/KNUNK_SC_INCA_final.txt

data/KNUNK_SC_DECA_quick.txt: experiments KNUNK.cpp problems/SC_DECA.dat
	./experiments KNUNK problems/SC_DECA.dat 500 > data/KNUNK_SC_DECA_quick.txt

data/KNUNK_SC_DECA_final.txt: experiments KNUNK.cpp problems/SC_DECA.dat
	./experiments KNUNK problems/SC_DECA.dat 10000 > data/KNUNK_SC_DECA_final.txt

data/KNUNK_MDM_INCA_quick.txt: experiments KNUNK.cpp problems/MDM_INCA.dat
	./experiments KNUNK problems/MDM_INCA.dat 500 > data/KNUNK_MDM_INCA_quick.txt

data/KNUNK_MDM_INCA_final.txt: experiments KNUNK.cpp problems/MDM_INCA.dat
	./experiments KNUNK problems/MDM_INCA.dat 10000 > data/KNUNK_MDM_INCA_final.txt

data/KNUNK_MDM_DECA_quick.txt: experiments KNUNK.cpp problems/MDM_DECA.dat
	./experiments KNUNK problems/MDM_DECA.dat 500 > data/KNUNK_MDM_DECA_quick.txt

data/KNUNK_MDM_DECA_final.txt: experiments KNUNK.cpp problems/MDM_DECA.dat
	./experiments KNUNK problems/MDM_DECA.dat 10000 > data/KNUNK_MDM_DECA_final.txt

data/KNUNK_RPI_heteroA_quick.txt: experiments KNUNK.cpp problems/RPI_heteroA.dat
	./experiments KNUNK problems/RPI_heteroA.dat 500 > data/KNUNK_RPI_heteroA_quick.txt

data/KNUNK_RPI_heteroA_final.txt: experiments KNUNK.cpp problems/RPI_heteroA.dat
	./experiments KNUNK problems/RPI_heteroA.dat 10000 > data/KNUNK_RPI_heteroA_final.txt

data/BIZ_PGS3_quick.txt: experiments BIZ.cpp problems/PGS3.dat
	./experiments BIZ problems/PGS3.dat 500 > data/BIZ_PGS3_quick.txt

data/BIZ_PGS3_final.txt: experiments BIZ.cpp problems/PGS3.dat
	./experiments BIZ problems/PGS3.dat 10000 > data/BIZ_PGS3_final.txt

data/BIZ_PGS10_quick.txt: experiments BIZ.cpp problems/PGS10.dat
	./experiments BIZ problems/PGS10.dat 500 > data/BIZ_PGS10_quick.txt

data/BIZ_PGS10_final.txt: experiments BIZ.cpp problems/PGS10.dat
	./experiments BIZ problems/PGS10.dat 10000 > data/BIZ_PGS10_final.txt

data/BIZ_PGS100_quick.txt: experiments BIZ.cpp problems/PGS100.dat
	./experiments BIZ problems/PGS100.dat 500 > data/BIZ_PGS100_quick.txt

data/BIZ_PGS100_final.txt: experiments BIZ.cpp problems/PGS100.dat
	./experiments BIZ problems/PGS100.dat 10000 > data/BIZ_PGS100_final.txt

data/BIZ_PGS32_quick.txt: experiments BIZ.cpp problems/PGS32.dat
	./experiments BIZ problems/PGS32.dat 500 > data/BIZ_PGS32_quick.txt

data/BIZ_PGS32_final.txt: experiments BIZ.cpp problems/PGS32.dat
	./experiments BIZ problems/PGS32.dat 10000 > data/BIZ_PGS32_final.txt

data/BIZ_RPI_PGS_quick.txt: experiments BIZ.cpp problems/RPI_PGS.dat
	./experiments BIZ problems/RPI_PGS.dat 500 > data/BIZ_RPI_PGS_quick.txt

data/BIZ_RPI_PGS_final.txt: experiments BIZ.cpp problems/RPI_PGS.dat
	./experiments BIZ problems/RPI_PGS.dat 10000 > data/BIZ_RPI_PGS_final.txt

homo_quick: data/BIZ_SC_quick.txt data/BIZ_MDM_quick.txt data/BIZ_RPI_quick.txt data/KN_SC_quick.txt data/KN_MDM_quick.txt data/KN_RPI_quick.txt data/BKS_SC_quick.txt data/BKS_MDM_quick.txt data/BKS_RPI_quick.txt data/Paulson_SC_quick.txt data/Paulson_MDM_quick.txt data/Paulson_RPI_quick.txt

homo_final: data/BIZ_SC_final.txt data/BIZ_MDM_final.txt data/BIZ_RPI_final.txt data/KN_SC_final.txt data/KN_MDM_final.txt data/KN_RPI_final.txt data/BKS_SC_final.txt data/BKS_MDM_final.txt data/BKS_RPI_final.txt data/Paulson_SC_final.txt data/Paulson_MDM_final.txt data/Paulson_RPI_final.txt

hetero_quick: data/BIZHET_SC_INC_quick.txt data/BIZHET_SC_DEC_quick.txt data/BIZHET_MDM_INC_quick.txt data/BIZHET_MDM_DEC_quick.txt data/BIZHET_RPI_hetero_quick.txt data/BIZHET_SC_INCA_quick.txt data/BIZHET_SC_DECA_quick.txt data/BIZHET_MDM_INCA_quick.txt data/BIZHET_MDM_DECA_quick.txt data/BIZHET_RPI_heteroA_quick.txt data/KNHET_SC_INC_quick.txt data/KNHET_SC_DEC_quick.txt data/KNHET_MDM_INC_quick.txt data/KNHET_MDM_DEC_quick.txt data/KNHET_RPI_hetero_quick.txt data/KNHET_SC_INCA_quick.txt data/KNHET_SC_DECA_quick.txt data/KNHET_MDM_INCA_quick.txt data/KNHET_MDM_DECA_quick.txt data/KNHET_RPI_heteroA_quick.txt

hetero_final: data/BIZHET_SC_INC_final.txt data/BIZHET_SC_DEC_final.txt data/BIZHET_MDM_INC_final.txt data/BIZHET_MDM_DEC_final.txt data/BIZHET_RPI_hetero_final.txt data/BIZHET_SC_INCA_final.txt data/BIZHET_SC_DECA_final.txt data/BIZHET_MDM_INCA_final.txt data/BIZHET_MDM_DECA_final.txt data/BIZHET_RPI_heteroA_final.txt data/KNHET_SC_INC_final.txt data/KNHET_SC_DEC_final.txt data/KNHET_MDM_INC_final.txt data/KNHET_MDM_DEC_final.txt data/KNHET_RPI_hetero_final.txt data/KNHET_SC_INCA_final.txt data/KNHET_SC_DECA_final.txt data/KNHET_MDM_INCA_final.txt data/KNHET_MDM_DECA_final.txt data/KNHET_RPI_heteroA_final.txt

unk_quick: data/BIZUNK_SC_quick.txt data/BIZUNK_MDM_quick.txt data/BIZUNK_RPI_quick.txt data/BIZUNK_SC_INC_quick.txt data/BIZUNK_SC_DEC_quick.txt data/BIZUNK_MDM_INC_quick.txt data/BIZUNK_MDM_DEC_quick.txt data/BIZUNK_RPI_hetero_quick.txt data/BIZUNK_SC_INCA_quick.txt data/BIZUNK_SC_DECA_quick.txt data/BIZUNK_MDM_INCA_quick.txt data/BIZUNK_MDM_DECA_quick.txt data/BIZUNK_RPI_heteroA_quick.txt data/KNUNK_SC_quick.txt data/KNUNK_MDM_quick.txt data/KNUNK_RPI_quick.txt data/KNUNK_SC_INC_quick.txt data/KNUNK_SC_DEC_quick.txt data/KNUNK_MDM_INC_quick.txt data/KNUNK_MDM_DEC_quick.txt data/KNUNK_RPI_hetero_quick.txt data/KNUNK_SC_INCA_quick.txt data/KNUNK_SC_DECA_quick.txt data/KNUNK_MDM_INCA_quick.txt data/KNUNK_MDM_DECA_quick.txt data/KNUNK_RPI_heteroA_quick.txt

unk_final: data/BIZUNK_SC_final.txt data/BIZUNK_MDM_final.txt data/BIZUNK_RPI_final.txt data/BIZUNK_SC_INC_final.txt data/BIZUNK_SC_DEC_final.txt data/BIZUNK_MDM_INC_final.txt data/BIZUNK_MDM_DEC_final.txt data/BIZUNK_RPI_hetero_final.txt data/BIZUNK_SC_INCA_final.txt data/BIZUNK_SC_DECA_final.txt data/BIZUNK_MDM_INCA_final.txt data/BIZUNK_MDM_DECA_final.txt data/BIZUNK_RPI_heteroA_final.txt data/KNUNK_SC_final.txt data/KNUNK_MDM_final.txt data/KNUNK_RPI_final.txt data/KNUNK_SC_INC_final.txt data/KNUNK_SC_DEC_final.txt data/KNUNK_MDM_INC_final.txt data/KNUNK_MDM_DEC_final.txt data/KNUNK_RPI_hetero_final.txt data/KNUNK_SC_INCA_final.txt data/KNUNK_SC_DECA_final.txt data/KNUNK_MDM_INCA_final.txt data/KNUNK_MDM_DECA_final.txt data/KNUNK_RPI_heteroA_final.txt

SC_quick: data/BIZ_SC_quick.txt data/KN_SC_quick.txt data/BKS_SC_quick.txt data/Paulson_SC_quick.txt data/BIZUNK_SC_quick.txt data/KNUNK_SC_quick.txt

MDM_quick: data/BIZ_MDM_quick.txt data/KN_MDM_quick.txt data/BKS_MDM_quick.txt data/Paulson_MDM_quick.txt data/BIZUNK_MDM_quick.txt data/KNUNK_MDM_quick.txt

RPI_quick: data/BIZ_RPI_quick.txt data/KN_RPI_quick.txt data/BKS_RPI_quick.txt data/Paulson_RPI_quick.txt data/BIZUNK_RPI_quick.txt data/KNUNK_RPI_quick.txt

SC_INC_quick: data/BIZHET_SC_INC_quick.txt data/KNHET_SC_INC_quick.txt data/BIZUNK_SC_INC_quick.txt data/KNUNK_SC_INC_quick.txt

SC_DEC_quick: data/BIZHET_SC_DEC_quick.txt data/KNHET_SC_DEC_quick.txt data/BIZUNK_SC_DEC_quick.txt data/KNUNK_SC_DEC_quick.txt

MDM_INC_quick: data/BIZHET_MDM_INC_quick.txt data/KNHET_MDM_INC_quick.txt data/BIZUNK_MDM_INC_quick.txt data/KNUNK_MDM_INC_quick.txt

MDM_DEC_quick: data/BIZHET_MDM_DEC_quick.txt data/KNHET_MDM_DEC_quick.txt data/BIZUNK_MDM_DEC_quick.txt data/KNUNK_MDM_DEC_quick.txt

RPI_hetero_quick: data/BIZHET_RPI_hetero_quick.txt data/KNHET_RPI_hetero_quick.txt data/BIZUNK_RPI_hetero_quick.txt data/KNUNK_RPI_hetero_quick.txt

SC_INCA_quick: data/BIZHET_SC_INCA_quick.txt data/KNHET_SC_INCA_quick.txt data/BIZUNK_SC_INCA_quick.txt data/KNUNK_SC_INCA_quick.txt

SC_DECA_quick: data/BIZHET_SC_DECA_quick.txt data/KNHET_SC_DECA_quick.txt data/BIZUNK_SC_DECA_quick.txt data/KNUNK_SC_DECA_quick.txt

MDM_INCA_quick: data/BIZHET_MDM_INCA_quick.txt data/KNHET_MDM_INCA_quick.txt data/BIZUNK_MDM_INCA_quick.txt data/KNUNK_MDM_INCA_quick.txt

MDM_DECA_quick: data/BIZHET_MDM_DECA_quick.txt data/KNHET_MDM_DECA_quick.txt data/BIZUNK_MDM_DECA_quick.txt data/KNUNK_MDM_DECA_quick.txt

RPI_heteroA_quick: data/BIZHET_RPI_heteroA_quick.txt data/KNHET_RPI_heteroA_quick.txt data/BIZUNK_RPI_heteroA_quick.txt data/KNUNK_RPI_heteroA_quick.txt

BIZ_quick: data/BIZ_SC_quick.txt data/BIZ_MDM_quick.txt data/BIZ_RPI_quick.txt

KN_quick: data/KN_SC_quick.txt data/KN_MDM_quick.txt data/KN_RPI_quick.txt

BKS_quick: data/BKS_SC_quick.txt data/BKS_MDM_quick.txt data/BKS_RPI_quick.txt

Paulson_quick: data/Paulson_SC_quick.txt data/Paulson_MDM_quick.txt data/Paulson_RPI_quick.txt

BIZHET_quick: data/BIZHET_SC_INC_quick.txt data/BIZHET_SC_DEC_quick.txt data/BIZHET_MDM_INC_quick.txt data/BIZHET_MDM_DEC_quick.txt data/BIZHET_RPI_hetero_quick.txt data/BIZHET_SC_INCA_quick.txt data/BIZHET_SC_DECA_quick.txt data/BIZHET_MDM_INCA_quick.txt data/BIZHET_MDM_DECA_quick.txt data/BIZHET_RPI_heteroA_quick.txt

KNHET_quick: data/KNHET_SC_INC_quick.txt data/KNHET_SC_DEC_quick.txt data/KNHET_MDM_INC_quick.txt data/KNHET_MDM_DEC_quick.txt data/KNHET_RPI_hetero_quick.txt data/KNHET_SC_INCA_quick.txt data/KNHET_SC_DECA_quick.txt data/KNHET_MDM_INCA_quick.txt data/KNHET_MDM_DECA_quick.txt data/KNHET_RPI_heteroA_quick.txt

BIZUNK_quick: data/BIZUNK_SC_quick.txt data/BIZUNK_MDM_quick.txt data/BIZUNK_RPI_quick.txt data/BIZUNK_SC_INC_quick.txt data/BIZUNK_SC_DEC_quick.txt data/BIZUNK_MDM_INC_quick.txt data/BIZUNK_MDM_DEC_quick.txt data/BIZUNK_RPI_hetero_quick.txt data/BIZUNK_SC_INCA_quick.txt data/BIZUNK_SC_DECA_quick.txt data/BIZUNK_MDM_INCA_quick.txt data/BIZUNK_MDM_DECA_quick.txt data/BIZUNK_RPI_heteroA_quick.txt

KNUNK_quick: data/KNUNK_SC_quick.txt data/KNUNK_MDM_quick.txt data/KNUNK_RPI_quick.txt data/KNUNK_SC_INC_quick.txt data/KNUNK_SC_DEC_quick.txt data/KNUNK_MDM_INC_quick.txt data/KNUNK_MDM_DEC_quick.txt data/KNUNK_RPI_hetero_quick.txt data/KNUNK_SC_INCA_quick.txt data/KNUNK_SC_DECA_quick.txt data/KNUNK_MDM_INCA_quick.txt data/KNUNK_MDM_DECA_quick.txt data/KNUNK_RPI_heteroA_quick.txt

SC_final: data/BIZ_SC_final.txt data/KN_SC_final.txt data/BKS_SC_final.txt data/Paulson_SC_final.txt data/BIZUNK_SC_final.txt data/KNUNK_SC_final.txt

MDM_final: data/BIZ_MDM_final.txt data/KN_MDM_final.txt data/BKS_MDM_final.txt data/Paulson_MDM_final.txt data/BIZUNK_MDM_final.txt data/KNUNK_MDM_final.txt

RPI_final: data/BIZ_RPI_final.txt data/KN_RPI_final.txt data/BKS_RPI_final.txt data/Paulson_RPI_final.txt data/BIZUNK_RPI_final.txt data/KNUNK_RPI_final.txt

SC_INC_final: data/BIZHET_SC_INC_final.txt data/KNHET_SC_INC_final.txt data/BIZUNK_SC_INC_final.txt data/KNUNK_SC_INC_final.txt

SC_DEC_final: data/BIZHET_SC_DEC_final.txt data/KNHET_SC_DEC_final.txt data/BIZUNK_SC_DEC_final.txt data/KNUNK_SC_DEC_final.txt

MDM_INC_final: data/BIZHET_MDM_INC_final.txt data/KNHET_MDM_INC_final.txt data/BIZUNK_MDM_INC_final.txt data/KNUNK_MDM_INC_final.txt

MDM_DEC_final: data/BIZHET_MDM_DEC_final.txt data/KNHET_MDM_DEC_final.txt data/BIZUNK_MDM_DEC_final.txt data/KNUNK_MDM_DEC_final.txt

RPI_hetero_final: data/BIZHET_RPI_hetero_final.txt data/KNHET_RPI_hetero_final.txt data/BIZUNK_RPI_hetero_final.txt data/KNUNK_RPI_hetero_final.txt

SC_INCA_final: data/BIZHET_SC_INCA_final.txt data/KNHET_SC_INCA_final.txt data/BIZUNK_SC_INCA_final.txt data/KNUNK_SC_INCA_final.txt

SC_DECA_final: data/BIZHET_SC_DECA_final.txt data/KNHET_SC_DECA_final.txt data/BIZUNK_SC_DECA_final.txt data/KNUNK_SC_DECA_final.txt

MDM_INCA_final: data/BIZHET_MDM_INCA_final.txt data/KNHET_MDM_INCA_final.txt data/BIZUNK_MDM_INCA_final.txt data/KNUNK_MDM_INCA_final.txt

MDM_DECA_final: data/BIZHET_MDM_DECA_final.txt data/KNHET_MDM_DECA_final.txt data/BIZUNK_MDM_DECA_final.txt data/KNUNK_MDM_DECA_final.txt

RPI_heteroA_final: data/BIZHET_RPI_heteroA_final.txt data/KNHET_RPI_heteroA_final.txt data/BIZUNK_RPI_heteroA_final.txt data/KNUNK_RPI_heteroA_final.txt

BIZ_final: data/BIZ_SC_final.txt data/BIZ_MDM_final.txt data/BIZ_RPI_final.txt

KN_final: data/KN_SC_final.txt data/KN_MDM_final.txt data/KN_RPI_final.txt

BKS_final: data/BKS_SC_final.txt data/BKS_MDM_final.txt data/BKS_RPI_final.txt

Paulson_final: data/Paulson_SC_final.txt data/Paulson_MDM_final.txt data/Paulson_RPI_final.txt

BIZHET_final: data/BIZHET_SC_INC_final.txt data/BIZHET_SC_DEC_final.txt data/BIZHET_MDM_INC_final.txt data/BIZHET_MDM_DEC_final.txt data/BIZHET_RPI_hetero_final.txt data/BIZHET_SC_INCA_final.txt data/BIZHET_SC_DECA_final.txt data/BIZHET_MDM_INCA_final.txt data/BIZHET_MDM_DECA_final.txt data/BIZHET_RPI_heteroA_final.txt

KNHET_final: data/KNHET_SC_INC_final.txt data/KNHET_SC_DEC_final.txt data/KNHET_MDM_INC_final.txt data/KNHET_MDM_DEC_final.txt data/KNHET_RPI_hetero_final.txt data/KNHET_SC_INCA_final.txt data/KNHET_SC_DECA_final.txt data/KNHET_MDM_INCA_final.txt data/KNHET_MDM_DECA_final.txt data/KNHET_RPI_heteroA_final.txt

BIZUNK_final: data/BIZUNK_SC_final.txt data/BIZUNK_MDM_final.txt data/BIZUNK_RPI_final.txt data/BIZUNK_SC_INC_final.txt data/BIZUNK_SC_DEC_final.txt data/BIZUNK_MDM_INC_final.txt data/BIZUNK_MDM_DEC_final.txt data/BIZUNK_RPI_hetero_final.txt data/BIZUNK_SC_INCA_final.txt data/BIZUNK_SC_DECA_final.txt data/BIZUNK_MDM_INCA_final.txt data/BIZUNK_MDM_DECA_final.txt data/BIZUNK_RPI_heteroA_final.txt

KNUNK_final: data/KNUNK_SC_final.txt data/KNUNK_MDM_final.txt data/KNUNK_RPI_final.txt data/KNUNK_SC_INC_final.txt data/KNUNK_SC_DEC_final.txt data/KNUNK_MDM_INC_final.txt data/KNUNK_MDM_DEC_final.txt data/KNUNK_RPI_hetero_final.txt data/KNUNK_SC_INCA_final.txt data/KNUNK_SC_DECA_final.txt data/KNUNK_MDM_INCA_final.txt data/KNUNK_MDM_DECA_final.txt data/KNUNK_RPI_heteroA_final.txt

