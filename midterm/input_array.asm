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
;   Author CWID : 885089755d

global input_array
extern printf
extern scanf

segment .data
    format_float db "%lf", 0

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