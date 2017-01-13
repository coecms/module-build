#!/bin/bash
# Source this file to get the build environment

module purge

# Compiler
module load intel-fc/17.0.1.132
module load intel-cc/17.0.1.132

# MPI
module load openmpi/1.10.2

module load curl/7.49.1
module load zlib/1.2.8

export CPATH=/home/562/saw562/scratch/mpas-build/hdf5/1.8.18/install/include:$CPATH
export LIBRARY_PATH=/home/562/saw562/scratch/mpas-build/hdf5/1.8.18/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/562/saw562/scratch/mpas-build/hdf5/1.8.18/install/lib:$LD_LIBRARY_PATH
export CPATH=/home/562/saw562/scratch/mpas-build/pnetcdf/1.8.0/install/include:$CPATH
export LIBRARY_PATH=/home/562/saw562/scratch/mpas-build/pnetcdf/1.8.0/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/home/562/saw562/scratch/mpas-build/pnetcdf/1.8.0/install/lib:$LD_LIBRARY_PATH
