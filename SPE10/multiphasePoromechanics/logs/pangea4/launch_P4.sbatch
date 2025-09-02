#!/bin/sh
#SBATCH --job-name="SPE10"
#SBATCH --ntasks=768
#SBATCH --time=1:00:00
#SBATCH --partition=p4_general
#SBATCH -o 768rank_P4.out
# #SBATCH --mem=200GB
#SBATCH -N 4
#SBATCH --exclusive

ulimit -s unlimited
ulimit -c unlimited

module purge
module load PrgEnv-gnu/8.4.0 craype-x86-milan cmake/3.27.2 cray-python/3.10.10
module unload cray-libsci/23.09.1.1 cray-mpich/8.1.27 
module load hpcx
export MODULEPATH=$MODULEPATH:/lustre/p4scratch/data_local/sw/lmod/lmod/modulefiles/rhel8.8/genoa/spack/gcc/12.1/.level1/.libraries
module load intel-oneapi-mkl/2023.2.0

export HDF5_USE_FILE_LOCKING=FALSE
export OMP_NUM_THREADS=1

#----- Execute a job -----
srun --hint=nomultithread --mpi=pmix_v3 -n ${SLURM_NTASKS} /workrd/SCR/GEOSX/j1067677/P4_build/GEOS/build-pangea4-gcc12.1-hpcxompi2.17.1-onemkl2023.2.0-release/bin/geosx -i SPE10_with_burdens_fim_homog.xml -x 12 -y 8 -z 8
