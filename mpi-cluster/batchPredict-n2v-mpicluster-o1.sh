#!/bin/sh

#SBATCH --job-name=n2vSimSim-o1
#SBATCH --time 0-01:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-predict-o1.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

mkdir results
mkdir results/o1
python3 ../n2v/scripts/predictN2V.py --dataPath='./orientations/o1/' --fileName='*.tif' --dims=TYX --name='n2v-simcare-o1' --output='./results/o1/'
