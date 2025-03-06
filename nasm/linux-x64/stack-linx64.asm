; Ackermann function (stack)
; This version uses the program stack to hold numbers
; For some reason pushing and poppong caused a seg fault
; 


global main
extern printf
extern scanf

section .data
	inp db "Enter m n: ", 0
	fmt db "%d %llu", 0
	msg db "Ackermann(%llu, %llu) = %llu", 10, 0 


section .bss
	stack  resq 1
	m   resq 1
	n   resq 1


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

	mov rax, [n]

	call ackermann

    ;(rdi)printf(rsi, rdx, rcx, r8)
	mov rsi, [m]
	mov rdx, [n]
	mov rcx, rax
	push rbp
	lea rdi, [msg]
	call printf wrt ..plt
	mov rax, 0
	pop rbp

    mov       rax, 60                 ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit
	

ackermann:
    mov [stack], rsp
    push qword[m]
	jmp .l1
	ret

.done:
    ret

.l1:
	cmp rsp, [stack]
	je .done                ; if stack is empty, stop

	cmp qword[rsp], 0
	jg .cmpres                  ; if top of stack > 0, compare result
	je .three                   ; if top of stack = 0, got to .three
	ret

.cmpres:
	cmp rax, 0
	jg .one                     ; if result > 0, go to .one
	je .two                     ; if result = 0, go to .two
	ret

.one:
	push qword[rsp]
    dec qword[rsp + 8]
    dec rax
   
	jmp .l1

.two:
	dec qword[rsp]      ; decrement top of stack
	mov rax, 1                  ; result = 1
	jmp .l1

.three:
	inc rax         	; result++
	pop r8         	; sub rsp, 8
    
	jmp .l1



	

