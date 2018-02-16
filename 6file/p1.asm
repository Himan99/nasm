section .data
fname : db 'a.txt',0
size : dq 1346
msg1: db "Cannot opent file ;) ",10
len1 : equ $-msg1
msg2 :  db "File opened",10
len2 : equ $-msg2

section .bss
fd_in : resq 1
buffer : resb 1400

global buffer,size
extern space , newline ,charac

%macro scall 4
	mov rax ,%1
	mov rdi ,%2
	mov rsi ,%3
	mov rdx ,%4
	syscall
%endmacro

section  .text
global main
scall 2,fname,2,0777
mov [fd_in],rax
bt rax,63
jc err

scall 1,1,msg2,len2
scall 0,[fd_in],buffer,1400
mov [size],rax

call space
call newline
call charac

;scall 1,1,buffer,size

scall 3,[fd_in],0,0
jmp exit
err:
scall 1,1,msg1,len1


exit:
scall 60,0,0,0
