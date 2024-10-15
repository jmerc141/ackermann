; Ackermann function (recursive)
; nasm -f win64 ack.asm
; golink /console ask.obj /entry _start msvcr100.dll

global  _start
extern  printf


section .data
	msg  db "Ackermann(%d, %llu) = %llu", 10, 0 
	m    dq 4
	n    dq 1


section .bss
	result resq 1


section .text
;Basically cannot get command line parameters on Windows 64 bit
_start:
	mov rdi, [m]
	mov rsi, [n]

	call ackermann

	;printf(rcx, rdx, r8, r9)
	mov rcx, msg
	mov rdx, [m]
	mov r8, [n]
	mov r9, rax
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi

	ret

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

