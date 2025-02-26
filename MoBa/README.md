# GenoPred on MoBa example

This directory contains and example for running the GenoPred pipeline.

- Documentation: <https://opain.github.io/GenoPred/index.html>
- Source: <https://github.com/opain/GenoPred>

This example uses inhouse genotypes from the MoBa sample, using our inhouse cleansumstats processed GWAS
and available phenotypic information from questionnaire

## List of files

Short list of files contained here. For detailed descriptions of the GenoPred specific files, see its documentation linked to above:

- `README.md`: This file
- `extract_moba_targets.ipynb`: Jupyter notebook to extract genotype target genotype files (chr 1-22) on PLINK1 format (.bed/.bim/.fam)
- `config.yaml`: GenoPred configuration file. Modify accordingly, e.g., by choosing as subset of PRS methods, e.g., `ldpred2`, input/output file locations
- `target_list.txt`: GenoPred list of target files. May have multiple rows.
- `gwas_list.txt`: GenoPred list of GWAS summary stats files. May have multiple rows.
- `score_list.txt`: Genopred external scores files. Not used/optional. May have multiple rows
- `run_genopred.sh`: Slurm job script. Modify as needed, submit to queue as `sbatch run_genopred.sh`
- `entrypoint.sh`: instructions for running the pipeline using the GenoPred Singularity image file via the Slurm job script
- `evaluate_moba_w_pheno.ipynb`: Jupyter notebook to load phenotypic information and correlate with calculated PRS values, showing "best" performing model.
- `slurm.yaml`: Slurm configuration file. Not used.
- `input/`: Processed inputs (target files)
- `logs/`: Slurm output log files
- `output/`: GenoPred produced output
