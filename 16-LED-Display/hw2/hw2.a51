ORG 000H
	
	START:
		MOV P0,#00H
		MOV P2,#00H
		MOV P3,#00H
		MOV R2,#0D
		MOV R0,#22D
		SJMP SKIPSTARTDELAY
	LOOP1:
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		NOP
		INC R2
		INC R2
	SKIPSTARTDELAY:
		ACALL DELAY
		MOV R1,#11D
		MOV DPTR,#300H
	LOOP2:
		MOV P0,R1
		MOV A,R2
		MOVC A,@A+DPTR
		MOV P2,A
		INC DPTR
		MOV A,R2
		MOVC A,@A+DPTR
		MOV P3,A
		INC DPTR
		DJNZ R1,LOOP2
		DJNZ R0,LOOP1
		SJMP START
		
ORG 300H
	DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,0E1H,87H,0E1H,43H,0E5H,0C4H,0E5H,0C7H,0E1H,43H,0C8H,10H,0E0H,43H,0C8H,13H,0E2H,47H,0E0H,0C7H,20H,43H,22H,47H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
		
	DELAY:
		ACALL DELAY1
		ACALL DELAY2
		MOV R5,#15
		MOV TMOD,#01
	DELAYLOOP:
		MOV TL0,#0
		MOV TH0,#0
		SETB TR0
	AGAIN:
		JNB TF0, AGAIN
		CLR TR0
		CLR TF0
		DJNZ R5,DELAYLOOP
		RET
		
	DELAY1:
		MOV R5,#200D
	LABEL1:
		ACALL DEL1
		DJNZ R5,LABEL1
		RET
	DEL1:
		MOV R6,#23D
	DEL1LOOP:
		DJNZ R6,DEL1LOOP
		RET
		
	DELAY2:
		MOV R5,#196D
	LABEL2:
		ACALL DEL2
		DJNZ R5,LABEL2
		RET
	DEL2:
		MOV R6,#14D
	DEL2LOOP:
		DJNZ R6,DEL2LOOP
		RET