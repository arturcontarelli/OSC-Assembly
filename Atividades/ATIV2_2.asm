TITLE letraMaiuscula
.MODEL SMALL
.STACK 100h
.DATA

MSG1 DB 'Digite um numero: $'
MSG2 DB 10, 13, 'Digite o segundo numero: $'
MSG3 DB 10, 13, 'A soma dos dois numeros e: $'
result DB ?
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

        ; Transforma em numero
    SUB AL, '0'

        ;Guarda em resultado
    MOV result, AL
    
        ; Exibe a mensagem 2
    MOV AH, 9
    LEA DX, MSG2
    INT 21h

      ; Lê um caractere do teclado
    MOV AH, 1
    INT 21h
; Transforma em num 
    SUB AL, '0'
; Soma os dois numeros
    ADD result, AL

        ; Trasforma em caractere de volta
    ADD result, '0'


        ; Exibe a mensagem 3
    MOV AH, 9
    LEA DX, MSG3
    INT 21h

        ; Exibe o caractere maiúsculo
    MOV AH, 2
    MOV DL, result
    INT 21h

    ;Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
