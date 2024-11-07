TITLE letraMaiuscula
.MODEL SMALL
.STACK 100h
.DATA

MSG1 DB 'Digite uma letra minuscula: $'
MSG2 DB 10, 13, 'A letra maiuscula correspondente e: $'

.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem 1
    MOV AH, 9
    LEA DX, MSG1
    INT 21h

    ; Lê um caractere do teclado
    MOV AH, 1
    INT 21h

    ; Transforma em maiuscula
    SUB AL, 20h

    MOV BL, AL
    
    ; Exibe a mensagem 2
    MOV AH, 9
    LEA DX, MSG2
    INT 21h

    ; Exibe o caractere maiúsculo
    MOV AH, 2
    MOV DL, BL
    INT 21h

    ;Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
