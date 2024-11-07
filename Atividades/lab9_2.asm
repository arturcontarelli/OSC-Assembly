.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2  ; Define o vetor

.CODE
MAIN PROC
    MOV AX, @DATA           ; Inicializa o segmento de dados
    MOV DS, AX              
    CALL PREPARA            ; Chama preparação
    CALL VOLTA              ; Chama o procedimento de impressão
    MOV AH, 4CH             ; Termina o programa
    INT 21H 
MAIN ENDP

PREPARA PROC
    XOR DL, DL              ; Zera DL
    MOV CX, 6               ; Define o contador
    LEA SI, VETOR           ; Carrega o endereço do vetor
    RET
PREPARA ENDP

VOLTA PROC
VOLTA_LOOP:
    MOV DL, [SI]            ; Obtém valor do vetor
    INC SI                  ; Avança para o próximo
    ADD DL, 30H             ; Converte para caractere
    MOV AH, 02              ; Prepara impressão
    INT 21H                 ; Imprime o caractere
    LOOP VOLTA_LOOP         ; Repete até CX ser zero
    RET
VOLTA ENDP

END MAIN
