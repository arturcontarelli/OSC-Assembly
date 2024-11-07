.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 10, 13, 'Insira um numero: $'  ; Mensagem para entrada
    RESULTADO DB 10, 13, 'A somatoria e: $' ; Mensagem para resultado
    somatoria db 0                          ; Inicializa somatoria com 0
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                          

    MOV CX, 5  ; Número de iterações
print: 
    MOV AH, 9  ; Imprime mensagem
    LEA DX, MSG  ; Carrega endereço da mensagem
    INT 21h                                 

    MOV AH, 1   ; Lê caractere
    INT 21h                                 
    SUB AL, '0'  ; Converte ASCII para número

    ADD somatoria, AL   ; Soma o número
    LOOP print                             

    
    MOV AH, 9   ; Imprime mensagem de resultado
    LEA DX, RESULTADO
    INT 21h                                 

    MOV DL, somatoria                    
    ADD DL, '0'     ; Converte para ASCII
    MOV AH, 2       ; Imprime caractere
    INT 21h                                 

    MOV AH, 4CH    ; Finaliza programa
    INT 21H                                 

MAIN ENDP
END MAIN
