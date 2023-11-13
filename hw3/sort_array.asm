; Program name: "Sort Array". This program sort an array using modular
; components that manage, input, output and sort the array.
; Copyright (C) <2023>  <Dang Khoa Nguyen>

; This file is part of the software program "Sort Array".

; Sort Array is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; Sort Array is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>. 

;Author information
;  Author name : Dang Khoa Nguyen
;  Author email: colormak3r@csu.fullerton.edu
;  Author CWID : 885089755

global sort_array
extern printf

segment .data
output_float db "%1.2f", 10, 0

segment .bss
align 64
storedata resb 832

segment .text

sort_array:
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

    mov         r14, rdi                        ; rdi contains the address of the nicearray    
    mov         r15, rsi                        ; rsi contains the count of the nicearray

    ; Check if if the count is 0 => no sort to prevent segfault
    cmp         r15, 0                          
    je          sort_finished

    sub         r15, 1                          ; calculate n-1
    xor         r13, r13                        ; i - counter for the outer loop
    xor         r12, r12                        ; j - counter for the inner loop
    xor         r10, r10                        ; swapped flag (0 = false, 1 = true)

bubble_sort:    
    ; Start of the outer loop
    cmp         r13, r15                        ; for (i = 0; i < n - 1; i++)
    jae         sort_finished

    ; Set swapped = false
    mov         r11, 0                          

bubble_sort_internal:
    ; Start of the inner loop
    mov         rax, r15
    sub         rax, r13                        ; calculate n - i - 1
    cmp         r12, rax                        ; for (j = 0; j < n - i - 1; j++)
    jae         bubble_sort_internal_finished
    
    ; Put the float value of arr[j] to xmm0
    mov         rax, [r14 + r12 * 8]            ; rax contains the address of arr[j]
    movsd       xmm14, [rax]                    ; dereference again to get the value

    ; Put the float value of arr[j+1] to xmm1
    mov         rbx, [r14 + (r12 + 1) * 8]      ; rbx contains the address of arr[j+1]
    movsd       xmm15, [rbx]                    ; dereference again to get the value
    
    ; Comparing arr[j] and arr[j+1]
    ucomisd     xmm14, xmm15                    
    ja          swap_pointers

    ; Repeat the inner loop
    inc         r12                             ; j++
    jmp         bubble_sort_internal            

swap_pointers:
    ; Swap the addresses with out moving the value
    mov         rax, [r14 + r12 * 8]            ; rax contains the address of arr[j]
    mov         rbx, [r14 + (r12 + 1) * 8 ]     ; rbx contains the address of arr[j+1]    
    mov         [r14 + r12 * 8], rbx            
    mov         [r14 + (r12 + 1) * 8], rax    

    ; Set swapped = true
    mov         r11, 1      

    ; Repeat the inner loop
    inc         r12                             ; j++
    jmp         bubble_sort_internal            

bubble_sort_internal_finished:
    xor         r12, r12                        ; set j = 0
    inc         r13                             ; i++

    ; Repeat the outer loop if swapped == true
    cmp         r11, 1 
    je          bubble_sort                     ; if no number is swapped,  it means the array is sorted => stop looping

sort_finished:
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

