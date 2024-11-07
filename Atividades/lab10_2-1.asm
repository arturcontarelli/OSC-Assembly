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
    PUSH DI
    ENDM

POP_ALL MACRO
    POP DI
    POP DX
    POP SI
    POP CX
    POP BX
    POP AX
    ENDM

.MODEL SMALL
.STACK 100H
.DATA
    MATRIZ DB 4 DUP(4 DUP(?))

.STACK 100H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA BX, MATRIZ
    CALL LER

    CALL SOMAR

    CALL IMPRIMIR

    MOV AH, 4CH
    INT 21H

MAIN ENDP

LER PROC
    PUSH_ALL
    MOV AH,1
    MOV DI,BX                    
    ADD DI,12
    PROX_LINHA:
    XOR SI,SI                    
    MOV CX,4                     ;loop 4 vezes
    INPUT_MATRIZ:
        INT 21H                  ;recebe caractere
        AND AL,0Fh               ;converte caractere
        MOV MATRIZ[BX][SI],AL    ;coloca na matriz
        INC SI                   ;próximo elemento
        LOOP INPUT_MATRIZ
    ADD BX,SI                    ;próxima fileira
    CMP BX,DI
    JLE PROX_LINHA               ;se não passou, volta
    POP_ALL                      ;restaura registradores
    RET
LER ENDP

SOMAR PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    XOR AX,AX
    MOV DI,BX                    ;DI=última fileira
    ADD DI,12
    SOMA_FILEIRA:
    XOR SI,SI
    MOV CX,4
    SOMAR_ELEMENTOS:             ;loop soma 4 elementos
        MOV DL,[BX][SI]          ;elemento para DL
        XOR DH,DH
        ADD AX,DX                ;soma em AX
        INC SI                   ;próximo elemento
        LOOP SOMAR_ELEMENTOS
        ADD BX,SI                ;próxima fileira
        CMP BX,DI                ;compara com última fileira
        JLE SOMA_FILEIRA         ;sai após última fileira
    MOV BX,AX
    POP SI
    POP DX
    POP CX
    POP AX
    RET
SOMAR ENDP

IMPRIMIR PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV DI,10
    XOR CX,CX
    MOV AX,BX                    ;número para dividir
    XOR DX,DX
    OUTPUTDECIMAL:
        DIV DI                   ;div AX/DI, resto em DX
        PUSH DX                  ;guarda resto
        XOR DX,DX                ;limpa DX
        INC CX
        OR AX,AX                 ;verifica quociente 0
        JNZ OUTPUTDECIMAL
    MOV AH,2
    ENDL
    IMPRIMIRDECIMAL:
        POP DX                   ;desempilha e imprime
        OR DL,30H                ;converte para caractere
        INT 21H
        LOOP IMPRIMIRDECIMAL
    POP DX
    POP CX
    POP BX
    POP AX
    RET
IMPRIMIR ENDP
END MAIN
