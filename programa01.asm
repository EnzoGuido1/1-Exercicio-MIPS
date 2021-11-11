#-----------------------------------------------------------------------------------------------------------------------------
# ALUNO: ENZO GUIDO AMERICANO DA COSTA       MATRICULA: 202000560432
#-----------------------------------------------------------------------------------------------------------------------------

.data #cont�m as mensagens de texto que ser�o printadas no programa

msg1: .asciiz "\nEntre com um valor inteiro (N>1): "
msg2: .asciiz "O valor digitado N tem que ser maior que 1.\n"
msg3: .asciiz "A soma dos inteiros de 1 at� N �: "
msg4: .asciiz "\n"

.text #cont�m as fun��es que ser�o utilizadas no programa

main: #branch main, inicializa o endere�o $t0, $t1 e $t2 para 0 e pula para a branch "read" sem nenhuma condi��o
	add $t0,$zero,$zero #zera o valor contido em $t0, $t0 ir� armazenar o valor N inserido
	add $t1,$zero,$zero #zera o valor contido em $t1, $t1 ir� armazenar a soma dos valores de 1 a N
	add $t2,$zero,$zero #zera o valor contido em $t2, $t2 ir� servir como contador da soma (1 a N)
	j read #pula para a branch "read"
	
	read: #branch read, realiza a leitura de N que ser� inserido no terminal
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg1 #carrega o endere�o de msg1 em a0
		syscall #emite uma chamada do sistema
		li $v0,5 #c�digo syscall para ler inteiros, far� a leitura de N
		syscall #emite uma chamada do sistema
		add $t0,$v0,$zero #valor de $t0 recebe $v0 (N)
		j compare #pula para a branch "compare"
		
	compare: #compara se o valor contido em $t0 (N) � maior do que um
		add $k0,$zero,$zero #zera o valor contido em $k0, $k0 ir� servir como condicional para caso N > 1
		sub $k0,$t0,1 #k0 recebe o valor de t0 menos 1
		blez $k0,error #caso o valor em $k0 seja menor ou igual a 1, pula para a branch "error"
		j factorial #pula para a branch "factorial" caso o valor N em $t0 seja v�lido
		
	error: #caso o valor N inserido em $t0 seja menor ou igual a zero
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg2 #carrega o endere�o de msg2 em a0
		syscall #emite uma chamada do sistema
		j read #pula para a branch "read", realiza outra leitura de N at� ser um valor v�lido
		
	factorial: #loop de soma dos valores de 1 a N
		add $t2,$t2,1 #adiciona 1 ao contador
		add $t1,$t1,$t2 #como o contador tamb�m representa a sequ�ncia dos numeros naturais at� N, $t1 (soma dos valores inteiros de 1 at� N) recebe o pr�prio valor mais contador ($t2)
		bne $t2,$t0,factorial #caso $t2 (contador) seja diferente de $t0 (N) volta para a branch factorial, at� ser igual e terminar o programa
		j ending #pula para a branch "ending"
		
	ending: #final do programa, imprime a mensagem final com o valor da soma de 1 at� N armazenado em $t1
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg3 #carrega o endere�o de msg3 em a0
		syscall #emite uma chamada do sistema
		li $v0,1 #c�digo syscall para imprimir inteiros
		add $a0,$t1,$zero #$a0 recebe o valor de $t1 (soma dos valores inteiros de 1 at� N) e imprime no terminal
		syscall #emite uma chamada do sistema
		li $v0,4 #c�digo syscall para imprimir strings
		la $a0,msg4 #carrega o endere�o de msg4 em a0
		syscall #emite uma chamada do sistema
		
	
