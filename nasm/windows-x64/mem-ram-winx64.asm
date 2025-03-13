; Ackermann function (memoization)
; This is the memo RAM version
; Change arr2 size for larger numbers

default rel
global main
extern printf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0

section .bss
	m resq 1
	n resq 1
	;2D array
	arr2 resq 1250000000
	         ;1250000000 = 1GB RAM

section .text
main:
	
	; check for 3 arguments
	cmp rcx, 3
	jne errmsg

	; get first argument
	mov rdi, [rdx+8]
	mov [m], rdi
	; get second argument
	mov rdi, [rdx+16]
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
	;Check if in arr
	mov r10, arr2			;point to array

	mov r11, rdi			;m
	mov rbx, rsi			;n

	imul r11, 24			;64-bit
	imul rbx, 8				;64-bit

	add r10, r11			;add col
	add r10, rbx			;add row
							;[r10] is value at (m, n)
	
	cmp qword[r10], 0		;if (m, n) does not exist in arr
	jne .return				;return result

	;Base case if m==0, return n+1
	cmp rdi, 0
	je .case_one
    jne .check_second
	mov qword[r10], rax
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

.return:
	ret

errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rcx, error_msg
	
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi
	ret
