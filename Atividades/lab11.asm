; Fazer um programa que permita a entrada e qualquer uma das bases e a saída em qualquer uma
; das bases. O programa deverá perguntar em que base será a entrada do número e em que base
; será a saída do número. Usar procedimentos e macros.

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
    PUSH DX
    ENDM

POP_ALL MACRO
    POP DX
    POP CX
    POP BX
    POP AX
    ENDM

PRINT MACRO MSG
    PUSH_ALL
    MOV AH, 9 ; Exibe a mensagem e as opções
    LEA DX, MSG
    INT 21H 
    POP_ALL
ENDM

.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'BINARIO = B',10,13,'DECIMAL = D',10,13,'HEXADECIMAL = H$'
MSG2 DB 'ESCOLHA UMA ENTRADA: $'
MSG3 DB 'DIGITE O NUMERO: $'
MSG4 DB 'ESCOLHA UMA SAIDA: $'
TABELA DB '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' ; DEFINE A TABELA DE TRADUÇÃO

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    PRINT MSG1
    ENDL
    PRINT MSG2

    MOV AH, 1
    INT 21H
    ENDL
    ; Verificar se é uma letra minúscula ('a' <= char <= 'z')
    CMP AL, 'a'
    JL ENTRADA ; se for menor que 'a', já está em maiúscula ou é outro caractere    
    SUB AL, 32 ; Converter para maiúscula

    ENTRADA:
    PRINT MSG3
    CMP AL, 'B'
    JE CHAMA_FUNCAO_BIN
    CMP AL, 'D'
    JE CHAMA_FUNCAO_DEC
    CMP AL, 'H'
    JE CHAMA_FUNCAO_HEX
    JMP FIM

    CHAMA_FUNCAO_BIN:
    CALL ENTBIN
    JMP SAIDA

    CHAMA_FUNCAO_DEC:
    CALL ENTDEC
    JMP SAIDA

    CHAMA_FUNCAO_HEX:
    CALL ENTHEX
    JMP SAIDA

    SAIDA: 
    PUSH_ALL
    ENDL 
    PRINT MSG1
    ENDL
    PRINT MSG4

    MOV AH, 1
    INT 21H
    ENDL
    ; Verificar se é uma letra minúscula ('a' <= char <= 'z')
    CMP AL, 'a'
    JL @SAIDA ; se for menor que 'a', já está em maiúscula ou é outro caractere    
    SUB AL, 32 ; Converter para maiúscula

    @SAIDA:
    CMP AL, 'B'
    JE SAIDA_BIN
    CMP AL, 'D'
    JE SAIDA_DEC
    CMP AL, 'H'
    JE SAIDA_HEX
    JMP FIM

    SAIDA_BIN:
    POP_ALL
    CALL SAIBIN
    JMP FIM

    SAIDA_DEC:
    POP_ALL
    CALL SAIDEC
    JMP FIM

    SAIDA_HEX:
    POP_ALL
    CALL SAIHEX
    JMP FIM

    FIM:
    MOV AH,4CH
    INT 21H
MAIN ENDP

ENTDEC PROC
; lê um numero entre -32768 A 32767
; entrada nenhuma
; saída numero em AX

@INICIO:

;  total = 0
    XOR BX,BX
; negativo = falso
    XOR CX,CX

; le caractere
    MOV AH,1
    INT 21H

; case caractere lido eh?
    CMP AL,'-'
    JE @NEGT
    CMP AL,'+'
    JE @POST
    JMP @REP2
@NEGT:
    MOV CX,1
@POST:
    INT 21H
;end case
@REP2:
; if caractere esta entre 0 e 9
    CMP AL, '0'
    JNGE @NODIG
    CMP AL, '9'
    JNLE @NODIG
; converte caractere em digito
    AND AX,000FH
    PUSH AX
; total = total X 10 + digito
    MOV AX,10
    MUL BX   ; AX = total X 10
    POP BX
    ADD BX,AX ; total - total X 10 + digito
; le caractere
    MOV AH,1
    INT 21H
    CMP AL,13  ;CR ?
    JNE @REP2    ; não, continua
; ate CR
    MOV AX,BX   ; guarda numero em AX
; se negativo
    OR CX,CX    ; negativo ?
    JE @SAI      ; sim, sai
; entao
    NEG AX
; end if
    jmp @sai
@NODIG:
; se caractere ilegal
    MOV AH,2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    JMP @INICIO
@SAI:
    MOV BX, AX ; MOVE PARA O REGISTRADOR QUE ESTA SENDO UTILIZADO COMO PADRAO NAS TRADUÇÕES
    RET   ; retorna

ENTDEC ENDP

SAIDEC PROC
; imprime numero decimal sinalizado em AX
; entrada AX
; saida nenhuma

; if AX < 0
    MOV AX, BX
    OR AX,AX      ; AX < 0 ?
    JGE @END_IF1
;then
    PUSH AX     ;salva o numero
    MOV DL, '-'
    MOV AH,2
    INT 21H         ; imprime -
    POP AX          ; restaura numero
    NEG AX

; digitos decimais
@END_IF1:
    XOR CX,CX      ; contador de d?gitos
    MOV BX,10      ; divisor
@REP1:
    XOR DX,DX      ; prepara parte alta do dividendo
    DIV BX         ; AX = quociente   DX = resto
    PUSH DX        ; salva resto na pilha
    INC CX         ; contador = contador +1

;until
    OR AX,AX       ; quociente = 0?
    JNE @REP1      ; nao, continua

; converte digito em caractere
    MOV AH,2

; for contador vezes
@IMP_LOOP:
    POP DX        ; digito em DL
    OR DL,30H
    INT 21H
    LOOP @IMP_LOOP
; fim do for


    RET
SAIDEC ENDP

   ENTHEX PROC
    XOR BX, BX ; LIMPA BX
    MOV CL, 4 ; DEFINE O DESLOCAMENTO PARA 4 BITS

    MOV AH, 1
WILE:
    INT 21H ; LÊ UM CARACTERE

    CMP AL, 13   ; VERIFICA SE FOI PRESSIONADA A TECLA ENTER
    JE IMPRIME   ; SE SIM, VAI PARA A IMPRESSAO

    CMP AL, 57   ; SE AL FOR MAIOR QUE 9(57 ASCII), É UMA LETRA
    JA LETRA

    AND AL, 0FH   ; CONVERTE DE ASCII PARA VALOR NUMÉRICO(TIRA 30H)
    JMP DESLOCA

LETRA:
    SUB AL, 37H   ; CONVERTE DE HEXADECIMAL PARA VALORES NUMERICOS

DESLOCA:
    SHL BX, CL    ; DESLOCA BX PARA A ESQUERDA EM 4 BITS
    AND AL, 0FH  ;PREPARA AL(DEIXA APENAS OS PRIMEIROS 4 BITS)
    OR BL, AL     ; ARMAZENA O VALOR NO REGISTRADOR BX
    JMP WILE

IMPRIME:
    RET
    ENTHEX ENDP

    SAIHEX PROC
    MOV AH, 2
    MOV CX, 4

LOOP_IMPRIME:
   
    MOV DL, BH                  
    SHR DL, 4                   ;DESLOCA O DÍGITO HEXADECIMAL PARA A DIREITA 

    PUSH BX                     ;GUARDA VALOR DE BX NA PILHA

    LEA BX, TABELA              ;COLOCA OFFSET DO ENDEREÇO EM BX
    XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL 
    XLAT                        ;CONVERTE CONTEÚDO DE AL PARA O VALOR CORRESPONDENTE NA TABELA
    XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL

    POP BX                      ;RETORNA VALOR DE BX DA PILHA

    SHL BX, 4               ;DESLOCA BX 4 BITS PARA A ESQUERDA
    INT 21H                 ;IMPRIME CARACTERE ARMAZENADO EM DL
    LOOP LOOP_IMPRIME ; CONTINUA ATÉ QUE TODOS OS BITS TENHAM SIDO PROCESSADOS

    RET
    SAIHEX ENDP


ENTBIN PROC

    XOR BX, BX ; LIMPA BX
    MOV AH, 1

WILE1:
    INT 21H ; LE O NUMERO INSERIDO
    CMP AL, 13
    JE ENTBINFIM; SE O NUMERO INSERIDO FOR O CR(13) ELE PULA
    CMP AL, '0'       
    JE ZERO
    SHL BX, 1     ; DESLOCA BX 1 CASA PARA A ESQUERDA
    OR BX, 1    ; INSERE 1 NO LSB
    JMP WILE1  ; VOLTA PARA RECEBER MAIS CARACTERES

ZERO:
    SHL BX, 1    ; DESLOCA BX 1 CASA PARA A ESQUERDA E ADICIONA 0 EM LSB
    JMP WILE1    ; VOLTA PARA RECEBER MAIS CARACTERES

ENTBINFIM:
    RET
ENTBIN ENDP

SAIBIN PROC
    MOV AH, 02h        ; FUNÇÃO PARA IMPRIMIR CARACTERE
    MOV CX, 16 ; DEFINE O CONTADOR COMO 16

IMPRIME_LOOP:
    ROL BX, 1          ; DESLOCA BX 1 CASA PARA A ESQUERDA
    JC UM_CARRY        ; VERIFICA SE O CARRY É 1, SE FOR PULA PARA IMPRIMIR UM
    MOV DL, '0'         ;SE NAO IMPRIME ZERO
    JMP IMPRIME1

UM_CARRY:
    MOV DL, '1'

IMPRIME1:
    INT 21H            ; IMPRIME O CARACTERE
    LOOP IMPRIME_LOOP  ; REPETE PARA O PRÓXIMO BIT

RET
SAIBIN ENDP

END MAIN