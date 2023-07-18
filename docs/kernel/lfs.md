## Cross compilation

### Actors
* build: The system that **builds** the code.
* host: The system that will **execute** the program.
* target: When compiling GCC, the system for which this GCC will compile code for.

### System type definition

The original system type definition used the cpu-vendor-system style (x86_64-unknown-freebsd), known as the system triplet. However, two machines can share the same system and still be too different to be used the same triplet to describe them, so the system field was splitted in kernel and os. For instance, this is the case of Android and a regular Ubuntu distribution for and ARM64 device (aarch64-unknown-linux-android, aarch64-unknown-linux-gnu). Finally, since the vendor field is rarely used, is usually omitted, ending with cpu-kernel-os (aarch64-linux-gnu).

For bare-metal embbeded systems, the kernel is none and instead of the os, we add the system (embbeded) ABI: arm-none-eabi.

This system type definition is usually used as a prefix by a specific GCC build, like x86_64-linux-gnu-gcc. In contrast, LLVM is cross compilers by definition, without the need for multiple binaries, thanks to its modular design.

### Steps
1. Compile a cross compiler for LFS.
1. Compile a LFS-native compiler with the cross compiler. It needs libgcc, glibc and stdlibc++, which are interdependant:
    1. Compile a degraded version libgcc and stdlibc++ without glibc.
    1. Used them to compile glibc.
    1. Rebuild libgcc and stdlibc++.
1. Use the LFS compiler to compile native packages.


### Linking stage


### Compiler sysroot

#### Library paths
gcc -L option pass paths where to look for (shared or static) libraries to ld
