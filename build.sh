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

set -eu

APPROOT=/short/w35/saw562/scratch/testapps
MODULEROOT=/short/w35/saw562/scratch/testapps/modules
CONFIGROOT=$PWD

APPVERSION=$1

for compiler in $CONFIGROOT/toolchains/compiler/*; do
    COMPILER=$(basename $compiler)

    for mpi in $CONFIGROOT/toolchains/mpi/*; do
    MPI=$(basename $mpi)

        qsub -q express -l ncpus=1 -l walltime=30:00 -l mem=2gb -l jobfs=2gb -j oe -m ea -N "$APPVERSION/${COMPILER}-${MPI}" << EOF
test -f $CONFIGROOT/$APPVERSION/environment.sh || echo "No environment"
test -f $CONFIGROOT/$APPVERSION/build.sh || echo "No build script"

export PREFIX=${APPROOT}/${APPVERSION}/${COMPILER}-${MPI}
mkdir -p \$PREFIX

source $CONFIGROOT/toolchains/compiler/$COMPILER
source $CONFIGROOT/toolchains/mpi/$MPI

BUILDDIR=$(mktemp -d)
pushd \$BUILDDIR

source $CONFIGROOT/$APPVERSION/environment.sh
bash $CONFIGROOT/$APPVERSION/build.sh | tee \$PREFIX/build.log
EOF

    done
done
