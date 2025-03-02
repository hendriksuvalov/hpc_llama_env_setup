#!/bin/bash
#SBATCH --partition gpu
#SBATCH --nodes 1
#SBATCH --time 04:00:00
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem 16G
#SBATCH --job-name llama_env_setup
#SBATCH --output jupyter-log-%J.txt
#SBATCH --mail-type=ALL

# Activate conda module
module load any/python/3.8.3-conda
conda env create -f llama_local_env.yml


