#!/usr/bin/env bash
#
# 2022 Herman Fung, Mahamid Lab, EMBL Heidelberg
#
#SBATCH -w name-of-your-cluster
#SBATCH -J AreTomo
#SBATCH -t 3:00:00
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH -o logs/run_%A_%a.out
#SBATCH -e logs/run_%A_%a.err


module purge

# Retrieve path to tilt series
TSNAME_LIST=($(<$INPUTLIST))
TSNAME=${TSNAME_LIST[${SLURM_ARRAY_TASK_ID}]}

# Perform reconstruction
/path-to-aretomo-binary/AreTomo_1.3.1_11102022/AreTomo_1.3.1_Cuda101_11102022 \
    -AngFile ${TSNAME}.rawtlt \
    -InMrc ${TSNAME}.st \
    -OutMrc ${TSNAME}_aretomo.mrc \
    -VolZ $ZTHICKNESS \
    -AlignZ 1800 \
    -DarkTol 0.01 \
    -OutBin $BINFACTOR \
    -TiltAxis $TILTANG -1 \
    -TiltCor -1 \
    -Patch $PATCHX $PATCHY \
    -Wbp 1 \
    -FlipVol 1 \
    -OutImod 1 \
    -IntpCor 0

# Write pixel size into header
module purge
module -s load imod/4.12.9
source /path-to-imod-installation/IMOD/4.12.9/IMOD-linux.sh 
alterheader ${TSNAME}_aretomo.mrc -PixelSize $OUTPXSIZE,$OUTPXSIZE,$OUTPXSIZE -SpaceGroup 1

# Move xf and aln solutions into imod tilt series directory
mv $(dirname $(dirname $TSNAME))/$(basename $TSNAME .mrc)_Imod/$(basename $TSNAME .mrc).xf ${TSNAME}.xf
mv $(dirname $(dirname $TSNAME))/$(basename $TSNAME .mrc).aln ${TSNAME}.aln
rm -r $(dirname $(dirname $TSNAME))/$(basename $TSNAME .mrc)_Imod
