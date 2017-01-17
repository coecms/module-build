# module-build
Build configuration and scripts for creating environment modules at NCI

Libraries are built with different 'toolchains', combinations of compiler and
MPI library, which are automatically selected between when the library module
is loaded.

## Setup

The build script expects three helper scripts in the directory `libname/version`:

 * `download.sh`: Downloads the specified version's source code. As the compute
   nodes have no internet connection this gets run on the login node

 * `environment.sh`: Loads any extra environment, beyond the toolchain modules

 * `build.sh`: Compile and test the library, then install to the path
   `$PREFIX`, which will contain toolchain information.

## Build a library

### Build a library for a specific toolchain

    ./build.sh netcdf/4.4.1.1 intel17 ompi2.0

### Build a library for all available toolchains

    ./build-all.sh netcdf/4.4.1.1

## Create a modulefile

The `modules-common.tcl` script automatically sets up paths, and checks the
currently loaded compiler and MPI to determine the correct build to use. It
expects to be installed to the app directory.

To use the script create a module file which sources it. Paths are then
generated based on the module name.

    cat $MODULES_ROOT/netcdf/4.4.1.1 <<< EOF
    #%Modules1.0
    source $APP_ROOT/modules-common.tcl
    EOF
