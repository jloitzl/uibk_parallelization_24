#!/bin/bash

# submission partition

# name of the job
#SBATCH --job-name my_test_job
# redirect output stream to this file
#SBATCH --output output.dat
# specify parallel environment
#SBATCH --ntasks 8
#SBATCH --ntasks-per-node 2

mpiexec -n $SLURM_NTASKS ./build/mandelbrot_mpi
# srun ./build/mandelbrot_seq