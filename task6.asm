.model small
.stack 100h
.data 
string1 db "Enter price of item: $"
string2 db "Total amount: $"		;strings for user ease
number dw 0
temp dw 0
count1 dw 0							;declaring variables and counters
numcount dw 0
sum dw 0
.code
main proc
mov ax,@data
mov ds,ax
mov cx,5
loops:
lea dx,string1			;loading effective address of string1
mov ah,09
int 21h
input:
mov ah,01				;taking input
int 21h
cmp al,13				;stoping inputing at pressing enter
je stop
sub al,48
mov ah,0
mov temp,ax
mov ax,0
mov bx,0
mov ax,number
mov bl,10						
mul bl					;multiplying number by 10 and adding it in temporary variable
add ax,temp			
mov number,ax
inc bx
jmp input
stop:
mov ax,0
mov temp,ax
mov dl,10
mov ah,02
int 21h					;new line an d carriage return
mov dl,13
mov ah,02
int 21h
mov ax,number			
add sum,ax				;adding number to sum
mov number, 0
loop loops				;loop repeats 5 times


lea dx,string2			;loading effective address of string2
mov ah,09
int 21h

mov count1,0
mov ax,sum
l1:
mov temp,ax				;moving sum in a temporary variable
mov bx,10
mov dx,0
div bx
inc count1
push dx					;Pushing in stack digit by digit
cmp temp,0
ja l1
pop dx
dec count1
l2:
pop dx					;poping values digit y digit and adding 48
add dx,48
mov ah,02
int 21h
dec count1				;decrementing counter to keep track
cmp count1,0
ja l2
mov ah,4ch				;terminating programe
int 21h
main endp
end main