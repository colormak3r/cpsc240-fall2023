; Author: Dang Khoa Nguyen
; CWID: 885089755

; Disclaimer: This repository is for my personal use only. 
; You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
; Remember, I have the commit history to prove the timeline. 
; Avoid academic dishonesty.

global output_array
extern printf

segment .data
output_float db "%1.2f", 10, 0
debug db "Debug", 10, 0

segment .bss
align 64
storedata resb 832

segment .text

output_array:
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

    xor         r13, r13     ; r13 keeps track of the index of the loop    
    mov         r14, rdi     ; rdi contains the array
    mov         r15, rsi     ; rsi contains the count of the array

output_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         output_finished
 
    ; Print the number inside the array
    mov         rax, 1
    movsd       xmm0, [r14 + r13 * 8]
    mov         rdi, output_float   
    call        printf

    ; Inrease the index
    inc         r13    

    ; Repeat the loop
    jmp         output_loop

output_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

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

