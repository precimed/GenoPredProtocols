#!/bin/bash
# development script running GenoPred pipelines interactively with test data
module purge
# export GENOPRED=/ess/p697/data/durable/s3-api/espehage-nird/GenoPred  # TSD, s3-api synced dir
export VERSION="v2.2.11"
export GENOPRED=/ess/p697/data/durable/users/espehage/GenoPred  # local copy of s3-api synced dir (crashes from other dir due to wrong file permissions)
export APPTAINERENV_GENOPRED=$GENOPRED
export GSH="apptainer shell --bind $GENOPRED:$GENOPRED --writable-tmpfs --cleanenv $GENOPRED/genopred_pipeline_$VERSION.sif"

# fix permissions - pipeline assumes executable which aint preserved by s3-api transfer
chmod +x $GENOPRED/pipeline/resources/software/ldsc/munge_sumstats.py
chmod +x $GENOPRED/pipeline/resources/software/ldsc/ldsc.py
chmod +x $GENOPRED/pipeline/resources/software/dbslmm/software/dbslmm
chmod +x $GENOPRED/pipeline/resources/software/plink/plink
chmod +x $GENOPRED/pipeline/resources/software/gctb/gctb_2.03beta_Linux/gctb
chmod +x $GENOPRED/pipeline/resources/software/prscs/PRScs.py
chmod +x $GENOPRED/pipeline/resources/software/ldak/ldak5.1.linux

# test dir
cd /ess/p697/data/durable/users/espehage/GenoPredProtocols/
cp -r $GENOPRED/pipeline/test_data .

# start container
$GSH

# Inside the running container
source /opt/mambaforge/etc/profile.d/conda.sh
conda activate genopred

# steps from https://opain.github.io/GenoPred/running_offline.html
cd /tools/GenoPred/pipeline
export WDIR=/ess/p697/data/durable/users/espehage/GenoPredProtocols
ln -s $WDIR/test_data ./test_data
# 1. Remove score files requiring direct access to PGS catalogue
awk -F' ' '$2 != "NA" {print}' example_input/score_list.txt > example_input/score_list_2.txt && mv example_input/score_list_2.txt example_input/score_list.txt
# 2. Update resdir to previously downloaded resources
echo "resdir: ${GENOPRED}/pipeline/resources" >> example_input/config.yaml

# optional, edit example_input/config.yaml file to run another or all PRS methods

# dru run
snakemake -n --use-conda --configfile=example_input/config.yaml output_all

# do run
snakemake -j4 --use-conda --configfile=example_input/config.yaml output_all
