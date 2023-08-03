# Debugging notes


### Kernel debug options
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


### glibc utils
* mtrace: dynamic memory checks
* ldd: print required shared libraries. -> pldd: from PID
* memusage: print memory usage
* sotruss: trace shared library function calls


### Other
* strace: System calls traces
* ltrace: Library calls traces
