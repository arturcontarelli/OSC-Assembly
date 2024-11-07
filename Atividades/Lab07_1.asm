.MODEL SMALL           
.STACK 100H            
.DATA
MSG1 DB 'DIGITE O DIVIDENDO: $'
MSG2 DB 10, 'DIGITE O DIVISOR: $'
MSG3 DB 10, 'DIGITE UM NUMERO MENOR QUE O DIVIDENDO$'
MSG6 DB 10, 'QUOCIENTE: $'
MSG7 DB 10, 'RESTO: $'
.CODE
MAIN PROC
  MOV AX, @DATA 
  MOV DS, AX

  XOR CL,CL ; Zera o registro CL para contar o quociente

  MOV AH, 9
  LEA DX, MSG1 ; Exibe a mensagem 
  INT 21H

  MOV AH, 1
  INT 21h ; Lê o dividendo
  SUB AL, '0' ; Converte o valor lido de ASCII para número
  MOV BL, AL ; Armazena o dividendo em BL


DIVISOR:

  MOV AH, 9
  LEA DX, MSG2 ; Exibe a mensagem 
  INT 21H

  MOV AH, 1
  INT 21h ; Lê o divisor
  SUB AL, '0' ; Converte o valor lido de ASCII para número
  MOV BH, AL ; Armazena o divisor em BH

  CMP BL, BH ; Compara o dividendo com o divisor
  JB VERIFY ; Se o divisor for maior, pula para a verificação

SUBLOOP:

  INC CL ; Incrementa o quociente
  SUB BL, BH ; Subtrai o divisor do dividendo
  CMP BL, BH ; Compara o valor restante do dividendo com o divisor
  JAE SUBLOOP ; Continua subtraindo enquanto o dividendo for maior ou igual ao divisor
  JMP FIM ; Quando a divisão terminar, pula para o final

VERIFY:

  MOV AH, 9
  LEA DX, MSG3 ; Exibe a mensagem de erro se o divisor for maior que o dividendo
  INT 21H
  JMP DIVISOR ; Solicita o input novamente

FIM:

  MOV AH, 9
  LEA DX, MSG6 ; Exibe a mensagem
  INT 21H

  ADD CL, '0' ; Converte o quociente de volta para ASCII
  MOV AH, 2
  MOV DL, CL ; Exibe o quociente
  INT 21h

  MOV AH, 9
  LEA DX, MSG7 ; Exibe a mensagem
  INT 21H

  ADD BL, '0' ; Converte o resto de volta para ASCII
  MOV AH, 2
  MOV DL, BL ; Exibe o resto
  INT 21h

  MOV AH, 4Ch ; Finaliza o programa
  INT 21h
MAIN ENDP
END MAIN
