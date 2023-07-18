# Linker

Compiling process:
source code --(compiler)-> assembly code --(assembler)-> object file --(linker)-> executable

The linker is usually the last step of the compiling process. It converts object files into executables and shared libraries.

Print link debug options: LD_DEBUG=help ./executable
LD_LIBRARY_PATH: paths where to look for shared libraries

### Unix linkers
* ld.bfd: This is the default GNU binutils linker (called with ld).
* ld.gold: New, faster implementation, included also in GNU binutils. Only works with ELF files.
* lld: LLVM linker implementation, faster than the original ld.


### Dynamic linker
The dynamic linker/loader links an executable with the shared libraries it needs.
On Linux, the dynamic linker is the ld.so executable (which calls ld-linux-so.2), which is part of glibc. It is called automatically when executing a program, but it can also be called manually with 'ld.so /full/path/to/executable'.

* ldd: print required shared libraries. -> pldd from PID
* ldconfig: creates ld.so links and cache
* /etc/ld.so.conf (/etc/ld.so.conf.d/)

#### .so files
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



### References
1. https://www.airs.com/blog/archives/38 (http://a3f.at/lists/linkers)
