#!/bin/bash
#SBATCH --job-name=genopred
#SBATCH --open-mode=truncate
#SBATCH --output=/ess/p697/data/durable/users/espehage/GenoPredProtocols/MoBa/logs/genopred.txt
#SBATCH --error=/ess/p697/data/durable/users/espehage/GenoPredProtocols/MoBa/logs/genopred.txt
#SBATCH --account=p697
#SBATCH --time=48:00:00
###SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --mem-per-cpu=3500M
#SBATCH --partition=normal

module purge
# export GENOPRED=/ess/p697/data/durable/s3-api/espehage-nird/GenoPred  # TSD, s3-api synced dir. NOTE: Has wrong permissions for some files
export VERSION="v2.2.11"
export GENOPRED=/ess/p697/data/durable/users/espehage/GenoPred  # local copy of s3-api synced dir (crashes from other dir due to wrong file permissions)
export APPTAINERENV_GENOPRED=$GENOPRED
export GSH="apptainer exec --bind $GENOPRED:$GENOPRED,/ess:/ess --writable-tmpfs \
    $GENOPRED/genopred_pipeline_$VERSION.sif bash ./entrypoint.sh"

# fix permissions (once) - pipeline assumes executable which aint preserved by s3-api transfer:
# chmod +x $GENOPRED/pipeline/resources/software/ldsc/munge_sumstats.py
# chmod +x $GENOPRED/pipeline/resources/software/ldsc/ldsc.py
# chmod +x $GENOPRED/pipeline/resources/software/dbslmm/software/dbslmm
# chmod +x $GENOPRED/pipeline/resources/software/plink/plink
# chmod +x $GENOPRED/pipeline/resources/software/gctb/gctb_2.03beta_Linux/gctb
# chmod +x $GENOPRED/pipeline/resources/software/prscs/PRScs.py
# chmod +x $GENOPRED/pipeline/resources/software/ldak/ldak5.1.linux

# Working/config dir 
cd /ess/p697/data/durable/users/espehage/GenoPredProtocols/MoBa

# run container with options for snakemake
# dry run (for testing)
# $GSH -n --use-conda --configfile=$PWD/config.yaml output_all
# $GSH -n --use-conda --configfile=$PWD/config.yaml indiv_report

# production run
# $GSH -j 16 --use-conda --configfile=$PWD/config.yaml output_all
$GSH --cores all --use-conda --configfile=$PWD/config.yaml indiv_report
