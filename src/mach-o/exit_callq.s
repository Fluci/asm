# simple exit program from http://www.idryman.org/blog/2014/12/02/writing-64-bit-assembly-on-mac-os-x/
.section __TEXT,__text # segment __TEXT, section __text
.globl _main
_main: # label to know here main starts
	pushq %rbp 		# push base pointer value to stack
	movq %rsp, %rbp	# copy stack pointer to base pointer
	movl $5, %edi   # exit(5): put 5 into register edi
	callq _exit		# call exit
