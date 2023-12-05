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

global benchmark
extern printf
extern cpuid
segment .data
    prompt_before_push db "Time on the clock before the push instruction: %d tics", 10, 0
    prompt_after_push db "Time on the clock after the push instruction: %d tics", 10, 0

    prompt_before_add db "Time on the clock before the add instruction: %d tics", 10, 0
    prompt_after_add db "Time on the clock after the add instruction: %d tics", 10, 0

    output_execution_time db "Execution time was %d tics.", 10, 10, 0
    prompt_conclusion db "Now you know which instruction was faster and which was slower.", 10, "The fast execution time will be sent to the driver.", 10, 10, 0

segment .bss
    align 64
    storedata resb 832

segment .text
benchmark:
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

    ; Get the time on the clock before the push instruction and put it in r13
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r13, rax

    ; The push instruction
    push        rdx

    ; Get the time on the clock after the push instruction and put it in r14
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r14, rax
    
    ; Pop to prevent seg fault
    pop         rax 

    ; Print the time on the clock before the push instruction
    mov         rax, 0
    mov         rdi, prompt_before_push
    mov         rsi, r13
    call        printf

    ; Print the time on the clock after the push instruction
    mov         rax, 0
    mov         rdi, prompt_after_push
    mov         rsi, r14
    call        printf

    ; Get the execution time of push
    sub         r14, r13

    ; Save the execution time to r15 so we can compare later
    mov         r15, r14

    ; Print the execution time of push
    mov         rax, 0
    mov         rdi, output_execution_time
    mov         rsi, r14
    call        printf

    ; Get the time on the clock before the add instruction and put it in r13
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r13, rax

    ; The add instruction
    add rbx,rcx

    ; Get the time on the clock after the add instruction and put it in r14
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r14, rax

    ; Print the time on the clock before the add instruction
    mov         rax, 0
    mov         rdi, prompt_before_add
    mov         rsi, r13
    call        printf

    ; Print the time on the clock after the add instruction
    mov         rax, 0
    mov         rdi, prompt_after_add
    mov         rsi, r14
    call        printf

    ; Get the execution time of add
    sub         r14, r13

    ; Print the execution time of add
    mov         rax, 0
    mov         rdi, output_execution_time
    mov         rsi, r14
    call        printf

    ; Comparing the two execution times
    cmp         r14, r15
    jl          push_is_faster

    mov         r12,r15
    jmp         conclusion

push_is_faster:
    mov         r12, r14

conclusion:
    ; Print the conclusion    
    mov         rax, 0
    mov         rdi,  prompt_conclusion
    call        printf

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    mov         rax, r12
    
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