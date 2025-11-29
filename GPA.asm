.MODEL small
.STACK 100h

.DATA

msg_subjects    db "Enter number of subjects (1-9): $"
msg_grade       db 10,"Enter grade (0-100): $"
msg_error       db 10,"Invalid input! Try again.",10,13,'$'
msg_final       db 10,13,"--- Final Result ---$"
msg_degree      db 10,"Final Average Grade: $"
msg_status      db 10,"Academic Status: $"
Sign_           db "%",'$'


msg_excellent   db "Excellent! $"
msg_vgood       db "Very Good $"
msg_good        db "Good $"
msg_clean_pass  db "Pass (No Fails) $"        
msg_fail        db "Fail (Repeat Year) $"
msg_carry_prefix db "Pass and Promoted with $" 
msg_carry_suffix db " Subject(s) $" 

num_subjects    db ?                       
grade_input     db ?                        
sum_grades      dw 0                        
fail_count      db 0                       


buffer_grade    db 3                        ; Max input size (3 chars for '100')
                db 0                       
                db 3 dup(?)                

.CODE
MAIN PROC
    mov ax, @data
    mov ds, ax

ask_subjects:
    
    mov dx, offset msg_subjects
    mov ah, 09h
    int 21h

   
    mov ah, 01h
    int 21h
    sub al, '0' 
    
    ; Validate range (1 to 9)
    cmp al, 1
    jb ask_subjects 
    cmp al, 9
    ja ask_subjects 

    mov num_subjects, al
    mov cl, 0       
read_loop:
    mov al, num_subjects
    xor ah, ah
    cmp cl, al     
    jl read_grade_continue 
    jmp calc_and_print     

read_grade_continue:
    
ask_grade: 
    mov dx, offset msg_grade
    mov ah, 09h
    int 21h

    ; Read input string into buffer_grade
    mov ah, 0Ah
    mov dx, offset buffer_grade
    int 21h

    push cx 

    mov cl, buffer_grade+1
    ; Check length (1 to 3 digits)
    cmp cl, 1
    jb invalid_grade
    cmp cl, 3
    ja invalid_grade

    xor ax, ax     
    mov si, offset buffer_grade+2 

convert_loop:
    mov bl, [si]   
    ; Check if character is a digit
    cmp bl, '0'
    jb invalid_grade_pop
    cmp bl, '9'
    ja invalid_grade_pop

    sub bl, '0'     ; Convert ASCII to numeric (BL holds the digit)
    mov bh, 0

    ; Calculate AX = (AX * 10) + digit
    mov dx, ax     
    mov ax, 10      
    mul dx         
    add ax, bx     

    inc si
    dec cl
    jnz convert_loop

    ; Final value check (must be <= 100)
    cmp ax, 100
    ja invalid_grade_pop

    pop cx 
    
    mov grade_input, al 
    jmp add_to_sum

invalid_grade_pop:
    pop cx
    
invalid_grade:
    ; Print error message and restart grade input
    mov dx, offset msg_error
    mov ah, 09h
    int 21h
    jmp ask_grade

add_to_sum:
    mov al, grade_input
    xor ah, ah
    
    ; Check if the current grade is < 50 (Failure in a single subject)
    cmp al, 50
    jl increment_fail_count 
    jmp continue_sum

increment_fail_count:
    inc fail_count      

continue_sum:    
    add sum_grades, ax  
    
    inc cl              
    jmp read_loop

calc_and_print:
   
    mov dx, offset msg_final
    mov ah, 09h
    int 21h

    ; Calculate Average
    mov ax, sum_grades
    mov bl, num_subjects
    xor bh, bh
    div bl             
    mov bl, al       

   
    mov dx, offset msg_degree
    mov ah, 09h
    int 21h
    mov al, bl
    call print_byte_as_decimal
    
    
    mov dx, offset Sign_
    mov ah, 09h
    int 21h

    
    mov dx, offset msg_status
    mov ah, 09h
    int 21h


;  STATUS DETERMINATION LOGIC

    ; Rule A: Check Administrative Fail (3 or more subjects < 50)
    mov al, fail_count
    cmp al, 3
    jge print_fail      

    ; Rule B: Check Overall Average Fail (< 50)
    mov al, bl          
    cmp al, 50
    jl print_fail       

   
    ; Check Rule C: Carrying Subjects (Takhalluf)
    mov al, fail_count
    cmp al, 0
    jnz print_pass_with_carry 
   
    mov al, bl

    cmp al, 85
    jge print_excellent

    cmp al, 75
    jge print_vgood

    cmp al, 65
    jge print_good

    ; If Average >= 50, and fail_count is 0, it's a clean Pass.
    jmp print_clean_pass


print_pass_with_carry:
    mov dx, offset msg_carry_prefix
    mov ah, 09h
    int 21h
    
    
    mov al, fail_count 
    call print_byte_as_decimal
    
 
    mov dx, offset msg_carry_suffix
    mov ah, 09h
    int 21h
    jmp final_exit 


print_excellent:
    mov dx, offset msg_excellent
    jmp print_result

print_vgood:
    mov dx, offset msg_vgood
    jmp print_result

print_good:
    mov dx, offset msg_good
    jmp print_result

print_clean_pass:
    mov dx, offset msg_clean_pass
    jmp print_result


; STATUS: FAIL (Avg < 50 OR fail_count >= 3)
print_fail:
    mov dx, offset msg_fail
    
print_result:
    mov ah, 09h
    int 21h

final_exit:
    mov ax, 4C00h
    int 21h


print_byte_as_decimal PROC
    push ax
    push bx
    push cx
    push dx

    mov bl, 10
    mov cx, 0           
push_digits:
    xor ah, ah          
    div bl             
    push ax             
    inc cx              
    cmp al, 0           
    jnz push_digits    

print_loop:
    pop ax              
    mov dl, ah         
    add dl, '0'         
    mov ah, 02h         
    int 21h
    loop print_loop     

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_byte_as_decimal ENDP

MAIN ENDP
END MAIN