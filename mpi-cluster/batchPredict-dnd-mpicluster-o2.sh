#!/bin/sh

#SBATCH --job-name=pn2vSimSim-o2
#SBATCH --time 0-01:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o DnDJob-predict-o2.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../DnD/script_predict_DnD.py --dataPath='./orientations/o2/' --fileName='*.tif' --name="o2" --output='./results/o2/' --tileSize=128
