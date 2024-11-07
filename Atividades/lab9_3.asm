; Escreva um programa que inverta a ordem de um vetor de 7 posições, isto é, o primeiro elemento
; se tornará o último, o último se tornará o primeiro e assim sucessivamente. Ler o vetor e imprimir
; depois de inverter a ordem. NÃO UTILIZAR UM VETOR AUXILIAR. Utilizar BX, SI e DI nas
; diversas manipulação de vetor (ler, inverter e imprimir)

.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'DIGITE UM VETOR DE 7 POSICOES: $'
MSG2 DB 10, 13, 'O VETOR COM A ORDEM INVERTIDA FICA: $'
VETOR DB 0,0,0,0,0,0,0  ; Inicializa o vetor


.CODE
MAIN PROC

MOV AX, @DATA              
MOV DS, AX  
CALL LER_VETOR ; Le o vetor e guarda ele de maneira invertida
CALL IMPRIME_VETOR ; Imprime o vetor invertido
MOV AH, 4CH ; Fim do programa               
INT 21H 
MAIN ENDP


LER_VETOR PROC

MOV CX, 7  ; Define o contador para 7 iterações
XOR BX, BX ; Zera BX

MOV AH, 9 ; Exibe mensagem
LEA DX, MSG1
INT 21H
MOV AH, 1
MOV BX, CX ; Move o contador para bx
LER:
INT 21H 
DEC BX ; Decrementa bx para igualar a posicao 
MOV VETOR[BX], AL ; Move o caractere inserido para a posicao bx do vetor
LOOP LER

RET
LER_VETOR ENDP


IMPRIME_VETOR PROC
MOV AH, 9 ; Exibe a mensagem 
LEA DX, MSG2 
INT 21H
MOV CX, 7 ; Define o contador para 7 iterações
XOR SI, SI ; Zera SI
MOV AH, 2 ; Define impressao

IMPRIME:


 MOV DL, VETOR[SI] ; Move o caractere da posição SI para DL
 INC SI ; Passa para a proxima posição
 INT 21H ; Imprime DL
 LOOP IMPRIME ; 7 iterações

RET
IMPRIME_VETOR ENDP


END MAIN