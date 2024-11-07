.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC

    MOV AH, 02h   ; Função para imprimir caractere
    MOV DL, 'a'   ; Inicia com 'a'
    MOV BL, 4     ; Contador para o pulo
    MOV CX, 26   ; Total de letras a imprimir

MINUSCULO:
    INT 21H    ; Imprime o caractere em DL
    INC DL     ; Próxima letra
    DEC BL     ; Decrementa contador
    JNZ LOPAR   ; Loopa se BL não for zero

    MOV BL, 4      ; Reseta BL para 4
    MOV BH, DL      ; Armazena DL

    MOV DL, 10       
    INT 21H           ; Imprime nova linha
    
    MOV DL, BH      

LOPAR:
    LOOP MINUSCULO       ; Repete até CX zerar

    MOV AH, 4CH       ; Função para encerrar o programa
    INT 21H        ; Chama a interrupção para encerrar

MAIN ENDP
END MAIN
