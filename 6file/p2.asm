section .data

count : db 0
scount : dw 0
ncount : dw 0
ccount : dw 0

section .bss
result : resb 5
char : resb 2

global space , newline ,charac
extern buffer,size

%macro scall 4
	mov rax ,%1
	mov rdi ,%2
	mov rsi ,%3
	mov rdx ,%4
	syscall
%endmacro


section .text
global main_2

space:
	mov rcx,[size]
	mov rsi,buffer
	up1:
		cmp byte[rsi],20h
		jne next1 
		inc word[scount]
		next1:
		inc rsi
	loop up1
	mov ax,[scount]
	call htoa
ret

newline:
	mov rcx,[size]
	mov rsi,buffer
	up2:
		cmp byte[rsi],10
		jne next2 
		inc word[ncount]
		next2:
		inc rsi
	loop up2
	mov ax,[ncount]
	call htoa
ret

charac:
scall 0,1,char,2 
mov dl,byte[char]
	mov rcx,[size]
	mov rsi,buffer
	up3:
		cmp byte[rsi],dl
		jne next3 
		inc word[ccount]
		next3:
		inc rsi
	loop up3
	mov ax,[ccount]
	call htoa

ret


htoa:
mov rdi,result
mov byte[count],4
up:
	rol ax,4
	mov cl,al
	and cl,0x0F
	cmp cl,9
	jbe next
	add cl,7
	next: 
	add cl,30H
	mov byte[rdi],cl
	inc rdi
	dec byte[count]
jnz up
	mov byte[rdi],10
	scall 1,1,result,5
ret

scall 60,0,0,0
