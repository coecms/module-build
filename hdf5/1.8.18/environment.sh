#!/bin/bash
# Source this file to get the build environment

module purge

# Compiler
module load intel-fc/17.0.1.132
module load intel-cc/17.0.1.132

# MPI
module load openmpi/1.10.2

module load hdf5/1.8.7
module load curl/7.49.1
module load zlib/1.2.8
