;No while, a condição é checada antes de entrar no loop, 
;então se a condição for falsa desde o começo, o código não imprime nada. 
;Já no repeat, o código dentro do loop sempre é executado pelo menos uma vez, 
;porque a condição é verificada só depois.
.model small
.stack 100h
.code
main proc
    mov ax, @data           
    mov ds, ax

    xor cx, cx; Zera o contador CX

    mov ah, 1  ; Função 01h  (ler caractere)

repeat_loop:
    inc cx ; Incrementa o contador antes da leitura (comportamento de repeat)

    int 21h ; Lê 
    cmp al, 13  ; Compara o caractere lido (AL) com 13 (CR - Carriage Return)
    jne repeat_loop ; Se não for CR, volta ao início do loop para ler o próximo caractere

    mov ah, 2 ; Função 02h (imprimir caractere)
    je fim ; Se for CR, salta para 'fim' 

fim:
    mov dl, '*' ; Coloca o caractere '*' no registrador DL para imprimir
    int 21h ; imprimir o caractere
    loop fim  ; Decrementa CX e repete se CX ainda for maior que 0

    mov ah, 4Ch  ; Função para sair do programa
    int 21h 

main endp
end main

