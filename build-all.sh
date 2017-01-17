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

CONFIGROOT=$PWD
APPVERSION=$1
export SOURCEDIR=$CONFIGROOT/$APPVERSION

if [ -f $CONFIGROOT/$APPVERSION/download.sh ]; then
    bash $CONFIGROOT/$APPVERSION/download.sh 
fi

for compiler in $CONFIGROOT/toolchains/compiler/*; do
    COMPILER=$(basename $compiler)

    for mpi in $CONFIGROOT/toolchains/mpi/*; do
    MPI=$(basename $mpi)

        name=$(tr '/' '_' <<< "$APPVERSION/${COMPILER}-${MPI}")
        qsub -o "$CONFIGROOT/log/$name" -N "$name" -v APPVERSION=${APPVERSION},COMPILER=${COMPILER},MPI=${MPI} -P $PROJECT $CONFIGROOT/build.sh

    done
done
