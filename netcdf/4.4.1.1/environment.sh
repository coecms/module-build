#!/bin/bash
# Source this file to get the build environment

module load curl/7.49.1
module load zlib/1.2.8
module load hdf5/1.8.18

# Conflicts with pnetcdf > 1.6
# http://netcdf-group.1586084.n2.nabble.com/make-test-fails-tests-involving-uchar-Numeric-conversion-not-representable-td7576124.html
#module load pnetcdf/1.8.0
