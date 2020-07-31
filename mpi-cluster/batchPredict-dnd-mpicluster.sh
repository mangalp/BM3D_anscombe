#!/bin/sh

#SBATCH --job-name=DnD-predict
#SBATCH --time 0-00:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o DnD-predict.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../../../../DnD/script_predict_DnD.py --dataPath=./ --fileName='*.tif' --name="DnD-predict" --output='./' --tileSize=128
