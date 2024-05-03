!/bin/bash

SBATCH -N 1                # Number of nodes
SBATCH -c 4                # Number of CPU cores per task
SBATCH --mem=64G           # Memory pool for all cores (see also --mem-per-cpu)
SBATCH -t 2-00:00:00       # Runtime in D-HH:MM, minimum of 10 minutes
SBATCH -p general          # Partition to submit to
SBATCH --qos=public        # QOS; adjust if your system uses a different QOS name
SBATCH -o slurm.%j.out     # Standard output and error log
SBATCH -e slurm.%j.err     # Standard error log
SBATCH --mail-type=ALL     # Send email at start, end, and abortion of the job
SBATCH --gres=gpu:1        # Request GPU resource
SBATCH --export=ALL        # Export you current env to the job env

# Load modules or software if needed
module load python/3.8 cuda/11.0 cudnn/8.0.4.30-11.1-linux-x64
# Replace with the modules available in your cluster environment

# Activate your Python virtual environment
#source activate /path/to/your/env/scicomp

# Make sure to navigate to your project directory if it's necessary
cd /home/puoza/p2/Pointnet_Pointnet2_pytorch/



# Run the training script
python train_semseg.py --model pointnet_sem_seg --batch_size 16 --epoch 32 --gpu 0
