.data
msj: .asciiz "\n HOSGELDINIZ "
msj1.1: .asciiz"\n ilk sayinin tam kismi:"
msj1.2: .asciiz "\n ilk sayinin ondalik kismi:"
msj2: .asciiz"\n Operator girin(+, -, *):"
msj3.1: .asciiz"\n ikinci sayinin tam kismi:"
msj3.2: .asciiz"\n ikinci sayinin ondalik kismi:"
errormsj: .asciiz "\n yanlis format,program sonlaniyor..."
newline: .asciiz"\n"
word: .word 4
dot: .byte '.'

.text
	main:
		li $s5, -9999
		li $s6, -1		

		li $v0, 4 
		la $a0, msj #baslangic 
		syscall
	
		jal read #userdan input girisleri
		li $v0, 10 
		syscall	
	
	read:	
		li $v0, 4
		la $a0, msj1.1 
		syscall
		
		li $v0, 5  #ilk integerin tam kismi ve kontrolu
		syscall
		move $s1, $v0
		beq $s1, $s5, exit 
		
		li $v0, 4
		la $a0, msj1.2 
		syscall
		
		li $v0, 5 #ilk integerin ondalik kismi
		syscall
		move $s2, $v0
		blt $s2, $zero, exit 
		beq $s2, $s5, exit 
		
		li $v0, 4
		la $a0, msj2 
		syscall
		
		li $v0, 12 #operator okuma
		syscall
		move $s0, $v0
		
		li $v0, 4
		la $a0, msj3.1 
		syscall
		
		li $v0, 5 #ikinci integerin tam kismi
		syscall
		move $s3, $v0
		beq $s3, $s5, exit 
		
		li $v0, 4
		la $a0, msj3.2 
		syscall
		
		li $v0, 5 #ikinci integerin ondalik kismi
		syscall
		move $s4, $v0
		blt $s4, $zero, exit 
		beq $s4, $s5, exit 
		
		#operatore gore yonlendirme
		beq $s0, '+', addition 
		beq $s0, '-', addition 
		beq $s0, '*', multiply
		
		jr $ra
	#hata alirsa cikis labeli	
	exit:
		li $v0, 4
		la $a0, errormsj 
		syscall
		li $v0, 10 
		syscall		
		
		
	multiply:
		
		#ilk sayinin basamak sayisini t2ye atar
		li $t7, 0
		move $t0, $s2
		jal basamakbul 
		move $t2, $t7
		#ikinci sayinin basamak sayisini t4ye atar
		li $t7, 0
		move $t0, $s4
		jal basamakbul 
		move $t4, $t7	
		add $a2, $t2, $t4 #basamak sayilari toplamini a2ye atar
		
		#ilk sayi negatifse pozitif yapip ondalik ve tam kismi birlestirir.t8e atar.
		move $t3, $t2
		li $t6, 10 
		li $t7, 0 
		move $t0, $s1
		blt $t0, $zero, domult
		j elsemult
	domult:
		jal negatifyap
	elsemult:			
		jal butunsayiyacevir
		add $t8, $t0, $s2
		
		#ikinci sayi negatifse pozitif yapip ondalik ve tam kismi birlestirir.t9e atar.
		move $t3, $t4
		li $t6, 10 
		li $t7, 0 
		move $t0, $s3
		blt $t0, $zero, domul
		j elsemul
	domul:
		jal negatifyap
	elsemul:			
		jal butunsayiyacevir
		add $t9, $t0, $s4
		
		j multipleresultprint
		
	multipleresultprint:
		blt $s1, $zero , cevir
		j elsecevir
		cevir: 
			move $t0, $t8
			jal negatifyap #sonuc negatifse islem icin pozitif yapar.t8 e kopyalar
			move $t8, $t0
		elsecevir:
		
		blt $s3, $zero , cevir2
		j elsecevir2
		cevir2:
			move $t0, $t9
			jal negatifyap#sonuc negatifse islem icin pozitif yapar.t9 a kopyalar
			move $t9, $t0
		elsecevir2:		
				
		mult $t8, $t9
		mflo $s7#sonuucn s7ye alinmasi
		sonucuduzenlebas:
			move $t0, $s7
			li $t3, 0
			li $t7, 1
			li $t6, 10
			#birlesik sayisi ekrana basmak icin parcalama bolumu
			kaydir:
				mult $t7, $t6	
				mflo $t7
				add, $t3, $t3, 1
				bne $t3, $a2, kaydir
				div $t0, $t7
				mflo $t7 	
				mfhi $t3 
				move $t1,$t3
				blt $t3, $zero negatif
				jal elsenegatif
			negatif:
				move $t0, $t3
				jal negatifyap
				move $t3, $t0
			elsenegatif:
				
				beq $t7, $zero, myy
				j myelsee
				#tam kismin 0, ondalik kismin negatif ise duzenleme
				myy:
				blt $t1, $zero , aa
				j elseaa
				aa:
					li $v0, 11
					li $a0, '-'
					syscall	
				elseaa:
			
				myelsee:
			
				#ekrana basma
				li $v0, 1
				move $a0, $t7
				syscall
				li $v0, 4
				la $a0, dot
				syscall
				
				
				#sonucun  basamak sayisi
				li $t7, 0
				move $t0, $t3
				jal basamakbul
				move $t2, $t7 
				
				#bazi izlemlerde 0 basilmasi gerekiyo.
				#eksik bastigi icin duzenleme.t7 kac sifir basilmasi gerektigi
				sub $t7, $a2, $t2 
				
				beq $t7, $zero, asagiatla
				li $t9, 0
				dondur:
					
					li $v0,1
					li $a0, 0
					syscall
						
					add $t9, $t9, 1
					bne $t9, $t7, dondur
				
				asagiatla:		
							
				li $v0, 1
				move $a0, $t3				
				syscall						
				
				li $v0, 10 
				syscall
		
		
	addition:
		#ilk sayinin ondalik kismi basamak sayisi
		li $t7, 0
		move $t0, $s2
		jal basamakbul 
		move $t2, $t7
		
		#ikinci sayinin ondalik kismi basamak sayisi
		li $t7, 0
		move $t0, $s4
		jal basamakbul 		
		move $t4, $t7
		
		#sayilardan ondalik kismin basamak sayisinin buyuk olanini belirleme
		beq $t4, $t2, addition1
		bne $t4, $t2, yap
		j yapma
		yap:
			blt $t4, $t2 yap2
			j yapma2
			yap2:
				sub $a3, $t2, $t4
				move $t4, $t2
				j addition2
			yapma2:
				sub $a3, $t4, $t2
				move $t2, $t4
				j addition3 			
		yapma:
			j addition1
	
	#t4 daha kucuk
	addition2: 
		#ilk sayinin ondalik ve tam kismi birlestirilmesi
		move $t3, $t2
		li $t6, 10 
		li $t7, 0 
		move $t0, $s1
		blt $t0, $zero, do5
		j else5
	do5:
		jal negatifyap
	else5:			
		jal butunsayiyacevir
		add $t8, $t0, $s2
		
		#ikinci sayinin ondalik ve tam kismi birlestirilmesi		
		move $t3, $t4
		li $t6, 10 
		li $t7, 0 
		move $t0, $s3
		blt $t0, $zero, do6 
		j else6
	do6:
		jal negatifyap
	else6:
		jal butunsayiyacevir
		move $t7, $s4 
		move $t6, $a3
		li $t5, 10
		jal ondalikcevirici #sayinin ondalik kismini diger ondalik kisma gore buyutuyor
		add $t9, $t0, $t7
		
		#sonuclar negatifse toplama islemi icin pozitif yaparlar
		move $t0, $t8
		blt $s1, $zero do7 
		move $t8, $t0
		j else7
	do7:
		jal negatifyap
		move $t8, $t0
	else7:	
		move $t0, $t9
		blt $s3, $zero do8
		move $t9, $t0
		j else8
	do8:		
		jal negatifyap
		move $t9, $t0
	else8:			
		j printresult
	
	#t2 daha kucuk
	addition3:
		#ilk sayinin ondalik ve tam kismi birlestirilmesi	
		move $t3, $t2
		li $t6, 10 
		li $t7, 0 
		move $t0, $s1
		blt $t0, $zero, do9
		j else9
	do9:
		jal negatifyap
	else9:			
		jal butunsayiyacevir
		move $t7, $s2	
		move $t6, $a3
		li $t5, 10
		jal ondalikcevirici#sayinin ondalik kismini diger ondalik kisma gore buyutuyor			
		add $t8, $t0, $t7
		
		#ikinci sayinin ondalik ve tam kismi birlestirilmesi			
		move $t3, $t4
		li $t6, 10 
		li $t7, 0 
		move $t0, $s3
		blt $t0, $zero, do10 
		j else10
	do10:
		jal negatifyap
	else10:
		jal butunsayiyacevir
		add $t9, $t0, $s4
			 	
		#sonuclar negatifse toplama islemi icin pozitif yaparlar	 			 			 	
		move $t0, $t8
		blt $s1, $zero do11 
		move $t8, $t0
		j else11
	do11:
		jal negatifyap
		move $t8, $t0
	else11:	
		move $t0, $t9
		blt $s3, $zero do12
		move $t9, $t0
		j else12
	do12:		
		jal negatifyap
		move $t9, $t0
	else12:			
		j printresult
	
	#ondalik kisimlarin basamak sayisi esitse
	addition1:	
		#ilk sayinin ondalik ve tam kismi birlestirilmesi	
		move $t3, $t2
		li $t6, 10 
		li $t7, 0 
		move $t0, $s1
		blt $t0, $zero, do
		j else
	do:
		jal negatifyap
	else:			
		jal butunsayiyacevir				
		add $t8, $t0, $s2
		
		#ikinci sayinin ondalik ve tam kismi birlestirilmesi			
		move $t3, $t4
		li $t6, 10 
		li $t7, 0 
		move $t0, $s3
		blt $t0, $zero, do2 
		j else2
	do2:
		jal negatifyap
	else2:
		jal butunsayiyacevir
		add $t9, $t0, $s4
			 			 	
		#sonuclarin toplanmasi icin templerin negatif degerlerini pozitif deger yapar
		move $t0, $t8
		blt $s1, $zero do3 
		move $t8, $t0
		j else3
	do3:
		jal negatifyap
		move $t8, $t0
	else3:	
		
		move $t0, $t9
		blt $s3, $zero do4
		move $t9, $t0
		j else4
	do4:		
		jal negatifyap
		move $t9, $t0
	else4:			
		j printresult		
	
	#bu label hem toplama hem cikarma islemi icin calisir
	printresult:
		beq $s0, '+', toplamayap
		j cikarmayap
	toplamayap: 
		add $s7, $t8, $t9
		j atlaaa
	cikarmayap:
		sub $s7, $t8, $t9
	atlaaa:	
		ble $t2, $t4, atla
		j baskayereatla
	atla:
		move $t0, $s7
		li $t3, 0
		li $t7, 1
		li $t6, 10
		addi $t4, $t4, 0
		#noktanin koyulcak yerin belirlenmesi
		kaydir1:
			mult $t7, $t6	
			mflo $t7
			add, $t3, $t3, 1
			bne $t3, $t4, kaydir1
			div $t0, $t7
			mflo $t7 	
			mfhi $t3 
			move $t1, $t3
			blt $t3, $zero negatif1
			jal elsenegatif1
		negatif1:
			move $t0, $t3
			jal negatifyap
			move $t3, $t0
		elsenegatif1:
			
			beq $t7, $zero, my
			j myelse
		#tam kismin 0, ondalik kismin negatif ise duzenleme
		my:
			blt $t1, $zero , a
			j elsea
			a:
				li $v0, 11
				li $a0, '-'
				syscall	
			elsea:
			
		myelse:
			
			li $v0, 1
			move $a0, $t7
			syscall
			li $v0, 4
			la $a0, dot
			syscall
			
				#ondalik kisimda eksik 0lari tamamlamak icin
				li $t7, 0
				move $t0, $t3
				jal basamakbul  
				move $t1, $t7 
				
				move  $a2, $t4
				sub $t7, $a2, $t1 
				
				beq $t7, $zero, asagiatla2
				li $t9, 0
				dondur2:
					
					li $v0,1
					li $a0, 0
					syscall
						
					add $t9, $t9, 1
					bne $t9, $t7, dondur2
				
				asagiatla2:	
			
			
			li $v0, 1
			move $a0, $t3				
			syscall						
			
			li $v0, 10 
			syscall
		
	baskayereatla:
		move $t0, $s7
		li $t3, 0
		li $t7, 1
		li $t6, 10
		addi $t2, $t2, 0
		#noktanin koyulcak yerin belirlenmesi
		kaydir2:
			mult $t7, $t6	
			mflo $t7
			add, $t3, $t3, 1
			bne $t3, $t2, kaydir2
			div $t0, $t7
			mflo $t7 	
			mfhi $t3
			move $t1, $t3 
			blt $t3, $zero negatif2
			jal elsenegatif2
		negatif2:
			move $t0, $t3
			jal negatifyap
			move $t3, $t0
		elsenegatif2:
		
			beq $t7, $zero, my1
			j myelse1
		#tam kismin 0, ondalik kismin negatif ise duzenleme
		my1:
			blt $t1, $zero , ax
			j elsea1
			ax:
				li $v0, 11
				li $a0, '-'
				syscall	
			elsea1:
			
		myelse1:
			
			li $v0, 1
			move $a0, $t7
			syscall
			li $v0, 4
			la $a0, dot
			li $t7, 0
				
				#ondalik kisimda eksik 0lari tamamlamak icin
				move $t0, $t3
				jal basamakbul  
				move $t1, $t7 
				
				move  $a2, $t2
				sub $t7, $a2, $t1 
				
				beq $t7, $zero, asagiatla3
				li $t9, 0
				dondur3:
					
					li $v0,1
					li $a0, 0
					syscall
						
					add $t9, $t9, 1
					bne $t9, $t7, dondur3
				
				asagiatla3:
			
			
			syscall
			li $v0, 1
			move $a0, $t3				
			syscall						
			
			li $v0, 10 
			syscall
	
	butunsayiyacevir:
		mult $t0, $t6
		mflo $t0
		addi $t7, $t7, 1
		bne $t7, $t3, butunsayiyacevir  	
		jr $ra				
	
	basamakbul:
		li $t6, 10
		div $t0, $t6
		mflo $t0
		
		addi $t7, $t7, 1
		bne $t0, $zero, basamakbul 
		jr $ra
		
	negatifyap:
		li $t5, -1
		mult $t0, $t5
		mflo $t0
		jr $ra
		
	ondalikcevirici:
		mult $t7, $t5 
		mflo $t7
		  
		add $t6, $t6, -1
		bne $t6 $zero, ondalikcevirici
		jr $ra
