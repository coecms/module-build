#!/bin/bash
#  Copyright 2017 ARC Centre of Excellence for Climate Systems Science
#
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

#PBS -q express
#PBS -l ncpus=1 
#PBS -l walltime=1:30:00 
#PBS -l mem=2gb 
#PBS -l jobfs=2gb 
#PBS -l software=intel-fc
#PBS -j oe 
#PBS -m a

set -eu

APPROOT=/short/w35/saw562/scratch/testapps
MODULEROOT=/short/w35/saw562/scratch/testapps/modules
CONFIGROOT=${PBS_O_WORKDIR:-$PWD}

module purge
module use $MODULEROOT

: ${APPVERSION:=$1}
: ${COMPILER:=$2}
: ${MPI:=$3}

test -f $CONFIGROOT/$APPVERSION/environment.sh || echo "No environment"
test -f $CONFIGROOT/$APPVERSION/build.sh || echo "No build script"

export PREFIX=${APPROOT}/${APPVERSION}/${COMPILER}-${MPI}
mkdir -p $PREFIX

source $CONFIGROOT/toolchains/compiler/$COMPILER
source $CONFIGROOT/toolchains/mpi/$MPI

BUILDDIR=$(mktemp -d)
pushd $BUILDDIR

source $CONFIGROOT/$APPVERSION/environment.sh
bash $CONFIGROOT/$APPVERSION/build.sh | tee $PREFIX/build.log
