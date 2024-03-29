bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;a,b,c,d - byte (a-b)+(c-b-d)+d = (6 - 4) + ( 2 - 4 - 2) + 2 = 0 
    a db 0FFh
    b db 4h
    c db 0Ah
    d db 2h
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al, [a]; al := a
        sub al, [b]; al := a - b
        
    ;*************************************************** al := a - b ***********************************************************
        
        mov bl, [c]; bl := c
        sub bl, [b]; bl := bl - b := c - b
        sub bl, [d]; bl := bl - d := c - b - d
        
    ;************************************************* bl := c - b - d *********************************************************
        
        add al, bl; al := al + bl := (a - b) + (c - b - d)
        add al, [d]; al := al + d := (a - b) + (c - b - d) + d
        
    ;*********************************** al := al + d := (a - b) + (c - b - d) + d *********************************************
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
