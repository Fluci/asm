# http://www.idryman.org/blog/2014/12/02/writing-64-bit-assembly-on-mac-os-x/#hello-world-using-printf

.section __DATA,__data
str:
	.asciz "Hello world from printf!\n"

.section __TEXT,__text
.globl _main
_main:
	pushq %rbp # push frame pointer, start to prepare function call
	movq %rsp, %rbp # frame pointer to start of new frame (which is the old base pointer)
	movq str@GOTPCREL(%rip), %rdi # get str via GOT and %rip
    movb $0, %al #
    callq _printf # call printf
    popq %rbp #

    movl $0x2000001, %eax # magic number for exit syscall
    syscall # execute systemcall

