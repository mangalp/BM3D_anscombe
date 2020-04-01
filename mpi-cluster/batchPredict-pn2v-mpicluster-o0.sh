#!/bin/sh

#SBATCH --job-name=pn2vSimSim-o0
#SBATCH --time 0-00:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o PN2VJob-predict-o0.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../ppn2v/scripts/predictPN2V.py --dataPath='./orientations/o0/' --fileName='*.tif' --name="o0" --output='./results/o0/' --noiseModel=./GMMNoiseModel_None_3_2.npz --tileSize=128
