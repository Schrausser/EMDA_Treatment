REM ---------------------------------------------------------------------
REM                       EYE MOVEMENT DESENSITIZATION
REM                     _________________________________
REM                      Programm von Dietmar Schrausser
REM                                 (c) 1994
REM ---------------------------------------------------------------------
REM

REM ------------------------- Startdefinition ---------------------------

zwe = 0: dur = 20   ' ** Anzahl der Durchgänge.
neu:
CLS : SCREEN 8: COLOR 8, 7: GOSUB tit
taf1 = 8: taf2 = 15: ta = 0
DO
  IF INKEY$ = "e" THEN GOSUB dru: SOUND 200, 5: SLEEP (2): gru = 1: GOTO we
  IF INKEY$ = "a" THEN ta = 200: GOSUB dru: SOUND 150, 5: SLEEP (2): gru = 2: GOTO we
  IF INKEY$ = "„" THEN ta = 400: GOSUB dru: SOUND 100, 5: SLEEP (2): COLOR 15, 0: CLS : END
LOOP

we:
SCREEN 8: COLOR 15, 0

REM ---------------------------------------------------------------------
REM --------------------------- Hauptprogramm ---------------------------
REM ---------------------------------------------------------------------

emd1:
CLS
GOSUB ber
ON gru GOSUB demo1, demo2  ' ** Aufteilung der Demogruppen
GOSUB schl: GOSUB star
zf = VAL(MID$(TIME$, 7, 2))
ON gru GOTO vg, kg    '** Aufteilung der Gruppen VG oder KG

REM ------------------------------- VG ---------------------------------

vg:
FOR s% = 1 TO dur
    aa = 1: bb = 640: fa1 = 10: x1 = 0: x2 = 30: st = 1
    RANDOMIZE zf
    zfa = RND(2)
    IF s% > 1 AND zfa >= .87 THEN g = -1 ELSE g = 0 ' ** p(blau) = 0.13
    GOSUB emd:
NEXT
gru = 2
CLS
GOTO en

REM ------------------------------- KG1 ---------------------------------

kg:
FOR ii = 1 TO dur
  RESTORE
  FOR i = 1 TO 4
      RANDOMIZE zf
      zfa = RND(2)
      IF zfa < .5 THEN g = 1 ELSE g = 0
      GOSUB abla
  NEXT
 SLEEP (3)  ' ** Darbietungszeit
NEXT
CLS
gru = 1

en:
GOSUB schl: GOSUB ende
IF xx$ = "x" THEN CLS : END
IF xx$ = "m" THEN GOTO neu

GOTO emd1

REM -----------------------------------------------------------------------
REM ---------------------------- Unterprogramme ---------------------------
REM -----------------------------------------------------------------------

schl:
SLEEP (2)
RETURN

REM ------------------------------ Startmenü ------------------------------

tit:
LINE (80, 120)-(570, 40), 8, B
LINE (80, 120)-(570, 120), 15: LINE (570, 120)-(570, 40), 15
LINE (120, 56)-(125, 50), 2, BF: LINE (110, 64)-(115, 58), 2, BF
LINE (130, 64)-(135, 58), 1, BF: LINE (120, 72)-(125, 66), 1, BF
LOCATE 10, 19
PRINT "  E M D - Generator   by D.Schrausser (c)1994"
LOCATE 11, 18
PRINT " ______________________________________________"
IF zwe = 0 THEN GOSUB melo
zwe = 1
COLOR 15, 7: taf1 = 15: taf2 = 8: ta = -200
FOR i% = 1 TO 3
    ta = ta + 200
    GOSUB dru
NEXT
LOCATE 20, 13: PRINT "EMD (E)"
LOCATE 20, 38: PRINT "ABL (A)"
LOCATE 20, 62: PRINT "Ende (X)"
RETURN

REM ------------------------------ Demomessage ----------------------------

ber:
LOCATE 10, 25
LINE (150, 110)-(500, 50), 6, B
PRINT " D E M O - beliebige Taste drcken "
SLEEP: SLEEP (1)
CLS : SLEEP (1)
RETURN

REM ------------------------------ Startmessage ---------------------------

star:
COLOR 4, 0
LOCATE 10, 24
LINE (150, 110)-(500, 50), 4, B
PRINT "S T A R T - beliebige Taste Drcken "
SLEEP: SLEEP (1)
CLS : SLEEP (2)
RETURN

REM --------------------------------- Endmenü -----------------------------

ende:
COLOR 10, 0
LOCATE 10, 35
LINE (150, 120)-(500, 40), 2, B
PRINT " D A N K E !"
COLOR 4, 0
SLEEP (4)
CLS
SLEEP
IF gru = 1 THEN PRINT "Jetzt kommt    E M D" ELSE PRINT "Jetzt kommt    A B L a"
COLOR 15, 0
PRINT
INPUT "Weiter(W)  Menü(M)  Ende(X)"; xx$
RETURN

REM --------------------------------- EMD Demo ----------------------------

demo1:
GOSUB demologo
FOR a% = 1 TO 8
    aa = 1: bb = 640: fa1 = 10: x1 = 0: x2 = 30: st = 1
    IF a% = 4 OR a% = 6 THEN g = 1: df = 9: GOSUB meld:  ELSE g = 0
    IF a% = 5 OR a% = 7 THEN GOSUB lsch
    GOSUB emd
NEXT
CLS
RETURN

REM -------------------------------- ABL Demo ----------------------------

demo2:
GOSUB demologo
g = 0: h = 1
FOR i% = 1 TO 8
    RESTORE
    GOSUB lsch
    FOR j% = 1 TO 4
        IF i% < 3 OR i% = 5 THEN SWAP g, h
        IF i% = 6 THEN g = 1
        IF i% > 7 AND j% = 3 THEN g = 0
        GOSUB abla
    NEXT
    IF i% = 3 THEN df = 10: GOSUB meld
    IF i% = 6 THEN df = 9: GOSUB meld
    SLEEP (3)
    IF i% < 3 OR i% = 5 THEN SWAP g, h
NEXT
CLS
RETURN

REM -------------------------------- Demologo ----------------------------

demologo:
PRINT
PRINT "                           D E M O N S T R A T I O N"
RETURN
meld:
LOCATE 4, 30
COLOR df, 0
PRINT "jetzt Farbe melden ! "
RETURN
lsch:
LOCATE 4, 20
PRINT "                                                      "
RETURN

REM ------------------------------ E M D Prozedur ------------------------

emd:
    FOR r% = 1 TO 2
        FOR i% = aa TO bb STEP 7 * st    ' ** Geschwindigkeit
            LINE (i% - x1, 150)-(i% + x2, 40), fa1 - g, BF
            LINE (i% - x2, 150)-(i% + x1, 40), 0, BF
        NEXT
        SWAP aa, bb: SWAP x1, x2: st = -1
    NEXT
RETURN

REM ------------------------------ A B L Prozedur ------------------------

abla:
      READ x, y, x1, y1
      DATA 0,-45,0,-40,0,40,0,45,-80,0,-80,0,80,0,80,0
      LINE (300 + x, 120 + y)-(340 + x1, 80 + y1), 10 - g, BF
RETURN

REM --------------------------------- Melodie  ---------------------------

melo:
play$ = "l8cg.. l12 c.... g.... dcfe " 'd. c. f e... dfce..  c..     "
PLAY "<<<" + play$
PLAY "l5c."
RETURN

REM ---------------------------------- Tasten ----------------------------

dru:
LINE (80 + ta, 168)-(80 + ta, 145), taf1: LINE (80 + ta, 145)-(160 + ta, 145), taf1
LINE (80 + ta, 168)-(160 + ta, 168), taf2: LINE (160 + ta, 168)-(160 + ta, 145), taf2
RETURN

