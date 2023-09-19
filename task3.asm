.model small 
.stack 100h

.data
string1 db "Enter first number: $"
string2 db " Enter second number: $"	;strings for user ease
string3 db "Odd: $"
string4 db "Even: $"
temp dw 0				;temporary variable
num1 dw 0 
num2 dw 0 				;range for even and odd numbers
numcount dw 0
count1 db 0				;counters
sum dw 0

.code
main proc
mov ax, @data
mov ds, ax

lea dx, string1 	;loading effective address for 1st string
mov ah, 09
int 21h
inputnum1:
mov ah, 01			;inputting 1st number
int 21h
cmp al, 13			;stopping iput on pressing enter	
je stopnum1
sub al,48
mov ah, 0
mov temp,ax
mov ax,0
mov ax,num1
mov bl, 10
mul bl				;multipling number by 10 and adding in temporary ones
add ax,temp
mov num1, ax
jmp inputnum1
stopnum1:
mov ax,0
mov temp,ax
mov dl, 10
mov ah, 2h
int 21h				;new line & carriage return
mov dl, 13
mov ah, 2h
int 21h

lea dx, string2		;loading effective address for 2nd string
mov ah,09
int 21h
inputnum2:
mov ah,01			;inputting 1st number
int 21h
cmp al,13			;stopping iput on pressing enter
je stopnum2
sub al,48
mov ah,0
mov temp,ax
mov ax,0
mov ax,num2
mov bl,10
mul bl				;multipling number by 10 and adding in temporary ones
add ax,temp
mov num2,ax
jmp inputnum2
stopnum2:
mov ax,0
mov temp,ax
mov dl, 10
mov ah, 2h
int 21h				;new line & carriage return
mov dl, 13
mov ah, 2h
int 21h

mov cx, 2			;moving 2 in counter register
loops:				;bcz loop runs 2 times(1 for even & 1 for odd)
    mov numcount,cx 
    mov ax,num1		
    mov bx,2		
    div bl			;dividing num by 2 to check even or odd
    cmp ah,1		;comparing remainder (o for even & 1 for odd)
    jne evens
    lea dx,string3
    mov ah,09		;Odd
    int 21h
    jmp print
    evens:
    lea dx, string4
    mov ah,09		;Even
    int 21h
    print:			;Printing values
    mov cx,num1
	mov sum,0
    loops2:
	mov dx,'+'
	mov ah,02
	int 21h
    mov count1,0
    mov ax, cx
    in_stack:
    mov bx, 10
    mov dx, 0		;Pushing values in stack digit by digit
    div bx
	push dx
    inc count1		;incrementing counter
    cmp ax,0
    ja in_stack
    out_stack:
    pop dx			;poping values out of stack digit by digit
    add dx,48
    mov ah, 02
    int 21h
    dec count1		;decrementing counter
    cmp count1, 0
    jne out_stack
	add sum,cx
	add cx,2
	cmp cx,num2
	jbe loops2
    mov dx, '='
    mov ah, 02		;printing '=' for saperating sum from addition
    int 21h
	mov count1,0
	mov ax,sum
	sum_instack:
	mov bx,10		;pushing sum in stack digit by digit
	mov dx,0
	div bx
	push dx
	inc count1		;incrementing counter to keep track
	cmp ax,0
	ja sum_instack
	sum_outstack:
	pop dx			;poping sum from stack digit by digit
	add dx,48
	mov ah,02
	int 21h
	dec count1		;decrementing counter to keep track
	cmp count1,0
	jne sum_outstack
    add num1, 1		;adding 1 to change even to odd or odd to even
    mov cx,numcount
    mov dx, 10
    mov ah, 02
    int 21h			;new line and carriage return
    mov dx, 13
    mov ah, 02
    int 21h
	dec cx
	cmp cx,0
jne loops

mov ah, 4ch			;terminating programe
int 21h

main endp 			;ending main function
end main

