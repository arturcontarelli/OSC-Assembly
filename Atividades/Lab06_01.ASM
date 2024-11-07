.model small
.stack 100h
.code
main proc
    mov ax, @data        
    mov ds, ax

    xor cx, cx ; Zera o contador CX 

    mov ah, 1 ; Ler caractere

while_loop:
    int 21h  ; Lê um caractere do teclado e coloca em AL
    cmp al, 13   ; Compara o caractere lido com 13 (CR - Carriage Return)
    je verifica_zero  ; Se for CR, salta para 'verifica_zero'
    
    inc cx   ; incrementa o contador
    jmp while_loop; Volta ao início do loop para ler o próximo caractere

verifica_zero:
    cmp cx, 0 ; Compara CX com 0 
    jz fim  ; Se CX for 0, salta para 'fim' (sem caracteres para imprimir)
    
    mov ah, 2 ; Função 02h  (imprimir caractere)
    mov dl, '*' ; Coloca o caractere '*' no registrador DL para imprimir

imprime:
    
    int 21h ;imprimir o caractere
    loop imprime ; Decrementa CX e repete se CX ainda for maior que 0

fim:
    mov ah, 4Ch ; Função para sair do programa
    int 21h               

main endp
end main
