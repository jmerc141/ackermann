; Linux 64 bit recursive version
; 

default rel
global main
extern printf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg: db "Ackermann(%d, %llu) = %llu", 10

section .bss
	m   resq 1
	n   resq 1

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


errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rdi, error_msg
	
	push rbp
	call printf
	pop rbp

	xor rdi, rdi
	ret