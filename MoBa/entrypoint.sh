#!/bin/bash

# Activate GenoPred environment
source /opt/mambaforge/etc/profile.d/conda.sh
conda activate genopred

# Set working directory
cd /tools/GenoPred/pipeline

# Run Snakemake with all provided parameters
snakemake "$@"
