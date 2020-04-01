#!/bin/sh

#SBATCH --job-name=GMMnoiseModel
#SBATCH --time 0-0:15:00
#SBATCH --mem-per-cpu 256000
#SBATCH -o GMMnoiseModel.log
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

python3 ../ppn2v/scripts/createNoiseModelPN2V.py --outPath='./' --signal='results/join/*.tif' --observation='./*.tif' --minSigma=5.0
