; Cheap ackermann implementation, linux64

global main
extern printf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0 

section .bss
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
	mov rsi, [n]

	call ackermann

	;result is in rax

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

	ret
    ;mov       rax, 60                 ; system call for exit
    ;xor       rdi, rdi                ; exit code 0
    ;syscall                           ; invoke operating system to exit
	

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
	add rsi, 2		    ; n=n+2
	mov rax, rsi		; return n
	ret

.two:
	mov rax, 2		    ; rax=2
	mul rsi			    ; rax * n
	add rax, 3		    ; return (rax + 3)
	ret

.three:
	mov rax, 2		    ; rax=2
	mov rbx, 2		    ; rbx=2
	add rsi, 2		    ; n = n + 3 not sure why 2
	mov rcx, rsi		; tmp = n
	call .exp		    ; 2^n
	sub rax, 3		    ; rax - 3
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


errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rdi, error_msg
	
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi
	ret