

	.FUNCT	PARSER,PTR,WRD,VAL,VERB,OMERGED,OWINNER,LEN,DIR,NW,LW,CNT,?TMP2,?TMP1
	SET	'PTR,P-LEXSTART
	SET	'CNT,-1
?PRG1:	IGRTR?	'CNT,P-ITBLLEN /?REP2
	ZERO?	P-OFLAG \?CND6
	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
?CND6:	PUT	P-ITBL,CNT,0
	JUMP	?PRG1
?REP2:	SET	'OMERGED,P-MERGED
	SET	'OWINNER,WINNER
	SET	'P-MERGED,FALSE-VALUE
	PUT	P-PRSO,P-MATCHLEN,0
	PUT	P-PRSI,P-MATCHLEN,0
	PUT	P-BUTS,P-MATCHLEN,0
	ZERO?	QUOTE-FLAG \?CND8
	EQUAL?	WINNER,ADVENTURER /?CND8
	SET	'WINNER,ADVENTURER
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND12
	LOC	WINNER >HERE
?CND12:	CALL2	LIT?,HERE >LIT
?CND8:	ZERO?	RESERVE-PTR /?CCL16
	SET	'PTR,RESERVE-PTR
	ICALL	STUFF,P-LEXV,RESERVE-LEXV
	ICALL	INBUF-STUFF,P-INBUF,RESERVE-INBUF
	ZERO?	SUPER-BRIEF \?CND17
	EQUAL?	ADVENTURER,WINNER \?CND17
	CRLF	
?CND17:	SET	'RESERVE-PTR,FALSE-VALUE
	SET	'P-CONT,FALSE-VALUE
	JUMP	?CND14
?CCL16:	ZERO?	P-CONT /?CCL22
	SET	'PTR,P-CONT
	EQUAL?	ADVENTURER,WINNER \?CND14
	ZERO?	SUPER-BRIEF \?CND14
	CRLF	
	JUMP	?CND14
?CCL22:	SET	'WINNER,ADVENTURER
	SET	'QUOTE-FLAG,FALSE-VALUE
	LOC	WINNER
	FSET?	STACK,VEHBIT /?CND27
	LOC	WINNER >HERE
?CND27:	CALL2	LIT?,HERE >LIT
	ZERO?	SUPER-BRIEF \?PRG31
	CRLF	
?PRG31:	ICALL1	UPDATE-STATUS-LINE
	PRINTC	62
	PUTB	P-INBUF,1,0
	READ	P-INBUF,P-LEXV
	GETB	P-LEXV,P-LEXWORDS >P-INPUT-WORDS
?CND14:	GETB	P-LEXV,P-LEXWORDS >P-LEN
	ZERO?	P-LEN \?CCL35
	PRINTI	"I beg your pardon?"
	CRLF	
	RFALSE	
?CCL35:	GET	P-LEXV,PTR
	EQUAL?	STACK,W?OOPS,W?O \?CCL37
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?PERIOD,W?COMMA \?CND38
	ADD	PTR,P-LEXELEN >PTR
	DEC	'P-LEN
?CND38:	GRTR?	P-LEN,1 /?CCL42
	ICALL2	CANT-USE-THAT-WAY,STR?7
	RFALSE	
?CCL42:	GET	OOPS-TABLE,O-PTR
	ZERO?	STACK /?CCL44
	GRTR?	P-LEN,2 \?CND45
	PRINTI	"[Warning: Only the first word after OOPS is used.]"
	CRLF	
?CND45:	GET	OOPS-TABLE,O-PTR >?TMP1
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	PUT	AGAIN-LEXV,?TMP1,STACK
	SET	'WINNER,OWINNER
	MUL	PTR,P-LEXELEN
	ADD	STACK,6
	GETB	P-LEXV,STACK >?TMP2
	MUL	PTR,P-LEXELEN
	ADD	STACK,7
	GETB	P-LEXV,STACK >?TMP1
	GET	OOPS-TABLE,O-PTR
	MUL	STACK,P-LEXELEN
	ADD	STACK,3
	ICALL	INBUF-ADD,?TMP2,?TMP1,STACK
	ICALL	STUFF,P-LEXV,AGAIN-LEXV
	GETB	P-LEXV,P-LEXWORDS >P-LEN
	GET	OOPS-TABLE,O-START >PTR
	ICALL	INBUF-STUFF,P-INBUF,OOPS-INBUF
	JUMP	?CND33
?CCL44:	PUT	OOPS-TABLE,O-END,FALSE-VALUE
	PRINTI	"[There was no word to replace!]"
	CRLF	
	RFALSE	
?CCL37:	ZERO?	P-CONT \?CND33
	PUT	OOPS-TABLE,O-END,FALSE-VALUE
?CND33:	SET	'P-CONT,FALSE-VALUE
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?AGAIN,W?G \?CCL50
	ZERO?	P-OFLAG /?CCL53
	ICALL2	CANT-USE-THAT-WAY,STR?8
	RFALSE	
?CCL53:	ZERO?	P-WON \?CCL55
	PRINTI	"[That would just repeat a mistake!]"
	CRLF	
	RFALSE	
?CCL55:	EQUAL?	OWINNER,ADVENTURER /?CCL57
	CALL2	VISIBLE?,OWINNER
	ZERO?	STACK \?CCL57
	PRINTI	"[You can't see "
	PRINTD	OWINNER
	PRINTI	" any more.]"
	CRLF	
	RFALSE	
?CCL57:	GRTR?	P-LEN,1 \?CCL61
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?PERIOD,W?COMMA,W?THEN /?CTR63
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK
	EQUAL?	STACK,W?AND \?CCL64
?CTR63:	ADD	PTR,4 >PTR
	GETB	P-LEXV,P-LEXWORDS
	SUB	STACK,2
	PUTB	P-LEXV,P-LEXWORDS,STACK
	JUMP	?CND51
?CCL64:	SET	'P-WON,FALSE-VALUE
	PRINTI	"[That sentence isn't one I recognize.]"
	CRLF	
	RFALSE	
?CCL61:	ADD	PTR,P-LEXELEN >PTR
	GETB	P-LEXV,P-LEXWORDS
	SUB	STACK,1
	PUTB	P-LEXV,P-LEXWORDS,STACK
?CND51:	GETB	P-LEXV,P-LEXWORDS
	GRTR?	STACK,0 \?CCL69
	ICALL	STUFF,RESERVE-LEXV,P-LEXV
	ICALL	INBUF-STUFF,RESERVE-INBUF,P-INBUF
	SET	'RESERVE-PTR,PTR
	JUMP	?CND67
?CCL69:	SET	'RESERVE-PTR,FALSE-VALUE
?CND67:	SET	'WINNER,OWINNER
	SET	'P-MERGED,OMERGED
	ICALL	INBUF-STUFF,P-INBUF,OOPS-INBUF
	ICALL	STUFF,P-LEXV,AGAIN-LEXV
	SET	'CNT,-1
	SET	'DIR,AGAIN-DIR
?PRG70:	IGRTR?	'CNT,P-ITBLLEN /?CND48
	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG70
?CCL50:	ICALL	STUFF,AGAIN-LEXV,P-LEXV
	ICALL	INBUF-STUFF,OOPS-INBUF,P-INBUF
	PUT	OOPS-TABLE,O-START,PTR
	MUL	4,P-LEN
	PUT	OOPS-TABLE,O-LENGTH,STACK
	GETB	P-LEXV,P-LEXWORDS
	MUL	P-LEXELEN,STACK
	ADD	PTR,STACK
	MUL	2,STACK >LEN
	GET	OOPS-TABLE,O-END
	ZERO?	STACK \?CND75
	SUB	LEN,1
	GETB	P-LEXV,STACK >?TMP1
	SUB	LEN,2
	GETB	P-LEXV,STACK
	ADD	?TMP1,STACK
	PUT	OOPS-TABLE,O-END,STACK
?CND75:	SET	'RESERVE-PTR,FALSE-VALUE
	SET	'LEN,P-LEN
	SET	'P-NCN,0
	SET	'P-GETFLAGS,0
?PRG77:	DLESS?	'P-LEN,0 \?CCL81
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND48
?CCL81:	GET	P-LEXV,PTR >WRD
	ZERO?	WRD \?CTR82
	CALL2	NUMBER?,PTR >WRD
	ZERO?	WRD /?CCL83
?CTR82:	CALL2	NEXT-WORD,PTR >NW
	EQUAL?	WRD,W?TO \?CCL88
	EQUAL?	VERB,ACT?TELL \?CCL88
	SET	'WRD,W?QUOTE
	JUMP	?CND86
?CCL88:	EQUAL?	WRD,W?THEN \?CND86
	GRTR?	P-LEN,0 \?CND86
	ZERO?	VERB \?CND86
	ZERO?	QUOTE-FLAG \?CND86
	PUT	P-ITBL,P-VERB,ACT?TELL
	PUT	P-ITBL,P-VERBN,0
	SET	'WRD,W?QUOTE
?CND86:	EQUAL?	WRD,W?THEN,W?PERIOD /?CTR97
	EQUAL?	WRD,W?QUOTE \?CCL98
?CTR97:	EQUAL?	WRD,W?QUOTE \?CND101
	ZERO?	QUOTE-FLAG /?CCL105
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND101
?CCL105:	SET	'QUOTE-FLAG,TRUE-VALUE
?CND101:	ZERO?	P-LEN /?PEN106
	ADD	PTR,P-LEXELEN >P-CONT
?PEN106:	PUTB	P-LEXV,P-LEXWORDS,P-LEN
	JUMP	?CND48
?CCL98:	CALL	WT?,WRD,16,3 >VAL
	ZERO?	VAL /?CCL109
	EQUAL?	VERB,FALSE-VALUE,ACT?WALK \?CCL109
	EQUAL?	LEN,1 /?CTR108
	EQUAL?	LEN,2 \?PRD115
	EQUAL?	VERB,ACT?WALK /?CTR108
?PRD115:	EQUAL?	NW,W?THEN,W?PERIOD,W?QUOTE \?PRD118
	LESS?	LEN,2 \?CTR108
?PRD118:	ZERO?	QUOTE-FLAG /?PRD121
	EQUAL?	LEN,2 \?PRD121
	EQUAL?	NW,W?QUOTE /?CTR108
?PRD121:	GRTR?	LEN,2 \?CCL109
	EQUAL?	NW,W?COMMA,W?AND \?CCL109
?CTR108:	SET	'DIR,VAL
	EQUAL?	NW,W?COMMA,W?AND \?CND127
	ADD	PTR,P-LEXELEN
	ICALL	CHANGE-LEXV,STACK,W?THEN
?CND127:	GRTR?	LEN,2 /?CND79
	SET	'QUOTE-FLAG,FALSE-VALUE
	JUMP	?CND48
?CCL109:	CALL	WT?,WRD,64,1 >VAL
	ZERO?	VAL /?CCL132
	ZERO?	VERB \?CCL132
	SET	'P-PRSA-WORD,WRD
	SET	'VERB,VAL
	PUT	P-ITBL,P-VERB,VAL
	PUT	P-ITBL,P-VERBN,P-VTBL
	PUT	P-VTBL,0,WRD
	MUL	PTR,2
	ADD	STACK,2 >CNT
	GETB	P-LEXV,CNT
	PUTB	P-VTBL,2,STACK
	ADD	CNT,1
	GETB	P-LEXV,STACK
	PUTB	P-VTBL,3,STACK
	JUMP	?CND79
?CCL132:	CALL	WT?,WRD,8,0 >VAL
	ZERO?	VAL \?CTR135
	EQUAL?	WRD,W?ALL,W?ONE,W?BOTH /?CTR135
	CALL	WT?,WRD,32
	ZERO?	STACK \?CTR135
	CALL	WT?,WRD,128
	ZERO?	STACK /?CCL136
?CTR135:	GRTR?	P-LEN,0 \?CCL142
	EQUAL?	NW,W?OF \?CCL142
	ZERO?	VAL \?CCL142
	EQUAL?	WRD,W?ALL,W?ONE,W?A /?CCL142
	EQUAL?	WRD,W?AN,W?BOTH \?CND79
?CCL142:	ZERO?	VAL /?CCL149
	ZERO?	P-LEN /?CTR148
	EQUAL?	NW,W?THEN,W?PERIOD \?CCL149
?CTR148:	SET	'P-END-ON-PREP,TRUE-VALUE
	LESS?	P-NCN,2 \?CND79
	PUT	P-ITBL,P-PREP1,VAL
	PUT	P-ITBL,P-PREP1N,WRD
	JUMP	?CND79
?CCL149:	EQUAL?	P-NCN,2 \?CCL157
	PRINTI	"[There were too many nouns in that sentence.]"
	CRLF	
	RFALSE	
?CCL157:	INC	'P-NCN
	CALL	CLAUSE,PTR,VAL,WRD >PTR
	ZERO?	PTR /FALSE
	LESS?	PTR,0 \?CND79
	SET	'QUOTE-FLAG,FALSE-VALUE
?CND48:	PUT	OOPS-TABLE,O-PTR,FALSE-VALUE
	ZERO?	DIR /?CND168
	SET	'PRSA,V?WALK
	SET	'PRSO,DIR
	SET	'P-OFLAG,FALSE-VALUE
	SET	'P-WALK-DIR,DIR
	SET	'AGAIN-DIR,DIR
	RTRUE	
?CCL136:	CALL	WT?,WRD,4
	ZERO?	STACK \?CND79
	EQUAL?	VERB,ACT?TELL \?CCL164
	CALL	WT?,WRD,64,1
	ZERO?	STACK /?CCL164
	EQUAL?	WINNER,ADVENTURER \?CCL164
	PRINTI	"Consult your manual for how to talk to characters."
	CRLF	
	RFALSE	
?CCL164:	ICALL2	CANT-USE,PTR
	RFALSE	
?CCL83:	ICALL2	UNKNOWN-WORD,PTR
	RFALSE	
?CND79:	SET	'LW,WRD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG77
?CND168:	SET	'P-WALK-DIR,FALSE-VALUE
	SET	'AGAIN-DIR,FALSE-VALUE
	ZERO?	P-OFLAG /?CND170
	ICALL1	ORPHAN-MERGE
?CND170:	CALL1	SYNTAX-CHECK
	ZERO?	STACK /FALSE
	CALL1	SNARF-OBJECTS
	ZERO?	STACK /FALSE
	CALL1	MANY-CHECK
	ZERO?	STACK /FALSE
	CALL1	TAKE-CHECK
	ZERO?	STACK \TRUE
	RFALSE	


	.FUNCT	INBUF-STUFF,DEST,SRC,CNT
	SET	'CNT,-1
?PRG1:	IGRTR?	'CNT,80 /TRUE
	GETB	SRC,CNT
	PUTB	DEST,CNT,STACK
	JUMP	?PRG1


	.FUNCT	STUFF,DEST,SRC,MAX,PTR,CTR,BPTR
	ASSIGNED?	'MAX /?CND1
	SET	'MAX,39
?CND1:	SET	'PTR,P-LEXSTART
	SET	'CTR,1
	GETB	SRC,0
	PUTB	DEST,0,STACK
	GETB	SRC,1
	PUTB	DEST,1,STACK
?PRG3:	GET	SRC,PTR
	PUT	DEST,PTR,STACK
	MUL	PTR,2
	ADD	STACK,2 >BPTR
	GETB	SRC,BPTR
	PUTB	DEST,BPTR,STACK
	MUL	PTR,2
	ADD	STACK,3 >BPTR
	GETB	SRC,BPTR
	PUTB	DEST,BPTR,STACK
	ADD	PTR,P-LEXELEN >PTR
	IGRTR?	'CTR,MAX \?PRG3
	RTRUE	


	.FUNCT	NEXT-WORD,PTR,NW
	ZERO?	P-LEN /FALSE
	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
	ZERO?	NW /?CCL6
	RETURN	NW
?CCL6:	ADD	PTR,P-LEXELEN
	CALL2	NUMBER?,STACK
	RSTACK	


	.FUNCT	CHANGE-LEXV,PTR,WRD,PTRS?,X,Y,Z
	ZERO?	PTRS? /?CND1
	SUB	PTR,P-LEXELEN
	MUL	2,STACK
	ADD	2,STACK >X
	GETB	P-LEXV,X >Y
	MUL	2,PTR
	ADD	2,STACK >Z
	PUTB	P-LEXV,Z,Y
	PUTB	AGAIN-LEXV,Z,Y
	ADD	1,X
	GETB	P-LEXV,STACK >Y
	MUL	2,PTR
	ADD	3,STACK >Z
	PUTB	P-LEXV,Z,Y
	PUTB	AGAIN-LEXV,Z,Y
?CND1:	PUT	P-LEXV,PTR,WRD
	PUT	AGAIN-LEXV,PTR,WRD
	RTRUE	


	.FUNCT	WT?,PTR,BIT,B1,OFFST,TYP
	ASSIGNED?	'B1 /?CND1
	SET	'B1,5
?CND1:	SET	'OFFST,P-P1OFF
	GETB	PTR,P-PSOFF >TYP
	BTST	TYP,BIT \FALSE
	GRTR?	B1,4 /TRUE
	BAND	TYP,P-P1BITS >TYP
	EQUAL?	TYP,B1 /?CND9
	INC	'OFFST
?CND9:	GETB	PTR,OFFST
	RSTACK	


	.FUNCT	CLAUSE,PTR,VAL,WORD,OFF,NUM,ANDFLG,FIRST??,NW,LW,?TMP1
	SET	'FIRST??,TRUE-VALUE
	SUB	P-NCN,1
	MUL	STACK,2 >OFF
	ZERO?	VAL /?CCL3
	ADD	P-PREP1,OFF >NUM
	PUT	P-ITBL,NUM,VAL
	ADD	NUM,1
	PUT	P-ITBL,STACK,WORD
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND1
?CCL3:	INC	'P-LEN
?CND1:	ZERO?	P-LEN \?CND4
	DEC	'P-NCN
	RETURN	-1
?CND4:	ADD	P-NC1,OFF >NUM
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,NUM,STACK
	GET	P-LEXV,PTR
	EQUAL?	STACK,W?THE,W?A,W?AN \?PRG8
	GET	P-ITBL,NUM
	ADD	STACK,4
	PUT	P-ITBL,NUM,STACK
?PRG8:	DLESS?	'P-LEN,0 \?CND10
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	-1
?CND10:	GET	P-LEXV,PTR >WORD
	ZERO?	WORD \?CTR13
	CALL2	NUMBER?,PTR >WORD
	ZERO?	WORD /?CCL14
?CTR13:	ZERO?	P-LEN \?CCL19
	SET	'NW,0
	JUMP	?CND17
?CCL19:	ADD	PTR,P-LEXELEN
	GET	P-LEXV,STACK >NW
?CND17:	EQUAL?	WORD,W?AND,W?COMMA \?CCL22
	SET	'ANDFLG,TRUE-VALUE
	JUMP	?CND12
?CCL22:	EQUAL?	WORD,W?ALL,W?BOTH,W?ONE \?CCL24
	EQUAL?	NW,W?OF \?CND12
	DEC	'P-LEN
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?CND12
?CCL24:	EQUAL?	WORD,W?THEN,W?PERIOD /?CTR27
	CALL	WT?,WORD,8
	ZERO?	STACK /?CCL28
	ZERO?	FIRST?? \?CCL28
?CTR27:	INC	'P-LEN
	ADD	NUM,1 >?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	SUB	PTR,P-LEXELEN
	RSTACK	
?CCL28:	CALL	WT?,WORD,128
	ZERO?	STACK /?CCL34
	GRTR?	P-LEN,0 \?CCL37
	EQUAL?	NW,W?OF \?CCL37
	EQUAL?	WORD,W?ALL,W?ONE \?CND12
?CCL37:	CALL	WT?,WORD,32
	ZERO?	STACK /?CCL41
	ZERO?	NW /?CCL41
	CALL	WT?,NW,128
	ZERO?	STACK \?CND12
?CCL41:	ZERO?	ANDFLG \?CCL46
	EQUAL?	NW,W?BUT,W?EXCEPT /?CCL46
	EQUAL?	NW,W?AND,W?COMMA /?CCL46
	ADD	NUM,1 >?TMP1
	ADD	PTR,2
	MUL	STACK,2
	ADD	P-LEXV,STACK
	PUT	P-ITBL,?TMP1,STACK
	RETURN	PTR
?CCL46:	SET	'ANDFLG,FALSE-VALUE
	JUMP	?CND12
?CCL34:	ZERO?	P-OFLAG \?PRD52
	ZERO?	P-MERGED \?PRD52
	GET	P-ITBL,P-VERB
	ZERO?	STACK /?CCL50
?PRD52:	CALL	WT?,WORD,32
	ZERO?	STACK \?CND12
	CALL	WT?,WORD,4
	ZERO?	STACK \?CND12
?CCL50:	ZERO?	ANDFLG /?CCL59
	CALL	WT?,WORD,16
	ZERO?	STACK \?CTR58
	CALL	WT?,WORD,64
	ZERO?	STACK /?CCL59
?CTR58:	SUB	PTR,4 >PTR
	ADD	PTR,2
	PUT	P-LEXV,STACK,W?THEN
	ADD	P-LEN,2 >P-LEN
?CND12:	SET	'LW,WORD
	SET	'FIRST??,FALSE-VALUE
	ADD	PTR,P-LEXELEN >PTR
	JUMP	?PRG8
?CCL59:	CALL	WT?,WORD,8
	ZERO?	STACK \?CND12
	ICALL2	CANT-USE,PTR
	RFALSE	
?CCL14:	ICALL2	UNKNOWN-WORD,PTR
	RFALSE	


	.FUNCT	NUMBER?,PTR,CNT,BPTR,CHR,SUM,TIM,?TMP1
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,2 >CNT
	MUL	PTR,2
	ADD	P-LEXV,STACK
	GETB	STACK,3 >BPTR
?PRG1:	DLESS?	'CNT,0 /?REP2
	GETB	P-INBUF,BPTR >CHR
	GRTR?	SUM,10000 /FALSE
	LESS?	CHR,58 \FALSE
	GRTR?	CHR,47 \FALSE
	MUL	SUM,10 >?TMP1
	SUB	CHR,48
	ADD	?TMP1,STACK >SUM
	INC	'BPTR
	JUMP	?PRG1
?REP2:	PUT	P-LEXV,PTR,W?INTNUM
	GRTR?	SUM,10000 /FALSE
	SET	'P-NUMBER,SUM
	RETURN	W?INTNUM


	.FUNCT	ORPHAN-MERGE,CNT,TEMP,VERB,BEG,END,ADJ,WRD,?TMP1
	SET	'CNT,-1
	SET	'P-OFLAG,FALSE-VALUE
	GET	P-ITBL,P-VERBN
	GET	STACK,0 >WRD
	CALL	WT?,WRD,32
	ZERO?	STACK /?CCL3
	SET	'ADJ,TRUE-VALUE
	JUMP	?CND1
?CCL3:	CALL	WT?,WRD,128
	ZERO?	STACK /?CND1
	ZERO?	P-NCN \?CND1
	PUT	P-ITBL,P-VERB,0
	PUT	P-ITBL,P-VERBN,0
	PUT	P-ITBL,P-NC1,T?P-LEXV+2
	PUT	P-ITBL,P-NC1L,T?P-LEXV+6
	SET	'P-NCN,1
?CND1:	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB /?CCL9
	ZERO?	ADJ \?CCL9
	GET	P-OTBL,P-VERB
	EQUAL?	VERB,STACK \FALSE
?CCL9:	EQUAL?	P-NCN,2 /FALSE
	GET	P-OTBL,P-NC1
	EQUAL?	STACK,1 \?CCL16
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP1
	EQUAL?	TEMP,STACK /?CTR18
	ZERO?	TEMP \FALSE
?CTR18:	ZERO?	ADJ /?CCL24
	PUT	P-OTBL,P-NC1,T?P-LEXV+2
	PUT	P-OTBL,P-NC1L,T?P-LEXV+6
	JUMP	?PRG64
?CCL24:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC1,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC1L,STACK
	JUMP	?PRG64
?CCL16:	GET	P-OTBL,P-NC2
	EQUAL?	STACK,1 \?CCL26
	GET	P-ITBL,P-PREP1 >TEMP
	GET	P-OTBL,P-PREP2
	EQUAL?	TEMP,STACK /?CTR28
	ZERO?	TEMP \FALSE
?CTR28:	ZERO?	ADJ /?CND32
	PUT	P-ITBL,P-NC1,T?P-LEXV+2
	PUT	P-ITBL,P-NC1L,T?P-LEXV+6
?CND32:	GET	P-ITBL,P-NC1
	PUT	P-OTBL,P-NC2,STACK
	GET	P-ITBL,P-NC1L
	PUT	P-OTBL,P-NC2L,STACK
	SET	'P-NCN,2
	JUMP	?PRG64
?CCL26:	ZERO?	P-ACLAUSE /?PRG64
	EQUAL?	P-NCN,1 /?CCL37
	ZERO?	ADJ \?CCL37
	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?CCL37:	GET	P-ITBL,P-NC1 >BEG
	ZERO?	ADJ /?CND40
	SET	'BEG,T?P-LEXV+2
	SET	'ADJ,FALSE-VALUE
?CND40:	GET	P-ITBL,P-NC1L >END
?PRG42:	GET	BEG,0 >WRD
	EQUAL?	BEG,END \?CCL46
	ZERO?	ADJ /?CCL49
	ICALL2	ACLAUSE-WIN,ADJ
	JUMP	?PRG64
?CCL49:	SET	'P-ACLAUSE,FALSE-VALUE
	RFALSE	
?CCL46:	ZERO?	ADJ \?CCL51
	GETB	WRD,P-PSOFF
	BTST	STACK,32 /?CTR50
	EQUAL?	WRD,W?ALL,W?ONE \?CCL51
?CTR50:	SET	'ADJ,WRD
?CND44:	ADD	BEG,P-WORDLEN >BEG
	ZERO?	END \?PRG42
	SET	'END,BEG
	SET	'P-NCN,1
	SUB	BEG,4
	PUT	P-ITBL,P-NC1,STACK
	PUT	P-ITBL,P-NC1L,BEG
	JUMP	?PRG42
?CCL51:	GETB	WRD,P-PSOFF
	BTST	STACK,128 /?CCL56
	EQUAL?	WRD,W?ONE \?CND44
?CCL56:	EQUAL?	WRD,P-ANAM,W?ONE \FALSE
	ICALL2	ACLAUSE-WIN,ADJ
?PRG64:	IGRTR?	'CNT,P-ITBLLEN \?CCL68
	SET	'P-MERGED,TRUE-VALUE
	RTRUE	
?CCL68:	GET	P-OTBL,CNT
	PUT	P-ITBL,CNT,STACK
	JUMP	?PRG64


	.FUNCT	ACLAUSE-WIN,ADJ
	GET	P-OTBL,P-VERB
	PUT	P-ITBL,P-VERB,STACK
	SET	'P-CCSRC,P-OTBL
	ADD	P-ACLAUSE,1
	ICALL	CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET	P-OTBL,P-NC2
	ZERO?	STACK /?PEN1
	SET	'P-NCN,2
?PEN1:	SET	'P-ACLAUSE,FALSE-VALUE
	RTRUE	


	.FUNCT	WORD-PRINT,CNT,BUF
?PRG1:	DLESS?	'CNT,0 /TRUE
	GETB	P-INBUF,BUF
	PRINTC	STACK
	INC	'BUF
	JUMP	?PRG1


	.FUNCT	INBUF-ADD,LEN,BEG,SLOT,DBEG,CTR,TMP,?TMP1
	GET	OOPS-TABLE,O-END >TMP
	ZERO?	TMP /?CCL3
	SET	'DBEG,TMP
	JUMP	?CND1
?CCL3:	GET	OOPS-TABLE,O-LENGTH >TMP
	GETB	AGAIN-LEXV,TMP >?TMP1
	ADD	TMP,1
	GETB	AGAIN-LEXV,STACK
	ADD	?TMP1,STACK >DBEG
?CND1:	ADD	DBEG,LEN
	PUT	OOPS-TABLE,O-END,STACK
?PRG4:	ADD	DBEG,CTR >?TMP1
	ADD	BEG,CTR
	GETB	P-INBUF,STACK
	PUTB	OOPS-INBUF,?TMP1,STACK
	INC	'CTR
	EQUAL?	CTR,LEN \?PRG4
	PUTB	AGAIN-LEXV,SLOT,DBEG
	SUB	SLOT,1
	PUTB	AGAIN-LEXV,STACK,LEN
	RTRUE	


	.FUNCT	UNKNOWN-WORD,PTR,BUF,?TMP1
	PUT	OOPS-TABLE,O-PTR,PTR
	PRINTI	"[I don't know the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	ICALL	WORD-PRINT,?TMP1,STACK
	PRINTI	".""]"
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	CANT-USE,PTR,BUF,?TMP1
	PRINTI	"I can't use the word """
	MUL	PTR,2 >BUF
	ADD	P-LEXV,BUF
	GETB	STACK,2 >?TMP1
	ADD	P-LEXV,BUF
	GETB	STACK,3
	ICALL	WORD-PRINT,?TMP1,STACK
	PRINTI	""" here."
	CRLF	
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-OFLAG,FALSE-VALUE
	RETURN	P-OFLAG


	.FUNCT	SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1,DRIVE2,PREP,VERB,TMP,?TMP2,?TMP1
	GET	P-ITBL,P-VERB >VERB
	ZERO?	VERB \?CND1
	PRINTI	"I can't find a verb in that sentence!"
	CRLF	
	RFALSE	
?CND1:	SUB	255,VERB
	GET	VERBS,STACK >SYN
	GETB	SYN,0 >LEN
	INC	'SYN
?PRG3:	GETB	SYN,P-SBITS
	BAND	STACK,P-SONUMS >NUM
	GRTR?	P-NCN,NUM /?CND5
	LESS?	NUM,1 /?CCL9
	ZERO?	P-NCN \?CCL9
	GET	P-ITBL,P-PREP1 >PREP
	ZERO?	PREP /?CTR8
	GETB	SYN,P-SPREP1
	EQUAL?	PREP,STACK \?CCL9
?CTR8:	SET	'DRIVE1,SYN
	JUMP	?CND5
?CCL9:	GETB	SYN,P-SPREP1 >?TMP1
	GET	P-ITBL,P-PREP1
	EQUAL?	?TMP1,STACK \?CND5
	EQUAL?	NUM,2 \?CCL18
	EQUAL?	P-NCN,1 \?CCL18
	SET	'DRIVE2,SYN
?CND5:	DLESS?	'LEN,1 \?CCL24
	ZERO?	DRIVE1 \?REP4
	ZERO?	DRIVE2 \?REP4
	PRINTI	"I don't understand that sentence."
	CRLF	
	RFALSE	
?CCL18:	GETB	SYN,P-SPREP2 >?TMP1
	GET	P-ITBL,P-PREP2
	EQUAL?	?TMP1,STACK \?CND5
	ICALL2	SYNTAX-FOUND,SYN
	RTRUE	
?CCL24:	ADD	SYN,P-SYNLEN >SYN
	JUMP	?PRG3
?REP4:	ZERO?	DRIVE1 /?CCL32
	GETB	DRIVE1,P-SFWIM1 >?TMP2
	GETB	DRIVE1,P-SLOC1 >?TMP1
	GETB	DRIVE1,P-SPREP1
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?CCL32
	PUT	P-PRSO,P-MATCHLEN,1
	PUT	P-PRSO,1,OBJ
	CALL2	SYNTAX-FOUND,DRIVE1
	RSTACK	
?CCL32:	ZERO?	DRIVE2 /?CCL36
	GETB	DRIVE2,P-SFWIM2 >?TMP2
	GETB	DRIVE2,P-SLOC2 >?TMP1
	GETB	DRIVE2,P-SPREP2
	CALL	GWIM,?TMP2,?TMP1,STACK >OBJ
	ZERO?	OBJ /?CCL36
	PUT	P-PRSI,P-MATCHLEN,1
	PUT	P-PRSI,1,OBJ
	CALL2	SYNTAX-FOUND,DRIVE2
	RSTACK	
?CCL36:	EQUAL?	VERB,ACT?FIND \?CCL40
	PRINTI	"I can't answer that question."
	CRLF	
	RFALSE	
?CCL40:	EQUAL?	WINNER,ADVENTURER /?CCL42
	CALL1	CANT-ORPHAN
	RSTACK	
?CCL42:	ICALL	ORPHAN,DRIVE1,DRIVE2
	PRINTI	"What do you want to "
	GET	P-OTBL,P-VERBN >TMP
	ZERO?	TMP \?CCL45
	PRINTI	"tell"
	JUMP	?CND43
?CCL45:	GETB	P-VTBL,2
	ZERO?	STACK \?CCL47
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND43
?CCL47:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	ICALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
?CND43:	ZERO?	DRIVE2 /?CND48
	ICALL	CLAUSE-PRINT,P-NC1,P-NC1L
?CND48:	SET	'P-OFLAG,TRUE-VALUE
	ZERO?	DRIVE1 /?CCL52
	GETB	DRIVE1,P-SPREP1
	JUMP	?CND50
?CCL52:	GETB	DRIVE2,P-SPREP2
?CND50:	ICALL2	PREP-PRINT,STACK
	PRINTC	63
	CRLF	
	RFALSE	


	.FUNCT	CANT-ORPHAN
	PRINTI	"""I don't understand! What are you referring to?"""
	CRLF	
	RFALSE	


	.FUNCT	ORPHAN,D1,D2,CNT
	SET	'CNT,-1
	PUT	P-OCLAUSE,P-MATCHLEN,0
	SET	'P-CCSRC,P-ITBL
?PRG1:	IGRTR?	'CNT,P-ITBLLEN /?REP2
	GET	P-ITBL,CNT
	PUT	P-OTBL,CNT,STACK
	JUMP	?PRG1
?REP2:	EQUAL?	P-NCN,2 \?CND6
	ICALL	CLAUSE-COPY,P-NC2,P-NC2L
?CND6:	LESS?	P-NCN,1 /?CND8
	ICALL	CLAUSE-COPY,P-NC1,P-NC1L
?CND8:	ZERO?	D1 /?CCL12
	GETB	D1,P-SPREP1
	PUT	P-OTBL,P-PREP1,STACK
	PUT	P-OTBL,P-NC1,1
	RTRUE	
?CCL12:	ZERO?	D2 /FALSE
	GETB	D2,P-SPREP2
	PUT	P-OTBL,P-PREP2,STACK
	PUT	P-OTBL,P-NC2,1
	RTRUE	


	.FUNCT	CLAUSE-PRINT,BPTR,EPTR,THE?,?TMP1
	ASSIGNED?	'THE? /?CND1
	SET	'THE?,TRUE-VALUE
?CND1:	GET	P-ITBL,BPTR >?TMP1
	GET	P-ITBL,EPTR
	CALL	BUFFER-PRINT,?TMP1,STACK,THE?
	RSTACK	


	.FUNCT	BUFFER-PRINT,BEG,END,CP,NOSP,WRD,FIRST??,PN,?TMP1
	SET	'FIRST??,TRUE-VALUE
?PRG1:	EQUAL?	BEG,END /TRUE
	ZERO?	NOSP /?CCL8
	SET	'NOSP,FALSE-VALUE
	JUMP	?CND6
?CCL8:	PRINTC	32
?CND6:	GET	BEG,0 >WRD
	EQUAL?	WRD,W?PERIOD \?CCL11
	SET	'NOSP,TRUE-VALUE
	JUMP	?CND3
?CCL11:	EQUAL?	WRD,W?FLOYD,W?BLATHER \?CCL13
	ICALL2	CAPITALIZE,BEG
	SET	'PN,TRUE-VALUE
	JUMP	?CND3
?CCL13:	ZERO?	FIRST?? /?CND14
	ZERO?	PN \?CND14
	ZERO?	CP /?CND14
	PRINTI	"the "
?CND14:	ZERO?	P-OFLAG /?CCL21
	PRINTB	WRD
	JUMP	?CND19
?CCL21:	EQUAL?	WRD,W?IT \?CCL23
	EQUAL?	P-IT-LOC,HERE \?CCL23
	PRINTD	P-IT-OBJECT
	JUMP	?CND19
?CCL23:	GETB	BEG,2 >?TMP1
	GETB	BEG,3
	ICALL	WORD-PRINT,?TMP1,STACK
?CND19:	SET	'FIRST??,FALSE-VALUE
?CND3:	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CAPITALIZE,PTR,?TMP1
	GETB	PTR,3
	GETB	P-INBUF,STACK
	SUB	STACK,32
	PRINTC	STACK
	GETB	PTR,2
	SUB	STACK,1 >?TMP1
	GETB	PTR,3
	ADD	STACK,1
	CALL	WORD-PRINT,?TMP1,STACK
	RSTACK	


	.FUNCT	PREP-PRINT,PREP,WRD
	ZERO?	PREP /FALSE
	PRINTC	32
	CALL2	PREP-FIND,PREP >WRD
	PRINTB	WRD
	RTRUE	


	.FUNCT	CLAUSE-COPY,BPTR,EPTR,INSRT,BEG,END
	GET	P-CCSRC,BPTR >BEG
	GET	P-CCSRC,EPTR >END
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,BPTR,STACK
?PRG1:	EQUAL?	BEG,END \?CCL5
	GET	P-OCLAUSE,P-MATCHLEN
	MUL	STACK,P-LEXELEN
	ADD	STACK,2
	ADD	P-OCLAUSE,STACK
	PUT	P-OTBL,EPTR,STACK
	RTRUE	
?CCL5:	ZERO?	INSRT /?CND6
	GET	BEG,0
	EQUAL?	P-ANAM,STACK \?CND6
	ICALL2	CLAUSE-ADD,INSRT
?CND6:	GET	BEG,0
	ICALL2	CLAUSE-ADD,STACK
	ADD	BEG,P-WORDLEN >BEG
	JUMP	?PRG1


	.FUNCT	CLAUSE-ADD,WRD,PTR
	GET	P-OCLAUSE,P-MATCHLEN
	ADD	STACK,2 >PTR
	SUB	PTR,1
	PUT	P-OCLAUSE,STACK,WRD
	PUT	P-OCLAUSE,PTR,0
	PUT	P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE	


	.FUNCT	PREP-FIND,PREP,CNT,SIZE
	GET	PREPOSITIONS,0
	MUL	STACK,2 >SIZE
?PRG1:	IGRTR?	'CNT,SIZE /FALSE
	GET	PREPOSITIONS,CNT
	EQUAL?	STACK,PREP \?PRG1
	SUB	CNT,1
	GET	PREPOSITIONS,STACK
	RSTACK	


	.FUNCT	SYNTAX-FOUND,SYN
	SET	'P-SYNTAX,SYN
	GETB	SYN,P-SACTION >PRSA
	RETURN	PRSA


	.FUNCT	GWIM,GBIT,LBIT,PREP,OBJ
	EQUAL?	GBIT,RMUNGBIT \?CND1
	RETURN	ROOMS
?CND1:	SET	'P-GWIMBIT,GBIT
	SET	'P-SLOCBITS,LBIT
	PUT	P-MERGE,P-MATCHLEN,0
	CALL	GET-OBJECT,P-MERGE,FALSE-VALUE
	ZERO?	STACK /?CCL5
	SET	'P-GWIMBIT,0
	GET	P-MERGE,P-MATCHLEN
	EQUAL?	STACK,1 \FALSE
	GET	P-MERGE,1 >OBJ
	FSET?	OBJ,VEHBIT \?CND9
	EQUAL?	PREP,PR?DOWN \?CND9
	SET	'PREP,PR?ON
?CND9:	PRINTC	40
	ZERO?	PREP /?CND13
	CALL2	PREP-FIND,PREP
	PRINTB	STACK
	PRINTI	" the "
?CND13:	PRINTD	OBJ
	PRINTC	41
	CRLF	
	RETURN	OBJ
?CCL5:	SET	'P-GWIMBIT,0
	RFALSE	


	.FUNCT	SNARF-OBJECTS,PTR
	GET	P-ITBL,P-NC1 >PTR
	ZERO?	PTR /?CND1
	GETB	P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET	P-ITBL,P-NC1L
	CALL	SNARFEM,PTR,STACK,P-PRSO
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /?CND1
	CALL2	BUT-MERGE,P-PRSO >P-PRSO
?CND1:	GET	P-ITBL,P-NC2 >PTR
	ZERO?	PTR /TRUE
	GETB	P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET	P-ITBL,P-NC2L
	CALL	SNARFEM,PTR,STACK,P-PRSI
	ZERO?	STACK /FALSE
	GET	P-BUTS,P-MATCHLEN
	ZERO?	STACK /TRUE
	GET	P-PRSI,P-MATCHLEN
	EQUAL?	STACK,1 \?CCL15
	CALL2	BUT-MERGE,P-PRSO >P-PRSO
	RTRUE	
?CCL15:	CALL2	BUT-MERGE,P-PRSI >P-PRSI
	RTRUE	


	.FUNCT	BUT-MERGE,TBL,LEN,BUTLEN,CNT,MATCHES,OBJ,NTBL,?TMP1,?TMP2
	SET	'CNT,1
	GET	TBL,P-MATCHLEN >LEN
	PUT	P-MERGE,P-MATCHLEN,0
?PRG1:	DLESS?	'LEN,0 /?REP2
	GET	TBL,CNT >OBJ
	ADD	P-BUTS,2 >?TMP1
	GET	P-BUTS,0
	INTBL?	OBJ,?TMP1,STACK /?CND3
	ADD	MATCHES,1
	PUT	P-MERGE,STACK,OBJ
	INC	'MATCHES
?CND3:	INC	'CNT
	JUMP	?PRG1
?REP2:	PUT	P-MERGE,P-MATCHLEN,MATCHES
	SET	'NTBL,P-MERGE
	SET	'P-MERGE,TBL
	RETURN	NTBL


	.FUNCT	SNARFEM,PTR,EPTR,TBL,BUT,LEN,WV,WORD,NW
	SET	'P-AND,FALSE-VALUE
	SET	'P-GETFLAGS,0
	SET	'P-CSPTR,PTR
	SET	'P-CEPTR,EPTR
	PUT	P-BUTS,P-MATCHLEN,0
	PUT	TBL,P-MATCHLEN,0
	GET	PTR,0 >WORD
?PRG1:	EQUAL?	PTR,EPTR \?CCL5
	ZERO?	BUT /?PRD8
	PUSH	BUT
	JUMP	?PEN6
?PRD8:	PUSH	TBL
?PEN6:	CALL2	GET-OBJECT,STACK
	RSTACK	
?CCL5:	GET	PTR,P-LEXELEN >NW
	EQUAL?	WORD,W?ALL,W?BOTH \?CCL11
	SET	'P-GETFLAGS,P-ALL
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?CCL11:	EQUAL?	WORD,W?BUT,W?EXCEPT \?CCL15
	ZERO?	BUT /?PRD20
	PUSH	BUT
	JUMP	?PEN18
?PRD20:	PUSH	TBL
?PEN18:	CALL2	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	SET	'BUT,P-BUTS
	PUT	BUT,P-MATCHLEN,0
	JUMP	?CND3
?CCL15:	EQUAL?	WORD,W?A,W?AN,W?ONE \?CCL22
	ZERO?	P-ADJ \?CCL25
	SET	'P-GETFLAGS,P-ONE
	EQUAL?	NW,W?OF \?CND3
	ADD	PTR,P-WORDLEN >PTR
	JUMP	?CND3
?CCL25:	SET	'P-NAM,P-ONEOBJ
	ZERO?	BUT /?PRD32
	PUSH	BUT
	JUMP	?PEN30
?PRD32:	PUSH	TBL
?PEN30:	CALL2	GET-OBJECT,STACK
	ZERO?	STACK /FALSE
	ZERO?	NW \?CND3
	RTRUE	
?CCL22:	EQUAL?	WORD,W?AND,W?COMMA \?CCL36
	EQUAL?	NW,W?AND,W?COMMA /?CCL36
	SET	'P-AND,TRUE-VALUE
	ZERO?	BUT /?PRD43
	PUSH	BUT
	JUMP	?PEN41
?PRD43:	PUSH	TBL
?PEN41:	CALL2	GET-OBJECT,STACK
	ZERO?	STACK \?CND3
	RFALSE	
?CCL36:	CALL	WT?,WORD,8
	ZERO?	STACK /?CCL45
	EQUAL?	PTR,P-CSPTR \?CCL45
	ADD	P-CSPTR,P-WORDLEN >P-CSPTR
	JUMP	?CND3
?CCL45:	CALL	WT?,WORD,4
	ZERO?	STACK \?CND3
	EQUAL?	WORD,W?AND,W?COMMA /?CND3
	EQUAL?	WORD,W?OF \?CCL51
	ZERO?	P-GETFLAGS \?CND3
	SET	'P-GETFLAGS,P-INHIBIT
	JUMP	?CND3
?CCL51:	CALL	WT?,WORD,32
	ZERO?	STACK /?CCL55
	CALL	ADJ-CHECK,WORD,P-ADJ
	ZERO?	STACK /?CCL55
	EQUAL?	NW,W?OF /?CCL55
	SET	'P-ADJ,WORD
	JUMP	?CND3
?CCL55:	CALL	WT?,WORD,128
	ZERO?	STACK /?CND3
	SET	'P-NAM,WORD
	SET	'P-ONEOBJ,WORD
?CND3:	EQUAL?	PTR,EPTR /?PRG1
	ADD	PTR,P-WORDLEN >PTR
	SET	'WORD,NW
	JUMP	?PRG1


	.FUNCT	ADJ-CHECK,WRD,ADJ
	ZERO?	ADJ /TRUE
	EQUAL?	ADJ,W?FIRST,W?SECOND,W?THIRD /FALSE
	EQUAL?	ADJ,W?FOURTH,W?OLD,W?NEW /FALSE
	EQUAL?	ADJ,W?SEND,W?RECEIVE,W?KITCHEN /FALSE
	EQUAL?	ADJ,W?UPPER,W?LOWER,W?SHUTTLE /FALSE
	EQUAL?	ADJ,W?ELEVATOR,W?TELEPORTATION /FALSE
	EQUAL?	ADJ,W?SQUARE,W?ROUND,W?GOOD /FALSE
	EQUAL?	ADJ,W?SHINY,W?CRACKED,W?FRIED /FALSE
	EQUAL?	ADJ,W?TELEPORT,W?MINI,W?MINIATURIZATION /FALSE
	RTRUE	


	.FUNCT	GET-OBJECT,TBL,VRB,BITS,LEN,XBITS,TLEN,GCHECK,OLEN,OBJ
	ASSIGNED?	'VRB /?CND1
	SET	'VRB,TRUE-VALUE
?CND1:	SET	'XBITS,P-SLOCBITS
	GET	TBL,P-MATCHLEN >TLEN
	BTST	P-GETFLAGS,P-INHIBIT /TRUE
	ZERO?	P-NAM \?CND5
	ZERO?	P-ADJ /?CND5
	CALL	WT?,P-ADJ,128
	ZERO?	STACK /?CCL11
	SET	'P-NAM,P-ADJ
	SET	'P-ADJ,FALSE-VALUE
	JUMP	?CND5
?CCL11:	CALL	WT?,P-ADJ,16,3 >BITS
	ZERO?	BITS /?CND5
	SET	'P-DIRECTION,BITS
?CND5:	ZERO?	P-NAM \?CND13
	ZERO?	P-ADJ \?CND13
	EQUAL?	P-GETFLAGS,P-ALL /?CND13
	ZERO?	P-GWIMBIT \?CND13
	ZERO?	VRB /FALSE
	PRINTI	"I couldn't find a noun in that sentence!"
	CRLF	
	RFALSE	
?CND13:	EQUAL?	P-GETFLAGS,P-ALL \?CCL22
	ZERO?	P-SLOCBITS \?CND21
?CCL22:	SET	'P-SLOCBITS,-1
?CND21:	SET	'P-TABLE,TBL
?PRG25:	ZERO?	GCHECK /?CCL29
	ICALL2	GLOBAL-CHECK,TBL
	JUMP	?CND27
?CCL29:	ZERO?	LIT /?CND30
	EQUAL?	WINNER,ADVENTURER /?CND32
	FCLEAR	WINNER,OPENBIT
?CND32:	ICALL	DO-SL,HERE,SOG,SIR
	EQUAL?	WINNER,ADVENTURER /?CND30
	FSET	WINNER,OPENBIT
?CND30:	ICALL	DO-SL,WINNER,SH,SC
	EQUAL?	WINNER,ADVENTURER /?CND27
	EQUAL?	P-GETFLAGS,P-ALL /?CND27
	ICALL	DO-SL,ADVENTURER,SH,SC
?CND27:	GET	TBL,P-MATCHLEN
	SUB	STACK,TLEN >LEN
	BTST	P-GETFLAGS,P-ALL /?CND40
	BTST	P-GETFLAGS,P-ONE \?CCL43
	ZERO?	LEN /?CCL43
	EQUAL?	LEN,1 /?CND46
	RANDOM	LEN
	GET	TBL,STACK
	PUT	TBL,1,STACK
	PRINTI	"(How about the "
	GET	TBL,1
	PRINTD	STACK
	PRINTI	"?)"
	CRLF	
?CND46:	PUT	TBL,P-MATCHLEN,1
?CND40:	SET	'P-SLOCBITS,XBITS
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	
?CCL43:	GRTR?	LEN,1 /?CTR48
	ZERO?	LEN \?CCL49
	EQUAL?	P-SLOCBITS,-1 /?CCL49
?CTR48:	EQUAL?	P-SLOCBITS,-1 \?CCL56
	SET	'P-SLOCBITS,XBITS
	SET	'OLEN,LEN
	GET	TBL,P-MATCHLEN
	SUB	STACK,LEN
	PUT	TBL,P-MATCHLEN,STACK
	JUMP	?PRG25
?CCL56:	ZERO?	LEN \?CND57
	SET	'LEN,OLEN
?CND57:	EQUAL?	WINNER,ADVENTURER /?CCL61
	ICALL1	CANT-ORPHAN
	RFALSE	
?CCL61:	ZERO?	VRB /?CCL63
	ZERO?	P-NAM /?CCL63
	ICALL	WHICH-PRINT,TLEN,LEN,TBL
	EQUAL?	TBL,P-PRSO \?CCL68
	SET	'P-ACLAUSE,P-NC1
	JUMP	?CND66
?CCL68:	SET	'P-ACLAUSE,P-NC2
?CND66:	SET	'P-AADJ,P-ADJ
	SET	'P-ANAM,P-NAM
	ICALL	ORPHAN,FALSE-VALUE,FALSE-VALUE
	SET	'P-OFLAG,TRUE-VALUE
	JUMP	?CND59
?CCL63:	ZERO?	VRB /?CND59
	PRINTI	"I couldn't find a noun in that sentence!"
	CRLF	
?CND59:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?CCL49:	ZERO?	LEN \?CCL71
	ZERO?	GCHECK /?CCL71
	ZERO?	VRB /?CND74
	SET	'P-SLOCBITS,XBITS
	ZERO?	LIT \?CTR77
	EQUAL?	P-NAM,W?GRUE \?CCL78
?CTR77:	ICALL	OBJ-FOUND,NOT-HERE-OBJECT,TBL
	SET	'P-XNAM,P-NAM
	SET	'P-XADJ,P-ADJ
	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RTRUE	
?CCL78:	PRINTI	"It's too dark to see!"
	CRLF	
?CND74:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RFALSE	
?CCL71:	ZERO?	LEN \?CND40
	SET	'GCHECK,TRUE-VALUE
	JUMP	?PRG25


	.FUNCT	MOBY-FIND,TBL,FOO,LEN
	SET	'P-SLOCBITS,-1
	SET	'P-NAM,P-XNAM
	SET	'P-ADJ,P-XADJ
	PUT	TBL,P-MATCHLEN,0
	FIRST?	ROOMS >FOO /?PRG2
?PRG2:	ZERO?	FOO /?REP3
	ICALL	SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT?	FOO >FOO /?PRG2
	JUMP	?PRG2
?REP3:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND8
	ICALL	DO-SL,LOCAL-GLOBALS,1,1
?CND8:	GET	TBL,P-MATCHLEN >LEN
	ZERO?	LEN \?CND10
	ICALL	DO-SL,ROOMS,1,1
?CND10:	GET	TBL,P-MATCHLEN >LEN
	EQUAL?	LEN,1 \?CND12
	GET	TBL,1 >P-MOBY-FOUND
?CND12:	SET	'P-NAM,FALSE-VALUE
	SET	'P-ADJ,FALSE-VALUE
	RETURN	LEN


	.FUNCT	WHICH-PRINT,TLEN,LEN,TBL,OBJ,RLEN
	SET	'RLEN,LEN
	PRINTI	"Which"
	ZERO?	P-OFLAG \?CTR2
	ZERO?	P-MERGED \?CTR2
	ZERO?	P-AND /?CCL3
?CTR2:	PRINTC	32
	PRINTB	P-NAM
	JUMP	?CND1
?CCL3:	EQUAL?	TBL,P-PRSO \?CCL8
	ICALL	CLAUSE-PRINT,P-NC1,P-NC1L,FALSE-VALUE
	JUMP	?CND1
?CCL8:	ICALL	CLAUSE-PRINT,P-NC2,P-NC2L,FALSE-VALUE
?CND1:	PRINTI	" do you mean, "
?PRG9:	INC	'TLEN
	GET	TBL,TLEN >OBJ
	PRINTI	"the "
	PRINTD	OBJ
	EQUAL?	LEN,2 \?CCL13
	EQUAL?	RLEN,2 /?CND14
	PRINTC	44
?CND14:	PRINTI	" or "
	JUMP	?CND11
?CCL13:	GRTR?	LEN,2 \?CND11
	PRINTI	", "
?CND11:	DLESS?	'LEN,1 \?PRG9
	PRINTR	"?"


	.FUNCT	GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT,OBJ,OBITS,FOO
	GET	TBL,P-MATCHLEN >LEN
	SET	'OBITS,P-SLOCBITS
	GETPT	HERE,P?GLOBAL >RMG
	ZERO?	RMG /?CND1
	PTSIZE	RMG
	DIV	STACK,2
	SUB	STACK,1 >RMGL
?PRG3:	GET	RMG,CNT >OBJ
	CALL2	THIS-IT?,OBJ
	ZERO?	STACK /?CND5
	ICALL	OBJ-FOUND,OBJ,TBL
?CND5:	IGRTR?	'CNT,RMGL \?PRG3
?CND1:	GETPT	HERE,P?PSEUDO >RMG
	ZERO?	RMG /?CND9
	PTSIZE	RMG
	DIV	STACK,4
	SUB	STACK,1 >RMGL
	SET	'CNT,0
?PRG11:	MUL	CNT,2
	GET	RMG,STACK
	EQUAL?	P-NAM,STACK \?CCL15
	SET	'LAST-PSEUDO-LOC,HERE
	MUL	CNT,2
	ADD	STACK,1
	GET	RMG,STACK
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	GETPT	PSEUDO-OBJECT,P?ACTION
	SUB	STACK,7 >FOO
	COPYT	P-NAM,FOO,6
	ICALL	OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP	?CND9
?CCL15:	IGRTR?	'CNT,RMGL \?PRG11
?CND9:	GET	TBL,P-MATCHLEN
	EQUAL?	STACK,LEN \FALSE
	SET	'P-SLOCBITS,-1
	SET	'P-TABLE,TBL
	ICALL	DO-SL,GLOBAL-OBJECTS,1,1
	SET	'P-SLOCBITS,OBITS
	GET	TBL,P-MATCHLEN
	ZERO?	STACK \FALSE
	EQUAL?	PRSA,V?LOOK-INSIDE,V?SEARCH /?CCL25
	EQUAL?	PRSA,V?EXAMINE,V?FIND,V?THROUGH \FALSE
?CCL25:	CALL	DO-SL,ROOMS,1,1
	RSTACK	


	.FUNCT	DO-SL,OBJ,BIT1,BIT2
	ADD	BIT1,BIT2
	BTST	P-SLOCBITS,STACK \?CCL3
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCALL
	RSTACK	
?CCL3:	BTST	P-SLOCBITS,BIT1 \?CCL6
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP
	RSTACK	
?CCL6:	BTST	P-SLOCBITS,BIT2 \TRUE
	CALL	SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT
	RSTACK	


	.FUNCT	SEARCH-LIST,OBJ,TBL,LVL,FLS,NOBJ
	FIRST?	OBJ >OBJ \FALSE
?PRG4:	EQUAL?	LVL,P-SRCBOT /?CND6
	GETPT	OBJ,P?SYNONYM
	ZERO?	STACK /?CND6
	CALL2	THIS-IT?,OBJ
	ZERO?	STACK /?CND6
	ICALL	OBJ-FOUND,OBJ,TBL
?CND6:	FSET?	OBJ,INVISIBLE /?CND11
	ZERO?	LVL \?PRD15
	FSET?	OBJ,SEARCHBIT /?PRD15
	FSET?	OBJ,SURFACEBIT \?CND11
?PRD15:	FIRST?	OBJ >NOBJ \?CND11
	FSET?	OBJ,OPENBIT /?CCL12
	FSET?	OBJ,TRANSBIT \?CND11
?CCL12:	ZERO?	LVL \?CCL24
	FSET?	OBJ,SEARCHBIT \?CCL24
	EQUAL?	P-GETFLAGS,P-ALL /?CND11
?CCL24:	FSET?	OBJ,SURFACEBIT \?CCL30
	PUSH	P-SRCALL
	JUMP	?CND28
?CCL30:	FSET?	OBJ,SEARCHBIT \?CCL32
	PUSH	P-SRCALL
	JUMP	?CND28
?CCL32:	PUSH	P-SRCTOP
?CND28:	CALL	SEARCH-LIST,OBJ,TBL,STACK >FLS
?CND11:	NEXT?	OBJ >OBJ /?PRG4
	RTRUE	


	.FUNCT	OBJ-FOUND,OBJ,TBL,PTR
	GET	TBL,P-MATCHLEN >PTR
	ADD	PTR,1
	PUT	TBL,STACK,OBJ
	ADD	PTR,1
	PUT	TBL,P-MATCHLEN,STACK
	RTRUE	


	.FUNCT	TAKE-CHECK
	GETB	P-SYNTAX,P-SLOC1
	CALL	ITAKE-CHECK,P-PRSO,STACK
	ZERO?	STACK /FALSE
	GETB	P-SYNTAX,P-SLOC2
	CALL	ITAKE-CHECK,P-PRSI,STACK
	RSTACK	


	.FUNCT	ITAKE-CHECK,TBL,IBITS,PTR,OBJ,TAKEN
	GET	TBL,P-MATCHLEN >PTR
	ZERO?	PTR /TRUE
	BTST	IBITS,SHAVE /?PRG8
	BTST	IBITS,STAKE \TRUE
?PRG8:	DLESS?	'PTR,0 /TRUE
	ADD	PTR,1
	GET	TBL,STACK >OBJ
	EQUAL?	OBJ,IT \?CND13
	SET	'OBJ,P-IT-OBJECT
?CND13:	CALL2	HELD?,OBJ
	ZERO?	STACK \?PRG8
	EQUAL?	OBJ,HANDS /?PRG8
	SET	'PRSO,OBJ
	FSET?	OBJ,TRYTAKEBIT \?CCL21
	SET	'TAKEN,TRUE-VALUE
	JUMP	?CND19
?CCL21:	EQUAL?	WINNER,ADVENTURER /?CCL23
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND19
?CCL23:	BTST	IBITS,STAKE \?CCL25
	CALL2	ITAKE,FALSE-VALUE
	EQUAL?	STACK,TRUE-VALUE \?CCL25
	SET	'TAKEN,FALSE-VALUE
	JUMP	?CND19
?CCL25:	SET	'TAKEN,TRUE-VALUE
?CND19:	ZERO?	TAKEN /?CCL30
	BTST	IBITS,SHAVE \?CCL30
	EQUAL?	OBJ,NOT-HERE-OBJECT \?CND33
	PRINTI	"You don't have that!"
	CRLF	
	RFALSE	
?CND33:	PRINTI	"You don't have the "
	PRINTD	OBJ
	PRINTC	46
	CRLF	
	ICALL2	THIS-IS-IT,OBJ
	RFALSE	
?CCL30:	ZERO?	TAKEN \?PRG8
	EQUAL?	WINNER,ADVENTURER \?PRG8
	PRINTI	"(Taking the "
	PRINTD	OBJ
	PRINTI	" first)"
	CRLF	
	JUMP	?PRG8


	.FUNCT	HERE?,CAN
?PRG1:	LOC	CAN >CAN
	ZERO?	CAN /?REP2
	EQUAL?	CAN,HERE \?PRG1
	RTRUE	
?REP2:	CALL	GLOBAL-IN?,CAN,HERE
	ZERO?	STACK \TRUE
	EQUAL?	CAN,PSEUDO-OBJECT /TRUE
	RFALSE	


	.FUNCT	HELD?,OBJ,CONT
	ZERO?	CONT \?CND1
	SET	'CONT,WINNER
?CND1:	ZERO?	OBJ /FALSE
	IN?	OBJ,CONT /TRUE
	IN?	OBJ,ROOMS /FALSE
	LOC	OBJ
	CALL	HELD?,STACK,CONT
	RSTACK	


	.FUNCT	MANY-CHECK,LOSS,TMP,?TMP1
	GET	P-PRSO,P-MATCHLEN
	GRTR?	STACK,1 \?CCL3
	GETB	P-SYNTAX,P-SLOC1
	BTST	STACK,SMANY /?CCL3
	SET	'LOSS,1
	JUMP	?CND1
?CCL3:	GET	P-PRSI,P-MATCHLEN
	GRTR?	STACK,1 \?CND1
	GETB	P-SYNTAX,P-SLOC2
	BTST	STACK,SMANY /?CND1
	SET	'LOSS,2
?CND1:	ZERO?	LOSS /TRUE
	PRINTI	"I can't use multiple "
	EQUAL?	LOSS,2 \?CND12
	PRINTI	"in"
?CND12:	PRINTI	"direct objects with """
	GET	P-ITBL,P-VERBN >TMP
	ZERO?	TMP \?CCL16
	PRINTI	"tell"
	JUMP	?CND14
?CCL16:	ZERO?	P-OFLAG \?CTR17
	ZERO?	P-MERGED /?CCL18
?CTR17:	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND14
?CCL18:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	ICALL	WORD-PRINT,?TMP1,STACK
?CND14:	PRINTI	"."""
	CRLF	
	RFALSE	


	.FUNCT	LIT?,RM,OHERE,LIT
	SET	'P-GWIMBIT,ONBIT
	SET	'OHERE,HERE
	SET	'HERE,RM
	FSET?	RM,ONBIT \?CCL3
	SET	'LIT,TRUE-VALUE
	JUMP	?CND1
?CCL3:	PUT	P-MERGE,P-MATCHLEN,0
	SET	'P-TABLE,P-MERGE
	SET	'P-SLOCBITS,-1
	EQUAL?	OHERE,RM \?CND4
	ICALL	DO-SL,WINNER,1,1
?CND4:	ICALL	DO-SL,RM,1,1
	GET	P-TABLE,P-MATCHLEN
	GRTR?	STACK,0 \?CND1
	SET	'LIT,TRUE-VALUE
?CND1:	SET	'HERE,OHERE
	SET	'P-GWIMBIT,0
	RETURN	LIT


	.FUNCT	PRSO-PRINT,PTR
	ZERO?	P-MERGED \?CTR2
	GET	P-ITBL,P-NC1 >PTR
	GET	PTR,0
	EQUAL?	STACK,W?IT \?CCL3
?CTR2:	PRINTC	32
	PRINTD	PRSO
	RTRUE	
?CCL3:	GET	P-ITBL,P-NC1L
	CALL	BUFFER-PRINT,PTR,STACK,FALSE-VALUE
	RSTACK	


	.FUNCT	THIS-IT?,OBJ,SYNS,CNT
	FSET?	OBJ,INVISIBLE /FALSE
	GETPT	OBJ,P?SYNONYM >SYNS
	ZERO?	SYNS /FALSE
	ZERO?	P-NAM /?CND5
	PTSIZE	SYNS
	DIV	STACK,2
	INTBL?	P-NAM,SYNS,STACK \FALSE
?CND5:	ZERO?	P-ADJ /?CND9
	GETPT	OBJ,P?ADJECTIVE >SYNS
	ZERO?	SYNS /FALSE
	PTSIZE	SYNS
	DIV	STACK,2
	INTBL?	P-ADJ,SYNS,STACK \FALSE
?CND9:	ZERO?	P-GWIMBIT /TRUE
	FSET?	OBJ,P-GWIMBIT /TRUE
	RFALSE	

	.ENDI
