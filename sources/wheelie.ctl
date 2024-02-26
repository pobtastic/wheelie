; Copyright Microsphere 1983, 2024 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @rom
> $4000 @org=$4000
b $4000 Loading Screen
D $4000 #UDGTABLE { =h Wheelie Loading Screen. } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels.
  $5800,$0300,$20 Attributes.

c $5D11 Game Entry Point
@ $5D11 label=GameEntryPoint
  $5D11,$04 #REGsp=#N$FFFF.
  $5D15,$03 #HTML(#REGhl=*<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C53.html">PROG</a>.)
  $5D18,$03 #REGbc=#N$9B94.
  $5D1B,$03 #REGde=#N$FE00.
  $5D1E,$01 #REGhl+=#REGbc.
  $5D1F,$03 #REGbc=#N$9A01.
  $5D22,$02 Move the code into place.
  $5D24,$03 Jump to #R$6D1E.

b $5D27

c $6414
  $6414,$03 #HTML(#REGhl=*<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $6417,$01 #REGa=#REGh.
  $6418,$02,b$01 Keep only bits 0-1.
  $641A,$02 Jump to #R$641D if the result is not zero.
  $641C,$01 Increment #REGa by one.
  $641D,$02 #REGa+=#N$78.
  $641F,$01 #REGh=#REGa.
  $6420,$03 Write #REGhl to *#R$781E.
  $6423,$01 Return.

c $6424
  $6424,$02 #REGc=#N$05.
  $6426,$02 #REGb=#N$20.
  $6428,$01 #REGa=*#REGhl.
  $6429,$01 Increment #REGhl by one.
  $642A,$01 Write #REGa to *#REGde.
  $642B,$01 Increment #REGe by one.
  $642C,$02 Decrease counter by one and loop back to #R$6428 until counter is zero.
  $642E,$01 Decrease #REGe by one.
  $642F,$01 #REGa=#REGe.
  $6430,$02,b$01 Keep only bits 5-7.
  $6432,$01 #REGe=#REGa.
  $6433,$01 Increment #REGd by one.
  $6434,$01 Decrease #REGc by one.
  $6435,$02 Jump to #R$6426 until #REGc is zero.
  $6437,$02 #REGa+=#N$20.
  $6439,$01 #REGe=#REGa.
  $643A,$01 Return if #REGa is zero.
  $643B,$01 #REGa=#REGd.
  $643C,$02 #REGa-=#N$05.
  $643E,$01 #REGd=#REGa.
  $643F,$01 Return.

c $6440

c $6500

c $67E9
  $67E9,$07 Compare *#R$7814 is not equal to #N$02.
  $67F0,$02 Write #N$00 to *#REGhl.
  $67F2,$01 Increment #REGhl by one.
  $67F3,$01 #REGa=*#REGhl.
  $67F4,$02 Return if #REGa is zero.
  $67F6,$02 Write #N$00 to *#REGhl.
  $67F8,$05 Jump to #R$672E #REGa is equal to #N$02.
  $67FD,$03 Jump to #R$678C.

c $6800
  $6800,$03 Write #REGa to *#R$7819.
  $6803,$01 #REGa=#REGl.
  $6804,$02 #REGa-=#N$08.
  $6806,$01 #REGl=#REGa.
  $6807,$02 Jump to #R$680D if {} is higher.
  $6809,$01 #REGa=#REGh.
  $680A,$02 #REGa-=#N$05.
  $680C,$01 #REGh=#REGa.
  $680D,$03 Write #REGhl to *#R$7817.
  $6810,$03 #REGhl=#N($0000,$04,$04).
  $6813,$03 Write #REGhl to *#R$7814.
  $6816,$02 #REGb=#N$20.
  $6818,$01 Stash #REGbc on the stack.
  $6819,$03 Call #R$659C.
  $681C,$03 Call #R$659C.
  $681F,$03 Call #R$67E9.
  $6822,$01 Restore #REGbc from the stack.
  $6823,$02 Decrease counter by one and loop back to #R$6818 until counter is zero.
  $6825,$01 Return.

u $6826

c $6828 Get Keyboard Input
@ $6828 label=KeyboardInput
  $6828,$03 #REGde=#R$FE00.
  $682B,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $6830,$01 Invert the bits in #REGa.
  $6831,$02,b$01 Keep only bits 0-4.
  $6833,$02 Jump to #R$6836 if {} is zero.
  $6835,$01 Set the carry flag.
  $6836,$02 Rotate #REGe left.
  $6838,$02 Rotate #REGd left.
  $683A,$02 Jump to #R$6840 if {} is higher.
  $683C,$02 Rotate #REGb left (with carry).
  $683E,$02 Jump to #R$682E.
  $6840,$01 #REGa=#REGe.
  $6841,$01 RRCA.
  $6842,$02 Jump to #R$6846 if {} is higher.
  $6844,$02 Set bit 0 of #REGd.
  $6846,$01 RRCA.
  $6847,$02 Jump to #R$684B if {} is higher.
  $6849,$02 Set bit 2 of #REGd.
  $684B,$01 RRCA.
  $684C,$02 Jump to #R$6850 if {} is higher.
  $684E,$02 Set bit 3 of #REGd.
  $6850,$01 RRCA.
  $6851,$02 Jump to #R$6855 if {} is higher.
  $6853,$02 Set bit 4 of #REGd.
  $6855,$01 RRCA.
  $6856,$02 Jump to #R$685A if {} is higher.
  $6858,$02 Set bit 4 of #REGd.
  $685A,$01 RRCA.
  $685B,$02 Jump to #R$685F if {} is higher.
  $685D,$02 Set bit 3 of #REGd.
  $685F,$01 RRCA.
  $6860,$02 Jump to #R$6864 if {} is higher.
  $6862,$02 Set bit 2 of #REGd.
  $6864,$01 RRCA.
  $6865,$02 Jump to #R$6869 if {} is higher.
  $6867,$02 Set bit 1 of #REGd.
  $6869,$01 #REGa=#REGd.
  $686A,$02,b$01 Keep only bits 0-1.
  $686C,$02 Compare #REGa with #N$03.
  $686E,$02 Jump to #R$6872 if {} is not zero.
  $6870,$01 Flip the bits according to #REGd.
  $6871,$01 #REGd=#REGa.
  $6872,$01 #REGa=#REGd.
  $6873,$02,b$01 Keep only bits 2-3.
  $6875,$02 Compare #REGa with #N$0C.
  $6877,$02 Jump to #R$687B if {} is not zero.
  $6879,$01 Flip the bits according to #REGd.
  $687A,$01 #REGd=#REGa.
  $687B,$01 #REGa=#REGd.
  $687C,$01 Return.

b $687D

c $687D

c $6CAA
  $6CAA,$03 Call #R$75AA.
  $6CAD,$06 Write #N$3400 to *#R$783C.
  $6CB3,$03 #REGhl=#R$7815.
  $6CB6,$02 Write #N$00 to *#REGhl.
  $6CB8,$01 Decrease #REGl by one.
  $6CB9,$02 Write #N$00 to *#REGhl.
  $6CBB,$02 #REGl=#N$1A.
  $6CBD,$02 Write #N$01 to *#REGhl.
  $6CBF,$01 Increment #REGl by one.
  $6CC0,$02 Write #N$00 to *#REGhl.
  $6CC2,$01 Increment #REGl by one.
  $6CC3,$02 Write #N$00 to *#REGhl.
  $6CC5,$01 Increment #REGl by one.
  $6CC6,$02 Write #N$B2 to *#REGhl.
  $6CC8,$02 #REGl=#N$21.
  $6CCA,$02 #REGb=#N$03.
  $6CCC,$02 Write #N$80 to *#REGhl.
  $6CCE,$01 Increment #REGl by one.
  $6CCF,$02 Decrease counter by one and loop back to #R$6CCC until counter is zero.
  $6CD1,$02 #REGb=#N$08.
  $6CD3,$02 Write #N$00 to *#REGhl.
  $6CD5,$01 Increment #REGl by one.
  $6CD6,$02 Decrease counter by one and loop back to #R$6CD3 until counter is zero.
  $6CD8,$02 Increment #REGl by two.
  $6CDA,$02 Write #N$13 to *#REGhl.
  $6CDC,$01 Increment #REGl by one.
  $6CDD,$02 Write #N$A1 to *#REGhl.
  $6CDF,$01 Increment #REGl by one.
  $6CE0,$02 Write #N$03 to *#REGhl.
  $6CE2,$01 Increment #REGl by one.
  $6CE3,$02 Write #N$00 to *#REGhl.
  $6CE5,$01 Increment #REGl by one.
  $6CE6,$02 Write #N$BB to *#REGhl.
  $6CE8,$01 Increment #REGl by one.
  $6CE9,$02 Write #N$0B to *#REGhl.
  $6CEB,$01 Increment #REGl by one.
  $6CEC,$02 Write #N$00 to *#REGhl.
  $6CEE,$03 Call #R$6500.
  $6CF1,$02 #REGl=#N$10.
  $6CF3,$07 Jump to #R$6D11 if *#R$782D is not equal to #N$73.
  $6CFA,$03 #REGhl=#R$A1E0.
  $6CFD,$01 #REGa=*#REGhl.
  $6CFE,$01 Decrease #REGl by one.
  $6CFF,$01 Decrease #REGa by one.
  $6D00,$02 Jump to #R$6D0A if #REGa is zero.
  $6D02,$04 Jump to #R$6CFD if #REGa is higher than #N$31.
  $6D06,$04 Jump to #R$6CFD if #REGa is lower than #N$2D.
  $6D0A,$01 #REGa=#REGl.
  $6D0B,$01 Increment #REGa by one.
  $6D0C,$03 Write #REGa to *#R$782E.
  $6D0F,$02 Decrease #REGl by two.
  $6D11,$02 #REGh=#N$9E.
  $6D13,$01 Flip the bits according to #REGa.
  $6D14,$03 Call #R$6800.
  $6D17,$03 #HTML(#REGa=*<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $6D1A,$01 Increment #REGa by one.
  $6D1B,$03 Jump to #R$EBF6.

c $6D1E
  $6D1E,$03 Jump to #R$E80E.

c $6D21

c $7420

c $742C
  $742C,$03 Write #REGhl to *#R$7846.
  $742F,$01 Switch to the shadow registers.
  $7430,$03 #REGde'=#N$51C6 (screen buffer location).
  $7433,$01 Switch back to the normal registers.
  $7434,$03 #REGde=#R$784B.
  $7437,$03 #REGbc=#N$D810.
  $743A,$02 #REGa=#N$FF.
  $743C,$01 Increment #REGa by one.
  $743D,$01 #REGhl+=#REGbc.
  $743E,$02 Jump to #R$743C if {} is lower.
  $7440,$02 #REGhl-=#REGbc.
  $7442,$01 Write #REGa to *#REGde.
  $7443,$01 Increment #REGe by one.
  $7444,$03 #REGbc=#N$FC18.
  $7447,$02 #REGa=#N$FF.
  $7449,$01 Increment #REGa by one.
  $744A,$01 #REGhl+=#REGbc.
  $744B,$02 Jump to #R$7449 if {} is lower.
  $744D,$02 #REGhl-=#REGbc.
  $744F,$01 Write #REGa to *#REGde.
  $7450,$01 Increment #REGe by one.
  $7451,$03 #REGbc=#N$FF9C.
  $7454,$02 #REGa=#N$FF.
  $7456,$01 Increment #REGa by one.
  $7457,$01 #REGhl+=#REGbc.
  $7458,$02 Jump to #R$7456 if {} is lower.
  $745A,$02 #REGhl-=#REGbc.
  $745C,$01 Write #REGa to *#REGde.
  $745D,$01 Increment #REGe by one.
  $745E,$02 #REGc=#N$F6.
  $7460,$02 #REGa=#N$FF.
  $7462,$01 Increment #REGa by one.
  $7463,$01 #REGhl+=#REGbc.
  $7464,$02 Jump to #R$7462 if {} is lower.
  $7466,$01 Write #REGa to *#REGde.
  $7467,$01 Increment #REGe by one.
  $7468,$01 #REGa=#REGl.
  $7469,$02 #REGa+=#N$0A.
  $746B,$01 Write #REGa to *#REGde.
  $746C,$01 Switch to the shadow registers.
  $746D,$03 #REGbc=#R$784B.
  $7470,$01 #REGa=*#REGbc.
  $7471,$01 #REGa+=#REGa.
  $7472,$01 #REGa+=#REGa.
  $7473,$01 #REGa+=#REGa.
  $7474,$02 #REGa+=#N$81.
  $7476,$01 #REGl=#REGa.
  $7477,$02 #REGh=#N$3D.
  $7479,$01 #REGa=*#REGhl.
  $747A,$01 Write #REGa to *#REGde.
  $747B,$01 Increment #REGl by one.
  $747C,$01 Increment #REGd by one.
  $747D,$01 #REGa=*#REGhl.
  $747E,$01 Write #REGa to *#REGde.
  $747F,$01 Increment #REGl by one.
  $7480,$01 Increment #REGd by one.
  $7481,$01 #REGa=*#REGhl.
  $7482,$01 Write #REGa to *#REGde.
  $7483,$01 Increment #REGl by one.
  $7484,$01 Increment #REGd by one.
  $7485,$01 #REGa=*#REGhl.
  $7486,$01 Write #REGa to *#REGde.
  $7487,$01 Increment #REGl by one.
  $7488,$01 Increment #REGd by one.
  $7489,$01 #REGa=*#REGhl.
  $748A,$01 Write #REGa to *#REGde.
  $748B,$01 Increment #REGl by one.
  $748C,$01 Increment #REGd by one.
  $748D,$01 #REGa=*#REGhl.
  $748E,$01 Write #REGa to *#REGde.
  $748F,$02 #REGd=#N$51.
  $7491,$01 Increment #REGe by one.
  $7492,$01 Increment #REGc by one.
  $7493,$04 Jump to #R$7470 if bit 3 of #REGc is not zero.
  $7497,$01 Switch to the shadow registers.
  $7498,$01 Return.

c $749C Clear Screen
@ $749C label=ClearScreen
  $749C,$03 #REGhl=#R$4000(#N$4000) (screen buffer location).
  $749F,$01 Write #N$00 to *#REGhl.
  $74A0,$03 #REGbc=#N$1B00.
  $74A3,$03 #REGde=#REGhl+#N$01.
  $74A6,$02 Copy #N$00 across both the screen and attribute buffers.
  $74A8,$01 Return.

b $74A9

c $74AA Print Bike Graphic
@ $74AA label=PrintBikeGraphic
  $74AA,$02 #REGh=#N$78.
  $74AC,$02 Jump to #R$74B5.

c $74AE Print Letter
@ $74AE label=PrintLetter
  $74AE,$01 Switch to the shadow registers.
  $74AF,$02 #REGl=#REGa*#N$02.
  $74B1,$02 #REGh=#N$0F.
  $74B3,$02 #REGhl*=#N$04.
@ $74B5 label=PrintUDG
  $74B5,$02 #REGb=#N$08.
  $74B7,$01 #REGc=#REGd.
@ $74B8 label=PrintUDGG_Loop
  $74B8,$01 #REGa=*#REGhl.
  $74B9,$01 Write #REGa to *#REGde.
  $74BA,$01 Increment #REGl by one.
  $74BB,$01 Increment #REGd by one.
  $74BC,$02 Decrease counter by one and loop back to #R$74B8 until counter is zero.
  $74BE,$01 #REGd=#REGc.
  $74BF,$01 Increment #REGe by one.
  $74C0,$01 Switch back to the normal registers.
  $74C1,$01 Return.

b $74C2

c $74C3 Print Footer Colour String
@ $74C3 label=PrintFooterColourString
D $74C3 Given an attribute value and a pointer to a string of #N$20 bytes, this routine will print a string to the
.       footer of the screen buffer using the given attribute colour.
D $74C3 Used by the routines at #R$74DC, #R$75AA and #R$ED52.
E $74C3 Continue on to #R$74D3.
R $74C3 A Attribute
R $74C3 HL Address of the string
  $74C3,$02 #REGb=#N$20 (counter of number of characters in a row).
  $74C5,$03 #REGde=#N$5AE0 (footer attribute buffer location).
@ $74C8 label=PrintColourString_Loop
  $74C8,$01 Write #REGa to *#REGde.
  $74C9,$01 Increment #REGe by one.
  $74CA,$02 Decrease counter by one and loop back to #R$74C8 until counter is zero.
  $74CC,$02 #REGb=#N$20 (counter of number of characters in string).
  $74CE,$01 Switch to the shadow registers.
  $74CF,$03 #REGde'=#N$50E0 (footer screen buffer location).
  $74D2,$01 Switch back to the normal registers.

c $74D3 Print Loop
@ $74D3 label=Print_Loop
R $74D3 B Counter; number of characters to print
R $74D3 HL Address of the string
R $74D3 DE' Screen buffer address for output
  $74D3,$01 Fetch a character from the string, store it in #REGa.
  $74D4,$03 Call #R$74AE.
  $74D7,$01 Increment the string pointer by one.
  $74D8,$02 Decrease counter by one and loop back to #R$74D3 until counter is zero.
  $74DA,$01 Return.

b $74DB

c $74DC

c $7535 Print "Demo Mode"
@ $7535 label=PrintDemoMode
  $7535,$07 Jump to #R$7544 if *#R$782D is not equal to #N$73.
  $753C,$02 #REGa=#N$82 (#COLOUR$82).
  $753E,$03 #REGhl=#R$BA66.
  $7541,$03 Jump to #R$74C3.
N $7544 If this is not demo mode then set the attributes to #COLOUR$00 where it would normally display the demo mode
.       footer messaging.
@ $7544 label=NotDemoMode
  $7544,$03 #REGhl=#N$5AE0 (footer attribute buffer location).
  $7547,$02 #REGb=#N$20.
@ $7549 label=NotDemoMode_Loop
  $7549,$02 Write #N$00 to *#REGhl.
  $754B,$01 Increment #REGl by one.
  $754C,$02 Decrease counter by one and loop back to #R$7549 until counter is zero.
  $754E,$01 Return.

c $754F Initialise Game
@ $754F label=InitialiseGame
  $754F,$03 Call #R$7535.
  $7552,$04 Decrease *#R$7839 by one.
N $7556 Compare the players current lives with the maximum number of lives (#N$04).
  $7556,$01 #REGc=*#R$7839.
  $7557,$02 #REGa=#N$04 (the maximum number of lives).
  $7559,$01 Switch to the shadow registers.
  $755A,$03 #REGde'=#N$50CB (screen buffer location).
  $755D,$01 Switch back to the normal registers.
  $755E,$01 #REGa-=#REGc.
  $755F,$02 Jump to #R$756B if #REGa is zero.
  $7561,$02 #REGb=#REGa*#N$02.
  $7563,$01 Switch to the shadow registers.
  $7564,$02 #REGl=#R$7864(#N$64).
  $7566,$03 Call #R$74AA.
  $7569,$02 Decrease counter by one and loop back to #R$7563 until counter is zero.
  $756B,$01 #REGa=#REGc.
  $756C,$03 Jump to #R$757E if #REGa is zero.
N $756F Display the bike graphic for each remaining life.
  $756F,$01 #REGb=#REGc (counter; current number of lives).
@ $7570 label=Print_Lives
  $7570,$01 Switch to the shadow registers.
  $7571,$02 #REGl'=#R$789C(#N$9C).
N $7573 Print the left side of the bike graphic.
  $7573,$03 Call #R$74AA.
  $7576,$01 Switch back to the normal registers.
N $7577 Print the right side of the bike graphic.
  $7577,$03 Call #R$74AA.
  $757A,$02 Decrease counter by one and loop back to #R$7570 until counter is zero.
  $757C,$01 Return.

b $757D
  $757D,$01

c $757E Game Over
@ $757E label=GameOver
  $757E,$03 Call #R$7420.
  $7581,$03 #REGhl=*#R$7848.
  $7584,$04 #REGde=*#R$7846.
  $7588,$01 Set flags.
  $7589,$02 #REGhl-=#REGde (with carry).
  $758B,$02 Jump to #R$7599 if {} is higher.
  $758D,$01 Exchange the #REGde and #REGhl registers.
  $758E,$03 Write #REGhl to *#R$7848.
  $7591,$01 Switch to the shadow registers.
  $7592,$03 #REGde=#N$51DB (screen buffer location).
  $7595,$01 Switch to the shadow registers.
  $7596,$03 Call #R$7434.
  $7599,$02 #REGa=#N$84 (#COLOUR$84).
  $759B,$03 #REGhl=#R$BA46.
  $759E,$03 Call #R$74C3.
@ $75A1 label=GameOver_Input
  $75A1,$03 Call #R$6828.
  $75A4,$03 Jump to #R$75A1 until any key is pressed.
  $75A7,$03 Jump to #R$E81B.

c $75AA Print Game Display
@ $75AA label=PrintGameDisplay
D $75AA #UDGTABLE(default,centre) { #PUSHS #SIM(start=$75AA,stop=$7638) #SCR$02(game-display) #POPS } UDGTABLE#
D $75AA Used by the routine at #R$6CAA.
  $75AA,$03 Call #R$749C.
  $75AD,$05 Write #N$05 to *#R$7839.
N $75B2 Set the attributes for the "ground".
  $75B2,$02 #REGh=#N$5A.
  $75B4,$02 #REGb=#N$40 (counter; two full rows).
@ $75B6 label=GameDisplay_GreenBarLoop
  $75B6,$02 Write #N$04 (#COLOUR$04) to *#REGhl.
  $75B8,$01 Increment #REGl by one.
  $75B9,$02 Decrease counter by one and loop back to #R$75B6 until counter is zero.
N $75BB Draw the "ground".
  $75BB,$02 #REGc=#N$04 (counter; how many times to write the byte).
  $75BD,$03 #REGhl=#N$5000 (screen buffer location).
@ $75C0 label=DrawGround_Loop
  $75C0,$02 #REGb=#N$40 (counter; two full rows).
@ $75C2 label=DrawGround_WriteLoop
  $75C2,$02 Write #N$55 to *#REGhl.
  $75C4,$01 Increment #REGl by one.
  $75C5,$02 Decrease counter by one and loop back to #R$75C2 until counter is zero.
  $75C7,$02 Increment #REGh by two.
  $75C9,$02 #REGl=#N$00.
  $75CB,$01 Decrease #REGc by one.
  $75CC,$02 Jump to #R$75C0 until #REGc is zero.
  $75CE,$02 #REGc=#N$03.
  $75D0,$03 #REGhl=#N$5A41 (attribute buffer location).
  $75D3,$02 #REGb=#N$04.
  $75D5,$02 Write #N$07 (#COLOUR$07) to *#REGhl.
  $75D7,$01 Increment #REGl by one.
  $75D8,$02 Decrease counter by one and loop back to #R$75D5 until counter is zero.
  $75DA,$01 #REGa=#REGl.
  $75DB,$02 #REGa+=#N$1C.
  $75DD,$01 #REGl=#REGa.
  $75DE,$01 Decrease #REGc by one.
  $75DF,$02 Jump to #R$75D3 until #REGc is zero.
  $75E1,$02 #REGl=#N$C0.
  $75E3,$02 #REGb=#N$20.
  $75E5,$02 Write #N$07 (#COLOUR$07) to *#REGhl.
  $75E7,$01 Increment #REGl by one.
  $75E8,$02 Decrease counter by one and loop back to #R$75E5 until counter is zero.
N $75EA Handles printing "MPH, FUEL, RPM" (bike stats) to the display.
  $75EA,$02 #REGc=#N$03 (counter; three strings).
  $75EC,$03 #REGhl=#R$C3E0.
  $75EF,$01 Switch to the shadow registers.
  $75F0,$03 #REGde'=#N$5041 (screen buffer location).
  $75F3,$01 Switch back to the normal registers.
@ $75F4 label=GameDisplay_StatsLoop
  $75F4,$02 #REGb=#N$04 (counter; number of characters in each string).
  $75F6,$03 Call #R$74D3.
N $75F9 At the end of each string there are two more bytes which build the up/ down arrow shown above "TARGET". This is
.       hidden by the attributes until it's shown in-game by setting the appropriate attribute values.
  $75F9,$01 #REGa=*#REGhl.
  $75FA,$01 Switch to the shadow registers.
  $75FB,$01 #REGl'=#REGa.
  $75FC,$04 #REGe'+=#N$0E.
  $7600,$03 Call #R$74AA.
  $7603,$01 Increment #REGl by one.
  $7604,$01 Switch back to the normal registers.
  $7605,$03 Call #R$74AA.
  $7608,$01 Increment #REGl by one.
  $7609,$01 Switch to the shadow registers.
  $760A,$04 #REGe'+=#N$0C.
  $760E,$01 Switch back to the normal registers.
  $760F,$01 Decrease #REGc by one.
  $7610,$02 Jump to #R$75F4 until #REGc is zero.
N $7612 Set the screen buffer position.
  $7612,$01 Switch to the shadow registers.
  $7613,$02 #REGe'=#N$C0.
  $7615,$01 Switch back to the normal registers.
  $7616,$02 #REGb=#N$06 (counter; number of characters in the "#STR($C3F2,$04,$06)" string).
  $7618,$03 Call #R$74D3.
N $761B Set the screen buffer position.
  $761B,$01 Switch to the shadow registers.
  $761C,$02 #REGe'=#N$D4.
  $761E,$01 Switch back to the normal registers.
  $761F,$02 #REGb=#N$07 (counter; number of characters in the "#STR($C3F8,$04,$07)" string).
  $7621,$03 Call #R$74D3.
  $7624,$06 Write #N($0000,$04,$04) to *#R$7844.
  $762A,$03 Call #R$742C.
  $762D,$03 #REGhl=*#R$7848.
  $7630,$01 Switch to the shadow registers.
  $7631,$03 #REGde'=#N$51DB (screen buffer location).
  $7634,$01 Switch back to the normal registers.
  $7635,$03 Call #R$7434.
  $7638,$03 Jump to #R$754F.

u $763B

c $763C

g $781E
W $781E,$02

g $782C
B $782C,$02,$01

g $782E

g $7839 Lives
@ $7839 label=Lives
B $7839,$01

g $783C Fuel
@ $783C label=Fuel
B $783C,$02,$01

g $7840

g $7844 Score
@ $7844 label=Score
  $7846
  $7848
  $784B

g $7850 Control Method
@ $7850 label=ControlMethod
D $7850 Pointer to the routine which will handle retrieving the player controls.
W $7850,$02

g $7852
B $7852,$01

g $7853 User-Defined KeyMap
@ $7853 label=UserDefinedKeyMap
B $7853,$01
B $7854,$01
B $7855,$01
B $7856,$01
B $7857,$01

g $7858

g $785A

g $785B AGF Interface KeyMap
@ $785B label=AGFInterfaceKeyMap
B $785B,$01
B $785C,$01
B $785D,$01
B $785E,$01
B $785F,$01

b $7860

b $7864 Graphics:
@ $7864 label=Graphics_Sssss
N $7864 #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(hmmmm-01)
  $7864,$10,$08
N $7874 #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(hmmmm-02)
  $7874,$10,$08
N $7884 #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(hmmmm-03)
  $7884,$10,$08

b $789C Graphics: Bike (Start Screen)
@ $789C label=Graphics_StartScreenBike
D $789C #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(bike)
  $789C,$10,$08

t $78AC Messaging: Ghostrider Is Finished
@ $78AC label=Messaging_GhostRiderFinished
  $78AC,$20 "#STR(#PC,$04,$20)".

b $78CC

b $A1E0

t $A800 Messaging: Start Screen
@ $A800 label=Messaging_StartScreen
  $A800,$20 "#STR(#PC,$04,$20)".
  $A820,$20 "#STR(#PC,$04,$20)".
  $A840,$20 "#STR(#PC,$04,$20)".
  $A860,$20 "#STR(#PC,$04,$20)".
  $A880,$20 "#STR(#PC,$04,$20)".
  $A8A0,$20 "#STR(#PC,$04,$20)".
  $A8C0,$20 "#STR(#PC,$04,$20)".
  $A8E0,$20 "#STR(#PC,$04,$20)".

b $A900 Start Page Footer
@ $A900 label=Footer_StartScreen
D $A900 #SCR$02,$00,$00,$20,$08,$A900,$B100(footer)
  $A900,$0800,$20 Pixels.
  $B100,$0100,$20 Attributes.

b $B200

t $BA46 Messaging: Game Over
@ $BA46 label=Messaging_GameOver
  $BA46,$20 "#STR(#PC,$04,$20)".

t $BA66 Messaging: Demo Mode
@ $BA66 label=Messaging_DemoMode
  $BA66,$20 "#STR(#PC,$04,$20)".

t $BA86 Messaging: Out Of Fuel
@ $BA86 label=Messaging_OutOfFuel
  $BA86,$20 "#STR(#PC,$04,$20)".

t $BAA6 Messaging: The Race Is On
@ $BAA6 label=Messaging_RaceIsOn
  $BAA6,$20 "#STR(#PC,$04,$20)".

t $BAC6 Messaging: New Code
@ $BAC6 label=Messaging_NewCode
  $BAC6,$20 "#STR(#PC,$04,$20)".
  $BAE6,$0D "#STR(#PC,$04,$0D)".

b $BAF3

t $BBA1 Messaging: Level Names
@ $BBA1 label=Messaging_Level1
  $BBA1,$1C,$1B:$01 Level 1
@ $BBBD label=Messaging_Level2
  $BBBD,$1C,$1B:$01 Level 2
@ $BBD9 label=Messaging_Level3
  $BBD9,$1C,$1B:$01 Level 3
@ $BBF5 label=Messaging_Level4
  $BBF5,$1C,$1B:$01 Level 4
@ $BC11 label=Messaging_Level5
  $BC11,$1C,$1B:$01 Level 5
@ $BC2D label=Messaging_Level6
  $BC2D,$1C,$1B:$01 Level 6
@ $BC49 label=Messaging_Level7
  $BC49,$1C,$1B:$01 Level 7
@ $BC65 label=Messaging_Level8
  $BC65,$1C,$1B:$01 Level 8

b $BC81

t $C3E0 Messaging: MPH
@ $C3E0 label=Messaging_MPH
  $C3E0,$04 "#STR(#PC,$04,$04)".

b $C3E4 Graphics: Arrow Top
@ $C3E4 label=Graphics_ArrowTop
  $C3E4,$02

t $C3E6 Messaging: Fuel
@ $C3E6 label=Messaging_Fuel
  $C3E6,$04 "#STR(#PC,$04,$04)".

b $C3EA Graphics: Arrow Middle
@ $C3EA label=Graphics_ArrowMiddle
  $C3EA,$02

t $C3EC Messaging: RPM
@ $C3EC label=Messaging_RPM
  $C3EC,$04 "#STR(#PC,$04,$04)".

b $C3F0 Graphics: Arrow Bottom
@ $C3F0 label=Graphics_ArrowBottom
  $C3F0,$02

t $C3F2 Messaging: Score
@ $C3F2 label=Messaging_Score
  $C3F2,$06 "#STR(#PC,$04,$06)".

t $C3F8 Messaging: Target
@ $C3F8 label=Messaging_Target
  $C3F8,$07 "#STR(#PC,$04,$07)".

b $C400

b $D5A0
B $D5A0 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-1)
B $D5A2 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-2)
B $D5A3 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-3)
B $D5A4 #UDGARRAY1,attr=7,scale=4,step=1;(#PC)-(#PC+$11)-$01-$10(kangaroo-4)

c $E800 Initialise Demo Mode
@ $E800 label=InitialiseDemoMode
  $E800,$06 Write #R$73B7 to *#R$782C.
  $E806,$05 Write #N$05 to *#R$7820.
  $E80B,$03 Jump to #R$6CAA.

c $E80E
  $E80E,$04 #REGsp=#N$FFFF.
  $E812,$03 Call #R$6414.
  $E815,$06 Write #R$6828 to #R$7850.
@ $E81B label=StartScreen
  $E81B,$06 Write *#R$7850 to *#R$782C.
  $E821,$03 Call #R$749C.
  $E824,$03 Call #R$E8E4.
  $E827,$01 #REGa=#N$00.
  $E828,$01 Decrease #REGa by one.
  $E829,$03 Write #REGa to *#R$7820.
  $E82C,$03 Call #R$E891.
N $E82F Wait for keyboard input.
@ $E82F label=StartScreen_Input
  $E82F,$03 Call #R$6828.
  $E832,$03 Jump to #R$E82F until any key is pressed.
N $E835 Should we start the demo mode?
  $E835,$05 Call #R$E800 if a key from the top row has been pressed.
N $E83A Should we display the instructions?
  $E83A,$04 Jump to #R$E843 if a key from the second row has not been pressed.
  $E83E,$03 Call #R$ED52.
  $E841,$02 Jump to #R$E81B.
N $E843 Should we start a new game?
@ $E843 label=TestStartGame
  $E843,$05 Jump to #R$ECAB if a key from the third row has not been pressed.
N $E848 Else a key from the third row was pressed so handle changing the controls.
  $E848,$03 Call #R$EB43.
  $E84B,$02 Jump to #R$E81B.

c $E84D

t $E871 Messaging: Welcome
@ $E871 label=Messaging_Welcome
  $E871,$20 "#STR(#PC,$04,$20)".

c $E891 Display Start Screen
@ $E891 label=DisplayStartScreen
D $E891 Used by the routine at #R$E80E.
.       #UDGTABLE(default,centre) { #PUSHS #SIM(start=$E821,stop=$E8DD) #SCR$02(start-screen) #POPS } UDGTABLE#
N $E891 Colour the top two rows of the attribute buffer with magenta paper and white ink.
  $E891,$03 #REGhl=#R$5800(#N$5800) (attribute buffer location).
  $E894,$02 #REGb=#N$40 (counter - two rows).
@ $E896 label=HeaderAttributes_Loop
  $E896,$02 Write #N$1F (#COLOUR$1F) to *#REGhl.
  $E898,$01 Move to the next column.
  $E899,$02 Decrease counter by one and loop back to #R$E896 until counter is zero.
N $E89B Colour the rest of the rows down to the footer with black paper and yellow ink.
  $E89B,$03 #REGde=#REGhl+#N$01.
  $E89E,$03 #REGbc=#N$01BF.
  $E8A1,$02 Write #N$06 (#COLOUR$06) to *#REGhl.
  $E8A3,$02 Copy #N$06 from #N$5840 to #N$5A00 #N$01BF times.
N $E8A5 Print the "#STR($E871,$04,$20)" messaging.
  $E8A5,$01 Switch to the shadow registers.
  $E8A6,$03 #REGde'=#R$4000(#N$4000) (screen buffer location).
  $E8A9,$01 Switch back to the normal registers.
  $E8AA,$03 #REGhl=#R$E871.
  $E8AD,$02 #REGb=#N$20 (length of #R$E871 messaging).
  $E8AF,$03 Call #R$74D3.
N $E8B2 This section of the routine handles the cute row of bike graphics in the top of the display.
  $E8B2,$02 #REGb=#N$10 (number of bike UDGs to display).
@ $E8B4 label=HeaderBike_Loop
  $E8B4,$01 Switch to the shadow registers.
  $E8B5,$02 #REGl'=#R$789C(#N$9C).
N $E8B7 Print the left side of the bike graphic.
  $E8B7,$03 Call #R$74AA.
  $E8BA,$01 Switch back to the normal registers.
N $E8BB Print the right side of the bike graphic.
  $E8BB,$03 Call #R$74AA.
  $E8BE,$02 Decrease counter by one and loop back to #R$E8B4 until counter is zero.
N $E8C0 The start screen messaging at #R$A800 is split into #N$04 blocks of text #N$40 characters long.
  $E8C0,$02 #REGc=#N$04 (blocks of text).
  $E8C2,$01 Switch to the shadow registers.
  $E8C3,$03 #REGde'=#N$4060 (screen buffer location).
  $E8C6,$01 Switch back to the normal registers.
  $E8C7,$03 #REGhl=#R$A800.
@ $E8CA label=StartScreen_TextLoop
  $E8CA,$02 #REGb=#N$40 (length of messaging).
  $E8CC,$03 Call #R$74D3.
  $E8CF,$01 Switch to the shadow registers.
  $E8D0,$04 Jump to #R$E8D6 if #REGe is not zero.
  $E8D4,$02 #REGd=#N$48.
@ $E8D6 label=StartScreen_SkipRow
  $E8D6,$02 Add #N$20 to leave a blank row between the blocks of text.
  $E8D8,$01 #REGe=#REGa.
  $E8D9,$01 Switch back to the normal registers.
  $E8DA,$01 Decrease #REGc by one.
  $E8DB,$02 Jump to #R$E8CA until #REGc is zero.
  $E8DD,$03 Jump to #R$EBE6.

b $E8E0

c $E8E4 Display Pink Footer
@ $E8E4 label=DisplayPinkFooter
N $E8E4 This routine moves the data at #R$A900 to the screen buffer (to draw the start page footer).
  $E8E4,$03 #REGde=#N$5000 (screen buffer location).
  $E8E7,$03 #REGhl=#R$A900.
  $E8EA,$03 #REGbc=#N($0800,$04,$04) (counter).
  $E8ED,$02 Copy the footer graphic data to the screen buffer, decrease the counter, repeat until zero.
  $E8EF,$02 #REGde=#N$5A00 (attribute buffer location).
  $E8F1,$02 #REGb=#N$01 (counter).
  $E8F3,$02 Copy the footer attribute data to the attribute buffer, decrease the counter, repeat until zero.
  $E8F5,$01 Return.

c $E8F6 Get Kempston Joystick Input
@ $E8F6 label=KempstonJoystickInput
  $E8F6,$02 Read Kempston Joystick input.
  $E8F8,$01 Return.

b $E8F9

t $E900 Messaging: Control Selection
@ $E900 label=Messaging_ControlSelection
  $E900,$100,$20 Wheelie control selection page.
@ $EA00 label=Messaging_ChangeControls
  $EA00,$20 Change controls for (#R$EA60, #R$EA80, #R$EAA0, #R$EAC0, #R$EAE0).
@ $EA20 label=Messaging_Warning
  $EA20,$40,$20 Warning message.
@ $EA60 label=Messaging_Left
  $EA60,$20 "#STR(#PC,$04,$20)".
@ $EA80 label=Messaging_Right
  $EA80,$20 "#STR(#PC,$04,$20)".
@ $EAA0 label=Messaging_Up
  $EAA0,$20 "#STR(#PC,$04,$20)".
@ $EAC0 label=Messaging_Down
  $EAC0,$20 "#STR(#PC,$04,$20)".
@ $EAE0 label=Messaging_Freeze
  $EAE0,$20 "#STR(#PC,$04,$20)".

b $EB00 User-Defined Keys Input
@ $EB00 label=UserDefinedKeysInput

c $EB43 Display Change Controls
@ $EB43 label=DisplayChangeControls
D $EB43 Used by the routine at #R$E80E.
.       #UDGTABLE(default,centre) { #PUSHS #SIM(start=$E821,stop=$E8C0)#SIM(start=$EB43,stop=$E8DD) #SCR$02(change-controls) #POPS } UDGTABLE#
  $EB43,$03 #REGhl=#R$E900.
  $EB46,$02 #REGc=#N$04 (four "blocks" of text).
  $EB48,$01 Switch to the shadow registers.
  $EB49,$03 #REGde'=#N$4060 (screen buffer location).
  $EB4C,$01 Switch to the shadow registers.
N $EB4D Re-use the same printing routine as the start screen.
  $EB4D,$03 Call #R$E8CA.
  $EB50,$06 #HTML(Write #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>
.           and #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
N $EB56 Add a little pause to debounce the keypress from the previous page.
  $EB56,$03 #REGhl=#N($0000,$04,$04).
@ $EB59 label=ChangeControls_DebounceLoop
  $EB59,$01 Decrease #REGhl by one.
  $EB5A,$04 Jump to #R$EB59 until #REGhl is zero.
N $EB5E Get input from the keyboard.
@ $EB5E label=ChangeControls_InputLoop
  $EB5E,$03 Call #R$6828.
  $EB61,$03 Jump to #R$EB5E until any key is pressed.
N $EB64 Test if "keyboard/ standard" control has been selected.
  $EB64,$03 #REGhl=#R$6828.
  $EB67,$04 Jump to #R$EB6F if a key from the top row has not been pressed.
N $EB6B Write the selected control method to *#R$7850.
@ $EB6B label=SetControlMethod
  $EB6B,$03 Write #REGhl to *#R$7850.
  $EB6E,$01 Return.
N $EB6F Test if "kempston joystick" control has been selected.
@ $EB6F label=ChangeControls_TestIfKempston
  $EB6F,$03 #REGhl=#R$E8F6.
  $EB72,$04 Jump to #R$EB6B if a key from the second row has been pressed.
N $EB76 Handle both AGF interface and "other" (user defined keys) selections.
  $EB76,$03 #REGhl=#R$EB00.
  $EB79,$03 Write #REGhl to *#R$7850.
  $EB7C,$05 Jump to #R$EC1E if a key from the third row has been pressed.
  $EB81,$01 No operation.
  $EB82,$01 No operation.
N $EB83 Ask the user to set user-defined keys.
N $EB83 #UDGTABLE(default,centre) { #PUSHS #SIM(start=$749C,stop=$74A8)#SIM(start=$EB86,stop=$EBB3) #SCR$02(user-defined-left) #POPS } UDGTABLE#
  $EB83,$03 Call #R$EBE3.
N $EB86 Set the attributes.
  $EB86,$03 #REGhl=#N$5900 (attribute buffer location).
  $EB89,$02 #REGb=#N$40 (counter; two rows of text).
@ $EB8B label=UserDefinedControls_ColourLoop
  $EB8B,$02 Write #N$85 (#COLOUR$85) to *#REGhl.
  $EB8D,$01 Increment #REGl by one.
  $EB8E,$02 Decrease counter by one and loop back to #R$EB8B until counter is zero.
N $EB90 Set the screen buffer position.
  $EB90,$01 Switch to the shadow registers.
  $EB91,$02 #REGd'=#N$48.
  $EB93,$01 Switch back to the normal registers.
N $EB94 Loop through each control and allow the user to set it.
  $EB94,$02 #REGb=#N$05 (counter; five controls to select).
  $EB96,$03 #REGhl=#R$EA60.
  $EB99,$03 #REGde=#R$7853.
@ $EB9C label=UserDefinedControls_Loop
  $EB9C,$01 Stash the control counter on the stack.
N $EB9D Reset the screen buffer position.
  $EB9D,$01 Switch to the shadow registers.
  $EB9E,$02 #REGe'=#N$20.
  $EBA0,$01 Switch back to the normal registers.
N $EBA1 Print the control select message to the screen.
  $EBA1,$02 #REGb=#N$20 (counter; number of characters to print for this control).
  $EBA3,$03 Call #R$74D3.
  $EBA6,$01 Stash control messaging pointer on the stack.
N $EBA7 Reset the screen buffer position.
  $EBA7,$01 Switch to the shadow registers.
  $EBA8,$02 #REGe'=#N$00.
  $EBAA,$01 Switch to the normal registers.
  $EBAB,$03 #REGhl=#R$EA00.
  $EBAE,$02 #REGb=#N$20 (counter; length of "change controls" string).
  $EBB0,$03 Call #R$74D3.
  $EBB3,$04 Write #N$07 to *#REGiy+#N$07.
  $EBB7,$04 Set bit 3 of *#REGix+#N$30.
  $EBBB,$03 #HTML(#REGhl=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>.)
  $EBBE,$02 Reset bit 5 of *#REGhl.
@ $EBC0 label=UserDefinedControls_InputLoop
  $EBC0,$01 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/0038.html">MASK_INT</a>)
  $EBC1,$04 Jump to #R$EBC0 until any key is pressed.
N $EBC5 Fetch the user keypress.
  $EBC5,$03 #HTML(#REGa=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
  $EBC8,$01 Write the keypress to the current position in *#R$7853.
  $EBC9,$01 Move onto the next control key.
N $EBCA Warn the user that we debounce using pauses rather than wait for the key to be released.
N $EBCA #UDGTABLE(default,centre) { #PUSHS #SIM(start=$749C,stop=$74A8)#SIM(start=$EB86,stop=$EBB3)#SIM(start=$EBCA,stop=$EBD6) #SCR$02(user-defined-warning) #POPS } UDGTABLE#
  $EBCA,$03 #REGhl=#R$EA20.
  $EBCD,$02 #REGb=#N$40 (counter; number of characters in the warning messaging).
N $EBCF Set the screen buffer position.
  $EBCF,$01 Switch to the shadow registers.
  $EBD0,$02 #REGe'=#N$00.
  $EBD2,$01 Switch back to the normal registers.
  $EBD3,$03 Call #R$74D3.
  $EBD6,$01 No operation.
  $EBD7,$01 No operation.
  $EBD8,$01 No operation.
  $EBD9,$03 Call #R$EBE6.
  $EBDC,$01 No operation.
  $EBDD,$01 No operation.
  $EBDE,$02 Restore control messaging pointer and control counter from the stack.
  $EBE0,$02 Decrease control counter by one and loop back to #R$EB9C until counter is zero.
  $EBE2,$01 Return.

c $EBE3 Clear Screen And Pause
@ $EBE3 label=ClearScreen_Pause
E $EBE3 Continue on to #R$EBE6.
  $EBE3,$03 Call #R$749C.

c $EBE6 Long Pause
@ $EBE6 label=PauseLong
N $EBE6 Countdown from #N$FFFF to #N($0000,$04,$04) a total of #N$05 times. This is creating a big pause of ~3 seconds before allowing input.
  $EBE6,$02 #REGb=#N$05 (counter).
  $EBE8,$03 #REGhl=#N($0000,$04,$04).
@ $EBEB label=PauseLong_Loop
  $EBEB,$01 Decrease #REGhl by one.
  $EBEC,$04 Jump to #R$EBEB until #REGhl is zero.
  $EBF0,$02 Decrease counter by one and loop back to #R$EBEB until counter is zero.
  $EBF2,$01 Return.

c $EBF3
  $EBF3,$03 #REGa=*#R$785A.
  $EBF6,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $EBF9,$03 Jump to #R$EBF9 if #REGa is not equal to *#REGhl.
  $EBFC,$03 Jump to #R$6C00.

u $EBFF

c $EC00
  $EC00,$01 Switch to the shadow registers.
  $EC01,$01 #REGc=#REGa.
  $EC02,$03 #REGa=*#R$785A.
  $EC05,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $EC08,$01 Compare #REGa with *#REGhl.
  $EC09,$01 #REGa=#REGc.
  $EC0A,$01 Switch back to the normal registers.
  $EC0B,$01 Return if #REGa was not equal to *#REGhl on line #R$EC08.
  $EC0C,$03 Jump to #R$6C00.

c $EC0F
  $EC0F,$03 #REGhl=#R$FA40.
  $EC12,$03 #REGde=#N($0008,$04,$04).
  $EC15,$02 #REGb=#N$50.
  $EC17,$02 Set bit 7 of *#REGhl.
  $EC19,$01 #REGhl+=#REGde.
  $EC1A,$02 Decrease counter by one and loop back to #R$EC17 until counter is zero.
  $EC1C,$01 Return.

u $EC1D

c $EC1E Set AGF Interface Controller
@ $EC1E label=SetAGFController
  $EC1E,$03 #REGhl=#R$785B.
  $EC21,$03 #REGde=#R$7853.
  $EC24,$03 #REGbc=#N($0005,$04,$04).
  $EC27,$02 Copy #N$05 bytes of controls data from #R$785B to #R$7853.
  $EC29,$01 Return.

c $EC2A
  $EC2A,$05 Write #N$01 to *#R$7839.
  $EC2F,$03 #REGhl=#R$7840.
  $EC32,$03 Jump to #R$775F.
  $EC35,$01 Disable interrupts.
  $EC36,$01 Flip the bits according to #REGa.
  $EC37,$01 #REGc=*#REGhl.
  $EC38,$01 Increment #REGc by one.
  $EC39,$02 Jump to #R$EC3D if {} is not zero.
  $EC3B,$01 Enable interrupts.
  $EC3C,$01 Return.
  $EC3D,$01 Decrease #REGc by one.
  $EC3E,$01 Increment #REGhl by one.
  $EC3F,$01 #REGe=*#REGhl.
  $EC40,$01 Increment #REGhl by one.
  $EC41,$01 #REGd=*#REGhl.
  $EC42,$01 Increment #REGhl by one.
  $EC43,$02 OUT #N$41FE
  $EC45,$01 #REGb=#REGc.
  $EC46,$02,b$01 Flip bits 4.
  $EC48,$02 Decrease counter by one and loop back to #R$EC48 until counter is zero.
  $EC4A,$01 #REGb=#REGa.
  $EC4B,$01 Decrease #REGde by one.
  $EC4C,$01 #REGa=#REGd.
  $EC4D,$01 Set the bits from #REGe.
  $EC4E,$01 #REGa=#REGb.
  $EC4F,$02 Jump to #R$EC43 if {} is not zero.
  $EC51,$02 #REGd=#N$0F.
  $EC53,$01 Decrease #REGde by one.
  $EC54,$01 #REGa=#REGd.
  $EC55,$01 Set the bits from #REGe.
  $EC56,$02 Jump to #R$EC53 if {} is not zero.
  $EC58,$01 #REGa=#REGb.
  $EC59,$01 Increment #REGa by one.
  $EC5A,$02,b$01 Keep only bits 0-2, 4.
  $EC5C,$02 Jump to #R$EC37.
  $EC5E,$03 #REGhl=#R$EEE8.
  $EC61,$02 Jump to #R$EC35.
  $EC63,$03 #REGhl=#R$EF4F.
  $EC66,$02 Jump to #R$EC35.
  $EC68,$03 #REGhl=#R$EFC2.
  $EC6B,$02 Jump to #R$EC35.
  $EC6D,$01 No operation.
  $EC6E,$04 Write #N$07 to *#REGiy+#N$07.
  $EC72,$04 Set bit 3 of *#REGix+#N$30.
  $EC76,$03 #HTML(#REGhl=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>.)
  $EC79,$02 Reset bit 5 of *#REGhl.
  $EC7B,$02 Test bit 5 of *#REGhl.
  $EC7D,$02 Jump to #R$EC7B if {} is zero.
  $EC7F,$03 #HTML(#REGa=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
  $EC82,$02 Compare #REGa with #N$80.
  $EC84,$02 Jump to #N$EC6F if {} is higher. TODO
  $EC86,$02 Compare #REGa with #N$60.
  $EC88,$01 Return if {} is lower.
  $EC89,$02 Reset bit 5 of #REGa.
  $EC8B,$01 Return.

c $EC8E Print Instructions
@ $EC8E label=PrintInstructions
R $EC8E HL Instructions page pointer
  $EC8E,$01 Switch to the shadow registers.
  $EC8F,$03 #REGde'=#N$4060 (screen buffer location).
  $EC92,$01 Switch back to the normal registers.
  $EC93,$02 #REGb=#N$A0.
  $EC95,$03 Call #R$74D3.
  $EC98,$01 Switch to the shadow registers.
  $EC99,$03 #REGde'=#N$4800 (screen buffer location).
  $EC9C,$01 Switch back to the normal registers.
  $EC9D,$03 Call #R$74D3.
  $ECA0,$01 Switch to the shadow registers.
  $ECA1,$03 #REGde'=#N$5000 (screen buffer location).
  $ECA4,$01 Switch back to the normal registers.
  $ECA5,$02 #REGb=#N$E0.
  $ECA7,$03 Call #R$74D3.
  $ECAA,$01 Return.

c $ECAB Start Game
@ $ECAB label=StartGame
  $ECAB,$06 #HTML(Write #N$0A23 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>/<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
  $ECB1,$03 Call #R$749C.
  $ECB4,$03 #REGhl=#N$5900 (attribute buffer location).
  $ECB7,$02 #REGb=#N$40.
  $ECB9,$02 Write #N$04 to *#REGhl.
  $ECBB,$01 Increment #REGl by one.
  $ECBC,$02 Decrease counter by one and loop back to #R$ECB9 until counter is zero.
  $ECBE,$01 Switch to the shadow registers.
  $ECBF,$03 #REGde=#N$4800 (screen buffer location).
  $ECC2,$01 Switch to the shadow registers.
  $ECC3,$02 #REGb=#N$40.
  $ECC5,$03 #REGhl=#R$EE14.
  $ECC8,$03 Call #R$74D3.
  $ECCB,$03 Call #R$EC6E.
  $ECCE,$02 Compare #REGa with #N$0D.
  $ECD0,$02 Jump to #R$ECDB if {} is not zero.
  $ECD2,$06 #HTML(Write #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>
.           and #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
  $ECD8,$03 Jump to #R$6CAA.
  $ECDB,$03 #REGde=#R$782E.
  $ECDE,$01 Write #REGa to *#REGde.
  $ECDF,$01 Switch to the shadow registers.
  $ECE0,$02 #REGe=#N$20.
  $ECE2,$01 Switch to the shadow registers.
  $ECE3,$03 #REGhl=#R$E9A0.
  $ECE6,$02 #REGb=#N$20.
  $ECE8,$03 Call #R$74D3.
  $ECEB,$02 #REGb=#N$04.
  $ECED,$03 #REGhl=#R$EEB4.
  $ECF0,$01 Switch to the shadow registers.
  $ECF1,$02 #REGe=#N$09.
  $ECF3,$01 Switch to the shadow registers.
  $ECF4,$01 Stash #REGbc on the stack.
  $ECF5,$02 #REGb=#N$03.
  $ECF7,$03 Call #R$74D3.
  $ECFA,$01 Restore #REGbc from the stack.
  $ECFB,$01 Stash #REGhl on the stack.
  $ECFC,$03 Call #R$EC6E.
  $ECFF,$01 Restore #REGhl from the stack.
  $ED00,$01 Increment #REGe by one.
  $ED01,$01 Write #REGa to *#REGde.
  $ED02,$02 Decrease counter by one and loop back to #R$ECF0 until counter is zero.
  $ED04,$02 #REGc=#N$07.
  $ED06,$03 #REGhl=#R$EEC0.
  $ED09,$02 #REGe=#N$2E.
  $ED0B,$02 #REGb=#N$05.
  $ED0D,$01 #REGa=*#REGde.
  $ED0E,$01 Increment #REGe by one.
  $ED0F,$01 Compare #REGa with *#REGhl.
  $ED10,$02 Jump to #R$ED1D if {} is not zero.
  $ED12,$01 Increment #REGhl by one.
  $ED13,$02 Decrease counter by one and loop back to #R$ED0D until counter is zero.
  $ED15,$02 #REGa=#N$07.
  $ED17,$01 #REGa-=#REGc.
  $ED18,$03 Write #REGa to *#R$7820.
  $ED1B,$02 Jump to #R$ECD2.
  $ED1D,$01 Increment #REGhl by one.
  $ED1E,$02 Decrease counter by one and loop back to #R$ED1D until counter is zero.
  $ED20,$01 Decrease #REGc by one.
  $ED21,$02 Jump to #R$ED09 if {} is not zero.
  $ED23,$01 Switch to the shadow registers.
  $ED24,$02 #REGe=#N$00.
  $ED26,$01 Switch to the shadow registers.
  $ED27,$03 #REGhl=#R$EE54.
  $ED2A,$02 #REGb=#N$20.
  $ED2C,$03 Call #R$74D3.
  $ED2F,$03 Call #R$EBE6.
  $ED32,$03 Jump to #R$ECAB.

b $ED35

c $ED39

c $ED52 Display Playing Instructions
@ $ED52 label=DisplayInstructions
  $ED52,$01 Switch to the shadow registers.
  $ED53,$03 #REGde'=#R$4000(#N$4000) (screen buffer location).
  $ED56,$01 Switch back to the normal registers.
N $ED57 Prints the "#STR($EE74,$03,$20)" banner.
  $ED57,$03 #REGhl=#R$EE74.
  $ED5A,$02 #REGb=#N$20 (length of banner).
  $ED5C,$03 Call #R$74D3.
N $ED5F Prints the "#STR($EE94,$03,$20)" footer messaging.
  $ED5F,$02 #REGa=#N$9F (#COLOUR$9F).
  $ED61,$03 #REGhl=#R$EE94.
  $ED64,$03 Call #R$74C3.
N $ED67 Display the instructions for page one.
N $ED67 #UDGTABLE(default,centre)
. { #PUSHS #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8C) #SCR$02(instruction-01) #POPS }
. UDGTABLE#
N $ED67 Set the attributes.
  $ED67,$03 #REGhl=#N$5840 (attribute buffer location).
  $ED6A,$02 #REGb=#N$A0 (counter).
@ $ED6C label=Instructions_Page1_CyanLoop
  $ED6C,$02 Write #N$28 (#COLOUR$28) to *#REGhl.
  $ED6E,$01 Increment #REGhl by one.
  $ED6F,$02 Decrease counter by one and loop back to #R$ED6C until counter is zero.
  $ED71,$02 #REGb=#N$C0 (counter).
@ $ED73 label=Instructions_Page1_YellowLoop
  $ED73,$02 Write #N$30 (#COLOUR$30) to *#REGhl.
  $ED75,$01 Increment #REGhl by one.
  $ED76,$02 Decrease counter by one and loop back to #R$ED73 until counter is zero.
  $ED78,$02 #REGb=#N$E0 (counter).
@ $ED7A label=Instructions_Page1_GreenLoop
  $ED7A,$02 Write #N$20 (#COLOUR$20) to *#REGhl.
  $ED7C,$01 Increment #REGhl by one.
  $ED7D,$02 Decrease counter by one and loop back to #R$ED7A until counter is zero.
  $ED7F,$02 #REGb=#N$60 (counter).
@ $ED81 label=Instructions_Page1_Cyan2Loop
  $ED81,$02 Write #N$28 (#COLOUR$28) to *#REGhl.
  $ED83,$01 Increment #REGhl by one.
  $ED84,$02 Decrease counter by one and loop back to #R$ED81 until counter is zero.
N $ED86 Now display the text for page one on the screen.
  $ED86,$03 #REGhl=#R$F000.
  $ED89,$03 Call #R$EC8E.
  $ED8C,$01 Store the current position in the instructions for the next page later.
  $ED8D,$03 Debounce using #R$EBE6.
@ $ED90 label=Instructions_InputLoop_Page1
  $ED90,$03 Call #R$6828.
  $ED93,$03 Jump to #R$ED90 until any key is pressed.
N $ED96 Display the instructions for page two.
N $ED96 #UDGTABLE(default,centre)
. { #PUSHS #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA7) #SCR$02(instruction-02) #POPS }
. UDGTABLE#
N $ED96 Set the attributes.
  $ED96,$03 #REGhl=#N$5840 (attribute buffer location).
  $ED99,$02 Write #N$0F (#COLOUR$0F) to *#REGhl.
  $ED9B,$03 #REGde=#N$5841 (attribute buffer location).
  $ED9E,$03 #REGbc=#N$029F.
  $EDA1,$02 Copy #COLOUR$0F to the screen buffer #N$029F times.
N $EDA3 Now display the text for page two on the screen.
  $EDA3,$01 Restore the position of the instructions pointer from the stack.
  $EDA4,$03 Call #R$EC8E.
  $EDA7,$01 Store the current position in the instructions for the next page later.
  $EDA8,$03 Debounce using #R$EBE6.
@ $EDAB label=Instructions_InputLoop_Page2
  $EDAB,$03 Call #R$6828.
  $EDAE,$03 Jump to #R$EDAB until any key is pressed.
N $EDB1 Display the instructions for page three.
N $EDB1 #UDGTABLE(default,centre)
. { #PUSHS #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA8)#SIM(start=$EDB1,stop=$EDE4) #SCR$02(instruction-03) #POPS }
. UDGTABLE#
N $EDB1 Set the attributes.
  $EDB1,$03 #REGhl=#N$5960 (attribute buffer location).
  $EDB4,$02 #REGb=#N$80 (counter).
@ $EDB6 label=Instructions_Page3_CyanLoop
  $EDB6,$02 Write #N$28 (#COLOUR$28) to *#REGhl.
  $EDB8,$01 Increment #REGhl by one.
  $EDB9,$02 Decrease counter by one and loop back to #R$EDB6 until counter is zero.
  $EDBB,$02 #REGb=#N$A0 (counter).
@ $EDBD label=Instructions_Page3_GreenLoop
  $EDBD,$02 Write #N$20 (#COLOUR$20) to *#REGhl.
  $EDBF,$01 Increment #REGhl by one.
  $EDC0,$02 Decrease counter by one and loop back to #R$EDBD until counter is zero.
  $EDC2,$02 #REGb=#N$60 (counter).
@ $EDC4 label=Instructions_Page3_YellowLoop
  $EDC4,$02 Write #N$30 (#COLOUR$30) to *#REGhl.
  $EDC6,$01 Increment #REGhl by one.
  $EDC7,$02 Decrease counter by one and loop back to #R$EDC4 until counter is zero.
N $EDC9 Colour the "keys" guide.
  $EDC9,$03 #REGhl=#N$5860 (attribute buffer location).
  $EDCC,$03 #REGde=#N($0037,$04,$04).
  $EDCF,$02 #REGc=#N$04 (counter; rows of "keys").
@ $EDD1 label=HighlightKeys_RowLoop
  $EDD1,$02 #REGb=#N$09 (counter; nine columns to colour).
@ $EDD3 label=HighlightKeys_LineLoop
  $EDD3,$02 Write #N$1B (#COLOUR$1B) to *#REGhl.
  $EDD5,$01 Increment #REGhl by one.
  $EDD6,$02 Decrease counter by one and loop back to #R$EDD3 until counter is zero.
  $EDD8,$01 Add #REGde to #REGhl to move us down one whole row (#N$20) and back to the beginning of where we need to
.           colour in (#N$20-#N$09=#N$17 ~ #N$20+#N$17=#N$37).
  $EDD9,$01 Decrease #REGc by one.
  $EDDA,$02 Jump to #R$EDD1 until #REGc is zero.
N $EDDC Fill in the gap on the bottom row.
  $EDDC,$02 Move the screen buffer pointer.
  $EDDE,$02 Write #N$09 (#COLOUR$09) to *#REGhl.
N $EDE0 Now display the text for page three on the screen.
  $EDE0,$01 Restore the position of the instructions pointer from the stack.
  $EDE1,$03 Call #R$EC8E.
  $EDE4,$01 Store the current position in the instructions for the next page later.
  $EDE5,$03 Debounce using #R$EBE6.
@ $EDE8 label=Instructions_InputLoop_Page3
  $EDE8,$03 Call #R$6828.
  $EDEB,$03 Jump to #R$EDE8 until any key is pressed.
N $EDEE Display the instructions for page four.
N $EDEE #UDGTABLE(default,centre)
. { #PUSHS #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA8)#SIM(start=$EDB1,stop=$EDE5)#SIM(start=$EDEE,stop=$EDFF) #SCR$02(instruction-04) #POPS }
. UDGTABLE#
N $EDEE Set the attributes.
  $EDEE,$03 #REGhl=#N$5840 (attribute buffer location).
  $EDF1,$02 Write #N$30 (#COLOUR$30) to *#REGhl.
  $EDF3,$03 #REGde=#N$5841 (attribute buffer location).
  $EDF6,$03 #REGbc=#N$029F.
  $EDF9,$02 Copy #COLOUR$30 to the screen buffer #N$029F times.
N $EDFB Now display the text for page four on the screen.
  $EDFB,$01 Restore the position of the instructions pointer from the stack.
  $EDFC,$03 Call #R$EC8E.
  $EDFF,$03 Debounce using #R$EBE6.
@ $EE02 label=Instructions_InputLoop_Page4
  $EE02,$03 Call #R$6828.
  $EE05,$03 Jump to #R$EE02 until any key is pressed.
  $EE08,$01 Return.

b $EE09

t $EE94 Messaging: Press Any Key
@ $EE94 label=Messaging_PressAnyKey
  $EE94,$20 "#STR(#PC,$04,$20)".

t $EE14 Messaging: Code Entry
@ $EE14 label=Messaging_CodeEntry
  $EE14,$40,$20
  $EE54,$20

t $EE74 Messaging: How to play Wheelie
@ $EE74 label=Messaging_HowToPlay
  $EE74,$20 "#STR(#PC,$04,$20)".

t $EEB4 Messaging: Code Letter Position
@ $EEB4 label=Messaging_CodeLetterPosition
  $EEB4,$0C,$03

t $EEC0 Messaging: Passwords
@ $EEC0 label=Messaging_Passwords
  $EEC0,$23,$05

b $EEE3

b $EEE8

b $EF4F

b $EFC2

t $F000 Messaging: Instructions (Page 1)
@ $F000 label=Messaging_InstructionsPage1
  $F000,$0280,$20 Page 1.

t $F280 Messaging: Instructions (Page 2)
@ $F280 label=Messaging_InstructionsPage2
  $F280,$0280,$20 Page 2.

t $F500 Messaging: Instructions (Page 3)
@ $F500 label=Messaging_InstructionsPage3
  $F500,$0280,$20 Page 3.

t $F780 Messaging: Instructions (Page 4)
@ $F780 label=Messaging_InstructionsPage4
  $F780,$0280,$20 Page 4.

b $FA00
