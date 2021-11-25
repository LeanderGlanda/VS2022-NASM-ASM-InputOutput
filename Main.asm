global main
extern  GetStdHandle
extern  ExitProcess
extern  printf
extern  scanf

section .data

format_literal_d:   db '%d', 0
message:            db 'Hello world!',10,0
scanf_output:       dd 0

section .text

main:
    ; hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
    mov     ecx, -11
    call    GetStdHandle

    mov rcx, message
    call printf

    mov rcx, format_literal_d
    mov rdx, scanf_output
    xor eax, eax
    call scanf

    mov rcx, format_literal_d
    ; First load the address of x and then access the data
    mov rdx, scanf_output
    mov rdx, QWORD [rdx + 0]
    call printf

    ; ExitProcess(0)
    mov rcx, 0
    call ExitProcess