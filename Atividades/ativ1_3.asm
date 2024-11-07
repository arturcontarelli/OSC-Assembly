.MODEL SMALL
.DATA
    MSG DB 'Digite algum caractere: $'  ; Mensagem para solicitar a entrada do usuário
    MSG1 DB 'O caractere escolhido foi: $'  ; Mensagem para exibir o caractere escolhido
.CODE
MAIN PROC
    ; Inicializa o segmento de dados
         MOV AX,@DATA
         MOV DS,AX

    ; Exibe a mensagem solicitando ao usuário para digitar um caractere
         MOV AH,9
         LEA DX,MSG
         INT 21h

    ; Captura um caractere do teclado e armazena em AL
         MOV AH,1
         INT 21h

    ; Salva o caractere lido em BL para uso posterior
         MOV BL,AL

    ; Adiciona uma linha em branco após a entrada do usuário
         MOV AH,2
         MOV DL,10    
         INT 21h

    ; Retorna o cursor para o início da linha atual
         MOV AH,2
         MOV DL,13    
         INT 21h

    ; Exibe a mensagem mostrando o caractere escolhido
         MOV AH,9
         LEA DX,MSG1
         INT 21h

    ; Mostra o caractere que o usuário digitou
         MOV AH,2
         MOV DL,BL
         INT 21h

    ; Termina o programa e retorna ao sistema operacional
         MOV AH,4Ch
         INT 21h
MAIN ENDP
END MAIN
