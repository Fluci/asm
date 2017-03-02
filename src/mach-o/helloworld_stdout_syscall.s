# http://www.idryman.org/blog/2014/12/02/writing-64-bit-assembly-on-mac-os-x/#hello-world

.section __DATA,__data
str:
	.asciz "Hello world from syscall!\n"

.section __TEXT,__text
.globl _main
_main:
	movl $0x2000004, %eax # sys call 4
	movl $1, %edi # write sys call to file descriptor is 1 (STDOUT)
	movq str@GOTPCREL(%rip), %rsi # value to print: access str through GOT (Global Offset Table), GOT needs to be accessed from the instruction pointer %rip
	movq $100, %rdx # size of value to print
	syscall # call write
	# prepare exit
	movl $0, %ebx
	movl $0x2000001, %eax # exit 0
	syscall

