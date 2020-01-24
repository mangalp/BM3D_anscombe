#!/bin/sh

#SBATCH --job-name=n2vSimCare-o2
#SBATCH --time 0-12:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-o2.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../n2v/scripts/trainN2V.py --dataPath='./orientations/o2/' --fileName='*.tif' --dims=TYX --validationFraction=2 --batchSize=8 --stepsPerEpoch=400  --name='n2v-simcare-o2' --patchSizeXY=100 --noAugment
