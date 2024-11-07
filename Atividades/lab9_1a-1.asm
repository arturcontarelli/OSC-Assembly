.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2  ; Define o vetor

.CODE
MAIN PROC

MOV AX, @DATA              
MOV DS, AX  

CALL PREPARA

CALL IMPRIME

MOV AH, 4CH                
INT 21H 
MAIN ENDP




PREPARA PROC

XOR DL, DL ; Zera o registrador DL 
MOV CX, 6  ; Define o contador para 6 iterações
LEA BX, VETOR ; Carrega o endereço do vetor em BX
    RET

PREPARA ENDP

IMPRIME PROC

VOLTA:
MOV DL, [BX] ; Move o valor do vetor apontado por BX para DL
INC BX ; Passa para o próximo elemento
ADD DL, 30H ; Converte o número para caractere
MOV AH, 02                 
INT 21H ; Imprime
LOOP VOLTA ; Loop

RET
IMPRIME ENDP


END MAIN