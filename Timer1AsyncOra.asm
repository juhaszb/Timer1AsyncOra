
_main:

;Timer1AsyncOra.c,14 :: 		void main() {
;Timer1AsyncOra.c,15 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;Timer1AsyncOra.c,16 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Timer1AsyncOra.c,17 :: 		CM1CON0 = 0;
	CLRF       CM1CON0+0
;Timer1AsyncOra.c,18 :: 		CM2CON0 = 0;
	CLRF       CM2CON0+0
;Timer1AsyncOra.c,19 :: 		CCP1CON = 0;
	CLRF       CCP1CON+0
;Timer1AsyncOra.c,20 :: 		CCP2CON = 0;
	CLRF       CCP2CON+0
;Timer1AsyncOra.c,21 :: 		T1CON.TMR1CS=1; //external clock , Kulso orajel
	BSF        T1CON+0, 1
;Timer1AsyncOra.c,22 :: 		T1CON.T1CKPS1=0;// elooszto (prescaler)
	BCF        T1CON+0, 5
;Timer1AsyncOra.c,23 :: 		T1CON.T1CKPS0=0;// elooszto (prescaler)
	BCF        T1CON+0, 4
;Timer1AsyncOra.c,24 :: 		T1CON.T1SYNC=1;// aszinkron mukodes (asynchronous )
	BSF        T1CON+0, 2
;Timer1AsyncOra.c,25 :: 		T1CON.TMR1ON=1;// Timer 1 bekapcsol
	BSF        T1CON+0, 0
;Timer1AsyncOra.c,26 :: 		T1CON.T1OSCEN=1;// kulso orajel -> kell , external clock
	BSF        T1CON+0, 3
;Timer1AsyncOra.c,27 :: 		PIR1.TMR1IF =0;// owerflow torlese , nem csordul tul
	BCF        PIR1+0, 0
;Timer1AsyncOra.c,28 :: 		INTCON.GIE =1;// interrupt engedelyezese
	BSF        INTCON+0, 7
;Timer1AsyncOra.c,29 :: 		INTCON.PEIE=1;// Peripheral interrupt engedelyezese
	BSF        INTCON+0, 6
;Timer1AsyncOra.c,30 :: 		INTCON.RBIE=0;
	BCF        INTCON+0, 3
;Timer1AsyncOra.c,31 :: 		TRISA = 0;
	CLRF       TRISA+0
;Timer1AsyncOra.c,32 :: 		TRISC = 0;
	CLRF       TRISC+0
;Timer1AsyncOra.c,33 :: 		PORTC = 0;
	CLRF       PORTC+0
;Timer1AsyncOra.c,34 :: 		TRISB = 0b11000011; // nem lehet az egeszet , mivel problemat okoz
	MOVLW      195
	MOVWF      TRISB+0
;Timer1AsyncOra.c,35 :: 		PORTA = 0;
	CLRF       PORTA+0
;Timer1AsyncOra.c,36 :: 		TMR1H = 0x80;
	MOVLW      128
	MOVWF      TMR1H+0
;Timer1AsyncOra.c,37 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;Timer1AsyncOra.c,38 :: 		while(1){
L_main0:
;Timer1AsyncOra.c,39 :: 		szamlalo++;
	INCF       _szamlalo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _szamlalo+1, 1
;Timer1AsyncOra.c,40 :: 		if(PIR1.TMR1IF){
	BTFSS      PIR1+0, 0
	GOTO       L_main2
;Timer1AsyncOra.c,41 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;Timer1AsyncOra.c,42 :: 		TMR1H = 0x7F; // testing if += makes a DIFFERENCE
	MOVLW      127
	MOVWF      TMR1H+0
;Timer1AsyncOra.c,43 :: 		TMR1L = 0xEF;
	MOVLW      239
	MOVWF      TMR1L+0
;Timer1AsyncOra.c,44 :: 		masodp++;
	INCF       _masodp+0, 1
	BTFSC      STATUS+0, 2
	INCF       _masodp+1, 1
;Timer1AsyncOra.c,46 :: 		}
L_main2:
;Timer1AsyncOra.c,48 :: 		if(masodp>59){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _masodp+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVF       _masodp+0, 0
	SUBLW      59
L__main21:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;Timer1AsyncOra.c,49 :: 		masodp=0;
	CLRF       _masodp+0
	CLRF       _masodp+1
;Timer1AsyncOra.c,50 :: 		perc2++;
	INCF       _perc2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _perc2+1, 1
;Timer1AsyncOra.c,51 :: 		}
L_main3:
;Timer1AsyncOra.c,52 :: 		if(perc2>9){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _perc2+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVF       _perc2+0, 0
	SUBLW      9
L__main22:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;Timer1AsyncOra.c,53 :: 		perc1++;
	INCF       _perc1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _perc1+1, 1
;Timer1AsyncOra.c,54 :: 		perc2=0;
	CLRF       _perc2+0
	CLRF       _perc2+1
;Timer1AsyncOra.c,55 :: 		}
L_main4:
;Timer1AsyncOra.c,56 :: 		if(perc1==6 && perc2==0){
	MOVLW      0
	XORWF      _perc1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVLW      6
	XORWF      _perc1+0, 0
L__main23:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	MOVLW      0
	XORWF      _perc2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main24
	MOVLW      0
	XORWF      _perc2+0, 0
L__main24:
	BTFSS      STATUS+0, 2
	GOTO       L_main7
L__main20:
;Timer1AsyncOra.c,57 :: 		ora2++;
	INCF       _ora2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ora2+1, 1
;Timer1AsyncOra.c,58 :: 		perc1=0;
	CLRF       _perc1+0
	CLRF       _perc1+1
;Timer1AsyncOra.c,59 :: 		perc2=0;
	CLRF       _perc2+0
	CLRF       _perc2+1
;Timer1AsyncOra.c,60 :: 		}
L_main7:
;Timer1AsyncOra.c,61 :: 		if(ora2==10){
	MOVLW      0
	XORWF      _ora2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main25
	MOVLW      10
	XORWF      _ora2+0, 0
L__main25:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Timer1AsyncOra.c,62 :: 		ora1++;
	INCF       _ora1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _ora1+1, 1
;Timer1AsyncOra.c,63 :: 		ora2=0;
	CLRF       _ora2+0
	CLRF       _ora2+1
;Timer1AsyncOra.c,64 :: 		}
L_main8:
;Timer1AsyncOra.c,65 :: 		if(ora2==4 && ora1==2){
	MOVLW      0
	XORWF      _ora2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main26
	MOVLW      4
	XORWF      _ora2+0, 0
L__main26:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVLW      0
	XORWF      _ora1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      2
	XORWF      _ora1+0, 0
L__main27:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
L__main19:
;Timer1AsyncOra.c,66 :: 		ora1=0;
	CLRF       _ora1+0
	CLRF       _ora1+1
;Timer1AsyncOra.c,67 :: 		ora2=0;
	CLRF       _ora2+0
	CLRF       _ora2+1
;Timer1AsyncOra.c,68 :: 		}
L_main11:
;Timer1AsyncOra.c,70 :: 		if(szamlalo % 12 ==0){
	MOVLW      12
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _szamlalo+0, 0
	MOVWF      R0+0
	MOVF       _szamlalo+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main28
	MOVLW      0
	XORWF      R0+0, 0
L__main28:
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;Timer1AsyncOra.c,71 :: 		PORTA = 0;
	CLRF       PORTA+0
;Timer1AsyncOra.c,72 :: 		PORTC = 0;
	CLRF       PORTC+0
;Timer1AsyncOra.c,73 :: 		kijelzo++;
	INCF       _kijelzo+0, 1
	BTFSC      STATUS+0, 2
	INCF       _kijelzo+1, 1
;Timer1AsyncOra.c,74 :: 		if(kijelzo<4){
	MOVLW      128
	XORWF      _kijelzo+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      4
	SUBWF      _kijelzo+0, 0
L__main29:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;Timer1AsyncOra.c,75 :: 		PORTB = KI[kijelzo];
	MOVF       _kijelzo+0, 0
	MOVWF      R0+0
	MOVF       _kijelzo+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _KI+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;Timer1AsyncOra.c,76 :: 		}
L_main13:
;Timer1AsyncOra.c,77 :: 		if(kijelzo==3){
	MOVLW      0
	XORWF      _kijelzo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      3
	XORWF      _kijelzo+0, 0
L__main30:
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;Timer1AsyncOra.c,78 :: 		kijelzo=-1;
	MOVLW      255
	MOVWF      _kijelzo+0
	MOVLW      255
	MOVWF      _kijelzo+1
;Timer1AsyncOra.c,79 :: 		}
L_main14:
;Timer1AsyncOra.c,81 :: 		}
L_main12:
;Timer1AsyncOra.c,82 :: 		if(kijelzo==0){
	MOVLW      0
	XORWF      _kijelzo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      0
	XORWF      _kijelzo+0, 0
L__main31:
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;Timer1AsyncOra.c,83 :: 		PORTA = szamok2[ora1][0];
	MOVF       _ora1+0, 0
	MOVWF      R0+0
	MOVF       _ora1+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _szamok2+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Timer1AsyncOra.c,84 :: 		PORTC = szamok2[ora1][1];
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Timer1AsyncOra.c,85 :: 		}
L_main15:
;Timer1AsyncOra.c,86 :: 		if(kijelzo==1){
	MOVLW      0
	XORWF      _kijelzo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      1
	XORWF      _kijelzo+0, 0
L__main32:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;Timer1AsyncOra.c,87 :: 		PORTA = szamok2[ora2][0];
	MOVF       _ora2+0, 0
	MOVWF      R0+0
	MOVF       _ora2+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _szamok2+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Timer1AsyncOra.c,88 :: 		PORTC = szamok2[ora2][1];
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Timer1AsyncOra.c,89 :: 		}
L_main16:
;Timer1AsyncOra.c,90 :: 		if(kijelzo==2){
	MOVLW      0
	XORWF      _kijelzo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      2
	XORWF      _kijelzo+0, 0
L__main33:
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;Timer1AsyncOra.c,91 :: 		PORTA = szamok2[perc1][0];
	MOVF       _perc1+0, 0
	MOVWF      R0+0
	MOVF       _perc1+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _szamok2+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Timer1AsyncOra.c,92 :: 		PORTC = szamok2[perc1][1];
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Timer1AsyncOra.c,93 :: 		}
L_main17:
;Timer1AsyncOra.c,94 :: 		if(kijelzo==3){
	MOVLW      0
	XORWF      _kijelzo+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      3
	XORWF      _kijelzo+0, 0
L__main34:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;Timer1AsyncOra.c,95 :: 		PORTA = szamok2[perc2][0];
	MOVF       _perc2+0, 0
	MOVWF      R0+0
	MOVF       _perc2+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _szamok2+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTA+0
;Timer1AsyncOra.c,96 :: 		PORTC = szamok2[perc2][1];
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Timer1AsyncOra.c,97 :: 		}
L_main18:
;Timer1AsyncOra.c,98 :: 		}
	GOTO       L_main0
;Timer1AsyncOra.c,99 :: 		}
	GOTO       $+0
; end of _main
