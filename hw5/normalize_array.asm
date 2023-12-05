; Program name: "Random Number Normalization". This program fill an array with up to
; element with a random number and normalize them into a number within the range of 
; 1.0 and 2.0
; Copyright (C) <2023>  <Dang Khoa Nguyen>

; This file is part of the software program "Random Number Normalization".

; Random Number Normalization is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; Random Number Normalization is distributed in the hope that it will be useful,
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

global normalize_array
extern rdrand

segment .data 
segment .bss
    align 64
    storedata resb 832
segment .text
normalize_array:
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

    xor         r13, r13                        ; r13 keeps track of the index of the loop 
    mov         r14, rdi                        ; rdi contains the address of the random_number_array   
    mov         r15, rsi                        ; rsi contains the count of the random_number_array

normalize_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         normalize_finished

    ; Normalize an element of the array
    mov         r12, [r14 + r13 * 8]            ; Temporary copy the element into r12.                  0x9c75b07eadac83b9 
    shl         r12, 12                         ; Shift the hex number 3 place to the left.             0x5b07eadac83b9 
    shr         r12, 12                         ; Shift the hex number 3 place to the right.            0x0005b07eadac83b9 
    mov         rax, 0x3FF0000000000000          
    or          r12, rax                        ; OR the hex number with the mask
    mov         [r14 + r13 * 8], r12            ; Move the normalized hex number back into the array    0x3ff5b07eadac83b9

    ; Inrease the index and repeat the loop
    inc         r13      
    jmp         normalize_loop

normalize_finished:
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
