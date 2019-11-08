#!/bin/sh

#SBATCH --job-name=n2vSimSim
#SBATCH -A p_biomedicalmodel
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --time 0-12:00:00
#SBATCH --mem 32G
#SBATCH --mail-type=END,FAIL,TIME_LIMIT_90
#SBATCH -o predict-o0.log
#SBATCH -c 6
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu1

python3 predictN2V.py --dataPath='/scratch/p_biomedicalmodel/n2v++/n2vSimSim/data/matslines/camsim/orientations/o0/' --name='n2v-simsim-o0' --fileName='*sig200*.tif' --dims=TYX --output='out/results/o0/'
