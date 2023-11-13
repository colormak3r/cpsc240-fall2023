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

global sum_array

segment .data

segment .bss
    align 64
    storedata resb 832

segment .text

sum_array:
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

    xor         r13, r13    ; r13 keeps track of the index of the loop   
    mov         r14, rdi    ; rdi contains the array    
    mov         r15, rsi    ; rsi contains the length of the array

sum_loop:
    ; If the array is full, end the loop
    cmp         r13, r15
    jge         sum_finished
    
    ; Add n elements from the array into xmm0
    addsd       xmm15, [r14 + r13 * 8]      
    
    inc         r13         ; Inrease the index
    jmp         sum_loop    ; Repeat the loop

sum_finished:
    ; Save the sum on the stack
    push        qword 0
    movsd       [rsp], xmm15

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ; Restore the sum and send to manage
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