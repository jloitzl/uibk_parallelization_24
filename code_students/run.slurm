#!/bin/bash

# submission partition
#SBATCH --partition=lva
# name of the job
#SBATCH --job-name my_test_job
# redirect output stream to this file
#SBATCH --output output.dat
# specify parallel environment
#SBATCH --ntasks 8
#SBATCH --ntasks-per-node 4

module load gcc/12.2.0-gcc-8.5.0-p4pe45v openmpi/3.1.6-gcc-12.2.0-d2gmn55

mpiexec -n $SLURM_NTASKS ./build/apps/run_full_code_parallel
