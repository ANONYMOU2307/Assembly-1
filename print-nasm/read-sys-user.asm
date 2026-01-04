section .bss
buffer resb 32

section .text
global _start

_start:

xor rax, rax
xor rdi, rdi
mov rsi, buffer
mov rdx, 32
syscall

xor r8, r8
xor rax, rax
movzx rbx, byte [rsi]


cmp rbx, 0x2d
jne .start

mov r8, 1
inc rsi
movzx rbx, byte [rsi]

.start:
cmp rbx, 0x30
jl .over
cmp rbx, 0x39
jg .over

.convert_loop:
movzx rbx, byte [rsi]

cmp rbx, 10
je .done
cmp rbx, 0
je .done

cmp rbx, 0x30
jl .over
cmp rbx, 0x39
jg .over

sub rbx, '0'

imul rax, rax, 10
jo .over
add rax, rbx
jo .over
inc rsi

jmp .convert_loop

.done:

mov rdi, buffer + 30
mov [rdi+1], 10
mov rbx, 10


.convert_loop2:
xor rdx, rdx
div rbx
add dl, 0x30
mov [rdi], dl
dec rdi
test rax, rax
jnz .convert_loop2

cmp r8, 1
jne .over1
mov [rdi], 0x2D
dec rdi

.over1:
inc rdi
mov rdx, buffer+32
mov rsi, rdi
sub rdx, rsi

mov rax, 1
mov rdi, 1
syscall


.over:
mov rax, 60
mov rdi, 0
syscall
