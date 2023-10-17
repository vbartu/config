# Debugging

## GDB

### Basic
[ENTER] repeats last command.
```
(GDB) file a.out
(GDB) info file            // Get entry point address
(GDB) break *0x400007      // Entry point
(GDB) run arg1 arg2 ...
(GDB) next                 // Next instruction, over functions
(GDB) step                 // One instruction, into functions
(GDB) finish               // End of current function/section?
```
### Assembly
```
(gdb) set disassembly-flavor intel
(gdb) layout asm
(gdb) layout regs
(gdb) nexti
(gdb) stepi
```

### References
* [Quick assembly guide](https://reverseengineering.stackexchange.com/questions/1935/how-to-handle-stripped-binaries-with-gdb-no-source-no-symbols-and-gdb-only-sho)

## Binutils tools
* strace: System calls traces
* ltrace: Library calls traces
* mtrace: dynamic memory checks
* ldd: print required shared libraries
    * pldd: from PID
* memusage: print memory usage
* sotruss: trace shared library function calls
* addr2line
* nm
* objdump, objcopy
* readelf, elfedit
* size
* strings, strip
* gcov, gprof





## Linux kernel debug options
With `menuconfig`, under *Kernel Hacking*.
General:
* CONFIG\_DEBUG\_INFO
* CONFIG\_DEBUG\_FS
* CONFIG\_MAGIC\_SYSRQ
* CONFIG\_DEBUG\_KERNEL
* CONFIG\_DEBUG\_MISC
* Memory:
    * CONFIG\_SLUB\_DEBUG
    * CONFIG\_DEBUG\_MEMORY\_INIT
    * CONFIG\_KASAN
* CONFIG\_DEBUG\_SHIRQ
* CONFIG\_SCHED\_STACK\_END\_CHECK
* CONFIG\_PROVE\_LOCKING
* CONFIG\_LOCK\_STAT
* CONFIG\_DEBUG\_ATOMIC\_SLEEP
* CONFIG\_STACKTRACE
* CONFIG\_DEBUG\_BUGVERBOSE
* CONFIG\_FTRACE: Has different tracers
* CONFIG\_BUG\_ON\_DATA\_CORRUPTION
* CONFIG\_KGDB: Kernel gdb
* CONFIG\_UBSAN
* CONFIG\_EARLY\_PRINTK
* CONFIG\_DEBUG\_BOOT\_PARAMS
* CONFIG\_UNWINDER\_FRAME\_POINTER
