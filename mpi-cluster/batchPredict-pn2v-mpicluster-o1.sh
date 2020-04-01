#!/bin/sh

#SBATCH --job-name=pn2vSimSim-o1
#SBATCH --time 0-00:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o PN2VJob-predict-o1.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../ppn2v/scripts/predictPN2V.py --dataPath='./orientations/o1/' --fileName='*.tif' --name="o1" --output='./results/o1/' --noiseModel=./GMMNoiseModel_None_3_2.npz --tileSize=128
