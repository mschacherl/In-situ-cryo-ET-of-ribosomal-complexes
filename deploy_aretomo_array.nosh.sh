#!/usr/bin/env bash

# 2022 Herman Fung, Mahamid Lab, EMBL Heidelberg

# Specify IMOD directory, tomogram names and AreTomo parameters
IMODDIR=/your_data/frames/imod
TOMOLIST=( ${IMODDIR}/*/ )  # Slash at the end ensures only directories are listed when asterisk used
#TOMOLIST=( ${IMODDIR}/TS_0{28..32}.mrc )  # Tomogram range, use comma to list individual tomograms
#TOMOLIST=( ${IMODDIR}/TS_032.mrc )  # Single tomogram
TILTANG=83.6   
PATCHX=0
PATCHY=0
ZTHICKNESS=2000
BINFACTOR=8
ORIGPXSIZE=1.378

INPUTLIST=$(pwd)"/input_"$(date +"%Y%m%d%H%M%S")".list"
ls -d "${TOMOLIST[@]}" | awk -F'/' 'BEGIN{OFS="/"} {if($NF == "") {NF--; print $0,$NF} else {print $0,$NF}}' > $INPUTLIST

NUMTOMO=$(sed '/^ *$/ d' $INPUTLIST | wc -l)
OUTPXSIZE=$(echo | awk -v a=$BINFACTOR -v b=$ORIGPXSIZE '{print a*b}')

mkdir -p logs
sbatch --array=0-$(($NUMTOMO-1))%3 --export=INPUTLIST=$INPUTLIST,TILTANG=$TILTANG,PATCHX=$PATCHX,PATCHY=$PATCHY,ZTHICKNESS=$ZTHICKNESS,BINFACTOR=$BINFACTOR,OUTPXSIZE=$OUTPXSIZE /your_data/frames/aretomo/aretomo_array_template.sh
