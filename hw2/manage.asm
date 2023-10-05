; Author: Dang Khoa Nguyen
; CWID: 885089755

; Disclaimer: This repository is for my personal use only. 
; You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
; Remember, I have the commit history to prove the timeline. 
; Avoid academic dishonesty.

global manage
max_size equ 8
extern printf
extern input_array
extern output_array
extern sum_array
extern displayArray

segment .data
prompt_intro db "We will take care of all your array needs.", 10, "Please input float numbers separated by ws.", 10, "After the last number press ws followed by control-d", 10, 0
prompt_confirm db 10, "Thank you. The numbers in the array are:", 10, 0
prompt_sum db "The sum of numbers in the array is %1.2f", 10, "Thank you for using Array Management System.", 10, 0
debug_count db "Count = %d", 10, 0
debug_elem db "Element = %1.2f", 10, 0

segment .bss
align 64
storedata resb 832
nicearray resq max_size
sendback resq 2

segment .text

manage:
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

    ; Print the prompt_intro
    mov         rax, 0
    mov         rdi, prompt_intro
    call        printf

    ; Call input_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, max_size
    call        input_array    

    ; Move array count to r12
    mov         r12, rax

    ; Print prompt_confirm
    mov         rax, 0
    mov         rdi, prompt_confirm    
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r12
    call        output_array

    ; Call sum_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r12
    call        sum_array

    ; Print prompt_sum
    mov         rax, 1
    mov         rdi, prompt_sum
    call        printf     

    ; Set cell 1 of sendback array the count, and cell 2 the nicearray address
    mov         [sendback + 0 * 8], r12
    mov         r11, nicearray
    mov         [sendback + 1 * 8], r11

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ; Send the array and count to the main module
    mov         rax, sendback
    
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

