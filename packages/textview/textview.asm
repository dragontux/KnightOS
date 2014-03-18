.nolist
#include "kernel.inc"
#include "corelib.inc"
; TODO: add textview.lang
.list

; Program constants
#define BUFSIZE 0x10

; Program header
    .db 0, 50
.org 0
    jr start
    .db 'K'
    .db 0b00000010
    .db "Text Viewer", 0

; Functions
; Inputs:
;   HL: Pointer to path string of file to view
start:
    kld( hl, testPath )
    ld bc, 0
    pcall( cpHLBC )
    ; Return immediately if there's no path in HL
    jr z, _

    kjp( main )
_:
    ret

main:
    ; Initialization
    pcall( getLcdLock )
    pcall( getKeypadLock )
    pcall( allocScreenBuffer )

    ; Load needed libraries
    kld( de, corelibPath )
    pcall( loadLibrary )

_:
    kcall( redraw )
    corelib( appGetKey )
    cp kMode
    jr nz, -_

    ; Do stuff
    ret

; Redraw the window
redraw:
    push hl \ push af \ push de
        kld( hl, windowTitle )
        xor a
        corelib( drawWindow )

        ld de, 0x0208
        kld( hl, windowTitle )
        pcall( drawStr )

        ; Draw everything to screen
        pcall( fastCopy )
    pop de \ pop af \ pop hl
    ret

; Read-only program data 
windowTitle:
    ; TODO: use lang_windowTitle from textview.lang
    .db "Text Viewer", 0
corelibPath:
    .db "/lib/core", 0
testPath:
    .db "/etc/texttest", 0

; Modifiable program data 
; TODO: add vars here
