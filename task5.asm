.model small
.stack 100h

.data
string1 db "Enter your 1st number: $"
string2 db "Enter your 2nd number: $"			;strings for user ease
string3 db "Enter your 3rd number: $"
string4 db "Maximum: $"
string5 db "Minimum: $"
temp dw 0
num1 dw 0
count1 db 0										;counters and numbers for user input
num2 dw 0
count2 db 0
num3 dw 0
count3 db 0

.code
main proc
mov ax,@data
mov ds,ax

lea dx,string1
mov ah,09
int 21h
input1:
mov ah,01							;taking input for 1st number			
int 21h
cmp al,13							;stoping input at pressing enter
je stop1
sub al,30h
mov ah,0
mov temp,ax
mov ax,0
mov ax,num1
mov bl,10
mul bl
add ax,temp
mov num1,ax
inc count1							;incrementing count for total digits in 1st number
jmp input1
stop1:
mov ax,0
mov temp,ax
mov dl,10
mov ah,02
int 21h								;stoping inputing and new line + carriage return
mov dl,13
mov ah,02
int 21h

lea dx,string2
mov ah,09
int 21h
input2:
mov ah,01							;taking input for 2nd number
int 21h
cmp al,13							;stoping input at pressing enter
je stop2
sub al,30h
mov ah,0
mov temp,ax
mov ax,0
mov ax,num2
mov bl,10
mul bl
add ax,temp
mov num2,ax
inc count2							;incrementing count for total digits in 2nd number
jmp input2
stop2:
mov ax,0
mov temp,ax
mov dl,10
mov ah,02
int 21h								;stoping inputing and new line + carriage return
mov dl,13
mov ah,02
int 21h

lea dx,string3
mov ah,09
int 21h
input3:
mov ah,01							;taking input for 3rd number
int 21h
cmp al,13							;stoping input at pressing enter
je stop3
sub al,30h
mov ah,0
mov temp,ax
mov ax,0
mov ax,num3
mov bl,10
mul bl
add ax,temp
mov num3,ax
inc count3							;incrementing count for total digits in 3rd number
jmp input3
stop3:
mov ax,0
mov temp,ax
mov dl,10
mov ah,02
int 21h								;stoping inputing and new line + carriage return
mov dl,13
mov ah,02
int 21h

mov ax,num2
cmp num3,ax							;comparing num2 & num3
je loop1
mov bx,num3
mov num2,bx
mov num3,ax							;swapping num2 & num3
mov al,count2
mov bl,count3
mov count2,bl
mov count3,al						;swapping counters for num2 & num3
loop1:

mov ax, num1
cmp num2, ax						;comapring num1 & num2
jae loop2 
mov bx, num2
mov num1, bx
mov num2, ax						;swapping ..// 
mov al, count1
mov bl, count2
mov count1, bl
mov count2, al						;swappong counters ..//
loop2:

mov ax, num2 
cmp num3, ax					;again comoaring num2 & num3
jae loop3
mov bx, num3 
mov num2, bx
mov num3, ax 					;swapping again..//
mov al, count2
mov bl, count3
mov count2, bl
mov count3, al					;swapping counters ..//
loop3:

lea dx,string4
mov ah,09						;Maximum number
int 21h
mov al,count3
mov cl,al
stop4:
cmp count3,0					;running loop until counter 3 != 0
je display_max
dec count3						;decrementing counter 3
mov ax,num3
mov bl,10
div bl
mov dx,0
mov dl,ah
push dx							;pushing maximum num in stack digit by digit
mov ah,0
mov num3,ax
jmp stop4
display_max:
cmp cl,0
je loop4
dec cl
pop dx							;poping maximum num from stack digit by digit and adding 48
add dl,30h
mov ah,02
int 21h
jmp display_max
loop4:
mov temp,ax
mov dl,10
mov ah,02
int 21h							;new line and carriage return
mov dl,13
mov ah,02
int 21h

lea dx,string5					;Minimum number
mov ah,09
int 21h
mov al,count1
mov cl,al
stop5:
cmp count1,0					;running loop until counter 1 != 0
je display_min
dec count1						;decrementing counter 1
mov ax,num1
mov bl,10
div bl
mov dx,0
mov dl,ah
push dx							;pushing minimum num in stack digit by digit
mov ah,0
mov num1,ax
jmp stop5
display_min:
cmp cl,0
je loop5
dec cl
pop dx							;poping minimum num from stack digit by digit and adding 48
add dl,30h
mov ah,02
int 21h
jmp display_min
loop5:
mov temp,ax
mov dl,10
mov ah,02
int 21h							;new line and carriage return
mov dl,13
mov ah,02
int 21h

Exit:
mov ah,4ch						;function ending or terminating label
int 21h

main endp
end main