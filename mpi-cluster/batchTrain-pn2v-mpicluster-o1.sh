#!/bin/sh

#SBATCH --job-name=pn2vSimCare-o1
#SBATCH --time 0-24:00:000
#SBATCH --mem-per-cpu 256000
#SBATCH -o PN2VJob-o1.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../ppn2v/scripts/trainPN2V.py --dataPath=./orientations/o1/ --noiseModel=./GMMNoiseModel_None_3_2.npz --name="o1"  --virtualBatchSize=64 --batchSize=1 --learningRate=0.0001
