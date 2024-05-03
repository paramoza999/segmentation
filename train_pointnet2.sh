#!/bin/bash 
#SBATCH -p general ## Partition
#SBATCH -q public  ## QOS
#SBATCH -c 1       ## Number of Cores, adjusted as needed for PointNet++
#SBATCH --gres=gpu:1  ## Request GPU resource
#SBATCH --mem=64G  ## Memory, adjust based on your model's requirement
#SBATCH --time=0-24:00:00  ## 24 hours of compute, adjust as needed
#SBATCH --job-name=pointnet2_train
#SBATCH --output=slurm.%j.out  ## job /dev/stdout record (%j expands -> jobid)
#SBATCH --error=slurm.%j.err   ## job /dev/stderr record 
#SBATCH --export=NONE          ## keep environment clean
#SBATCH --mail-type=ALL        ## Notify for any job state change
#SBATCH --mail-user=puoza@asu.edu ## Correct email address

echo "WHERE I AM FROM: $SLURM_SUBMIT_DIR"
echo "WHERE AM I NOW: $(pwd)"
echo "Loading python 3 from anaconda module"
module load mamba/latest  ## Assuming mamba manages your environments
echo "Loading scientific computing python environment for PointNet++"
source activate pytorch-gpu-2.1.0-cuda-12.1  ## Make sure this environment has all necessary packages
echo "Running PointNet++ training script"
python3 train_semseg.py --model pointnet2_sem_seg_tran_msg --test_area 5 --log_dir pointnet2_sem_seg_tran_msg
