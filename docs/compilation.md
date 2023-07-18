# Compilation
Compiling process:
source code --(compiler)-> assembly code --(assembler)-> object file --(linker)-> executable

### System type definition
The original system type definition used the cpu-vendor-system style (x86_64-unknown-freebsd), known as the system triplet. However, two machines can share the same system and still be too different to be used the same triplet to describe them, so the system field was splitted in kernel and os. For instance, this is the case of Android and a regular Ubuntu distribution for and ARM64 device (aarch64-unknown-linux-android, aarch64-unknown-linux-gnu). Finally, since the vendor field is rarely used, is usually omitted, ending with cpu-kernel-os (aarch64-linux-gnu).

For bare-metal embbeded systems, the kernel is none and instead of the os, we add the system (Embbeded-) ABI: arm-none-eabi.

This system type definition is usually used as a prefix by a specific GCC build, like x86_64-linux-gnu-gcc. In contrast, LLVM is cross compilers by definition, without the need for multiple binaries, thanks to its modular design.

### Options
gcc -L: option pass paths where to look for (shared or static) libraries to ld
gcc --sysroot: select sysroot

#### CPU and ARCH compilation flags
In x86[\_64], `-mcpu` is equivalent to `-mtune`. In arm, `-mcpu` combines `-march` and `-mtune` to provide the best performance.


## Cross-compilation
### Actors
* build: The system that **builds** the code.
* host: The system that will **execute** the program.
* target: When compiling with GCC, the system for which this GCC will compile code for.

### Compiler sysroot
Contains libraries, header files and config files.
Dirs: lib, sbin, usr/{bin,include,lib,share} -> Mastering Embbeded System Programming Chp 2


### Device tree
TODO

### Linux From Scratch (LFS) compiler setup steps
1. Compile a cross compiler for LFS.
1. Compile a LFS-native compiler with the cross compiler. It needs libgcc, glibc and stdlibc++, which are interdependant:
    1. Compile a degraded version libgcc and stdlibc++ without glibc.
    1. Used them to compile glibc.
    1. Rebuild libgcc and stdlibc++.
1. Use the LFS compiler to compile native packages.


### crosstools-ng
#### Setup
* Download and decompress crosstools-ng release
* bootstrap
* configure prefix=$PWD
    * --with-sysroot
* menuconfig
    * ARCH_CPU (mcpu)
    * 64 bits
    * linux version
    * glibc (or musl libc) version
    * binutils version
* makej
* make install.


## Linker
The linker is usually the last step of the compiling process. It converts object files into executables and shared libraries.

Print link debug options: LD_DEBUG=help ./executable
LD_LIBRARY_PATH: paths where to look for shared libraries

### Unix linkers
* ld.bfd: This is the default GNU binutils linker (called with ld).
* ld.gold: New, faster implementation, included also in GNU binutils. Only works with ELF files.
* lld: LLVM linker implementation, faster ld drop-in replacement.
* mold: From lld's developer, faster than lld

### LTO (Link Time Optimizer)
-flto

### Dynamic linker
The dynamic linker/loader links an executable with the shared libraries it needs.
On Linux, the dynamic linker is the ld.so executable (which calls ld-linux-so.2), which is part of glibc. It is called automatically when executing a program, but it can also be called manually with 'ld.so /full/path/to/executable'.

* ldd: print required shared libraries.
    * pldd: from PID
* ldconfig: creates ld.so links and cache
* /etc/ld.so.conf (/etc/ld.so.conf.d/)

#### Shared libraries
shared_lib.so.x -> the x refers to different library versions. Each executable knows exactly which version it needs.
The symbolic link shared_lib.so points to the one whose headers (.h) files are installed on the system, so the linker can use it during the linking process.
In Debian, -dev packages usually includes the headers and the symbolic link. The actual library is enough for *running* executables.

### Linker internals
Very rough understanding. See references 1.

#### Linker data types
* Symbols: name-value pairs. The value is usually an address offset into the contents of the code (function, variable, etc). They are also used to reference a name defined somewhere else (undefined symbol). During linking, the linker assigns an address to each defined symbol, and resolves each undefined symbol.
* Contents: The actual bytes of the different memory sections (text, data, etc.). The linker concatenates them by type, applies realocations and creates the final executable.
* Relocations: Computations on the contents.

#### Address spaces
* Object file address space
* Output address space (virtual memory addresses): Where the program runs in memory
* Load memory address space: Where the program is loaded. Changes in embedded systems (ROM vs RAM)

### Linker references
1. https://www.airs.com/blog/archives/38
2. http://a3f.at/lists/linkers
