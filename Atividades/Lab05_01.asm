.MODEL SMALL
.STACK 100H
.DATA
    PULA DB 10           ; Caractere de nova linha

.CODE
MAIN PROC
               MOV  AX, @DATA          ; Inicializa o segmento de dados
               MOV  DS, AX

               MOV  AH, 02h            ; Função para imprimir caractere
               MOV  DL, '*'             
               MOV  CX, 50             

MESMALINHA:
               INT  21H                ; Imprime o caractere '*'
               DEC CX                   ; Decrementa o contador
               JNZ MESMALINHA          ; Se ainda não zerou, continua

               MOV  CX, 50          ; Reseta o contador para a próxima linha

LINHADIF:  
               MOV  AH, 02h            ; Função para imprimir caractere
               MOV  DL, PULA           ; Carrega nova linha
               INT  21H                ; Imprime nova linha

               MOV  AH, 02h            ; Função para imprimir caractere
               MOV  DL, '*'             
               INT  21H                ; Imprime o caractere '*'

               DEC  CX                  ; Decrementa o contador
               JNZ  LINHADIF           ; Se ainda não zerou, continua

               MOV  AH, 4CH            
               INT  21H                

MAIN ENDP
END MAIN
