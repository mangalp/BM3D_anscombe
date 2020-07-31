#!/bin/sh

#SBATCH --job-name=dndJob
#SBATCH --time 0-24:00:000
#SBATCH --mem-per-cpu 256000
#SBATCH -o dndJob.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../../../../DnD/script_train_DnD.py --dataPath=./ --name="DnD" --virtualBatchSize=64 --batchSize=1 --learningRate=0.0001 --stdPSF=1.2 --cropSize=256 --cropsPerImage=16

