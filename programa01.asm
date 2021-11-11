#-----------------------------------------------------------------------------------------------------------------------------
# ALUNO: ENZO GUIDO AMERICANO DA COSTA       MATRICULA: 202000560432
#-----------------------------------------------------------------------------------------------------------------------------

.data #contém as mensagens de texto que serão printadas no programa

msg1: .asciiz "\nEntre com um valor inteiro (N>1): "
msg2: .asciiz "O valor digitado N tem que ser maior que 1.\n"
msg3: .asciiz "A soma dos inteiros de 1 até N é: "
msg4: .asciiz "\n"

.text #contém as funções que serão utilizadas no programa

main: #branch main, inicializa o endereço $t0, $t1 e $t2 para 0 e pula para a branch "read" sem nenhuma condição
	add $t0,$zero,$zero #zera o valor contido em $t0, $t0 irá armazenar o valor N inserido
	add $t1,$zero,$zero #zera o valor contido em $t1, $t1 irá armazenar a soma dos valores de 1 a N
	add $t2,$zero,$zero #zera o valor contido em $t2, $t2 irá servir como contador da soma (1 a N)
	j read #pula para a branch "read"
	
	read: #branch read, realiza a leitura de N que será inserido no terminal
		li $v0,4 #código syscall para imprimir strings
		la $a0,msg1 #carrega o endereço de msg1 em a0
		syscall #emite uma chamada do sistema
		li $v0,5 #código syscall para ler inteiros, fará a leitura de N
		syscall #emite uma chamada do sistema
		add $t0,$v0,$zero #valor de $t0 recebe $v0 (N)
		j compare #pula para a branch "compare"
		
	compare: #compara se o valor contido em $t0 (N) é maior do que um
		add $k0,$zero,$zero #zera o valor contido em $k0, $k0 irá servir como condicional para caso N > 1
		sub $k0,$t0,1 #k0 recebe o valor de t0 menos 1
		blez $k0,error #caso o valor em $k0 seja menor ou igual a 1, pula para a branch "error"
		j factorial #pula para a branch "factorial" caso o valor N em $t0 seja válido
		
	error: #caso o valor N inserido em $t0 seja menor ou igual a zero
		li $v0,4 #código syscall para imprimir strings
		la $a0,msg2 #carrega o endereço de msg2 em a0
		syscall #emite uma chamada do sistema
		j read #pula para a branch "read", realiza outra leitura de N até ser um valor válido
		
	factorial: #loop de soma dos valores de 1 a N
		add $t2,$t2,1 #adiciona 1 ao contador
		add $t1,$t1,$t2 #como o contador também representa a sequência dos numeros naturais até N, $t1 (soma dos valores inteiros de 1 até N) recebe o próprio valor mais contador ($t2)
		bne $t2,$t0,factorial #caso $t2 (contador) seja diferente de $t0 (N) volta para a branch factorial, até ser igual e terminar o programa
		j ending #pula para a branch "ending"
		
	ending: #final do programa, imprime a mensagem final com o valor da soma de 1 até N armazenado em $t1
		li $v0,4 #código syscall para imprimir strings
		la $a0,msg3 #carrega o endereço de msg3 em a0
		syscall #emite uma chamada do sistema
		li $v0,1 #código syscall para imprimir inteiros
		add $a0,$t1,$zero #$a0 recebe o valor de $t1 (soma dos valores inteiros de 1 até N) e imprime no terminal
		syscall #emite uma chamada do sistema
		li $v0,4 #código syscall para imprimir strings
		la $a0,msg4 #carrega o endereço de msg4 em a0
		syscall #emite uma chamada do sistema
		
	
