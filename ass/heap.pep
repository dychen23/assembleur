         LDA     0,i
         LDX     0,i
bclLect: DECI    nbLu,d
         LDA     nbLu,d
         CPA     -1,i
         BRLE    affChne
         LDA     sizeBlck,i
         CALL    new
         LDA     nbLu,d
         STA     nbr,x
         LDA     -1,i
         STA     addrNxt,x
         LDA     addPrec,d
         CPA     -1,i 
         BREQ    sautPrec
         STX     addAct,d 
         LDX     addPrec,d 
         LDA     addAct,d
         STA     addrNxt,x

sautPrec:LDA     addAct,d
         STA     addPrec,d
         BR      bclLect
      
affChne: LDX     heap,d
         CPX     hpPtr,d
         BREQ    fin

bclAff: DECO     nbr,x
        LDX      
fin:    STOP

;******* operator new
;        Precondition: A contains number of bytes
;        Postcondition: X contains pointer to bytes
new:     LDX     hpPtr,d     ;returned pointer
         ADDA    hpPtr,d     ;allocate from heap
         STA     hpPtr,d     ;update hpPtr
         RET0           

;structure bloque
nbr:     .EQUATE 0           
addrNXT: .EQUATE 2
sizeBLCK:.EQUATE 4


nbLu:    .BLOCK  2
hpPtr:   .ADDRSS heap        ;address of next free byte
heap:    .BLOCK  1           ;first byte in the heap
VAR1:    .BLOCK 2
hpPtr:   .BLOCK 2
heap:    .BLOCK 0            
         .END ;ERROR: Symbol hpPtr was previously defined.