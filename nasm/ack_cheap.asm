; Cheap ackermann implementation

global _start
extern printf
extern scanf

section .data
	inp db "Enter m n: ", 0
	fmt db "%d %llu", 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0 

section .bss
	result resq 1
	m resq 1
	n resq 1


section .text
;Basically cannot get command line parameters on Windows 64 bit
_start:

	;printf
	mov rcx, inp
	sub rsp, 32
	call printf
	add rsp, 32

	; scanf
	mov rcx, fmt
	mov rdx, m
	mov r8, n
	sub rsp, 32
	call scanf
	add rsp, 32

	mov rdi, [m]
	mov rsi, [n]

	call ackermann

	;result is in rax

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
	je .zero

	cmp rdi, 1
	je .one
	
	cmp rdi, 2
	je .two

	cmp rdi, 3
	je .three

	cmp rdi, 4
	je .four

	cmp rdi, 5
	je .five

	ret

.zero:
	inc rsi
	mov rax, rsi
	ret

.one:
	add rsi, 2		; n=n+2
	mov rax, rsi		; return n
	ret

.two:
	mov rax, 2		; rax=2
	mul rsi			; rax * n
	add rax, 3		; return (rax + 3)
	ret

.three:
	mov rax, 2		; rax=2
	mov rbx, 2		; rbx=2
	add rsi, 2		; n = n + 3 not sure why 2
	mov rcx, rsi		; tmp = n
	call .exp		; 2^n
	sub rax, 3		; rax - 3
	ret

.four:
	;(4,2)
	mov rax, 2
	mov rbx, 2
	
	cmp rsi, 0
	je .fourzero
	
	cmp rsi, 1
	je .fourone
	
	ret

.fourzero:
	inc rsi
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	sub rax, 3
	ret

;really dumb but gets the right answer
.fourone:
	mov rax, 1
	mov rcx, rax
	call .exp
	mov rbx, 2
	mov rcx, rax
	call .exp
	mov rcx, rax
	call .exp
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	mov rcx, rsi
	call .exp
	sub rax, 3
	ret

.five:
	ret

.exp:
	mul rbx
	loop .exp
	ret
