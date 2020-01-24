#!/bin/sh

#SBATCH --job-name=n2vSimSim-o0
#SBATCH --time 0-01:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-predict-o0.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../../../../../n2v/scripts/predictN2V.py --dataPath='./' --fileName='*5033*.tif' --dims=TYX --name='n2v-simsim-o0' --output='../results/o0/'
