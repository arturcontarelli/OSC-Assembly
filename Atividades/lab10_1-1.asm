ENDL MACRO 
PUSH AX
PUSH DX
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
POP DX
POP AX
ENDM

PUSH_ALL MACRO
    PUSH AX 
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DX
    ENDM

POP_ALL MACRO
    POP DX
    POP SI
    POP CX
    POP BX
    POP AX
    ENDM

PRINTM MACRO
    PUSH DX
MOV DL, MATRIZ[BX][SI] ;Pega o numero e move para dl
ADD DL, 30H ; Converte o numero para letra
INT 21H ; Imprime o caracter

    POP DX
    ENDM

.MODEL SMALL
.STACK 100H
.DATA
MATRIZ  DB 1,2,3,4
        DB 4,3,2,1
        DB 5,6,7,8
        DB 8,7,6,5
COUNTER DB 4
.CODE

MAIN PROC
MOV AX, @DATA
MOV DS, AX

CALL IMPRIME_MATRIZ

MOV AH, 4CH
INT 21H
MAIN ENDP




IMPRIME_MATRIZ PROC

    MOV COUNTER, 4    
    MOV CX, 4         
    MOV AH, 2         
    XOR BX, BX        ; Zera BX 
    XOR SI, SI        ; Zera SI 
    JMP IMPRIME       

PROX_LINHA:
    ENDL    ; Função para pular para a próxima linha
    ADD BX, 4  ; Incrementa o índice de linha (4 bytes por linha)
    XOR SI, SI ; Reseta o índice da coluna
    MOV CX, 4        

IMPRIME:
    PRINTM  ; Exibe o elemento atual da matriz
    INC SI  ; Incrementa o índice de coluna

    LOOP IMPRIME  ; Decrementa CX e repete o loop enquanto CX > 0 (para imprimir colunas)
    DEC COUNTER  ; Decrementa o número de linhas
    JNZ PROX_LINHA    ; Pula para prox linha
    
    RET              

IMPRIME_MATRIZ ENDP
END MAIN
