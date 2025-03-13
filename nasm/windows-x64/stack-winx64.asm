; Ackermann function (stack)
; This version uses the program stack to hold numbers


default rel
global main
extern printf
extern scanf

section .data
	error_msg db "Please run again with 2 parameters", 10, 0
	msg db "Ackermann(%d, %llu) = %llu", 10, 0 


section .bss
	stack  resq 1
	m   resq 1
	n   resq 1


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

	mov rax, [n]

	call ackermann

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

errmsg:
	;printf(rcx, rdx, r8, r9)
	mov rcx, error_msg
	
	sub rsp, 32
	call printf
	add rsp, 32

	xor rdi, rdi
	ret