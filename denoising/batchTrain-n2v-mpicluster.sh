#!/bin/sh

#SBATCH --job-name=n2vSimSim-o0
#SBATCH --time 0-01:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-o0.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 trainN2V.py --dataPath='./' --fileName='*.tif' --dims=TYX --validationFraction=2 --batchSize=8 --stepsPerEpoch=400  --name='n2v-simsim-o0' --patchSizeXY=128
