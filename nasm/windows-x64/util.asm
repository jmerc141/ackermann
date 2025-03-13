; nasm -f win64 FILE.asm && gcc -Wl,--stack,SIZE -o FILE FILE.obj
; 
; [rdx] or [rbx] = argv on windows
; x86_64-w64-mingw32-gcc:
; 	[rdx] = argv
; 	rbx, rcx, rbp, = argc
; cygwin-gcc:
; 	[rbx], [rdx] = argv
; 	rcx = argc
; golink:
; 	command line args not available
;
; Replace mov with lea faster?
; mov rax, x
; lea rax, [x]


default rel
global main
extern printf

section .data
	msg  db "(%s) (%d) (%d)", 10, 0
	error_msg db "Please run again with 2 parameters", 10, 0
	regs db "rax: %x ", 10, 0, "rbx: %x ", 10, 0, "rcx: %x ", 10, 0, "rdx: %x ", 10, 0, "rbp: %x ", 10, 0, "rsp: %x ", 10, 0, "rsi: %x ", 10, 0, "rdi: %x ", 10, 0, "r8:  %x ", 10, 0, "r9:  %x ", 10, 0, "r10: %x ", 10, 0, "r11: %x ", 10, 0, "r12: %x ", 10, 0, "r13: %x ", 10, 0, "r14: %x ", 10, 0, "r15: %x ", 10, 0
	

section .bss
	arg1 resq 1
	arg2 resq 1
	args resq 256
	res  resq 1


section .text
main:

	call .print
	call .dumpregs
	
	ret
	
	
.print:
	;(rcx)printf(rdx, r8, r9)
	mov rdx, r10
	mov r8,  0
	mov r9,  0
	
	mov rcx, msg
	sub rsp, 32
	call printf
	add rsp, 32
	
	ret


.strtoull_custom:							; rsi = string
    xor rax, rax     ; Clear rax (result)
    xor rcx, rcx     ; Clear rcx (digit)

.convert_loop:
    movzx rcx, byte [rsi]  ; Load the next byte from the string
    test rcx, rcx          ; Check if it is the null terminator
    jz .conversion_done    ; If null terminator, conversion is done
    
    sub rcx, '0'           ; Convert ASCII to integer
    cmp rcx, 9
    ja .conversion_done    ; If not a valid digit, conversion is done
    
    imul rax, rax, 10      ; Multiply result by 10
    add rax, rcx           ; Add the digit to the result
    
    inc rsi                ; Move to the next character
    jmp .convert_loop      ; Repeat the loop

.conversion_done:
    ;mov [res], rax      ; Store the result
    ret


.dumpregs:
	; copy all registers to memory
	mov [args], rax
	mov [args+8*1], rbx
	mov [args+8*2], rcx
	mov [args+8*3], rdx
	mov [args+8*4], rbp
	mov [args+8*5], rsp
	mov [args+8*6], rsi
	mov [args+8*7], rdi
	mov [args+8*8], r8
	mov [args+8*9], r9
	mov [args+8*10], r10
	mov [args+8*11], r11
	mov [args+8*12], r12
	mov [args+8*13], r13
	mov [args+8*14], r14
	mov [args+8*15], r15
	
	; rsi is counter, set to 0
	mov rsi, 0
	; copy regs address to rdi
	mov rdi, regs
	l:		
		mov rcx, rdi			; copy regs address to rcx for printf
		mov r10, args			; copy args address to r10
		mov rdx, [r10+rsi]		; copy args[rsi] to rdx for printf
		
		sub rsp, 32
		call printf
		add rsp, 32
		
		add rdi, 10				; next in string array regs
		add rsi, 8
		cmp rsi, 120
		je .retu
		jle l
		
	ret
	
	
	
.retu:
	xor rdi, rdi
	ret
	
endregs:
	ret

errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rcx, error_msg
	
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi
	ret
	
	