section .bss
	buffer resb 32

section .text
	global _start

_start:
	mov rax, -10
	mov rdi, buffer+30
	mov rbx, 10
	mov byte [rdi + 1], 10
	xor r8, r8
	
	cmp rax, 0
		jge convert_loop
		mov r8, rax
		neg rax

	convert_loop:
		
		xor rdx, rdx
		div rbx
		add dl, 0x30
		mov [rdi], dl
		dec rdi
		test rax, rax
			jnz convert_loop
	cmp r8, 0
		jge done
		
	mov [rdi], 0x2D
	dec rdi
	

	done:
	inc rdi
	mov rdx, buffer+32
	mov rsi, rdi
	
	sub rdx, rdi

	mov rax, 1
	mov rdi, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
