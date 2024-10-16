; Ackermann function (memoization)
; /stackinit 900000h /stacksize 900000h

global  _start
extern  printf
;global x

section .data
	msg db "Ackermann(%lu, %llu) = %llu", 10, 0
	m   dq 0
	n   dq 176259065
	;18446744073709551615

section .bss
	;2D array
	arr2 resq 1250000000
	         ;1250000000 = 1GB RAM


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

