#!/bin/sh

#SBATCH --job-name=n2vSimCare-o0
#SBATCH --time 0-12:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-o0.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../n2v/scripts/trainN2V.py --dataPath='./orientations/o0/' --fileName='*.tif' --dims=TYX --validationFraction=2 --batchSize=128 --stepsPerEpoch=400  --name='n2v-simcare-o0' --patchSizeXY=120 --noAugment --n2vPercPix=0.198 --netDepth=3 --num_patches=200
