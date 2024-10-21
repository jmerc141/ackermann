; Ackermann function (stack)
; This version uses the program stack to hold numbers
; Change stackinit or stacksize for larger numbers
; golink /console /stackinit 900000h /stacksize 900000h ask.obj /entry _start msvcr100.dll
; F4240h = 1GB


global _start
extern printf
extern scanf

section .data
	inp db "Enter m n: ", 0
	fmt db "%d %llu", 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0 


section .bss
	stack  resq 1
	m   resq 1
	n   resq 1


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

	mov rax, [n]

	call ackermann

	xor rdi, rdi

	ret

ackermann:
	mov [stack], rsp    ;get original stack location
	push qword[m]       ;add 8
	jmp .l1
	ret

.l1:
	cmp rsp, [stack]
	je .stop            ; if stack is empty, stop

	cmp qword[rsp], 0
	jg .cmpres          ; if top of stack > 0, compare result
	je .three           ; if top of stack = 0, got to .three
	ret

.cmpres:
	cmp rax, 0
	jg .one             ; if result > 0, go to .one
	je .two             ; if result = 0, go to .two
	ret

.one:
	push qword[rsp]     ; add rsp, 8
	dec qword[rsp+8]    ; decrement stack[top-1]
	dec rax             ; decrement result
    
	jmp .l1

.two:
	dec qword[rsp]      ; decrement top of stack
	mov rax, 1          ; result = 1
	jmp .l1

.three:
	inc rax         ; result++
	pop r10         ; sub rsp, 8
	jmp .l1


.stop:
	mov rcx, msg
	mov rdx, [m]
	mov r8, [n]
	mov r9, rax
	sub rsp, 32
	call printf
	add rsp, 32
	ret

