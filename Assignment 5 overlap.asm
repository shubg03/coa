data segment
msg1 db 10,13, "Enter A Number$"
msg2 db 10,13, "No is:$"
No db 05h dup(0)
No1 db 05h dup(0)
msg3 db 10,13, "Enter an Index for overlapping$"
over db 30h
temp db 30h
n db 30h
n1 db 30h
data ends

code segment
assume cs:code, ds:data
start:
mov ax, data
mov ds, ax


mov si,0000h
up:
lea dx,msg1
mov ah,09h
int 21h
call take
mov[no+si],bh
inc si
inc[n]
cmp[n], 34h
jbe up


lea dx, msg3
mov ah, 09h
int 21h
mov ah, 01h
int 21h
sub al, 30h

mov [over], al
mov bl, 05h
sub bl, [over]
mov [temp], bl 


mov si, 0000h
mov di, 0000h


loop1: 	mov al, [no+si]
	mov [no1+di], al
	inc si
	inc di
	dec [over]
	jnz loop1

mov si, 0000h
loop2: mov al, [no+si]
	mov [no1+di], al
	inc si
	inc di
	dec [temp]
	jnz loop2


mov di, 0000h
up1:lea dx,msg2
mov ah,09h
int 21h
mov bh,[no1+di]
call display
inc [n1]
inc di
cmp [n1],34h
jbe up1


mov ah,04ch
int 21h

take proc near
	mov ah, 01h
	int 21h
	cmp al,39h
        jbe down
	sub al,07h
down: 	sub al, 30h
	mov cl,04h
	rol al,cl
	mov bh, al

	mov ah, 01h
	int 21h
	cmp al,39h
	jbe down1
	sub al,07h
down1: 	sub al,30h
	add bh,al
ret
take endp

display proc near
	mov ch,bh
	and ch,0f0h
	mov cl,04h
	rol ch,cl
	cmp ch,09h
	jbe down2
	add ch,07h
down2: 	add ch,30h
	mov dl,ch
	mov ah,02h
	int 21h

	mov ch,bh
	and ch,0fh
	cmp ch,09h
	jbe down3
	add ch,07h
down3: 	add ch,30h
	mov dl,ch
	mov ah,02h
	int 21h
ret
display endp

code ends
end start