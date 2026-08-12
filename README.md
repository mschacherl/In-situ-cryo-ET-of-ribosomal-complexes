# In-situ-cryo-ET-of-ribosomal-complexes
This repository contains all necessary scripts and files to perform the published protocol for 'In situ cryo-ET of ribosomal complexes' as book chapter in the second edition of Methods in Molecular Biology 'Multiprotein Complexes', edited by Arnaud Poterszman.

The repository contains:
1. Python script 'mdoc_DateTime.py', to change the date format in MDOC files from a four-digit year (e.g., 03-Mar-2023) to a two-digit year (03-Mar-23) that can be read by Warp/M [1].
2. Python script 'mdoc_ZValue_renumber.py' can be used to reorder the ZValues in MDOC files if metadata of individual tilt images were removed. It generates a backup file first and then renumbers the Z-values from [ZValue = 0] to [ZValue = n] (n = number of final images in respective tilt series).
3. The bash scripts aretomo_array_template.sh and deploy_aretomo_array.sh to operate AreTomo (v1.3) [2] in batch mode.
4. The trained model 'BoxNet2Mask_gold_removal.zip' for fiducial identification and masking, to be used in Warp/M [1].
5. The 3D volume 'ref80S_12Apx.mrc' at the voxel size of 12.24 Å and box sixe of 34 px, to be used for template matching in Warp/M [1].
6. Files for 3D printing of pedestals (formats 3MF and STL) in folder 'Pedestals_3D_print.zip'. They can be read by all 3D printer software. Three designs are provided, one for each well format: 24-well, 12-well and 6-well.

All files are stored as non-executables to prevent problems during download (.nopy/.nosh need to be renamed to .py/.sh after download).

Credit goes to Herman Fung from the Mahamid group at EMBL@Heidelberg, Jana Kroll from MDC Berlin as well as Christoph Diebolder and Thiemo Sprink @ from CFcryoEM@Berlin.

References:
1. Tegunov D, Xue L, Dienemann C, Cramer P and Mahamid J. Nat Methods 18, 186 (2021). 10.1038/s41592-020-01054-7
2. Zheng S et al. J Struct Biol X 6, 100068 (2022). 10.1016/j.yjsbx.2022.100068
