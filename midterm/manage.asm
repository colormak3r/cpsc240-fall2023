; Program name: "Rotate Array". This program rotate an array left using modular
; components that manage, input, output rotate, and sum the array.
; Copyright (C) <2023>  <Dang Khoa Nguyen>

; This file is part of the software program "Rotate Array".

; Rotate Array is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; Rotate Array is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>. 

; Author information
;   Author name : Dang Khoa Nguyen
;   Author email: colormak3r@csu.fullerton.edu
;   Author section: 240-3
;   Author CWID : 885089755

global manage
extern input_array
extern output_array
extern rot_left
extern sum_array
extern printf
max_size equ 10

segment .data
    prompt_intro db "Please enter floating point numbers separated by ws.  After the last valid input enter one more ws followed by control+d." , 10, 0
    prompt_output db "This is the array: ", 0
    prompt_rot db 10, 10, "Function rot-left was called 1 time.", 10, 0
    prompt_rot_cons db 10, 10, "Function rot-left was called %d times consecutively.", 10, 0
    newline db 10,0

segment .bss
    align 64
    storedata resb 832
    nicearray resq max_size

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
    mov         rdi, prompt_intro           ; Please enter floating point numbers separated by ws...
    call        printf

    ; Call input_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, max_size
    call        input_array   

    ; Move the nicearray count to r13
    mov         r13, rax

    ; Print the prompt_output
    mov         rax, 0
    mov         rdi, newline                 ; Neline
    call        printf

    ; Print the prompt_output
    mov         rax, 0
    mov         rdi, prompt_output           ; This is the array: 
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Call rot_left
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        rot_left

    ; Print the prompt_rot
    mov         rax, 0
    mov         rdi, prompt_rot              ; Function rot-left was called 1 time.
    mov         rsi, r14
    call        printf
    
    ; Print the prompt_output
    mov         rax, 0
    mov         rdi, prompt_output           ; This is the array: 
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Call rot_left 3 times
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        rot_left
    call        rot_left
    call        rot_left

    ; Print the prompt_rot_cons
    mov         rax, 0
    mov         rdi, prompt_rot_cons        ; Function rot-left was called 3 times consecutively.
    mov         rsi, 3
    call        printf

    ; Print the prompt_output
    mov         rax, 0
    mov         rdi, prompt_output          ; This is the array: 
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Call rot_left 2 times
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        rot_left
    call        rot_left

    ; Print the prompt_rot_cons
    mov         rax, 0
    mov         rdi, prompt_rot_cons        ; Function rot-left was called 2 times consecutively.
    mov         rsi, 2
    call        printf

    ; Print the prompt_output
    mov         rax, 0
    mov         rdi, prompt_output          ; This is the array: 
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Call sum_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        sum_array

    ; Save the sum on the stack
    push        qword 0
    movsd       [rsp], xmm0

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;  Restore the sum and it send to the main module
    movsd       xmm0, [rsp]
    pop         rax
    
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