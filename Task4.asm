.model small
.stack 100h
.data
string1 db "Enter first number : $"
string2 db "Enter second number: $"
string3 db "Enter third number: $"
string4 db "Acsending order: $"		;declaring strings for user ease
string5 db "Descending order: $"
num1 db ?
num2 db ?							;declaring variables
num3 db ?
.code
main proc							;initializing main procedure

mov ax,@data
mov ds,ax

lea dx,string1
mov ah,09
int 21h
mov ah,01						
int 21h
mov num1,al							;getting input for first number
sub num1,30h
mov dl,10							;New line
mov ah,02
int 21h
mov dl,13							;Carriage return
mov ah,01
int 21h

lea dx,string2
mov ah,09
int 21h
mov ah,01				;getting input for 2nd number
int 21h
mov num2,al
sub num2,30h
mov dl,10				;New line
mov ah,02
int 21h
mov dl,13				;Carriage return
mov ah,01
int 21h

lea dx,string3
mov ah,09
int 21h
mov ah,01				;getting input for 2nd number
int 21h
mov num3,al
sub num3,30h
mov dl,10				;New line
mov ah,02
int 21h
mov dl,13				;Carriage return
mov ah,01
int 21h

mov al,num2
cmp num3,al
jae check1				;jumping if num3 >= num2
mov bl,num3
mov num2,bl
mov num3,al				;swapping num2 & num3
check1:
mov al,num1
cmp num2,al
jae check2				;jumping if num2 >=num1
mov bl,num2
mov num1,bl
mov num2,al				;swapping num1 & num2
check2:
mov al,num2
cmp num3,al
jae check3				;jumping if num3 >= num2 again
mov bl,num3
mov num2,bl
mov num3,al				;swapping num3 & num2
check3:
lea dx,string4
mov ah,09
int 21h
mov dl,10
mov ah,02				;new line & carriage return
int 21h
mov dl,13
mov ah,02
int 21h

mov dl,num1
add dl,30h
mov ah,02
int 21h

mov dl,'<'
mov ah,02
int 21h

mov dl,num2				;Displaing all digits in ascending order
add dl,30h
mov ah,02
int 21h

mov dl,'<'
mov ah,02
int 21h

mov dl,num3
mov ah,02
add dl,30h
int 21h

mov al,num1				;Swapping num1 & num3
mov bl,num3				;for converting 
mov num1,bl				;ascending order into
mov num3,al				;descending order

mov dl,10
mov ah,02
int 21h
mov dl,13
mov ah,02
int 21h


lea dx,string5
mov ah,09
int 21h
mov dl,10
mov ah,02
int 21h
mov dl,13
mov ah,02
int 21h

mov dl,num1
add dl,30h
mov ah,02
int 21h

mov dl,'>'
mov ah,02
int 21h

mov dl,num2
add dl,30h				;Displaing all digits in descending order
mov ah,02
int 21h

mov dl,'>'
mov ah,02
int 21h

mov dl,num3
mov ah,02
add dl,30h
int 21h

mov ah,4ch				;Terminating code
int 21h

main endp				;Ending main function
end main