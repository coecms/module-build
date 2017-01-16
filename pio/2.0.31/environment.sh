#!/bin/bash
# Source this file to get the build environment

module purge
module use /short/w35/saw562/scratch/testapps/modules

# Compiler
module load intel-fc/17.0.1.132
module load intel-cc/17.0.1.132

# MPI
module load openmpi/1.10.2

module load netcdf/4.3.3.1
module load pnetcdf/1.8.0

module load cmake
