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

global executive
extern fgets
extern printf
extern strlen
extern stdin
extern atoi
extern fill_random_array
extern show_array
extern normalize_array
max_size equ 60

segment .data
    prompt_name db "Please enter your name: ", 0
    prompt_title db "Please enter your title (Mr, Ms, Sargent, Chief, Project Leader,etc): ", 0
    prompt_welcome db "Nice to meet you %s %s", 10, 10, 0
    prompt_instruction_1 db "This program will generate 64-bit IEEE float numbers.", 10, 0
    prompt_instruction_2 db "How many numbers do you want. Today’s limit is 100 per customer: ", 0
    prompt_print_num_1 db "Your numbers have been stored in an array. Here is that array.", 10, 10, 0
    prompt_print_num_2 db 10, "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.", 10, 10, 0
    prompt_goodbye db 10, "Good bye %s. You are welcome any time.", 10, 0

segment .bss
    align 64
    storedata resb 832
    input_name resb max_size 
    input_title resb max_size 
    input_count resb max_size
    random_number_array resq 100

segment .text
executive:
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

    ; Print the prompt_name
    mov         rax, 0
    mov         rdi, prompt_name                ; Please enter your name:
    call        printf

    ; Get the name input
    mov         rax, 0
    mov         rdi, input_name
    mov         rsi, max_size  		            ; Accept 59, null at the end
    mov         rdx, [stdin]
    call        fgets			                ; Stops on \n

    ; Remove the newline character
    mov         rax, 0
    mov         rdi, input_name
    call        strlen
    mov         byte[input_name + rax - 1], byte 0

    ; Print the prompt_title
    mov         rax, 0
    mov         rdi, prompt_title               ; Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc):  
    call        printf

    ; Get the title input
    mov         rax, 0
    mov         rdi, input_title
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets

    ; Remove the newline character
    mov         rax, 0
    mov         rdi, input_title
    call        strlen
    mov         byte[input_title + rax - 1], byte 0

    ; Print the prompt_welcome 
    mov         rax, 0
    mov         rdi, prompt_welcome             ; Nice to meet you
    mov         rsi, input_title
    mov         rdx, input_name
    call        printf

    ; Print the prompt_instruction_1
    mov         rax, 0
    mov         rdi, prompt_instruction_1       ; This program will generate 64-bit IEEE float numbers.
    call        printf

    ; Print the prompt_instruction_2
    mov         rax, 0
    mov         rdi, prompt_instruction_2
    call        printf

    ; Get the count input
    mov         rax, 0
    mov         rdi, input_count                ; How many numbers do you want. Today’s limit is 100 per customer: 
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets

    ; Remove the newline character
    mov         rax, 0
    mov         rdi, input_count
    call        strlen
    mov         byte[input_count + rax - 1], byte 0

    ; Convert input_count from string to int
    mov         rax, 0
    mov         rdi, input_count
    call        atoi
    mov         r15, rax

    ; Print the prompt_print_num_1
    mov         rax, 0
    mov         rdi, prompt_print_num_1         ; Your numbers have been stored in an array. Here is that array.
    call        printf

    ; Generate random numbers inside the array
    mov         rax, 0
    mov         rdi, random_number_array
    mov         rsi, r15
    call        fill_random_array

    ; Show the content of the array
    mov         rax, 0
    mov         rdi, random_number_array
    mov         rsi, r15
    call        show_array

    ; Print the prompt_print_num_2
    mov         rax, 0
    mov         rdi, prompt_print_num_2         ; The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array.
    call        printf

    ; Normalize the array
    mov         rax, 0
    mov         rdi, random_number_array
    mov         rsi, r15
    call        normalize_array

    ; Show the content of the array
    mov         rax, 0
    mov         rdi, random_number_array
    mov         rsi, r15
    call        show_array

    ; Print the prompt_goodbye
    mov         rax, 0
    mov         rdi, prompt_goodbye             ; Good bye. You are welcome any time.
    mov         rsi, input_title
    call        printf

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    mov         rax, input_name
    
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