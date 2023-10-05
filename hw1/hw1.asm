; Author: Dang Khoa Nguyen
; CWID: 885089755

; Disclaimer: This repository is for my personal use only. 
; You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
; Remember, I have the commit history to prove the timeline. 
; Avoid academic dishonesty.

global lasvegas
extern printf
extern scanf

; Decalre some messages
segment .data
    prompt_initial_speed db "Please enter the speed for the initial segment of the trip (mph): ", 0
    prompt_initial_miles db "For how many miles will you maintain this average speed? ", 0
    prompt_final_speed db "What will be your speed during the final segment of the trip (mph)? ", 0
    
    answer_avg_speed db "Your average speed will be %1.2lf mph.", 10, 0
    answer_travel_time db "The total travel time will be %1.2lf hours. ", 10, 0

    error_invalid_input db "An invalid speed was entered. Please run the program again and enter correct data.", 10, 0

    format_float db "%lf", 0 
    format_string db "%s", 0

    const_float_zero dq 0.0
    const_float_two dq 2.0
    const_total_length dq 253.5

segment .bss  

; Begin instructions
segment .text    

lasvegas:
    ; Back up components
    push       rbp
    mov        rbp, rsp
    push       rbx
    push       rcx
    push       rdx
    push       rsi
    push       rdi
    push       r8 
    push       r9 
    push       r10
    push       r11
    push       r12
    push       r13
    push       r14
    push       r15
    pushf

    ; Get onto the 16-byte boundary
    push       qword 0

    ; Prompt for the initial speed 
    push       qword 0
    mov        rax, 0 
    mov        rdi, format_string
    mov        rsi, prompt_initial_speed
    call       printf 
    pop        rax

    ; Obtain the inital speed from the user and put it in xmm15
    push       qword 0
    mov        rax, 0 
    mov        rdi, format_float
    mov        rsi, rsp
    call       scanf    
    movsd      xmm15, [rsp]    
    pop        rax

    ; Prompt for the initial miles
    push       qword 0 
    mov        qword  rax, 0 
    mov        rdi, format_string
    mov        rsi, prompt_initial_miles
    call       printf
    pop        rax

    ; Obtain the initial miles from the user and put it in xmm14  
    push       qword 0
    mov        qword  rax, 0
    mov        rdi, format_float
    mov        rsi, rsp
    call       scanf
    movsd      xmm14, [rsp]
    pop        rax

    ; Prompt for the final speed
    push       qword 0 
    mov        qword  rax, 0 
    mov        rdi, format_string
    mov        rsi, prompt_final_speed
    call       printf
    pop        rax
   
    ; Obtain the final speed from the user and put it in xmm13  
    push       qword 0
    mov        qword  rax, 0
    mov        rdi, format_float
    mov        rsi, rsp
    call       scanf
    movsd      xmm13, [rsp]
    pop        rax

    ; Pop the initial push
    pop        rax

    ; Check if the third input is less than 0
    movsd xmm0, xmm13
    comisd xmm0, qword [const_float_zero]
    ja check_upper_bound
    jmp error

 check_upper_bound:
    ; Check if input is larger than 253.5
    comisd xmm0, qword [const_total_length]
    jbe continue_program
    jmp error

error:
    ; Print error message
    mov rdi, error_invalid_input
    call printf
    jmp end_program

continue_program:
    ; Calculate the final segment length = total length - initial length
    movsd       xmm12, qword [const_total_length]   ; xmm12 = total length
    subsd       xmm12, xmm14                        ; xmm14 = initial length

    ; Calculate the final segment travel time (time = distance/speed)
    divsd       xmm12, xmm13                        ; xmm13 = final speed

    ; Calculate the initial segment travel time (time = distance/speed)
    divsd       xmm14, xmm15                        ; xmm15 = inital speed

    ; Calculate the total time travel = inital time travel + final time travel
    addsd       xmm12, xmm14
    
    ; Calculate the average speed = total length / total time travel
    movsd       xmm11, qword [const_total_length]
    divsd       xmm11, xmm12 
    
    ; Output the average speed
    movsd      xmm0, xmm11
    mov        rax, 1
    mov        rdi, answer_avg_speed
    call       printf
    
    ; Output the total time travel
    movsd      xmm0, xmm12
    mov        rax, 1
    mov        rdi, answer_travel_time
    call       printf

    ; Set the total time as the return value
    movsd       xmm0, xmm12

end_program:
    ;Restore the original values to the GPRs
    popf          
    pop        r15
    pop        r14
    pop        r13
    pop        r12
    pop        r11
    pop        r10
    pop        r9 
    pop        r8 
    pop        rdi
    pop        rsi
    pop        rdx
    pop        rcx
    pop        rbx
    pop        rbp

    ; Clean up
    ret