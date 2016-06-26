int szamlalo=0;
int i=0;
int masodp=0;
int perc1=0;
int perc2=0;
int ora1=0;
int ora2=0;
int szamok[10]={123,48,103,118,60,94,95,112,127,126};
int szamok2[10][2]={{63,0},{6,0},{27,4},{15,4},{44,4},{45,4},{61,4},{7,0},{63,4},{47,4}};
int kijelzo=0;
int szamol2=0;
int szamolvalamit=0;
int KI[4] = {32,16,8,4};
void main() {
  ANSEL = 0;
  ANSELH = 0;
  CM1CON0 = 0;
  CM2CON0 = 0;
  CCP1CON = 0;
  CCP2CON = 0;
  T1CON.TMR1CS=1; //external clock , Kulso orajel
  T1CON.T1CKPS1=0;// elooszto (prescaler)
  T1CON.T1CKPS0=0;// elooszto (prescaler)
  T1CON.T1SYNC=1;// aszinkron mukodes (asynchronous )
  T1CON.TMR1ON=1;// Timer 1 bekapcsol
  T1CON.T1OSCEN=1;// kulso orajel -> kell , external clock
  PIR1.TMR1IF =0;// owerflow torlese , nem csordul tul
  INTCON.GIE =1;// interrupt engedelyezese
  INTCON.PEIE=1;// Peripheral interrupt engedelyezese
  INTCON.RBIE=0;
  TRISA = 0;
  TRISC = 0;
  PORTC = 0;
  TRISB = 0b11000011; // nem lehet az egeszet , mivel problemat okoz
  PORTA = 0;
  TMR1H = 0x80;
  TMR1L = 0;
  while(1){
  szamlalo++;
           if(PIR1.TMR1IF){
                           PIR1.TMR1IF=0;
                           TMR1H = 0x7F; // testing if += makes a DIFFERENCE
                           TMR1L = 0xEF;
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
                       PORTA = 0;
                       PORTC = 0;
                       kijelzo++;
                       if(kijelzo<4){
                                     PORTB = KI[kijelzo];
                                     }
                       if(kijelzo==3){
                                      kijelzo=-1;
                                      }

                                }
            if(kijelzo==0){
                           PORTA = szamok2[ora1][0];
                           PORTC = szamok2[ora1][1];
                           }
            if(kijelzo==1){
                           PORTA = szamok2[ora2][0];
                           PORTC = szamok2[ora2][1];
                           }
            if(kijelzo==2){
                           PORTA = szamok2[perc1][0];
                           PORTC = szamok2[perc1][1];
                           }
            if(kijelzo==3){
                           PORTA = szamok2[perc2][0];
                           PORTC = szamok2[perc2][1];
                           }
}
}