.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC
    MOV AH, 02h                   ; Função para imprimir letra
    MOV CX, 65                    ; Começa com 'A' (65 em ASCII)

MAIUSCULO:
    MOV DX, CX                    ; Põe o valor de CX em DX para imprimir
    INT 21H                       ; Imprime a letra
    INC CX                        ; Vai para a próxima letra
    CMP CX, 91                    ; Checa se é antes de 'Z' (91)
    JNE MAIUSCULO                 ; Se sim, continua

    MOV CX, 97                    ; Agora começa com 'a' (97 em ASCII)

MINUSCULO:
    MOV DX, CX                    ; Põe o valor de CX em DX para imprimir
    INT 21H                       ; Imprime a letra
    INC CX                        ; Próxima letra
    CMP CX, 123                   ; Checa se é antes de 'z' (123)
    JNE MINUSCULO                 ; Se sim, continua

    MOV AH, 4CH                
    INT 21H              

MAIN ENDP
END MAIN
