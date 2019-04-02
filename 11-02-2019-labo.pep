; ************************************************************
;       Programme: code.txt     version PEP813 sous Windows
;
;       Un programme qui valide un nom de famille.
;
;       auteur:         Andy Chen
;       code permanent: CHEA23099303
;       courriel:       chen.andy@courrier.uqam.ca
;       date:           12-02-2019
;       cours:          INF2171
; ***********************************************************
;
         LDA     0,i         ;initialisation � 0 du registre accumulateur
         LDX     0,i
         STRO    bienvenu,d  ;message bienvenue 
         ;STRO    msgQuit,d 
debut:   STRO    msgEntre,d  ;message d'invite 
bclLect: CHARI   caract,d    ;l'input de l'utilisateur
         LDA     avCaract,d
         CPA     ' ',i	      ;verification des caracteres interdit
         BREQ    bclLect     ;ou bien des caracteres speciaux
         CPA     '\n',i      
         BREQ    div10       
         CPA     '-',i 	     
         BREQ    tiret       
         CPA     'A',i       
         BRLT    erreur 
         CPA     'Z',i 
         BRLE    verifVoy
         CPA     'a',i
         BRLT    erreur 
         CPA     'z',i 
         BRLE    transMin 
         BR      erreur
transMin:SUBA    0x0020,i
         STBYTEA caract,d
verifVoy:LDX     0,i	       ;on verifie les voyelles pour les multiplier par 2
         STX     temApTr,d
         CPA     'A',i
         BREQ    multi2
         CPA     'E',i
         BREQ    multi2   
         CPA     'I',i
         BREQ    multi2   
         CPA     'O',i
         BREQ    multi2   
         CPA     'U',i
         BREQ    multi2   
         CPA     'Y',i
         BREQ    multi2
         BR      ltrNorm  
multi2:  SUBA    'A',i       ;on multiplie par deux
         ADDA    1,i
         ASLA    
         ADDA    totalCal,d  ;on aditionne a totalCal
         STA     totalCal,d
         BR      bclLect
ltrNorm: SUBA    'A',i       ;si c'est minuscule, on additione a totalCal
         ADDA    1,i
         ADDA    totalCal,d
         STA     totalCal,d
         BR      bclLect 
tiret:   LDX     temApTr,d   ;si c'est un tiret, on ajoute 27
         BRNE    erreur
         LDX     1,i 
         STX     temApTr,d
         LDA     totalCal,d
         ADDA    27,i
         STA     totalCal,d
         BR      bclLect
apost:   LDX     temApTr,d   ;si c'est un apostrophe, on ajoute 28
         BRNE    erreur
         LDX     1,i 
         STX     temApTr,d
         LDA     totalCal,d
         ADDA    28,i
         STA     totalCal,d
         BR      bclLect 

div10:   LDA     totalCal,d
         LDX     0,i
        ; CPA     0,i
        ; BREQ    fin
bcldiv10:SUBA    divis,i     ;on boucle jusqu'a c'est negatif
         ADDX    1,i
         CPA     0,i         
         BRGE    bcldiv10
         ADDA    divis,i     ;quand c'est negatif, on re-ajoute le divis
         SUBX    1,i
         STA     reste,d
         STX     res,d      
affich:  STRO    msgVali1,d  ;on affiche les messages de validation
         DECO    reste,d 
         STRO    msgVali2,d      
         LDA     0,i         ;vide le tampon
         STA     totalCal,d  ;vide le tampon
         BR      debut 
erreur:  STRO    msgErr,d  
         LDA     0,i         ;vide le tampon
         STA     totalCal,d  ;vide le tampon
entTamp: LDA     avCaract,d
         CPA     '\n',i
         BR      debut   
fin:     STRO    msgFin,d
         STOP

bienvenu:.ASCII  "Bienvenue au TP1 :\n\n\x00"
msgQuit: .ASCII  "Pour quitter, entrer ENTER\n"
msgEntre:.ASCII  "Veuillez entrer votre nom de famille:\x00"
msgErr:  .ASCII  "\nErreur: entr�e invalide!\n\n\x00"
msgVali1:.ASCII  "\nLe code de validation est \x00"
msgVali2:.ASCII  ".\n\n\x00"
msgFin:  .ASCII  "\nFin du programme.\x00"
avCaract:.BLOCK  1
caract:  .BLOCK  1               
totalCal:.BLOCK  2           ;#2d
divis:   .EQUATE 10          ;#2d
res:     .BLOCK 2            ;#2d
reste:   .BLOCK 2            ;#2d
temApTr: .BLOCK 2
         .END














