#!/bin/sh

#SBATCH --job-name=pn2vSimSimPredict-o0
#SBATCH -A p_biomedicalmodel
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --time 0-12:00:00
#SBATCH --mem 32G
#SBATCH --mail-type=END,FAIL,TIME_LIMIT_90
#SBATCH -o PN2V-PredictJob-o0.log
#SBATCH -c 6
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu1

python3 predictPN2V.py --dataPath='/scratch/p_biomedicalmodel/n2v++/n2vSimSim/data/matslines/camsim/orientations/o0/' --name='pn2v-simsim-o0' --histogram="../../noiseModel.npy" --output='out/results/o0/'
