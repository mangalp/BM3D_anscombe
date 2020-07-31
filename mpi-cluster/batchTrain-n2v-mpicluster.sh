#!/bin/sh

#SBATCH --job-name=n2vJob
#SBATCH --time 0-24:00:000
#SBATCH --mem-per-cpu 256000
#SBATCH -o n2vJob.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../../../../DnD/script_train_dnd.py --dataPath=./ --name="n2v" --virtualBatchSize=64 --batchSize=1 --learningRate=0.0001 --stdPSF=0 --cropSize=256 --cropsPerImage=16

