# hpc_llama_env_setup


### Getting the files to HPC

Get all the files into your preferred directory on HPC. After downloading the files in this repository, use a terminal to cd into the folder containing the files and move them to HPC. An easy way to do this is via scp.

```
scp <file> <user>@rocket.hpc.ut.ee:/<path_on_HPC>
```

For example, if I wanted a file in my home directory:

```
scp llama_local_env.yml shuva@rocket.hpc.ut.ee:/gpfs/helios/home/shuva/llama_local_env.yml
```

This copies the files to HPC's rocket. Repeat this for all the files in this repo.

### Setting up the environment

_llama_local_env.yml_ file contains the instructions for a conda environment with the needed libraries to run the LLM-s. 
_llama_local_setup.sbatch_ file uses **slurm** to create this environment. On HPC rocket, if you want to allocate resources to run code, you queue up a task with specified resources and the task. This batch file asks for some resources and the purpose of it is creating a conda environment called _llama_local_.

In order to run it, make sure you are in the server through a terminal:

```
ssh <LDAP_user>@rocket.hpc.ut.ee
```

Navigate to the directory that contains the files. If they are in your home directory, you should already be in the correct place. Double-check with ```ls```.

Run the following:

```
sbatch llama_local_setup.sbatch
```

This will return you a message saying:

**Submitted batch job <id>**

You can check running jobs under your username with the following command:

```
squeue -u <username>
```

The task should also generate a log file called _jupyter-log-<task_id>_. You can type ```cat jupyter-log-<task_id>``` to see the status of the task. Once it's finished, it should state that a conda environment was created. If at any point your tasks get completed and you no longer need the resources and the task does not kill itself, you can cancel it with the following command:

```
scancel <job_id>
```

Or to kill all tasks submitted by your user:

```
scancel -u <user_name>
```

### Running the environment

_llama_local_notebook.sbatch_ is a task that activates the conda environment and a **jupyter-notebook** instance with said environment, where you can run your code. Activate the task by typing:

```
sbatch llama_local_notebook.sbatch
```

When the task goes through, it should generate a log file as well, which you can see by typing ```cat jupyter-log-<task_id>```. If everything is successful, it should contain a link directing you to the notebook instance. Use the one that is not _localhost_ or _127.0.0.1_. If for some reason the page is not loading, make sure you are either in **eduroam** WIFI or using a VPN. 

_Running_a_small_llama_model.ipynb_ is an example notebook file that should init a model and generate tokens. It runs a ridiculously small model that does not do anything useful other than validates our code. Replace the model card with a preferred model of your own.

Remember to kill the task once you're done. You can modify the _llama_local_notebook.sbatch_ to ask for more resources or a longer task time (currently 4h). Check out HPC docs at https://docs.hpc.ut.ee/public/ for more help.








