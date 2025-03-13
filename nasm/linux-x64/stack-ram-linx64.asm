; Ackermann function (stack array)
; This version hold numbers in RAM
; Change size of stack for larger numbers


global main
extern printf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0


section .bss
	;number of elements on stack
	stack resq 125000000		;1GB
	m resq 1
	n resq 1
    

section .text
main:
	; check for 3 arguments
	cmp rbp, 3
	jne errmsg

	; get first argument
	mov rdi, [rsi+8]
	mov [m], rdi
	; get second argument
	mov rdi, [rsi+16]
	mov [n], rdi

	; convert arg1 to integer
	mov rsi, [m]
	call .strtoull_custom
	mov [m], rax

	; convert arg2 to integer
	mov rsi, [n]
	call .strtoull_custom
	mov [n], rax
	
    mov rdi, [m]
    mov rax, [n]
	
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


errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rdi, error_msg
	
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi
	ret
