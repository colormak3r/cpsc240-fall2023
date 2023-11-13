global faraday
extern fgets
extern printf
extern strlen
extern stdin

segment .data
    prompt_name db "Please enter your name: ", 0
    prompt_title db "Please enter your title or profession: ", 0
    prompt_welcome db "We always welcome a %s to our electrical lab.", 10, 10, 0

    prompt_voltage db "Please enter the voltage of the electrical system at your site (volts): %lf", 10, 0
    prompt_resistance  db "Please enter the electrical resistance in the system at your site (ohms): %lf", 10, 0
    prompt_time db "Please enter the time your system was operating (seconds): %lf", 10, 0

    prompt_congrats1 db "Congratulations %s. Come back any time and make use of our software.", 10, 0
    prompt_congrats2 db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 0
    
    input_name db 60
    input_title db 60

    debug db "Debug %d", 10, 0

segment .bss
    align 64
    storedata resb 832

segment .text
faraday:
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

    mov         rax, 0
    mov         rdi, input_name
    mov         rsi, 60 		                ;accept 59, null at the end
    mov         rdx, [stdin]
    call        fgets			                ;stops on \n

    mov         rax, 0
    mov         rdi, input_name
    call        strlen
    mov r15,rax
    mov         byte[input_name + rax - 1], byte 0

    mov         rax,0
    mov rdi, debug
    mov rsi, r15
    call printf

    ; ; Print the prompt_title
    ; mov         rax, 0
    ; mov         rdi, prompt_title               ;Please enter your title or profession:
    ; call        printf

    ; mov         rax, 0
    ; mov         rdi, input_title
    ; mov         rsi, 60 		                ;accept 59, null at the end
    ; mov         rdx, [stdin]
    ; call        fgets			                ;stops on \n

    ; mov         rax, 0
    ; mov         rdi, input_title
    ; call        strlen
    ; mov         byte[input_title + rax - 1], byte 0

    ; ; Print the prompt_welcome
    ; mov         rax, 0
    ; mov         rdi, prompt_welcome             ;Please enter your title or profession:
    ; mov         rsi, input_title
    ; call        printf

    ; Print the prompt_congrats1
    mov         rax, 0
    mov         rdi, prompt_congrats1           ;Congratulations %s. Come back any time and make use of our software.
    mov         rsi, input_name
    call        printf

    ; ; Print the prompt_congrats2
    ; mov         rax, 0
    ; mov         rdi, prompt_congrats2           ;Everyone with title %s is welcome to use our programs at a reduced price.
    ; mov         rsi, input_title
    ; call        printf

    ; mov         rax,0
    ; mov rdi, debug
    ; mov rsi, r15
    ; call printf

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