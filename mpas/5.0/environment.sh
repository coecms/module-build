#!/bin/bash
# Source this file to get the build environment

module purge

# Compiler
module load intel-fc/17.0.1.132
module load intel-cc/17.0.1.132

# MPI
module load openmpi/1.10.2

module load netcdf/4.3.3.1
