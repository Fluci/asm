# simple exit program from http://www.idryman.org/blog/2014/12/02/writing-64-bit-assembly-on-mac-os-x/
.section __TEXT,__text # segment __TEXT, section __text
.globl _main
_main: # label to know here main starts
	movl $0x2000001, %eax # put system call $1 (exit) with $0x200000 offset in eax
	movl $17, %ebx # set exit code to be $0
	syscall # call exit(0)
