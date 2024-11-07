TITLE Eco
.MODEL SMALL
.CODE
MAIN PROC
    ; Exibe o caractere '?'
    MOV AH,2
    MOV DL,'?'
    INT 21h
    
    ; Lê um caractere do teclado
    MOV AH,1
    INT 21h
    
    ; Armazena o caractere lido em BL
    MOV BL,AL
    
    ; Pula uma linha
    MOV AH,2
    MOV DL,10
    INT 21h
    
    ; Volta ao início da linha)
    MOV AH,2
    MOV DL,13
    INT 21h
    
    ; Exibe o caractere lido
    MOV AH,2
    MOV DL,BL
    INT 21h
    
    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
MAIN ENDP
END MAIN

