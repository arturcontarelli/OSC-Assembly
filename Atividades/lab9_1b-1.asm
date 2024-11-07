.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2  ; Define o vetor

.CODE
MAIN PROC
    MOV AX, @DATA          
    MOV DS, AX          

    CALL PREPARA   
    CALL VOLTA   

    MOV AH, 4CH ; Termina o programa
    INT 21H 
MAIN ENDP

PREPARA PROC
    XOR DL, DL ; Zera DL
    MOV CX, 6 ; Define o contador
    XOR BX, BX ; Zera BX
    RET
PREPARA ENDP

VOLTA PROC

VOLTA_LOOP:
    MOV DL, VETOR[BX]       ; Obtém valor do vetor
    INC BX ; Avança para o próximo
    ADD DL, 30H ; Converte para caractere
    MOV AH, 02  
    INT 21H ; Imprime o caractere
    LOOP VOLTA_LOOP ; Repete até CX ser zero
    RET
VOLTA ENDP

END MAIN
