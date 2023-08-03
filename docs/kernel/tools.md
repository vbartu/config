# Kernel tools

Check Linux Kernel Programming book resources (ch5/lkm\_template/Makefile).

### Code navigation
1. ctags
1. cscope


### Security
1. checksec.sh
1. leaking\_addressess.pl

### Code style
[Kernel code style](https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=indentation)
1. indent
1. [scripts/checkpath.pl](https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html)

### Static analysis
1. [sparse](https://www.kernel.org/doc/html/latest/dev-tools/sparse.html)
1. gcc: Pass W=1,2,3,e -> enables warnings, more than 1 is probably overkill. (make help)
1. [flawfinder](https://github.com/david-a-wheeler/flawfinder)
1. cppcheck
1. [coccinelle](https://www.kernel.org/doc/html/latest/dev-tools/coccinelle.html)

### Dynamic analysis
Requires enabling debug config options.
1. kasan: Kernel Address Sanitazer -> check debugging.md
1. lockdep


### Research further:
1. Linux Tracing Toolkit next generation (LTTng)
