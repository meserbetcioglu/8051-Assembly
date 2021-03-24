ORG 000H
	
	START:
		MOV P1,#00H
		MOV R1,#12D
		MOV R2,#10D
		MOV R3,#9D
		MOV R4,#8D
		MOV R5,#7D
	MAINLOOP:
		ACALL DELAY
		DJNZ R1,SKIP1
		CPL P1.1
		MOV R1,#12D
	SKIP1:
		DJNZ R2,SKIP2
		CPL P1.2
		MOV R2,#10D
	SKIP2:
		DJNZ R3,SKIP3
		CPL P1.3
		MOV R3,#9D
	SKIP3:
		DJNZ R4,SKIP4
		CPL P1.4
		MOV R4,#8D
	SKIP4:
		DJNZ R5,SKIP5
		CPL P1.5
		MOV R5,#7D
	SKIP5:
		SJMP MAINLOOP


	DELAY:
		MOV R6,#1
		MOV TMOD,#01H
	DELAYLOOP:
		MOV TL0,#209
		MOV TH0,#254
		SETB TR0
	AGAIN:
		JNB TF0, AGAIN
		CLR TR0
		CLR TF0
		DJNZ R6,DELAYLOOP
		RET
END
			