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

global director
extern input_array
extern output_array
extern sort_array
extern printf
max_size equ 10

segment .data
prompt_intro db "This program will sort all of your doubles", 10, "Please enter floating point numbers separated by white space.", 10, "After the last numeric input enter at least one more white space and press cntl+d.", 10, 0
prompt_confirm db 10, "Thank you. You entered these numbers:", 10, 0
prompt_sort_start db "End of output of array.", 10, "The array is now being sorted without moving any numbers.", 10, "The data in the array are now ordered as follows", 10, 0
prompt_sort_end db "End of output of array.", 10, "The array will be sent back to the caller function.", 10, 0

segment .bss
align 64
storedata resb 832
nicearray resq max_size
sendback resq 2

segment .text

director:
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
    mov         rdi, prompt_intro           ; This program will sort all of your doubles...
    call        printf

    ; Call input_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, max_size
    call        input_array   

    ; Move the nicearray count to r13
    mov         r13, rax

    ; Print prompt_confirm
    mov         rax, 0
    mov         rdi, prompt_confirm         ; Thank you. You entered these numbers:
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Print prompt_sort_start
    mov         rax, 0
    mov         rdi, prompt_sort_start      ; End of output of array. The array is now being sorted without moving any numbers....
    call        printf

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        sort_array

    ; Call output_array
    mov         rax, 0 
    mov         rdi, nicearray
    mov         rsi, r13
    call        output_array

    ; Print prompt_sort_end
    mov         rax, 0
    mov         rdi, prompt_sort_end        ; End of output of array. The array will be sent back to the caller function.
    call        printf

    ; Preparing the sendback array
    mov         [sendback + 0 * 8], r13     ; Set cell 1 of the sendback array the count
    mov         r11, nicearray
    mov         [sendback + 1 * 8], r11     ; Set cell 2 of the sendback array the nicearray address

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ; Send the sendback array to the main module
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

