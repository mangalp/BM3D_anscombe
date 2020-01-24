#!/bin/sh

#SBATCH --job-name=n2vSimSim-o2
#SBATCH --time 0-01:00:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o N2VJob-predict-o2.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../n2v/scripts/predictN2V.py --dataPath='./orientations/o2/' --fileName='*.tif' --dims=TYX --name='n2v-simcare-o2' --output='./results/o2/'
