#!/bin/bash

sub=$1

# runs FMRIPREP on input subject
# usage: bash run_fmriprep.sh <sub>

root='/data/projects/rutgers-socreward/data/'
    
singularity run --cleanenv \
-B $root/bids:/data \
-B $root/mriqc:/out \
-B $scratch:/scratch/caleb/ \
/data/tools/mriqc-0.15.1.simg \
/data /out \
participant --participant_label $sub -w /scratch
