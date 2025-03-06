; Linux 64 bit
; [rsp] or rbp or rdi = argc
; [rsi+8] = argv[1] as string
; Could not get command line arguments to work,
; need to convert string to integer

global main
extern printf
extern scanf


section .data
	inp: db "Enter m n: ", 0
	fmt: db "%d %llu", 0
	msg: db "Ackermann(%d, %llu) = %llu", 10

section .bss
	result resq 1
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
	
	mov rdi, [m]
	mov rsi, [n]
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

; ackerman(rdi, rsi) -> rax
ackermann:
	;Base case if m==0, return n+1
	cmp rdi, 0
	je .case_one
	jne .check_second
	ret

.case_one:
	inc rsi
	mov rax, rsi
	ret

.check_second:
	;if n==0 call ackermann(m-1,1)
	cmp rsi, 0
	je .case2
	jne .case3
	ret

.case2:
	dec rdi							;m=m-1
	mov rsi, 1						;n=1
	call ackermann
	ret

.case3:
	;Call ackermann(m,n-1)
	push rdi						;save m
	dec rsi							;n = n-1
	call ackermann

	;Call ackermann(m-1,result)
	pop rdi							;restore m
	dec rdi							;m=m-1
	mov rsi, rax					;n=result from ackermann(m, n-1)
	call ackermann
	ret

