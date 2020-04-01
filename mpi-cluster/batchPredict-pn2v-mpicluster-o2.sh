#!/bin/sh

#SBATCH --job-name=pn2vSimSim-o2
#SBATCH --time 0-01:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o PN2VJob-predict-o2.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../ppn2v/scripts/predictPN2V.py --dataPath='./orientations/o2/' --fileName='*.tif' --name="o2" --output='./results/o2/' --noiseModel=./GMMNoiseModel_None_3_2.npz --tileSize=128
