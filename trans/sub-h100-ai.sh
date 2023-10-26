#!/bin/bash -l

#SBATCH --job-name=train_mn
#SBATCh -D ./
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH -o tjob_output.%j
#SBATCH -e tjob_error.%j
#SBATCH --time=1-00:00:00
#SBATCH --gres=gpu:4
###SBATCH --mem=1020000
#SBATCH --cpus-per-task=16
#SBATCH --exclusive

##SBATCH --account ISAAC-UTK0235 for MRSEC

#SBATCH --account ISAAC-UTK0254
#SBATCH --partition=ai-tenn
#SBATCH --qos=ai-tenn

module purge
#module load /lustre/isaac/proj/UTK0235/YZ_group/yz/bin/nvidia/hpc_sdk/modulefiles/nvhpc/23.9

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
ulimit -s unlimited
ulimit -l unlimited

#srun vasp_ncl > prog1.out
df -mh >>prog.out
free -h >>prog.out
lscpu >>prog.out
nvidia-smi >>prog.out
ulimit -a >>prog.out

source /lustre/isaac/proj/UTK0254/mn/bin/deepmd.sh


dp train input.json --init-model old/model.ckpt
