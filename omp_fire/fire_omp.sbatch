#!/bin/bash

#SBATCH --partition=guane_24_cores  # Partition name - The names are obtained with the sinfo command
#SBATCH --job-name=mxm_Jv           # Name of the task to be executed - can be any
#SBATCH --nodes=1                   # Number of nodes to use
#SBATCH --ntasks=1		            # Number of tasks to execute
#SBACTH --cpus-per-task=8            # Number of cores assigned to each task
#SBATCH --ntasks-per-node=1         # Total number of tasks to execute per node
#SBATCH --output=output_fire_omp_%j.txt  # Output file containing the results of the execution
#SBATCH --error=error_fire_omp_%j.err    # File containing runtime errors


module load devtools/gcc/6.2.0

if [ -f SALIDA ]; then
    rm -r fire_omp
fi      
gcc -fopenmp fire_omp.c -o fire_omp
        
if [ -n "$SLURM_CPUS_PER_TASK"]; then
	omp_threads=$SLURM_CPUS_PER_TASK
else
    omp_threads=1
fi
                        
export OMP_NUM_THREADS=$omp_threads
./fire_omp
