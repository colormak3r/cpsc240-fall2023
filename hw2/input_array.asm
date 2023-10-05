; Author: Dang Khoa Nguyen
; CWID: 885089755

; Disclaimer: This repository is for my personal use only. 
; You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
; Remember, I have the commit history to prove the timeline. 
; Avoid academic dishonesty.

global input_array
extern printf
extern scanf

segment .data
prompt db "Inside input_loop", 10, 0
format_float db "%lf", 0
debug db "Count = %d", 10, 0

segment .bss
align 64
storedata resb 832

segment .text

input_array:

    ; Back up components
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    ; Get onto 16-bit boundary
    push        qword 0
    
    xor         r13, r13    ; r13 keeps track of the index of the loop   
    mov         r14, rdi    ; rdi contains the array    
    mov         r15, rsi    ; rsi contains the size of the array

input_loop:
    ; If the array is full, end the loop
    cmp         r13, r15
    jge         input_finished
    
    ; Scan for input
    mov         rax,0
    push        qword 0
    mov         rdi, format_float    
    mov         rsi, rsp
    call        scanf 
    pop         r12 

    ; If the user press CTRL+D, end the loop
    cdqe
    cmp         rax, -1
    je          input_finished    

    ; Move the input into the array
    mov         [r14 + r13 * 8], r12     

    ; Inrease the index
    inc         r13      
    
    ; Repeat the loop
    jmp         input_loop

input_finished:
    ; Pop the first push
    pop         r12

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ; Send the count back to manage
    mov         rax, r13 

    ;Restore the original values to the GPRs
    popf          
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ; Clean up
    ret