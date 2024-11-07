TITLE Numero

.MODEL SMALL

.STACK 100h

.DATA
MSG1 DB 'Digite um caractere: $'
SIM DB 10,13,'O caractere digitado e um numero.$'
NAO DB 10,13,'O caractere digitado nao e um numero.$'

; O Programa solicita ao usuário que digite um caractere, 
;verifica se é um dígito numérico, e exibe uma mensagem correspondente 
;indicando se o caractere digitado é um número ou não antes de encerrar.

.CODE
MAIN PROC
; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA

MOV DS,AX
; Exibe na tela a string MSG1 (“Digite um caractere: ”)

MOV AH,9
LEA DX, MSG1
INT 21h
; Lê um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h
; Copia o caractere lido para BL
MOV BL,AL
; Compara o caractere em BL com o valor 48 (código ASCII do caracter “0”)
CMP BL,48
; Se o caractere em BL for menor que 48 (“0”), salta para o rótulo NAOENUMERO
JB NAOENUMERO
; Compara o caractere em BL com o valor 57 (código ASCII do caracter “9”)
CMP BL,57
; Se o caractere em BL for maior que 57 (“9”), salta para o rótulo NAOENUMERO
JA NAOENUMERO
; Se chegou até aqui, exibe na tela dizendo que o caracter é um número
MOV AH,9
MOV DX,OFFSET SIM
INT 21h
; Salta para o rótulo FIM
JMP FIM
; Define o rótulo NAOENUMERO
NAOENUMERO:
; Exibe na tela dizendo que o caractere não é um número
MOV AH,9
MOV DX,OFFSET NAO
INT 21h
; Define o rótulo FIM
FIM:
; Finaliza o programa
MOV AH,4Ch
INT 21h

MAIN ENDP
END MAIN


