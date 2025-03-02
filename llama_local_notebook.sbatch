#!/bin/bash
#SBATCH --partition gpu
#SBATCH --nodes 1
#SBATCH --time 04:00:00
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem 40G
#SBATCH --job-name llama_local_notebook
#SBATCH --output jupyter-log-%J.txt
#SBATCH --mail-type=ALL

# Some modules
module load any/python/3.8.3-conda
conda activate llama_local

## get tunneling info
XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-8080 -n1)
ipnip=$(hostname -i)

## print tunneling instructions to jupyter-log-{jobid}.txt
echo -e "\n\n   Copy/Paste this in your local terminal to ssh tunnel with remote "
echo        "   ------------------------------------------------------------------"
echo        "   ssh -N -L $ipnport:$ipnip:$ipnport $(whoami)@$(dig +short -x $ipnip | rev | cut -c 2- | rev)"
echo        "   ------------------------------------------------------------------"
echo -e "\n\n   Then open a browser on your local machine to the following address"
echo        "   ------------------------------------------------------------------"
echo        "   localhost:$ipnport                                                "
echo -e     "   ------------------------------------------------------------------\n\n"
sleep 1

## start an ipcluster instance and launch jupyter server
jupyter-notebook --no-browser --port=$ipnport --ip=$ipnip

