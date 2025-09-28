; Copyright Microsphere 1983, 2024 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @rom
> $4000 @start
b $4000 Loading Screen
D $4000 #UDGTABLE { =h Wheelie Loading Screen. } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels.
  $5800,$0300,$20 Attributes.

b $5B00

c $5D11 Game Entry Point
@ $5D11 label=GameEntryPoint
  $5D11,$04 #REGsp=#N$FFFF.
  $5D15,$03 #HTML(#REGhl=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C53.html">PROG</a>.)
  $5D18,$03 #REGbc=#N$9B94.
  $5D1B,$03 #REGde=#N$FE00.
  $5D1E,$01 #REGhl+=#REGbc.
  $5D1F,$03 #REGbc=#N$9A01.
  $5D22,$02 Move the code into place.
  $5D24,$03 Jump to #R$6D1E.

b $5D27

c $6400 Get Random Number
@ $6400 label=GetRandomNumber
R $6400 O:A Random number
N $6400 Random numbers are just data pulled from addresses between #N$7900-#N$7AFF (sequentially).
  $6400,$01 Stash #REGhl on the stack.
  $6401,$03 #REGhl=*#R$781E.
  $6404,$01 #REGa=*#REGhl.
  $6405,$01 Increment #REGl by one.
  $6406,$02 Jump to #R$640F if #REGl is not zero.
  $6408,$01 Increment #REGh by one.
  $6409,$04 Jump to #R$640F if bit 2 of #REGh is not set.
N $640D Bit 2 is set, this means that #REGh has reached #N$7C so pull the range back down to #N$79.
  $640D,$02 #REGh=#N$79.
@ $640F label=UpdateRandomNumberSeed
  $640F,$03 Write #REGhl to *#R$781E.
  $6412,$01 Restore #REGhl from the stack.
  $6413,$01 Return.

c $6414 Set Random Number Seed?
@ $6414 label=SetRandomNumberSeed
  $6414,$03 #HTML(#REGhl=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $6417,$01 #REGa=#REGh.
  $6418,$02,b$01 Keep only bits 0-1.
  $641A,$02 Jump to #R$641D if the result is not zero.
  $641C,$01 Increment #REGa by one.
@ $641D label=SkipNonZero
  $641D,$02 #REGa+=#N$78.
  $641F,$01 #REGh=#REGa.
M $6417,$09 #REGh=random number between #N$79-#N$7B.
  $6420,$03 Write #REGhl to *#R$781E.
  $6423,$01 Return.

c $6424 Copy Level Data to Level Buffer
@ $6424 label=CopyLevelDataToBuffer
R $6424 HL Source data pointer
R $6424 DE Destination buffer pointer
  $6424,$02 Set a counter in #REGc for #N$05 rows to copy.
@ $6426 label=CopyLevelDataToBuffer_CopyRow
  $6426,$02 Set a counter in #REGb for #N$20 bytes per row.
@ $6428 label=CopyLevelDataToBuffer_CopyByte
  $6428,$01 Fetch a terrain byte from the source data.
  $6429,$01 Move to the next source data byte.
  $642A,$01 Write the byte to the destination buffer.
  $642B,$01 Move to the next destination buffer position.
  $642C,$02 Decrease the bytes-per-row counter by one and loop back to #R$6428
. until the whole row has been copied.
N $642E Handle updating the destination pointer positioning after each row.
  $642E,$01 Step back one position.
  $642F,$01 Align to a #N$20 byte boundary.
M $6430,$02 Keep only the upper 3 bits of the #REGe co-ordinate.
  $6430,$02,b$01 Keep only bits 5-7.
  $6432,$01 Reset to the start of the current #N$20 byte block.
  $6433,$01 Move down one row.
  $6434,$01 Decrease the row counter by one.
  $6435,$02 Jump back to #R$6426 until all the rows have been copied.
N $6437 Adjust the destination pointer after copying a complete #N$05x#N$20
. block.
  $6437,$02 Move to the next block horizontally.
  $6439,$01 Load the new horizontal position into #REGe.
  $643A,$01 Return if #REGe wrapped around to #N$00 (we reached the end of the
. buffer).
N $643B Move the destination pointer back up #N$05 rows to the original
. vertical position.
  $643B,$04 #REGd-=#N$05.
  $643F,$01 Return.

c $6440 Initialise Game Objects
@ $6440 label=InitialiseGameObjects
  $6440,$02 Set the number of game objects to process (#N$0A).
  $6442,$01 No operation.
  $6443,$01 Set a counter in #REGc of the number of game objects.
  $6444,$01 Increment #REGb by one.
  $6445,$01 Increment #REGc by one.
  $6446,$03 #REGhl=#R$9E00(#N$A01E).
  $6449,$01 Stash #REGhl on the stack.
  $644A,$03 #REGde=#R$B400.
  $644D,$01 Decrease *#REGhl by one.
  $644E,$02 Jump to #R$6458 if *#REGhl is zero.
  $6450,$02 #REGe=#N$24.
  $6452,$01 Increment #REGh by one.
  $6453,$01 Decrease *#REGhl by one.
  $6454,$02 Jump to #R$6458 if *#REGhl is zero.
  $6456,$02 #REGe=#N$48.
  $6458,$01 Restore #REGhl from the stack.
  $6459,$01 Stash #REGhl on the stack.
  $645A,$02 Increment #REGl by two.
  $645C,$02 Jump to #R$6462 if #REGl is not zero.
  $645E,$04 #REGh+=#N$05.
  $6462,$01 Increment #REGl by one.
  $6463,$01 #REGa=*#REGhl.
  $6464,$01 Decrease #REGa by one.
  $6465,$02 Jump to #R$6470 if #REGa is zero.
  $6467,$01 Increment #REGh by one.
  $6468,$01 #REGa=*#REGhl.
  $6469,$01 Decrease #REGa by one.
  $646A,$02 #REGa=#N$0C.
  $646C,$02 Jump to #R$6470 if #REGa was zero on line #R$6469.
  $646E,$04 #REGe+=#N$18.
  $6472,$01 Restore #REGhl from the stack.
  $6473,$01 Decrease #REGh by one.
  $6474,$02 #REGb=#N$04.
  $6476,$01 #REGa=*#REGde.
  $6477,$01 Write #REGa to *#REGhl.
  $6478,$01 Increment #REGh by one.
  $6479,$01 Increment #REGe by one.
  $647A,$02 Decrease counter by one and loop back to #R$6476 until counter is zero.
  $647C,$04 Decrease #REGh by four.
  $6480,$01 Increment #REGl by one.
  $6481,$02 #REGb=#N$04.
  $6483,$01 #REGa=*#REGde.
  $6484,$01 Write #REGa to *#REGhl.
  $6485,$01 Increment #REGh by one.
  $6486,$01 Increment #REGe by one.
  $6487,$02 Decrease counter by one and loop back to #R$6483 until counter is zero.
  $6489,$01 Increment #REGh by one.
  $648A,$01 Increment #REGl by one.
  $648B,$02 Jump to #R$6491 if #REGl is zero.
  $648D,$04 #REGh-=#N$05.
  $6491,$02 #REGb=#N$04.
  $6493,$01 #REGa=*#REGde.
  $6494,$01 Write #REGa to *#REGhl.
  $6495,$01 Increment #REGh by one.
  $6496,$01 Increment #REGe by one.
  $6497,$02 Decrease counter by one and loop back to #R$6493 until counter is zero.
  $6499,$03 Decrease #REGh by three.
  $649C,$04 #REGl+=#N$1E.
  $64A0,$01 Decrease #REGc by one.
  $64A1,$02 Jump to #R$6449 until #REGc is zero.
  $64A3,$01 Return.

u $64A4

c $64AA Level Object Placement And Special Terrain Generation
@ $64AA label=ObjectPlacement_SpecialTerrain
N $64AA Search the level buffer for special terrain markers (#N$32) and replace
. with objects/ terrain.
  $64AA,$03 Load #REGhl with #R$9E00.
  $64AD,$03 Set the length of the level buffer in #REGbc (#N$0A00 bytes).
@ $64B0 label=ObjectPlacement_SpecialTerrain_Loop
  $64B0,$04 Search for the next #N$32 marker in the level buffer.
  $64B4,$03 Return if no more markers were found.
N $64B7 A marker was found.
  $64B7,$02 Stash the level buffer position and buffer counter on the stack.
  $64B9,$01 Clear #REGa.
  $64BA,$02 No operation.
  $64BC,$02 Set a counter in #REGb for #N$04 bytes to process.
  $64BE,$01 #REGe=#REGa.
  $64BF,$01 Decrease #REGl by one.
N $64C0 Determine what to place based on a random number.
  $64C0,$03 Call #R$6400.
M $64C3,$02 #REGa=random number between #N$00 and #N$07.
  $64C3,$02,b$01 Keep only bits 0-2.
  $64C5,$03 Jump to #R$64F4 if #REGa is lower than #REGe.
N $64C8 Generate terrain/ object from the data table.
N $64C8 This part of the routine takes a random number between #N$00-#N$07 and
. uses it to fetch terrain data:
.
. #TABLE(default,centre,centre,centre)
. { =h Random Number | =h Calculation | =h Address }
. #FOR$00,$07,$01,$04(x,{ #Nx | #N((x*$06)+$6C) | #R(((x*$06)+$6C)+$B4*$100) })
. TABLE#
  $64C8,$03 Call #R$7088.
M $64CB,$02 Ensure the random number is between #N$00-#N$07.
  $64CB,$02,b$01 Keep only bits 0-2.
N $64CD Calculate the low-byte of the object data table address.
  $64CD,$07 #REGe=(#REGa*#N$06)+#N$6C.
  $64D4,$02 Set the high-byte in #REGd to #N$B4.
N $64D6 Copy a byte of the #N$04 bytes of object data into the level buffer.
@ $64D6 label=PlaceObjectData
  $64D6,$01 Fetch an object data byte.
  $64D7,$01 Write the object data byte into the level buffer.
  $64D8,$01 Move to the next object data byte.
  $64D9,$01 Move to the next position in the level buffer.
  $64DA,$02 Decrease the byte counter by one and loop back to #R$64D6 until all
. the object data bytes have been written into the level buffer.
N $64DC Check if the object has a vertical component.
  $64DC,$04 Jump to #R$64F9 if the current data byte is zero (no vertical
. component).
N $64E0 Place the vertical component of the object.
  $64E0,$03 Decrease #REGl by three.
  $64E3,$01 Increment #REGh by one.
  $64E4,$02 #REGb=#N$02.
@ $64E6 label=PlaceVerticalComponent
  $64E6,$01 #REGa=*#REGhl.
  $64E7,$01 Set flags.
  $64E8,$01 #REGa=*#REGde.
  $64E9,$02 Jump to #R$64ED if *#REGhl is zero.
  $64EB,$02 Increment #REGa by two.
@ $64ED label=PlaceVerticalByte
  $64ED,$01 Write #REGa to *#REGhl.
  $64EE,$01 Increment #REGl by one.
  $64EF,$01 Increment #REGe by one.
  $64F0,$02 Decrease counter by one and loop back to #R$64E6 until counter is zero.
  $64F2,$02 Jump to #R$64F9.
N $64F4 Place a simple terrain block (block type: #N$01).
@ $64F4 label=PlaceSimpleTerrain_Loop
  $64F4,$02 Write block type #N$01 to the level buffer pointer.
  $64F6,$01 Move to the next buffer position.
  $64F7,$02 Decrease the byte counter by one and loop back to #R$64F4 until all
. bytes have been written into the buffer.
N $64F9 Continue searching for the next terrain markers.
@ $64F9 label=ObjectPlacement_SpecialTerrain_Next
  $64F9,$02 Restore the buffer counter and level buffer position from the stack.
  $64FB,$02 Jump to #R$64B0.

u $64FD

c $6500 Initialise Level
@ $6500 label=InitialiseLevel
N $6500 #PUSHS #UDGTABLE {
. #SIM(start=$6CAA,stop=$6562)#SCR$02(level-1)
. } UDGTABLE# #POPS
  $6500,$03 #REGde=#R$9E00.
  $6503,$03 #REGhl=#R$8960.
  $6506,$03 Call #R$6424.
  $6509,$03 #REGhl=#N$A101.
  $650C,$02 #REGb=#N$0A.
  $650E,$02 Write #N$00 to *#REGhl.
  $6510,$01 Decrease #REGh by one.
  $6511,$02 Write #N$00 to *#REGhl.
  $6513,$01 Increment #REGh by one.
  $6514,$01 Increment #REGl by one.
  $6515,$02 Decrease counter by one and loop back to #R$650E until counter is zero.
  $6517,$02 Write #N$23 to *#REGhl.
  $6519,$01 Switch to the shadow registers.
  $651A,$02 #REGa=#N$0A.
  $651C,$01 No operation.
  $651D,$01 #REGb=#REGa.
  $651E,$01 Switch to the shadow registers.
  $651F,$03 Call #R$6400.
  $6522,$02,b$01 Keep only bits 0-4.
  $6524,$01 #REGb=#REGa.
  $6525,$01 #REGa+=#REGa.
  $6526,$01 #REGa+=#REGa.
  $6527,$01 #REGa+=#REGb.
  $6528,$03 RRCA.
  $652B,$01 #REGl=#REGa.
  $652C,$02,b$01 Keep only bits 0-4.
  $652E,$02 #REGa+=#N$8A.
  $6530,$01 #REGh=#REGa.
  $6531,$01 #REGa=#REGl.
  $6532,$02,b$01 Keep only bits 5-7.
  $6534,$01 #REGl=#REGa.
  $6535,$03 Call #R$6424.
  $6538,$01 Switch to the shadow registers.
  $6539,$02 Decrease counter by one and loop back to #R$651E until counter is zero.
  $653B,$01 Switch to the shadow registers.
  $653C,$03 #REGhl=#R$8960.
  $653F,$03 Call #R$6424.
  $6542,$01 #REGa=#REGe.
  $6543,$03 #REGhl=#N$02F4.
  $6546,$03 Jump to #R$654B if #REGa is not zero.
  $6549,$02 #REGh=#N$FE.
  $654B,$01 #REGhl+=#REGde.
  $654C,$02 Write #N$22 to *#REGhl.
  $654E,$02 #REGb=#N$0A.
  $6550,$01 Increment #REGl by one.
  $6551,$02 Write #N$00 to *#REGhl.
  $6553,$01 Decrease #REGh by one.
  $6554,$02 Write #N$00 to *#REGhl.
  $6556,$01 Increment #REGh by one.
  $6557,$02 Decrease counter by one and loop back to #R$6550 until counter is zero.
  $6559,$03 Call #R$6440.
  $655C,$03 Call #R$64AA.
  $655F,$03 Call #R$7200.
  $6562,$01 Return.

u $6563

c $6564 Prepare Scroll Data
@ $6564 label=PrepareScrollData
R $6564 A Scroll phase
  $6564,$03 #REGc=#REGa*#N$04.
  $6567,$01 Switch to the shadow registers.
  $6568,$03 Set a counter in #REGb of #N$05 (the #N$FF in #REGc isn't used).
  $656B,$03 #REGde=#R$7800.
@ $656E label=PrepareScrollData_Loop
  $656E,$01 Switch back to the normal registers.
  $656F,$01 Read the index byte.
  $6570,$01 Move to the next byte.
  $6571,$03 Rotate the index byte right three times to extract the address
. components.
  $6574,$01 Copy the result to #REGl.
  $6575,$02,b$01 Keep only bits 0-4.
  $6577,$03 Add #N$80 to form the high byte of the graphics address in #REGhl.
  $657A,$01 Restore the rotated value.
  $657B,$02,b$01 Keep only bits 5-7.
  $657D,$01 Add the scroll offset from #REGc.
  $657E,$01 Complete the graphics address in #REGhl.
  $657F,$01 Stash the graphics address on the stack.
  $6580,$01 Switch to the shadow registers.
  $6581,$01 Restore the graphics address from the stack.
  $6582,$08 Copy #N$04 bytes from the graphics line to the destination.
  $658A,$02 Decrease the row counter by one and loop back to #R$656E until all
. the rows have been copied.
  $658C,$01 #REGa=*#REGde.
  $658D,$01 Increment #REGa by one.
  $658E,$01 Write #REGa to *#REGde.
  $658F,$01 Increment #REGe by one.
  $6590,$01 #REGa=*#REGde.
  $6591,$01 Switch to the shadow registers.
  $6592,$01 #REGa+=#REGb.
  $6593,$01 Switch to the shadow registers.
  $6594,$01 Write #REGa to *#REGde.
  $6595,$02 #REGe=#N$02.
  $6597,$02 #REGb=#N$10.
  $6599,$01 Switch to the shadow registers.
  $659A,$01 Return.

u $659B

c $659C Scroll Playarea Left
@ $659C label=ScrollPlayarea_Left
D $659C #HTML(Scrolls the play area horizontally by shifting pixel data left
. using <code>RLD</code> instructions.)
  $659C,$03 #REGhl=*#R$7817.
  $659F,$02 Copy the screen position pointer into #REGde.
  $65A1,$03 #REGa=*#R$7819.
  $65A4,$01 Copy the scroll phase counter into #REGc.
  $65A5,$01 Increment the scroll phase counter by one.
M $65A6,$02 Ensure the counter is limited to being a number between
. #N$00-#N$07.
  $65A6,$02,b$01 Keep only bits 0-2.
  $65A8,$03 Write the scroll phase counter back to *#R$7819.
  $65AB,$02 Jump to #R$65B7 if #REGa is not zero.
  $65AD,$01 Increment #REGl by one.
  $65AE,$02 Jump to #R$65B4 if #REGl is not zero.
  $65B0,$04 #REGh+=#N$05.
@ $65B4 label=ScrollPlayarea_StorePointer
  $65B4,$03 Write #REGhl to *#R$7817.
N $65B7 Set up the column data pointer for new graphics data.
@ $65B7 label=ScrollPlayarea_UpdateColumnPointer
  $65B7,$04 #REGe+=#N$08.
  $65BB,$02 Jump to #R$65C1 if {} is higher.
  $65BD,$04 #REGd+=#N$05.
@ $65C1 label=ScrollPlayarea_SetupScroll
  $65C1,$01 Load the original scroll phase counter value into #REGa.
  $65C2,$02 Set a counter in #REGb for #N$01 column to process.
  $65C4,$03 Call #R$6564.
N $65C7 Start of screen buffer.
  $65C7,$03 #REGhl=#N$401F (screen buffer location).
  $65CA,$02 Copy the screen position pointer into #REGde.
  $65CC,$01 Switch to the shadow registers.
@ $65CD label=ScrollPlayarea_ProcessRows
  $65CD,$01 #REGa=*#REGde.
  $65CE,$01 Increment #REGe by one.
  $65CF,$01 #REGl=#REGa.
  $65D0,$02 #REGh=#N$1F.
  $65D2,$02 Multiply #REGhl by #N$04.
  $65D4,$01 Switch to the shadow registers.
N $65D5 #HTML(Scroll one character row (#N$20 characters) left by #N$01 pixel
. using <code>RLD</code>.)
  $65D5,$02 #REGb=#N$04.
@ $65D7 label=ScrollCharacterRow_Left
  $65D7,$01 Switch to the shadow registers.
  $65D8,$01 #REGa=*#REGhl.
  $65D9,$01 Increment #REGl by one.
  $65DA,$01 Switch to the shadow registers.
  $65DB,$02 RLD.
  $65DD,$01 Decrease #REGl by one.
  $65DE,$02 RLD.
  $65E0,$01 Decrease #REGl by one.
  $65E1,$02 RLD.
  $65E3,$01 Decrease #REGl by one.
  $65E4,$02 RLD.
  $65E6,$01 Decrease #REGl by one.
  $65E7,$02 RLD.
  $65E9,$01 Decrease #REGl by one.
  $65EA,$02 RLD.
  $65EC,$01 Decrease #REGl by one.
  $65ED,$02 RLD.
  $65EF,$01 Decrease #REGl by one.
  $65F0,$02 RLD.
  $65F2,$01 Decrease #REGl by one.
  $65F3,$02 RLD.
  $65F5,$01 Decrease #REGl by one.
  $65F6,$02 RLD.
  $65F8,$01 Decrease #REGl by one.
  $65F9,$02 RLD.
  $65FB,$01 Decrease #REGl by one.
  $65FC,$02 RLD.
  $65FE,$01 Decrease #REGl by one.
  $65FF,$02 RLD.
  $6601,$01 Decrease #REGl by one.
  $6602,$02 RLD.
  $6604,$01 Decrease #REGl by one.
  $6605,$02 RLD.
  $6607,$01 Decrease #REGl by one.
  $6608,$02 RLD.
  $660A,$01 Decrease #REGl by one.
  $660B,$02 RLD.
  $660D,$01 Decrease #REGl by one.
  $660E,$02 RLD.
  $6610,$01 Decrease #REGl by one.
  $6611,$02 RLD.
  $6613,$01 Decrease #REGl by one.
  $6614,$02 RLD.
  $6616,$01 Decrease #REGl by one.
  $6617,$02 RLD.
  $6619,$01 Decrease #REGl by one.
  $661A,$02 RLD.
  $661C,$01 Decrease #REGl by one.
  $661D,$02 RLD.
  $661F,$01 Decrease #REGl by one.
  $6620,$02 RLD.
  $6622,$01 Decrease #REGl by one.
  $6623,$02 RLD.
  $6625,$01 Decrease #REGl by one.
  $6626,$02 RLD.
  $6628,$01 Decrease #REGl by one.
  $6629,$02 RLD.
  $662B,$01 Decrease #REGl by one.
  $662C,$02 RLD.
  $662E,$01 Decrease #REGl by one.
  $662F,$02 RLD.
  $6631,$01 Decrease #REGl by one.
  $6632,$02 RLD.
  $6634,$01 Decrease #REGl by one.
  $6635,$02 RLD.
  $6637,$01 Decrease #REGl by one.
  $6638,$02 RLD.
  $663A,$01 #REGl=#REGe.
  $663B,$02 Increment #REGh by two.
  $663D,$02 Decrease counter by one and loop back to #R$65D7 until counter is zero.
  $663F,$04 Move down one character row.
  $6643,$01 Update the screen pointer.
  $6644,$02 Jump to #R$6648 if {} is higher.
  $6646,$02 #REGd=#N$48.
@ $6648 label=ScrollPlayarea_NextRow
  $6648,$01 Update the screen pointer.
  $6649,$01 Switch to the shadow registers.
  $664A,$02 Decrease counter by one and loop back to #R$65CD until counter is zero.
  $664C,$01 Switch back to the normal registers.
  $664D,$01 Return.

u $664E

c $6650 Scroll Playarea Right
@ $6650 label=ScrollPlayarea_Right
D $6650 #HTML(Scrolls the play area horizontally by shifting pixel data right
. using <code>RRD</code> instructions.)
  $6650,$03 #REGhl=*#R$7817.
  $6653,$06 Jump to #R$6667 if *#R$7819 is not zero.
  $6659,$04 Jump to #R$6661 if #REGl is not zero.
  $665D,$04 #REGh-=#N$05.
  $6661,$01 Decrease #REGl by one.
  $6662,$03 Write #REGhl to *#R$7817.
  $6665,$02 #REGa=#N$08.
  $6667,$01 Decrease #REGa by one.
  $6668,$03 Write #REGa to *#R$7819.
  $666B,$02 Copy #REGhl to #REGde.
  $666D,$02 #REGb=#N$FF.
  $666F,$03 Call #R$6564.
N $6672 Start of screen buffer.
  $6672,$03 #REGhl=#R$4000(#N$4000) (screen buffer).
  $6675,$02 Copy the screen position pointer into #REGde.
  $6677,$01 Switch to the shadow registers.
  $6678,$01 #REGa=*#REGde.
  $6679,$01 Increment #REGe by one.
  $667A,$01 #REGl=#REGa.
  $667B,$02 #REGh=#N$1F.
  $667D,$02 Multiply #REGhl by #N$04.
  $667F,$01 Switch to the shadow registers.
N $6680 #HTML(Scroll one character row (#N$20 characters) left by #N$01 pixel
. using <code>RRD</code>.)
  $6680,$02 Set a counter in #REGb for #N$04 rows.
@ $6682 label=ScrollCharacterRow_Right
  $6682,$01 Switch to the shadow registers.
  $6683,$01 #REGa=*#REGhl.
  $6684,$01 Increment #REGl by one.
  $6685,$01 Switch to the shadow registers.
  $6686,$02 RRD.
  $6688,$01 Increment #REGl by one.
  $6689,$02 RRD.
  $668B,$01 Increment #REGl by one.
  $668C,$02 RRD.
  $668E,$01 Increment #REGl by one.
  $668F,$02 RRD.
  $6691,$01 Increment #REGl by one.
  $6692,$02 RRD.
  $6694,$01 Increment #REGl by one.
  $6695,$02 RRD.
  $6697,$01 Increment #REGl by one.
  $6698,$02 RRD.
  $669A,$01 Increment #REGl by one.
  $669B,$02 RRD.
  $669D,$01 Increment #REGl by one.
  $669E,$02 RRD.
  $66A0,$01 Increment #REGl by one.
  $66A1,$02 RRD.
  $66A3,$01 Increment #REGl by one.
  $66A4,$02 RRD.
  $66A6,$01 Increment #REGl by one.
  $66A7,$02 RRD.
  $66A9,$01 Increment #REGl by one.
  $66AA,$02 RRD.
  $66AC,$01 Increment #REGl by one.
  $66AD,$02 RRD.
  $66AF,$01 Increment #REGl by one.
  $66B0,$02 RRD.
  $66B2,$01 Increment #REGl by one.
  $66B3,$02 RRD.
  $66B5,$01 Increment #REGl by one.
  $66B6,$02 RRD.
  $66B8,$01 Increment #REGl by one.
  $66B9,$02 RRD.
  $66BB,$01 Increment #REGl by one.
  $66BC,$02 RRD.
  $66BE,$01 Increment #REGl by one.
  $66BF,$02 RRD.
  $66C1,$01 Increment #REGl by one.
  $66C2,$02 RRD.
  $66C4,$01 Increment #REGl by one.
  $66C5,$02 RRD.
  $66C7,$01 Increment #REGl by one.
  $66C8,$02 RRD.
  $66CA,$01 Increment #REGl by one.
  $66CB,$02 RRD.
  $66CD,$01 Increment #REGl by one.
  $66CE,$02 RRD.
  $66D0,$01 Increment #REGl by one.
  $66D1,$02 RRD.
  $66D3,$01 Increment #REGl by one.
  $66D4,$02 RRD.
  $66D6,$01 Increment #REGl by one.
  $66D7,$02 RRD.
  $66D9,$01 Increment #REGl by one.
  $66DA,$02 RRD.
  $66DC,$01 Increment #REGl by one.
  $66DD,$02 RRD.
  $66DF,$01 Increment #REGl by one.
  $66E0,$02 RRD.
  $66E2,$01 Increment #REGl by one.
  $66E3,$02 RRD.
  $66E5,$01 #REGl=#REGe.
  $66E6,$02 Increment #REGh by two.
  $66E8,$02 Decrease counter by one and loop back to #R$6682 until counter is zero.
  $66EA,$04 #REGe+=#N$20.
  $66EE,$01 #REGl=#REGa.
  $66EF,$02 Jump to #R$66F3 if {} is higher.
  $66F1,$02 #REGd=#N$48.
@ $66F3 label=ContinueScreenScroll_Right
  $66F3,$01 Update the screen pointer.
  $66F4,$01 Switch to the shadow registers.
  $66F5,$02 Decrease counter by one and loop back to #R$6678 until counter is zero.
  $66F7,$01 Switch back to the normal registers.
  $66F8,$01 Return.

u $66F9

c $6700
  $6700,$03 #REGde=#R$7802.
  $6703,$02 #REGb=#N$10.
  $6705,$01 #REGa=*#REGde.
  $6706,$01 Increment #REGe by one.
  $6707,$02 #REGc=#N$04.
  $6709,$04 Jump to #R$6722 if #REGa is lower than #N$0F.
  $670D,$04 Jump to #R$6722 if #REGa is higher than #N$90.
  $6711,$01 Increment #REGc by one.
  $6712,$04 Jump to #R$6722 if #REGa is lower than #N$3D.
  $6716,$01 Increment #REGc by one.
  $6717,$04 Jump to #R$6722 if #REGa is lower than #N$51.
  $671B,$02 #REGc=#N$02.
  $671D,$04 Jump to #R$6722 if #REGa is lower than #N$6F.
  $6721,$01 Increment #REGc by one.
  $6722,$01 Write #REGc to *#REGhl.
  $6723,$02 #REGa=#N$20.
  $6725,$01 #REGa+=#REGl.
  $6726,$01 #REGl=#REGa.
  $6727,$01 #REGa+=#REGh.
  $6728,$01 #REGa-=#REGl.
  $6729,$01 #REGh=#REGa.
  $672A,$02 Decrease counter by one and loop back to #R$6705 until counter is zero.
  $672C,$01 Return.

u $672D

c $672E
  $672E,$03 #REGhl=#N$5801 (attribute buffer location).
  $6731,$03 #REGde=#R$5800(#N$5800) (attribute buffer location).
  $6734,$02 #REGb=#N$10.
  $6736,$02 #REGc=#N$FF.
  $6738,$3E LDI.
  $6776,$01 Increment #REGhl by one.
  $6777,$01 Increment #REGde by one.
  $6778,$02 Decrease counter by one and loop back to #R$6736 until counter is zero.
  $677A,$03 #REGhl=#N$581F (attribute buffer location).
  $677D,$03 Jump to #R$6700.

u $6780

c $678C
  $678C,$03 #REGhl=#N$59FE (attribute buffer location).
  $678F,$03 #REGde=#N$59FF (attribute buffer location).
  $6792,$02 #REGb=#N$10.
  $6794,$02 #REGc=#N$FF.
  $6796,$3E LDD.
  $67D4,$01 Decrease #REGhl by one.
  $67D5,$01 Decrease #REGde by one.
  $67D6,$02 Decrease counter by one and loop back to #R$6794 until counter is zero.
  $67D8,$03 #REGhl=#R$5800(#N$5800) (attribute buffer location).
  $67DB,$03 Jump to #R$6700.

u $67DE

c $67E9 Draw Playarea
@ $67E9 label=DrawPlayarea
  $67E9,$07 Return if *#R$7814 is not equal to #N$02.
  $67F0,$02 Write #N$00 to *#REGhl.
  $67F2,$01 Increment #REGhl by one.
  $67F3,$01 #REGa=*#REGhl.
  $67F4,$02 Return if #REGa is zero.
  $67F6,$02 Write #N$00 to *#REGhl.
  $67F8,$05 Jump to #R$672E if #REGa is equal to #N$02.
  $67FD,$03 Jump to #R$678C.

c $6800
  $6800,$03 Write #REGa to *#R$7819.
  $6803,$04 #REGl-=#N$08.
  $6807,$02 Jump to #R$680D if {} is higher.
  $6809,$04 #REGh-=#N$05.
  $680D,$03 Write #REGhl to *#R$7817.
  $6810,$06 Write #N($0000,$04,$04) to *#R$7814.
  $6816,$02 #REGb=#N$20 (counter; screen columns).
  $6818,$01 Stash the screen column counter on the stack.
  $6819,$03 Call #R$659C.
  $681C,$03 Call #R$659C.
  $681F,$03 Call #R$67E9.
  $6822,$01 Restore the screen column counter from the stack.
  $6823,$02 Decrease the screen column counter by one and loop back to #R$6818 until counter is zero.
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

u $687D

c $6880 Display Speedometer
@ $6880 label=DisplaySpeedometer
R $6880 A The speed value
R $6880 DE Points to #N$5A45 (the attribute buffer location of the speedometer)
E $6880 Continue on to #R$6893.
  $6880,$04 Jump to #R$6885 if the speed value is negative.
  $6884,$01 Make the position speed value into a negative.
N $6885 Strip off the signed bit.
@ $6885 label=ProcessSpeedValue
  $6885,$02,b$01 Keep only bits 0-6.
  $6887,$02 Divide the speed value by two and store the result in #REGl (scaled
. speed value).
  $6889,$02 Set the base offset value in #REGa of #N$A7.
  $688B,$04 No operation.
  $688F,$02 Update #REGl to #N$A7 - the scaled speed value.
  $6891,$02 Set #REGh to the high byte of the display data table.

c $6893 Copy #N$0C Bytes
@ $6893 label=CopyTwelveBytes
R $6893 HL Source address
R $6893 DE Destination address
  $6893,$18 Copy #N$0C bytes from the source address to the destination
. address.
  $68AB,$01 Return.

u $68AC

c $68AD Remove Sprites
@ $68AD label=RemoveSprites
  $68AD,$05 Return if *#R$781B is zero (no sprite blocks on the screen).
N $68B2 Whilst this routine is clearing sprites, the data is stored per
. character block, e.g. a kangaroo may span 3 character blocks - and data is
. stored individually for each of those three blocks, so the count is +3 for
. a kangaroo (when it is covering those three blocks).
  $68B2,$03 Load *#R$781C into #REGhl.
  $68B5,$01 Set a counter in #REGb of the number of character blocks needed to
. clear all the sprites.
  $68B6,$02 Set a "clear" value (#N$00) in #REGc.

@ $68B8 label=RemoveSingleSpriteBlock_Loop
M $68B8,$04 Load #REGde with the attribute buffer address of the sprite block.
  $68B8,$01 Decrease #REGhl by one.
  $68B9,$01 #REGd=*#REGhl.
  $68BA,$01 Decrease #REGhl by one.
  $68BB,$01 #REGe=*#REGhl.
M $68BC,$02 Fetch the background attribute value.
  $68BC,$01 Decrease #REGhl by one.
  $68BD,$01 #REGa=*#REGhl.
  $68BE,$01 Write the background attribute value to the attribute buffer
. address held in #REGde.
  $68BF,$01 Move to next buffer entry.
N $68C0 Convert the attribute address to the corresponding screen buffer
. address.
  $68C0,$03 Taking the attribute buffer high byte, subtract #N$11.
  $68C3,$02,b$01 Adjust for the screen buffer memory layout.
  $68C5,$01 Write this back into #REGd.
  $68C6,$01 Exchange the #REGde and #REGhl registers.
  $68C7,$01 Write #REGc to *#REGhl.
  $68C8,$01 Decrease #REGh by one.
  $68C9,$01 #REGa=*#REGde.
  $68CA,$01 Write #REGa to *#REGhl.
  $68CB,$01 Decrease #REGde by one.
  $68CC,$01 Decrease #REGh by one.
  $68CD,$01 Write #REGc to *#REGhl.
  $68CE,$01 Decrease #REGh by one.
  $68CF,$01 #REGa=*#REGde.
  $68D0,$01 Write #REGa to *#REGhl.
  $68D1,$01 Decrease #REGde by one.
  $68D2,$01 Decrease #REGh by one.
  $68D3,$01 Write #REGc to *#REGhl.
  $68D4,$01 Decrease #REGh by one.
  $68D5,$01 #REGa=*#REGde.
  $68D6,$01 Write #REGa to *#REGhl.
  $68D7,$01 Decrease #REGde by one.
  $68D8,$01 Decrease #REGh by one.
  $68D9,$01 Write #REGc to *#REGhl.
  $68DA,$01 Decrease #REGh by one.
  $68DB,$01 #REGa=*#REGde.
  $68DC,$01 Write #REGa to *#REGhl.
  $68DD,$01 Exchange the #REGde and #REGhl registers.
  $68DE,$02 Decrease the sprite block counter by one and loop back to #R$68B8
. until all the sprite blocks have been reverted to backgrounds.
N $68E0 All sprite blocks are now reverted!
  $68E0,$03 Update the buffer position at *#R$781C.
  $68E3,$04 Mark that no sprite blocks are now active at *#R$781B.
  $68E7,$01 Return.

u $68E8

c $68EC Complete Sprite Sequence
@ $68EC label=CompleteSpriteSequence
R $68EC B' Active block counter
R $68EC HL' Sprite background buffer pointer
  $68EC,$01 Switch to the shadow registers.
  $68ED,$03 Write the updated sprite background buffer pointer to *#R$781C.
  $68F0,$04 Write the updated active block counter to *#R$781B.
  $68F4,$01 Switch back to the normal registers.
  $68F5,$01 Return.

c $68F6 Draw Sprite
@ $68F6 label=DrawSprite
R $68F6 BC Sprite data pointer
R $68F6 HL Screen buffer address
R $68F6 HL' Sprite background buffer
  $68F6,$01 Read the current screen data (row #N$01).
  $68F7,$01 Switch to the shadow registers.
  $68F8,$01 Save row #N$01 background data to the sprite background buffer.
  $68F9,$01 Move to the next position in the background buffer.
  $68FA,$01 Switch back to the normal registers.
  $68FB,$02 Write sprite pixel data to row #N$01 of the screen buffer.
  $68FD,$01 Move to the next sprite data byte.
  $68FE,$01 Move to row #N$02 in the screen buffer.
  $68FF,$02 Write sprite pixel data to row #N$02 of the screen buffer.
  $6901,$01 Move to the next sprite data byte.
  $6902,$01 Move to row #N$03 in the screen buffer.
  $6903,$01 Read the current screen data (row #N$03).
  $6904,$01 Switch to the shadow registers.
  $6905,$01 Save row #N$03 background data to the sprite background buffer.
  $6906,$01 Move to the next position in the background buffer.
  $6907,$01 Switch back to the normal registers.
  $6908,$02 Write sprite pixel data to row #N$03 of the screen buffer.
  $690A,$01 Move to the next sprite data byte.
  $690B,$01 Move to row #N$04 in the screen buffer.
  $690C,$02 Write sprite pixel data to row #N$04 of the screen buffer.
  $690E,$01 Move to the next sprite data byte.
  $690F,$01 Return.

c $6910 Convert Screen Buffer Address To Attribute Buffer
@ $6910 label=ScreenBufferToAttributeBuffer
E $6910 Continue on to #R$691B.
  $6910,$01 #REGa=#REGh.
  $6911,$02 #REGa-=#N$48.
  $6913,$01 #REGa-=#REGa (with carry).
  $6914,$02 #REGa+=#N$59.
  $6916,$01 #REGh=#REGa.
  $6917,$01 #REGa=*#REGhl.
  $6918,$01 Stash #REGhl on the stack.
  $6919,$01 Switch to the shadow registers.
  $691A,$01 Restore #REGde' from the stack.
M $6918,$03 #REGde'=#REGhl (using the stack).

c $691B Colourise Sprite
@ $691B label=ColouriseSprite
R $691B A Sprite data
R $691B B' Sprite block counter
R $691B C' Sprite attribute
R $691B D' Sprite Y position
R $691B E' Sprite X position
R $691B HL' Background buffer store
R $691B HL Attribute buffer pointer
  $691B,$01 Increment the sprite block counter in #REGb' by one.
  $691C,$01 Write the sprite data to the sprite background buffer.
  $691D,$01 Increment the sprite background buffer by one.
  $691E,$01 Write the sprite X position to the sprite background buffer.
  $691F,$01 Increment the sprite background buffer by one.
  $6920,$01 Write the sprite Y position to the sprite background buffer.
  $6921,$01 Increment the sprite background buffer by one.
  $6922,$02 Check if this is a special sprite (type #N$07).
  $6924,$01 Load the sprite attribute from #REGc'.
  $6925,$01 Switch back to the normal registers.
  $6926,$01 Write the sprite attribute to the attribute buffer.
  $6927,$01 Return if this isn't a special type #N$07 sprite (from line
. #R$6922).
  $6928,$03 Jump to #R$73F2.

u $692B
  $692B,$01 Return.

c $692C Draw Sprite Object
@ $692C label=DrawSpriteObject
R $692C A Sprite frame ID
R $692C C Sprite colour
R $692C DE Sprite screen position
  $692C,$01 Store the sprite frame ID in #REGb.
  $692D,$01 Load the sprite attribute value into #REGa.
  $692E,$01 Switch to the shadow registers.
  $692F,$03 #REGhl'=*#R$781C.
  $6932,$01 Load the sprite attribute value into #REGc'.
  $6933,$04 Load *#R$781B into #REGb'.
  $6937,$01 Switch back to the normal registers.
N $6938 Calculate the sprite data address from the frame ID.
  $6938,$03 Load #REGl with the frame ID multiplied by #N$02.
N $693B This is quite clever, and very subtle. It's probably easier here to
. show examples:
. #TABLE(default,centre,centre)
.   { =h Input Value | =h Output in #REGhl }
.   #FOREACH($0D,$12,$87,$C7)(n,{ #Nn | #SIM(start=$692C,stop=$693F,a=n)#R({sim[HL]})(#N({sim[HL]})) })
. TABLE#
. From a quick glance, the following code looks pretty straight-forward, just a
. little strange: #REGh=(frame ID * #N$02) + #N$BE - (frame ID * #N$02).
.
. #HTML(The cleverness here is with the carry flag and the <code>ADC</code>
. instruction.)
.
. #HTML(When the multiplication of the frame ID passes #N$100, the carry flag
. is set and this is included when adding the graphics high byte #N$BE. The
. <code>SUB #REGl</code> then removes the "frame ID * #N$02" part, leaving just
. #N$BE + carry flag.)
  $693B,$04 Load #REGh with the high byte for the graphics data: #N$BE + the
. carry flag.
  $693F,$01 Load the original frame ID into #REGa.
N $6940 Fetch the sprite data.
  $6940,$03 Fetch the sprite data address from *#REGhl and store it in #REGbc.
N $6943 Check the sprite "type" bit.
  $6943,$05 Jump to #R$6DA8 if bit 5 of the sprite ID is set.
N $6948 Process regular sprite animation frames.
  $6948,$01 Fetch the sprite X offset and store it in #REGa.
@ $6949 label=ProcessNextFrame
  $6949,$01 Move to the next data byte.
  $694A,$02 #REGe=base X position + the sprite X offset.
  $694C,$01 Fetch the sprite Y offset and store it in #REGa.
  $694D,$01 Move to the next data byte.
@ $694E label=CalculatePosition
  $694E,$02 #REGd=base Y position + the sprite Y offset.
N $6950 Check if the sprite frame is within the screen boundaries.
  $6950,$04 Jump to #R$6959 if the sprites "Y" position is higher than #N$10.
  $6954,$05 Jump to #R$696E if the sprites "X" position is lower than #N$20.
N $6959 Skip the current frame and advance to the next frame data.
@ $6959 label=SkipToNextFrame
  $6959,$06 #REGbc=sprite data pointer+#N($0008,$04,$04).
@ $695F label=CheckNextFrame
  $695F,$01 Load #REGa with the next control byte from *#REGbc.
N $6960 Check for the terminator (#N$FF+#N$01 will set the zero flag).
  $6960,$01 Increment the control byte by one.
  $6961,$02 Set the sprite "type" flag in #REGa to #N$01.
  $6963,$02 Jump to #R$694E if the terminator character wasn't detected (on
. line #R$6960).
N $6965 We reached the terminator.
  $6965,$01 Move to the next data byte.
N $6966 Check for the sequence end marker byte.
  $6966,$01 Read the sequence control byte.
  $6967,$04 Jump to #R$6949 if the sequence control byte is not equal to #N$80.
  $696B,$03 Jump to #R$68EC.
N $696E Draw the sprite frame to the screen.
@ $696E label=DrawVisibleFrame
  $696E,$01 Load the sprite Y position.
  $696F,$02 Convert it to a screen buffer address.
N $6971 Extract the bits which relate to the ZX Spectrum screen layout.
  $6971,$02,b$01 Keep only bits 3 and 6.
  $6973,$01 Store the result in #REGh.
  $6974,$01 Reload the sprite Y position.
  $6975,$03 Rotate #REGa right three positions (bits 0 to 2 are now in positions 5 to 7).
N $6978 Keep only the row bits.
  $6978,$02,b$01 Keep only bits 5-7.
  $697A,$02 Add the sprite X position and store the result in #REGl.
N $697C Draw the sprite to the screen buffer.
  $697C,$03 Call #R$68F6 to draw the top of the sprite.
  $697F,$01 Move to the next screen row.
  $6980,$03 Call #R$68F6 to draw the bottom of the sprite.
  $6983,$03 Call #R$6910.
  $6986,$02 Jump to #R$695F.

c $6988
  $6988,$03 Write #REGa to *#R$7825.
  $698B,$01 Switch to the shadow registers.
  $698C,$01 Write #REGa to *#REGhl.
  $698D,$01 Load the active sprite block count into #REGh.
  $698E,$01 Load the attribute byte into #REGl.
  $698F,$03 Jump to #R$691B.

u $6992

c $6996
  $6996,$01 #REGe=#REGa.
  $6997,$03 #REGa=*#R$7828.
  $699A,$04 Jump to #R$69A4 if bit 2 of #REGa is not zero.
  $699E,$01 Increment #REGe by one.
  $699F,$04 Jump to #R$69A4 if bit 3 of #REGa is zero.
  $69A3,$01 Increment #REGe by one.
  $69A4,$01 #REGl=*#REGhl.
  $69A5,$02 #REGh=#N$00.
  $69A7,$02 #REGd=#N$B5.
  $69A9,$01 #REGhl+=#REGhl.
  $69AA,$01 #REGb=#REGh.
  $69AB,$01 #REGc=#REGl.
  $69AC,$01 #REGhl+=#REGhl.
  $69AD,$01 #REGhl+=#REGhl.
  $69AE,$01 #REGhl+=#REGhl.
  $69AF,$01 #REGhl+=#REGbc.
  $69B0,$01 #REGhl+=#REGde.
  $69B1,$01 #REGa=*#REGhl.
  $69B2,$01 #REGa+=#REGa.
  $69B3,$01 #REGa+=#REGa.
  $69B4,$01 #REGl=#REGa.
  $69B5,$02 #REGh=#N$BB.
  $69B7,$01 Return.

u $69B8

c $69BA
  $69BA,$01 #REGhl+=#REGhl.
  $69BB,$01 #REGhl+=#REGbc.
  $69BC,$01 Return.

u $69BD

c $69BE
  $69BE,$03 #REGde=#N($0002,$04,$04).
  $69C1,$01 #REGhl+=#REGde.
  $69C2,$01 #REGa=*#REGhl.
  $69C3,$01 RLCA.
  $69C4,$01 #REGa-=#REGa.
  $69C5,$01 Return if {} is lower.
  $69C6,$03 Return if bit 6 of *#REGhl is zero.
  $69C9,$01 Increment #REGa by one.
  $69CA,$01 Return.
  $69CB,$03 Call #R$69BE.
  $69CE,$01 #REGe=#REGa.
  $69CF,$03 #REGhl=*#R$782E.
  $69D2,$01 #REGa+=#REGh.
  $69D3,$01 #REGh=#REGa.
  $69D4,$01 #REGhl+=#REGbc.
  $69D5,$03 Jump to #R$69DD if #REGa is equal to #REGh.
  $69D8,$01 #REGa=#REGc.
  $69D9,$01 #REGa+=#REGa.
  $69DA,$01 #REGa+=#REGa.
  $69DB,$01 #REGa+=#REGh.
  $69DC,$01 #REGh=#REGa.
  $69DD,$01 #REGa=#REGb.
  $69DE,$02,b$01 Keep only bits 0-1.
  $69E0,$01 Increment #REGa by one.
  $69E1,$01 #REGa+=#REGe.
  $69E2,$01 #REGe=#REGa.
  $69E3,$03 Call #R$6F62.
  $69E6,$01 #REGa+=#REGa.
  $69E7,$01 #REGa+=#REGe.
  $69E8,$03 Call #R$6996.
  $69EB,$03 Write #REGhl to *#R$7831.
  $69EE,$03 #REGa=*#R$7830.
  $69F1,$01 Return.

u $69F2

c $6A00
  $6A00,$03 #REGa=*#R$7830.
  $6A03,$01 Increment #REGa by one.
  $6A04,$02,b$01 Keep only bits 0-2.
  $6A06,$03 Write #REGa to *#R$7830.
  $6A09,$03 #REGhl=*#R$7831.
  $6A0C,$03 #REGbc=#N($0001,$04,$04).
  $6A0F,$03 Call #R$69CB if #REGa is zero.
  $6A12,$02 #REGc=#REGa*#N$02.
  $6A14,$02 Jump to #R$6A27.

u $6A16

c $6A17

c $6A27
  $6A27,$01 #REGa=*#REGhl.
  $6A28,$04 RLCA.
  $6A2C,$01 #REGl=#REGa.
  $6A2D,$02,b$01 Keep only bits 0-3.
  $6A2F,$03 #REGh=#N$C0+#REGa.
  $6A32,$01 #REGa=#REGl.
  $6A33,$02,b$01 Keep only bits 4-7.
  $6A35,$01 #REGa+=#REGc.
  $6A36,$01 #REGl=#REGa.
  $6A37,$01 #REGa=*#REGhl.
  $6A38,$01 Increment #REGl by one.
  $6A39,$03 Write #REGa to *#R$7834.
  $6A3C,$01 #REGa=*#REGhl.
  $6A3D,$03 #REGhl=#R$7826.
  $6A40,$02 Write #N$00 to *#REGhl.
  $6A42,$01 RRCA.
  $6A43,$02 Jump to #R$6A46 if {} is higher.
  $6A45,$01 Increment *#REGhl by one.
  $6A46,$01 RRCA.
  $6A47,$01 #REGc=#REGa.
  $6A48,$02 Jump to #R$6A6D if {} is higher.
  $6A4A,$02,b$01 Keep only bits 0-1.
  $6A4C,$02 #REGl=#N$33.
  $6A4E,$02 Jump to #R$6A51 if {} is not zero.
  $6A50,$01 Decrease *#REGhl by one.
  $6A51,$01 Decrease #REGa by one.
  $6A52,$02 Jump to #R$6A55 if #REGa is not zero.
  $6A54,$01 Increment *#REGhl by one.
  $6A55,$02 #REGl=#N$26.
  $6A57,$01 #REGb=#REGa.
  $6A58,$02 #REGa=#N$23.
  $6A5A,$01 #REGa-=*#REGhl.
  $6A5B,$01 #REGl=#REGa.
  $6A5C,$01 #REGa=*#REGhl.
  $6A5D,$01 Decrease #REGb by one.
  $6A5E,$02 Jump to #R$6A65 if #REGb is not zero.
  $6A60,$04 Jump to #R$6A65 if #REGa is equal to #N$69.
  $6A64,$01 Decrease *#REGhl by one.
  $6A65,$01 Decrease #REGb by one.
  $6A66,$02 Jump to #R$6A6D if #REGb is not zero.
  $6A68,$04 Jump to #R$6A6D if #REGa is equal to #N$96.
  $6A6C,$01 Increment *#REGhl by one.
  $6A6D,$02 #REGl=#N$26.
  $6A6F,$04 Jump to #R$6A94 if *#REGhl is not zero.
  $6A73,$02 #REGl=#N$22.
  $6A75,$05 Jump to #R$6A7B if bit 7 of *#REGhl is set.
  $6A7A,$01 Invert the bits in #REGa.
  $6A7B,$01 #REGb=#REGa.
  $6A7C,$01 Decrease #REGl by one.
  $6A7D,$05 Jump to #R$6A83 if bit 7 of *#REGhl is set.
  $6A82,$01 #REGa=#N$00.
  $6A83,$01 #REGa-=#REGb.
  $6A84,$02 Jump to #R$6A94 if {} is higher.
  $6A86,$01 Invert the bits in #REGa.
  $6A87,$04 Shift #REGa right twice.
  $6A8B,$02 #REGl=#N$34.
  $6A8D,$01 #REGa+=*#REGhl.
  $6A8E,$04 Jump to #R$6A93 if bit 4 of #REGa is not set.
  $6A92,$01 Decrease #REGa by one.
  $6A93,$01 Write #REGa to *#REGhl.
  $6A94,$01 #REGa=#REGc.
  $6A95,$03 RRCA.
  $6A98,$01 Return if {} is higher.
N $6A99 There are #N$07 actions. They are contained in a jump table at: #R$B4DC onwards.
  $6A99,$02,b$01 Keep only bits 0-2.
  $6A9B,$04 #REGl=#N$DC+(#REGa*#N$02).
  $6A9F,$02 #REGh=#N$B4.
N $6AA1 Fetch the related action from the jump table and jump to it.
  $6AA1,$01 #REGa=*#REGhl.
  $6AA2,$01 Increment #REGl by one.
  $6AA3,$01 #REGh=*#REGhl.
  $6AA4,$01 #REGl=#REGa.
  $6AA5,$01 Jump to *#REGhl.

u $6AA6

c $6AAC

u $6B2A

c $6B2D Handler: Player Sprite
@ $6B2D label=Handler_PlayerSprite
  $6B2D,$03 Load #REGa with *#R$7822.
  $6B30,$02 Set the sprite offset in #REGe (#N$0D bytes).
  $6B32,$02 Check the direction bit.
  $6B34,$02 Jump to #R$6B38 if the player is moving fowards.
  $6B36,$02 Set an alternate sprite offset for the left-facing sprite (#N$12
. bytes).
@ $6B38 label=SetPlayerSpriteDirection
  $6B38,$02 Set #INK$07 to #REGc.
  $6B3A,$04 Fetch #R$7833 in #REGd.
  $6B3E,$02 Fetch #R$7834 in #REGa.
  $6B40,$03 Call #R$692C.
  $6B43,$01 Return.

c $6B44 Unused?
  $6B44,$01 Increment #REGd by one.
  $6B45,$01 Write #REGe to *#REGhl.
  $6B46,$01 Return.

u $6B47

c $6B48 Get Controls
@ $6B48 label=GetControls
  $6B48,$03 #REGhl=*#R$782C.
  $6B4B,$01 Jump to *#REGhl.

c $6B4C Handler: Player Movement
@ $6B4C label=Handler_PlayerMovement
R $6B4C A Input state
  $6B4C,$03 Store the current player input state in *#R$7828.
N $6B4F Set up the directional indicator colors based on the input combination.
. The indicators show which direction the player will move on slopes.
N $6B4F Note that the middle body section is shared between the "UP" and "DOWN"
. arrows, this is why the logic controls three colour variables.
  $6B4F,$02 Initialise the "UP" indicator colour in #REGc to #INK$00 (OFF).
  $6B51,$03 Set #INK$06 (ON) for both #REGd ("DOWN" indicator) and #REGe
. (the middle body section of the indicators).
  $6B54,$04 Jump to #R$6B61 if "DOWN" is being pressed.
N $6B58 A "DOWN" key is not being pressed, so activate the "UP" indicator.
  $6B58,$01 Change the "UP" indicator colour in #REGc to #INK$06 (ON).
  $6B59,$02 Clear the "DOWN" indicator colour in #REGe to #INK$00 (OFF).
  $6B5B,$04 Jump to #R$6B61 if "UP" is being pressed.
N $6B5F Neither "UP" or "DOWN" are being pressed, so clear both indicators.
  $6B5F,$01 Clear the "UP" indicator colour in #REGc to #INK$00 (OFF).
  $6B60,$01 Clear the middle body section colour in #REGd to #INK$00 (OFF).
N $6B61 Paint the indicators.
N $6B61 First paint the "UP" section.
@ $6B61 label=UpdateIndicatorDisplay
  $6B61,$03 Set the attribute buffer location of the top of the indicators in
. #REGhl to #N$5A53 to paint the "UP" section.
  $6B64,$03 Write #REGc containing the "UP" indicator colour value to the
. top left and right of the "UP" indicator.
N $6B67 The body of the indicator is shared between both "UP" and "DOWN"
. indicator arrows.
  $6B67,$02 Alter the attribute buffer location to point to the body of the
. indicator.
  $6B69,$03 Write #REGd containing the middle section of the indicator colour
. value to the middle left and right of the indicator body.
N $6B6C Finally, paint the "DOWN" section.
  $6B6C,$02 Alter the attribute buffer location to point to the bottom of the
. indicators to paint the "DOWN" section.
  $6B6E,$03 Write #REGe containing the "DOWN" indicator colour value to the
. bottom left and right of the "DOWN" indicator.
  $6B71,$03 No operation.
  $6B74,$03 #REGhl=#R$7823.
  $6B77,$02,b$01 Keep only bits 0-1.
  $6B79,$02 Jump to #R$6B99 if #REGl is equal to #N$93.
  $6B7B,$01 RRCA.
  $6B7C,$01 #REGa=*#REGhl.
  $6B7D,$02 Jump to #R$6B8C if #REGl is greater than or equal to #N$93.
  $6B7F,$02 Compare #REGa with #N$96.
  $6B81,$02 #REGa=#N$00.
  $6B83,$02 Jump to #R$6B99 if #REGa was equal to #N$96 on line #R$6B7F.
  $6B85,$01 Increment *#REGhl by one.
  $6B86,$02 Test bit 7 of *#REGhl.
  $6B88,$02 Jump to #R$6B99 if *#REGhl is not equal to #N$00.
  $6B8A,$02 Jump to #R$6B97.

  $6B8C,$02 Compare #REGa with #N$69.
  $6B8E,$02 #REGa=#N$00.
  $6B90,$02 Jump to #R$6B99 if #REGa was equal to #N$69 on line #R$6B8C.
  $6B92,$01 Decrease *#REGhl by one.
  $6B93,$02 Test bit 7 of *#REGhl.
  $6B95,$02 Jump to #R$6B99 if *#REGhl is equal to #N$00.
  $6B97,$05 Write #N$02 to *#R$7829.
  $6B9C,$02 #REGl=#N$27.
  $6B9E,$04 Jump to #R$6BA3 if *#REGhl is zero.
  $6BA2,$01 Decrease *#REGhl by one.
  $6BA3,$01 Decrease #REGl by one.
  $6BA4,$04 Jump to #R$6BC3 if *#REGhl is not zero.
  $6BA8,$02 #REGl=#N$23.
  $6BAA,$01 #REGa=*#REGhl.
  $6BAB,$01 Decrease #REGl by one.
  $6BAC,$03 Jump to #R$6BC3 if #REGa is equal to *#REGhl.
  $6BAF,$01 #REGa=*#REGhl.
  $6BB0,$02 Jump to #R$6BB4 if #REGa is less than *#REGhl.
  $6BB2,$02 Increment *#REGhl by two.
  $6BB4,$01 Decrease *#REGhl by one.
  $6BB5,$01 Set the bits from *#REGhl.
  $6BB6,$01 Increment #REGa by one.
  $6BB7,$02 Jump to #R$6BC3 if #REGa is not equal to *#REGhl.
  $6BB9,$01 #REGa=*#REGhl.
  $6BBA,$01 Decrease #REGl by one.
  $6BBB,$01 Write #REGa to *#REGhl.
  $6BBC,$01 RLCA.
  $6BBD,$03 Jump to #R$6AC9 if #REGl is greater than *#REGhl.
  $6BC0,$03 Jump to #R$6B10.
  $6BC3,$02 #REGl=#N$22.
  $6BC5,$01 #REGa=*#REGhl.
  $6BC6,$01 Decrease #REGl by one.
  $6BC7,$03 Jump to #R$6BEB if #REGa is equal to *#REGhl.
  $6BCA,$02 Jump to #R$6BD9 if #REGa is less than *#REGhl.
  $6BCC,$01 Increment *#REGhl by one.
  $6BCD,$01 RLCA.
  $6BCE,$02 Jump to #R$6BEA if *#REGhl is greater than or equal to *#REGhl.
  $6BD0,$06 Jump to #R$6BE5 if *#R$7827 is zero.
  $6BD6,$01 Decrease *#REGhl by one.
  $6BD7,$02 Jump to #R$6BEA.
  $6BD9,$01 Decrease *#REGhl by one.

  $6BDA,$01 RLCA.
  $6BDB,$02 Jump to #R$6BEA if *#REGhl is less than #REGa.
  $6BDD,$01 Increment *#REGhl by one.
  $6BDE,$06 Jump to #R$6BEA if *#R$7827 is not zero.
  $6BE4,$01 Decrease *#REGhl by one.
  $6BE5,$05 Write #N$03 to *#R$7827.
  $6BEA,$01 No operation.
  $6BEB,$02 #REGl=#N$22.
  $6BED,$01 #REGa=*#REGhl.
  $6BEE,$03 #REGde=#N$5A45 (attribute buffer location).
  $6BF1,$03 Call #R$6880.
  $6BF4,$03 #REGa=*#R$7823.
  $6BF7,$02 #REGe=#N$85.
  $6BF9,$03 Jump to #R$6D28.

u $6BFC

c $6C00 Game Loop
@ $6C00 label=Game_Loop
  $6C00,$03 #REGa=*#R$782B.
  $6C03,$02,b$01 Flip bit 0.
  $6C05,$03 Write #REGa back to *#R$782B.
  $6C08,$04 #REGsp=#N$FFFF.
  $6C0C,$03 #HTML(#REGa=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $6C0F,$01 Increment #REGa by one.
  $6C10,$03 #REGhl=#R$781A.
  $6C13,$01 Decrease *#REGhl by one.
  $6C14,$02 #REGl=#N$5A.
  $6C16,$01 Write #REGa to *#REGhl.
  $6C17,$02 Jump to #R$6C73 if *#REGhl is not zero.
  $6C19,$01 Increment *#REGhl by one.
  $6C1A,$02 #REGl=#N$2B.
  $6C1C,$01 #REGa=*#REGhl.
  $6C1D,$02,b$01 Flip bit 0.
  $6C1F,$01 Write #REGa to *#REGhl.

c $6CAA Game Initialisation
@ $6CAA label=GameInitialisation
  $6CAA,$03 Call #R$75AA.
@ $6CAD label=SetNewGameStates
  $6CAD,$06 Write #N$3400 to *#R$783C.
  $6CB3,$05 Write #N$00 to #R$7815.
  $6CB8,$03 Write #N$00 to #R$7814.
  $6CBB,$04 Write #N$01 to #R$781A.
  $6CBF,$03 Write #N$00 to #R$781B.
  $6CC2,$06 Write #R$B200 to #R$781C.
  $6CC8,$02 #REGhl=#R$7821.
N $6CCA Write #N$80 to #FOR$00,$02,,$01(n,#R($7821+n), , and ).
  $6CCA,$02 #REGb=#N$03.
  $6CCC,$02 Write #N$80 to *#REGhl.
  $6CCE,$01 Increment #REGl by one.
  $6CCF,$02 Decrease counter by one and loop back to #R$6CCC until counter is zero.
N $6CD1 Write #N$00 to #FOR$00,$07,,$01(n,#N($7824+n), , and ).
  $6CD1,$02 #REGb=#N$08.
  $6CD3,$02 Write #N$00 to *#REGhl.
  $6CD5,$01 Increment #REGl by one.
  $6CD6,$02 Decrease counter by one and loop back to #R$6CD3 until counter is zero.
  $6CD8,$07 Write #R$A100(#N$A113) to *#R$782E.
  $6CDF,$03 Write #N$03 to *#R$7830.
  $6CE2,$06 Write #N$BB00 to *#R$7831.
  $6CE8,$03 Write #N$0B to *#R$7833.
  $6CEB,$03 Write #N$00 to *#R$7834.
  $6CEE,$03 Call #R$6500.
  $6CF1,$02 #REGl=#N$10.
N $6CF3 See #R$E800.
  $6CF3,$07 Jump to #R$6D11 if the game is not in "demo mode" (the high-order byte of #R$782C does not contain #R$73B7(#N$73)).
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
  $6D13,$01 #REGa=#N$00.
  $6D14,$03 Call #R$6800.
  $6D17,$03 #HTML(#REGa=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $6D1A,$01 Increment #REGa by one.
  $6D1B,$03 Jump to #R$EBF6.

> $6D1E @org
c $6D1E
@ $6D1E label=Alias_InitialiseGame
  $6D1E,$03 Jump to #R$E80E.

c $6D21
  $6D21,$04 #REGsp=#N$FFFF.
  $6D25,$03 Jump to #R$6CAA.

c $6D28

c $6D49
  $6D49,$03 #HTML(#REGa=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $6D4C,$01 Increment #REGa by one.
  $6D4D,$03 Write #REGa to *#R$785A.
  $6D50,$03 #REGhl=#R$782A.
  $6D53,$04 Jump to #R$6D5E if *#REGhl is not zero.
  $6D57,$01 Decrease #REGl by one.
  $6D58,$04 Jump to #R$6D77 if *#REGhl is zero.
  $6D5C,$02 #REGa=#N$02.
  $6D5E,$02 #REGl=#N$CC.
  $6D60,$02 #REGb=#N$02.
  $6D62,$01 #REGd=*#REGhl.
  $6D63,$01 Increment #REGl by one.
  $6D64,$01 #REGe=*#REGhl.
  $6D65,$02 OUT #N$FE
  $6D67,$02,b$01 Flip bits 4.
  $6D69,$01 Decrease #REGe by one.
  $6D6A,$02 Jump to #R$6D69 until #REGe is zero.
  $6D6C,$03 Call #R$EC00.
  $6D6F,$01 Decrease #REGd by one.
  $6D70,$02 Jump to #R$6D64 until #REGd is zero.
  $6D72,$01 Increment #REGl by one.
  $6D73,$02 Decrease counter by one and loop back to #R$6D62 until counter is zero.
  $6D75,$02 Jump to #R$6D5E.
  $6D77,$03 #REGa=*#R$7835.
  $6D7A,$02 #REGa-=#N$9B.
  $6D7C,$01 #REGc=#REGa.
  $6D7D,$02 #REGd=#N$14.
  $6D7F,$02 #REGl=#N$CC.
  $6D81,$01 #REGa=#N$00.
  $6D82,$01 #REGb=#REGc.
  $6D83,$02 OUT #N$FE
  $6D85,$02,b$01 Flip bits 4.
  $6D87,$01 #REGe=*#REGhl.
  $6D88,$01 Decrease #REGe by one.
  $6D89,$02 Jump to #R$6D88 until #REGe is zero.
  $6D8B,$03 Call #R$EC00.
  $6D8E,$02 Decrease counter by one and loop back to #R$6D87 until counter is zero.
  $6D90,$01 Increment #REGl by one.
  $6D91,$01 Decrease #REGd by one.
  $6D92,$02 Jump to #R$6D82 until #REGd is zero.
  $6D94,$02 Jump to #R$6D7D.

c $6D96
  $6D96,$01 #REGa=*#REGhl.
  $6D97,$02 Write #N$00 to *#REGhl.
  $6D99,$01 Switch to the shadow registers.
  $6D9A,$01 Write #REGa to *#REGhl'.
  $6D9B,$01 Increment #REGhl' by one.
  $6D9C,$01 Switch back to the normal registers.
  $6D9D,$02 Increment #REGh by two.
  $6D9F,$01 #REGa=*#REGhl.
  $6DA0,$02 Write #N$00 to *#REGhl.
  $6DA2,$01 Switch to the shadow registers.
  $6DA3,$01 Write #REGa to *#REGhl'.
  $6DA4,$01 Increment #REGhl' by one.
  $6DA5,$01 Switch back to the normal registers.
  $6DA6,$01 Increment #REGh by one.
  $6DA7,$01 Return.

c $6DA8 Draw Large Sprite
@ $6DA8 label=DrawLargeSprite
  $6DA8,$01 #REGa=*#REGbc.
  $6DA9,$01 Increment #REGbc by one.
  $6DAA,$01 #REGa+=#REGe.
  $6DAB,$01 #REGe=#REGa.
  $6DAC,$01 #REGa=*#REGbc.
  $6DAD,$01 Increment #REGbc by one.
  $6DAE,$01 #REGa+=#REGd.
  $6DAF,$01 Decrease #REGa by one.
  $6DB0,$01 #REGd=#REGa.
  $6DB1,$02 Compare #REGa with #N$10.
  $6DB3,$02 Jump to #R$6DBA if #REGa is greater than or equal to #N$10.
  $6DB5,$05 Jump to #R$6DCF if #REGe is less than #N$20.
  $6DBA,$04 #REGhl=#N($0008,$04,$04)+#REGbc.
  $6DBE,$01 #REGb=#REGh.
  $6DBF,$01 #REGc=#REGl.
  $6DC0,$01 Increment #REGd by one.
  $6DC1,$01 #REGa=*#REGbc.
  $6DC2,$01 Increment #REGa by one.
  $6DC3,$03 Jump to #R$6DB1 if #REGd is not equal to #N$20.
  $6DC6,$01 Increment #REGbc by one.
  $6DC7,$05 Jump to #R$6DA9 if *#REGbc is not equal to #N$80.
  $6DCC,$03 Jump to #R$68EC.

  $6DCF,$01 #REGa=#REGd.
  $6DD0,$02 #REGa+=#N$40.
  $6DD2,$02,b$01 Keep only bits 3, 6.
  $6DD4,$01 #REGh=#REGa.
  $6DD5,$01 #REGa=#REGd.
  $6DD6,$01 RRCA.
  $6DD7,$01 RRCA.
  $6DD8,$01 RRCA.
  $6DD9,$02,b$01 Keep only bits 5-7.
  $6DDB,$01 #REGa+=#REGe.
  $6DDC,$01 #REGl=#REGa.
  $6DDD,$03 Call #R$6D96.
  $6DE0,$01 Increment #REGh by one.
  $6DE1,$03 Call #R$68F6.
  $6DE4,$03 Call #R$6910.
  $6DE7,$01 Increment #REGd by one.
  $6DE8,$05 Jump to #R$6DF3 if #REGd is less than #N$10.
  $6DED,$04 Increment #REGbc by four.
  $6DF1,$02 Jump to #R$6DC1.

  $6DF3,$02 #REGa+=#N$40.
  $6DF5,$02,b$01 Keep only bits 3, 6.
  $6DF7,$01 #REGh=#REGa.
  $6DF8,$01 #REGa=#REGd.
  $6DF9,$01 RRCA.
  $6DFA,$01 RRCA.
  $6DFB,$01 RRCA.
  $6DFC,$02,b$01 Keep only bits 5-7.
  $6DFE,$01 #REGa+=#REGe.
  $6DFF,$01 #REGl=#REGa.
  $6E00,$03 Call #R$68F6.
  $6E03,$01 Increment #REGh by one.
  $6E04,$01 #REGa=*#REGbc.
  $6E05,$01 Increment #REGa by one.
  $6E06,$02 Jump to #R$6DE1 if #REGa is not zero.
  $6E08,$03 Call #R$6D96.
  $6E0B,$03 Call #R$6910.
  $6E0E,$02 Jump to #R$6DC6.

b $6E10

c $6E18 Handler: Game Over
@ $6E18 label=Handler_GameOver
  $6E18,$03 Call #R$68AD.
  $6E1B,$03 #REGhl=*#R$783A.
  $6E1E,$01 #REGa=*#REGhl.
  $6E1F,$04 Jump to #R$6E57 if #REGa is higher than #N$F0.
  $6E23,$03 Write #REGa to *#R$7834.
  $6E26,$01 Increment #REGhl by one.
  $6E27,$01 #REGa=*#REGhl.
  $6E28,$02,b$01 Keep only bits 0-3.
  $6E2A,$03 Write #REGa to *#R$781A.
  $6E2D,$01 #REGa=*#REGhl.
  $6E2E,$01 Increment #REGhl by one.
  $6E2F,$03 Write #REGhl to *#R$783A.
  $6E32,$03 #REGhl=#R$7833.
  $6E35,$01 RLCA.
  $6E36,$02 Jump to #R$6E39 if {} is higher.
  $6E38,$01 Decrease *#REGhl by one.
  $6E39,$01 RLCA.
  $6E3A,$02 Jump to #R$6E3D if {} is higher.
  $6E3C,$01 Increment *#REGhl by one.
  $6E3D,$01 RLCA.
  $6E3E,$02 Jump to #R$6E48 if {} is higher.
  $6E40,$03 Call #R$659C.
  $6E43,$03 Call #R$67E9.
  $6E46,$02 Jump to #R$6E51.
  $6E48,$01 RLCA.
  $6E49,$02 Jump to #R$6E51 if {} is higher.
  $6E4B,$03 Call #R$6650.
  $6E4E,$03 Call #R$67E9.
  $6E51,$03 Call #R$6B2D.
  $6E54,$03 Call #R$6D50.
@ $6E57 label=StartCarouselAnimation
  $6E57,$01 Stash #REGaf on the stack.
  $6E58,$06 No operation.
  $6E5E,$03 Call #R$6B2D.
  $6E61,$01 Restore #REGaf from the stack.
  $6E62,$02,b$01 Keep only bits 0-3.
  $6E64,$02 #REGa-=#N$08.
  $6E66,$01 #REGb=#REGa.
  $6E67,$05 Fetch *#R$7822 to determine if the player facing left or right?
  $6E6C,$02 Set a default offset in #REGa of #N$12.
  $6E6E,$02 Jump to #R$6E72 if the player is facing left.
N $6E70 The player is facing right.
  $6E70,$02 Change the offset in #REGa to #N$0D.
  $6E72,$01 #REGa+=#REGb.
  $6E73,$01 #REGl=#REGa.
  $6E74,$03 #REGa=*#R$7833.
  $6E77,$02 #REGa-=#N$02.
  $6E79,$02 #REGh=#N$40.
  $6E7B,$04 Jump to #R$6E81 if #REGa is lower than #N$08.
  $6E7F,$02 #REGh=#N$48.
  $6E81,$02,b$01 Keep only bits 0-2.
  $6E83,$03 RRCA.
  $6E86,$01 #REGa+=#REGl.
  $6E87,$01 #REGl=#REGa.
  $6E88,$01 Stash #REGhl on the stack.
  $6E89,$02 Decrease #REGl by two.
  $6E8B,$03 #REGde=#R$78E0.
  $6E8E,$02 #REGc=#N$28.
  $6E90,$01 Exchange the #REGde and #REGhl registers.
  $6E91,$02 #REGb=#N$04.
  $6E93,$02 LDI.
  $6E95,$02 Decrease counter by one and loop back to #R$6E93 until counter is zero.
  $6E97,$01 #REGa=#REGe.
  $6E98,$02 #REGa-=#N$04.
  $6E9A,$01 #REGe=#REGa.
  $6E9B,$01 Increment #REGd by one.
  $6E9C,$01 Decrease #REGc by one.
  $6E9D,$02 Jump to #R$6E91 until #REGc is zero.
  $6E9F,$01 #REGa=#REGd.
  $6EA0,$02 #REGa-=#N$49.
  $6EA2,$01 #REGa-=#REGa.
  $6EA3,$02 #REGa+=#N$59.
  $6EA5,$01 #REGd=#REGa.
N $6EA8 Paint the carousel.
  $6EA6,$02 Set a counter in #REGb of #N$04 for the width of the carousel.
  $6EA8,$02 #REGa=#COLOUR$06.
@ $6EAA label=ColourCarousel_Loop
  $6EAA,$01 Write the attribute byte to the attribute buffer address in
. *#REGde.
  $6EAB,$01 Move to the next attribute buffer position.
  $6EAC,$02 Decrease the carousel width counter by one and loop back to #R$6EAA
. until all of the carousel has been painted.
  $6EAE,$01 Restore #REGhl from the stack.
N $6EAF Play the "player dead" audio.
N $6EAF #HTML(#AUDIO(dead.wav)(#INCLUDE(Dead)))
  $6EAF,$02 #REGb=#N$14 (counter; #N$14 loops).
@ $6EB1 label=Handler_PlayerDead
  $6EB1,$02 Stash #REGbc and #REGhl on the stack.
  $6EB3,$01 #REGa=#REGb.
  $6EB4,$02,b$01 Keep only bits 0-2.
  $6EB6,$02 #REGd=#N$00.
@ $6EB8 label=PlayAudioDead
  $6EB8,$02 Send to the speaker.
  $6EBA,$02,b$01 Flip the speaker (bit 4) on/ off.
  $6EBC,$01 #REGb=#REGd.
@ $6EBD label=AudioDead_Loop
  $6EBD,$02 Decrease counter by one and loop back to #R$6EBD until counter is zero.
  $6EBF,$01 Decrease #REGd by one.
  $6EC0,$02 Jump to #R$6EB8 until #REGd is zero.
  $6EC2,$02 #REGb=#N$08 (counter; height of the carousel).
@ $6EC4 label=Carousel_Loop
  $6EC4,$01 #REGa=#N$00.
  $6EC5,$02 RLD.
  $6EC7,$01 Decrease #REGl by one.
  $6EC8,$02 RLD.
  $6ECA,$01 Increment #REGl by one.
  $6ECB,$01 Set the bits from *#REGhl.
  $6ECC,$01 Write #REGa to *#REGhl.
  $6ECD,$01 Increment #REGh by one.
  $6ECE,$02 Decrease counter by one and loop back to #R$6EC4 until counter is zero.
  $6ED0,$02 Restore #REGhl and #REGbc from the stack.
  $6ED2,$02 Decrease counter by one and loop back to #R$6EB1 until counter is zero.
  $6ED4,$03 Call #R$68AD.
  $6ED7,$03 #REGa=*#R$7838.
  $6EDA,$02 Test bit 7 of #REGa.
  $6EDC,$03 #REGhl=#R$BB00.
  $6EDF,$02 #REGa=#N$80.
  $6EE1,$02 Jump to #R$6EE6 if {} is zero.
  $6EE3,$01 Decrease #REGa by one.
  $6EE4,$02 #REGl=#N$04.
  $6EE6,$03 Write #REGhl to *#R$7831.
  $6EE9,$03 #REGhl=#R$7830.
  $6EEC,$02 Write #N$03 to *#REGhl.
  $6EEE,$02 Jump to #R$6EF1 if {} is zero.
  $6EF0,$01 Increment *#REGhl by one.
  $6EF1,$02 #REGl=#N$21.
  $6EF3,$02 #REGb=#N$03.
  $6EF5,$01 Write #REGa to *#REGhl.
  $6EF6,$01 Increment #REGl by one.
  $6EF7,$02 Decrease counter by one and loop back to #R$6EF5 until counter is zero.
  $6EF9,$02 #REGb=#N$08.
  $6EFB,$02 Write #N$00 to *#REGhl.
  $6EFD,$01 Increment #REGl by one.
  $6EFE,$02 Decrease counter by one and loop back to #R$6EFB until counter is zero.
  $6F00,$02 #REGl=#N$1A.
  $6F02,$02 Write #N$01 to *#REGhl.
  $6F04,$06 Write #N($0000,$04,$04) to *#R$7814.
  $6F0A,$06 Write *#R$7836 to *#R$782E.
  $6F10,$02 Test bit 7 of #REGa.
  $6F12,$02 #REGb=#N$03.
  $6F14,$02 Jump to #R$6F17 if {} is not zero.
  $6F16,$01 Increment #REGb by one.
  $6F17,$01 #REGa=#REGh.
  $6F18,$02 #REGa-=#N$99.
  $6F1A,$02 #REGa-=#N$05.
  $6F1C,$02 Jump to #R$6F1A if {} is higher.
  $6F1E,$02 #REGa+=#N$05.
  $6F20,$01 #REGa+=#REGa.
  $6F21,$01 #REGa+=#REGa.
  $6F22,$01 Decrease #REGa by one.
  $6F23,$03 Write #REGa to *#R$7833.
  $6F26,$02 #REGa=#N$9E.
  $6F28,$02 #REGa+=#N$05.
  $6F2A,$03 Jump to #R$6F28 if #REGa is lower than #REGh.
  $6F2D,$02 #REGa-=#N$05.
  $6F2F,$01 #REGh=#REGa.
  $6F30,$03 #REGl-=#REGb.
  $6F33,$02 Jump to #R$6F39 if {} is higher.
  $6F35,$04 #REGh-=#N$05.
  $6F39,$01 #REGa=#N$00.
  $6F3A,$03 Call #R$6800.
  $6F3D,$03 Call #R$7552.
  $6F40,$03 Call #R$6D17.

u $6F43

c $6F4A Handler: Hit Wall
@ $6F4A label=Handler_HitWall
  $6F4A,$03 #REGhl=#R$BC80.
  $6F4D,$07 Jump to #R$6F56 if *#R$7822 is higher than #N$80 (i.e. moving right).
  $6F54,$02 #REGl=#N$8F.
@ $6F56 label=HitWallMovingRight
  $6F56,$03 Write #REGhl to *#R$783A.
  $6F59,$05 Write #N$04 to *#R$782A.
  $6F5E,$01 Return.

u $6F5F

c $6F62
  $6F62,$03 Write #REGhl to *#R$782E.
  $6F65,$01 #REGc=#REGa.
  $6F66,$01 #REGa=*#REGhl.
  $6F67,$01 Decrease #REGa by one.
  $6F68,$02 Jump to #R$6F72 if #REGa is zero.
  $6F6A,$04 Jump to #R$6F7B if #REGa is lower than #N$29.
  $6F6E,$04 Jump to #R$6F7B if #REGa is higher than #N$31.
  $6F72,$03 Write #REGhl to *#R$7836.
  $6F75,$06 Write *#R$7822 to *#R$7838.
  $6F7B,$01 #REGa=#REGc.
  $6F7C,$01 Return.

c $6F7D Handler: Hit Hump
@ $6F7D label=Handler_HitHump
  $6F7D,$03 #REGa=*#R$7834.
N $6F80 #TABLE(default,centre,centre,centre,centre)
. { =h Direction | =h Wheelie Range | =h Byte | =h Bits }
. { =r4 Left | =h Normal (no wheelie) | #N$48 | #EVAL($48,$02,$08) }
. { =h Mid-Low | #N$49 | #EVAL($49,$02,$08) }
. { =h Mid-High | #N$4A | #EVAL($4A,$02,$08) }
. { =h Max (full wheelie) | #N$4B | #EVAL($4B,$02,$08) }
. { =r4 Right | =h Normal (no wheelie) | #N$08 | #EVAL($08,$02,$08) }
. { =h Mid-Low | #N$09 | #EVAL($09,$02,$08) }
. { =h Mid-High | #N$0A | #EVAL($0A,$02,$08) }
. { =h Max (full wheelie) | #N$0B | #EVAL($0B,$02,$08) }
. TABLE#
  $6F80,$02,b$01 Keep only bits 0-2.
  $6F82,$01 Return if the result is not zero.
  $6F83,$05 Write #N$05 to *#R$782A.
  $6F88,$03 #REGa=*#R$7834.
  $6F8B,$02,b$01 Keep only the direction bit (bit 6).
  $6F8D,$03 #REGhl=#R$BD0E.
  $6F90,$02 Jump to #R$6F94 if the player is moving right.
  $6F92,$02 #REGl=#N$21.
@ $6F94 label=HitHumpMovingRight
  $6F94,$03 Write #REGhl to *#R$783A.
  $6F97,$01 Return.

u $6F98

c $6F99 Handler: Ice
@ $6F99 label=Handler_Ice
N $6F99 If you hit ice too fast the bike will slide (crash) and you fall off.
N $6F99 The parameters are; #TABLE(default,centre,centre,centre,centre)
. { =h,r2 Direction | =h,c2 Bike Range | =h,r2 Crash Point }
. { =h Lowest | =h Highest }
. { Left | #N$69 | #N$7F | < #N$6F }
. { Right | #N$80 | #N$96 | > #N$90 }
. TABLE#
  $6F99,$03 #REGa=*#R$7822.
  $6F9C,$04 Jump to #R$6FAA if #REGa is higher than #N$90.
  $6FA0,$04 Jump to #R$6FAA if #REGa is lower than #N$6F.
  $6FA4,$03 #REGa=*#R$7828.
  $6FA7,$02,b$01 Keep only bits 0-1.
  $6FA9,$01 Return if the result is zero.
@ $6FAA label=Initialise_CrashIce
  $6FAA,$05 Write #N$06 to *#R$782A.
  $6FAF,$03 #REGhl=#R$BDB8.
  $6FB2,$07 Jump to #R$6FBB if *#R$7822 is higher than #N$80 (i.e. moving right).
  $6FB9,$02 #REGl=#N$C7.
@ $6FBB label=CrashIceMovingRight
  $6FBB,$03 Write #REGhl to *#R$783A.
  $6FBE,$01 Return.

u $6FBF

c $6FC0 Handler: Jumps
@ $6FC0 label=Handler_Jumps
N $6FC0 If you hit a jump too fast or too slow the bike will crash.
  $6FC0,$03 #REGde=#N($0000,$04,$04).
  $6FC3,$03 #REGa=*#R$7822.
N $6FC6 Check if the speed was too fast.
N $6FC6 The parameters are quite wide; #TABLE(default,centre,centre,centre,centre)
. { =h,r2 Direction | =h,c2 Bike Range | =h,r2 Crash Point }
. { =h Lowest | =h Highest }
. { Left | #N$69 | #N$7F | < #N$6A }
. { Right | #N$80 | #N$96 | > #N$96 }
. TABLE#
  $6FC6,$04 Jump to #R$6FDE if #REGa is higher than #N$96.
  $6FCA,$02 #REGe=#N$42.
  $6FCC,$04 Jump to #R$6FDE if #REGa is lower than #N$6A.
  $6FD0,$02 #REGe=#N$23.
N $6FD2 Check if the speed was too slow.
N $6FD2 The parameters are again, quite wide; #TABLE(default,centre,centre,centre,centre)
. { =h,r2 Direction | =h,c2 Bike Range | =h,r2 Crash Point }
. { =h Lowest | =h Highest }
. { Left | #N$69 | #N$7F | > #N$70 }
. { Right | #N$80 | #N$96 | < #N$90 }
. TABLE#
  $6FD2,$03 Return if #REGa is higher than #N$90.
  $6FD5,$03 Return if #REGa is lower than #N$70.
  $6FD8,$04 Jump to #R$6FDE if *#R$7822 is higher than #N$80 (i.e. moving right).
  $6FDC,$02 #REGe=#N$65.
@ $6FDE label=Initialise_CrashJumpTooFast
  $6FDE,$01 Rotate the direction bit into the carry flag.
  $6FDF,$03 #REGhl=*#R$782E.
  $6FE2,$02 Jump to #R$6FE6 if the player is moving right.
  $6FE4,$02 Decrease #REGl by two.
@ $6FE6 label=CrashJumpTooFastMovingRight
  $6FE6,$01 Increment #REGl by one.
  $6FE7,$01 #REGa=*#REGhl.
  $6FE8,$03 #REGhl=#R$BD34.
  $6FEB,$04 Jump to #R$6FF2 if #REGa is lower than #N$43.
  $6FEF,$03 #REGhl=#R$C400.
  $6FF2,$01 #REGhl+=#REGde.
  $6FF3,$03 Write #REGhl to *#R$783A.
  $6FF6,$05 Write #N$04 to *#R$782A.
  $6FFB,$01 Return.

u $6FFC

c $6FFD Handler: Downhill
@ $6FFD label=Handler_Downhill
N $6FFD If you hit a downhill too fast the bike will launch (crash) and you fall off.
N $6FFD The parameters are quite wide though; #TABLE(default,centre,centre,centre,centre)
. { =h,r2 Direction | =h,c2 Bike Range | =h,r2 Crash Point }
. { =h Lowest | =h Highest }
. { Left | #N$69 | #N$7F | < #N$6A }
. { Right | #N$80 | #N$96 | > #N$96 }
. TABLE#
  $6FFD,$03 #REGa=*#R$7822.
  $7000,$04 Jump to #R$7007 if the players speed is higher than or equal to #N$96.
  $7004,$03 Return if #REGa is higher than #N$6A.
@ $7007 label=Initialise_CrashDownhill
  $7007,$03 #REGhl=#R$BC9E.
  $700A,$04 #REGde=*#R$782E.
  $700E,$01 Increment #REGd by one.
  $700F,$01 Store speed in #REGb temporarily.
  $7010,$05 Write #N$03 to *#R$782A.
  $7015,$01 Restore the current speed back to #REGa.
  $7016,$01 RLCA.
  $7017,$02 Jump to #R$702D if #REGa is higher.
  $7019,$01 Increment #REGe by one.
  $701A,$02 Jump to #R$7020 if #REGe is not zero.
  $701C,$04 #REGd+=#N$05.
  $7020,$01 #REGa=*#REGde.
  $7021,$04 Jump to #R$7029 if #REGa is equal to #N$0B.
  $7025,$04 Jump to #R$7043 if #REGa is not equal to #N$1E.
  $7029,$02 #REGl=#N$B3.
  $702B,$02 Jump to #R$7043.
  $702D,$02 #REGl=#N$D6.
  $702F,$01 #REGa=#REGe.
  $7030,$01 Decrease #REGe by one.
  $7031,$03 Jump to #R$7038 if #REGa is not zero.
  $7034,$04 #REGd-=#N$05.
  $7038,$01 #REGa=*#REGde.
  $7039,$04 Jump to #R$7041 if #REGa is equal to #N$0A.
  $703D,$04 Jump to #R$7043 if #REGa is not equal to #N$1F.
  $7041,$02 #REGl=#N$EB.
  $7043,$03 Write #REGhl to *#R$783A.
  $7046,$01 Return.

u $7047

c $7048 Handler: Refuel
@ $7048 label=Handler_Refuel
  $7048,$03 #REGhl=*#R$782E.
  $704B,$02 Write #N$2E to *#REGhl.
  $704D,$03 #REGa=*#R$7833.
  $7050,$02 Compare #REGa with #N$08.
  $7052,$02 #REGh=#N$42.
  $7054,$02 Jump to #R$7058 if #REGa was lower than #N$08 (on line #R$7050).
  $7056,$02 #REGh=#N$4A.
  $7058,$01 Decrease #REGa by one.
  $7059,$02,b$01 Keep only bits 1-2.
  $705B,$03 RRCA.
  $705E,$02 #REGa+=#N$0D.
  $7060,$01 #REGl=#REGa.
  $7061,$02 #REGc=#N$03.
  $7063,$02 #REGe=#N$02.
  $7065,$02 #REGb=#N$06.
  $7067,$02 Write #N$00 to *#REGhl.
  $7069,$01 Increment #REGl by one.
  $706A,$02 Decrease counter by one and loop back to #R$7068 until counter is zero.
  $706C,$04 #REGl-=#N$06.
  $7070,$02 Increment #REGh by two.
  $7072,$01 Decrease #REGc by one.
  $7073,$02 Jump to #R$7065 until #REGc is zero.
  $7075,$02 #REGa+=#N$20.
  $7077,$01 #REGl=#REGa.
  $7078,$01 #REGa=#REGh.
  $7079,$02 #REGa-=#N$08.
  $707B,$01 #REGh=#REGa.
  $707C,$01 #REGc=#REGe.
  $707D,$01 Decrease #REGe by one.
  $707E,$02 Jump to #R$7065 until #REGe is zero.
  $7080,$06 Write #N$3400 to *#R$783C.
  $7086,$01 Return.

u $7087

c $7088 Contextual Random Number
@ $7088 label=ContextualRandomNumber
R $7088 H Seed value
R $7088 O:A Random number betwen #N$00-#N$FF
  $7088,$03 Call #R$6400.
  $708B,$01 #REGe=#REGa.
M $7088,$04 #REGe=random number between #N$00-#N$FF.
  $708C,$01 Get the seed number.
@ $708D label=CheckSeedNumber
  $708D,$04 Jump to #R$709B if the seed number in #REGh is lower than #N$9F.
  $7091,$02 Jump to #R$7097 if the seed number in #REGh is equal to #N$9F.
N $7093 Else, subtract #N$05 and loop back to try again.
  $7093,$02 Subtract #N$05 from the seed number.
  $7095,$02 Jump back to #R$708D.
N $7097 Return either #N$00 or #N$01 using bit 0 of the random number.
@ $7097 label=ReturnBoolean
  $7097,$01 #REGa=#REGe.
  $7098,$02,b$01 Keep only bit 0.
M $7097,$03 #REGa=bit 0 of the random number stored in #REGe (ensure it is
. either #N$00 or #N$01).
  $709A,$01 Return.
N $709B Just return the full random number between #N$00-#N$FF.
@ $709B label=ReturnFullValue
  $709B,$01 #REGa=the random number stored in #REGe.
  $709C,$01 Return.

c $709D

c $7161 Check Demo Mode
@ $7161 label=Check_DemoMode
  $7161,$03 Call #R$7535.
  $7164,$03 Jump to #R$6ED4.

u $7167

c $716E

u $71F8

c $7200 Initialise New Level
@ $7200 label=InitialiseNewLevel
  $7200,$03 #REGhl=#R$7820.
  $7203,$05 Jump to #R$720A if the current level is equal to #N$07. After level #N$07 the game just repeats this level.
N $7208 Increments both #R$7820 and #REGa as we use this as an offset for pointing to the level data.
  $7208,$01 Increment *#REGhl by one.
  $7209,$01 Increment #REGa by one.
N $720A #TABLE(default,centre,centre)
. { =h Level | =h Data }
. { #N$00 | #R$E600 }
. { #N$01 | #R$E640 }
. { #N$02 | #R$E680 }
. { #N$03 | #R$E6C0 }
. { #N$04 | #R$E700 }
. { #N$05 | #R$E740 }
. { #N$06 | #R$E780 }
. { #N$07 | #R$E7C0 }
. TABLE#
@ $720A label=InitialiseLevelTodo
  $720A,$02 Rotate #REGa right two positions (bits 2 to 5 are now in positions 0 to 3) using the carry flag.
  $720C,$01 #REGl=#REGa.
  $720D,$02,b$01 Keep only bits 0-1.
  $720F,$02 #REGa+=#N$E6.
  $7211,$01 #REGh=#REGa.
  $7212,$01 #REGa=#REGl.
  $7213,$02,b$01 Keep only bits 6-7.
  $7215,$01 #REGl=#REGa.
  $7216,$02 #REGa=#N$0A (counter).
  $7218,$01 No operation.
  $7219,$03 #REGde=#R$FA40.
  $721C,$01 Stash #REGhl on the stack.
  $721D,$03 #REGbc=#N($0040,$04,$04).
  $7220,$02 Copy #N($0040,$04,$04) bytes of data from *#REGhl to *#REGde.
  $7222,$01 Restore #REGhl from the stack.
  $7223,$01 Decrease #REGa by one.
  $7224,$02 Jump to #R$721C until #REGa is zero.
  $7226,$01 #REGh=#REGa.
  $7227,$02 #REGb=#N$08.
  $7229,$01 #REGl=#REGb.
  $722A,$01 Exchange the #REGde and #REGhl registers.
  $722B,$01 Write #REGh to *#REGhl.
  $722C,$01 #REGhl+=#REGde.
  $722D,$02 Decrease counter by one and loop back to #R$722B until counter is zero.
  $722F,$01 #REGb=#REGe.
  $7230,$02 #REGh=#N$FA.
  $7232,$01 Write #REGh to *#REGhl.
  $7233,$01 #REGhl+=#REGde.
  $7234,$02 Decrease counter by one and loop back to #R$7232 until counter is zero.
  $7236,$01 #REGb=#REGe.
  $7237,$02 #REGe=#N$10.
  $7239,$01 Write #REGh to *#REGhl.
  $723A,$01 #REGhl+=#REGde.
  $723B,$02 Decrease counter by one and loop back to #R$7239 until counter is zero.
  $723D,$01 Switch to the shadow registers.
  $723E,$03 #REGbc'=#N$FA46.
  $7241,$01 Switch back to the normal registers.
  $7242,$03 #REGde=#R$9F20.
  $7245,$02 #REGb=#N$0A.
  $7247,$01 Stash #REGbc on the stack.
  $7248,$02 #REGb=#N$08.
  $724A,$03 Call #R$6400.
  $724D,$02,b$01 Keep only bits 0-4.
M $724A,$05 #REGa=random number between #N$00-#N$1F.
  $724F,$04 Jump to #R$724A if #REGa is equal to #N$1F.
  $7253,$04 Jump to #R$724A if #REGa is lower than #N$08.
  $7257,$01 #REGl=#REGa.
  $7258,$03 Call #R$6400.
  $725B,$02,b$01 Keep only bits 0-1.
  $725D,$01 #REGh=#REGa.
M $7258,$06 #REGh=random number between #N$00-#N$03.
  $725E,$01 #REGhl+=#REGde.
  $725F,$01 #REGa=*#REGhl.
  $7260,$01 Decrease #REGa by one.
  $7261,$02 Jump to #R$726B if #REGa is zero.
  $7263,$04 Jump to #R$724A if #REGa is higher than #N$31.
  $7267,$04 Jump to #R$724A if #REGa is lower than #N$2D.
  $726B,$01 Stash #REGhl on the stack.
  $726C,$01 Switch to the shadow registers.
  $726D,$01 #REGh=#REGb.
  $726E,$01 #REGl=#REGc.
  $726F,$01 Restore #REGde from the stack.
  $7270,$01 #REGa=*#REGhl.
  $7271,$03 Jump to #R$7284 if #REGa is zero.
  $7274,$01 Increment #REGl by one.
  $7275,$03 Jump to #R$727E if #REGa is not equal to #REGe.
  $7278,$01 #REGa=*#REGhl.
  $7279,$01 Compare #REGa with #REGd.
  $727A,$01 Switch to the shadow registers.
  $727B,$02 Jump to #R$724A if {} is zero.
  $727D,$01 Switch to the shadow registers.
  $727E,$04 #REGl+=#N$07.
  $7282,$02 Jump to #R$7270.
  $7284,$01 Write #REGe to *#REGhl.
  $7285,$01 Increment #REGl by one.
  $7286,$01 Write #REGd to *#REGhl.
  $7287,$01 Switch to the shadow registers.
  $7288,$02 Decrease counter by one and loop back to #R$724A until counter is zero.
  $728A,$01 Switch to the shadow registers.
  $728B,$03 #REGhl=#N($0040,$04,$04).
  $728E,$01 #REGhl+=#REGbc.
  $728F,$01 #REGb=#REGh.
  $7290,$01 #REGc=#REGl.
  $7291,$01 Switch to the shadow registers.
  $7292,$04 #REGe+=#N$20.
  $7296,$02 Jump to #R$729C if #REGe is not zero.
  $7298,$04 #REGd+=#N$05.
  $729C,$01 Restore #REGbc from the stack.
  $729D,$02 Decrease counter by one and loop back to #R$7247 until counter is zero.
  $729F,$03 Call #R$74DC.
  $72A2,$03 #REGhl=#N$3280.
N $72A5 See #R$E800.
  $72A5,$07 Jump to #R$72AE if the game is in "demo mode" (the high-order byte of #R$782C contains #R$73B7(#N$73)).
  $72AC,$02 #REGh=#N$0B.
@ $72AE label=InitialiseNewLevel_InDemoMode
  $72AE,$02 No operation.
  $72B0,$03 Write #REGhl to *#R$7841.
  $72B3,$04 Write #N$00 to *#R$7840.
  $72B7,$03 Jump to #R$7396.

u $72BA

c $72C3
  $72C3,$06 Jump to #R$72E2 if *#R$7840 is zero.
  $72C9,$03 #REGhl=#R$7843.
  $72CC,$01 Decrease *#REGhl by one.
  $72CD,$02 Jump to #R$72E2 if *#REGhl is not zero.
  $72CF,$02 Write #N$03 to *#REGhl.
  $72D1,$03 #REGhl=*#R$7841.
  $72D4,$01 Decrease #REGhl by one.
  $72D5,$03 Write #REGhl to *#R$7841.
  $72D8,$04 Jump to #R$72E2 if #REGh is not zero.
  $72DC,$06 Call #R$77E0 if #REGl is equal to #N$80.
  $72E2,$03 #REGhl=*#R$7817.
  $72E5,$01 #REGa=#REGh.
  $72E6,$02 #REGa-=#N$99.
  $72E8,$02 #REGb=#N$FE.
  $72EA,$02 Increment #REGb by two.
  $72EC,$02 #REGa-=#N$05.
  $72EE,$02 Jump to #R$72EA if #REGa is not zero.
  $72F0,$01 #REGa=#REGl.
  $72F1,$02,b$01 Keep only bits 5-7.
  $72F3,$01 #REGa+=#REGa.
  $72F4,$01 #REGl=#REGa.
  $72F5,$01 #REGa+=#REGb.
  $72F6,$01 #REGa-=#REGl.
  $72F7,$02 #REGa+=#N$FA.
  $72F9,$01 #REGh=#REGa.
  $72FA,$03 Call #R$E84D.
  $72FD,$02 #REGb=#N$08.
  $72FF,$02 Stash #REGhl and #REGbc on the stack.
  $7301,$03 Call #R$709D.
  $7304,$02 Restore #REGbc and #REGhl from the stack.
  $7306,$03 #REGde=#N($0008,$04,$04).
  $7309,$01 #REGhl+=#REGde.
  $730A,$02 Decrease counter by one and loop back to #R$72FF until counter is zero.
  $730C,$01 Return.

u $730D

c $7311
  $7311,$03 Call #R$6B2D.
  $7314,$03 Call #R$716E.
  $7317,$03 #REGhl=*#R$7817.
  $731A,$01 #REGa=#REGl.
  $731B,$03 RLCA.
  $731E,$01 #REGl=#REGa.
  $731F,$02,b$01 Keep only bits 0-2.
  $7321,$01 #REGb=#REGa.
  $7322,$01 #REGa=#REGl.
  $7323,$02,b$01 Keep only bits 3-7.
  $7325,$01 #REGl=#REGa.
  $7326,$03 #REGa=*#R$7819.
  $7329,$01 #REGa+=#REGl.
  $732A,$01 #REGl=#REGa.
  $732B,$01 #REGa=#REGh.
  $732C,$02 #REGh=#N$F8.
  $732E,$03 #REGde=#N$0800.
  $7331,$02 #REGa-=#N$99.
  $7333,$01 #REGhl+=#REGde.
  $7334,$02 #REGa-=#N$05.
  $7336,$02 Jump to #R$7333 if #REGa is not zero.
  $7338,$01 #REGa=#REGh.
  $7339,$01 #REGa+=#REGb.
  $733A,$01 #REGh=#REGa.
  $733B,$01 Stash #REGhl on the stack.
  $733C,$03 #REGde=#N($0008,$04,$04).
  $733F,$02 #REGhl-=#REGde (with carry).
  $7341,$01 Exchange the #REGde and #REGhl registers.
  $7342,$03 #REGhl=*#R$7841.
  $7345,$02 #REGhl-=#REGde (with carry).
  $7347,$04 Jump to #R$736C if #REGh is not zero.
  $734B,$01 #REGa=#REGl.
  $734C,$04 Jump to #R$736C if #REGa is higher than #N$50.
  $7350,$02 #REGa-=#N$08.
  $7352,$02
  $7354,$02 #REGc=#COLOUR$44.
  $7356,$01 #REGe=#REGa.
  $7357,$02 #REGd=#N$0B.
  $7359,$02 #REGa=#N$00.
  $735B,$02
  $735D,$03 Call #R$76D7.
  $7360,$07 Jump to #R$736C if *#R$7825 is not equal to #N$44.
  $7367,$05 Write #N$01 to *#R$7840.
  $736C,$01 Restore #REGhl from the stack.
  $736D,$05 Return if *#R$7840 is zero.
  $7372,$03 Return if #REGh is not zero.
  $7375,$04 Return if #REGl is higher than #N$80.
  $7379,$02 #REGa=#N$80.
  $737B,$01 #REGa-=#REGl.
  $737C,$05 No operation.
  $7381,$02 #REGc=#N$47.
  $7383,$02 #REGd=#N$0B.
  $7385,$02
  $7387,$01 #REGe=#REGa.
  $7388,$02 #REGa=#N$40.
  $738A,$02
  $738C,$03 Call #R$76D7.
  $738F,$01 Return.

u $7390

c $7396
  $7396,$03 #REGhl=#R$FA47.
  $7399,$02 #REGb=#N$50.
  $739B,$01 #REGa=*#REGhl.
  $739C,$02 Decrease #REGl by two.
  $739E,$02 #REGa-=#N$9A.
  $73A0,$02 #REGa-=#N$05.
  $73A2,$02 Jump to #R$73A0 if {} is higher.
  $73A4,$02 #REGa+=#N$06.
  $73A6,$04 Jump to #R$73AF if #REGa is equal to #N$05.
  $73AA,$01 #REGa+=#REGa.
  $73AB,$01 #REGa+=#REGa.
  $73AC,$01 Decrease #REGa by one.
  $73AD,$01 #REGa+=*#REGhl.
  $73AE,$01 Write #REGa to *#REGhl.
  $73AF,$03 #REGde=#N($000A,$04,$04).
  $73B2,$01 #REGhl+=#REGde.
  $73B3,$02 Decrease counter by one and loop back to #R$739B until counter is zero.
  $73B5,$01 Return.

u $73B6

c $73B7 Demo Mode Input
@ $73B7 label=DemoModeInput
D $73B7 Input method; used by the routine at #R$6B48.
N $73B7 In demo mode, we never let the game run out of fuel or lives.
  $73B7,$05 Write #N$04 to *#R$7839.
  $73BC,$06 Write #N$3400 to *#R$783C.
  $73C2,$03 Call #R$6828.
  $73C5,$03 Jump to #R$73D1 if no keys are being pressed.
  $73C8,$06 No operation.
N $73CE Any input jumps back to the start screen.
  $73CE,$03 Jump to #R$E81B.
N $73D1 Randomly send controls for the game.
@ $73D1 label=DemoModeControls
  $73D1,$03 Call #R$6400.
  $73D4,$02,b$01 Keep only bits 2-3.
  $73D6,$02 Jump to #R$73D1 if the result is zero.
M $73D4,$04 Ensure the random number is either #N$04#RAW(,) #N$08 or #N$0C.
  $73D8,$02,b$01 Flip bits 2-3 so #N$04 becomes #N$08#RAW(,) #N$08 becomes #N$04 and #N$0C becomes #N$00.
  $73DA,$03 #REGhl=*#R$7831.
  $73DD,$03 Increment #REGl by three.
  $73E0,$01 #REGd=#REGa.
  $73E1,$03 #REGa=*#R$7822.
  $73E4,$01 Compare #REGa with *#REGhl.
  $73E5,$02 #REGa=#N$00.
  $73E7,$02 Jump to #R$73EF if #REGa was equal to *#REGhl on line #R$73E4.
  $73E9,$02 Jump to #R$73ED if #REGa was lower than *#REGhl on line #R$73E4.
  $73EB,$02 #REGa=#N$03.
  $73ED,$02,b$01 Flip bits 0.
  $73EF,$01 Set the bits from #REGd.
  $73F0,$01 Return.

u $73F1

c $73F2
  $73F2,$03 #REGa=*#R$7825.
  $73F5,$02 Return if #REGa is not zero.
  $73F7,$03 #REGhl=#R$FFF8.
  $73FA,$01 #REGhl+=#REGbc.
  $73FB,$01 Switch to the shadow registers.
  $73FC,$04 #REGl'-=#N$07.
  $7400,$01 #REGa-=#REGa.
  $7401,$01 #REGa+=#REGh'.
  $7402,$01 #REGh'=#REGa.
  $7403,$03 #REGde'=#N$0400.
  $7406,$01 #REGa=*#REGhl'.
  $7407,$01 Switch back to the normal registers.
  $7408,$01 Set the bits from *#REGhl.
  $7409,$01 Flip the bits according to *#REGhl.
  $740A,$02 Increment #REGhl by two.
  $740C,$01 Switch to the shadow registers.
  $740D,$03 Jump to #R$7411 if #REGa is equal to *#REGhl'.
  $7410,$01 Increment #REGe' by one.
  $7411,$01 Increment #REGhl' by one.
  $7412,$01 Decrease #REGd' by one.
  $7413,$02 Jump to #R$7406 if #REGd' is not zero.
  $7415,$03 Increment #REGhl' by three.
  $7418,$01 #REGa=#REGe'.
  $7419,$03 Write #REGa to *#R$7825.
  $741C,$01 Switch back to the normal registers.
  $741D,$01 Return.

u $741E

c $7420 Update Score Display
@ $7420 label=UpdateScoreDisplay
N $7420 Convert the 16-bit into a five digit score using two's complement.
  $7420,$03 #REGhl=*#R$7844.
  $7423,$04 #REGde=*#R$7846.
  $7427,$04 Return if the players score is the same as the stored highscore.
  $742B,$01 Restore the original players score value.
@ $742C label=ForceScoreUpdate
  $742C,$03 Update the stored *#R$7846 value.
  $742F,$01 Switch to the shadow registers.
  $7430,$03 Set the screen buffer position for the score display.
  $7433,$01 Switch back to the normal registers.
@ $7434 label=ConvertScoreToDigits
  $7434,$03 #REGde=#R$784B.
N $7437 Convert the binary score to decimal using the repeated subtraction
. method.
N $7437 Calculate the tens of thousands digit.
  $7437,$03 #REGbc=-10,000 (it's technically -10,224 which is probably a
. mistake).
  $743A,$02 Set the digit counter in #REGa to -01.
@ $743C label=ExtractTenThousands_Loop
  $743C,$01 Increment the digit counter by one.
  $743D,$01 Subtract 10,000 from the score.
  $743E,$02 Jump back to #R$743C if the result is still positive.
  $7440,$02 Restore the valid remainder.
  $7442,$01 Store the count to the score buffer in *#REGde.
  $7443,$01 Move to the next score digit position.
N $7444 Calculate the thousands digit.
  $7444,$03 #REGbc=-1,000.
  $7447,$02 Set the digit counter in #REGa to -01.
@ $7449 label=ExtractThousands_Loop
  $7449,$01 Increment the digit counter by one.
  $744A,$01 Subtract 1,000 from the score remainder.
  $744B,$02 Jump back to #R$7449 if the result is still positive.
  $744D,$02 Restore the valid remainder.
  $744F,$01 Store the count to the score buffer in *#REGde.
  $7450,$01 Move to the next score digit position.
N $7451 Calculate the hundreds digit.
  $7451,$03 #REGbc=-100.
  $7454,$02 Set the digit counter in #REGa to -01.
@ $7456 label=ExtractHundreds_Loop
  $7456,$01 Increment the digit counter by one.
  $7457,$01 Subtract 100 from the score remainder.
  $7458,$02 Jump back to #R$7456 if the result is still positive.
  $745A,$02 Restore the valid remainder.
  $745C,$01 Store the count to the score buffer in *#REGde.
  $745D,$01 Move to the next score digit position.
N $745E Calculate the tens digit.
  $745E,$02 #REGc=-10.
  $7460,$02 Set the digit counter in #REGa to -01.
@ $7462 label=ExtractTens_Loop
  $7462,$01 Increment the digit counter by one.
  $7463,$01 Subtract 10 from the score remainder.
  $7464,$02 Jump back to #R$7462 if the result is still positive.
  $7466,$01 Store the count to the score buffer in *#REGde.
  $7467,$01 Move to the next score digit position.
N $7468 Store the units digit.
  $7468,$01 Get the final remainder.
  $7469,$02 Compensate for the last subtraction.
  $746B,$01 Store the result to the score buffer in *#REGde.
  $746C,$01 Switch to the shadow registers.
  $746D,$03 #REGbc'=#R$784B.
N $7470 #HTML(Work out the ZX Spectrum ROM location of the number UDG, e.g. "1" would be
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html#3d89">#N$3D89</a>.)
N $7470 This calculation avoids the whitespace at the top and bottom of the ROM UDG; in the code below you'll see it
. only copies six bytes/ lines.
@ $7470 label=PrintScoreDigit_Loop
  $7470,$01 Fetch the score digit value.
N $7471 Calculate the ZX Spectrum ROM font address:
. #N$3D00 + (digit * #N$08) + #N$01.
  $7471,$06 #REGl'=#N$81+(#REGa*#N$08).
  $7477,$02 #HTML(#REGh'=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html">#N$3D</a>.)
N $7479 Copy #N$06 lines of font character data (skipping top and bottom whitespace).
  $7479,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $747B,$01 Move to the next font line.
  $747C,$01 Move down one row in the screen buffer.
  $747D,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $747F,$01 Move to the next font line.
  $7480,$01 Move down one row in the screen buffer.
  $7481,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $7483,$01 Move to the next font line.
  $7484,$01 Move down one row in the screen buffer.
  $7485,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $7487,$01 Move to the next font line.
  $7488,$01 Move down one row in the screen buffer.
  $7489,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $748B,$01 Move to the next font line.
  $748C,$01 Move down one row in the screen buffer.
  $748D,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
N $748F Reset the screen buffer position.
  $748F,$02 #REGd'=#N$51.
  $7491,$01 Move right one character block in the screen buffer, ready to print the next number.
  $7492,$01 Move to the next digit in the score display buffer.
  $7493,$04 Jump back to #R$7470 until all the digits have been printed.
  $7497,$01 Switch back to the normal registers.
  $7498,$01 Return.

u $7499

c $749C Clear Screen
@ $749C label=ClearScreen
  $749C,$03 #REGhl=#R$4000(#N$4000) (screen buffer location).
  $749F,$01 Write #N$00 to *#REGhl.
  $74A0,$03 #REGbc=#N$1B00.
  $74A3,$03 #REGde=#REGhl+#N$01.
  $74A6,$02 Copy #N$00 across both the screen and attribute buffers.
  $74A8,$01 Return.

u $74A9

c $74AA Print Graphic
@ $74AA label=PrintGraphic
R $74AA L The low-order byte to point to a UDG address
N $74AA Set the high-order byte value for the UDG address.
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

u $74C2

c $74C3 Print Footer Colour String
@ $74C3 label=PrintFooterColourString
N $74C3 Given an attribute value and a pointer to a string of #N$20 bytes, this routine will print a string to the
.       footer of the screen buffer using the given attribute colour.
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

u $74DB

c $74DC Print Level Name
@ $74DC label=PrintLevelName
D $74DC #UDGTABLE(default,centre) { #PUSHS #SIM(start=$75AA,stop=$7638)#SIM(start=$74DC,stop=$7518) #SCR$02(game) #POPS } UDGTABLE#
N $74DC This looks confusing but it's basically #REGhl=#N$BBA0+(level*#N$1C).
N $74DC #TABLE(default,centre,centre,centre,centre)
. { =h Level | =h Address | =h Attribute | =h Name }
. #FOR$00,$07,(n,{ #Nn | #R($BBA0+n*$1C)(#N($BBA0+n*$1C)) | #COLOUR(#PEEK($BBA0+n*$1C)) | #HTML(#STR($BBA1+n*$1C,$04,$09)<br />#STR($BBAA+n*$1C,$04,$09)<br />#STR($BBB3+n*$1C,$04,$09)) }, )
. TABLE#
  $74DC,$03 #REGa=*#R$7820.
  $74DF,$02 #REGa*=#N$04.
  $74E1,$01 #REGl=#REGa (level*#N$04).
  $74E2,$01 #REGa*=#N$02.
  $74E3,$01 #REGh=#REGa (level*#N$08).
  $74E4,$06 #REGl=#N$A0+#REGh+#REGl+(level*#N$10).
  $74EA,$05 #REGh=#N$BB+carry.
  $74EF,$03 #REGde=#N$5A57 (attribute buffer location).
  $74F2,$02 #REGc=#N$03 (counter; three lines).
@ $74F4 label=LevelName_ColourLineLoop
  $74F4,$01 #REGa=*#REGhl.
  $74F5,$02 #REGb=#N$09 (counter; length of each line).
@ $74F7 label=LevelName_ColourLoop
  $74F7,$01 Write #REGa to *#REGde.
  $74F8,$01 Increment #REGe by one.
  $74F9,$02 Decrease counter by one and loop back to #R$74F7 until counter is zero.
N $74FB Move down one line (and reset the position - #N$09+#N$17=#N$20).
  $74FB,$04 #REGe+=#N$17.
  $74FF,$01 Decrease #REGc by one.
  $7500,$02 Jump to #R$74F4 until #REGc is zero.
  $7502,$01 Increment #REGl by one.
  $7503,$01 Switch to the shadow registers.
  $7504,$03 #REGde'=#N$5057 (screen buffer location).
  $7507,$01 Switch back to the normal registers.
  $7508,$02 #REGc=#N$03 (counter; three lines).
@ $750A label=PrintLevelName_Loop
  $750A,$02 #REGb=#N$09 (counter; length of each line).
  $750C,$03 Call #R$74D3.
N $750F Move down one line (and reset the position - #N$09+#N$17=#N$20).
  $750F,$01 Switch to the shadow registers.
  $7510,$04 #REGe'+=#N$17.
  $7514,$01 Switch back to the normal registers.
N $7515 Have we printed all three lines of the level name yet?
  $7515,$01 Decrease #REGc by one.
  $7516,$02 Jump to #R$750A until #REGc is zero.
  $7518,$01 Return.

u $7519

c $751A Handler: Hump Jump
@ $751A label=Handler_HumpJump
  $751A,$03 #REGhl=*#R$782E.
  $751D,$03 #REGde=#N($0011,$04,$04).
  $7520,$01 #REGa=*#REGhl.
  $7521,$04 Jump to #R$752D if #REGa is lower than #N$28.
  $7525,$02 Compare #REGa with #N$46.
  $7527,$02 Alter awarded score to #N($0008,$04,$04).
  $7529,$02 Jump to #R$752D if #REGa was higher than #N$46 (on line #R$7525).
  $752B,$02 Alter awarded score to #N($0001,$04,$04).
N $752D Award the score.
@ $752D label=HumpJumpAwardScore
  $752D,$04 #REGhl=*#R$7844+#REGde.
  $7531,$03 Write #REGhl to *#R$7844.
  $7534,$01 Return.

c $7535 Print "Demo Mode"
@ $7535 label=PrintDemoMode
N $7535 See #R$E800.
  $7535,$07 Jump to #R$7544 if the game is not in "demo mode" (the high-order byte of #R$782C does not contain #R$73B7(#N$73)).
N $753C Print the "#STR($BA66,$03,$20)" messaging in the footer.
N $753C #HTML(#FONT:(DEMO MODE-PRESS A KEY TO PLAY)$3D00,attr=$82(demo-mode))
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

c $754F Initialise New Game
@ $754F label=InitialiseNewGame
  $754F,$03 Call #R$7535.
N $7552 "Spend" a life to continue, or move to Game Over.
@ $7552 label=SpendLife
  $7552,$04 Decrease *#R$7839 by one.
N $7556 Compare the players current lives with the maximum number of lives (#N$04).
  $7556,$01 #REGc=*#R$7839.
  $7557,$02 #REGa=#N$04 (the maximum number of lives).
  $7559,$01 Switch to the shadow registers.
  $755A,$03 #REGde'=#N$50CB (screen buffer location).
  $755D,$01 Switch back to the normal registers.
  $755E,$01 #REGa-=#REGc.
  $755F,$02 Jump to #R$756B if #REGa is zero.
N $7561 Blank out where the lives would print.
  $7561,$02 #REGb=#REGa*#N$02.
@ $7563 label=PrintBlank_Loop
  $7563,$01 Switch to the shadow registers.
  $7564,$02 #REGl=#R$7864(#N$64).
  $7566,$03 Call #R$74AA.
  $7569,$02 Decrease counter by one and loop back to #R$7563 until counter is zero.
@ $756B label=TestGameOver
  $756B,$04 Jump to #R$757E if #REGc is zero.
N $756F Display the bike graphic for each remaining life.
  $756F,$01 #REGb=#REGc (counter; current number of lives).
@ $7570 label=PrintLives
  $7570,$01 Switch to the shadow registers.
  $7571,$02 #REGl'=#R$789C(#N$9C).
N $7573 Print the left side of the bike graphic.
  $7573,$03 Call #R$74AA.
  $7576,$01 Switch back to the normal registers.
N $7577 Print the right side of the bike graphic.
  $7577,$03 Call #R$74AA.
  $757A,$02 Decrease counter by one and loop back to #R$7570 until counter is zero.
  $757C,$01 Return.

u $757D

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
  $7592,$03 #REGde'=#N$51DB (screen buffer location).
  $7595,$01 Switch back to the normal registers.
  $7596,$03 Call #R$7434.
N $7599 Print the "#STR($BA46,$03,$20)" messaging in the footer.
N $7599 #HTML(#FONT:(GAME OVER-PRESS KEY TO TRY AGAIN)$3D00,attr=$84(game-over))
@ $7599 label=Print_GameOver
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
. hidden by the attributes until it's shown in-game by setting the appropriate attribute values.
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

c $763C Handler: Fuel
@ $763C label=Handler_Fuel
  $763C,$03 Call #R$7420.
  $763F,$03 #REGhl=*#R$783C.
  $7642,$05 Jump to #R$769A if #REGh is lower than #N$80.
  $7647,$03 #REGhl=*#R$782E.
  $764A,$01 #REGa=*#REGhl.
  $764B,$01 Decrease #REGa by one.
  $764C,$02 Jump to #R$765C if #REGa is zero.
  $764E,$05 Call #R$EBF3 if #REGa is higher than #N$31.
  $7653,$05 Call #R$EBF3 if #REGa is lower than #N$2D.
  $7658,$04 No operation.
N $765C Start the "Out Of Fuel" sequence.
@ $765C label=TriggerOutOfFuel
  $765C,$03 Call #R$68AD.
  $765F,$03 #REGa=*#R$7822.
  $7662,$02 Check the direction bit.
  $7664,$02 Load the base player sprite into #REGa (#N$87).
  $7666,$02 Jump to #R$766A if the player is moving left.
  $7668,$02 Modify the player sprite ID for the player moving right (#N$C7).
@ $766A label=SetWheelieSprite
  $766A,$03 Write the player sprite ID to *#R$7834.
  $766D,$03 Call #R$6B2D.
N $7670 Print the "#STR($BA86,$03,$20)" messaging in the footer.
N $7670 #HTML(#FONT:(OUT OF FUEL)$3D00,attr=$A9(out-of-fuel))
  $7670,$02 #REGa=#N$A9 (#COLOUR$A9).
  $7672,$03 #REGhl=#R$BA86.
  $7675,$03 Call #R$74C3.
N $7678 Play the "out of fuel" audio.
N $7678 #HTML(#AUDIO(out-of-fuel.wav)(#INCLUDE(OutOfFuel)))
  $7678,$02 Set an outer loop count in #REGd for #N$10 iterations.
  $767A,$02 Set the initial tone value in #REGc to #N$01.
@ $767C label=PlayFuelSound_OuterLoop
  $767C,$03 Set the tone duration counter in #REGhl to #N$1E00.
  $767F,$01 Get current tone value.
@ $7680 label=PlayFuelSound_ToneLoop
  $7680,$01 Set inner delay counter.
  $7681,$02 Send to the speaker.
  $7683,$02,b$01 Flip the speaker bit.
@ $7685 label=PlayFuelSound_InnerDelayLoop
  $7685,$02 Decrease the inner delay counter by one and loop back to #R$7685
. until the counter is zero.
  $7687,$01 Decrease the tone duration low byte by one.
  $7688,$02 Jump back to #R$7680 until the tone duration low byte is zero.
  $768A,$01 Decrease the tone duration high byte by one.
  $768B,$02 Jump back to #R$7680 until the tone duration high byte is zero.
  $768D,$01 Increase the tone frequency by one (higher pitch).
  $768E,$01 Decrease the outer loop counter by one.
  $768F,$02 Jump back to #R$767C until the outer loop counter is zero.
N $7691 Reset the players fuel and restart the game.
  $7691,$06 Write #N$3400 to *#R$783C.
  $7697,$03 Jump to #R$7161.
N $769A Normal fuel consumption processing.
@ $769A label=ProcessFuelConsumption
  $769A,$03 #REGa=*#R$7822.
  $769D,$02 Check the direction bit.
  $769F,$02 Jump to #R$76A2 if the player is moving backwards.
N $76A1 The player is moving forwards.
  $76A1,$01 Invert the speed for forward movement calculation.
@ $76A2 label=CalculateFuelConsumption
  $76A2,$07 Calculate the fuel consumption rate in #REGde; (speed-#N$7E)/#N$02.
  $76A9,$03 Subtract the consumption from the players fuel level.
  $76AC,$03 Write the updated fuel value back to *#R$783C.
  $76AF,$02 Jump to #R$76D0 if the fuel value is negative.
N $76B1 Update the fuel gauge display.
  $76B1,$01 Get the fuel high byte.
  $76B2,$04 Divide it by #N$04.
  $76B6,$01 Invert the byte for the gauge display.
  $76B7,$02 Abjust by an offset of #N$0C bytes for where the gauge displays.
  $76B9,$01 Set this value in #REGl.
  $76BA,$02 Load the high byte in #REGh with #N$BA.
  $76BC,$03 Point #REGde to the gauge position #N$5A65 (attribute buffer
. location).
  $76BF,$03 Call #R$6893.
N $76C2 Handle fuel-related audio effects during gameplay.
  $76C2,$03 #REGhl=*#R$783C.
  $76C5,$0B Call #R$6D50 if the fuel level is #N$0400 or higher, or for every
. #N$40 fuel units (which creates pulses as the fuel decreases).
  $76D0,$03 Jump to #R$EBF3.

u $76D3

c $76D7 Handler: Ghost Rider
@ $76D7 label=Handler_GhostRider
  $76D7,$03 Call #R$692C.
  $76DA,$05 Return if *#R$7825 is zero.
  $76DF,$04 Write #N$00 to *#R$7825.
  $76E3,$05 Return if *#R$782A is not zero.
  $76E8,$01 Switch to the shadow registers.
  $76E9,$01 #REGa=#REGc'.
  $76EA,$01 Switch back to the normal registers.
  $76EB,$04 Jump to #R$7744 if #REGa is lower than #N$44.
  $76EF,$02 Jump to #R$7729 if #REGa is not equal to #N$44.
  $76F1,$03 #REGhl=#R$7840.
  $76F4,$05 Jump to #R$EC2A if *#REGhl is not zero.
  $76F9,$02 Write #N$01 to *#REGhl.
  $76FB,$03 Call #R$EC0F.
  $76FE,$01 No operation.
  $76FF,$0A Add #N$01F4 to *#R$7844.
N $7709 Print the "#STR($BAA6,$03,$20)" messaging in the footer.
N $7709 #HTML(#FONT:(THE RACE IS ON!)$3D00,attr=$96(race-is-on))
  $7709,$02 #REGa=#N$96 (#COLOUR$96).
  $770B,$03 #REGhl=#R$BAA6.
  $770E,$03 Call #R$74C3.
  $7711,$03 Call #R$EC63.
  $7714,$03 Call #R$7535.
  $7717,$04 Write #N$00 to *#R$7824.
  $771B,$04 Write #N$01 to *#R$781A.
  $771F,$06 Write #N$0B6E to *#R$7841.
  $7725,$01 No operation.
  $7726,$03 Call #R$6D49.
  $7729,$04 Jump to #R$7742 if #REGa is higher than #N$46.
  $772D,$0A Add #N($0032,$04,$04) to *#R$7844.
  $7737,$02 Restore #REGhl and #REGde from the stack.
  $7739,$02 Stash #REGde and #REGhl on the stack.
  $773B,$03 #REGhl=#N$FFFA.
  $773E,$01 #REGhl+=#REGde.
  $773F,$02 Set bit 7 of *#REGhl.
  $7741,$01 Return.
  $7742,$02 Jump to #R$77A2 if {} is not zero.
  $7744,$06 No operation.
  $774A,$02 Restore #REGhl and #REGde from the stack.
  $774C,$03 #REGhl=*#R$783E.
  $774F,$03 #REGbc=#N($0008,$04,$04).
  $7752,$01 #REGa=#REGc.
  $7753,$02 Set bit 7 of *#REGhl.
  $7755,$01 #REGhl+=#REGbc.
  $7756,$01 Decrease #REGa by one.
  $7757,$02 Jump to #R$7753 until #REGa is zero.
  $7759,$03 #REGhl=#N$FFFA.
  $775C,$01 #REGhl+=#REGde.
  $775D,$02 Reset bit 7 of *#REGhl.
  $775F,$01 Stash #REGhl on the stack.
  $7760,$02 #REGb=#N$06.
  $7762,$01 Stash #REGbc on the stack.
  $7763,$03 Call #R$68AD.
  $7766,$03 Call #R$6B2D.
  $7769,$02 #REGc=#N$28.
  $776B,$03 #REGhl=#N$0800.
  $776E,$02 #REGa=#N$02.
  $7770,$02 OUT #N$FE
  $7772,$02,b$01 Flip bit 4.
  $7774,$01 #REGd=#REGa.
  $7775,$01 #REGb=#REGc.
  $7776,$02 Decrease counter by one and loop back to #R$7776 until counter is zero.
  $7778,$01 Decrease #REGhl by one.
  $7779,$02 Is #REGhl zero?
  $777B,$01 #REGa=#REGd.
  $777C,$02 Jump to #R$7770 if #REGhl is not zero.
  $777E,$03 Call #R$68AD.
  $7781,$03 Call #R$7314.
  $7784,$02 #REGc=#N$14.
  $7786,$03 #REGhl=#N($1000,$04,$04).
  $7789,$02 #REGa=#N$06.
  $778B,$02 OUT #N$FE
  $778D,$02,b$01 Flip bit 4.
  $778F,$01 #REGd=#REGa.
  $7790,$01 #REGb=#REGc.
  $7791,$02 Decrease counter by one and loop back to #R$7791 until counter is zero.
  $7793,$01 Decrease #REGhl by one.
  $7794,$02 Is #REGhl zero?
  $7796,$01 #REGa=#REGd.
  $7797,$02 Jump to #R$778B if #REGhl is not zero.
  $7799,$01 Restore #REGbc from the stack.
  $779A,$02 Decrease counter by one and loop back to #R$7762 until counter is zero.
  $779C,$01 Restore #REGhl from the stack.
  $779D,$02 Set bit 7 of *#REGhl.
  $779F,$03 Jump to #R$6ED4.
  $77A2,$06 No operation.
  $77A8,$0A Add #N$03E8 to *#R$7844.
  $77B2,$03 Call #R$7420.
  $77B5,$03 Call #R$68AD.
  $77B8,$04 No operation.
  $77BC,$05 Write #N$05 to *#R$7839.
  $77C1,$03 Call #R$ED39.
N $77C4 Print the "#STR($BAC6,$03,$20)" messaging in the footer.
N $77C4 #HTML(#FONT:(NEW CODE ABCDE-PRESS KEY TO PLAY)$3D00,attr=$9F(new-code))
  $77C4,$02 #REGa=#N$9F (#COLOUR$9F).
  $77C6,$03 #REGhl=#R$BAC6.
  $77C9,$03 Call #R$74C3.
  $77CC,$03 Call #R$EC5E.
@ $77CF label=LevelComplete_Input
  $77CF,$03 Call #R$6828.
  $77D2,$03 Jump to #R$77CF until any key is pressed.
  $77D5,$03 Call #R$7535.
  $77D8,$03 Jump to #R$6CAD.

u $77DB

c $77E0
  $77E0,$06 No operation.
N $77E6 Print the "#STR($78AC,$03,$20)" messaging in the footer.
N $77E6 #HTML(#FONT:(THE GHOSTRIDER HAS FINISHED)$3D00,attr=$87(ghostrider-finished))
  $77E6,$02 #REGa=#N$87 (#COLOUR$87).
  $77E8,$03 #REGhl=#R$78AC.
  $77EB,$03 Call #R$74C3.
  $77EE,$03 Call #R$EC68.
N $77F1 Set the player lives to #N$01 this is decreased to #N$00 by #R$7552 so is how the player receives a "Game Over".
  $77F1,$05 Write #N$01 to #R$7839.
  $77F6,$03 Jump to #R$7552.

b $77F9

b $7800
  $7800,$14,$02

g $7814
B $7814,$01

g $7815
W $7815,$02

g $7817 Current Screen Position
@ $7817 label=Current_ScreenPosition
W $7817,$02

g $7819 Scroll Phase Counter
@ $7819 label=ScrollPhase_Counter
B $7819,$01

g $781A
B $781A,$01

g $781B Active Sprite Blocks
@ $781B label=ActiveSpriteBlocks
D $781B The number of sprite character blocks (8x8 pixels) currently active.
.
. A single sprite may span multiple character blocks, this is where it's
. tracked.
B $781B,$01

g $781C Pointer: Sprite Background Buffer
@ $781C label=SpriteBackgroundBuffer_Pointer
D $781C Pointer to buffer containing saved background data for sprite removal.
W $781C,$02

g $781E Random Number Seed?
@ $781E label=RandomNumberSeed
D $781E See #R$6414 for how this is generated.
W $781E,$02

g $7820 Current Level
@ $7820 label=CurrentLevel
B $7820,$01

g $7821

g $7822 Speed?
@ $7822 label=Speed
B $7822,$01 Pivots around #N$80 for direction - right >= #N$80, left is < #N$80.
B $7823,$01 Mirror of speed? Doesn't seem to be used. TODO.

g $7824
B $7824,$01

g $7825 Sprite State
@ $7825 label=SpriteState
B $7825,$01

g $7826
B $7826,$01

g $7827
B $7827,$01

g $7828 Player Input
@ $7828 label=PlayerInput
D $7828 Relates to the direction for the current player input.
. #TABLE(default,centre,centre)
.   { =h Byte | =h Meaning }
.   { #N$00 | No input }
.   { #N$01 | Right }
.   { #N$02 | Left }
.   { #N$04 | Down }
.   { #N$08 | Up }
. TABLE#
B $7828,$01

u $7829

g $782A Action
@ $782A label=Action
B $782A,$01

u $782B

g $782C Control Method Pointer
@ $782C label=ControlMethod_Pointer
W $782C,$02

g $782E Level Progress Pointer
@ $782E label=LevelProgressPointer
W $782E,$02

g $7830
B $7830,$01

g $7831
W $7831,$02

g $7833 Player Y Position
@ $7833 label=PlayerPosition_Y
B $7833,$01

g $7834 Player Sprite ID
@ $7834 label=PlayerSpriteID
B $7834,$01

g $7835

g $7836

g $7838

g $7839 Lives
@ $7839 label=Lives
B $7839,$01

g $783A
W $783A,$02

g $783C Fuel
@ $783C label=Fuel
W $783C,$02

g $783E

g $7840

g $7841

g $7843

g $7844 Score
@ $7844 label=Score
W $7844,$02

g $7846
@ $7846 label=HighScore
W $7846,$02

g $7848
  $7848

g $784B Displayed Score
@ $784B label=DisplayedScore
B $784B,$05

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

g $785A Frame Count
@ $785A label=FrameCount
B $785A,$01

g $785B AGF Interface KeyMap
@ $785B label=AGFInterfaceKeyMap
B $785B,$01
B $785C,$01
B $785D,$01
B $785E,$01
B $785F,$01

b $7860

b $7864 Graphics: Blank
@ $7864 label=Graphics_Blank
  $7864,$08 #UDGTABLE(default,centre) { #UDG$7864 } UDGTABLE#

b $786C Graphics: Arrow Top
@ $786C label=Graphics_ArrowTopLeft
  $786C,$08 #UDGTABLE(default,centre) { #UDG$786C,attr=$06(arrow-top-left) } UDGTABLE#
@ $7874 label=Graphics_ArrowTopRight
  $7874,$08 #UDGTABLE(default,centre) { #UDG$7874,attr=$06(arrow-top-right) } UDGTABLE#

b $787C Graphics: Arrow Middle
@ $787C label=Graphics_ArrowMiddleLeft
  $787C,$08 #UDGTABLE(default,centre) { #UDG$787C,attr=$06(arrow-middle-left) } UDGTABLE#
@ $7884 label=Graphics_ArrowMiddleRight
  $7884,$08 #UDGTABLE(default,centre) { #UDG$7884,attr=$06(arrow-middle-right) } UDGTABLE#

b $788C Graphics: Arrow Bottom
@ $788C label=Graphics_ArrowBottomLeft
  $788C,$08 #UDGTABLE(default,centre) { #UDG$788C,attr=$06(arrow-bottom-left) } UDGTABLE#
@ $7894 label=Graphics_ArrowBottomRight
  $7894,$08 #UDGTABLE(default,centre) { #UDG$7894,attr=$06(arrow-bottom-right) } UDGTABLE#

b $789C Graphics: Bike (Start Screen)
@ $789C label=Graphics_StartScreenBike
D $789C #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(bike)
  $789C,$10,$08

t $78AC Messaging: Ghostrider Is Finished
@ $78AC label=Messaging_GhostRiderFinished
  $78AC,$20 "#STR(#PC,$04,$20)".

b $78CC

b $78E0 Graphics: Carousel
@ $78E0 label=Graphics_Carousel
D $78E0 This is bit rotated by the routine at: #R$6E18.
  $78E0,$20,$04 #UDGTABLE { #UDGARRAY$04,attr=$06,scale=$04,step=$04;(#PC)-(#PC+$1C)-$01-$20(carousel) } TABLE#

b $7900

b $8000 Graphics Data
  $8000,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_solid)
  $8020,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_stripes)
  $8040,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_edge1)
  $8060,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_edge2)
  $8080,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_edge3)
  $80A0,$20 #UDGARRAY$20,attr=$07,scale=$02;(#PC)-(#PC+$1F){$00,$00,$100,$01}(terrain_line_edge4)

g $8960 Data: Level 1
@ $8960 label=Data_Level_1
N $8960 Page #N($01+(#PC-$8960)/$A0).
B $8960,$A0,$20
L $8960,$A0,$10

g $9360 Data: Level 2
@ $9360 label=Data_Level_2
N $9360 Page #N($01+(#PC-$9360)/$A0).
B $9360,$A0,$20
L $9360,$A0,$10

g $9E00 Level Buffer
@ $9E00 label=LevelBuffer
D $9E00 #N$20 columns x #N$50 rows, organised as #N$10 pages of #N$A0 bytes
. each (each page is #N$05 rows x #N$20 columns).
N $9E00 Page #N($01+(#PC-$9E00)/$A0).
B $9E00,$A0,$20
L $9E00,$A0,$10

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

b $B200 Shadow Buffer?
@ $B200 label=ShadowBuffer

b $B400
  $B400,$0C,$04 #UDGTABLE #TILES(#PC,$04,$03) TABLE#
L $B400,$0C,$09

g $B46C Terrain Data
@ $B46C label=Data_Terrain_01
@ $B472 label=Data_Terrain_02
@ $B478 label=Data_Terrain_03
@ $B47E label=Data_Terrain_04
@ $B484 label=Data_Terrain_05
@ $B48A label=Data_Terrain_06
@ $B490 label=Data_Terrain_07
@ $B496 label=Data_Terrain_08
N $B46C Terrain object #N($01+(#PC-$B46C)/$06).
B $B46C,$04
N $B470 Vertical component: #MAP(#PEEK(#PC))(Yes,0:No).
B $B470,$02
L $B46C,$06,$08

g $B49C Table: Speedometer Attributes
@ $B49C label=Table_SpeedometerAttributes
D $B49C Used by the routine at #R$6880.
N $B49C These attribute bytes are copied to the attribute buffer using #R$6893.
. The idea is that, #N$0C bytes are copied to represent the speed gauge, but
. where they start from is determined by a calculation on the speed.
.
. The absolute minimum speed is #N$80 for right movement and #N$7F for left
. movement, so aftter the calculation will use a starting address of #N$B4A7 to
. copy the #N$0C bytes.
.
. The maximum speeds are #N$96 for right movement and #N$69 for left movement,
. these both use a starting address of #N$B49C to copy the #N$0C bytes.
B $B49C,$01 Attribute: "#INK(#PEEK(#PC))".
L $B49C,$01,$17,$02

g $B4B3

g $B4BC

g $B4DC Actions Jump Table
@ $B4DC label=JumpTable_Actions
D $B4DC Used by the routine at #R$6A27.
W $B4DC,$02 #D(#PEEK(#PC)+#PEEK(#PC+$01)*$0100).
L $B4DC,$02,$07

b $B4EA

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

u $BAF3

b $BB00

t $BBA0 Messaging: Level Names
D $BBA0 Used by the routine at #R$74DC.
N $BBA0 Level 1.
@ $BBA0 label=Messaging_Level1
B $BBA0,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BBA1,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(   THE   )$3D00,attr=$42(level-01-01) }
. { #FONT:(BOUNCING )$3D00,attr=$42(level-01-02) }
. { #FONT:(HEDGEHOGS)$3D00,attr=$42(level-01-03) }
. UDGTABLE#
N $BBBC Level 2.
@ $BBBC label=Messaging_Level2
B $BBBC,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BBBD,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(   THE   )$3D00,attr=$45(level-02-01) }
. { #FONT:(  WILY   )$3D00,attr=$45(level-02-02) }
. { #FONT:(WALLABIES)$3D00,attr=$45(level-02-03) }
. UDGTABLE#
N $BBD8 Level 3.
@ $BBD8 label=Messaging_Level3
B $BBD8,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BBD9,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(   THE   )$3D00,attr=$46(level-03-01) }
. { #FONT:( KILLER  )$3D00,attr=$46(level-03-02) }
. { #FONT:(  BEES   )$3D00,attr=$46(level-03-03) }
. UDGTABLE#
N $BBF4 Level 4.
@ $BBF4 label=Messaging_Level4
B $BBF4,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BBF5,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(   ALL   )$3D00,attr=$50(level-04-01) }
. { #FONT:(  THAT   )$3D00,attr=$50(level-04-02) }
. { #FONT:( BOUNCES )$3D00,attr=$50(level-04-03) }
. UDGTABLE#
N $BC10 Level 5.
@ $BC10 label=Messaging_Level5
B $BC10,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BC11,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(   THE   )$3D00,attr=$70(level-05-01) }
. { #FONT:(  SWARM  )$3D00,attr=$70(level-05-02) }
. { #FONT:(         )$3D00,attr=$70(level-05-03) }
. UDGTABLE#
N $BC2C Level 6.
@ $BC2C label=Messaging_Level6
B $BC2C,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BC2D,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:( SPRING  )$3D00,attr=$56(level-06-01) }
. { #FONT:(   AND   )$3D00,attr=$56(level-06-02) }
. { #FONT:(  STING  )$3D00,attr=$56(level-06-03) }
. UDGTABLE#
N $BC48 Level 7.
@ $BC48 label=Messaging_Level7
B $BC48,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BC49,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:(NIGHTMARE)$3D00,attr=$44(level-07-01) }
. { #FONT:(  PARK   )$3D00,attr=$44(level-07-02) }
. { #FONT:(         )$3D00,attr=$44(level-07-03) }
. UDGTABLE#
N $BC64 Level 8.
@ $BC64 label=Messaging_Level8
B $BC64,$01 Attribute #COLOUR(#PEEK(#PC)).
  $BC65,$1B,$09 #UDGTABLE(default,centre)
. { #FONT:( ABANDON )$3D00,attr=$D6(level-08-01) }
. { #FONT:(   ALL   )$3D00,attr=$D6(level-08-02) }
. { #FONT:(  HOPE!  )$3D00,attr=$D6(level-08-03) }
. UDGTABLE#

b $BC80

b $BC9E

b $BD0E
  $BD21

b $BD34

b $BDB8

g $BE00
W $BE00,$02 #N((#PC-$BE00)/$02).
L $BE00,$02,$E0

t $C3E0 Messaging: MPH
@ $C3E0 label=Messaging_MPH
  $C3E0,$04 "#STR(#PC,$04,$04)".

b $C3E4 Graphics: Arrow Top
@ $C3E4 label=Graphics_ArrowTop
D $C3E4 #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$06,scale=$04,step=$01;$786C-$7874-$08(arrow-top) } UDGTABLE#
  $C3E4,$01 See #R$786C.
  $C3E5,$01 See #R$7874.

t $C3E6 Messaging: Fuel
@ $C3E6 label=Messaging_Fuel
  $C3E6,$04 "#STR(#PC,$04,$04)".

b $C3EA Graphics: Arrow Middle
@ $C3EA label=Graphics_ArrowMiddle
D $C3EA #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$06,scale=$04,step=$01;$787C-$7884-$08(arrow-middle) } UDGTABLE#
  $C3EA,$01 See #R$787C.
  $C3EB,$01 See #R$7884.

t $C3EC Messaging: RPM
@ $C3EC label=Messaging_RPM
  $C3EC,$04 "#STR(#PC,$04,$04)".

b $C3F0 Graphics: Arrow Bottom
@ $C3F0 label=Graphics_ArrowBottom
D $C3F0 #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$06,scale=$04,step=$01;$788C-$7894-$08(arrow-bottom) } UDGTABLE#
  $C3F0,$01 See #R$788C.
  $C3F1,$01 See #R$7894.

t $C3F2 Messaging: Score
@ $C3F2 label=Messaging_Score
  $C3F2,$06 "#STR(#PC,$04,$06)".

t $C3F8 Messaging: Target
@ $C3F8 label=Messaging_Target
  $C3F8,$07 "#STR(#PC,$04,$07)".

b $C400

b $C500 Sprite Animation Data
@ $C500 label=SpriteAnimationData
N $C500 Sprite #N$01, Frame #N$01.
  $C500,$02 X/ Y position offsets.
  $C502,$08 Pixel data (2 character rows × 4 bytes each).
  $C50A,$01 Frame #N$01 terminator.
N $C50B Sprite #N$01, Frame #N$02 ($04 bytes).
  $C50B,$02 X/ Y position offsets.
  $C50D,$02 Pixel/ control data.
  $C50F,$01 Animation sequence terminator.
  $C510,$01 Animation sequence terminator.
N $C511 Sprite #N$03, Frame #N$01 ($04 bytes).
  $C511,$02 X/ Y position offsets.
  $C513,$02 Pixel/ control data.
  $C515,$01 Frame #N$01 terminator.
  $C516,$01 Animation sequence terminator.
N $C517 Sprite #N$04, Frame #N$01.
  $C517,$02 X/ Y position offsets.
  $C519,$08 Pixel data (2 character rows × 4 bytes each).
  $C521,$01 Frame #N$01 terminator.
N $C522 Sprite #N$04, Frame #N$02.
  $C522,$02 X/ Y position offsets.
  $C524,$08 Pixel data (2 character rows × 4 bytes each).
  $C52C,$01 Frame #N$02 terminator.
  $C52D,$01 Animation sequence terminator.
N $C52E Sprite #N$05, Frame #N$01 ($12 bytes).
  $C52E,$02 X/ Y position offsets.
  $C530,$10 Pixel/ control data.
  $C540,$01 Frame #N$01 terminator.
N $C541 Sprite #N$05, Frame #N$02 (control byte).
  $C541,$01 Control data.
  $C542,$01 Frame #N$02 terminator.
N $C543 Sprite #N$05, Frame #N$03 (position only).
  $C543,$02 X/ Y position offsets.
  $C545,$01 Animation sequence terminator.
N $C546 Sprite #N$06, Frame #N$01 ($05 bytes).
  $C546,$02 X/ Y position offsets.
  $C548,$03 Pixel/ control data.
  $C54B,$01 Frame #N$01 terminator.
  $C54C,$01 Animation sequence terminator.
N $C54D Sprite #N$07, Frame #N$01 ($12 bytes).
  $C54D,$02 X/ Y position offsets.
  $C54F,$10 Pixel/ control data.
  $C55F,$01 Frame #N$01 terminator.
N $C560 Sprite #N$07, Frame #N$02 (control byte).
  $C560,$01 Control data.
  $C561,$01 Frame #N$02 terminator.
N $C562 Sprite #N$07, Frame #N$03 ($10 bytes).
  $C562,$02 X/ Y position offsets.
  $C564,$0E Pixel/ control data.
  $C572,$01 Frame #N$03 terminator.
  $C573,$01 Animation sequence terminator.
N $C574 Sprite #N$08, Frame #N$01 ($0B bytes).
  $C574,$02 X/ Y position offsets.
  $C576,$09 Pixel/ control data.
  $C57F,$01 Frame #N$01 terminator.
N $C580 Sprite #N$08, Frame #N$02 (control byte).
  $C580,$01 Control data.
  $C581,$01 Frame #N$02 terminator.
N $C582 Sprite #N$08, Frame #N$03 (control byte).
  $C582,$01 Control data.
  $C583,$01 Animation sequence terminator.
N $C584 Sprite #N$09, Frame #N$01 ($07 bytes).
  $C584,$02 X/ Y position offsets.
  $C586,$05 Pixel/ control data.
  $C58B,$01 Animation sequence terminator.
  $C58C,$01 Animation sequence terminator.
  $C58D,$01 Animation sequence terminator.
N $C58E Sprite #N$0C, Frame #N$01 ($04 bytes).
  $C58E,$02 X/ Y position offsets.
  $C590,$02 Pixel/ control data.
  $C592,$01 Frame #N$01 terminator.
  $C593,$01 Animation sequence terminator.
N $C594 Sprite #N$0D, Frame #N$01 ($12 bytes).
  $C594,$02 X/ Y position offsets.
  $C596,$10 Pixel/ control data.
  $C5A6,$01 Frame #N$01 terminator.
N $C5A7 Sprite #N$0D, Frame #N$02 (control byte).
  $C5A7,$01 Control data.
  $C5A8,$01 Frame #N$02 terminator.
N $C5A9 Sprite #N$0D, Frame #N$03 ($18 bytes).
  $C5A9,$02 X/ Y position offsets.
  $C5AB,$16 Pixel/ control data.
  $C5C1,$01 Frame #N$03 terminator.
N $C5C2 Sprite #N$0D, Frame #N$04 ($09 bytes).
  $C5C2,$02 X/ Y position offsets.
  $C5C4,$07 Pixel/ control data.
  $C5CB,$01 Animation sequence terminator.
N $C5CC Sprite #N$0E, Frame #N$01 ($04 bytes).
  $C5CC,$02 X/ Y position offsets.
  $C5CE,$02 Pixel/ control data.
  $C5D0,$01 Animation sequence terminator.
N $C5D1 Sprite #N$0F, Frame #N$01 ($06 bytes).
  $C5D1,$02 X/ Y position offsets.
  $C5D3,$04 Pixel/ control data.
  $C5D7,$01 Animation sequence terminator.
  $C5D8,$01 Animation sequence terminator.
N $C5D9 Sprite #N$11, Frame #N$01 ($03 bytes).
  $C5D9,$02 X/ Y position offsets.
  $C5DB,$01 Pixel/ control data.
  $C5DC,$01 Frame #N$01 terminator.
  $C5DD,$01 Animation sequence terminator.
N $C5DE Sprite #N$12, Frame #N$01.
  $C5DE,$02 X/ Y position offsets.
  $C5E0,$08 Pixel data (2 character rows × 4 bytes each).
  $C5E8,$01 Frame #N$01 terminator.
N $C5E9 Sprite #N$12, Frame #N$02 ($1A bytes).
  $C5E9,$02 X/ Y position offsets.
  $C5EB,$18 Pixel/ control data.
  $C603,$01 Frame #N$02 terminator.
N $C604 Sprite #N$12, Frame #N$03 ($17 bytes).
  $C604,$02 X/ Y position offsets.
  $C606,$15 Pixel/ control data.
  $C61B,$01 Animation sequence terminator.
N $C61C Sprite #N$13, Frame #N$01 (position only).
  $C61C,$02 X/ Y position offsets.
  $C61E,$01 Frame #N$01 terminator.
  $C61F,$01 Animation sequence terminator.
N $C620 Sprite #N$14, Frame #N$01.
  $C620,$02 X/ Y position offsets.
  $C622,$08 Pixel data (2 character rows × 4 bytes each).
  $C62A,$01 Frame #N$01 terminator.
N $C62B Sprite #N$14, Frame #N$02 ($1A bytes).
  $C62B,$02 X/ Y position offsets.
  $C62D,$18 Pixel/ control data.
  $C645,$01 Frame #N$02 terminator.
N $C646 Sprite #N$14, Frame #N$03.
  $C646,$02 X/ Y position offsets.
  $C648,$08 Pixel data (2 character rows × 4 bytes each).
  $C650,$01 Animation sequence terminator.
N $C651 Sprite #N$15, Frame #N$01 ($0F bytes).
  $C651,$02 X/ Y position offsets.
  $C653,$0D Pixel/ control data.
  $C660,$01 Frame #N$01 terminator.
  $C661,$01 Animation sequence terminator.
N $C662 Sprite #N$16, Frame #N$01 (control byte).
  $C662,$01 Control data.
  $C663,$01 Frame #N$01 terminator.
N $C664 Sprite #N$16, Frame #N$02 ($10 bytes).
  $C664,$02 X/ Y position offsets.
  $C666,$0E Pixel/ control data.
  $C674,$01 Frame #N$02 terminator.
N $C675 Sprite #N$16, Frame #N$03 ($12 bytes).
  $C675,$02 X/ Y position offsets.
  $C677,$10 Pixel/ control data.
  $C687,$01 Frame #N$03 terminator.
N $C688 Sprite #N$16, Frame #N$04 (control byte).
  $C688,$01 Control data.
  $C689,$01 Frame #N$04 terminator.
N $C68A Sprite #N$16, Frame #N$05 ($18 bytes).
  $C68A,$02 X/ Y position offsets.
  $C68C,$16 Pixel/ control data.
  $C6A2,$01 Frame #N$05 terminator.
  $C6A3,$01 Animation sequence terminator.
N $C6A4 Sprite #N$17, Frame #N$01 (control byte).
  $C6A4,$01 Control data.
  $C6A5,$01 Frame #N$01 terminator.
N $C6A6 Sprite #N$17, Frame #N$02 ($10 bytes).
  $C6A6,$02 X/ Y position offsets.
  $C6A8,$0E Pixel/ control data.
  $C6B6,$01 Frame #N$02 terminator.
N $C6B7 Sprite #N$17, Frame #N$03 ($12 bytes).
  $C6B7,$02 X/ Y position offsets.
  $C6B9,$10 Pixel/ control data.
  $C6C9,$01 Frame #N$03 terminator.
N $C6CA Sprite #N$17, Frame #N$04 ($1A bytes).
  $C6CA,$02 X/ Y position offsets.
  $C6CC,$18 Pixel/ control data.
  $C6E4,$01 Frame #N$04 terminator.
N $C6E5 Sprite #N$17, Frame #N$05 ($04 bytes).
  $C6E5,$02 X/ Y position offsets.
  $C6E7,$02 Pixel/ control data.
  $C6E9,$01 Animation sequence terminator.
  $C6EA,$01 Animation sequence terminator.
  $C6EB,$01 Animation sequence terminator.
N $C6EC Sprite #N$1A, Frame #N$01 ($03 bytes).
  $C6EC,$02 X/ Y position offsets.
  $C6EE,$01 Pixel/ control data.
  $C6EF,$01 Frame #N$01 terminator.
  $C6F0,$01 Animation sequence terminator.
N $C6F1 Sprite #N$1B, Frame #N$01 (control byte).
  $C6F1,$01 Control data.
  $C6F2,$01 Frame #N$01 terminator.
N $C6F3 Sprite #N$1B, Frame #N$02 ($10 bytes).
  $C6F3,$02 X/ Y position offsets.
  $C6F5,$0E Pixel/ control data.
  $C703,$01 Frame #N$02 terminator.
N $C704 Sprite #N$1B, Frame #N$03 (control byte).
  $C704,$01 Control data.
  $C705,$01 Frame #N$03 terminator.
N $C706 Sprite #N$1B, Frame #N$04 ($10 bytes).
  $C706,$02 X/ Y position offsets.
  $C708,$0E Pixel/ control data.
  $C716,$01 Frame #N$04 terminator.
N $C717 Sprite #N$1B, Frame #N$05 (control byte).
  $C717,$01 Control data.
  $C718,$01 Frame #N$05 terminator.
N $C719 Sprite #N$1B, Frame #N$06 ($18 bytes).
  $C719,$02 X/ Y position offsets.
  $C71B,$16 Pixel/ control data.
  $C731,$01 Frame #N$06 terminator.
N $C732 Sprite #N$1B, Frame #N$07 (control byte).
  $C732,$01 Control data.
  $C733,$01 Frame #N$07 terminator.
N $C734 Sprite #N$1B, Frame #N$08 (position only).
  $C734,$02 X/ Y position offsets.
  $C736,$01 Animation sequence terminator.
  $C737,$01 Animation sequence terminator.
  $C738,$01 Animation sequence terminator.
N $C739 Sprite #N$1E, Frame #N$01 (control byte).
  $C739,$01 Control data.
  $C73A,$01 Animation sequence terminator.
  $C73B,$01 Animation sequence terminator.
  $C73C,$01 Frame #N$01 terminator.
  $C73D,$01 Animation sequence terminator.
N $C73E Sprite #N$21, Frame #N$01 (control byte).
  $C73E,$01 Control data.
  $C73F,$01 Frame #N$01 terminator.
N $C740 Sprite #N$21, Frame #N$02 ($10 bytes).
  $C740,$02 X/ Y position offsets.
  $C742,$0E Pixel/ control data.
  $C750,$01 Frame #N$02 terminator.
N $C751 Sprite #N$21, Frame #N$03 (control byte).
  $C751,$01 Control data.
  $C752,$01 Frame #N$03 terminator.
N $C753 Sprite #N$21, Frame #N$04 ($0E bytes).
  $C753,$02 X/ Y position offsets.
  $C755,$0C Pixel/ control data.
  $C761,$01 Animation sequence terminator.
N $C762 Sprite #N$22, Frame #N$01 (control byte).
  $C762,$01 Control data.
  $C763,$01 Frame #N$01 terminator.
N $C764 Sprite #N$22, Frame #N$02 (control byte).
  $C764,$01 Control data.
  $C765,$01 Frame #N$02 terminator.
N $C766 Sprite #N$22, Frame #N$03 ($10 bytes).
  $C766,$02 X/ Y position offsets.
  $C768,$0E Pixel/ control data.
  $C776,$01 Frame #N$03 terminator.
N $C777 Sprite #N$22, Frame #N$04 (position only).
  $C777,$02 X/ Y position offsets.
  $C779,$01 Animation sequence terminator.
  $C77A,$01 Animation sequence terminator.
  $C77B,$01 Animation sequence terminator.
N $C77C Sprite #N$25, Frame #N$01 ($03 bytes).
  $C77C,$02 X/ Y position offsets.
  $C77E,$01 Pixel/ control data.
  $C77F,$01 Animation sequence terminator.
N $C780 Sprite #N$26, Frame #N$01 (control byte).
  $C780,$01 Control data.
  $C781,$01 Frame #N$01 terminator.
  $C782,$01 Animation sequence terminator.
N $C783 Sprite #N$27, Frame #N$01 (control byte).
  $C783,$01 Control data.
  $C784,$01 Frame #N$01 terminator.
N $C785 Sprite #N$27, Frame #N$02 ($10 bytes).
  $C785,$02 X/ Y position offsets.
  $C787,$0E Pixel/ control data.
  $C795,$01 Frame #N$02 terminator.
N $C796 Sprite #N$27, Frame #N$03 ($10 bytes).
  $C796,$02 X/ Y position offsets.
  $C798,$0E Pixel/ control data.
  $C7A6,$01 Animation sequence terminator.
N $C7A7 Sprite #N$28, Frame #N$01 ($07 bytes).
  $C7A7,$02 X/ Y position offsets.
  $C7A9,$05 Pixel/ control data.
  $C7AE,$01 Animation sequence terminator.
N $C7AF Sprite #N$29, Frame #N$01 (control byte).
  $C7AF,$01 Control data.
  $C7B0,$01 Frame #N$01 terminator.
N $C7B1 Sprite #N$29, Frame #N$02 (control byte).
  $C7B1,$01 Control data.
  $C7B2,$01 Frame #N$02 terminator.
  $C7B3,$01 Animation sequence terminator.
N $C7B4 Sprite #N$2A, Frame #N$01 ($0F bytes).
  $C7B4,$02 X/ Y position offsets.
  $C7B6,$0D Pixel/ control data.
  $C7C3,$01 Frame #N$01 terminator.
N $C7C4 Sprite #N$2A, Frame #N$02 (control byte).
  $C7C4,$01 Control data.
  $C7C5,$01 Frame #N$02 terminator.
N $C7C6 Sprite #N$2A, Frame #N$03 ($06 bytes).
  $C7C6,$02 X/ Y position offsets.
  $C7C8,$04 Pixel/ control data.
  $C7CC,$01 Animation sequence terminator.
N $C7CD Sprite #N$2B, Frame #N$01 ($03 bytes).
  $C7CD,$02 X/ Y position offsets.
  $C7CF,$01 Pixel/ control data.
  $C7D0,$01 Animation sequence terminator.
N $C7D1 Sprite #N$2C, Frame #N$01 ($05 bytes).
  $C7D1,$02 X/ Y position offsets.
  $C7D3,$03 Pixel/ control data.
  $C7D6,$01 Frame #N$01 terminator.
  $C7D7,$01 Animation sequence terminator.
N $C7D8 Sprite #N$2D, Frame #N$01 (control byte).
  $C7D8,$01 Control data.
  $C7D9,$01 Frame #N$01 terminator.
N $C7DA Sprite #N$2D, Frame #N$02 ($10 bytes).
  $C7DA,$02 X/ Y position offsets.
  $C7DC,$0E Pixel/ control data.
  $C7EA,$01 Frame #N$02 terminator.
N $C7EB Sprite #N$2D, Frame #N$03 ($18 bytes).
  $C7EB,$02 X/ Y position offsets.
  $C7ED,$16 Pixel/ control data.
  $C803,$01 Animation sequence terminator.
N $C804 Sprite #N$2E, Frame #N$01 (control byte).
  $C804,$01 Control data.
  $C805,$01 Frame #N$01 terminator.
N $C806 Sprite #N$2E, Frame #N$02 (control byte).
  $C806,$01 Control data.
  $C807,$01 Frame #N$02 terminator.
N $C808 Sprite #N$2E, Frame #N$03 ($10 bytes).
  $C808,$02 X/ Y position offsets.
  $C80A,$0E Pixel/ control data.
  $C818,$01 Frame #N$03 terminator.
N $C819 Sprite #N$2E, Frame #N$04 (control byte).
  $C819,$01 Control data.
  $C81A,$01 Frame #N$04 terminator.
N $C81B Sprite #N$2E, Frame #N$05 ($04 bytes).
  $C81B,$02 X/ Y position offsets.
  $C81D,$02 Pixel/ control data.
  $C81F,$01 Animation sequence terminator.
  $C820,$01 Animation sequence terminator.
  $C821,$01 Animation sequence terminator.
N $C822 Sprite #N$31, Frame #N$01 (control byte).
  $C822,$01 Control data.
  $C823,$01 Frame #N$01 terminator.
  $C824,$01 Animation sequence terminator.
N $C825 Sprite #N$32, Frame #N$01 (control byte).
  $C825,$01 Control data.
  $C826,$01 Frame #N$01 terminator.
N $C827 Sprite #N$32, Frame #N$02 ($10 bytes).
  $C827,$02 X/ Y position offsets.
  $C829,$0E Pixel/ control data.
  $C837,$01 Frame #N$02 terminator.
N $C838 Sprite #N$32, Frame #N$03 ($14 bytes).
  $C838,$02 X/ Y position offsets.
  $C83A,$12 Pixel/ control data.
  $C84C,$01 Animation sequence terminator.
N $C84D Sprite #N$33, Frame #N$01 ($03 bytes).
  $C84D,$02 X/ Y position offsets.
  $C84F,$01 Pixel/ control data.
  $C850,$01 Animation sequence terminator.
N $C851 Sprite #N$34, Frame #N$01 (control byte).
  $C851,$01 Control data.
  $C852,$01 Frame #N$01 terminator.
N $C853 Sprite #N$34, Frame #N$02 ($12 bytes).
  $C853,$02 X/ Y position offsets.
  $C855,$10 Pixel/ control data.
  $C865,$01 Frame #N$02 terminator.
  $C866,$01 Animation sequence terminator.
N $C867 Sprite #N$35, Frame #N$01 ($1A bytes).
  $C867,$02 X/ Y position offsets.
  $C869,$18 Pixel/ control data.
  $C881,$01 Frame #N$01 terminator.
N $C882 Sprite #N$35, Frame #N$02 ($18 bytes).
  $C882,$02 X/ Y position offsets.
  $C884,$16 Pixel/ control data.
  $C89A,$01 Animation sequence terminator.
N $C89B Sprite #N$36, Frame #N$01 (control byte).
  $C89B,$01 Control data.
  $C89C,$01 Frame #N$01 terminator.
N $C89D Sprite #N$36, Frame #N$02 ($0E bytes).
  $C89D,$02 X/ Y position offsets.
  $C89F,$0C Pixel/ control data.
  $C8AB,$01 Animation sequence terminator.
N $C8AC Sprite #N$37, Frame #N$01 ($03 bytes).
  $C8AC,$02 X/ Y position offsets.
  $C8AE,$01 Pixel/ control data.
  $C8AF,$01 Frame #N$01 terminator.
  $C8B0,$01 Animation sequence terminator.
N $C8B1 Sprite #N$38, Frame #N$01 ($1A bytes).
  $C8B1,$02 X/ Y position offsets.
  $C8B3,$18 Pixel/ control data.
  $C8CB,$01 Frame #N$01 terminator.
N $C8CC Sprite #N$38, Frame #N$02 ($14 bytes).
  $C8CC,$02 X/ Y position offsets.
  $C8CE,$12 Pixel/ control data.
  $C8E0,$01 Animation sequence terminator.
N $C8E1 Sprite #N$39, Frame #N$01 ($03 bytes).
  $C8E1,$02 X/ Y position offsets.
  $C8E3,$01 Pixel/ control data.
  $C8E4,$01 Animation sequence terminator.
N $C8E5 Sprite #N$3A, Frame #N$01 (control byte).
  $C8E5,$01 Control data.
  $C8E6,$01 Frame #N$01 terminator.
N $C8E7 Sprite #N$3A, Frame #N$02 ($12 bytes).
  $C8E7,$02 X/ Y position offsets.
  $C8E9,$10 Pixel/ control data.
  $C8F9,$01 Frame #N$02 terminator.
  $C8FA,$01 Animation sequence terminator.
N $C8FB Sprite #N$3B, Frame #N$01 ($1A bytes).
  $C8FB,$02 X/ Y position offsets.
  $C8FD,$18 Pixel/ control data.
  $C915,$01 Frame #N$01 terminator.
N $C916 Sprite #N$3B, Frame #N$02 ($11 bytes).
  $C916,$02 X/ Y position offsets.
  $C918,$0F Pixel/ control data.
  $C927,$01 Animation sequence terminator.
  $C928,$01 Animation sequence terminator.
  $C929,$01 Animation sequence terminator.
  $C92A,$01 Animation sequence terminator.
N $C92B Sprite #N$3F, Frame #N$01 ($03 bytes).
  $C92B,$02 X/ Y position offsets.
  $C92D,$01 Pixel/ control data.
  $C92E,$01 Animation sequence terminator.
N $C92F Sprite #N$40, Frame #N$01 (control byte).
  $C92F,$01 Control data.
  $C930,$01 Frame #N$01 terminator.
N $C931 Sprite #N$40, Frame #N$02 ($06 bytes).
  $C931,$02 X/ Y position offsets.
  $C933,$04 Pixel/ control data.
  $C937,$01 Animation sequence terminator.
  $C938,$01 Animation sequence terminator.
  $C939,$01 Animation sequence terminator.
N $C93A Sprite #N$43, Frame #N$01 (control byte).
  $C93A,$01 Control data.
  $C93B,$01 Frame #N$01 terminator.
  $C93C,$01 Animation sequence terminator.
  $C93D,$01 Frame #N$01 terminator.
N $C93E Sprite #N$44, Frame #N$02 ($11 bytes).
  $C93E,$02 X/ Y position offsets.
  $C940,$0F Pixel/ control data.
  $C94F,$01 Frame #N$02 terminator.
N $C950 Sprite #N$44, Frame #N$03 (control byte).
  $C950,$01 Control data.
  $C951,$01 Frame #N$03 terminator.
N $C952 Sprite #N$44, Frame #N$04 ($18 bytes).
  $C952,$02 X/ Y position offsets.
  $C954,$16 Pixel/ control data.
  $C96A,$01 Frame #N$04 terminator.
N $C96B Sprite #N$44, Frame #N$05 ($0B bytes).
  $C96B,$02 X/ Y position offsets.
  $C96D,$09 Pixel/ control data.
  $C976,$01 Animation sequence terminator.
  $C977,$01 Animation sequence terminator.
  $C978,$01 Animation sequence terminator.
  $C979,$01 Animation sequence terminator.
N $C97A Sprite #N$48, Frame #N$01 ($05 bytes).
  $C97A,$02 X/ Y position offsets.
  $C97C,$03 Pixel/ control data.
  $C97F,$01 Animation sequence terminator.
N $C980 Sprite #N$49, Frame #N$01 ($03 bytes).
  $C980,$02 X/ Y position offsets.
  $C982,$01 Pixel/ control data.
  $C983,$01 Animation sequence terminator.
N $C984 Sprite #N$4A, Frame #N$01 (control byte).
  $C984,$01 Control data.
  $C985,$01 Frame #N$01 terminator.
  $C986,$01 Animation sequence terminator.
N $C987 Sprite #N$4B, Frame #N$01.
  $C987,$02 X/ Y position offsets.
  $C989,$08 Pixel data (2 character rows × 4 bytes each).
  $C991,$01 Frame #N$01 terminator.
  $C992,$01 Frame #N$02 terminator.
N $C993 Sprite #N$4B, Frame #N$03 ($09 bytes).
  $C993,$02 X/ Y position offsets.
  $C995,$07 Pixel/ control data.
  $C99C,$01 Frame #N$03 terminator.
  $C99D,$01 Animation sequence terminator.
N $C99E Sprite #N$4C, Frame #N$01.
  $C99E,$02 X/ Y position offsets.
  $C9A0,$08 Pixel data (2 character rows × 4 bytes each).
  $C9A8,$01 Frame #N$01 terminator.
  $C9A9,$01 Frame #N$02 terminator.
N $C9AA Sprite #N$4C, Frame #N$03 ($09 bytes).
  $C9AA,$02 X/ Y position offsets.
  $C9AC,$07 Pixel/ control data.
  $C9B3,$01 Frame #N$03 terminator.
  $C9B4,$01 Animation sequence terminator.
N $C9B5 Sprite #N$4D, Frame #N$01 ($12 bytes).
  $C9B5,$02 X/ Y position offsets.
  $C9B7,$10 Pixel/ control data.
  $C9C7,$01 Frame #N$01 terminator.
  $C9C8,$01 Frame #N$02 terminator.
  $C9C9,$01 Frame #N$03 terminator.
N $C9CA Sprite #N$4D, Frame #N$04 ($08 bytes).
  $C9CA,$02 X/ Y position offsets.
  $C9CC,$06 Pixel/ control data.
  $C9D2,$01 Frame #N$04 terminator.
  $C9D3,$01 Animation sequence terminator.
N $C9D4 Sprite #N$4E, Frame #N$01.
  $C9D4,$02 X/ Y position offsets.
  $C9D6,$08 Pixel data (2 character rows × 4 bytes each).
  $C9DE,$01 Animation sequence terminator.
N $C9DF Sprite #N$4F, Frame #N$01 (position only).
  $C9DF,$02 X/ Y position offsets.
  $C9E1,$01 Animation sequence terminator.
N $C9E2 Sprite #N$50, Frame #N$01 ($04 bytes).
  $C9E2,$02 X/ Y position offsets.
  $C9E4,$02 Pixel/ control data.
  $C9E6,$01 Frame #N$01 terminator.
  $C9E7,$01 Frame #N$02 terminator.
  $C9E8,$01 Frame #N$03 terminator.
N $C9E9 Sprite #N$50, Frame #N$04 ($10 bytes).
  $C9E9,$02 X/ Y position offsets.
  $C9EB,$0E Pixel/ control data.
  $C9F9,$01 Frame #N$04 terminator.
  $C9FA,$01 Animation sequence terminator.
N $C9FB Sprite #N$51, Frame #N$01 ($0B bytes).
  $C9FB,$02 X/ Y position offsets.
  $C9FD,$09 Pixel/ control data.
  $CA06,$01 Frame #N$01 terminator.
  $CA07,$01 Frame #N$02 terminator.
  $CA08,$01 Frame #N$03 terminator.
N $CA09 Sprite #N$51, Frame #N$04 ($10 bytes).
  $CA09,$02 X/ Y position offsets.
  $CA0B,$0E Pixel/ control data.
  $CA19,$01 Frame #N$04 terminator.
  $CA1A,$01 Animation sequence terminator.
N $CA1B Sprite #N$52, Frame #N$01 ($0B bytes).
  $CA1B,$02 X/ Y position offsets.
  $CA1D,$09 Pixel/ control data.
  $CA26,$01 Animation sequence terminator.
  $CA27,$01 Animation sequence terminator.
  $CA28,$01 Animation sequence terminator.
N $CA29 Sprite #N$55, Frame #N$01 ($04 bytes).
  $CA29,$02 X/ Y position offsets.
  $CA2B,$02 Pixel/ control data.
  $CA2D,$01 Frame #N$01 terminator.
  $CA2E,$01 Frame #N$02 terminator.
  $CA2F,$01 Frame #N$03 terminator.
N $CA30 Sprite #N$55, Frame #N$04 ($18 bytes).
  $CA30,$02 X/ Y position offsets.
  $CA32,$16 Pixel/ control data.
  $CA48,$01 Frame #N$04 terminator.
  $CA49,$01 Frame #N$05 terminator.
N $CA4A Sprite #N$55, Frame #N$06 ($19 bytes).
  $CA4A,$02 X/ Y position offsets.
  $CA4C,$17 Pixel/ control data.
  $CA63,$01 Frame #N$06 terminator.
  $CA64,$01 Animation sequence terminator.
N $CA65 Sprite #N$56, Frame #N$01.
  $CA65,$02 X/ Y position offsets.
  $CA67,$08 Pixel data (2 character rows × 4 bytes each).
  $CA6F,$01 Frame #N$01 terminator.
  $CA70,$01 Frame #N$02 terminator.
N $CA71 Sprite #N$56, Frame #N$03 ($19 bytes).
  $CA71,$02 X/ Y position offsets.
  $CA73,$17 Pixel/ control data.
  $CA8A,$01 Frame #N$03 terminator.
  $CA8B,$01 Frame #N$04 terminator.
N $CA8C Sprite #N$56, Frame #N$05 ($19 bytes).
  $CA8C,$02 X/ Y position offsets.
  $CA8E,$17 Pixel/ control data.
  $CAA5,$01 Frame #N$05 terminator.
  $CAA6,$01 Animation sequence terminator.
N $CAA7 Sprite #N$57, Frame #N$01.
  $CAA7,$02 X/ Y position offsets.
  $CAA9,$08 Pixel data (2 character rows × 4 bytes each).
  $CAB1,$01 Frame #N$01 terminator.
  $CAB2,$01 Frame #N$02 terminator.
N $CAB3 Sprite #N$57, Frame #N$03 ($10 bytes).
  $CAB3,$02 X/ Y position offsets.
  $CAB5,$0E Pixel/ control data.
  $CAC3,$01 Animation sequence terminator.
  $CAC4,$01 Animation sequence terminator.
  $CAC5,$01 Animation sequence terminator.
N $CAC6 Sprite #N$5A, Frame #N$01 ($06 bytes).
  $CAC6,$02 X/ Y position offsets.
  $CAC8,$04 Pixel/ control data.
  $CACC,$01 Frame #N$01 terminator.
  $CACD,$01 Frame #N$02 terminator.
N $CACE Sprite #N$5A, Frame #N$03 ($19 bytes).
  $CACE,$02 X/ Y position offsets.
  $CAD0,$17 Pixel/ control data.
  $CAE7,$01 Frame #N$03 terminator.
  $CAE8,$01 Animation sequence terminator.
N $CAE9 Sprite #N$5B, Frame #N$01 (control byte).
  $CAE9,$01 Control data.
  $CAEA,$01 Frame #N$01 terminator.
N $CAEB Sprite #N$5B, Frame #N$02 ($07 bytes).
  $CAEB,$02 X/ Y position offsets.
  $CAED,$05 Pixel/ control data.
  $CAF2,$01 Animation sequence terminator.
N $CAF3 Sprite #N$5C, Frame #N$01 ($08 bytes).
  $CAF3,$02 X/ Y position offsets.
  $CAF5,$06 Pixel/ control data.
  $CAFB,$01 Frame #N$01 terminator.
  $CAFC,$01 Frame #N$02 terminator.
N $CAFD Sprite #N$5C, Frame #N$03 ($0C bytes).
  $CAFD,$02 X/ Y position offsets.
  $CAFF,$0A Pixel/ control data.
  $CB09,$01 Animation sequence terminator.
N $CB0A Sprite #N$5D, Frame #N$01 ($04 bytes).
  $CB0A,$02 X/ Y position offsets.
  $CB0C,$02 Pixel/ control data.
  $CB0E,$01 Frame #N$01 terminator.
  $CB0F,$01 Frame #N$02 terminator.
  $CB10,$01 Frame #N$03 terminator.
N $CB11 Sprite #N$5D, Frame #N$04 ($03 bytes).
  $CB11,$02 X/ Y position offsets.
  $CB13,$01 Pixel/ control data.
  $CB14,$01 Animation sequence terminator.
N $CB15 Sprite #N$5E, Frame #N$01 ($05 bytes).
  $CB15,$02 X/ Y position offsets.
  $CB17,$03 Pixel/ control data.
  $CB1A,$01 Animation sequence terminator.
  $CB1B,$01 Animation sequence terminator.
N $CB1C Sprite #N$60, Frame #N$01 ($0D bytes).
  $CB1C,$02 X/ Y position offsets.
  $CB1E,$0B Pixel/ control data.
  $CB29,$01 Frame #N$01 terminator.
  $CB2A,$01 Animation sequence terminator.
N $CB2B Sprite #N$61, Frame #N$01 (control byte).
  $CB2B,$01 Control data.
  $CB2C,$01 Frame #N$01 terminator.
N $CB2D Sprite #N$61, Frame #N$02 ($08 bytes).
  $CB2D,$02 X/ Y position offsets.
  $CB2F,$06 Pixel/ control data.
  $CB35,$01 Animation sequence terminator.
N $CB36 Sprite #N$62, Frame #N$01 ($07 bytes).
  $CB36,$02 X/ Y position offsets.
  $CB38,$05 Pixel/ control data.
  $CB3D,$01 Frame #N$01 terminator.
  $CB3E,$01 Frame #N$02 terminator.
N $CB3F Sprite #N$62, Frame #N$03 ($11 bytes).
  $CB3F,$02 X/ Y position offsets.
  $CB41,$0F Pixel/ control data.
  $CB50,$01 Frame #N$03 terminator.
  $CB51,$01 Frame #N$04 terminator.
N $CB52 Sprite #N$62, Frame #N$05 ($10 bytes).
  $CB52,$02 X/ Y position offsets.
  $CB54,$0E Pixel/ control data.
  $CB62,$01 Animation sequence terminator.
  $CB63,$01 Animation sequence terminator.
N $CB64 Sprite #N$64, Frame #N$01 ($07 bytes).
  $CB64,$02 X/ Y position offsets.
  $CB66,$05 Pixel/ control data.
  $CB6B,$01 Frame #N$01 terminator.
  $CB6C,$01 Frame #N$02 terminator.
N $CB6D Sprite #N$64, Frame #N$03 ($09 bytes).
  $CB6D,$02 X/ Y position offsets.
  $CB6F,$07 Pixel/ control data.
  $CB76,$01 Frame #N$03 terminator.
  $CB77,$01 Animation sequence terminator.
N $CB78 Sprite #N$65, Frame #N$01 (control byte).
  $CB78,$01 Control data.
  $CB79,$01 Frame #N$01 terminator.
N $CB7A Sprite #N$65, Frame #N$02 ($10 bytes).
  $CB7A,$02 X/ Y position offsets.
  $CB7C,$0E Pixel/ control data.
  $CB8A,$01 Frame #N$02 terminator.
  $CB8B,$01 Frame #N$03 terminator.
  $CB8C,$01 Frame #N$04 terminator.
N $CB8D Sprite #N$65, Frame #N$05 ($10 bytes).
  $CB8D,$02 X/ Y position offsets.
  $CB8F,$0E Pixel/ control data.
  $CB9D,$01 Frame #N$05 terminator.
  $CB9E,$01 Frame #N$06 terminator.
  $CB9F,$01 Frame #N$07 terminator.
N $CBA0 Sprite #N$65, Frame #N$08 ($0D bytes).
  $CBA0,$02 X/ Y position offsets.
  $CBA2,$0B Pixel/ control data.
  $CBAD,$01 Animation sequence terminator.
N $CBAE Sprite #N$66, Frame #N$01.
  $CBAE,$02 X/ Y position offsets.
  $CBB0,$08 Pixel data (2 character rows × 4 bytes each).
  $CBB8,$01 Frame #N$01 terminator.
  $CBB9,$01 Frame #N$02 terminator.
  $CBBA,$01 Frame #N$03 terminator.
N $CBBB Sprite #N$66, Frame #N$04 ($08 bytes).
  $CBBB,$02 X/ Y position offsets.
  $CBBD,$06 Pixel/ control data.
  $CBC3,$01 Frame #N$04 terminator.
  $CBC4,$01 Animation sequence terminator.
N $CBC5 Sprite #N$67, Frame #N$01 (control byte).
  $CBC5,$01 Control data.
  $CBC6,$01 Frame #N$01 terminator.
N $CBC7 Sprite #N$67, Frame #N$02 ($10 bytes).
  $CBC7,$02 X/ Y position offsets.
  $CBC9,$0E Pixel/ control data.
  $CBD7,$01 Frame #N$02 terminator.
  $CBD8,$01 Frame #N$03 terminator.
  $CBD9,$01 Frame #N$04 terminator.
N $CBDA Sprite #N$67, Frame #N$05 ($10 bytes).
  $CBDA,$02 X/ Y position offsets.
  $CBDC,$0E Pixel/ control data.
  $CBEA,$01 Frame #N$05 terminator.
  $CBEB,$01 Frame #N$06 terminator.
  $CBEC,$01 Frame #N$07 terminator.
N $CBED Sprite #N$67, Frame #N$08 ($10 bytes).
  $CBED,$02 X/ Y position offsets.
  $CBEF,$0E Pixel/ control data.
  $CBFD,$01 Frame #N$08 terminator.
  $CBFE,$01 Frame #N$09 terminator.
N $CBFF Sprite #N$67, Frame #N$0A ($09 bytes).
  $CBFF,$02 X/ Y position offsets.
  $CC01,$07 Pixel/ control data.
  $CC08,$01 Frame #N$0A terminator.
  $CC09,$01 Animation sequence terminator.
N $CC0A Sprite #N$68, Frame #N$01 (control byte).
  $CC0A,$01 Control data.
  $CC0B,$01 Frame #N$01 terminator.
N $CC0C Sprite #N$68, Frame #N$02 ($10 bytes).
  $CC0C,$02 X/ Y position offsets.
  $CC0E,$0E Pixel/ control data.
  $CC1C,$01 Frame #N$02 terminator.
  $CC1D,$01 Frame #N$03 terminator.
N $CC1E Sprite #N$68, Frame #N$04 ($19 bytes).
  $CC1E,$02 X/ Y position offsets.
  $CC20,$17 Pixel/ control data.
  $CC37,$01 Frame #N$04 terminator.
  $CC38,$01 Frame #N$05 terminator.
  $CC39,$01 Frame #N$06 terminator.
N $CC3A Sprite #N$68, Frame #N$07 ($10 bytes).
  $CC3A,$02 X/ Y position offsets.
  $CC3C,$0E Pixel/ control data.
  $CC4A,$01 Frame #N$07 terminator.
  $CC4B,$01 Frame #N$08 terminator.
  $CC4C,$01 Frame #N$09 terminator.
N $CC4D Sprite #N$68, Frame #N$0A ($10 bytes).
  $CC4D,$02 X/ Y position offsets.
  $CC4F,$0E Pixel/ control data.
  $CC5D,$01 Frame #N$0A terminator.
  $CC5E,$01 Animation sequence terminator.
N $CC5F Sprite #N$69, Frame #N$01 (control byte).
  $CC5F,$01 Control data.
  $CC60,$01 Frame #N$01 terminator.
N $CC61 Sprite #N$69, Frame #N$02 ($04 bytes).
  $CC61,$02 X/ Y position offsets.
  $CC63,$02 Pixel/ control data.
  $CC65,$01 Animation sequence terminator.
  $CC66,$01 Animation sequence terminator.
N $CC67 Sprite #N$6B, Frame #N$01.
  $CC67,$02 X/ Y position offsets.
  $CC69,$08 Pixel data (2 character rows × 4 bytes each).
  $CC71,$01 Frame #N$01 terminator.
  $CC72,$01 Frame #N$02 terminator.
N $CC73 Sprite #N$6B, Frame #N$03 ($19 bytes).
  $CC73,$02 X/ Y position offsets.
  $CC75,$17 Pixel/ control data.
  $CC8C,$01 Frame #N$03 terminator.
  $CC8D,$01 Frame #N$04 terminator.
  $CC8E,$01 Frame #N$05 terminator.
N $CC8F Sprite #N$6B, Frame #N$06 ($10 bytes).
  $CC8F,$02 X/ Y position offsets.
  $CC91,$0E Pixel/ control data.
  $CC9F,$01 Frame #N$06 terminator.
  $CCA0,$01 Frame #N$07 terminator.
  $CCA1,$01 Frame #N$08 terminator.
N $CCA2 Sprite #N$6B, Frame #N$09 ($08 bytes).
  $CCA2,$02 X/ Y position offsets.
  $CCA4,$06 Pixel/ control data.
  $CCAA,$01 Frame #N$09 terminator.
  $CCAB,$01 Animation sequence terminator.
N $CCAC Sprite #N$6C, Frame #N$01 (control byte).
  $CCAC,$01 Control data.
  $CCAD,$01 Frame #N$01 terminator.
N $CCAE Sprite #N$6C, Frame #N$02 (control byte).
  $CCAE,$01 Control data.
  $CCAF,$01 Animation sequence terminator.
  $CCB0,$01 Animation sequence terminator.
  $CCB1,$01 Animation sequence terminator.
N $CCB2 Sprite #N$6F, Frame #N$01 ($0C bytes).
  $CCB2,$02 X/ Y position offsets.
  $CCB4,$0A Pixel/ control data.
  $CCBE,$01 Frame #N$01 terminator.
  $CCBF,$01 Frame #N$02 terminator.
N $CCC0 Sprite #N$6F, Frame #N$03 ($19 bytes).
  $CCC0,$02 X/ Y position offsets.
  $CCC2,$17 Pixel/ control data.
  $CCD9,$01 Frame #N$03 terminator.
  $CCDA,$01 Frame #N$04 terminator.
N $CCDB Sprite #N$6F, Frame #N$05 ($11 bytes).
  $CCDB,$02 X/ Y position offsets.
  $CCDD,$0F Pixel/ control data.
  $CCEC,$01 Frame #N$05 terminator.
  $CCED,$01 Animation sequence terminator.
N $CCEE Sprite #N$70, Frame #N$01 ($06 bytes).
  $CCEE,$02 X/ Y position offsets.
  $CCF0,$04 Pixel/ control data.
  $CCF4,$01 Animation sequence terminator.
  $CCF5,$01 Animation sequence terminator.
N $CCF6 Sprite #N$72, Frame #N$01 ($12 bytes).
  $CCF6,$02 X/ Y position offsets.
  $CCF8,$10 Pixel/ control data.
  $CD08,$01 Frame #N$01 terminator.
  $CD09,$01 Frame #N$02 terminator.
N $CD0A Sprite #N$72, Frame #N$03 ($19 bytes).
  $CD0A,$02 X/ Y position offsets.
  $CD0C,$17 Pixel/ control data.
  $CD23,$01 Frame #N$03 terminator.
  $CD24,$01 Frame #N$04 terminator.
N $CD25 Sprite #N$72, Frame #N$05 ($11 bytes).
  $CD25,$02 X/ Y position offsets.
  $CD27,$0F Pixel/ control data.
  $CD36,$01 Frame #N$05 terminator.
  $CD37,$01 Animation sequence terminator.
N $CD38 Sprite #N$73, Frame #N$01 ($1A bytes).
  $CD38,$02 X/ Y position offsets.
  $CD3A,$18 Pixel/ control data.
  $CD52,$01 Frame #N$01 terminator.
  $CD53,$01 Frame #N$02 terminator.
N $CD54 Sprite #N$73, Frame #N$03 ($19 bytes).
  $CD54,$02 X/ Y position offsets.
  $CD56,$17 Pixel/ control data.
  $CD6D,$01 Frame #N$03 terminator.
  $CD6E,$01 Frame #N$04 terminator.
N $CD6F Sprite #N$73, Frame #N$05 ($11 bytes).
  $CD6F,$02 X/ Y position offsets.
  $CD71,$0F Pixel/ control data.
  $CD80,$01 Frame #N$05 terminator.
  $CD81,$01 Animation sequence terminator.
N $CD82 Sprite #N$74, Frame #N$01 ($1A bytes).
  $CD82,$02 X/ Y position offsets.
  $CD84,$18 Pixel/ control data.
  $CD9C,$01 Frame #N$01 terminator.
  $CD9D,$01 Frame #N$02 terminator.
N $CD9E Sprite #N$74, Frame #N$03 ($19 bytes).
  $CD9E,$02 X/ Y position offsets.
  $CDA0,$17 Pixel/ control data.
  $CDB7,$01 Frame #N$03 terminator.
  $CDB8,$01 Frame #N$04 terminator.
N $CDB9 Sprite #N$74, Frame #N$05 ($09 bytes).
  $CDB9,$02 X/ Y position offsets.
  $CDBB,$07 Pixel/ control data.
  $CDC2,$01 Frame #N$05 terminator.
  $CDC3,$01 Animation sequence terminator.
N $CDC4 Sprite #N$75, Frame #N$01 ($0D bytes).
  $CDC4,$02 X/ Y position offsets.
  $CDC6,$0B Pixel/ control data.
  $CDD1,$01 Animation sequence terminator.
  $CDD2,$01 Animation sequence terminator.
N $CDD3 Sprite #N$77, Frame #N$01 ($03 bytes).
  $CDD3,$02 X/ Y position offsets.
  $CDD5,$01 Pixel/ control data.
  $CDD6,$01 Frame #N$01 terminator.
  $CDD7,$01 Frame #N$02 terminator.
  $CDD8,$01 Frame #N$03 terminator.
N $CDD9 Sprite #N$77, Frame #N$04 ($18 bytes).
  $CDD9,$02 X/ Y position offsets.
  $CDDB,$16 Pixel/ control data.
  $CDF1,$01 Frame #N$04 terminator.
  $CDF2,$01 Frame #N$05 terminator.
N $CDF3 Sprite #N$77, Frame #N$06 ($19 bytes).
  $CDF3,$02 X/ Y position offsets.
  $CDF5,$17 Pixel/ control data.
  $CE0C,$01 Frame #N$06 terminator.
  $CE0D,$01 Animation sequence terminator.
N $CE0E Sprite #N$78, Frame #N$01 ($1A bytes).
  $CE0E,$02 X/ Y position offsets.
  $CE10,$18 Pixel/ control data.
  $CE28,$01 Frame #N$01 terminator.
N $CE29 Sprite #N$78, Frame #N$02 ($1A bytes).
  $CE29,$02 X/ Y position offsets.
  $CE2B,$18 Pixel/ control data.
  $CE43,$01 Frame #N$02 terminator.
N $CE44 Sprite #N$78, Frame #N$03 (control byte).
  $CE44,$01 Control data.
  $CE45,$01 Frame #N$03 terminator.
N $CE46 Sprite #N$78, Frame #N$04 ($03 bytes).
  $CE46,$02 X/ Y position offsets.
  $CE48,$01 Pixel/ control data.
  $CE49,$01 Animation sequence terminator.
N $CE4A Sprite #N$79, Frame #N$01 ($0C bytes).
  $CE4A,$02 X/ Y position offsets.
  $CE4C,$0A Pixel/ control data.
  $CE56,$01 Frame #N$01 terminator.
  $CE57,$01 Animation sequence terminator.
N $CE58 Sprite #N$7A, Frame #N$01 ($1A bytes).
  $CE58,$02 X/ Y position offsets.
  $CE5A,$18 Pixel/ control data.
  $CE72,$01 Frame #N$01 terminator.
N $CE73 Sprite #N$7A, Frame #N$02 ($17 bytes).
  $CE73,$02 X/ Y position offsets.
  $CE75,$15 Pixel/ control data.
  $CE8A,$01 Animation sequence terminator.
N $CE8B Sprite #N$7B, Frame #N$01 (position only).
  $CE8B,$02 X/ Y position offsets.
  $CE8D,$01 Frame #N$01 terminator.
N $CE8E Sprite #N$7B, Frame #N$02 (control byte).
  $CE8E,$01 Control data.
  $CE8F,$01 Frame #N$02 terminator.
N $CE90 Sprite #N$7B, Frame #N$03 ($03 bytes).
  $CE90,$02 X/ Y position offsets.
  $CE92,$01 Pixel/ control data.
  $CE93,$01 Animation sequence terminator.
N $CE94 Sprite #N$7C, Frame #N$01 ($0C bytes).
  $CE94,$02 X/ Y position offsets.
  $CE96,$0A Pixel/ control data.
  $CEA0,$01 Frame #N$01 terminator.
  $CEA1,$01 Animation sequence terminator.
N $CEA2 Sprite #N$7D, Frame #N$01 (control byte).
  $CEA2,$01 Control data.
  $CEA3,$01 Frame #N$01 terminator.
N $CEA4 Sprite #N$7D, Frame #N$02 ($10 bytes).
  $CEA4,$02 X/ Y position offsets.
  $CEA6,$0E Pixel/ control data.
  $CEB4,$01 Frame #N$02 terminator.
N $CEB5 Sprite #N$7D, Frame #N$03 ($1A bytes).
  $CEB5,$02 X/ Y position offsets.
  $CEB7,$18 Pixel/ control data.
  $CECF,$01 Frame #N$03 terminator.
N $CED0 Sprite #N$7D, Frame #N$04 ($07 bytes).
  $CED0,$02 X/ Y position offsets.
  $CED2,$05 Pixel/ control data.
  $CED7,$01 Animation sequence terminator.
N $CED8 Sprite #N$7E, Frame #N$01 ($12 bytes).
  $CED8,$02 X/ Y position offsets.
  $CEDA,$10 Pixel/ control data.
  $CEEA,$01 Frame #N$01 terminator.
N $CEEB Sprite #N$7E, Frame #N$02.
  $CEEB,$02 X/ Y position offsets.
  $CEED,$08 Pixel data (2 character rows × 4 bytes each).
  $CEF5,$01 Frame #N$02 terminator.
  $CEF6,$01 Animation sequence terminator.
N $CEF7 Sprite #N$7F, Frame #N$01 (control byte).
  $CEF7,$01 Control data.
  $CEF8,$01 Frame #N$01 terminator.
N $CEF9 Sprite #N$7F, Frame #N$02 ($10 bytes).
  $CEF9,$02 X/ Y position offsets.
  $CEFB,$0E Pixel/ control data.
  $CF09,$01 Frame #N$02 terminator.
N $CF0A Sprite #N$7F, Frame #N$03 (control byte).
  $CF0A,$01 Control data.
  $CF0B,$01 Frame #N$03 terminator.
N $CF0C Sprite #N$7F, Frame #N$04 ($10 bytes).
  $CF0C,$02 X/ Y position offsets.
  $CF0E,$0E Pixel/ control data.
  $CF1C,$01 Frame #N$04 terminator.
N $CF1D Sprite #N$7F, Frame #N$05 (control byte).
  $CF1D,$01 Control data.
  $CF1E,$01 Frame #N$05 terminator.
N $CF1F Sprite #N$7F, Frame #N$06 ($0D bytes).
  $CF1F,$02 X/ Y position offsets.
  $CF21,$0B Pixel/ control data.
  $CF2C,$01 Animation sequence terminator.
N $CF2D Sprite #N$80, Frame #N$01 (position only).
  $CF2D,$02 X/ Y position offsets.
  $CF2F,$01 Frame #N$01 terminator.
N $CF30 Sprite #N$80, Frame #N$02.
  $CF30,$02 X/ Y position offsets.
  $CF32,$08 Pixel data (2 character rows × 4 bytes each).
  $CF3A,$01 Frame #N$02 terminator.
  $CF3B,$01 Animation sequence terminator.
N $CF3C Sprite #N$81, Frame #N$01 ($12 bytes).
  $CF3C,$02 X/ Y position offsets.
  $CF3E,$10 Pixel/ control data.
  $CF4E,$01 Frame #N$01 terminator.
N $CF4F Sprite #N$81, Frame #N$02 ($1A bytes).
  $CF4F,$02 X/ Y position offsets.
  $CF51,$18 Pixel/ control data.
  $CF69,$01 Frame #N$02 terminator.
N $CF6A Sprite #N$81, Frame #N$03 ($07 bytes).
  $CF6A,$02 X/ Y position offsets.
  $CF6C,$05 Pixel/ control data.
  $CF71,$01 Animation sequence terminator.
  $CF72,$01 Animation sequence terminator.
N $CF73 Sprite #N$83, Frame #N$01 ($11 bytes).
  $CF73,$02 X/ Y position offsets.
  $CF75,$0F Pixel/ control data.
  $CF84,$01 Frame #N$01 terminator.
  $CF85,$01 Animation sequence terminator.
N $CF86 Sprite #N$84, Frame #N$01 ($12 bytes).
  $CF86,$02 X/ Y position offsets.
  $CF88,$10 Pixel/ control data.
  $CF98,$01 Frame #N$01 terminator.
N $CF99 Sprite #N$84, Frame #N$02 ($1A bytes).
  $CF99,$02 X/ Y position offsets.
  $CF9B,$18 Pixel/ control data.
  $CFB3,$01 Frame #N$02 terminator.
N $CFB4 Sprite #N$84, Frame #N$03 ($0C bytes).
  $CFB4,$02 X/ Y position offsets.
  $CFB6,$0A Pixel/ control data.
  $CFC0,$01 Animation sequence terminator.
N $CFC1 Sprite #N$85, Frame #N$01 ($0D bytes).
  $CFC1,$02 X/ Y position offsets.
  $CFC3,$0B Pixel/ control data.
  $CFCE,$01 Frame #N$01 terminator.
  $CFCF,$01 Animation sequence terminator.
N $CFD0 Sprite #N$86, Frame #N$01 ($12 bytes).
  $CFD0,$02 X/ Y position offsets.
  $CFD2,$10 Pixel/ control data.
  $CFE2,$01 Frame #N$01 terminator.
N $CFE3 Sprite #N$86, Frame #N$02 (control byte).
  $CFE3,$01 Control data.
  $CFE4,$01 Frame #N$02 terminator.
N $CFE5 Sprite #N$86, Frame #N$03 ($18 bytes).
  $CFE5,$02 X/ Y position offsets.
  $CFE7,$16 Pixel/ control data.
  $CFFD,$01 Frame #N$03 terminator.
N $CFFE Sprite #N$86, Frame #N$04 ($1A bytes).
  $CFFE,$02 X/ Y position offsets.
  $D000,$18 Pixel/ control data.
  $D018,$01 Frame #N$04 terminator.
  $D019,$01 Animation sequence terminator.
N $D01A Sprite #N$87, Frame #N$01 ($1A bytes).
  $D01A,$02 X/ Y position offsets.
  $D01C,$18 Pixel/ control data.
  $D034,$01 Frame #N$01 terminator.
N $D035 Sprite #N$87, Frame #N$02 ($1A bytes).
  $D035,$02 X/ Y position offsets.
  $D037,$18 Pixel/ control data.
  $D04F,$01 Frame #N$02 terminator.
N $D050 Sprite #N$87, Frame #N$03 ($12 bytes).
  $D050,$02 X/ Y position offsets.
  $D052,$10 Pixel/ control data.
  $D062,$01 Frame #N$03 terminator.
N $D063 Sprite #N$87, Frame #N$04 (control byte).
  $D063,$01 Control data.
  $D064,$01 Frame #N$04 terminator.
N $D065 Sprite #N$87, Frame #N$05 ($10 bytes).
  $D065,$02 X/ Y position offsets.
  $D067,$0E Pixel/ control data.
  $D075,$01 Frame #N$05 terminator.
  $D076,$01 Animation sequence terminator.
N $D077 Sprite #N$88, Frame #N$01 ($05 bytes).
  $D077,$02 X/ Y position offsets.
  $D079,$03 Pixel/ control data.
  $D07C,$01 Animation sequence terminator.
N $D07D Sprite #N$89, Frame #N$01 ($04 bytes).
  $D07D,$02 X/ Y position offsets.
  $D07F,$02 Pixel/ control data.
  $D081,$01 Frame #N$01 terminator.
N $D082 Sprite #N$89, Frame #N$02 (control byte).
  $D082,$01 Control data.
  $D083,$01 Frame #N$02 terminator.
N $D084 Sprite #N$89, Frame #N$03 ($10 bytes).
  $D084,$02 X/ Y position offsets.
  $D086,$0E Pixel/ control data.
  $D094,$01 Frame #N$03 terminator.
N $D095 Sprite #N$89, Frame #N$04 (control byte).
  $D095,$01 Control data.
  $D096,$01 Frame #N$04 terminator.
N $D097 Sprite #N$89, Frame #N$05 ($06 bytes).
  $D097,$02 X/ Y position offsets.
  $D099,$04 Pixel/ control data.
  $D09D,$01 Animation sequence terminator.
  $D09E,$01 Animation sequence terminator.
N $D09F Sprite #N$8B, Frame #N$01 ($08 bytes).
  $D09F,$02 X/ Y position offsets.
  $D0A1,$06 Pixel/ control data.
  $D0A7,$01 Frame #N$01 terminator.
N $D0A8 Sprite #N$8B, Frame #N$02 (control byte).
  $D0A8,$01 Control data.
  $D0A9,$01 Frame #N$02 terminator.
N $D0AA Sprite #N$8B, Frame #N$03 ($10 bytes).
  $D0AA,$02 X/ Y position offsets.
  $D0AC,$0E Pixel/ control data.
  $D0BA,$01 Frame #N$03 terminator.
N $D0BB Sprite #N$8B, Frame #N$04 (control byte).
  $D0BB,$01 Control data.
  $D0BC,$01 Frame #N$04 terminator.
N $D0BD Sprite #N$8B, Frame #N$05 ($0E bytes).
  $D0BD,$02 X/ Y position offsets.
  $D0BF,$0C Pixel/ control data.
  $D0CB,$01 Animation sequence terminator.
N $D0CC Sprite #N$8C, Frame #N$01 (control byte).
  $D0CC,$01 Control data.
  $D0CD,$01 Frame #N$01 terminator.
  $D0CE,$01 Animation sequence terminator.
N $D0CF Sprite #N$8D, Frame #N$01 ($12 bytes).
  $D0CF,$02 X/ Y position offsets.
  $D0D1,$10 Pixel/ control data.
  $D0E1,$01 Frame #N$01 terminator.
N $D0E2 Sprite #N$8D, Frame #N$02 (control byte).
  $D0E2,$01 Control data.
  $D0E3,$01 Frame #N$02 terminator.
N $D0E4 Sprite #N$8D, Frame #N$03 ($0F bytes).
  $D0E4,$02 X/ Y position offsets.
  $D0E6,$0D Pixel/ control data.
  $D0F3,$01 Animation sequence terminator.
N $D0F4 Sprite #N$8E, Frame #N$01 ($08 bytes).
  $D0F4,$02 X/ Y position offsets.
  $D0F6,$06 Pixel/ control data.
  $D0FC,$01 Frame #N$01 terminator.
N $D0FD Sprite #N$8E, Frame #N$02 (control byte).
  $D0FD,$01 Control data.
  $D0FE,$01 Frame #N$02 terminator.
N $D0FF Sprite #N$8E, Frame #N$03 ($0F bytes).
  $D0FF,$02 X/ Y position offsets.
  $D101,$0D Pixel/ control data.
  $D10E,$01 Animation sequence terminator.
  $D10F,$01 Frame #N$01 terminator.
  $D110,$01 Animation sequence terminator.
N $D111 Sprite #N$90, Frame #N$01 ($12 bytes).
  $D111,$02 X/ Y position offsets.
  $D113,$10 Pixel/ control data.
  $D123,$01 Frame #N$01 terminator.
N $D124 Sprite #N$90, Frame #N$02 (control byte).
  $D124,$01 Control data.
  $D125,$01 Frame #N$02 terminator.
N $D126 Sprite #N$90, Frame #N$03 ($0F bytes).
  $D126,$02 X/ Y position offsets.
  $D128,$0D Pixel/ control data.
  $D135,$01 Animation sequence terminator.
N $D136 Sprite #N$91, Frame #N$01 ($08 bytes).
  $D136,$02 X/ Y position offsets.
  $D138,$06 Pixel/ control data.
  $D13E,$01 Frame #N$01 terminator.
N $D13F Sprite #N$91, Frame #N$02 ($19 bytes).
  $D13F,$02 X/ Y position offsets.
  $D141,$17 Pixel/ control data.
  $D158,$01 Animation sequence terminator.
  $D159,$01 Frame #N$01 terminator.
N $D15A Sprite #N$92, Frame #N$02 ($12 bytes).
  $D15A,$02 X/ Y position offsets.
  $D15C,$10 Pixel/ control data.
  $D16C,$01 Frame #N$02 terminator.
  $D16D,$01 Animation sequence terminator.
N $D16E Sprite #N$93, Frame #N$01 (control byte).
  $D16E,$01 Control data.
  $D16F,$01 Frame #N$01 terminator.
N $D170 Sprite #N$93, Frame #N$02 ($08 bytes).
  $D170,$02 X/ Y position offsets.
  $D172,$06 Pixel/ control data.
  $D178,$01 Frame #N$02 terminator.
N $D179 Sprite #N$93, Frame #N$03 ($12 bytes).
  $D179,$02 X/ Y position offsets.
  $D17B,$10 Pixel/ control data.
  $D18B,$01 Frame #N$03 terminator.
N $D18C Sprite #N$93, Frame #N$04 (control byte).
  $D18C,$01 Control data.
  $D18D,$01 Frame #N$04 terminator.
N $D18E Sprite #N$93, Frame #N$05 ($10 bytes).
  $D18E,$02 X/ Y position offsets.
  $D190,$0E Pixel/ control data.
  $D19E,$01 Frame #N$05 terminator.
N $D19F Sprite #N$93, Frame #N$06 (control byte).
  $D19F,$01 Control data.
  $D1A0,$01 Frame #N$06 terminator.
N $D1A1 Sprite #N$93, Frame #N$07 ($05 bytes).
  $D1A1,$02 X/ Y position offsets.
  $D1A3,$03 Pixel/ control data.
  $D1A6,$01 Animation sequence terminator.
  $D1A7,$01 Animation sequence terminator.
N $D1A8 Sprite #N$95, Frame #N$01 ($03 bytes).
  $D1A8,$02 X/ Y position offsets.
  $D1AA,$01 Pixel/ control data.
  $D1AB,$01 Animation sequence terminator.
N $D1AC Sprite #N$96, Frame #N$01 ($04 bytes).
  $D1AC,$02 X/ Y position offsets.
  $D1AE,$02 Pixel/ control data.
  $D1B0,$01 Animation sequence terminator.
  $D1B1,$01 Frame #N$01 terminator.
N $D1B2 Sprite #N$97, Frame #N$02.
  $D1B2,$02 X/ Y position offsets.
  $D1B4,$08 Pixel data (2 character rows × 4 bytes each).
  $D1BC,$01 Frame #N$02 terminator.
N $D1BD Sprite #N$97, Frame #N$03.
  $D1BD,$02 X/ Y position offsets.
  $D1BF,$08 Pixel data (2 character rows × 4 bytes each).
  $D1C7,$01 Frame #N$03 terminator.
N $D1C8 Sprite #N$97, Frame #N$04 ($12 bytes).
  $D1C8,$02 X/ Y position offsets.
  $D1CA,$10 Pixel/ control data.
  $D1DA,$01 Frame #N$04 terminator.
  $D1DB,$01 Animation sequence terminator.
N $D1DC Sprite #N$98, Frame #N$01.
  $D1DC,$02 X/ Y position offsets.
  $D1DE,$08 Pixel data (2 character rows × 4 bytes each).
  $D1E6,$01 Frame #N$01 terminator.
N $D1E7 Sprite #N$98, Frame #N$02 ($09 bytes).
  $D1E7,$02 X/ Y position offsets.
  $D1E9,$07 Pixel/ control data.
  $D1F0,$01 Animation sequence terminator.
  $D1F1,$01 Frame #N$01 terminator.
N $D1F2 Sprite #N$99, Frame #N$02 (control byte).
  $D1F2,$01 Control data.
  $D1F3,$01 Frame #N$02 terminator.
N $D1F4 Sprite #N$99, Frame #N$03 ($10 bytes).
  $D1F4,$02 X/ Y position offsets.
  $D1F6,$0E Pixel/ control data.
  $D204,$01 Frame #N$03 terminator.
N $D205 Sprite #N$99, Frame #N$04 ($09 bytes).
  $D205,$02 X/ Y position offsets.
  $D207,$07 Pixel/ control data.
  $D20E,$01 Animation sequence terminator.
  $D20F,$01 Frame #N$01 terminator.
N $D210 Sprite #N$9A, Frame #N$02.
  $D210,$02 X/ Y position offsets.
  $D212,$08 Pixel data (2 character rows × 4 bytes each).
  $D21A,$01 Frame #N$02 terminator.
N $D21B Sprite #N$9A, Frame #N$03 ($12 bytes).
  $D21B,$02 X/ Y position offsets.
  $D21D,$10 Pixel/ control data.
  $D22D,$01 Frame #N$03 terminator.
N $D22E Sprite #N$9A, Frame #N$04 (control byte).
  $D22E,$01 Control data.
  $D22F,$01 Frame #N$04 terminator.
N $D230 Sprite #N$9A, Frame #N$05 ($05 bytes).
  $D230,$02 X/ Y position offsets.
  $D232,$03 Pixel/ control data.
  $D235,$01 Animation sequence terminator.
  $D236,$01 Animation sequence terminator.
N $D237 Sprite #N$9C, Frame #N$01 ($08 bytes).
  $D237,$02 X/ Y position offsets.
  $D239,$06 Pixel/ control data.
  $D23F,$01 Animation sequence terminator.
  $D240,$01 Frame #N$01 terminator.
  $D241,$01 Animation sequence terminator.
N $D242 Sprite #N$9E, Frame #N$01 (control byte).
  $D242,$01 Control data.
  $D243,$01 Frame #N$01 terminator.
N $D244 Sprite #N$9E, Frame #N$02 ($08 bytes).
  $D244,$02 X/ Y position offsets.
  $D246,$06 Pixel/ control data.
  $D24C,$01 Frame #N$02 terminator.
N $D24D Sprite #N$9E, Frame #N$03 ($12 bytes).
  $D24D,$02 X/ Y position offsets.
  $D24F,$10 Pixel/ control data.
  $D25F,$01 Frame #N$03 terminator.
N $D260 Sprite #N$9E, Frame #N$04 (control byte).
  $D260,$01 Control data.
  $D261,$01 Frame #N$04 terminator.
N $D262 Sprite #N$9E, Frame #N$05 ($10 bytes).
  $D262,$02 X/ Y position offsets.
  $D264,$0E Pixel/ control data.
  $D272,$01 Frame #N$05 terminator.
N $D273 Sprite #N$9E, Frame #N$06 (control byte).
  $D273,$01 Control data.
  $D274,$01 Frame #N$06 terminator.
N $D275 Sprite #N$9E, Frame #N$07 ($05 bytes).
  $D275,$02 X/ Y position offsets.
  $D277,$03 Pixel/ control data.
  $D27A,$01 Animation sequence terminator.
  $D27B,$01 Animation sequence terminator.
N $D27C Sprite #N$A0, Frame #N$01 ($03 bytes).
  $D27C,$02 X/ Y position offsets.
  $D27E,$01 Pixel/ control data.
  $D27F,$01 Animation sequence terminator.
N $D280 Sprite #N$A1, Frame #N$01 ($04 bytes).
  $D280,$02 X/ Y position offsets.
  $D282,$02 Pixel/ control data.
  $D284,$01 Animation sequence terminator.
  $D285,$01 Frame #N$01 terminator.
N $D286 Sprite #N$A2, Frame #N$02.
  $D286,$02 X/ Y position offsets.
  $D288,$08 Pixel data (2 character rows × 4 bytes each).
  $D290,$01 Frame #N$02 terminator.
N $D291 Sprite #N$A2, Frame #N$03 ($1A bytes).
  $D291,$02 X/ Y position offsets.
  $D293,$18 Pixel/ control data.
  $D2AB,$01 Frame #N$03 terminator.
N $D2AC Sprite #N$A2, Frame #N$04 ($08 bytes).
  $D2AC,$02 X/ Y position offsets.
  $D2AE,$06 Pixel/ control data.
  $D2B4,$01 Animation sequence terminator.
  $D2B5,$01 Animation sequence terminator.
  $D2B6,$01 Animation sequence terminator.
  $D2B7,$01 Animation sequence terminator.
  $D2B8,$01 Animation sequence terminator.
  $D2B9,$01 Animation sequence terminator.
  $D2BA,$01 Animation sequence terminator.
N $D2BB Sprite #N$A9, Frame #N$01 ($0B bytes).
  $D2BB,$02 X/ Y position offsets.
  $D2BD,$09 Pixel/ control data.
  $D2C6,$01 Frame #N$01 terminator.
  $D2C7,$01 Animation sequence terminator.
N $D2C8 Sprite #N$AA, Frame #N$01.
  $D2C8,$02 X/ Y position offsets.
  $D2CA,$08 Pixel data (2 character rows × 4 bytes each).
  $D2D2,$01 Frame #N$01 terminator.
N $D2D3 Sprite #N$AA, Frame #N$02 ($09 bytes).
  $D2D3,$02 X/ Y position offsets.
  $D2D5,$07 Pixel/ control data.
  $D2DC,$01 Animation sequence terminator.
  $D2DD,$01 Frame #N$01 terminator.
N $D2DE Sprite #N$AB, Frame #N$02 (control byte).
  $D2DE,$01 Control data.
  $D2DF,$01 Frame #N$02 terminator.
N $D2E0 Sprite #N$AB, Frame #N$03 ($10 bytes).
  $D2E0,$02 X/ Y position offsets.
  $D2E2,$0E Pixel/ control data.
  $D2F0,$01 Frame #N$03 terminator.
N $D2F1 Sprite #N$AB, Frame #N$04 ($09 bytes).
  $D2F1,$02 X/ Y position offsets.
  $D2F3,$07 Pixel/ control data.
  $D2FA,$01 Animation sequence terminator.
  $D2FB,$01 Frame #N$01 terminator.
N $D2FC Sprite #N$AC, Frame #N$02.
  $D2FC,$02 X/ Y position offsets.
  $D2FE,$08 Pixel data (2 character rows × 4 bytes each).
  $D306,$01 Frame #N$02 terminator.
N $D307 Sprite #N$AC, Frame #N$03 ($1A bytes).
  $D307,$02 X/ Y position offsets.
  $D309,$18 Pixel/ control data.
  $D321,$01 Frame #N$03 terminator.
  $D322,$01 Animation sequence terminator.
N $D323 Sprite #N$AD, Frame #N$01.
  $D323,$02 X/ Y position offsets.
  $D325,$08 Pixel data (2 character rows × 4 bytes each).
  $D32D,$01 Frame #N$01 terminator.
N $D32E Sprite #N$AD, Frame #N$02 ($09 bytes).
  $D32E,$02 X/ Y position offsets.
  $D330,$07 Pixel/ control data.
  $D337,$01 Animation sequence terminator.
  $D338,$01 Frame #N$01 terminator.
N $D339 Sprite #N$AE, Frame #N$02 (control byte).
  $D339,$01 Control data.
  $D33A,$01 Frame #N$02 terminator.
N $D33B Sprite #N$AE, Frame #N$03 ($10 bytes).
  $D33B,$02 X/ Y position offsets.
  $D33D,$0E Pixel/ control data.
  $D34B,$01 Frame #N$03 terminator.
N $D34C Sprite #N$AE, Frame #N$04 ($09 bytes).
  $D34C,$02 X/ Y position offsets.
  $D34E,$07 Pixel/ control data.
  $D355,$01 Animation sequence terminator.
  $D356,$01 Frame #N$01 terminator.
N $D357 Sprite #N$AF, Frame #N$02 (control byte).
  $D357,$01 Control data.
  $D358,$01 Frame #N$02 terminator.
N $D359 Sprite #N$AF, Frame #N$03 ($10 bytes).
  $D359,$02 X/ Y position offsets.
  $D35B,$0E Pixel/ control data.
  $D369,$01 Frame #N$03 terminator.
N $D36A Sprite #N$AF, Frame #N$04 ($1A bytes).
  $D36A,$02 X/ Y position offsets.
  $D36C,$18 Pixel/ control data.
  $D384,$01 Frame #N$04 terminator.
  $D385,$01 Animation sequence terminator.
N $D386 Sprite #N$B0, Frame #N$01.
  $D386,$02 X/ Y position offsets.
  $D388,$08 Pixel data (2 character rows × 4 bytes each).
  $D390,$01 Frame #N$01 terminator.
N $D391 Sprite #N$B0, Frame #N$02 ($09 bytes).
  $D391,$02 X/ Y position offsets.
  $D393,$07 Pixel/ control data.
  $D39A,$01 Animation sequence terminator.
  $D39B,$01 Frame #N$01 terminator.
N $D39C Sprite #N$B1, Frame #N$02 (control byte).
  $D39C,$01 Control data.
  $D39D,$01 Frame #N$02 terminator.
N $D39E Sprite #N$B1, Frame #N$03 ($10 bytes).
  $D39E,$02 X/ Y position offsets.
  $D3A0,$0E Pixel/ control data.
  $D3AE,$01 Frame #N$03 terminator.
N $D3AF Sprite #N$B1, Frame #N$04 ($09 bytes).
  $D3AF,$02 X/ Y position offsets.
  $D3B1,$07 Pixel/ control data.
  $D3B8,$01 Animation sequence terminator.
  $D3B9,$01 Frame #N$01 terminator.
N $D3BA Sprite #N$B2, Frame #N$02.
  $D3BA,$02 X/ Y position offsets.
  $D3BC,$08 Pixel data (2 character rows × 4 bytes each).
  $D3C4,$01 Frame #N$02 terminator.
N $D3C5 Sprite #N$B2, Frame #N$03.
  $D3C5,$02 X/ Y position offsets.
  $D3C7,$08 Pixel data (2 character rows × 4 bytes each).
  $D3CF,$01 Frame #N$03 terminator.
N $D3D0 Sprite #N$B2, Frame #N$04 (position only).
  $D3D0,$02 X/ Y position offsets.
  $D3D2,$01 Animation sequence terminator.
N $D3D3 Sprite #N$B3, Frame #N$01 ($07 bytes).
  $D3D3,$02 X/ Y position offsets.
  $D3D5,$05 Pixel/ control data.
  $D3DA,$01 Frame #N$01 terminator.
  $D3DB,$01 Animation sequence terminator.
N $D3DC Sprite #N$B4, Frame #N$01 ($12 bytes).
  $D3DC,$02 X/ Y position offsets.
  $D3DE,$10 Pixel/ control data.
  $D3EE,$01 Frame #N$01 terminator.
N $D3EF Sprite #N$B4, Frame #N$02 (control byte).
  $D3EF,$01 Control data.
  $D3F0,$01 Frame #N$02 terminator.
N $D3F1 Sprite #N$B4, Frame #N$03 ($18 bytes).
  $D3F1,$02 X/ Y position offsets.
  $D3F3,$16 Pixel/ control data.
  $D409,$01 Frame #N$03 terminator.
N $D40A Sprite #N$B4, Frame #N$04 ($1A bytes).
  $D40A,$02 X/ Y position offsets.
  $D40C,$18 Pixel/ control data.
  $D424,$01 Frame #N$04 terminator.
  $D425,$01 Animation sequence terminator.
N $D426 Sprite #N$B5, Frame #N$01.
  $D426,$02 X/ Y position offsets.
  $D428,$08 Pixel data (2 character rows × 4 bytes each).
  $D430,$01 Frame #N$01 terminator.
N $D431 Sprite #N$B5, Frame #N$02 ($1A bytes).
  $D431,$02 X/ Y position offsets.
  $D433,$18 Pixel/ control data.
  $D44B,$01 Frame #N$02 terminator.
N $D44C Sprite #N$B5, Frame #N$03 ($1A bytes).
  $D44C,$02 X/ Y position offsets.
  $D44E,$18 Pixel/ control data.
  $D466,$01 Frame #N$03 terminator.
N $D467 Sprite #N$B5, Frame #N$04 (control byte).
  $D467,$01 Control data.
  $D468,$01 Frame #N$04 terminator.
N $D469 Sprite #N$B5, Frame #N$05 (position only).
  $D469,$02 X/ Y position offsets.
  $D46B,$01 Animation sequence terminator.
  $D46C,$01 Animation sequence terminator.
  $D46D,$01 Animation sequence terminator.
N $D46E Sprite #N$B8, Frame #N$01 ($0B bytes).
  $D46E,$02 X/ Y position offsets.
  $D470,$09 Pixel/ control data.
  $D479,$01 Frame #N$01 terminator.
  $D47A,$01 Animation sequence terminator.
N $D47B Sprite #N$B9, Frame #N$01 (control byte).
  $D47B,$01 Control data.
  $D47C,$01 Frame #N$01 terminator.
N $D47D Sprite #N$B9, Frame #N$02 ($06 bytes).
  $D47D,$02 X/ Y position offsets.
  $D47F,$04 Pixel/ control data.
  $D483,$01 Animation sequence terminator.
N $D484 Sprite #N$BA, Frame #N$01 ($09 bytes).
  $D484,$02 X/ Y position offsets.
  $D486,$07 Pixel/ control data.
  $D48D,$01 Frame #N$01 terminator.
N $D48E Sprite #N$BA, Frame #N$02 ($0B bytes).
  $D48E,$02 X/ Y position offsets.
  $D490,$09 Pixel/ control data.
  $D499,$01 Animation sequence terminator.
  $D49A,$01 Animation sequence terminator.
N $D49B Sprite #N$BC, Frame #N$01 ($0D bytes).
  $D49B,$02 X/ Y position offsets.
  $D49D,$0B Pixel/ control data.
  $D4A8,$01 Frame #N$01 terminator.
N $D4A9 Sprite #N$BC, Frame #N$02 ($06 bytes).
  $D4A9,$02 X/ Y position offsets.
  $D4AB,$04 Pixel/ control data.
  $D4AF,$01 Animation sequence terminator.
  $D4B0,$01 Animation sequence terminator.
  $D4B1,$01 Animation sequence terminator.
N $D4B2 Sprite #N$BF, Frame #N$01 (position only).
  $D4B2,$02 X/ Y position offsets.
  $D4B4,$01 Animation sequence terminator.
  $D4B5,$01 Animation sequence terminator.
N $D4B6 Sprite #N$C1, Frame #N$01 ($0D bytes).
  $D4B6,$02 X/ Y position offsets.
  $D4B8,$0B Pixel/ control data.
  $D4C3,$01 Frame #N$01 terminator.
  $D4C4,$01 Animation sequence terminator.
N $D4C5 Sprite #N$C2, Frame #N$01.
  $D4C5,$02 X/ Y position offsets.
  $D4C7,$08 Pixel data (2 character rows × 4 bytes each).
  $D4CF,$01 Frame #N$01 terminator.
N $D4D0 Sprite #N$C2, Frame #N$02 ($09 bytes).
  $D4D0,$02 X/ Y position offsets.
  $D4D2,$07 Pixel/ control data.
  $D4D9,$01 Animation sequence terminator.
  $D4DA,$01 Frame #N$01 terminator.
N $D4DB Sprite #N$C3, Frame #N$02 (control byte).
  $D4DB,$01 Control data.
  $D4DC,$01 Frame #N$02 terminator.
N $D4DD Sprite #N$C3, Frame #N$03 ($10 bytes).
  $D4DD,$02 X/ Y position offsets.
  $D4DF,$0E Pixel/ control data.
  $D4ED,$01 Frame #N$03 terminator.
N $D4EE Sprite #N$C3, Frame #N$04 ($11 bytes).
  $D4EE,$02 X/ Y position offsets.
  $D4F0,$0F Pixel/ control data.
  $D4FF,$01 Animation sequence terminator.
N $D500 Sprite #N$C4, Frame #N$01 ($07 bytes).
  $D500,$02 X/ Y position offsets.
  $D502,$05 Pixel/ control data.
  $D507,$01 Animation sequence terminator.
  $D508,$01 Frame #N$01 terminator.
N $D509 Sprite #N$C5, Frame #N$02 ($1A bytes).
  $D509,$02 X/ Y position offsets.
  $D50B,$18 Pixel/ control data.
  $D523,$01 Frame #N$02 terminator.
  $D524,$01 Animation sequence terminator.
N $D525 Sprite #N$C6, Frame #N$01.
  $D525,$02 X/ Y position offsets.
  $D527,$08 Pixel data (2 character rows × 4 bytes each).
  $D52F,$01 Frame #N$01 terminator.
N $D530 Sprite #N$C6, Frame #N$02 ($09 bytes).
  $D530,$02 X/ Y position offsets.
  $D532,$07 Pixel/ control data.
  $D539,$01 Animation sequence terminator.
  $D53A,$01 Frame #N$01 terminator.
N $D53B Sprite #N$C7, Frame #N$02 ($1A bytes).
  $D53B,$02 X/ Y position offsets.
  $D53D,$18 Pixel/ control data.
  $D555,$01 Frame #N$02 terminator.
N $D556 Sprite #N$C7, Frame #N$03 ($19 bytes).
  $D556,$02 X/ Y position offsets.
  $D558,$17 Pixel/ control data.
  $D56F,$01 Animation sequence terminator.
  $D570,$01 Frame #N$01 terminator.
N $D571 Sprite #N$C8, Frame #N$02 (control byte).
  $D571,$01 Control data.
  $D572,$01 Frame #N$02 terminator.
N $D573 Sprite #N$C8, Frame #N$03 (control byte).
  $D573,$01 Control data.
  $D574,$01 Animation sequence terminator.
  $D575,$01 Animation sequence terminator.
N $D576 Sprite #N$CA, Frame #N$01 ($08 bytes).
  $D576,$02 X/ Y position offsets.
  $D578,$06 Pixel/ control data.
  $D57E,$01 Animation sequence terminator.
N $D57F Sprite #N$CB, Frame #N$01 ($04 bytes).
  $D57F,$02 X/ Y position offsets.
  $D581,$02 Pixel/ control data.
  $D583,$01 Frame #N$01 terminator.
  $D584,$01 Animation sequence terminator.
N $D585 Sprite #N$CC, Frame #N$01.
  $D585,$02 X/ Y position offsets.
  $D587,$08 Pixel data (2 character rows × 4 bytes each).
  $D58F,$01 Frame #N$01 terminator.
N $D590 Sprite #N$CC, Frame #N$02 ($09 bytes).
  $D590,$02 X/ Y position offsets.
  $D592,$07 Pixel/ control data.
  $D599,$01 Animation sequence terminator.
  $D59A,$01 Frame #N$01 terminator.
N $D59B Sprite #N$CD, Frame #N$02 ($1A bytes).
  $D59B,$02 X/ Y position offsets.
  $D59D,$18 Pixel/ control data.
  $D5B5,$01 Frame #N$02 terminator.
N $D5B6 Sprite #N$CD, Frame #N$03 (control byte).
  $D5B6,$01 Control data.
  $D5B7,$01 Frame #N$03 terminator.
N $D5B8 Sprite #N$CD, Frame #N$04 ($0F bytes).
  $D5B8,$02 X/ Y position offsets.
  $D5BA,$0D Pixel/ control data.
  $D5C7,$01 Animation sequence terminator.
  $D5C8,$01 Frame #N$01 terminator.
  $D5C9,$01 Animation sequence terminator.
N $D5CA Sprite #N$CF, Frame #N$01 (control byte).
  $D5CA,$01 Control data.
  $D5CB,$01 Frame #N$01 terminator.
N $D5CC Sprite #N$CF, Frame #N$02 ($10 bytes).
  $D5CC,$02 X/ Y position offsets.
  $D5CE,$0E Pixel/ control data.
  $D5DC,$01 Frame #N$02 terminator.
N $D5DD Sprite #N$CF, Frame #N$03 ($1A bytes).
  $D5DD,$02 X/ Y position offsets.
  $D5DF,$18 Pixel/ control data.
  $D5F7,$01 Frame #N$03 terminator.
N $D5F8 Sprite #N$CF, Frame #N$04 (control byte).
  $D5F8,$01 Control data.
  $D5F9,$01 Frame #N$04 terminator.
  $D5FA,$01 Animation sequence terminator.
  $D5FB,$01 Animation sequence terminator.
  $D5FC,$01 Animation sequence terminator.
N $D5FD Sprite #N$D2, Frame #N$01 ($0D bytes).
  $D5FD,$02 X/ Y position offsets.
  $D5FF,$0B Pixel/ control data.
  $D60A,$01 Frame #N$01 terminator.
N $D60B Sprite #N$D2, Frame #N$02 (position only).
  $D60B,$02 X/ Y position offsets.
  $D60D,$01 Animation sequence terminator.
  $D60E,$01 Animation sequence terminator.
  $D60F,$01 Animation sequence terminator.
N $D610 Sprite #N$D5, Frame #N$01 ($03 bytes).
  $D610,$02 X/ Y position offsets.
  $D612,$01 Pixel/ control data.
  $D613,$01 Animation sequence terminator.
N $D614 Sprite #N$D6, Frame #N$01 (control byte).
  $D614,$01 Control data.
  $D615,$01 Frame #N$01 terminator.
  $D616,$01 Animation sequence terminator.
N $D617 Sprite #N$D7, Frame #N$01 (control byte).
  $D617,$01 Control data.
  $D618,$01 Frame #N$01 terminator.
N $D619 Sprite #N$D7, Frame #N$02 ($10 bytes).
  $D619,$02 X/ Y position offsets.
  $D61B,$0E Pixel/ control data.
  $D629,$01 Frame #N$02 terminator.
N $D62A Sprite #N$D7, Frame #N$03 (control byte).
  $D62A,$01 Control data.
  $D62B,$01 Frame #N$03 terminator.
N $D62C Sprite #N$D7, Frame #N$04 ($10 bytes).
  $D62C,$02 X/ Y position offsets.
  $D62E,$0E Pixel/ control data.
  $D63C,$01 Frame #N$04 terminator.
  $D63D,$01 Animation sequence terminator.
N $D63E Sprite #N$D8, Frame #N$01 (control byte).
  $D63E,$01 Control data.
  $D63F,$01 Frame #N$01 terminator.
N $D640 Sprite #N$D8, Frame #N$02 ($10 bytes).
  $D640,$02 X/ Y position offsets.
  $D642,$0E Pixel/ control data.
  $D650,$01 Frame #N$02 terminator.
  $D651,$01 Animation sequence terminator.
N $D652 Sprite #N$D9, Frame #N$01 (control byte).
  $D652,$01 Control data.
  $D653,$01 Frame #N$01 terminator.
N $D654 Sprite #N$D9, Frame #N$02 ($10 bytes).
  $D654,$02 X/ Y position offsets.
  $D656,$0E Pixel/ control data.
  $D664,$01 Frame #N$02 terminator.
N $D665 Sprite #N$D9, Frame #N$03 (control byte).
  $D665,$01 Control data.
  $D666,$01 Frame #N$03 terminator.
N $D667 Sprite #N$D9, Frame #N$04 (control byte).
  $D667,$01 Control data.
  $D668,$01 Animation sequence terminator.
N $D669 Sprite #N$DA, Frame #N$01 ($0E bytes).
  $D669,$02 X/ Y position offsets.
  $D66B,$0C Pixel/ control data.
  $D677,$01 Frame #N$01 terminator.
  $D678,$01 Animation sequence terminator.
N $D679 Sprite #N$DB, Frame #N$01 (control byte).
  $D679,$01 Control data.
  $D67A,$01 Frame #N$01 terminator.
N $D67B Sprite #N$DB, Frame #N$02 ($10 bytes).
  $D67B,$02 X/ Y position offsets.
  $D67D,$0E Pixel/ control data.
  $D68B,$01 Frame #N$02 terminator.
N $D68C Sprite #N$DB, Frame #N$03 (control byte).
  $D68C,$01 Control data.
  $D68D,$01 Frame #N$03 terminator.
N $D68E Sprite #N$DB, Frame #N$04 ($05 bytes).
  $D68E,$02 X/ Y position offsets.
  $D690,$03 Pixel/ control data.
  $D693,$01 Animation sequence terminator.
N $D694 Sprite #N$DC, Frame #N$01.
  $D694,$02 X/ Y position offsets.
  $D696,$08 Pixel data (2 character rows × 4 bytes each).
  $D69E,$01 Frame #N$01 terminator.
  $D69F,$01 Animation sequence terminator.
N $D6A0 Sprite #N$DD, Frame #N$01 (control byte).
  $D6A0,$01 Control data.
  $D6A1,$01 Frame #N$01 terminator.
N $D6A2 Sprite #N$DD, Frame #N$02 ($08 bytes).
  $D6A2,$02 X/ Y position offsets.
  $D6A4,$06 Pixel/ control data.
  $D6AA,$01 Frame #N$02 terminator.
N $D6AB Sprite #N$DD, Frame #N$03 ($12 bytes).
  $D6AB,$02 X/ Y position offsets.
  $D6AD,$10 Pixel/ control data.
  $D6BD,$01 Frame #N$03 terminator.
N $D6BE Sprite #N$DD, Frame #N$04 (control byte).
  $D6BE,$01 Control data.
  $D6BF,$01 Frame #N$04 terminator.
N $D6C0 Sprite #N$DD, Frame #N$05 ($10 bytes).
  $D6C0,$02 X/ Y position offsets.
  $D6C2,$0E Pixel/ control data.
  $D6D0,$01 Frame #N$05 terminator.
  $D6D1,$01 Animation sequence terminator.
N $D6D2 Sprite #N$DE, Frame #N$01.
  $D6D2,$02 X/ Y position offsets.
  $D6D4,$08 Pixel data (2 character rows × 4 bytes each).
  $D6DC,$01 Frame #N$01 terminator.
N $D6DD Sprite #N$DE, Frame #N$02 (control byte).
  $D6DD,$01 Control data.
  $D6DE,$01 Frame #N$02 terminator.
N $D6DF Sprite #N$DE, Frame #N$03 ($10 bytes).
  $D6DF,$02 X/ Y position offsets.
  $D6E1,$0E Pixel/ control data.
  $D6EF,$01 Frame #N$03 terminator.
N $D6F0 Sprite #N$DE, Frame #N$04 (control byte).
  $D6F0,$01 Control data.
  $D6F1,$01 Frame #N$04 terminator.
N $D6F2 Sprite #N$DE, Frame #N$05 ($10 bytes).
  $D6F2,$02 X/ Y position offsets.
  $D6F4,$0E Pixel/ control data.
  $D702,$01 Frame #N$05 terminator.
  $D703,$01 Animation sequence terminator.
N $D704 Sprite #N$DF, Frame #N$01.
  $D704,$02 X/ Y position offsets.
  $D706,$08 Pixel data (2 character rows × 4 bytes each).
  $D70E,$01 Frame #N$01 terminator.
N $D70F Sprite #N$DF, Frame #N$02.
  $D70F,$02 X/ Y position offsets.
  $D711,$08 Pixel data (2 character rows × 4 bytes each).
  $D719,$01 Frame #N$02 terminator.
N $D71A Sprite #N$DF, Frame #N$03 (control byte).
  $D71A,$01 Control data.
  $D71B,$01 Frame #N$03 terminator.
N $D71C Sprite #N$DF, Frame #N$04 ($10 bytes).
  $D71C,$02 X/ Y position offsets.
  $D71E,$0E Pixel/ control data.
  $D72C,$01 Frame #N$04 terminator.
N $D72D Sprite #N$DF, Frame #N$05 (control byte).
  $D72D,$01 Control data.
  $D72E,$01 Frame #N$05 terminator.
N $D72F Sprite #N$DF, Frame #N$06 ($10 bytes).
  $D72F,$02 X/ Y position offsets.
  $D731,$0E Pixel/ control data.
  $D73F,$01 Frame #N$06 terminator.
  $D740,$01 Animation sequence terminator.
  $D741,$01 Frame #N$01 terminator.
N $D742 Sprite #N$E0, Frame #N$02 ($09 bytes).
  $D742,$02 X/ Y position offsets.
  $D744,$07 Pixel/ control data.
  $D74B,$01 Frame #N$02 terminator.
N $D74C Sprite #N$E0, Frame #N$03 (control byte).
  $D74C,$01 Control data.
  $D74D,$01 Frame #N$03 terminator.
N $D74E Sprite #N$E0, Frame #N$04 ($10 bytes).
  $D74E,$02 X/ Y position offsets.
  $D750,$0E Pixel/ control data.
  $D75E,$01 Frame #N$04 terminator.
  $D75F,$01 Animation sequence terminator.
N $D760 Sprite #N$E1, Frame #N$01 (control byte).
  $D760,$01 Control data.
  $D761,$01 Frame #N$01 terminator.
N $D762 Sprite #N$E1, Frame #N$02 ($10 bytes).
  $D762,$02 X/ Y position offsets.
  $D764,$0E Pixel/ control data.
  $D772,$01 Frame #N$02 terminator.
N $D773 Sprite #N$E1, Frame #N$03 (control byte).
  $D773,$01 Control data.
  $D774,$01 Frame #N$03 terminator.
N $D775 Sprite #N$E1, Frame #N$04 ($08 bytes).
  $D775,$02 X/ Y position offsets.
  $D777,$06 Pixel/ control data.
  $D77D,$01 Animation sequence terminator.
N $D77E Sprite #N$E2, Frame #N$01 (control byte).
  $D77E,$01 Control data.
  $D77F,$01 Animation sequence terminator.
N $D780 Sprite #N$E3, Frame #N$01 ($05 bytes).
  $D780,$02 X/ Y position offsets.
  $D782,$03 Pixel/ control data.
  $D785,$01 Frame #N$01 terminator.
  $D786,$01 Animation sequence terminator.
  $D787,$01 Frame #N$01 terminator.
N $D788 Sprite #N$E4, Frame #N$02 ($09 bytes).
  $D788,$02 X/ Y position offsets.
  $D78A,$07 Pixel/ control data.
  $D791,$01 Frame #N$02 terminator.
N $D792 Sprite #N$E4, Frame #N$03 (control byte).
  $D792,$01 Control data.
  $D793,$01 Frame #N$03 terminator.
N $D794 Sprite #N$E4, Frame #N$04 ($10 bytes).
  $D794,$02 X/ Y position offsets.
  $D796,$0E Pixel/ control data.
  $D7A4,$01 Frame #N$04 terminator.
  $D7A5,$01 Animation sequence terminator.
N $D7A6 Sprite #N$E5, Frame #N$01 (control byte).
  $D7A6,$01 Control data.
  $D7A7,$01 Frame #N$01 terminator.
N $D7A8 Sprite #N$E5, Frame #N$02 ($10 bytes).
  $D7A8,$02 X/ Y position offsets.
  $D7AA,$0E Pixel/ control data.
  $D7B8,$01 Frame #N$02 terminator.
N $D7B9 Sprite #N$E5, Frame #N$03 (control byte).
  $D7B9,$01 Control data.
  $D7BA,$01 Frame #N$03 terminator.
N $D7BB Sprite #N$E5, Frame #N$04 ($04 bytes).
  $D7BB,$02 X/ Y position offsets.
  $D7BD,$02 Pixel/ control data.
  $D7BF,$01 Animation sequence terminator.
N $D7C0 Sprite #N$E6, Frame #N$01 (control byte).
  $D7C0,$01 Control data.
  $D7C1,$01 Animation sequence terminator.
N $D7C2 Sprite #N$E7, Frame #N$01 ($09 bytes).
  $D7C2,$02 X/ Y position offsets.
  $D7C4,$07 Pixel/ control data.
  $D7CB,$01 Frame #N$01 terminator.
  $D7CC,$01 Animation sequence terminator.
N $D7CD Sprite #N$E8, Frame #N$01.
  $D7CD,$02 X/ Y position offsets.
  $D7CF,$08 Pixel data (2 character rows × 4 bytes each).
  $D7D7,$01 Frame #N$01 terminator.
N $D7D8 Sprite #N$E8, Frame #N$02 ($04 bytes).
  $D7D8,$02 X/ Y position offsets.
  $D7DA,$02 Pixel/ control data.
  $D7DC,$01 Animation sequence terminator.
N $D7DD Sprite #N$E9, Frame #N$01 ($03 bytes).
  $D7DD,$02 X/ Y position offsets.
  $D7DF,$01 Pixel/ control data.
  $D7E0,$01 Animation sequence terminator.
N $D7E1 Sprite #N$EA, Frame #N$01 (control byte).
  $D7E1,$01 Control data.
  $D7E2,$01 Frame #N$01 terminator.
  $D7E3,$01 Animation sequence terminator.
N $D7E4 Sprite #N$EB, Frame #N$01.
  $D7E4,$02 X/ Y position offsets.
  $D7E6,$08 Pixel data (2 character rows × 4 bytes each).
  $D7EE,$01 Frame #N$01 terminator.
N $D7EF Sprite #N$EB, Frame #N$02.
  $D7EF,$02 X/ Y position offsets.
  $D7F1,$08 Pixel data (2 character rows × 4 bytes each).
  $D7F9,$01 Frame #N$02 terminator.
  $D7FA,$01 Animation sequence terminator.
N $D7FB Sprite #N$EC, Frame #N$01 ($12 bytes).
  $D7FB,$02 X/ Y position offsets.
  $D7FD,$10 Pixel/ control data.
  $D80D,$01 Frame #N$01 terminator.
N $D80E Sprite #N$EC, Frame #N$02 (control byte).
  $D80E,$01 Control data.
  $D80F,$01 Frame #N$02 terminator.
N $D810 Sprite #N$EC, Frame #N$03 ($07 bytes).
  $D810,$02 X/ Y position offsets.
  $D812,$05 Pixel/ control data.
  $D817,$01 Animation sequence terminator.
N $D818 Sprite #N$ED, Frame #N$01 (position only).
  $D818,$02 X/ Y position offsets.
  $D81A,$01 Animation sequence terminator.
N $D81B Sprite #N$EE, Frame #N$01 ($05 bytes).
  $D81B,$02 X/ Y position offsets.
  $D81D,$03 Pixel/ control data.
  $D820,$01 Frame #N$01 terminator.
  $D821,$01 Animation sequence terminator.
N $D822 Sprite #N$EF, Frame #N$01 ($12 bytes).
  $D822,$02 X/ Y position offsets.
  $D824,$10 Pixel/ control data.
  $D834,$01 Frame #N$01 terminator.
N $D835 Sprite #N$EF, Frame #N$02 (control byte).
  $D835,$01 Control data.
  $D836,$01 Frame #N$02 terminator.
N $D837 Sprite #N$EF, Frame #N$03 ($10 bytes).
  $D837,$02 X/ Y position offsets.
  $D839,$0E Pixel/ control data.
  $D847,$01 Frame #N$03 terminator.
  $D848,$01 Animation sequence terminator.
  $D849,$01 Frame #N$01 terminator.
N $D84A Sprite #N$F0, Frame #N$02 ($09 bytes).
  $D84A,$02 X/ Y position offsets.
  $D84C,$07 Pixel/ control data.
  $D853,$01 Frame #N$02 terminator.
N $D854 Sprite #N$F0, Frame #N$03 (control byte).
  $D854,$01 Control data.
  $D855,$01 Frame #N$03 terminator.
N $D856 Sprite #N$F0, Frame #N$04 ($0F bytes).
  $D856,$02 X/ Y position offsets.
  $D858,$0D Pixel/ control data.
  $D865,$01 Frame #N$04 terminator.
  $D866,$01 Frame #N$05 terminator.
N $D867 Sprite #N$F0, Frame #N$06 (control byte).
  $D867,$01 Control data.
  $D868,$01 Frame #N$06 terminator.
N $D869 Sprite #N$F0, Frame #N$07 ($04 bytes).
  $D869,$02 X/ Y position offsets.
  $D86B,$02 Pixel/ control data.
  $D86D,$01 Animation sequence terminator.
N $D86E Sprite #N$F1, Frame #N$01 ($0B bytes).
  $D86E,$02 X/ Y position offsets.
  $D870,$09 Pixel/ control data.
  $D879,$01 Frame #N$01 terminator.
  $D87A,$01 Animation sequence terminator.
N $D87B Sprite #N$F2, Frame #N$01 (control byte).
  $D87B,$01 Control data.
  $D87C,$01 Frame #N$01 terminator.
N $D87D Sprite #N$F2, Frame #N$02 ($10 bytes).
  $D87D,$02 X/ Y position offsets.
  $D87F,$0E Pixel/ control data.
  $D88D,$01 Frame #N$02 terminator.
N $D88E Sprite #N$F2, Frame #N$03 (control byte).
  $D88E,$01 Control data.
  $D88F,$01 Frame #N$03 terminator.
N $D890 Sprite #N$F2, Frame #N$04 ($0F bytes).
  $D890,$02 X/ Y position offsets.
  $D892,$0D Pixel/ control data.
  $D89F,$01 Frame #N$04 terminator.
  $D8A0,$01 Frame #N$05 terminator.
N $D8A1 Sprite #N$F2, Frame #N$06 (control byte).
  $D8A1,$01 Control data.
  $D8A2,$01 Frame #N$06 terminator.
N $D8A3 Sprite #N$F2, Frame #N$07 ($07 bytes).
  $D8A3,$02 X/ Y position offsets.
  $D8A5,$05 Pixel/ control data.
  $D8AA,$01 Animation sequence terminator.
N $D8AB Sprite #N$F3, Frame #N$01 ($08 bytes).
  $D8AB,$02 X/ Y position offsets.
  $D8AD,$06 Pixel/ control data.
  $D8B3,$01 Frame #N$01 terminator.
  $D8B4,$01 Animation sequence terminator.
  $D8B5,$01 Frame #N$01 terminator.
  $D8B6,$01 Frame #N$02 terminator.
N $D8B7 Sprite #N$F4, Frame #N$03 ($10 bytes).
  $D8B7,$02 X/ Y position offsets.
  $D8B9,$0E Pixel/ control data.
  $D8C7,$01 Frame #N$03 terminator.
N $D8C8 Sprite #N$F4, Frame #N$04 (control byte).
  $D8C8,$01 Control data.
  $D8C9,$01 Frame #N$04 terminator.
N $D8CA Sprite #N$F4, Frame #N$05 ($0B bytes).
  $D8CA,$02 X/ Y position offsets.
  $D8CC,$09 Pixel/ control data.
  $D8D5,$01 Frame #N$05 terminator.
N $D8D6 Sprite #N$F4, Frame #N$06 ($04 bytes).
  $D8D6,$02 X/ Y position offsets.
  $D8D8,$02 Pixel/ control data.
  $D8DA,$01 Frame #N$06 terminator.
N $D8DB Sprite #N$F4, Frame #N$07 (control byte).
  $D8DB,$01 Control data.
  $D8DC,$01 Frame #N$07 terminator.
  $D8DD,$01 Animation sequence terminator.
N $D8DE Sprite #N$F5, Frame #N$01 ($0F bytes).
  $D8DE,$02 X/ Y position offsets.
  $D8E0,$0D Pixel/ control data.
  $D8ED,$01 Frame #N$01 terminator.
  $D8EE,$01 Animation sequence terminator.
N $D8EF Sprite #N$F6, Frame #N$01 (control byte).
  $D8EF,$01 Control data.
  $D8F0,$01 Frame #N$01 terminator.
N $D8F1 Sprite #N$F6, Frame #N$02 ($10 bytes).
  $D8F1,$02 X/ Y position offsets.
  $D8F3,$0E Pixel/ control data.
  $D901,$01 Frame #N$02 terminator.
N $D902 Sprite #N$F6, Frame #N$03 (control byte).
  $D902,$01 Control data.
  $D903,$01 Frame #N$03 terminator.
N $D904 Sprite #N$F6, Frame #N$04 ($0B bytes).
  $D904,$02 X/ Y position offsets.
  $D906,$09 Pixel/ control data.
  $D90F,$01 Frame #N$04 terminator.
N $D910 Sprite #N$F6, Frame #N$05 ($04 bytes).
  $D910,$02 X/ Y position offsets.
  $D912,$02 Pixel/ control data.
  $D914,$01 Frame #N$05 terminator.
N $D915 Sprite #N$F6, Frame #N$06 (control byte).
  $D915,$01 Control data.
  $D916,$01 Frame #N$06 terminator.
N $D917 Sprite #N$F6, Frame #N$07 ($03 bytes).
  $D917,$02 X/ Y position offsets.
  $D919,$01 Pixel/ control data.
  $D91A,$01 Animation sequence terminator.
N $D91B Sprite #N$F7, Frame #N$01 ($0C bytes).
  $D91B,$02 X/ Y position offsets.
  $D91D,$0A Pixel/ control data.
  $D927,$01 Frame #N$01 terminator.
  $D928,$01 Animation sequence terminator.
N $D929 Sprite #N$F8, Frame #N$01 (control byte).
  $D929,$01 Control data.
  $D92A,$01 Frame #N$01 terminator.
  $D92B,$01 Animation sequence terminator.
N $D92C Sprite #N$F9, Frame #N$01 ($0C bytes).
  $D92C,$02 X/ Y position offsets.
  $D92E,$0A Pixel/ control data.
  $D938,$01 Animation sequence terminator.
  $D939,$01 Animation sequence terminator.
  $D93A,$01 Animation sequence terminator.
  $D93B,$01 Frame #N$01 terminator.
N $D93C Sprite #N$FC, Frame #N$02 (control byte).
  $D93C,$01 Control data.
  $D93D,$01 Frame #N$02 terminator.
N $D93E Sprite #N$FC, Frame #N$03 ($10 bytes).
  $D93E,$02 X/ Y position offsets.
  $D940,$0E Pixel/ control data.
  $D94E,$01 Frame #N$03 terminator.
  $D94F,$01 Animation sequence terminator.
N $D950 Sprite #N$FD, Frame #N$01 (control byte).
  $D950,$01 Control data.
  $D951,$01 Frame #N$01 terminator.
N $D952 Sprite #N$FD, Frame #N$02 ($10 bytes).
  $D952,$02 X/ Y position offsets.
  $D954,$0E Pixel/ control data.
  $D962,$01 Frame #N$02 terminator.
N $D963 Sprite #N$FD, Frame #N$03 (control byte).
  $D963,$01 Control data.
  $D964,$01 Frame #N$03 terminator.
N $D965 Sprite #N$FD, Frame #N$04 ($03 bytes).
  $D965,$02 X/ Y position offsets.
  $D967,$01 Pixel/ control data.
  $D968,$01 Frame #N$04 terminator.
N $D969 Sprite #N$FD, Frame #N$05 ($08 bytes).
  $D969,$02 X/ Y position offsets.
  $D96B,$06 Pixel/ control data.
  $D971,$01 Frame #N$05 terminator.
N $D972 Sprite #N$FD, Frame #N$06 ($03 bytes).
  $D972,$02 X/ Y position offsets.
  $D974,$01 Pixel/ control data.
  $D975,$01 Frame #N$06 terminator.
  $D976,$01 Animation sequence terminator.
N $D977 Sprite #N$FE, Frame #N$01 (control byte).
  $D977,$01 Control data.
  $D978,$01 Frame #N$01 terminator.
N $D979 Sprite #N$FE, Frame #N$02.
  $D979,$02 X/ Y position offsets.
  $D97B,$08 Pixel data (2 character rows × 4 bytes each).
  $D983,$01 Animation sequence terminator.
N $D984 Sprite #N$FF, Frame #N$01 ($03 bytes).
  $D984,$02 X/ Y position offsets.
  $D986,$01 Pixel/ control data.
  $D987,$01 Animation sequence terminator.
N $D988 Sprite #N$100, Frame #N$01 (control byte).
  $D988,$01 Control data.
  $D989,$01 Frame #N$01 terminator.
  $D98A,$01 Frame #N$02 terminator.
N $D98B Sprite #N$100, Frame #N$03 ($19 bytes).
  $D98B,$02 X/ Y position offsets.
  $D98D,$17 Pixel/ control data.
  $D9A4,$01 Frame #N$03 terminator.
  $D9A5,$01 Frame #N$04 terminator.
  $D9A6,$01 Frame #N$05 terminator.
N $D9A7 Sprite #N$100, Frame #N$06 ($10 bytes).
  $D9A7,$02 X/ Y position offsets.
  $D9A9,$0E Pixel/ control data.
  $D9B7,$01 Frame #N$06 terminator.
  $D9B8,$01 Frame #N$07 terminator.
  $D9B9,$01 Frame #N$08 terminator.
N $D9BA Sprite #N$100, Frame #N$09 ($10 bytes).
  $D9BA,$02 X/ Y position offsets.
  $D9BC,$0E Pixel/ control data.
  $D9CA,$01 Frame #N$09 terminator.
  $D9CB,$01 Animation sequence terminator.
N $D9CC Sprite #N$101, Frame #N$01 ($15 bytes).
  $D9CC,$02 X/ Y position offsets.
  $D9CE,$13 Pixel/ control data.
  $D9E1,$01 Frame #N$01 terminator.
N $D9E2 Sprite #N$101, Frame #N$02 ($04 bytes).
  $D9E2,$02 X/ Y position offsets.
  $D9E4,$02 Pixel/ control data.
  $D9E6,$01 Frame #N$02 terminator.
  $D9E7,$01 Frame #N$03 terminator.
  $D9E8,$01 Frame #N$04 terminator.
N $D9E9 Sprite #N$101, Frame #N$05 ($10 bytes).
  $D9E9,$02 X/ Y position offsets.
  $D9EB,$0E Pixel/ control data.
  $D9F9,$01 Frame #N$05 terminator.
  $D9FA,$01 Frame #N$06 terminator.
  $D9FB,$01 Frame #N$07 terminator.
N $D9FC Sprite #N$101, Frame #N$08 ($0F bytes).
  $D9FC,$02 X/ Y position offsets.
  $D9FE,$0D Pixel/ control data.
  $DA0B,$01 Animation sequence terminator.
  $DA0C,$01 Frame #N$01 terminator.
  $DA0D,$01 Frame #N$02 terminator.
  $DA0E,$01 Frame #N$03 terminator.
N $DA0F Sprite #N$102, Frame #N$04 ($10 bytes).
  $DA0F,$02 X/ Y position offsets.
  $DA11,$0E Pixel/ control data.
  $DA1F,$01 Frame #N$04 terminator.
  $DA20,$01 Animation sequence terminator.
  $DA21,$01 Frame #N$01 terminator.
N $DA22 Sprite #N$103, Frame #N$02 ($19 bytes).
  $DA22,$02 X/ Y position offsets.
  $DA24,$17 Pixel/ control data.
  $DA3B,$01 Frame #N$02 terminator.
  $DA3C,$01 Frame #N$03 terminator.
N $DA3D Sprite #N$103, Frame #N$04 ($19 bytes).
  $DA3D,$02 X/ Y position offsets.
  $DA3F,$17 Pixel/ control data.
  $DA56,$01 Frame #N$04 terminator.
  $DA57,$01 Frame #N$05 terminator.
  $DA58,$01 Frame #N$06 terminator.
N $DA59 Sprite #N$103, Frame #N$07 ($10 bytes).
  $DA59,$02 X/ Y position offsets.
  $DA5B,$0E Pixel/ control data.
  $DA69,$01 Frame #N$07 terminator.
  $DA6A,$01 Animation sequence terminator.
  $DA6B,$01 Frame #N$01 terminator.
N $DA6C Sprite #N$104, Frame #N$02 ($03 bytes).
  $DA6C,$02 X/ Y position offsets.
  $DA6E,$01 Pixel/ control data.
  $DA6F,$01 Animation sequence terminator.
N $DA70 Sprite #N$105, Frame #N$01 ($03 bytes).
  $DA70,$02 X/ Y position offsets.
  $DA72,$01 Pixel/ control data.
  $DA73,$01 Animation sequence terminator.
N $DA74 Sprite #N$106, Frame #N$01 ($03 bytes).
  $DA74,$02 X/ Y position offsets.
  $DA76,$01 Pixel/ control data.
  $DA77,$01 Animation sequence terminator.
  $DA78,$01 Animation sequence terminator.
N $DA79 Sprite #N$108, Frame #N$01 ($0C bytes).
  $DA79,$02 X/ Y position offsets.
  $DA7B,$0A Pixel/ control data.
  $DA85,$01 Frame #N$01 terminator.
  $DA86,$01 Frame #N$02 terminator.
N $DA87 Sprite #N$108, Frame #N$03 ($19 bytes).
  $DA87,$02 X/ Y position offsets.
  $DA89,$17 Pixel/ control data.
  $DAA0,$01 Frame #N$03 terminator.
  $DAA1,$01 Frame #N$04 terminator.
  $DAA2,$01 Frame #N$05 terminator.
N $DAA3 Sprite #N$108, Frame #N$06 ($10 bytes).
  $DAA3,$02 X/ Y position offsets.
  $DAA5,$0E Pixel/ control data.
  $DAB3,$01 Frame #N$06 terminator.
  $DAB4,$01 Animation sequence terminator.
  $DAB5,$01 Frame #N$01 terminator.
  $DAB6,$01 Frame #N$02 terminator.
N $DAB7 Sprite #N$109, Frame #N$03 ($06 bytes).
  $DAB7,$02 X/ Y position offsets.
  $DAB9,$04 Pixel/ control data.
  $DABD,$01 Animation sequence terminator.
N $DABE Sprite #N$10A, Frame #N$01 ($09 bytes).
  $DABE,$02 X/ Y position offsets.
  $DAC0,$07 Pixel/ control data.
  $DAC7,$01 Frame #N$01 terminator.
  $DAC8,$01 Frame #N$02 terminator.
N $DAC9 Sprite #N$10A, Frame #N$03 ($19 bytes).
  $DAC9,$02 X/ Y position offsets.
  $DACB,$17 Pixel/ control data.
  $DAE2,$01 Frame #N$03 terminator.
  $DAE3,$01 Frame #N$04 terminator.
N $DAE4 Sprite #N$10A, Frame #N$05 ($19 bytes).
  $DAE4,$02 X/ Y position offsets.
  $DAE6,$17 Pixel/ control data.
  $DAFD,$01 Frame #N$05 terminator.
  $DAFE,$01 Frame #N$06 terminator.
N $DAFF Sprite #N$10A, Frame #N$07 ($09 bytes).
  $DAFF,$02 X/ Y position offsets.
  $DB01,$07 Pixel/ control data.
  $DB08,$01 Frame #N$07 terminator.
  $DB09,$01 Animation sequence terminator.
  $DB0A,$01 Frame #N$01 terminator.
  $DB0B,$01 Frame #N$02 terminator.
N $DB0C Sprite #N$10B, Frame #N$03 ($0F bytes).
  $DB0C,$02 X/ Y position offsets.
  $DB0E,$0D Pixel/ control data.
  $DB1B,$01 Animation sequence terminator.
  $DB1C,$01 Frame #N$01 terminator.
  $DB1D,$01 Frame #N$02 terminator.
  $DB1E,$01 Frame #N$03 terminator.
N $DB1F Sprite #N$10C, Frame #N$04 ($05 bytes).
  $DB1F,$02 X/ Y position offsets.
  $DB21,$03 Pixel/ control data.
  $DB24,$01 Animation sequence terminator.
N $DB25 Sprite #N$10D, Frame #N$01.
  $DB25,$02 X/ Y position offsets.
  $DB27,$08 Pixel data (2 character rows × 4 bytes each).
  $DB2F,$01 Frame #N$01 terminator.
  $DB30,$01 Frame #N$02 terminator.
  $DB31,$01 Frame #N$03 terminator.
N $DB32 Sprite #N$10D, Frame #N$04 ($10 bytes).
  $DB32,$02 X/ Y position offsets.
  $DB34,$0E Pixel/ control data.
  $DB42,$01 Frame #N$04 terminator.
  $DB43,$01 Frame #N$05 terminator.
N $DB44 Sprite #N$10D, Frame #N$06 ($09 bytes).
  $DB44,$02 X/ Y position offsets.
  $DB46,$07 Pixel/ control data.
  $DB4D,$01 Frame #N$06 terminator.
  $DB4E,$01 Animation sequence terminator.
  $DB4F,$01 Frame #N$01 terminator.
N $DB50 Sprite #N$10E, Frame #N$02 ($06 bytes).
  $DB50,$02 X/ Y position offsets.
  $DB52,$04 Pixel/ control data.
  $DB56,$01 Animation sequence terminator.
  $DB57,$01 Animation sequence terminator.
N $DB58 Sprite #N$110, Frame #N$01 ($09 bytes).
  $DB58,$02 X/ Y position offsets.
  $DB5A,$07 Pixel/ control data.
  $DB61,$01 Frame #N$01 terminator.
  $DB62,$01 Frame #N$02 terminator.
N $DB63 Sprite #N$110, Frame #N$03 ($19 bytes).
  $DB63,$02 X/ Y position offsets.
  $DB65,$17 Pixel/ control data.
  $DB7C,$01 Frame #N$03 terminator.
  $DB7D,$01 Frame #N$04 terminator.
N $DB7E Sprite #N$110, Frame #N$05 ($19 bytes).
  $DB7E,$02 X/ Y position offsets.
  $DB80,$17 Pixel/ control data.
  $DB97,$01 Frame #N$05 terminator.
  $DB98,$01 Animation sequence terminator.
  $DB99,$01 Frame #N$01 terminator.
N $DB9A Sprite #N$111, Frame #N$02 ($11 bytes).
  $DB9A,$02 X/ Y position offsets.
  $DB9C,$0F Pixel/ control data.
  $DBAB,$01 Frame #N$02 terminator.
  $DBAC,$01 Frame #N$03 terminator.
N $DBAD Sprite #N$111, Frame #N$04 ($03 bytes).
  $DBAD,$02 X/ Y position offsets.
  $DBAF,$01 Pixel/ control data.
  $DBB0,$01 Animation sequence terminator.
  $DBB1,$01 Animation sequence terminator.
  $DBB2,$01 Animation sequence terminator.
N $DBB3 Sprite #N$114, Frame #N$01 (control byte).
  $DBB3,$01 Control data.
  $DBB4,$01 Animation sequence terminator.
N $DBB5 Sprite #N$115, Frame #N$01 ($11 bytes).
  $DBB5,$02 X/ Y position offsets.
  $DBB7,$0F Pixel/ control data.
  $DBC6,$01 Frame #N$01 terminator.
  $DBC7,$01 Frame #N$02 terminator.
N $DBC8 Sprite #N$115, Frame #N$03 ($19 bytes).
  $DBC8,$02 X/ Y position offsets.
  $DBCA,$17 Pixel/ control data.
  $DBE1,$01 Frame #N$03 terminator.
  $DBE2,$01 Animation sequence terminator.
  $DBE3,$01 Frame #N$01 terminator.
N $DBE4 Sprite #N$116, Frame #N$02 ($11 bytes).
  $DBE4,$02 X/ Y position offsets.
  $DBE6,$0F Pixel/ control data.
  $DBF5,$01 Frame #N$02 terminator.
  $DBF6,$01 Frame #N$03 terminator.
  $DBF7,$01 Frame #N$04 terminator.
N $DBF8 Sprite #N$116, Frame #N$05 ($16 bytes).
  $DBF8,$02 X/ Y position offsets.
  $DBFA,$14 Pixel/ control data.
  $DC0E,$01 Animation sequence terminator.
N $DC0F Sprite #N$117, Frame #N$01 (control byte).
  $DC0F,$01 Control data.
  $DC10,$01 Frame #N$01 terminator.
  $DC11,$01 Frame #N$02 terminator.
N $DC12 Sprite #N$117, Frame #N$03 ($19 bytes).
  $DC12,$02 X/ Y position offsets.
  $DC14,$17 Pixel/ control data.
  $DC2B,$01 Frame #N$03 terminator.
  $DC2C,$01 Animation sequence terminator.
  $DC2D,$01 Frame #N$01 terminator.
N $DC2E Sprite #N$118, Frame #N$02 ($05 bytes).
  $DC2E,$02 X/ Y position offsets.
  $DC30,$03 Pixel/ control data.
  $DC33,$01 Animation sequence terminator.
N $DC34 Sprite #N$119, Frame #N$01 ($07 bytes).
  $DC34,$02 X/ Y position offsets.
  $DC36,$05 Pixel/ control data.
  $DC3B,$01 Animation sequence terminator.
N $DC3C Sprite #N$11A, Frame #N$01 ($0B bytes).
  $DC3C,$02 X/ Y position offsets.
  $DC3E,$09 Pixel/ control data.
  $DC47,$01 Frame #N$01 terminator.
  $DC48,$01 Frame #N$02 terminator.
N $DC49 Sprite #N$11A, Frame #N$03 ($19 bytes).
  $DC49,$02 X/ Y position offsets.
  $DC4B,$17 Pixel/ control data.
  $DC62,$01 Frame #N$03 terminator.
  $DC63,$01 Frame #N$04 terminator.
N $DC64 Sprite #N$11A, Frame #N$05 ($05 bytes).
  $DC64,$02 X/ Y position offsets.
  $DC66,$03 Pixel/ control data.
  $DC69,$01 Animation sequence terminator.
N $DC6A Sprite #N$11B, Frame #N$01 ($0B bytes).
  $DC6A,$02 X/ Y position offsets.
  $DC6C,$09 Pixel/ control data.
  $DC75,$01 Frame #N$01 terminator.
  $DC76,$01 Frame #N$02 terminator.
  $DC77,$01 Frame #N$03 terminator.
N $DC78 Sprite #N$11B, Frame #N$04 ($10 bytes).
  $DC78,$02 X/ Y position offsets.
  $DC7A,$0E Pixel/ control data.
  $DC88,$01 Frame #N$04 terminator.
  $DC89,$01 Animation sequence terminator.
  $DC8A,$01 Frame #N$01 terminator.
N $DC8B Sprite #N$11C, Frame #N$02 ($09 bytes).
  $DC8B,$02 X/ Y position offsets.
  $DC8D,$07 Pixel/ control data.
  $DC94,$01 Frame #N$02 terminator.
  $DC95,$01 Frame #N$03 terminator.
  $DC96,$01 Frame #N$04 terminator.
N $DC97 Sprite #N$11C, Frame #N$05 (position only).
  $DC97,$02 X/ Y position offsets.
  $DC99,$01 Animation sequence terminator.
  $DC9A,$01 Animation sequence terminator.
  $DC9B,$01 Animation sequence terminator.
N $DC9C Sprite #N$11F, Frame #N$01 ($0B bytes).
  $DC9C,$02 X/ Y position offsets.
  $DC9E,$09 Pixel/ control data.
  $DCA7,$01 Frame #N$01 terminator.
  $DCA8,$01 Frame #N$02 terminator.
  $DCA9,$01 Frame #N$03 terminator.
N $DCAA Sprite #N$11F, Frame #N$04 ($10 bytes).
  $DCAA,$02 X/ Y position offsets.
  $DCAC,$0E Pixel/ control data.
  $DCBA,$01 Frame #N$04 terminator.
  $DCBB,$01 Frame #N$05 terminator.
  $DCBC,$01 Frame #N$06 terminator.
N $DCBD Sprite #N$11F, Frame #N$07 ($10 bytes).
  $DCBD,$02 X/ Y position offsets.
  $DCBF,$0E Pixel/ control data.
  $DCCD,$01 Frame #N$07 terminator.
  $DCCE,$01 Frame #N$08 terminator.
  $DCCF,$01 Frame #N$09 terminator.
N $DCD0 Sprite #N$11F, Frame #N$0A ($10 bytes).
  $DCD0,$02 X/ Y position offsets.
  $DCD2,$0E Pixel/ control data.
  $DCE0,$01 Frame #N$0A terminator.
  $DCE1,$01 Animation sequence terminator.
  $DCE2,$01 Frame #N$01 terminator.
N $DCE3 Sprite #N$120, Frame #N$02 ($0D bytes).
  $DCE3,$02 X/ Y position offsets.
  $DCE5,$0B Pixel/ control data.
  $DCF0,$01 Animation sequence terminator.
  $DCF1,$01 Animation sequence terminator.
  $DCF2,$01 Animation sequence terminator.
N $DCF3 Sprite #N$123, Frame #N$01 (control byte).
  $DCF3,$01 Control data.
  $DCF4,$01 Frame #N$01 terminator.
  $DCF5,$01 Frame #N$02 terminator.
  $DCF6,$01 Frame #N$03 terminator.
N $DCF7 Sprite #N$123, Frame #N$04 ($18 bytes).
  $DCF7,$02 X/ Y position offsets.
  $DCF9,$16 Pixel/ control data.
  $DD0F,$01 Frame #N$04 terminator.
  $DD10,$01 Frame #N$05 terminator.
  $DD11,$01 Frame #N$06 terminator.
N $DD12 Sprite #N$123, Frame #N$07 ($10 bytes).
  $DD12,$02 X/ Y position offsets.
  $DD14,$0E Pixel/ control data.
  $DD22,$01 Frame #N$07 terminator.
  $DD23,$01 Animation sequence terminator.
  $DD24,$01 Frame #N$01 terminator.
N $DD25 Sprite #N$124, Frame #N$02 ($0D bytes).
  $DD25,$02 X/ Y position offsets.
  $DD27,$0B Pixel/ control data.
  $DD32,$01 Animation sequence terminator.
  $DD33,$01 Animation sequence terminator.
  $DD34,$01 Animation sequence terminator.
N $DD35 Sprite #N$127, Frame #N$01 (control byte).
  $DD35,$01 Control data.
  $DD36,$01 Frame #N$01 terminator.
  $DD37,$01 Frame #N$02 terminator.
  $DD38,$01 Frame #N$03 terminator.
N $DD39 Sprite #N$127, Frame #N$04 ($18 bytes).
  $DD39,$02 X/ Y position offsets.
  $DD3B,$16 Pixel/ control data.
  $DD51,$01 Frame #N$04 terminator.
  $DD52,$01 Frame #N$05 terminator.
N $DD53 Sprite #N$127, Frame #N$06 ($19 bytes).
  $DD53,$02 X/ Y position offsets.
  $DD55,$17 Pixel/ control data.
  $DD6C,$01 Frame #N$06 terminator.
  $DD6D,$01 Frame #N$07 terminator.
N $DD6E Sprite #N$127, Frame #N$08 ($0B bytes).
  $DD6E,$02 X/ Y position offsets.
  $DD70,$09 Pixel/ control data.
  $DD79,$01 Animation sequence terminator.
N $DD7A Sprite #N$128, Frame #N$01 ($05 bytes).
  $DD7A,$02 X/ Y position offsets.
  $DD7C,$03 Pixel/ control data.
  $DD7F,$01 Frame #N$01 terminator.
  $DD80,$01 Animation sequence terminator.
N $DD81 Sprite #N$129, Frame #N$01 (control byte).
  $DD81,$01 Control data.
  $DD82,$01 Frame #N$01 terminator.
N $DD83 Sprite #N$129, Frame #N$02 (position only).
  $DD83,$02 X/ Y position offsets.
  $DD85,$01 Animation sequence terminator.
N $DD86 Sprite #N$12A, Frame #N$01 ($05 bytes).
  $DD86,$02 X/ Y position offsets.
  $DD88,$03 Pixel/ control data.
  $DD8B,$01 Frame #N$01 terminator.
  $DD8C,$01 Frame #N$02 terminator.
N $DD8D Sprite #N$12A, Frame #N$03 ($11 bytes).
  $DD8D,$02 X/ Y position offsets.
  $DD8F,$0F Pixel/ control data.
  $DD9E,$01 Frame #N$03 terminator.
  $DD9F,$01 Frame #N$04 terminator.
  $DDA0,$01 Frame #N$05 terminator.
N $DDA1 Sprite #N$12A, Frame #N$06 ($10 bytes).
  $DDA1,$02 X/ Y position offsets.
  $DDA3,$0E Pixel/ control data.
  $DDB1,$01 Frame #N$06 terminator.
  $DDB2,$01 Frame #N$07 terminator.
  $DDB3,$01 Frame #N$08 terminator.
N $DDB4 Sprite #N$12A, Frame #N$09 ($10 bytes).
  $DDB4,$02 X/ Y position offsets.
  $DDB6,$0E Pixel/ control data.
  $DDC4,$01 Frame #N$09 terminator.
N $DDC5 Sprite #N$12A, Frame #N$0A.
  $DDC5,$02 X/ Y position offsets.
  $DDC7,$08 Pixel data (2 character rows × 4 bytes each).
  $DDCF,$01 Frame #N$0A terminator.
  $DDD0,$01 Frame #N$0B terminator.
N $DDD1 Sprite #N$12A, Frame #N$0C ($09 bytes).
  $DDD1,$02 X/ Y position offsets.
  $DDD3,$07 Pixel/ control data.
  $DDDA,$01 Frame #N$0C terminator.
  $DDDB,$01 Frame #N$0D terminator.
N $DDDC Sprite #N$12A, Frame #N$0E ($11 bytes).
  $DDDC,$02 X/ Y position offsets.
  $DDDE,$0F Pixel/ control data.
  $DDED,$01 Frame #N$0E terminator.
  $DDEE,$01 Animation sequence terminator.
N $DDEF Sprite #N$12B, Frame #N$01.
  $DDEF,$02 X/ Y position offsets.
  $DDF1,$08 Pixel data (2 character rows × 4 bytes each).
  $DDF9,$01 Frame #N$01 terminator.
  $DDFA,$01 Frame #N$02 terminator.
N $DDFB Sprite #N$12B, Frame #N$03 ($09 bytes).
  $DDFB,$02 X/ Y position offsets.
  $DDFD,$07 Pixel/ control data.
  $DE04,$01 Frame #N$03 terminator.
  $DE05,$01 Frame #N$04 terminator.
  $DE06,$01 Frame #N$05 terminator.
N $DE07 Sprite #N$12B, Frame #N$06 ($10 bytes).
  $DE07,$02 X/ Y position offsets.
  $DE09,$0E Pixel/ control data.
  $DE17,$01 Frame #N$06 terminator.
  $DE18,$01 Frame #N$07 terminator.
N $DE19 Sprite #N$12B, Frame #N$08 ($09 bytes).
  $DE19,$02 X/ Y position offsets.
  $DE1B,$07 Pixel/ control data.
  $DE22,$01 Frame #N$08 terminator.
N $DE23 Sprite #N$12B, Frame #N$09 ($05 bytes).
  $DE23,$02 X/ Y position offsets.
  $DE25,$03 Pixel/ control data.
  $DE28,$01 Animation sequence terminator.
N $DE29 Sprite #N$12C, Frame #N$01 ($04 bytes).
  $DE29,$02 X/ Y position offsets.
  $DE2B,$02 Pixel/ control data.
  $DE2D,$01 Frame #N$01 terminator.
  $DE2E,$01 Frame #N$02 terminator.
N $DE2F Sprite #N$12C, Frame #N$03 ($09 bytes).
  $DE2F,$02 X/ Y position offsets.
  $DE31,$07 Pixel/ control data.
  $DE38,$01 Animation sequence terminator.
  $DE39,$01 Animation sequence terminator.
  $DE3A,$01 Animation sequence terminator.
  $DE3B,$01 Animation sequence terminator.
  $DE3C,$01 Animation sequence terminator.
  $DE3D,$01 Animation sequence terminator.
N $DE3E Sprite #N$132, Frame #N$01 (position only).
  $DE3E,$02 X/ Y position offsets.
  $DE40,$01 Frame #N$01 terminator.
  $DE41,$01 Frame #N$02 terminator.
  $DE42,$01 Frame #N$03 terminator.
N $DE43 Sprite #N$132, Frame #N$04 ($10 bytes).
  $DE43,$02 X/ Y position offsets.
  $DE45,$0E Pixel/ control data.
  $DE53,$01 Frame #N$04 terminator.
  $DE54,$01 Animation sequence terminator.
N $DE55 Sprite #N$133, Frame #N$01 (control byte).
  $DE55,$01 Control data.
  $DE56,$01 Frame #N$01 terminator.
N $DE57 Sprite #N$133, Frame #N$02 (position only).
  $DE57,$02 X/ Y position offsets.
  $DE59,$01 Animation sequence terminator.
N $DE5A Sprite #N$134, Frame #N$01 ($05 bytes).
  $DE5A,$02 X/ Y position offsets.
  $DE5C,$03 Pixel/ control data.
  $DE5F,$01 Frame #N$01 terminator.
  $DE60,$01 Frame #N$02 terminator.
N $DE61 Sprite #N$134, Frame #N$03 ($11 bytes).
  $DE61,$02 X/ Y position offsets.
  $DE63,$0F Pixel/ control data.
  $DE72,$01 Frame #N$03 terminator.
  $DE73,$01 Frame #N$04 terminator.
  $DE74,$01 Frame #N$05 terminator.
N $DE75 Sprite #N$134, Frame #N$06 ($10 bytes).
  $DE75,$02 X/ Y position offsets.
  $DE77,$0E Pixel/ control data.
  $DE85,$01 Frame #N$06 terminator.
  $DE86,$01 Frame #N$07 terminator.
  $DE87,$01 Frame #N$08 terminator.
N $DE88 Sprite #N$134, Frame #N$09 ($10 bytes).
  $DE88,$02 X/ Y position offsets.
  $DE8A,$0E Pixel/ control data.
  $DE98,$01 Frame #N$09 terminator.
  $DE99,$01 Frame #N$0A terminator.
N $DE9A Sprite #N$134, Frame #N$0B ($04 bytes).
  $DE9A,$02 X/ Y position offsets.
  $DE9C,$02 Pixel/ control data.
  $DE9E,$01 Animation sequence terminator.
N $DE9F Sprite #N$135, Frame #N$01 ($04 bytes).
  $DE9F,$02 X/ Y position offsets.
  $DEA1,$02 Pixel/ control data.
  $DEA3,$01 Frame #N$01 terminator.
  $DEA4,$01 Frame #N$02 terminator.
N $DEA5 Sprite #N$135, Frame #N$03 ($19 bytes).
  $DEA5,$02 X/ Y position offsets.
  $DEA7,$17 Pixel/ control data.
  $DEBE,$01 Frame #N$03 terminator.
  $DEBF,$01 Frame #N$04 terminator.
N $DEC0 Sprite #N$135, Frame #N$05 ($19 bytes).
  $DEC0,$02 X/ Y position offsets.
  $DEC2,$17 Pixel/ control data.
  $DED9,$01 Frame #N$05 terminator.
  $DEDA,$01 Animation sequence terminator.
N $DEDB Sprite #N$136, Frame #N$01.
  $DEDB,$02 X/ Y position offsets.
  $DEDD,$08 Pixel data (2 character rows × 4 bytes each).
  $DEE5,$01 Frame #N$01 terminator.
  $DEE6,$01 Frame #N$02 terminator.
N $DEE7 Sprite #N$136, Frame #N$03 ($09 bytes).
  $DEE7,$02 X/ Y position offsets.
  $DEE9,$07 Pixel/ control data.
  $DEF0,$01 Frame #N$03 terminator.
  $DEF1,$01 Frame #N$04 terminator.
  $DEF2,$01 Frame #N$05 terminator.
N $DEF3 Sprite #N$136, Frame #N$06 ($10 bytes).
  $DEF3,$02 X/ Y position offsets.
  $DEF5,$0E Pixel/ control data.
  $DF03,$01 Frame #N$06 terminator.
  $DF04,$01 Frame #N$07 terminator.
N $DF05 Sprite #N$136, Frame #N$08 ($09 bytes).
  $DF05,$02 X/ Y position offsets.
  $DF07,$07 Pixel/ control data.
  $DF0E,$01 Frame #N$08 terminator.
N $DF0F Sprite #N$136, Frame #N$09.
  $DF0F,$02 X/ Y position offsets.
  $DF11,$08 Pixel data (2 character rows × 4 bytes each).
  $DF19,$01 Frame #N$09 terminator.
  $DF1A,$01 Frame #N$0A terminator.
N $DF1B Sprite #N$136, Frame #N$0B ($19 bytes).
  $DF1B,$02 X/ Y position offsets.
  $DF1D,$17 Pixel/ control data.
  $DF34,$01 Frame #N$0B terminator.
  $DF35,$01 Animation sequence terminator.
N $DF36 Sprite #N$137, Frame #N$01.
  $DF36,$02 X/ Y position offsets.
  $DF38,$08 Pixel data (2 character rows × 4 bytes each).
  $DF40,$01 Frame #N$01 terminator.
  $DF41,$01 Frame #N$02 terminator.
N $DF42 Sprite #N$137, Frame #N$03 ($09 bytes).
  $DF42,$02 X/ Y position offsets.
  $DF44,$07 Pixel/ control data.
  $DF4B,$01 Frame #N$03 terminator.
  $DF4C,$01 Frame #N$04 terminator.
  $DF4D,$01 Frame #N$05 terminator.
N $DF4E Sprite #N$137, Frame #N$06 ($10 bytes).
  $DF4E,$02 X/ Y position offsets.
  $DF50,$0E Pixel/ control data.
  $DF5E,$01 Frame #N$06 terminator.
  $DF5F,$01 Frame #N$07 terminator.
N $DF60 Sprite #N$137, Frame #N$08 ($09 bytes).
  $DF60,$02 X/ Y position offsets.
  $DF62,$07 Pixel/ control data.
  $DF69,$01 Frame #N$08 terminator.
N $DF6A Sprite #N$137, Frame #N$09 (control byte).
  $DF6A,$01 Control data.
  $DF6B,$01 Frame #N$09 terminator.
N $DF6C Sprite #N$137, Frame #N$0A ($10 bytes).
  $DF6C,$02 X/ Y position offsets.
  $DF6E,$0E Pixel/ control data.
  $DF7C,$01 Frame #N$0A terminator.
  $DF7D,$01 Frame #N$0B terminator.
N $DF7E Sprite #N$137, Frame #N$0C ($19 bytes).
  $DF7E,$02 X/ Y position offsets.
  $DF80,$17 Pixel/ control data.
  $DF97,$01 Frame #N$0C terminator.
  $DF98,$01 Animation sequence terminator.
N $DF99 Sprite #N$138, Frame #N$01.
  $DF99,$02 X/ Y position offsets.
  $DF9B,$08 Pixel data (2 character rows × 4 bytes each).
  $DFA3,$01 Frame #N$01 terminator.
  $DFA4,$01 Frame #N$02 terminator.
N $DFA5 Sprite #N$138, Frame #N$03 ($09 bytes).
  $DFA5,$02 X/ Y position offsets.
  $DFA7,$07 Pixel/ control data.
  $DFAE,$01 Frame #N$03 terminator.
  $DFAF,$01 Frame #N$04 terminator.
  $DFB0,$01 Frame #N$05 terminator.
N $DFB1 Sprite #N$138, Frame #N$06 ($10 bytes).
  $DFB1,$02 X/ Y position offsets.
  $DFB3,$0E Pixel/ control data.
  $DFC1,$01 Frame #N$06 terminator.
  $DFC2,$01 Frame #N$07 terminator.
N $DFC3 Sprite #N$138, Frame #N$08 ($09 bytes).
  $DFC3,$02 X/ Y position offsets.
  $DFC5,$07 Pixel/ control data.
  $DFCC,$01 Frame #N$08 terminator.
N $DFCD Sprite #N$138, Frame #N$09.
  $DFCD,$02 X/ Y position offsets.
  $DFCF,$08 Pixel data (2 character rows × 4 bytes each).
  $DFD7,$01 Frame #N$09 terminator.
  $DFD8,$01 Frame #N$0A terminator.
N $DFD9 Sprite #N$138, Frame #N$0B (control byte).
  $DFD9,$01 Control data.
  $DFDA,$01 Animation sequence terminator.
N $DFDB Sprite #N$139, Frame #N$01 ($07 bytes).
  $DFDB,$02 X/ Y position offsets.
  $DFDD,$05 Pixel/ control data.
  $DFE2,$01 Frame #N$01 terminator.
  $DFE3,$01 Frame #N$02 terminator.
N $DFE4 Sprite #N$139, Frame #N$03 ($09 bytes).
  $DFE4,$02 X/ Y position offsets.
  $DFE6,$07 Pixel/ control data.
  $DFED,$01 Frame #N$03 terminator.
  $DFEE,$01 Animation sequence terminator.
N $DFEF Sprite #N$13A, Frame #N$01 ($04 bytes).
  $DFEF,$02 X/ Y position offsets.
  $DFF1,$02 Pixel/ control data.
  $DFF3,$01 Animation sequence terminator.
  $DFF4,$01 Animation sequence terminator.
N $DFF5 Sprite #N$13C, Frame #N$01 ($0C bytes).
  $DFF5,$02 X/ Y position offsets.
  $DFF7,$0A Pixel/ control data.
  $E001,$01 Frame #N$01 terminator.
  $E002,$01 Frame #N$02 terminator.
  $E003,$01 Frame #N$03 terminator.
N $E004 Sprite #N$13C, Frame #N$04 ($03 bytes).
  $E004,$02 X/ Y position offsets.
  $E006,$01 Pixel/ control data.
  $E007,$01 Animation sequence terminator.
N $E008 Sprite #N$13D, Frame #N$01 ($0D bytes).
  $E008,$02 X/ Y position offsets.
  $E00A,$0B Pixel/ control data.
  $E015,$01 Animation sequence terminator.
N $E016 Sprite #N$13E, Frame #N$01 (control byte).
  $E016,$01 Control data.
  $E017,$01 Animation sequence terminator.
  $E018,$01 Animation sequence terminator.
  $E019,$01 Animation sequence terminator.
  $E01A,$01 Animation sequence terminator.
  $E01B,$01 Animation sequence terminator.
  $E01C,$01 Frame #N$01 terminator.
  $E01D,$01 Frame #N$02 terminator.
N $E01E Sprite #N$143, Frame #N$03 ($19 bytes).
  $E01E,$02 X/ Y position offsets.
  $E020,$17 Pixel/ control data.
  $E037,$01 Frame #N$03 terminator.
  $E038,$01 Animation sequence terminator.
N $E039 Sprite #N$144, Frame #N$01.
  $E039,$02 X/ Y position offsets.
  $E03B,$08 Pixel data (2 character rows × 4 bytes each).
  $E043,$01 Frame #N$01 terminator.
  $E044,$01 Frame #N$02 terminator.
N $E045 Sprite #N$144, Frame #N$03 (position only).
  $E045,$02 X/ Y position offsets.
  $E047,$01 Animation sequence terminator.
N $E048 Sprite #N$145, Frame #N$01 ($16 bytes).
  $E048,$02 X/ Y position offsets.
  $E04A,$14 Pixel/ control data.
  $E05E,$01 Frame #N$01 terminator.
  $E05F,$01 Frame #N$02 terminator.
N $E060 Sprite #N$145, Frame #N$03.
  $E060,$02 X/ Y position offsets.
  $E062,$08 Pixel data (2 character rows × 4 bytes each).
  $E06A,$01 Animation sequence terminator.
N $E06B Sprite #N$146, Frame #N$01 ($0E bytes).
  $E06B,$02 X/ Y position offsets.
  $E06D,$0C Pixel/ control data.
  $E079,$01 Frame #N$01 terminator.
  $E07A,$01 Frame #N$02 terminator.
  $E07B,$01 Frame #N$03 terminator.
N $E07C Sprite #N$146, Frame #N$04 ($10 bytes).
  $E07C,$02 X/ Y position offsets.
  $E07E,$0E Pixel/ control data.
  $E08C,$01 Frame #N$04 terminator.
  $E08D,$01 Animation sequence terminator.
N $E08E Sprite #N$147, Frame #N$01 (control byte).
  $E08E,$01 Control data.
  $E08F,$01 Frame #N$01 terminator.
N $E090 Sprite #N$147, Frame #N$02 ($10 bytes).
  $E090,$02 X/ Y position offsets.
  $E092,$0E Pixel/ control data.
  $E0A0,$01 Frame #N$02 terminator.
  $E0A1,$01 Frame #N$03 terminator.
N $E0A2 Sprite #N$147, Frame #N$04 ($19 bytes).
  $E0A2,$02 X/ Y position offsets.
  $E0A4,$17 Pixel/ control data.
  $E0BB,$01 Frame #N$04 terminator.
  $E0BC,$01 Frame #N$05 terminator.
N $E0BD Sprite #N$147, Frame #N$06 ($19 bytes).
  $E0BD,$02 X/ Y position offsets.
  $E0BF,$17 Pixel/ control data.
  $E0D6,$01 Frame #N$06 terminator.
  $E0D7,$01 Animation sequence terminator.
N $E0D8 Sprite #N$148, Frame #N$01.
  $E0D8,$02 X/ Y position offsets.
  $E0DA,$08 Pixel data (2 character rows × 4 bytes each).
  $E0E2,$01 Frame #N$01 terminator.
  $E0E3,$01 Frame #N$02 terminator.
N $E0E4 Sprite #N$148, Frame #N$03 ($09 bytes).
  $E0E4,$02 X/ Y position offsets.
  $E0E6,$07 Pixel/ control data.
  $E0ED,$01 Frame #N$03 terminator.
  $E0EE,$01 Frame #N$04 terminator.
  $E0EF,$01 Frame #N$05 terminator.
N $E0F0 Sprite #N$148, Frame #N$06 ($10 bytes).
  $E0F0,$02 X/ Y position offsets.
  $E0F2,$0E Pixel/ control data.
  $E100,$01 Frame #N$06 terminator.
  $E101,$01 Frame #N$07 terminator.
N $E102 Sprite #N$148, Frame #N$08.
  $E102,$02 X/ Y position offsets.
  $E104,$08 Pixel data (2 character rows × 4 bytes each).
  $E10C,$01 Animation sequence terminator.
N $E10D Sprite #N$149, Frame #N$01 ($0E bytes).
  $E10D,$02 X/ Y position offsets.
  $E10F,$0C Pixel/ control data.
  $E11B,$01 Frame #N$01 terminator.
  $E11C,$01 Frame #N$02 terminator.
N $E11D Sprite #N$149, Frame #N$03 ($19 bytes).
  $E11D,$02 X/ Y position offsets.
  $E11F,$17 Pixel/ control data.
  $E136,$01 Frame #N$03 terminator.
  $E137,$01 Animation sequence terminator.
N $E138 Sprite #N$14A, Frame #N$01.
  $E138,$02 X/ Y position offsets.
  $E13A,$08 Pixel data (2 character rows × 4 bytes each).
  $E142,$01 Frame #N$01 terminator.
  $E143,$01 Frame #N$02 terminator.
N $E144 Sprite #N$14A, Frame #N$03 ($09 bytes).
  $E144,$02 X/ Y position offsets.
  $E146,$07 Pixel/ control data.
  $E14D,$01 Frame #N$03 terminator.
  $E14E,$01 Frame #N$04 terminator.
N $E14F Sprite #N$14A, Frame #N$05 ($08 bytes).
  $E14F,$02 X/ Y position offsets.
  $E151,$06 Pixel/ control data.
  $E157,$01 Animation sequence terminator.
N $E158 Sprite #N$14B, Frame #N$01 ($10 bytes).
  $E158,$02 X/ Y position offsets.
  $E15A,$0E Pixel/ control data.
  $E168,$01 Frame #N$01 terminator.
  $E169,$01 Frame #N$02 terminator.
N $E16A Sprite #N$14B, Frame #N$03 ($0D bytes).
  $E16A,$02 X/ Y position offsets.
  $E16C,$0B Pixel/ control data.
  $E177,$01 Animation sequence terminator.
  $E178,$01 Animation sequence terminator.
  $E179,$01 Animation sequence terminator.
N $E17A Sprite #N$14E, Frame #N$01 ($09 bytes).
  $E17A,$02 X/ Y position offsets.
  $E17C,$07 Pixel/ control data.
  $E183,$01 Frame #N$01 terminator.
  $E184,$01 Frame #N$02 terminator.
  $E185,$01 Frame #N$03 terminator.
N $E186 Sprite #N$14E, Frame #N$04 ($10 bytes).
  $E186,$02 X/ Y position offsets.
  $E188,$0E Pixel/ control data.
  $E196,$01 Frame #N$04 terminator.
  $E197,$01 Animation sequence terminator.
N $E198 Sprite #N$14F, Frame #N$01.
  $E198,$02 X/ Y position offsets.
  $E19A,$08 Pixel data (2 character rows × 4 bytes each).
  $E1A2,$01 Frame #N$01 terminator.
  $E1A3,$01 Frame #N$02 terminator.
N $E1A4 Sprite #N$14F, Frame #N$03 ($09 bytes).
  $E1A4,$02 X/ Y position offsets.
  $E1A6,$07 Pixel/ control data.
  $E1AD,$01 Frame #N$03 terminator.
  $E1AE,$01 Frame #N$04 terminator.
N $E1AF Sprite #N$14F, Frame #N$05 ($19 bytes).
  $E1AF,$02 X/ Y position offsets.
  $E1B1,$17 Pixel/ control data.
  $E1C8,$01 Frame #N$05 terminator.
  $E1C9,$01 Frame #N$06 terminator.
  $E1CA,$01 Frame #N$07 terminator.
N $E1CB Sprite #N$14F, Frame #N$08 ($10 bytes).
  $E1CB,$02 X/ Y position offsets.
  $E1CD,$0E Pixel/ control data.
  $E1DB,$01 Frame #N$08 terminator.
  $E1DC,$01 Animation sequence terminator.
N $E1DD Sprite #N$150, Frame #N$01 (control byte).
  $E1DD,$01 Control data.
  $E1DE,$01 Frame #N$01 terminator.
N $E1DF Sprite #N$150, Frame #N$02 ($10 bytes).
  $E1DF,$02 X/ Y position offsets.
  $E1E1,$0E Pixel/ control data.
  $E1EF,$01 Frame #N$02 terminator.
  $E1F0,$01 Frame #N$03 terminator.
N $E1F1 Sprite #N$150, Frame #N$04 ($19 bytes).
  $E1F1,$02 X/ Y position offsets.
  $E1F3,$17 Pixel/ control data.
  $E20A,$01 Frame #N$04 terminator.
  $E20B,$01 Frame #N$05 terminator.
  $E20C,$01 Frame #N$06 terminator.
N $E20D Sprite #N$150, Frame #N$07 ($10 bytes).
  $E20D,$02 X/ Y position offsets.
  $E20F,$0E Pixel/ control data.
  $E21D,$01 Frame #N$07 terminator.
  $E21E,$01 Frame #N$08 terminator.
N $E21F Sprite #N$150, Frame #N$09 ($09 bytes).
  $E21F,$02 X/ Y position offsets.
  $E221,$07 Pixel/ control data.
  $E228,$01 Frame #N$09 terminator.
  $E229,$01 Animation sequence terminator.
  $E22A,$01 Frame #N$01 terminator.
  $E22B,$01 Frame #N$02 terminator.
N $E22C Sprite #N$151, Frame #N$03 ($03 bytes).
  $E22C,$02 X/ Y position offsets.
  $E22E,$01 Pixel/ control data.
  $E22F,$01 Animation sequence terminator.
N $E230 Sprite #N$152, Frame #N$01 ($0C bytes).
  $E230,$02 X/ Y position offsets.
  $E232,$0A Pixel/ control data.
  $E23C,$01 Frame #N$01 terminator.
  $E23D,$01 Frame #N$02 terminator.
  $E23E,$01 Frame #N$03 terminator.
N $E23F Sprite #N$152, Frame #N$04 ($10 bytes).
  $E23F,$02 X/ Y position offsets.
  $E241,$0E Pixel/ control data.
  $E24F,$01 Frame #N$04 terminator.
  $E250,$01 Animation sequence terminator.
N $E251 Sprite #N$153, Frame #N$01 (control byte).
  $E251,$01 Control data.
  $E252,$01 Frame #N$01 terminator.
N $E253 Sprite #N$153, Frame #N$02 ($10 bytes).
  $E253,$02 X/ Y position offsets.
  $E255,$0E Pixel/ control data.
  $E263,$01 Frame #N$02 terminator.
  $E264,$01 Animation sequence terminator.
  $E265,$01 Frame #N$01 terminator.
  $E266,$01 Frame #N$02 terminator.
N $E267 Sprite #N$154, Frame #N$03 (control byte).
  $E267,$01 Control data.
  $E268,$01 Animation sequence terminator.
N $E269 Sprite #N$155, Frame #N$01 (position only).
  $E269,$02 X/ Y position offsets.
  $E26B,$01 Animation sequence terminator.
N $E26C Sprite #N$156, Frame #N$01 ($06 bytes).
  $E26C,$02 X/ Y position offsets.
  $E26E,$04 Pixel/ control data.
  $E272,$01 Animation sequence terminator.
  $E273,$01 Animation sequence terminator.
N $E274 Sprite #N$158, Frame #N$01 ($03 bytes).
  $E274,$02 X/ Y position offsets.
  $E276,$01 Pixel/ control data.
  $E277,$01 Frame #N$01 terminator.
  $E278,$01 Frame #N$02 terminator.
  $E279,$01 Frame #N$03 terminator.
N $E27A Sprite #N$158, Frame #N$04 ($10 bytes).
  $E27A,$02 X/ Y position offsets.
  $E27C,$0E Pixel/ control data.
  $E28A,$01 Frame #N$04 terminator.
  $E28B,$01 Animation sequence terminator.
  $E28C,$01 Frame #N$01 terminator.
  $E28D,$01 Frame #N$02 terminator.
N $E28E Sprite #N$159, Frame #N$03 ($0E bytes).
  $E28E,$02 X/ Y position offsets.
  $E290,$0C Pixel/ control data.
  $E29C,$01 Animation sequence terminator.
N $E29D Sprite #N$15A, Frame #N$01 (control byte).
  $E29D,$01 Control data.
  $E29E,$01 Frame #N$01 terminator.
  $E29F,$01 Frame #N$02 terminator.
  $E2A0,$01 Frame #N$03 terminator.
N $E2A1 Sprite #N$15A, Frame #N$04 ($10 bytes).
  $E2A1,$02 X/ Y position offsets.
  $E2A3,$0E Pixel/ control data.
  $E2B1,$01 Frame #N$04 terminator.
  $E2B2,$01 Animation sequence terminator.
N $E2B3 Sprite #N$15B, Frame #N$01 (control byte).
  $E2B3,$01 Control data.
  $E2B4,$01 Frame #N$01 terminator.
N $E2B5 Sprite #N$15B, Frame #N$02 ($06 bytes).
  $E2B5,$02 X/ Y position offsets.
  $E2B7,$04 Pixel/ control data.
  $E2BB,$01 Animation sequence terminator.
  $E2BC,$01 Animation sequence terminator.
  $E2BD,$01 Frame #N$01 terminator.
  $E2BE,$01 Frame #N$02 terminator.
N $E2BF Sprite #N$15D, Frame #N$03 ($0F bytes).
  $E2BF,$02 X/ Y position offsets.
  $E2C1,$0D Pixel/ control data.
  $E2CE,$01 Animation sequence terminator.
N $E2CF Sprite #N$15E, Frame #N$01 (control byte).
  $E2CF,$01 Control data.
  $E2D0,$01 Frame #N$01 terminator.
  $E2D1,$01 Frame #N$02 terminator.
  $E2D2,$01 Frame #N$03 terminator.
N $E2D3 Sprite #N$15E, Frame #N$04 ($10 bytes).
  $E2D3,$02 X/ Y position offsets.
  $E2D5,$0E Pixel/ control data.
  $E2E3,$01 Frame #N$04 terminator.
  $E2E4,$01 Animation sequence terminator.
N $E2E5 Sprite #N$15F, Frame #N$01.
  $E2E5,$02 X/ Y position offsets.
  $E2E7,$08 Pixel data (2 character rows × 4 bytes each).
  $E2EF,$01 Frame #N$01 terminator.
  $E2F0,$01 Frame #N$02 terminator.
  $E2F1,$01 Frame #N$03 terminator.
N $E2F2 Sprite #N$15F, Frame #N$04 ($10 bytes).
  $E2F2,$02 X/ Y position offsets.
  $E2F4,$0E Pixel/ control data.
  $E302,$01 Frame #N$04 terminator.
  $E303,$01 Frame #N$05 terminator.
  $E304,$01 Frame #N$06 terminator.
N $E305 Sprite #N$15F, Frame #N$07 ($10 bytes).
  $E305,$02 X/ Y position offsets.
  $E307,$0E Pixel/ control data.
  $E315,$01 Frame #N$07 terminator.
  $E316,$01 Animation sequence terminator.
N $E317 Sprite #N$160, Frame #N$01 ($04 bytes).
  $E317,$02 X/ Y position offsets.
  $E319,$02 Pixel/ control data.
  $E31B,$01 Animation sequence terminator.
N $E31C Sprite #N$161, Frame #N$01 (position only).
  $E31C,$02 X/ Y position offsets.
  $E31E,$01 Animation sequence terminator.
N $E31F Sprite #N$162, Frame #N$01 (position only).
  $E31F,$02 X/ Y position offsets.
  $E321,$01 Frame #N$01 terminator.
  $E322,$01 Frame #N$02 terminator.
N $E323 Sprite #N$162, Frame #N$03 ($09 bytes).
  $E323,$02 X/ Y position offsets.
  $E325,$07 Pixel/ control data.
  $E32C,$01 Frame #N$03 terminator.
  $E32D,$01 Frame #N$04 terminator.
  $E32E,$01 Frame #N$05 terminator.
N $E32F Sprite #N$162, Frame #N$06 ($10 bytes).
  $E32F,$02 X/ Y position offsets.
  $E331,$0E Pixel/ control data.
  $E33F,$01 Frame #N$06 terminator.
  $E340,$01 Frame #N$07 terminator.
  $E341,$01 Frame #N$08 terminator.
N $E342 Sprite #N$162, Frame #N$09 ($10 bytes).
  $E342,$02 X/ Y position offsets.
  $E344,$0E Pixel/ control data.
  $E352,$01 Frame #N$09 terminator.
  $E353,$01 Animation sequence terminator.
N $E354 Sprite #N$163, Frame #N$01.
  $E354,$02 X/ Y position offsets.
  $E356,$08 Pixel data (2 character rows × 4 bytes each).
  $E35E,$01 Frame #N$01 terminator.
  $E35F,$01 Frame #N$02 terminator.
  $E360,$01 Frame #N$03 terminator.
N $E361 Sprite #N$163, Frame #N$04 ($10 bytes).
  $E361,$02 X/ Y position offsets.
  $E363,$0E Pixel/ control data.
  $E371,$01 Frame #N$04 terminator.
  $E372,$01 Animation sequence terminator.
N $E373 Sprite #N$164, Frame #N$01 (control byte).
  $E373,$01 Control data.
  $E374,$01 Frame #N$01 terminator.
N $E375 Sprite #N$164, Frame #N$02 ($07 bytes).
  $E375,$02 X/ Y position offsets.
  $E377,$05 Pixel/ control data.
  $E37C,$01 Animation sequence terminator.
N $E37D Sprite #N$165, Frame #N$01 ($08 bytes).
  $E37D,$02 X/ Y position offsets.
  $E37F,$06 Pixel/ control data.
  $E385,$01 Frame #N$01 terminator.
  $E386,$01 Frame #N$02 terminator.
  $E387,$01 Frame #N$03 terminator.
N $E388 Sprite #N$165, Frame #N$04 ($10 bytes).
  $E388,$02 X/ Y position offsets.
  $E38A,$0E Pixel/ control data.
  $E398,$01 Frame #N$04 terminator.
  $E399,$01 Animation sequence terminator.
N $E39A Sprite #N$166, Frame #N$01.
  $E39A,$02 X/ Y position offsets.
  $E39C,$08 Pixel data (2 character rows × 4 bytes each).
  $E3A4,$01 Frame #N$01 terminator.
  $E3A5,$01 Frame #N$02 terminator.
  $E3A6,$01 Frame #N$03 terminator.
N $E3A7 Sprite #N$166, Frame #N$04 ($10 bytes).
  $E3A7,$02 X/ Y position offsets.
  $E3A9,$0E Pixel/ control data.
  $E3B7,$01 Frame #N$04 terminator.
  $E3B8,$01 Animation sequence terminator.
N $E3B9 Sprite #N$167, Frame #N$01 (control byte).
  $E3B9,$01 Control data.
  $E3BA,$01 Frame #N$01 terminator.
N $E3BB Sprite #N$167, Frame #N$02 ($03 bytes).
  $E3BB,$02 X/ Y position offsets.
  $E3BD,$01 Pixel/ control data.
  $E3BE,$01 Animation sequence terminator.
N $E3BF Sprite #N$168, Frame #N$01 ($0C bytes).
  $E3BF,$02 X/ Y position offsets.
  $E3C1,$0A Pixel/ control data.
  $E3CB,$01 Frame #N$01 terminator.
  $E3CC,$01 Frame #N$02 terminator.
  $E3CD,$01 Frame #N$03 terminator.
N $E3CE Sprite #N$168, Frame #N$04 ($10 bytes).
  $E3CE,$02 X/ Y position offsets.
  $E3D0,$0E Pixel/ control data.
  $E3DE,$01 Frame #N$04 terminator.
  $E3DF,$01 Animation sequence terminator.
N $E3E0 Sprite #N$169, Frame #N$01.
  $E3E0,$02 X/ Y position offsets.
  $E3E2,$08 Pixel data (2 character rows × 4 bytes each).
  $E3EA,$01 Frame #N$01 terminator.
  $E3EB,$01 Frame #N$02 terminator.
N $E3EC Sprite #N$169, Frame #N$03 ($09 bytes).
  $E3EC,$02 X/ Y position offsets.
  $E3EE,$07 Pixel/ control data.
  $E3F5,$01 Frame #N$03 terminator.
  $E3F6,$01 Animation sequence terminator.
N $E3F7 Sprite #N$16A, Frame #N$01 ($05 bytes).
  $E3F7,$02 X/ Y position offsets.
  $E3F9,$03 Pixel/ control data.
  $E3FC,$01 Animation sequence terminator.
  $E3FD,$01 Animation sequence terminator.
  $E3FE,$01 Animation sequence terminator.
N $E3FF Sprite #N$16D, Frame #N$01 (position only).
  $E3FF,$02 X/ Y position offsets.
  $E401,$01 Frame #N$01 terminator.
  $E402,$01 Frame #N$02 terminator.
N $E403 Sprite #N$16D, Frame #N$03 ($09 bytes).
  $E403,$02 X/ Y position offsets.
  $E405,$07 Pixel/ control data.
  $E40C,$01 Frame #N$03 terminator.
  $E40D,$01 Animation sequence terminator.
N $E40E Sprite #N$16E, Frame #N$01 ($12 bytes).
  $E40E,$02 X/ Y position offsets.
  $E410,$10 Pixel/ control data.
  $E420,$01 Frame #N$01 terminator.
  $E421,$01 Frame #N$02 terminator.
  $E422,$01 Frame #N$03 terminator.
N $E423 Sprite #N$16E, Frame #N$04 ($10 bytes).
  $E423,$02 X/ Y position offsets.
  $E425,$0E Pixel/ control data.
  $E433,$01 Frame #N$04 terminator.
  $E434,$01 Animation sequence terminator.
N $E435 Sprite #N$16F, Frame #N$01 ($09 bytes).
  $E435,$02 X/ Y position offsets.
  $E437,$07 Pixel/ control data.
  $E43E,$01 Animation sequence terminator.
  $E43F,$01 Animation sequence terminator.
  $E440,$01 Animation sequence terminator.
N $E441 Sprite #N$172, Frame #N$01 ($06 bytes).
  $E441,$02 X/ Y position offsets.
  $E443,$04 Pixel/ control data.
  $E447,$01 Frame #N$01 terminator.
  $E448,$01 Frame #N$02 terminator.
  $E449,$01 Frame #N$03 terminator.
N $E44A Sprite #N$172, Frame #N$04 ($10 bytes).
  $E44A,$02 X/ Y position offsets.
  $E44C,$0E Pixel/ control data.
  $E45A,$01 Frame #N$04 terminator.
  $E45B,$01 Animation sequence terminator.
N $E45C Sprite #N$173, Frame #N$01 ($05 bytes).
  $E45C,$02 X/ Y position offsets.
  $E45E,$03 Pixel/ control data.
  $E461,$01 Animation sequence terminator.
N $E462 Sprite #N$174, Frame #N$01 ($04 bytes).
  $E462,$02 X/ Y position offsets.
  $E464,$02 Pixel/ control data.
  $E466,$01 Frame #N$01 terminator.
  $E467,$01 Frame #N$02 terminator.
  $E468,$01 Frame #N$03 terminator.
N $E469 Sprite #N$174, Frame #N$04 ($0F bytes).
  $E469,$02 X/ Y position offsets.
  $E46B,$0D Pixel/ control data.
  $E478,$01 Frame #N$04 terminator.
  $E479,$01 Frame #N$05 terminator.
  $E47A,$01 Frame #N$06 terminator.
  $E47B,$01 Frame #N$07 terminator.
N $E47C Sprite #N$174, Frame #N$08 ($0C bytes).
  $E47C,$02 X/ Y position offsets.
  $E47E,$0A Pixel/ control data.
  $E488,$01 Animation sequence terminator.
N $E489 Sprite #N$175, Frame #N$01 (control byte).
  $E489,$01 Control data.
  $E48A,$01 Animation sequence terminator.
N $E48B Sprite #N$176, Frame #N$01 (control byte).
  $E48B,$01 Control data.
  $E48C,$01 Frame #N$01 terminator.
  $E48D,$01 Animation sequence terminator.
N $E48E Sprite #N$177, Frame #N$01 (control byte).
  $E48E,$01 Control data.
  $E48F,$01 Frame #N$01 terminator.
N $E490 Sprite #N$177, Frame #N$02 ($05 bytes).
  $E490,$02 X/ Y position offsets.
  $E492,$03 Pixel/ control data.
  $E495,$01 Animation sequence terminator.
N $E496 Sprite #N$178, Frame #N$01.
  $E496,$02 X/ Y position offsets.
  $E498,$08 Pixel data (2 character rows × 4 bytes each).
  $E4A0,$01 Frame #N$01 terminator.
  $E4A1,$01 Frame #N$02 terminator.
  $E4A2,$01 Frame #N$03 terminator.
N $E4A3 Sprite #N$178, Frame #N$04 ($0F bytes).
  $E4A3,$02 X/ Y position offsets.
  $E4A5,$0D Pixel/ control data.
  $E4B2,$01 Frame #N$04 terminator.
  $E4B3,$01 Frame #N$05 terminator.
  $E4B4,$01 Frame #N$06 terminator.
  $E4B5,$01 Frame #N$07 terminator.
N $E4B6 Sprite #N$178, Frame #N$08 ($10 bytes).
  $E4B6,$02 X/ Y position offsets.
  $E4B8,$0E Pixel/ control data.
  $E4C6,$01 Frame #N$08 terminator.
  $E4C7,$01 Animation sequence terminator.
N $E4C8 Sprite #N$179, Frame #N$01 (control byte).
  $E4C8,$01 Control data.
  $E4C9,$01 Frame #N$01 terminator.
N $E4CA Sprite #N$179, Frame #N$02 ($07 bytes).
  $E4CA,$02 X/ Y position offsets.
  $E4CC,$05 Pixel/ control data.
  $E4D1,$01 Animation sequence terminator.
N $E4D2 Sprite #N$17A, Frame #N$01 ($08 bytes).
  $E4D2,$02 X/ Y position offsets.
  $E4D4,$06 Pixel/ control data.
  $E4DA,$01 Frame #N$01 terminator.
  $E4DB,$01 Frame #N$02 terminator.
  $E4DC,$01 Frame #N$03 terminator.
N $E4DD Sprite #N$17A, Frame #N$04 ($0B bytes).
  $E4DD,$02 X/ Y position offsets.
  $E4DF,$09 Pixel/ control data.
  $E4E8,$01 Frame #N$04 terminator.
N $E4E9 Sprite #N$17A, Frame #N$05 ($04 bytes).
  $E4E9,$02 X/ Y position offsets.
  $E4EB,$02 Pixel/ control data.
  $E4ED,$01 Frame #N$05 terminator.
  $E4EE,$01 Frame #N$06 terminator.
  $E4EF,$01 Frame #N$07 terminator.
N $E4F0 Sprite #N$17A, Frame #N$08 ($08 bytes).
  $E4F0,$02 X/ Y position offsets.
  $E4F2,$06 Pixel/ control data.
  $E4F8,$01 Animation sequence terminator.
N $E4F9 Sprite #N$17B, Frame #N$01 (control byte).
  $E4F9,$01 Control data.
  $E4FA,$01 Animation sequence terminator.
N $E4FB Sprite #N$17C, Frame #N$01 ($05 bytes).
  $E4FB,$02 X/ Y position offsets.
  $E4FD,$03 Pixel/ control data.
  $E500,$01 Frame #N$01 terminator.
  $E501,$01 Animation sequence terminator.
N $E502 Sprite #N$17D, Frame #N$01 (control byte).
  $E502,$01 Control data.
  $E503,$01 Frame #N$01 terminator.
N $E504 Sprite #N$17D, Frame #N$02 (control byte).
  $E504,$01 Control data.
  $E505,$01 Animation sequence terminator.
N $E506 Sprite #N$17E, Frame #N$01 ($0E bytes).
  $E506,$02 X/ Y position offsets.
  $E508,$0C Pixel/ control data.
  $E514,$01 Frame #N$01 terminator.
  $E515,$01 Frame #N$02 terminator.
  $E516,$01 Frame #N$03 terminator.
N $E517 Sprite #N$17E, Frame #N$04 ($0B bytes).
  $E517,$02 X/ Y position offsets.
  $E519,$09 Pixel/ control data.
  $E522,$01 Frame #N$04 terminator.
N $E523 Sprite #N$17E, Frame #N$05 ($04 bytes).
  $E523,$02 X/ Y position offsets.
  $E525,$02 Pixel/ control data.
  $E527,$01 Frame #N$05 terminator.
  $E528,$01 Frame #N$06 terminator.
  $E529,$01 Frame #N$07 terminator.
N $E52A Sprite #N$17E, Frame #N$08 ($10 bytes).
  $E52A,$02 X/ Y position offsets.
  $E52C,$0E Pixel/ control data.
  $E53A,$01 Frame #N$08 terminator.

  $C502,$08 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(graphic-(#PC)) } TABLE#
  $C519,$08 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(graphic-(#PC)) } TABLE#
  $C740,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C740-$C748-$08(player-01) } TABLE#
  $C753,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C753-$C75B-$08(player-02) } TABLE#
  $C766,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C766-$C76E-$08(player-03) } TABLE#
  $C777,$0A #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C777-$C77F-$08{$00,$00,$20,$28}(player-04) } TABLE#
  $C785,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C785-$C78D-$08(graphic-32) } TABLE#
  $C796,$1A #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C796-$C7AE-$08{$00,$00,$20,$68}(graphic-33) } TABLE#

B $D59B #UDGARRAY$01,attr=$07,scale=$04,step=$01;$D59B-$D5B3-$08(kangaroo)

b $E600

c $E800 Initialise Demo Mode
@ $E800 label=InitialiseDemoMode
  $E800,$06 Write #R$73B7 to *#R$782C.
  $E806,$05 Write #N$05 to *#R$7820.
  $E80B,$03 Jump to #R$6CAA.

c $E80E Initialise Game
@ $E80E label=InitialiseGame
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
M $E827,$05 Write #N$FF to *#R$7820.
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
  $E84D,$03 Write #REGhl to *#R$783E.
  $E850,$03 #REGa=*#R$7852.
  $E853,$03 Jump to #R$E85C if #REGa is zero.
  $E856,$01 Decrease #REGa by one.
  $E857,$03 Write #REGa to *#R$7852.
  $E85A,$01 Restore #REGhl from the stack.
  $E85B,$01 Return.
  $E85C,$06 Return if bit 4 of *#R$7828 is zero.
  $E862,$05 Write #N$4B to *#R$7852.
  $E867,$03 #REGa=*#R$783C(#N$783D).
  $E86A,$02 #REGa-=#N$08.
  $E86C,$03 Write #REGa to *#R$783C(#N$783D).
  $E86F,$01 Restore #REGhl from the stack.
  $E870,$01 Return.

t $E871 Messaging: Welcome
@ $E871 label=Messaging_Welcome
  $E871,$20 "#STR(#PC,$04,$20)".

c $E891 Display Start Screen
@ $E891 label=DisplayStartScreen
D $E891 Used by the routine at #R$E80E.
. #UDGTABLE(default,centre) { #PUSHS #SIM(start=$E821,stop=$E8DD) #SCR$02(start-screen) #POPS } UDGTABLE#
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

u $E8E0

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
D $E8F6 Input method; used by the routine at #R$6B48.
  $E8F6,$02 Read Kempston Joystick input.
  $E8F8,$01 Return.

u $E8F9

t $E900 Messaging: Control Selection
@ $E900 label=Messaging_ControlSelection
  $E900,$A0,$20 Wheelie control selection page.
@ $E9A0 label=Messaging_Blank
  $E9A0,$40,$20 Empty blanking space.
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
. #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$E821,stop=$E8C0)#SIM(start=$EB43,stop=$E8DD)
.   #SCR$02(change-controls)
. } UDGTABLE# #POPS
  $EB43,$03 #REGhl=#R$E900.
  $EB46,$02 #REGc=#N$04 (four "blocks" of text).
  $EB48,$01 Switch to the shadow registers.
  $EB49,$03 #REGde'=#N$4060 (screen buffer location).
  $EB4C,$01 Switch to the shadow registers.
N $EB4D Re-use the same printing routine as the start screen.
  $EB4D,$03 Call #R$E8CA.
  $EB50,$06 #HTML(Write #N$01 to <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>
. and #N$01 to <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
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
N $EB83 #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$749C,stop=$74A8)#SIM(start=$EB86,stop=$EBB3)
.   #SCR$02(user-defined-left)
. } UDGTABLE# #POPS
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
  $EBBB,$03 #HTML(#REGhl=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>.)
  $EBBE,$02 Reset bit 5 of *#REGhl.
@ $EBC0 label=UserDefinedControls_InputLoop
  $EBC0,$01 #HTML(Call <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/0038.html">MASK_INT</a>)
  $EBC1,$04 Jump to #R$EBC0 until any key is pressed.
N $EBC5 Fetch the user keypress.
  $EBC5,$03 #HTML(#REGa=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
  $EBC8,$01 Write the keypress to the current position in *#R$7853.
  $EBC9,$01 Move onto the next control key.
N $EBCA Warn the user that we debounce using pauses rather than wait for the key to be released.
N $EBCA #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$749C,stop=$74A8)#SIM(start=$EB86,stop=$EBB3)#SIM(start=$EBCA,stop=$EBD6)
.   #SCR$02(user-defined-warning)
. } UDGTABLE# #POPS
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
  $EBD9,$03 Debounce using #R$EBE6.
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

c $EBF3 Frame Synchronisation
@ $EBF3 label=WaitForNextFrame
  $EBF3,$03 #REGa=*#R$785A.
@ $EBF6 label=WaitForFrameChange
  $EBF6,$03 #HTML(#REGhl=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
N $EBF9 Wait loop, hold further execution until the frame counter changes to
. the stored value.
@ $EBF9 label=FrameSyncLoop
  $EBF9,$03 #HTML(Keep jumping back to #R$EBF9 until
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>
. matches *#R$785A.)
  $EBFC,$03 Jump to #R$6C00.

u $EBFF

c $EC00 Frame Synchronisation Check
@ $EC00 label=FrameSyncCheck
D $EC00 Check if this is a new video frame and jump to the game loop if it is.
  $EC00,$01 Switch to the shadow registers.
  $EC01,$01 Save the #REGa register to #REGc' temporarily.
  $EC02,$07 #HTML(Compare *#R$785A to 
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>
. ).
  $EC09,$01 Restore #REGa back to its original value.
  $EC0A,$01 Switch back to the normal registers.
  $EC0B,$01 Return if this is still the same frame.
  $EC0C,$03 Jump to #R$6C00 if a new frame has started.

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

c $EC35 Play Melody
@ $EC35 label=PlayMelody
R $EC35 HL Pointer to music data
  $EC35,$01 Disable interrupts.
  $EC36,$01 #REGa=#N$00.
@ $EC37 label=FetchNote
  $EC37,$01 #REGc=*#REGhl.
N $EC38 Check for the terminator (#N$FF).
  $EC38,$01 Increment #REGc by one.
  $EC39,$02 Jump to #R$EC3D if #REGc is not zero.
N $EC3B The terminator (#N$FF) was reached so return.
  $EC3B,$01 Enable interrupts.
  $EC3C,$01 Return.
N $EC3D Restore the real value of the note after the terminator check.
@ $EC3D label=PlayingMelody
  $EC3D,$01 Decrease #REGc by one.
  $EC3E,$01 Increment the music data pointer by one.
  $EC3F,$01 #REGe=*#REGhl.
  $EC40,$01 Increment the music data pointer by one.
  $EC41,$01 #REGd=*#REGhl.
  $EC42,$01 Increment the music data pointer by one.
@ $EC43 label=PlayMelody_Speaker
  $EC43,$02 OUT #N$FE
  $EC45,$01 #REGb=#REGc.
  $EC46,$02,b$01 Flip bit 4.
@ $EC48 label=PlayMelody_Loop
  $EC48,$02 Decrease counter by one and loop back to #R$EC48 until counter is zero.
  $EC4A,$01 #REGb=#REGa.
  $EC4B,$01 Decrease #REGde by one.
  $EC4C,$02 Is #REGde zero?
  $EC4E,$01 #REGa=#REGb.
  $EC4F,$02 Jump to #R$EC43 if #REGde is not zero.
  $EC51,$02 #REGd=#N$0F.
@ $EC53 label=PlayMelody_Pause
  $EC53,$01 Decrease #REGde by one.
  $EC54,$02 Is #REGde zero?
  $EC56,$02 Jump to #R$EC53 if #REGde is not zero.
  $EC58,$01 #REGa=#REGb.
  $EC59,$01 Increment #REGa by one.
  $EC5A,$02,b$01 Keep only bits 0-2 and 4.
  $EC5C,$02 Jump to #R$EC37.

c $EC5E Sounds: Level Complete
@ $EC5E label=Sounds_LevelComplete
N $EC5E #HTML(#AUDIO(level-complete.wav)(#INCLUDE(LevelComplete)))
  $EC5E,$03 #REGhl=#R$EEE8.
  $EC61,$02 Jump to #R$EC35.

c $EC63 Sounds: The Race Is On!
@ $EC63 label=Sounds_TheRaceIsOn
N $EC63 #HTML(#AUDIO(race-is-on.wav)(#INCLUDE(RaceIsOn)))
  $EC63,$03 #REGhl=#R$EF4F.
  $EC66,$02 Jump to #R$EC35.

c $EC68 Sounds: Ghostrider Has Finished
@ $EC68 label=Sounds_GhostriderFinished
N $EC68 #HTML(#AUDIO(ghostrider-finished.wav)(#INCLUDE(GhostriderFinished)))
  $EC68,$03 #REGhl=#R$EFC2.
  $EC6B,$02 Jump to #R$EC35.

u $EC6D

c $EC6E Player Typed Input
@ $EC6E label=PlayerTypedInput
  $EC6E,$04 #HTML(Write #N$00 (cursor type "C", "K" or "L") to
. *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C41.html">MODE</a>.)
  $EC72,$04 #HTML(Set CAPS LOCK on, using bit 3 of *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C6A.html">FLAGS2</a>).
  $EC76,$05 #HTML(Reset bit 5 of 
. *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>
. which resets "when a new key has been pressed".)
@ $EC7B label=PlayerTypedInput_Loop
  $EC7B,$04 Keep jumping back to #R$EC7B until a key was pressed.
N $EC7F Check which key was pressed.
  $EC7F,$03 #HTML(#REGa=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
  $EC82,$04 Jump to #N$EC6F if the ASCII value of the pressed key is #N$80 or 
. higher (anything higher is invalid).
  $EC86,$03 Return if the ASCII value is #N$60 or lower.
  $EC89,$02 Reset bit 5 of #REGa.
  $EC8B,$01 Return.

u $EC8C

c $EC8E Print Instructions
@ $EC8E label=PrintInstructions
R $EC8E HL Instructions page pointer
  $EC8E,$01 Switch to the shadow registers.
  $EC8F,$03 #REGde'=#N$4060 (screen buffer location).
  $EC92,$01 Switch back to the normal registers.
  $EC93,$02 #REGb=#N$A0 (counter; length of text).
  $EC95,$03 Call #R$74D3.
  $EC98,$01 Switch to the shadow registers.
  $EC99,$03 #REGde'=#N$4800 (screen buffer location).
  $EC9C,$01 Switch back to the normal registers.
  $EC9D,$03 Call #R$74D3.
  $ECA0,$01 Switch to the shadow registers.
  $ECA1,$03 #REGde'=#N$5000 (screen buffer location).
  $ECA4,$01 Switch back to the normal registers.
  $ECA5,$02 #REGb=#N$E0 (counter; length of text).
  $ECA7,$03 Call #R$74D3.
  $ECAA,$01 Return.

c $ECAB Check Password
@ $ECAB label=CheckPassword
  $ECAB,$06 #HTML(Write #N$0A23 to <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>/<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
  $ECB1,$03 Call #R$749C.
N $ECB4 Set the attributes for the code entry messaging.
  $ECB4,$03 #REGhl=#N$5900 (attribute buffer location).
  $ECB7,$02 #REGb=#N$40 (counter; two full rows).
@ $ECB9 label=CheckPassword_GreenLoop
  $ECB9,$02 Write #N$04 (#COLOUR$04) to *#REGhl.
  $ECBB,$01 Increment #REGl by one.
  $ECBC,$02 Decrease counter by one and loop back to #R$ECB9 until counter is zero.
N $ECBE Print "#STR($EE14,$03,$20)" to the screen.
  $ECBE,$01 Switch to the shadow registers.
  $ECBF,$03 #REGde'=#N$4800 (screen buffer location).
  $ECC2,$01 Switch back to the normal registers.
  $ECC3,$02 #REGb=#N$40 (counter; two full rows).
  $ECC5,$03 #REGhl=#R$EE14.
  $ECC8,$03 Call #R$74D3.
  $ECCB,$03 Call #R$EC6E.
  $ECCE,$04 Jump to #R$ECDB if #REGa is not equal to #N$0D ("ENTER").
N $ECD2 The player pressed the "ENTER" key to skip entering a code.
@ $ECD2 label=StartGame
  $ECD2,$06 #HTML(Write #N$01 to <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>
.           and #N$01 to <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
  $ECD8,$03 Jump to #R$6CAA.
N $ECDB The player is entering a password to access a later level.
@ $ECDB label=CheckPassword_Input
  $ECDB,$03 #REGde=#R$782E.
  $ECDE,$01 Write #REGa to *#REGde.
  $ECDF,$01 Switch to the shadow registers.
  $ECE0,$02 #REGe'=#N$20.
  $ECE2,$01 Switch back to the normal registers.
  $ECE3,$03 #REGhl=#R$E9A0.
  $ECE6,$02 #REGb=#N$20.
  $ECE8,$03 Call #R$74D3.
  $ECEB,$02 #REGb=#N$04.
  $ECED,$03 #REGhl=#R$EEB4.
N $ECF0 Updates the number suffix in the messaging.
@ $ECF0 label=NumberSuffix
  $ECF0,$01 Switch to the shadow registers.
  $ECF1,$02 #REGe'=#N$09.
  $ECF3,$01 Switch back to the normal registers.
  $ECF4,$01 Stash #REGbc on the stack.
  $ECF5,$02 #REGb=#N$03 (counter; length of number suffix messaging).
  $ECF7,$03 Call #R$74D3.
  $ECFA,$01 Restore #REGbc from the stack.
  $ECFB,$01 Stash #REGhl on the stack.
  $ECFC,$03 Call #R$EC6E.
  $ECFF,$01 Restore #REGhl from the stack.
  $ED00,$01 Increment #REGe by one.
  $ED01,$01 Write #REGa to *#REGde.
  $ED02,$02 Decrease counter by one and loop back to #R$ECF0 until counter is zero.
N $ED04 Test if any of the passwords match the input.
  $ED04,$02 #REGc=#N$07 (counter; there are seven passwords).
  $ED06,$03 #REGhl=#R$EEC0.
@ $ED09 label=CheckPassword_Loop
  $ED09,$02 Reset the user input held by #REGde back to the start of the string (#R$782E).
  $ED0B,$02 #REGb=#N$05 (counter; length of a password string).
@ $ED0D label=CheckLetter_Loop
  $ED0D,$01 Fetch a letter of the user-entered password string.
  $ED0E,$01 Increment the user-entered input pointer by one.
  $ED0F,$03 Jump to #R$ED1D if #REGa is not equal to *#REGhl.
N $ED12 There's a match, move onto the next letter of this password.
  $ED12,$01 Increment #REGhl by one.
  $ED13,$02 Decrease counter by one and loop back to #R$ED0D until counter is zero.
N $ED15 Success! This password is a match!
  $ED15,$02 #REGa=#N$07 (maximum levels).
N $ED17 The position in the password list counts down from #N$07 so this negatively correlates with the level number.
  $ED17,$01 #REGa-=#REGc.
  $ED18,$03 Write #REGa to *#R$7820.
  $ED1B,$02 Jump to #R$ECD2.
N $ED1D This password didn't match, move onto the next one.
@ $ED1D label=NextPassword
  $ED1D,$01 Increment #REGhl by one.
  $ED1E,$02 Decrease counter by one and loop back to #R$ED1D until counter is zero.
N $ED20 Are we out of passwords to check yet?
  $ED20,$01 Decrease #REGc by one.
  $ED21,$02 Jump to #R$ED09 until #REGc is zero.
N $ED23 All passwords have been checked, let the player know their password was entered incorrectly.
  $ED23,$01 Switch to the shadow registers.
  $ED24,$02 #REGe'=#N$00.
  $ED26,$01 Switch back to the normal registers.
  $ED27,$03 #REGhl=#R$EE54.
  $ED2A,$02 #REGb=#N$20 (counter; length of mistake string).
  $ED2C,$03 Call #R$74D3.
  $ED2F,$03 Debounce using #R$EBE6.
  $ED32,$03 Jump to #R$ECAB.

u $ED35

c $ED39 Get Level Password
@ $ED39 label=GetLevelPassword
  $ED39,$03 Call #R$7552.
N $ED3C Create an offset using #REGbc.
  $ED3C,$08 #REGc=*#R$7820*#N$05.
  $ED44,$02 #REGb=#N$00.
  $ED46,$04 #REGhl=#R$EEC0+=#REGbc.
  $ED4A,$03 #REGde=#R$BAC6(#N$BACF).
  $ED4D,$02 #REGc=#N$05.
  $ED4F,$02 Update the password at #R$BAC6 with the password for the new level.
  $ED51,$01 Return.

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
N $ED67 #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8C)
.   #SCR$02(instruction-01)
. } UDGTABLE# #POPS
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
N $ED96 #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA7)
.   #SCR$02(instruction-02)
. } UDGTABLE# #POPS
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
N $EDB1 #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA8)#SIM(start=$EDB1,stop=$EDE4)
.   #SCR$02(instruction-03)
. } UDGTABLE# #POPS
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
N $EDEE #PUSHS #UDGTABLE(default,centre) {
.   #SIM(start=$E821,stop=$E8C0)#SIM(start=$ED52,stop=$ED8D)#SIM(start=$ED96,stop=$EDA8)#SIM(start=$EDB1,stop=$EDE5)#SIM(start=$EDEE,stop=$EDFF)
.   #SCR$02(instruction-04)
. } UDGTABLE# #POPS
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

u $EE09

t $EE14 Messaging: Code Entry
@ $EE14 label=Messaging_CodeEntry
  $EE14,$40,$20 #TABLE(default,centre) #FOR$00,$20,$20(n,{ "#STR(#PC+n,$04,$20)" }, ) TABLE#

t $EE54 Messaging: Code Mistake
@ $EE54 label=Messaging_Mistake
  $EE54,$20 "#STR(#PC,$04,$20)".

t $EE74 Messaging: How To Play Wheelie
@ $EE74 label=Messaging_HowToPlay
  $EE74,$20 "#STR(#PC,$04,$20)".

t $EE94 Messaging: Press Any Key
@ $EE94 label=Messaging_PressAnyKey
  $EE94,$20 "#STR(#PC,$04,$20)".

t $EEB4 Messaging: Code Letter Position
@ $EEB4 label=Messaging_CodeLetterPosition
  $EEB4,$0C,$03

t $EEC0 Messaging: Passwords
@ $EEC0 label=Messaging_Passwords
D $EEC0 Used by the routine at #R$ECAB.
  $EEC0,$05 Password for level #N($01+(#PC-$EEC0)/$05).
L $EEC0,$05,$07

t $EEE3
  $EEE3,$05

b $EEE8 Melody Data: "Level Complete"
@ $EEE8 label=MelodyData_LevelComplete
D $EEE8 Used by the routine at #R$EC5E.
  $EEE8,$66,$03
  $EF4E,$01 Terminator.

b $EF4F Melody Data: "The Race Is On!"
@ $EF4F label=MelodyData_RaceIsOn
D $EF4F Used by the routine at #R$EC63.
  $EF4F,$72,$03
  $EFC1,$01 Terminator.

b $EFC2 Melody Data: "Ghostrider Has Finished"
@ $EFC2 label=MelodyData_GhostriderFinished
D $EFC2 Used by the routine at #R$EC68.
  $EFC2,$3C,$03
  $EFFE,$01 Terminator.

u $EFFF

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
  $FA47
  $FE00
