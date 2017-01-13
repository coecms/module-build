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
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/environment.sh
export PIO=$DIR/../../pio/2.0.31/install
export GPTL=$DIR/../../pio/2.0.31/install

tarball="https://github.com/MPAS-Dev/MPAS-Release/archive/v5.0.tar.gz"

[ -f src.tar.gz ] || wget -O src.tar.gz "$tarball"

mkdir -p src
tar --strip-components=1 --directory src -xf src.tar.gz

patch -p1 < patch/io_mod
patch -p1 < patch/mpi_comm_self
patch -p1 < patch/perf_mod

make -C src ifort CORE=init_atmosphere USE_PIO2=true TIMER_LIB=gptl AUTOCLEAN=true DEBUG=true
#make -C src ifort CORE=atmosphere USE_PIO2=true TIMER_LIB=gptl AUTOCLEAN=true DEBUG=true
