section .data
    message:     db 'Hello world!',10,0    ; 'Hello world!' plus a linefeed character
    ; messageLen equ $-message      ; Length of the 'Hello world!' string
    string_scanf_d: db '%d', 0

    x: dq 0.0 ;This will contain the float we are converting from the input
    n: dd 0 ;This will contain the number of items read.
    s: times 100 db 0 ;This is an array for putting the string input in
    fmt: db "%lf %s",0 ;This is the format used in scanf
    ;%lf means long float so double. %s means string. 
    ;See http://www.cplusplus.com/reference/clibrary/cstdio/scanf/

    global main
    extern  GetStdHandle
    extern  WriteConsoleA
    extern  ExitProcess
    extern  printf
    extern  scanf
    extern  putchar
    extern  getchar

section .text

main:
    ; At _start the stack is 8 bytes misaligned because there is a return
    ; address to the MSVCRT runtime library on the stack.
    ; 8 bytes of temporary storage for `bytes`.
    ; allocate 32 bytes of stack for shadow space.
    ; 8 bytes for the 5th parameter of WriteConsole.
    ; An additional 8 bytes for padding to make RSP 16 byte aligned.
    sub     rsp, 8+8+8+32
    ; At this point RSP is aligned on a 16 byte boundary and all necessary
    ; space has been allocated.

    ; hStdOut = GetStdHandle(STD_OUTPUT_HANDLE)
    mov     ecx, -11
    call    GetStdHandle

    ; WriteFile(hstdOut, message, length(message), &bytes, 0);
    ; mov     rcx, rax
    ; mov     rdx, message
    ; mov     r8,  messageLen
    ; lea     r9,  [rsp-16]         ; Address for `bytes`
    ; RSP-17 through RSP-48 are the 32 bytes of shadow space
    ; mov     qword [rsp-56], 0     ; First stack parameter of WriteConsoleA function
    ; call    WriteConsoleA

    mov rcx, message
    ; mov rdx, messageLen
    call printf

    ; sub     rsp, 16
    ; mov rcx, string_scanf_d
    ; lea rdx, [rsp-16]
    ; call scanf

    ;xor  rax, rax
    ;mov  rcx, string_scanf_d
    ;lea  rdx, [rsp-16]
    ;call  scanf
    ;pop rbx

    mov rdi, fmt ;Address of format is the first argument
    mov rsi, x ;Address of the double is second argument
    mov rdx, s ;Address of the string is third argument
    xor eax, eax ;Clears eax
    call scanf ;Calls scanf with our arguments
    ;mov [n], eax ;Moves the number of items read into n. eax always contains the return of a function

    ; call getchar
    ; mov rcx, rax
    ; call putchar

    ; mov rcx, [rsp-16]
    

    ; ExitProcess(0)
    ;    mov     rcx, 0
    ;    call    ExitProcess

    ; alternatively you can exit by setting RAX to 0
    ; and doing a ret

    add rsp, 8+8+32+8             ; Restore the stack pointer.
    xor eax, eax                  ; RAX = return value = 0
    ret