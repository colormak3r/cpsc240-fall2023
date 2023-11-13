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

global rot_left
segment .data

segment .bss
    align 64
    storedata resb 832

segment .text

rot_left:
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

    mov         r15, rsi                    ; rsi contains the size of the array  
    mov         r14, rdi                    ; rdi contains the array    
    xor         r13, r13                    ; r13 keeps track of the index of the loop starting at 0
    mov         r12, [r14]                  ; r12 contains the first element of the array
rot_loop:
    cmp         r13, r15
    jge         done

    ; move the element in a cell to the cell before it arr[i] = arr[i+1]
    movsd       xmm15, [r14 + 8 * (r13 + 1)]    
    movsd       [r14 + 8 * (r13)], xmm15 

    inc         r13
    jmp         rot_loop
done:
    ; move the first element to the last cell of the array
    mov         [r14 + 8 * (r15-1)], r12    

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