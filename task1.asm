.model small
.stack 100h
.data
string1 db "Enter number for factorial: $"		;strings for user ease
string2 db "Factorial is: $"
num dw 0
temp dw 0
result dw 0
count1 db 0			;counters & variables
count2 db 0
.code
main proc
mov ax,@data
mov ds,ax
lea dx,string1		;loading effective address of 1st string
mov ah,09
int 21h
input:
mov ah,01			;inputting 1st number
int 21h
cmp al,13			;taking input until Enter ids pressed
je stop
sub al,48
mov ah,0
mov temp,ax
mov ax,0
mov ax,num
mov bx,10			;multiplying number by 10 and adding it to temporary
mul bl
add ax,temp
mov num,ax
inc count1			;incrementing count to keep track
jmp input

stop:
mov ax,0
mov temp,ax
mov dl,10
mov ah,02
int 21h				;new line and carriage return
mov dl,13
mov ah,02
int 21h

mov ax,num
mov temp,ax			;moving number to temporary variable
multiply:
dec temp
cmp temp,0			;multiplying number with its decrements
je factorial
mov dx,0			; untill number is zero
mov bx,temp
mul bx
jmp multiply
factorial:
mov result,ax		;moving answer to result variable
lea dx,string2
mov ah,02
int 21h
mov count2,0
mov ax,result
in_stack:
mov bx,10
mov dx,0			;pushing result into stack digit by digit
div bx
push dx				
inc count2			;incrementing 2nd counter to keep track of digits
cmp ax,0
ja in_stack
out_stack:
pop dx				;poping result out of stack and adding 48
add dx,48
mov ah,02
int 21h
dec count2			;decrementing count to print same digigts(of result)
cmp count2,0
jne out_stack
exit:				;exiting programe or terminating label
mov ah,4ch
int 21h
main endp
end main