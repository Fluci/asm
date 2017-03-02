# The wonderful world of assembly
This repository tries to give an overview and general feel for the family of assembly languages. It doesn't aim to be a precise reference for a certaint dialet (there are plenty of good cheat sheets out there). This summary tries to give an intuition for common patterns and some "experience" of what is out there. 

In the directory `src` you can find a collection of examples. Most of the time, you can run an example with `$ gcc -m32 -o example example.s`.

## variables
### Local variables
Stored on the stack. Compiler doesn't know absolute value, uses frame pointer to resolve relative address.
Referenced by negative offsets from base pointer.

### Parameters
Referenced by positive offsets from base pointer.

## Registers

### Naming
src: [http://www.cs.princeton.edu/courses/archive/spring04/cos217/lectures/IA32-I.pdf]()

example:

- eax: 32-bit general-purpose register
- ax: 16-bit (lower half)
- ah, hl: 8-bit registers (high and low)

### %eax, %ax, %ah, %al
Accumulator for operands, results. Return values often end up here.

### %ebx, %bx, %bh, %bl
Pointer to data in the DS segment.

### %ecx, %cx, %ch, %cl
Counter for string, loop operations

### %edx, %dx, %dh, %dl
I/O pointer

### %esi, %si
Pointer to DS data, string source

### %edi, %di
Pointer to ES data, string destination

### Base pointer = BP, Frame Pointer = FP, %ebp, %bp
Pointer to data on the stack. Points to the previous frame's base pointer. Points to the base of the current stackframe: The base of the stack frame is not the first "item" belonging to the frame (like a parameter), but think of base as a reference point from which you can get to all the data of the function by using relative addresses (positive ones for parameters, negative ones for local variables etc.). Reference point on stack to get local variables and function parameters in current stack frame. Only manipulated explicitly.

### Stack pointer, %esp
Points to the last value that was stored, under the assumption that its size will match the operating mode of the processor.
A push decreases the value, a pop increases the pointer.


### Instruction pointer, %rip

### Programm Counter, Instruction Pointer, EIP
Changed by:

- unconditional jump
- conditional jump
- procedure call
- return

## commands

### v
A simple value: 0xdeadbeef (The number), %eax (content of the register)

### memory operand (v), [v]
Value at memory location v, except at lea instruction.

Examples:
```asm
mov eax, [ebx]
mov eax, [ebx+3]
movl (%ebx), %eax
movl 3(%ebx), %eax
```

Intel syntax: `segreg:[base+index*scale+disp]`
AT&T syntax: `%segreg:disp(base, index, scale)`
optional: index, scale, disp, segreg

### direction of operands: src,dst or dst,src?
intel syntax: dest,source
AT&T syntax: source,dest

### push v
Write v to stack, decrease stack pointer.

### pop v
Take top of the stack and write into v, increase stack pointer.

### mov a l
Computes addres a and stores value at a into location l.

### call v
Call the function v, return value in eax.

### lea a l, Load Effective Address
Computes address a and stores it into location l.

### AT&T suffixes
- l: long
- w: word
- b: byte

src: [http://www.imada.sdu.dk/Courses/DM18/Litteratur/IntelnATT.htm]()

## registers

## Syntax
### Statement format
One statement per line.
Generally:
```
[label] mnemonic [operands] [;comment]
```
[https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm]()

### Constants
Sometimes `1`, sometimes `$1`.

### Registers
Sometimes `AH`, sometimes `eax`, sometimes `%eax`.

### Commands
Sometimes `MOV`, sometimes `mov`.

### Comments
Sometimes with `;`, sometimes with `#`.

### Examples intel syntax
```
mov eax, 1
mov ebx, 0ffh
int 80h
```

### Examples AT&T Syntax
```
movl $1, %eax
movl $0xff, %ebx
int $0x80
```

## procedures
### procedure call, caller-side
Different types of data can be passed at different locations. Memory (large stuff or things without a "standard" size) often is passed on the stack by pushing them backwards.
example:
```
function(1,2,3);
```
gives:
```
pushl $3
pushl $2
pushl $1
call function
```

Integers often are passed in registers: %rdi, %rsi, %rdx, %rcx, %r8, %r9

Vectors are passed in %xmm0 to %xmm7.


### procedure call, callee-side = procedure prolog
save previous FP (resotre at procedure exit)
Copy SP into FP.
Advance SP to reserve space for the local variables.
[http://insecure.org/stf/smashstack.html](insecure.org)

```asm
pushl %ebp      ; push frame pointer onto stack
movl %esp, %ebp ; copy sp to bp, making it the new frame poitner
subl $20, %esp  ; allocate space for local variables
```

1. Function parameters pushed to stack in reverse order.
2. Push EIP return address.
3. prolog: push %ebp
4. prolog: %esp assigned to %ebp
5. Allocate space for local variables (subtract size to %esp)

### procedure epilog
1. Exit procedure
2. clean up stack
3. Pop %ebp
4. %ebp assigned to %esp

## System calls for macOS
```C
#define	SYS_syscall        0
#define	SYS_exit           1
#define	SYS_fork           2
#define	SYS_read           3
#define	SYS_write          4
#define	SYS_open           5
#define	SYS_close          6
#define	SYS_wait4          7
```

## Sources

[http://www.fabiensanglard.net/macosxassembly/index.php]()
[http://www.idryman.org/blog/2014/12/02/writing-64-bit-assembly-on-mac-os-x/]()
[http://insecure.org/stf/smashstack.html]()
[http://www.imada.sdu.dk/Courses/DM18/Litteratur/IntelnATT.htm]()


