# Set up some basics, name and version
set name [regsub {([^/]*)/(.*)} [ module-info version [ module-info name ]] {\1}]
set ver [regsub {([^/]*)/(.*)} [ module-info version [ module-info name ]] {\2}]
set id [regsub -all -- {-} "$name" {_}]

# Path where apps are installed to (the directory containing this script)
set root [ file dirname [ info script ] ]

if {! [module-info mode remove] } {
    # If not in remove mode get the compiler and MPI version
    if {! [ is-loaded intel-cc intel-fc gcc ]} {
        puts stderr "ERROR: No compiler is loaded, unable to load library"
        prereq intel-cc intel-fc gcc
    }

    if {! [ is-loaded openmpi intel-mpi ]} {
        puts stderr "ERROR: No MPI is loaded, unable to load library"
        prereq openmpi intel-mpi
    }

    if [ is-loaded intel-fc ] {
        set compiler intel[ regsub {([0-9]+)(\..*)?} $::env(INTEL_FC_VERSION) {\1}]
    } elseif [ is-loaded intel-cc ] {
        set compiler intel[ regsub {([0-9]+)(\..*)?} $::env(INTEL_CC_VERSION) {\1}]
    } elseif [ is-loaded gcc ] {
        set compiler gcc[ regsub {([0-9]+\.[0-9]+)(\..*)?} $::env(GCC_VERSION) {\1}]
    } else {
        puts stderr "ERROR: Unknown compiler"
        break
    }

    if [ is-loaded openmpi ] {
        set mpi ompi[ regsub {([0-9]+\.[0-9]+)(\..*)?} $::env(OPENMPI_VERSION) {\1}]
    } elseif [ is-loaded intel-mpi ] {
        set mpi impi[ regsub {([0-9]+)(\..*)?} $::env(INTEL_MPI_VERSION) {\1}]
    } else {
        puts stderr "ERROR: Unknown MPI"
        break
    }
    set prefix "$root/$name/$ver/$compiler-$mpi"

    if {! [ file exists $prefix/.build_succeeded ] } {
        puts stderr "ERROR: [module-info version [module-info name]] has not been compiled for $compiler-$mpi"
        break
    }
} else {
    # If in remove mode get the prefix from an environment variable (the
    # toolchain may have already been unloaded)
    set prefix $::env([string toupper $id]_ROOT)
}

# Some environment variables
setenv [string toupper $id]_ROOT $prefix
setenv [string toupper $id]_BASE $prefix
setenv [string toupper $id]_VERSION $ver

# Only add directories to PATHs if they exist
if [ file exists $prefix/bin ] {
    prepend-path PATH $prefix/bin
}
if [ file exists $prefix/lib64 ] {
    prepend-path RPATH           $prefix/lib64
    prepend-path LD_RUN_PATH     $prefix/lib64
    prepend-path LIBRARY_PATH    $prefix/lib64
    prepend-path LD_LIBRARY_PATH $prefix/lib64
}
if [ file exists $prefix/lib ] {
    prepend-path RPATH           $prefix/lib
    prepend-path LD_RUN_PATH     $prefix/lib
    prepend-path LIBRARY_PATH    $prefix/lib
    prepend-path LD_LIBRARY_PATH $prefix/lib
}
if [ file exists $prefix/include ] {
    prepend-path CPATH $prefix/include
    prepend-path FPATH $prefix/include
}
if [ file exists $prefix/lib/pkgconfig ] {
    prepend-path PKG_CONFIG_PATH $prefix/lib/pkgconfig
}
if [ file exists $prefix/man ] {
    prepend-path MANPATH $prefix/man
}
if [ file exists $prefix/share/man ] {
    prepend-path MANPATH $prefix/share/man
}
