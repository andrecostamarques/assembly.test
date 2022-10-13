.model small
.data
    msg db "Entre com o primeiro numero:$"
    msg2 db "Entre com o segundo numero:$"
    msg3 db "Maior numero:$"
    msg4 db "Menor numero:$"
    msgpar1 db "Paridade: Par$"
    msgpar0 db "Paridade: Impar$"
.code
main proc
    MOV AX,@DATA
    MOV DS,AX   ;inicializa a data

    MOV AH,09H  ;imprimir buffer
    LEA DX,msg  ;seta a primeira frase 
    INT 21H

    MOV AH,01   ;pegando input
    INT 21H
    MOV BH,AL   ;mandando input pra bh

    MOV AH,02   ;pulando linha
    MOV DL,10
    INT 21H

    MOV AH,09H  ;printando buffer
    LEA DX,msg2 ;setando segunda frase
    INT 21H

    MOV AH,01   ;pegando input
    INT 21H
    MOV BL,AL   ;mandando input pra bl

    MOV AH,02
    MOV DL,10   ;´pulandno linha
    INT 21H

    CMP BH,BL   ;compara bh com bl
    JNLE MANTEVE    ;se bh for maior ou igual nao troca (importante, isso troca a flag de paridade!)
    XCHG BH,BL  ;se bl for maior, troca com bh
    MANTEVE: 

    
    MOV AH,09H  ;printando o maior numero
    LEA DX,msg3
    INT 21H     

    MOV AH,02   ;printando bh, o maior numero 
    MOV DL,BH
    INT 21H

    MOV AH,02   ;pulando linha
    MOV DL,10
    INT 21H

    ADD BH,0 ;verifica se bh vai ter paridade > O flag de paridade vai ver o resultado de bl + 0 =  ou seja vai falar de bl


    JNP IMPAR1   
    MOV AH,09H  ;ta printando a mensagem de par
    LEA DX,msgpar1
    INT 21H
    JP PAR1;vai pular pro final se for par, ou seja, printou que é par e vai pular a parte que printa falando que é impar

    IMPAR1: ;vai pular para impar se a paridade for impar     
    MOV AH,09H  ;printando a mensagem de impar
    LEA DX,msgpar0
    INT 21H
    PAR1:

    MOV AH,02
    MOV DL,10   ;pulando linha
    INT 21H

    MOV AH,09H
    LEA DX,msg4 ;printando menor numero frase
    INT 21H     

    MOV AH,02
    MOV DL,BL ;printando o menor numero
    INT 21H
    MOV AH,02
    MOV DL,10   ;pulando linha
    INT 21H

    ADD BL,0   ;verifica se bl vai ter paridade > O flag de paridade vai ver o resultado de bl + 0 =  ou seja vai falar de bl

    JNP IMPAR2  ;vai pular para o par se a paridade estiver par
    MOV AH,09H  ;ta printando a mensagem de par
    LEA DX,msgpar1
    INT 21H
    JP PAR2

    IMPAR2: ;vai pular para impar se a paridade for impar     
    MOV AH,09H  ;printando a mensagem de impar
    LEA DX,msgpar0
    INT 21H
    PAR2:
    
    MOV AH,4CH
    INT 21H ;finaliza o programa 


    main endp
    end main