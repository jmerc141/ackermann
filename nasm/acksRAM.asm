; Ackermann function (stack array)
; This version hold numbers in RAM
; Change size of stack for larger numbers
; qwords used because of 64bit registers
;	mov byte[stack], rdi fails 8bit <- 64bit

global  _start
extern  printf

section .data
	msg  db "Ackermann(%d, %llu) = %llu", 10, 0
	m    dq 3
	n    dq 20


section .bss
	;number of elements on stack
	stack resq 12500000		;1GB
    


section .text
;Basically cannot get command line parameters on Windows 64 bit
_start:
	mov rdi, [m]
	mov rax, [n]
	
	mov rcx, 0
	

	call ackermann


    xor rdi, rdi

    ret

ackermann:
	add rcx, 8			;increment stack counter
	mov qword[stack + rcx], rdi	;push m onto stack
	jmp .l1
	ret

.l1:
	cmp rcx, 0			;if stack is empty
	je .stop            		;stop

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
	mov rsi, qword[stack + rcx]		;move top of stack to temp register
	mov qword[stack + rcx + 8], rsi	;push temp to top of stack
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


.stop:
	mov rcx, msg
	mov rdx, [m]
	mov r8, [n]
	mov r9, rax
	sub rsp, 32
	call printf
	add rsp, 32
	ret

