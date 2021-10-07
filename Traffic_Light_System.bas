;=============================================================
;=                                                           =
;=               Traffic Light Control System                =
;=                       By Sean Price                       =
;=                                                           =
;=============================================================
init: 
    clrf   PORTB        ; clear PORTB output latches
    bsf    STATUS,RP0   ; memory page 1
    movlw  b'11000000'  ; set portA pins 
    movwf  TRISA        ; write to TRIS register 
    movlw  b'00000000'  ; set portB pins 
    movwf  TRISB        ; write to TRIS register 
    bcf    STATUS,RP0   ; memory page 0
main:
    bsf    PORTA,1      ; Red Man
    movlw  b'01001000'  ; A Green B Red
    movwf  PORTB        ; write to PORT register 
    call   delay   
    movlw  b'01000100'  ; A Amber B Red
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    movlw  b'01000010'  ; Both Red
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    btfsc  PORTA,6      ; skip if A.6 is clear 
    call   crossing     ; Allow to cross
    movlw  b'01100010'  ; A Red B Red and Amber 
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    movlw  b'00010010'  ; A Red B Green
    movwf  PORTB        ; write to PORT register 
    call   delay  
    movlw  b'00100010'  ; A Red B Amber
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    movlw  b'01000010'  ; Both Red 
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    btfsc  PORTA,6      ; skip if A.6 is clear 
    call   crossing     ; Allow to cross
    movlw  b'01000110'  ; A Red and Amber B Red
    movwf  PORTB        ; write to PORT register 
    call   delay2  
    goto   main
crossing:
    bcf    PORTA,1      ; Red Man OFF
    bsf    PORTA,0      ; Green Man ON
    movlw  d'15'        ; move decimal 15 into working register
    movwf  B1           ; write to B1 register 
beep: 
    bsf    PORTA,2      ; Buzzer ON 
    call   wait100ms    ; delay 100 milliseconds 
    bcf    PORTA,2      ; Buzzer OFF
    call   wait100ms    ; delay 100 milliseconds 
    decfsz B1,F         ; decrement B1 and skip if zero 
    goto   beep         ; not zero so loop back again
    bcf    PORTA,0      ; Green Man OFF
    bsf    PORTA,1      ; Red Man ON
    return
delay:
    call wait1000ms
    call wait1000ms
    call wait1000ms
    call wait1000ms
    call wait1000ms
    call wait1000ms
    return
delay2:
    call wait1000ms
    call wait1000ms
    return

    
    
   
   
  