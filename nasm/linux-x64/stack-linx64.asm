; Ackermann function (stack)
; This version uses the program stack to hold numbers
; For some reason pushing and poppong caused a seg fault
; 


global main
extern printf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg db "Ackermann(%llu, %llu) = %llu", 10, 0 


section .bss
	stack  resq 1
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

	mov rax, [n]

	call ackermann

    ;(rdi)printf(rsi, rdx, rcx, r8)
	mov rsi, [m]
	mov rdx, [n]
	mov rcx, rax
	push rbp
	lea rdi, [msg]
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
    mov [stack], rsp
    push qword[m]
	jmp .l1
	ret

.done:
    ret

.l1:
	cmp rsp, [stack]
	je .done                ; if stack is empty, stop

	cmp qword[rsp], 0
	jg .cmpres                  ; if top of stack > 0, compare result
	je .three                   ; if top of stack = 0, got to .three
	ret

.cmpres:
	cmp rax, 0
	jg .one                     ; if result > 0, go to .one
	je .two                     ; if result = 0, go to .two
	ret

.one:
	push qword[rsp]
    dec qword[rsp + 8]
    dec rax
   
	jmp .l1

.two:
	dec qword[rsp]      ; decrement top of stack
	mov rax, 1                  ; result = 1
	jmp .l1

.three:
	inc rax         	; result++
	pop r8         	; sub rsp, 8
    
	jmp .l1


errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rdi, error_msg
	
	push rbp
	call printf
	pop rbp

	xor rdi, rdi
	ret
