> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Wheelie Loading Screen. } TABLE#
@ $4000 label=LOADING
B $4000,6144,32 Pixels
B $5800,768,32 Attributes

b $5B00

c $6400

c $6833

c $74AA Print characters to the screen
@ $74AA label=PRINT_BIKE_GRAPHIC
  $74AA,2 #REGh=$78
  $74AC,2 Jump to #R$74B5

@ $74AE label=PRINT_LETTER
  $74AE,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $74AF,1 Double the value in #REGa
  $74B0,1 #REGl=#REGa
  $74B1,2 #REGh=$0F
  $74B3,2 Shift #REGhl left two bits
  $74B5,2 #REGb=$08
  $74B7,1 #REGc=#REGd
@ $74B8 label=PRINT_LETTER_LOOP
  $74B8,1 #REGa=(#REGhl)
  $74B9,1 Writes #REGa to the memory location held by #REGde
  $74BA,1 Increases #REGl by one
  $74BB,1 Increases #REGd by one
  $74BC,2 Decrease #REGb by one, jump to #R$74B8 if not zero
  $74BE,1 #REGd=#REGc
  $74BF,1 Increases #REGe by one
  $74C0,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $74C1,1 Return

  $74C3,2 #REGb=$20
  $74C5,3 #REGde=$5AE0
  $74C8,1 Writes #REGa to the memory location held by #REGde
  $74C9,1 Increases #REGe by one
  $74CA,2 Decrease #REGb by one, jump to #R$74C8 if not zero
  $74CC,2 #REGb=$20
  $74CE,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $74CF,3 #REGde=$50E0
  $74D2,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'

N $74D3
@ $74D3 label=PRINT_STRING
  $74D3,1 Stores the first letter of the string in #REGa
  $74D4,3 Calls the subroutine at #R$74AE
  $74D7,1 Increases #REGhl by one
  $74D8,2 Decrease #REGb by one, loop back to #R$74D3 and keep going until #REGb is zero
  $74DA,1 Return

c $74DC
  $74DC,3 #REGa=#R$7820

  $74EF,3 #REGde=$5A57

  $753C,8 Jump to #R$74C3 with #REGa=$82 #REGhl=#R$BA66.

c $7552 Lose a life
  $7552,4 Decrease #R$7839 by one
  $7556,$15 Beginning at $50CB (in the screen buffer) draw the lives using the bike UDG.
.           If the lives are "4" (i.e. a new game) then skip down to #R$756B.

  $7681,2 Set the border to the colour held in #REGa

  $7770,2 Set the border to the colour held in #REGa

  $778B,2 Set the border to the colour held in #REGa

  $77C4,2 #REGa=$9F
  $77C6,3 #REGhl=#R$BAC6
  $77C9,3 Calls the subroutine at #R$74C3
  $77CC,3 Calls the subroutine at #R$EC5E
  $77CF,3 Calls the subroutine at #R$6828

g $7839 Lives
@ $7839 label=LIVES_REMAINING
g $7850 ????

b $78AC "Ghostrider is finished" text
@ $78AC label=GHOST_RIDER_FIN_TEXT
T $78AC,$20

b $78CC

b $789C Bike graphic for Start Screen
@ $789C label=BIKE_GRAPHIC
B $789C #UDGARRAY2,attr=31,scale=4,step=1;(#PC)-(#PC+$08)-8(bike)

b $A800 Start Screen text
@ $A800 label=START_SCREEN_TEXT
T $A800,$20
T $A820,$20
T $A840,$20
T $A860,$20
T $A880,$20
T $A8A0,$20
T $A8C0,$20
T $A8E0,$20

b $A900 Start page footer
@ $A900 label=START_FOOTER
D $A900 #SCR2,0,0,32,8,$A900,$B100(footer)
B $A900,$800,$20 Pixels
B $B100,$100,$20 Attributes

b $B200

b $BA46 Game over text
@ $BA46 label=GAME_OVER_TEXT
T $BA46,$20,$20

b $BA66 Demo mode text
@ $BA66 label=DEMO_MODE_TEXT
T $BA66,$20,$20

b $BA86 Out of fuel text
@ $BA86 label=OUT_OF_FUEL_TEXT
T $BA86,$20,$20

b $BAA6 The race is on text
@ $BAA6 label=RACE_IS_ON_TEXT
T $BAA6,$20,$20

b $BAC6 New code text
@ $BAC6 label=NEW_CODE_TEXT
T $BAC6,$20,$20
T $BAE6,$1D

b $BAF3

b $BBA1 Level names
T $BBA1,$1C,$1B:1 Level 1
@ $BBA1 label=LEVEL_1_NAME
T $BBBD,$1C,$1B:1 Level 2
@ $BBBD label=LEVEL_2_NAME
T $BBD9,$1C,$1B:1 Level 3
@ $BBD9 label=LEVEL_3_NAME
T $BBF5,$1C,$1B:1 Level 4
@ $BBF5 label=LEVEL_4_NAME
T $BC11,$1C,$1B:1 Level 5
@ $BC11 label=LEVEL_5_NAME
T $BC2D,$1C,$1B:1 Level 6
@ $BC2D label=LEVEL_6_NAME
T $BC49,$1C,$1B:1 Level 7
@ $BC49 label=LEVEL_7_NAME
T $BC65,$1C,$1B:1 Level 8
@ $BC65 label=LEVEL_8_NAME


b $BC80

b $C3E0 HUD text
T $C3E0,$04
@ $C3E0 label=MPH_TEXT
T $C3E6,$04
@ $C3E6 label=FUEL_TEXT
T $C3EC,$04
@ $C3EC label=RPM_TEXT
T $C3F2,$06
@ $C3F2 label=SCORE_TEXT
T $C3F8,$07
@ $C3F8 label=TARGET_TEXT

b $C400

B $C543 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$10)-$01-$08(player-5)

B $C706 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$10)-$01-$08(player-6)
B $C719 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$10)-$01-$08(player-7)

B $C740 #UDGARRAY1,attr=7,scale=4;$C740-($C740+8)-1-8;$C753-($C753+8)-1-8;$C766-($C766+8)-1-8;$C766-($C766+8)-1-8(player-x)

B $C740 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(player-1)
B $C753 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(player-2)
B $C766 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(player-3)
B $C779 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(player-4)

B $C7B3 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(dot-1)
B $C7C6 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+8)-$01-$08(dot-2)


B $D5A0 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-1)
B $D5A2 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-2)
B $D5A3 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-3)
B $D5A4 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-4)

  $E81B,3 #REGhl=(#R$7850)
  $E81E,3 (#R$782C)=#REGhl
  $E821,3 Calls the subroutine at $749C
  $E824,3 Calls the subroutine at #R$E8E4
  $E827,1 #REGa=0
  $E828,1 #REGa=$FF
  $E829,3 (#R$7820)=#REGa
  $E82C,3 Calls the subroutine at #R$E891
  $E82F,3 Calls the subroutine at #R$6828

b $E871 Welcome header text
@ $E871 label=WELCOME_TEXT
T $E871,$20 Wheelie welcome header

c $E891 Displays the Start Screen
@ $E891 label=PINK_HEADER
N $E891 Sets the top two rows of the attribute buffer to magenta paper with white ink.
  $E891,10 Writes $1F (Magenta/ White) to the top two rows of the attribute buffer.
@ $E896 label=PINK_HEADER_LOOP

@ $E89B label=CLEAR_START_SCREEN
N $E89B Source is currently $5840, we write $06 (Black/Yellow) to the memory location held in the
.       source register. Target is then just "source+1", so the LDIR just fast copies into the
.       following $01BF memory locations (up to $59FF accounting for the top two-thirds of the screen).
  $E89B,10 Write $06 (Black/ Yellow) to the next $01BF memory locations of the attribute buffer

  $E8A5,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
N $E8A6 From here onward fills the screen buffer with text/ images.
.       Starting with the "welcome" text.
  $E8A6,3 #REGde=$4000 (top of the screen buffer)
  $E8A9,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8AA,8 Point #REGhl to #R$E871 ($20 characters in length) and call #R$74D3
N $E8B2 This section handles the cute row of bike graphics in the top of the display.
  $E8B2,2 #REGb=$10 (number of bike UDGs to display)
@ $E8B4 label=BANNER_BIKE_GRAPHIC_LOOP
  $E8B4,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8B5,5 Point #REGhl to #R$789C and call #R$74AA this prints the left half of the bike graphic
  $E8BA,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8BB,3 Calling the subroutine #R$74AA again prints the right half of the bike graphic
  $E8BE,2 Decrease bike counter by one, jump back to #R$E8B4 if not zero
N $E8C0 This loop prints the "start screen text" in blocks of $40 characters (two rows at a time).
  $E8C0,2 #REGc=$04 (there are 4 blocks of text to display)
  $E8C2,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8C3,3 #REGde=$4060 (position in screen buffer we're writing to)
  $E8C6,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl
  $E8C7,8 Point #REGhl to #R$A800 ($40 characters in length) and call #R$74D3
@ $E8CA label=START_SCREEN_TEXT_LOOP
  $E8CF,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8D0,9 Meh
@ $E8D6 label=START_SCREEN_TEXT_SKIP
  $E8D9,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $E8DD,3 Jump to #R$EBE6

u $E8E0
  $E8E2

c $E8E4 Displays the pink footer
@ $E8E4 label=PINK_FOOTER
N $E8E4 This routine moves the data at #R$A900 to the screen buffer (to draw the start page footer).
  $E8E4,3 #REGde=$5000 (target)
  $E8E7,3 #REGhl=#R$A900 (source)
  $E8EA,3 #REGbc=$0800 (counter)
  $E8ED,2 Action! Copy source to target, decrease counter, repeat until zero
  $E8EF,2 DE=$5A00 (target)
  $E8F1,2 #REGbc=$0100 (counter)
  $E8F3,2 Action! Copy source to target, decrease counter, repeat until zero
  $E8F5,1 Return

b $E900 Control selection page
@ $E900 label=CONTROL_SELECT_TEXT
T $E900,$100,$20 Wheelie control selection page
T $EA00,$20,$20 Change controls for (#R$EA60, #R$EA80, #R$EAA0, #R$EAC0, #R$EAE0)
T $EA20,$40,$20 Warning message
T $EA60,$20,$20 LEFT
@ $EA60 label=LEFT
T $EA80,$20,$20 RIGHT
@ $EA80 label=RIGHT
T $EAA0,$20,$20 UP
@ $EAA0 label=UP
T $EAC0,$20,$20 DOWN
@ $EAC0 label=DOWN
T $EAE0,$20,$20 FREEZE
@ $EAE0 label=FREEZE

b $EB00

c $EBE6 Long pause (roughly 3 seconds)
@ $EBE6 label=PAUSE
  $EBE6,13 Countdown from $ffff to $0000 a total of $05 times. This is just creating a big pause before allowing input.
@ $EBEB label=PAUSE_LOOP

c $EBF3

c $EC35
  $EC35,1 Disable interupts
  $EC36,1 #REGa=0
  $EC3C,1 Return

  $EC43,2 Set the border to the colour held in #REGa

  $EC5E,3 #REGhl=$EEE8
  $EC61,2 Jump to #R$EC35

  $EC63,3 #REGhl=$EF4F
  $EC66,2 Jump to #R$EC35

  $EC68,3 #REGhl=$EFC2
  $EC6B,2 Jump to #R$EC35

  $ECAB,6 #HTML(The keyboard repeat and delay values are loaded to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">REPDEL</a>
.         and <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">REPPER</a>.)

c $EC8E Print instructions
@ $EC8E label=PRINT_INSTRUCTIONS
  $EC8E,10 Fetch #REGhl from the shadow registers (beginning of the string to print), and set #REGde to the position in
.          the screen buffer for where to print. Then pass this all to #R$74D3 to print it to the screen.
  $EC98,8 Fetch #REGhl from the shadow registers (beginning of the string to print), and set #REGde to the position in
.         the screen buffer for where to print. Then pass this all to #R$74D3 to print it to the screen.
  $ECA0,10 Fetch #REGhl from the shadow registers (beginning of the string to print), and set #REGde to the position in
.          the screen buffer for where to print. Then pass this all to #R$74D3 to print it to the screen.
  $ECAA,1 Return

c $ECAB

  $ED51,1 Return

c $ED52 Playing Instruction display routine
  $ED52,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $ED53,3 #REGde=$4000 (top of the screen buffer)
  $ED56,1 Exchange #REGbc, #REGde, and #REGhl with shadow registers with #REGbc', #REGde', and #REGhl'
  $ED57,8 Point #REGhl to #R$EE74 ($20 characters in length) and call #R$74D3
  $ED5F,8 Point #REGhl to #R$EE94 and call the subroutine at #R$74C3 with $9F (magenta/ white with flash toggled)

N $ED67 Colours the screen for page one.
  $ED67,10 Write $28 (cyan/ black) to the attribute buffer $A0 times, starting from $5840
  $ED71,7 Write $30 (yellow/ black) to the attribute buffer $C0 times
  $ED78,7 Write $20 (green/ black) to the attribute buffer $E0 times
  $ED7F,7 Write $28 (cyan/ black) to the attribute buffer $60 times
N $ED86 Displays the instructions for page one.
  $ED86,6 Point #REGhl to #R$F000 and call #R$EC8E
  $ED8C,1 Store our position in the instructions for later
  $ED8D,3 Pause before allowing input (debounce)
  $ED90,6 Loop until a key is pressed (using #R$6828)

N $ED96 Displays the instructions for page two.
  $ED96,13 Writes $0F (blue/ white) to the attribute buffer $029F times starting at $5840
  $EDA3,4 Restore our place in the instructions and call #R$EC8E
  $EDA7,1 Store our position in the instructions for later
  $EDA8,3 Pause before allowing input (debounce)
  $EDAB,6 Loop until a key is pressed (using #R$6828)

N $EDB1 Colours the screen for page three.
  $EDB1,10 Write $28 (cyan/ black) to the attribute buffer $80 times, starting from $5960
  $EDBB,7 Write $20 (green/ black) to the attribute buffer $A0 times
  $EDC2,7 Write $30 (yellow/ black) to the attribute buffer $60 times
  $EDC9,24 Cycles through the following $04 times (initially starting at $5860);
.          #LIST
.            { Write $1B (magenta/ magenta) to the attribute buffer $09 times }
.            { Add $0037 to the position of the attribute buffer }
.          LIST#
.          One this is finished, it "pokes a hole" at $5924 making it the same colour as the background $09 (blue/ blue)
.          this gives a 4x4 magenta strip on the bottom row as the text refers to keys on the left and right.

N $EDE0 Displays the instructions for page three.
  $EDE0,4 Restore our place in the instructions and call #R$EC8E

  $EDE4,1 Store our position in the instructions for later

  $EDE5,3 Pause before allowing input (debounce)
  $EDE8,6 Loop until a key is pressed (using #R$6828)

  $EDEE,13 Writes $30 (yellow/ black) to the attribute buffer $029F times starting at $5840

  $EDFB,4 Restore our place in the instructions and call #R$EC8E

  $EDFF,3 Pause before allowing input (debounce)
  $EE02,6 Loop until a key is pressed (using #R$6828)
  $EE08,1 Return

u $EE09

b $EE94 Press any key
@ $EE94 label=PRESSANYKEY_TEXT
T $EE94,$20,$20

b $EE14 Code entry message
@ $EE14 label=CODE_ENTRY
T $EE14,$40,$20 Enter code message
T $EE54,$20,$20 Oops! You made a mistake!

b $EE74 How to play Wheelie
@ $EE74 label=INSTRUCTIONS_HEADER
T $EE74,$20,$20 Instructions header

b $EEB4 Code letter position
@ $EEB4 label=CODE_POS
T $EEB4,$0C,$03

b $EEC0 Passwords
@ $EEC0 label=PASSWORDS
T $EEC0,$23,$05 Passwords

b $EEE3

b $F000 Instructions
@ $F000 label=INSTRUCTIONS
T $F000,$280,$20 Page 1
T $F280,$280,$20 Page 2
T $F500,$280,$20 Page 3
T $F780,$280,$20 Page 4

b $FA00
