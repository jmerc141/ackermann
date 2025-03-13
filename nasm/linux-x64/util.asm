; nasm -f elf64 FILE.asm && gcc -no-pie -Wl,-z,stack-size=9437184 -o util util.o
; 
; [rsp], rbp, rdi = argc
; [rsi+n], [rbx+n] = argv[n] as string
; [rdx+n] = 16 enviroment variables


global main
extern printf

section .data
	msg  db "(%d) (%s) (%x)", 10, 0
	error_msg db "Please run again with 2 parameters", 10, 0
	regs db "rax: %x ", 10, 0, "rbx: %x ", 10, 0, "rcx: %x ", 10, 0, "rdx: %x ", 10, 0, "rbp: %x ", 10, 0, "rsp: %x ", 10, 0, "rsi: %x ", 10, 0, "rdi: %x ", 10, 0, "r8:  %x ", 10, 0, "r9:  %x ", 10, 0, "r10: %x ", 10, 0, "r11: %x ", 10, 0, "r12: %x ", 10, 0, "r13: %x ", 10, 0, "r14: %x ", 10, 0, "r15: %x ", 10, 0
	

section .bss
	arg1 resq 1
	arg2 resq 1
	args resq 256


section .text
main:

	push rbp
	call .dumpregs
	pop rbp

	ret

	;mov       rax, 60                 ; system call for exit
    ;xor       rdi, rdi                ; exit code 0
    ;syscall                           ; invoke operating system to exit

	
	
.print:
	;(rdi)printf(rsi, rdx, rcx, r8)
	;mov rsi, rax
	;mov rdx, rbx
	;mov rcx, r8
	
	push rbp
	lea rdi, [msg]
	call printf wrt ..plt
	mov rax, 0
	pop rbp
	
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
	
	; calling print messes up these registers:
	; rcx, r8, r9, r10, r11
	; rax, rsi, rdi, rbp are used
	mov rbx, 0
	mov r12, 0

	l:
		push rbp
		lea rdi, [regs+rbx]
		mov rsi, [args+r12]
		call printf wrt ..plt
		mov rax, 0
		pop rbp
		
		add rbx, 10				; next in string array regs
		add r12, 8

		cmp rdx, 120
		je .retu
		jl l

	
.retu:
	xor rdi, rdi
	ret
	
endregs:
	ret

errmsg:
	lea rdi, [error_msg]
	push rbp
	call printf
	pop rbp

	xor rdi, rdi
	ret
	
	