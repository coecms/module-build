#!/bin/bash
# Source this file to get the build environment

module purge

# Compiler
module load intel-fc/17.0.1.132
module load intel-cc/17.0.1.132

# MPI
module load openmpi/1.10.2

module load netcdf-fortran/4.4.4
module load pnetcdf/1.8.0

module load pio/2.0.31-6ce7f36
