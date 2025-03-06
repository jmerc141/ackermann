; Ackermann function (stack array)
; This version hold numbers in RAM
; Change size of stack for larger numbers
; qwords used because of 64bit registers
;	mov byte[stack], rdi fails 8bit <- 64bit

global main
extern printf
extern scanf

section .data
	inp db "Enter m n: ", 0
	fmt db "%d %llu", 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0


section .bss
	;number of elements on stack
	stack resq 125000000		;1GB
	m resq 1
	n resq 1
    

section .text
main:

	;printf
	push rbp
	lea rdi, [inp]
	call printf wrt ..plt
	mov rax, 0
	pop rbp

	;scanf
	sub rsp, 8
	lea rdi, [fmt]
	lea rsi, [m]
	lea rdx, [n]
	mov al, 0
	call scanf wrt ..plt
	add rsp, 8
	
    mov rdi, [m]
    mov rax, [n]
	
    
    ;mov rcx, 8
    ;mov qword[stack + rcx], rdi
    ;jmp .stop
	call ackermann


	;(rdi)printf(rsi, rdx, rcx, r8)
	mov rsi, [m]
	mov rdx, [n]
	mov rcx, rax
	;mov r8,  0
	push rbp
	lea rdi, [msg]
	;lea rsi, [rel msg]
	call printf wrt ..plt
	mov rax, 0
	pop rbp

    mov       rax, 60                 ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit


ackermann:
	add rcx, 8			            ;increment stack counter
    mov qword[stack + rcx], rdi	    ;push m onto stack
	jmp .l1
	ret

.done:
    ret

.l1:
	cmp rcx, 0			        ;if stack is empty
	je .done            		;stop

	cmp qword[stack + rcx], 0
	jg .cmpres          		;if top of stack > 0, compare result
	je .three           		;if top of stack = 0, got to .three

	ret

.cmpres:
	cmp rax, 0
	jg .one             ;if result > 0, go to .one
	je .two             ;if result = 0, go to .two
	ret

.one:
	mov r8, qword[stack + rcx]		;move top of stack to temp register
	mov qword[stack + rcx + 8], r8	;push temp to top of stack
	dec qword[stack + rcx]    		;decrement stack[top-1]
	add rcx, 8						;increment stack counter
	dec rax             			;decrement result
	jmp .l1

.two:
	dec qword[stack + rcx]      	;decrement top of stack
	mov rax, 1          			;result = 1
	jmp .l1

.three:
	inc rax         				;result++
	sub rcx, 8						;decrement stack counter
	jmp .l1


