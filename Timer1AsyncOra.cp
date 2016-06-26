#line 1 "D:/kurva/Timer1AsyncOra.c"
int szamlalo=0;
int i=0;
int masodp=0;
int perc1=0;
int perc2=0;
int ora1=0;
int ora2=0;
int szamok[10]={123,48,103,118,60,94,95,112,127,126};
int kijelzo=0;
int szamol2=0;
int szamolvalamit=0;
int KI[4] = {128,64,32,16};
void main() {
 T1CON.TMR1CS=1;
 T1CON.T1CKPS1=0;
 T1CON.T1CKPS0=0;
 T1CON.T1SYNC=1;
 T1CON.TMR1ON=1;
 T1CON.T1OSCEN=1;
 PIR1.TMR1IF =0;
 INTCON.GIE =1;
 INTCON.PEIE=1;
 INTCON.RBIE=0;
 TRISD = 0;
 TRISB = 0b00001111;
 PORTD = 0;
 TMR1H = 0x80;
 TMR1L = 0;
 while(1){
 szamlalo++;
 if(PIR1.TMR1IF){
 PIR1.TMR1IF=0;
 TMR1H = 0x80;
 TMR1L = 0;
 masodp++;

 }

 if(masodp>59){
 masodp=0;
 perc2++;
 }
 if(perc2>9){
 perc1++;
 perc2=0;
 }
 if(perc1==6 && perc2==0){
 ora2++;
 perc1=0;
 perc2=0;
 }
 if(ora2==10){
 ora1++;
 ora2=0;
 }
 if(ora2==4 && ora1==2){
 ora1=0;
 ora2=0;
 }

 if(szamlalo % 12 ==0){
 PORTD = 0;
 kijelzo++;
 if(kijelzo<4){
 PORTB = KI[kijelzo];
 }
 if(kijelzo==4){
 kijelzo=-1;
 }

 }
 if(kijelzo==0){
 PORTD = szamok[ora1];
 }
 if(kijelzo==1){
 PORTD = szamok[ora2];
 }
 if(kijelzo==2){
 PORTD = szamok[perc1];
 }
 if(kijelzo==3){
 PORTD = szamok[perc2];
 }
}
}
