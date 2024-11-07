.MODEL SMALL           
.STACK 100H            
.DATA
MSG1 DB 'MULTIPLICANDO: $'
MSG2 DB 10, 'MULTIPLICADOR: $'
MSG3 DB 10, 'PRODUTO: $'
.CODE
MAIN PROC
  MOV AX, @DATA 
  MOV DS, AX

  XOR BH, BH ; Zera o acumulador BH

  MOV AH, 9
  LEA DX, MSG1 ; Exibe a mensagem 
  INT 21H

  MOV AH, 1
  INT 21h ; Lê o multiplicando
  SUB AL, '0' ; Converte o valor lido de ASCII para número
  MOV BL, AL ; Armazena o multiplicando em BL
 

  MOV AH, 9
  LEA DX, MSG2 ; Exibe a mensagem 
  INT 21H

  MOV AH, 1
  INT 21h ; Lê o multiplicador
  SUB AL, '0' ; Converte o valor lido de ASCII para número
  MOV CL, AL ; Armazena o multiplicador em CL
  OR CL, CL ; Verifica se é zero
  JZ FIM ; Se for, pula para o fim

MULOOP:

  ADD BH, BL ; Soma o multiplicando ao acumulador 
  DEC CL ; Decrementa o multiplicador, que define a quantidade de vezes da soma
  JNZ MULOOP

FIM:

  MOV AH, 9
  LEA DX, MSG3 ; Exibe a mensagem
  INT 21H

  ADD BH, '0' ; Converte o produto de volta para ASCII
  MOV AH, 2
  MOV DL, BH ; Exibe o produto
  INT 21h

  MOV AH, 4Ch ; Finaliza o programa
  INT 21h
MAIN ENDP
END MAIN
