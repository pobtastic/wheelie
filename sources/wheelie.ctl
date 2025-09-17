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
  $64B0,$04 Search for the next #N$32 markr in the level buffer.
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

c $659C Scroll Playarea
@ $659C label=ScrollPlayarea
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
  $65D2,$01 #REGhl+=#REGhl.
  $65D3,$01 #REGhl+=#REGhl.
  $65D4,$01 Switch to the shadow registers.
  $65D5,$02 #REGb=#N$04.
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

c $6650
  $6650,$03 #REGhl=*#R$7817.
  $6653,$06 Jump to #R$6667 if *#R$7819 is not zero.
  $6659,$04 Jump to #R$6661 if #REGl is not zero.
  $665D,$04 #REGh-=#N$05.
  $6661,$01 Decrease #REGl by one.
  $6662,$03 Write #REGhl to *#R$7817.
  $6665,$02 #REGa=#N$08.
  $6667,$01 Decrease #REGa by one.
  $6668,$03 Write #REGa to *#R$7819.
  $666B,$01 #REGd=#REGh.
  $666C,$01 #REGe=#REGl.
  $666D,$02 #REGb=#N$FF.
  $666F,$03 Call #R$6564.
  $6672,$03 #REGhl=#R$4000(#N$4000) (screen buffer).
  $6675,$01 #REGd=#REGh.
  $6676,$01 #REGe=#REGl.
  $6677,$01 Switch to the shadow registers.
  $6678,$01 #REGa=*#REGde.
  $6679,$01 Increment #REGe by one.
  $667A,$01 #REGl=#REGa.
  $667B,$02 #REGh=#N$1F.
  $667D,$01 #REGhl+=#REGhl.
  $667E,$01 #REGhl+=#REGhl.
  $667F,$01 Switch to the shadow registers.
  $6680,$02 #REGb=#N$04.
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
  $66F3,$01 #REGh=#REGd.
  $66F4,$01 Switch to the shadow registers.
  $66F5,$02 Decrease counter by one and loop back to #R$6678 until counter is zero.
  $66F7,$01 Switch to the shadow registers.
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

c $6880

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

c $68EC
  $68EC,$01 Switch to the shadow registers.
  $68ED,$03 Write #REGhl' to *#R$781C.
  $68F0,$01 #REGa=#REGb'.
  $68F1,$03 Write #REGa to *#R$781B.
  $68F4,$01 Switch back to the normal registers.
  $68F5,$01 Return.

c $68F6 Draw Sprite
@ $68F6 label=DrawSprite
  $68F6,$01 #REGa=*#REGhl.
  $68F7,$01 Switch to the shadow registers.
  $68F8,$01 Write #REGa to *#REGhl'.
  $68F9,$01 Increment #REGhl' by one.
  $68FA,$01 Switch back to the normal registers.
  $68FB,$01 #REGa=*#REGbc.
  $68FC,$01 Write #REGa to *#REGhl.
  $68FD,$01 Increment #REGbc by one.
  $68FE,$01 Increment #REGh by one.
  $68FF,$01 #REGa=*#REGbc.
  $6900,$01 Write #REGa to *#REGhl.
  $6901,$01 Increment #REGbc by one.
  $6902,$01 Increment #REGh by one.
  $6903,$01 #REGa=*#REGhl.
  $6904,$01 Switch to the shadow registers.
  $6905,$01 Write #REGa to *#REGhl'.
  $6906,$01 Increment #REGhl' by one.
  $6907,$01 Switch back to the normal registers.
  $6908,$01 #REGa=*#REGbc.
  $6909,$01 Write #REGa to *#REGhl.
  $690A,$01 Increment #REGbc by one.
  $690B,$01 Increment #REGh by one.
  $690C,$01 #REGa=*#REGbc.
  $690D,$01 Write #REGa to *#REGhl.
  $690E,$01 Increment #REGbc by one.
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
  $691B,$01 Increment #REGb' by one.
  $691C,$01 Write #REGa to *#REGhl'.
  $691D,$01 Increment #REGhl' by one.
  $691E,$01 Write #REGe to *#REGhl'.
  $691F,$01 Increment #REGhl' by one.
  $6920,$01 Write #REGd to *#REGhl'.
  $6921,$01 Increment #REGhl' by one.
  $6922,$02 Compare #REGa with #N$07.
  $6924,$01 #REGa=#REGc'.
  $6925,$01 Switch back to the normal registers.
  $6926,$01 Write #REGa to *#REGhl.
  $6927,$01 Return if #REGa was not equal to #N$07 on line #R$6922.
  $6928,$03 Jump to #R$73F2.

u $692B
  $692B,$01 Return.

c $692C Draw Sprite Object
@ $692C label=DrawSpriteObject
R $692C DE Sprite screen position
R $692C A Sprite frame ID
R $692C C Sprite colour
  $692C,$01 Store the sprite frame ID in #REGb.
  $692D,$01 Load the sprite attribute value into #REGa.
  $692E,$01 Switch to the shadow registers.
  $692F,$03 #REGhl'=*#R$781C.
  $6932,$01 Load the sprite attribute value into #REGc'.
  $6933,$04 Load *#R$781B into #REGb'.
  $6937,$01 Switch back to the normal registers.
N $6938 Calculate the sprite data address from the frame ID.
  $6938,$03 Load #REGl with the frame ID multiplied by #N$02.
  $693B,$04 Load #REGh with the high byte for the graphics data: #N$BE.
  $693F,$01 Load the original frame ID into #REGa.
N $6940 Fetch the sprite data.
  $6940,$01 #REGc=*#REGhl.
  $6941,$01 Increment #REGl by one.
  $6942,$01 #REGb=*#REGhl.
  $6943,$02 Test bit 5 of #REGa.
  $6945,$03 Jump to #R$6DA8 if {} is not zero.
  $6948,$01 #REGa=*#REGbc.
  $6949,$01 Increment #REGbc by one.
  $694A,$01 #REGa+=#REGe.
  $694B,$01 #REGe=#REGa.
  $694C,$01 #REGa=*#REGbc.
  $694D,$01 Increment #REGbc by one.
  $694E,$01 #REGa+=#REGd.
  $694F,$01 #REGd=#REGa.
  $6950,$04 Jump to #R$6959 if #REGa is higher than #N$10.
  $6954,$05 Jump to #R$696E if #REGe is lower than #N$20.
  $6959,$03 #REGhl=#N($0008,$04,$04).
  $695C,$01 #REGhl+=#REGbc.
  $695D,$01 #REGb=#REGh.
  $695E,$01 #REGc=#REGl.
M $6959,$06 #REGbc+=#N($0008,$04,$04).
  $695F,$01 #REGa=*#REGbc.
N $6960 Check for the terminator (#N$FF+#N$01 will set the Z flag).
  $6960,$01 Increment #REGa by one.
  $6961,$02 #REGa=#N$01.
  $6963,$02 Jump to #R$694E if #REGa was not zero (on line #R$6960).
N $6965 We reached the terminator.
  $6965,$01 Increment #REGbc by one.
  $6966,$05 Jump to #R$6949 if *#REGbc is not equal to #N$80.
  $696B,$03 Jump to #R$68EC.
  $696E,$01 #REGa=#REGd.
  $696F,$02 #REGa+=#N$40.
  $6971,$02,b$01 Keep only bits 3 and 6.
  $6973,$01 #REGh=#REGa.
  $6974,$01 #REGa=#REGd.
  $6975,$03 Rotate #REGa right three positions (bits 0 to 2 are now in positions 5 to 7).
  $6978,$02,b$01 Keep only bits 5-7.
  $697A,$01 #REGa+=#REGe.
  $697B,$01 #REGl=#REGa.
  $697C,$03 Call #R$68F6.
  $697F,$01 Increment #REGh by one.
  $6980,$03 Call #R$68F6.
  $6983,$03 Call #R$6910.
  $6986,$02 Jump to #R$695F.
  $6988,$03 Write #REGa to *#R$7825.
  $698B,$01 Switch to the shadow registers.
  $698C,$01 Write #REGa to *#REGhl.
  $698D,$01 #REGh=#REGb.
  $698E,$01 #REGl=#REGc.
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
@ $6B2D label=Handler: PlayerSprite
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

c $6B4C

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

c $6DA8

c $6E18
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
  $6E57,$01 Stash #REGaf on the stack.
  $6E58,$06 No operation.
  $6E5E,$03 Call #R$6B2D.
  $6E61,$01 Restore #REGaf from the stack.
  $6E62,$02,b$01 Keep only bits 0-3.
  $6E64,$02 #REGa-=#N$08.
  $6E66,$01 #REGb=#REGa.
  $6E67,$03 #REGa=*#R$7822.
  $6E6A,$02 Test bit 7 of #REGa.
  $6E6C,$02 #REGa=#N$12.
  $6E6E,$02 Jump to #R$6E72 if {} is zero.
  $6E70,$02 #REGa=#N$0D.
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
  $6EA6,$02 #REGb=#N$04.
  $6EA8,$02 #REGa=#N$06.
  $6EAA,$01 Write #REGa to *#REGde.
  $6EAB,$01 Increment #REGe by one.
  $6EAC,$02 Decrease counter by one and loop back to #R$6EAA until counter is zero.
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

c $7161
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
  $7354,$02 #REGc=#N$44.
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

c $7420
  $7420,$03 #REGhl=*#R$7844.
  $7423,$04 #REGde=*#R$7846.
  $7427,$01 Set flags.
  $7428,$02 #REGhl-=#REGde (with carry).
  $742A,$01 Return if the result is zero.
  $742B,$01 #REGhl+=#REGde.
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
  $746D,$03 #REGbc'=#R$784B.
N $7470 #HTML(Work out the ZX Spectrum ROM location of the number UDG, e.g. "1" would be
. <a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html#3d89">#N$3D89</a>.)
N $7470 This calculation avoids the whitespace at the top and bottom of the ROM UDG; in the code below you'll see it
. only copies six bytes/ lines.
@ $7470 label=PrintTarget
  $7470,$01 #REGa=*#REGbc'.
  $7471,$06 #REGl'=#N$81+(#REGa*#N$08).
  $7477,$02 #HTML(#REGh'=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html">#N$3D</a>.)
  $7479,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $747B,$01 Increment #REGl' by one.
  $747C,$01 Increment #REGd' by one.
  $747D,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $747F,$01 Increment #REGl' by one.
  $7480,$01 Increment #REGd' by one.
  $7481,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $7483,$01 Increment #REGl' by one.
  $7484,$01 Increment #REGd' by one.
  $7485,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $7487,$01 Increment #REGl' by one.
  $7488,$01 Increment #REGd' by one.
  $7489,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
  $748B,$01 Increment #REGl' by one.
  $748C,$01 Increment #REGd' by one.
  $748D,$02 Copy a number UDG byte line from the Spectum ROM (*#REGhl') to the screen buffer (*#REGde').
N $748F Reset the screen buffer position.
  $748F,$02 #REGd'=#N$51.
  $7491,$01 Move right one character block in the screen buffer, ready to print the next number.
  $7492,$01 Increment #REGc' by one.
  $7493,$04 Jump to #R$7470 if bit 3 of #REGc' is not zero.
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

c $76D7
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
  $76FF,$07 #REGhl=*#R$7844+#N$01F4.
  $7706,$03 Write #REGhl to *#R$7844.
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
  $772D,$07 #REGhl=*#R$7844+#N($0032,$04,$04).
  $7734,$03 Write #REGhl to *#R$7844.
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
  $77A8,$07 #REGhl=*#R$7844+#N$03E8.
  $77AF,$03 Write #REGhl to *#R$7844.
  $77B2,$03 Call #R$7420.
  $77B5,$03 Call #R$68AD.
  $77B8,$04 No operation.
  $77BC,$03 #REGhl=#R$7839.
  $77BF,$02 Write #N$05 to *#REGhl.
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

g $7825

g $7826

g $7828
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
B $783C,$02,$01

g $7840

g $7841

g $7843

g $7844 Score
@ $7844 label=Score
  $7846
  $7848

g $784B Target
@ $784B label=Target
  $784B,$05

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

b $7864 Graphics: Blank
@ $7864 label=Graphics_Blank
  $7864,$08 #UDGTABLE(default,centre) { #UDG$7864 } UDGTABLE#

b $786C Graphics: Arrow Top
@ $786C label=Graphics_ArrowTopLeft
  $786C,$08 #UDGTABLE(default,centre) { #UDG$786C(arrow-top-left) } UDGTABLE#
@ $7874 label=Graphics_ArrowTopRight
  $7874,$08 #UDGTABLE(default,centre) { #UDG$7874(arrow-top-right) } UDGTABLE#

b $787C Graphics: Arrow Middle
@ $787C label=Graphics_ArrowMiddleLeft
  $787C,$08 #UDGTABLE(default,centre) { #UDG$787C(arrow-middle-left) } UDGTABLE#
@ $7884 label=Graphics_ArrowMiddleRight
  $7884,$08 #UDGTABLE(default,centre) { #UDG$7884(arrow-middle-right) } UDGTABLE#

b $788C Graphics: Arrow Bottom
@ $788C label=Graphics_ArrowBottomLeft
  $788C,$08 #UDGTABLE(default,centre) { #UDG$788C(arrow-bottom-left) } UDGTABLE#
@ $7894 label=Graphics_ArrowBottomRight
  $7894,$08 #UDGTABLE(default,centre) { #UDG$7894(arrow-bottom-right) } UDGTABLE#

b $789C Graphics: Bike (Start Screen)
@ $789C label=Graphics_StartScreenBike
D $789C #UDGARRAY$02,attr=$1F,scale=$04,step=$01;(#PC)-(#PC+$08)-$08(bike)
  $789C,$10,$08

t $78AC Messaging: Ghostrider Is Finished
@ $78AC label=Messaging_GhostRiderFinished
  $78AC,$20 "#STR(#PC,$04,$20)".

b $78CC

b $78E0

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

g $B49C

w $B4DC Actions Jump Table
@ $B4DC label=JumpTable_Actions
D $B4DC Used by the routine at #R$6A27.
  $B4DC,$02 #D(#PEEK(#PC)+#PEEK(#PC+$01)*$0100).
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

t $C3E0 Messaging: MPH
@ $C3E0 label=Messaging_MPH
  $C3E0,$04 "#STR(#PC,$04,$04)".

b $C3E4 Graphics: Arrow Top
@ $C3E4 label=Graphics_ArrowTop
D $C3E4 #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$07,scale=$04,step=$01;$786C-$7874-$08(arrow-top) } UDGTABLE#
  $C3E4,$01 See #R$786C.
  $C3E5,$01 See #R$7874.

t $C3E6 Messaging: Fuel
@ $C3E6 label=Messaging_Fuel
  $C3E6,$04 "#STR(#PC,$04,$04)".

b $C3EA Graphics: Arrow Middle
@ $C3EA label=Graphics_ArrowMiddle
D $C3EA #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$07,scale=$04,step=$01;$787C-$7884-$08(arrow-middle) } UDGTABLE#
  $C3EA,$01 See #R$787C.
  $C3EB,$01 See #R$7884.

t $C3EC Messaging: RPM
@ $C3EC label=Messaging_RPM
  $C3EC,$04 "#STR(#PC,$04,$04)".

b $C3F0 Graphics: Arrow Bottom
@ $C3F0 label=Graphics_ArrowBottom
D $C3F0 #UDGTABLE(default,centre) { #UDGARRAY$02,attr=$07,scale=$04,step=$01;$788C-$7894-$08(arrow-bottom) } UDGTABLE#
  $C3F0,$01 See #R$788C.
  $C3F1,$01 See #R$7894.

t $C3F2 Messaging: Score
@ $C3F2 label=Messaging_Score
  $C3F2,$06 "#STR(#PC,$04,$06)".

t $C3F8 Messaging: Target
@ $C3F8 label=Messaging_Target
  $C3F8,$07 "#STR(#PC,$04,$07)".

b $C400

b $C500 Data: Graphics
@ $C500 label=Graphics_Data
N $C500 Graphic #N$00.
  $C50A,$01 Terminator.
N $C50B Graphic #N$01.
  $C515,$01 Terminator.
N $C516 Graphic #N$02.
  $C521,$01 Terminator.
N $C522 Graphic #N$03.
  $C52C,$01 Terminator.
N $C52D Graphic #N$04.
  $C540,$01 Terminator.
N $C541 Graphic #N$05.
  $C542,$01 Terminator.
N $C543 Graphic #N$06.
  $C54B,$01 Terminator.
N $C54C Graphic #N$07.
  $C55F,$01 Terminator.
N $C560 Graphic #N$08.
  $C561,$01 Terminator.
N $C562 Graphic #N$09.
  $C572,$01 Terminator.
N $C573 Graphic #N$0A.
  $C57F,$01 Terminator.
N $C580 Graphic #N$0B.
  $C581,$01 Terminator.
N $C582 Graphic #N$0C.
  $C592,$01 Terminator.
N $C593 Graphic #N$0D.
  $C5A6,$01 Terminator.
N $C5A7 Graphic #N$0E.
  $C5A8,$01 Terminator.
N $C5A9 Graphic #N$0F.
  $C5C1,$01 Terminator.
N $C5C2 Graphic #N$10.
  $C5DC,$01 Terminator.
N $C5DD Graphic #N$11.
  $C5E8,$01 Terminator.
N $C5E9 Graphic #N$12.
  $C603,$01 Terminator.
N $C604 Graphic #N$13.
  $C61E,$01 Terminator.
N $C61F Graphic #N$14.
  $C62A,$01 Terminator.
N $C62B Graphic #N$15.
  $C645,$01 Terminator.
N $C646 Graphic #N$16.
  $C660,$01 Terminator.
N $C661 Graphic #N$17.
  $C663,$01 Terminator.
N $C664 Graphic #N$18.
  $C674,$01 Terminator.
N $C675 Graphic #N$19.
  $C687,$01 Terminator.
N $C688 Graphic #N$1A.
  $C689,$01 Terminator.
N $C68A Graphic #N$1B.
  $C6A2,$01 Terminator.
N $C6A3 Graphic #N$1C.
  $C6A5,$01 Terminator.
N $C6A6 Graphic #N$1D.
  $C6B6,$01 Terminator.
N $C6B7 Graphic #N$1E.
  $C6C9,$01 Terminator.
N $C6CA Graphic #N$1F.
  $C6E4,$01 Terminator.
N $C6E5 Graphic #N$20.
  $C6EF,$01 Terminator.
N $C6F0 Graphic #N$21.
  $C6F2,$01 Terminator.
N $C6F3 Graphic #N$22.
  $C703,$01 Terminator.
N $C704 Graphic #N$23.
  $C705,$01 Terminator.
N $C706 Graphic #N$24.
  $C716,$01 Terminator.
N $C717 Graphic #N$25.
  $C718,$01 Terminator.
N $C719 Graphic #N$26.
  $C731,$01 Terminator.
N $C732 Graphic #N$27.
  $C733,$01 Terminator.
N $C734 Graphic #N$28.
  $C73C,$01 Terminator.
N $C73D Graphic #N$29.
  $C73F,$01 Terminator.
N $C740 Graphic #N$2A.
  $C750,$01 Terminator.
N $C751 Graphic #N$2B.
  $C752,$01 Terminator.
N $C753 Graphic #N$2C.
  $C763,$01 Terminator.
N $C764 Graphic #N$2D.
  $C765,$01 Terminator.
N $C766 Graphic #N$2E.
  $C776,$01 Terminator.
N $C777 Graphic #N$2F.
  $C781,$01 Terminator.
N $C782 Graphic #N$30.
  $C784,$01 Terminator.
N $C785 Graphic #N$31.
  $C795,$01 Terminator.
N $C796 Graphic #N$32.
  $C7B0,$01 Terminator.
N $C7B1 Graphic #N$33.
  $C7B2,$01 Terminator.
N $C7B3 Graphic #N$34.
  $C7C3,$01 Terminator.
N $C7C4 Graphic #N$35.
  $C7C5,$01 Terminator.
N $C7C6 Graphic #N$36.
  $C7D6,$01 Terminator.
N $C7D7 Graphic #N$37.
  $C7D9,$01 Terminator.
N $C7DA Graphic #N$38.
  $C7EA,$01 Terminator.
N $C7EB Graphic #N$39.
  $C805,$01 Terminator.
N $C806 Graphic #N$3A.
  $C807,$01 Terminator.
N $C808 Graphic #N$3B.
  $C818,$01 Terminator.
N $C819 Graphic #N$3C.
  $C81A,$01 Terminator.
N $C81B Graphic #N$3D.
  $C823,$01 Terminator.
N $C824 Graphic #N$3E.
  $C826,$01 Terminator.
N $C827 Graphic #N$3F.
  $C837,$01 Terminator.
N $C838 Graphic #N$40.
  $C852,$01 Terminator.
N $C853 Graphic #N$41.
  $C865,$01 Terminator.
N $C866 Graphic #N$42.
  $C881,$01 Terminator.
N $C882 Graphic #N$43.
  $C89C,$01 Terminator.
N $C89D Graphic #N$44.
  $C8AF,$01 Terminator.
N $C8B0 Graphic #N$45.
  $C8CB,$01 Terminator.
N $C8CC Graphic #N$46.
  $C8E6,$01 Terminator.
N $C8E7 Graphic #N$47.
  $C8F9,$01 Terminator.
N $C8FA Graphic #N$48.
  $C915,$01 Terminator.
N $C916 Graphic #N$49.
  $C930,$01 Terminator.
N $C931 Graphic #N$4A.
  $C93B,$01 Terminator.
N $C93C Graphic #N$4B.
  $C93D,$01 Terminator.
N $C93E Graphic #N$4C.
  $C94F,$01 Terminator.
N $C950 Graphic #N$4D.
  $C951,$01 Terminator.
N $C952 Graphic #N$4E.
  $C96A,$01 Terminator.
N $C96B Graphic #N$4F.
  $C985,$01 Terminator.
N $C986 Graphic #N$50.
  $C991,$01 Terminator.
N $C992 Graphic #N$51.
  $C99C,$01 Terminator.
N $C99D Graphic #N$52.
  $C9A8,$01 Terminator.
N $C9A9 Graphic #N$53.
  $C9B3,$01 Terminator.
N $C9B4 Graphic #N$54.
  $C9C7,$01 Terminator.
N $C9C8 Graphic #N$55.
  $C9C9,$01 Terminator.
N $C9CA Graphic #N$56.
  $C9D2,$01 Terminator.
N $C9D3 Graphic #N$57.
  $C9E6,$01 Terminator.
N $C9E7 Graphic #N$58.
  $C9E8,$01 Terminator.
N $C9E9 Graphic #N$59.
  $C9F9,$01 Terminator.
N $C9FA Graphic #N$5A.
  $CA06,$01 Terminator.
N $CA07 Graphic #N$5B.
  $CA08,$01 Terminator.
N $CA09 Graphic #N$5C.
  $CA19,$01 Terminator.
N $CA1A Graphic #N$5D.
  $CA2D,$01 Terminator.
N $CA2E Graphic #N$5E.
  $CA2F,$01 Terminator.
N $CA30 Graphic #N$5F.
  $CA48,$01 Terminator.
N $CA49 Graphic #N$60.
  $CA63,$01 Terminator.
N $CA64 Graphic #N$61.
  $CA6F,$01 Terminator.
N $CA70 Graphic #N$62.
  $CA8A,$01 Terminator.
N $CA8B Graphic #N$63.
  $CAA5,$01 Terminator.
N $CAA6 Graphic #N$64.
  $CAB1,$01 Terminator.
N $CAB2 Graphic #N$65.
  $CACC,$01 Terminator.
N $CACD Graphic #N$66.
  $CAE7,$01 Terminator.
N $CAE8 Graphic #N$67.
  $CAEA,$01 Terminator.
N $CAEB Graphic #N$68.
  $CAFB,$01 Terminator.
N $CAFC Graphic #N$69.
  $CB0E,$01 Terminator.
N $CB0F Graphic #N$6A.
  $CB10,$01 Terminator.
N $CB11 Graphic #N$6B.
  $CB29,$01 Terminator.
N $CB2A Graphic #N$6C.
  $CB2C,$01 Terminator.
N $CB2D Graphic #N$6D.
  $CB3D,$01 Terminator.
N $CB3E Graphic #N$6E.
  $CB50,$01 Terminator.
N $CB51 Graphic #N$6F.
  $CB6B,$01 Terminator.
N $CB6C Graphic #N$70.
  $CB76,$01 Terminator.
N $CB77 Graphic #N$71.
  $CB79,$01 Terminator.
N $CB7A Graphic #N$72.
  $CB8A,$01 Terminator.
N $CB8B Graphic #N$73.
  $CB8C,$01 Terminator.
N $CB8D Graphic #N$74.
  $CB9D,$01 Terminator.
N $CB9E Graphic #N$75.
  $CB9F,$01 Terminator.
N $CBA0 Graphic #N$76.
  $CBB8,$01 Terminator.
N $CBB9 Graphic #N$77.
  $CBBA,$01 Terminator.
N $CBBB Graphic #N$78.
  $CBC3,$01 Terminator.
N $CBC4 Graphic #N$79.
  $CBC6,$01 Terminator.
N $CBC7 Graphic #N$7A.
  $CBD7,$01 Terminator.
N $CBD8 Graphic #N$7B.
  $CBD9,$01 Terminator.
N $CBDA Graphic #N$7C.
  $CBEA,$01 Terminator.
N $CBEB Graphic #N$7D.
  $CBEC,$01 Terminator.
N $CBED Graphic #N$7E.
  $CBFD,$01 Terminator.
N $CBFE Graphic #N$7F.
  $CC08,$01 Terminator.
N $CC09 Graphic #N$80.
  $CC0B,$01 Terminator.
N $CC0C Graphic #N$81.
  $CC1C,$01 Terminator.
N $CC1D Graphic #N$82.
  $CC37,$01 Terminator.
N $CC38 Graphic #N$83.
  $CC39,$01 Terminator.
N $CC3A Graphic #N$84.
  $CC4A,$01 Terminator.
N $CC4B Graphic #N$85.
  $CC4C,$01 Terminator.
N $CC4D Graphic #N$86.
  $CC5D,$01 Terminator.
N $CC5E Graphic #N$87.
  $CC60,$01 Terminator.
N $CC61 Graphic #N$88.
  $CC71,$01 Terminator.
N $CC72 Graphic #N$89.
  $CC8C,$01 Terminator.
N $CC8D Graphic #N$8A.
  $CC8E,$01 Terminator.
N $CC8F Graphic #N$8B.
  $CC9F,$01 Terminator.
N $CCA0 Graphic #N$8C.
  $CCA1,$01 Terminator.
N $CCA2 Graphic #N$8D.
  $CCAA,$01 Terminator.
N $CCAB Graphic #N$8E.
  $CCAD,$01 Terminator.
N $CCAE Graphic #N$8F.
  $CCBE,$01 Terminator.
N $CCBF Graphic #N$90.
  $CCD9,$01 Terminator.
N $CCDA Graphic #N$92.
  $CCEC,$01 Terminator.
N $CCED Graphic #N$93.
  $CD08,$01 Terminator.
N $CD09 Graphic #N$94.
  $CD23,$01 Terminator.
N $CD24 Graphic #N$95.
  $CD36,$01 Terminator.
N $CD37 Graphic #N$96.
  $CD52,$01 Terminator.
N $CD53 Graphic #N$97.
  $CD6D,$01 Terminator.
N $CD6E Graphic #N$98.
  $CD80,$01 Terminator.
N $CD81 Graphic #N$99.
  $CD9C,$01 Terminator.
N $CD9D Graphic #N$9A.
  $CDB7,$01 Terminator.
N $CDB8 Graphic #N$9B.
  $CDC2,$01 Terminator.
N $CDC3 Graphic #N$9C.
  $CDD6,$01 Terminator.
N $CDD7 Graphic #N$9D.
  $CDD8,$01 Terminator.
N $CDD9 Graphic #N$9E.
  $CDF1,$01 Terminator.
N $CDF2 Graphic #N$9F.
  $CE0C,$01 Terminator.
N $CE0D Graphic #N$A0.
  $CE28,$01 Terminator.
N $CE29 Graphic #N$A1.
  $CE43,$01 Terminator.
N $CE44 Graphic #N$A2.
  $CE45,$01 Terminator.
N $CE46 Graphic #N$A3.
  $CE56,$01 Terminator.
N $CE57 Graphic #N$A4.
  $CE72,$01 Terminator.
N $CE73 Graphic #N$A5.
  $CE8D,$01 Terminator.
N $CE8E Graphic #N$A6.
  $CE8F,$01 Terminator.
N $CE90 Graphic #N$A7.
  $CEA0,$01 Terminator.
N $CEA1 Graphic #N$A8.
  $CEA3,$01 Terminator.
N $CEA4 Graphic #N$A9.
  $CEB4,$01 Terminator.
N $CEB5 Graphic #N$AA.
  $CECF,$01 Terminator.
N $CED0 Graphic #N$AB.
  $CEEA,$01 Terminator.
N $CEEB Graphic #N$AC.
  $CEF5,$01 Terminator.
N $CEF6 Graphic #N$AD.
  $CEF8,$01 Terminator.
N $CEF9 Graphic #N$AE.
  $CF09,$01 Terminator.
N $CF0A Graphic #N$AF.
  $CF0B,$01 Terminator.
N $CF0C Graphic #N$B0.
  $CF1C,$01 Terminator.
N $CF1D Graphic #N$B1.
  $CF1E,$01 Terminator.
N $CF1F Graphic #N$B2.
  $CF2F,$01 Terminator.
N $CF30 Graphic #N$B3.
  $CF3A,$01 Terminator.
N $CF3B Graphic #N$B4.
  $CF4E,$01 Terminator.
N $CF4F Graphic #N$B5.
  $CF69,$01 Terminator.
N $CF6A Graphic #N$B6.
  $CF84,$01 Terminator.
N $CF85 Graphic #N$B7.
  $CF98,$01 Terminator.
N $CF99 Graphic #N$B8.
  $CFB3,$01 Terminator.
N $CFB4 Graphic #N$B9.
  $CFCE,$01 Terminator.
N $CFCF Graphic #N$BA.
  $CFE2,$01 Terminator.
N $CFE3 Graphic #N$BB.
  $CFE4,$01 Terminator.
N $CFE5 Graphic #N$BC.
  $CFFD,$01 Terminator.
N $CFFE Graphic #N$BD.
  $D018,$01 Terminator.
N $D019 Graphic #N$BE.
  $D034,$01 Terminator.
N $D035 Graphic #N$BF.
  $D04F,$01 Terminator.
N $D050 Graphic #N$C0.
  $D062,$01 Terminator.
N $D063 Graphic #N$C1.
  $D064,$01 Terminator.
N $D065 Graphic #N$C2.
  $D075,$01 Terminator.
N $D076 Graphic #N$C3.
  $D081,$01 Terminator.
N $D082 Graphic #N$C4.
  $D083,$01 Terminator.
N $D084 Graphic #N$C5.
  $D094,$01 Terminator.
N $D095 Graphic #N$C6.
  $D096,$01 Terminator.
N $D097 Graphic #N$C7.
  $D0A7,$01 Terminator.
N $D0A8 Graphic #N$C8.
  $D0A9,$01 Terminator.
N $D0AA Graphic #N$C9.
  $D0BA,$01 Terminator.
N $D0BB Graphic #N$CA.
  $D0BC,$01 Terminator.
N $D0BD Graphic #N$CB.
  $D0CD,$01 Terminator.
N $D0CE Graphic #N$CC.
  $D0E1,$01 Terminator.
N $D0E2 Graphic #N$CD.
  $D0E3,$01 Terminator.
N $D0E4 Graphic #N$CE.
  $D0FC,$01 Terminator.
N $D0FD Graphic #N$CF.
  $D0FE,$01 Terminator.
N $D0FF Graphic #N$D0.
  $D10F,$01 Terminator.
N $D110 Graphic #N$D1.
  $D123,$01 Terminator.
N $D124 Graphic #N$D2.
  $D125,$01 Terminator.
N $D126 Graphic #N$D3.
  $D13E,$01 Terminator.
N $D13F Graphic #N$D4.
  $D159,$01 Terminator.
N $D15A Graphic #N$D5.
  $D16C,$01 Terminator.
N $D16D Graphic #N$D6.
  $D16F,$01 Terminator.
N $D170 Graphic #N$D7.
  $D178,$01 Terminator.
N $D179 Graphic #N$D8.
  $D18B,$01 Terminator.
N $D18C Graphic #N$D9.
  $D18D,$01 Terminator.
N $D18E Graphic #N$DA.
  $D19E,$01 Terminator.
N $D19F Graphic #N$DB.
  $D1A0,$01 Terminator.
N $D1A1 Graphic #N$DC.
  $D1B1,$01 Terminator.
N $D1B2 Graphic #N$DD.
  $D1BC,$01 Terminator.
N $D1BD Graphic #N$DE.
  $D1C7,$01 Terminator.
N $D1C8 Graphic #N$DF.
  $D1DA,$01 Terminator.
N $D1DB Graphic #N$E0.
  $D1E6,$01 Terminator.
N $D1E7 Graphic #N$E1.
  $D1F1,$01 Terminator.
N $D1F2 Graphic #N$E2.
  $D1F3,$01 Terminator.
N $D1F4 Graphic #N$E3.
  $D204,$01 Terminator.
N $D205 Graphic #N$E4.
  $D20F,$01 Terminator.
N $D210 Graphic #N$E5.
  $D21A,$01 Terminator.
N $D21B Graphic #N$E6.
  $D22D,$01 Terminator.
N $D22E Graphic #N$E7.
  $D22F,$01 Terminator.
N $D230 Graphic #N$E8.
  $D240,$01 Terminator.
N $D241 Graphic #N$E9.
  $D243,$01 Terminator.
N $D244 Graphic #N$EA.
  $D24C,$01 Terminator.
N $D24D Graphic #N$EB.
  $D25F,$01 Terminator.
N $D260 Graphic #N$EC.
  $D261,$01 Terminator.
N $D262 Graphic #N$ED.
  $D272,$01 Terminator.
N $D273 Graphic #N$EE.
  $D274,$01 Terminator.
N $D275 Graphic #N$EF.
  $D285,$01 Terminator.
N $D286 Graphic #N$F0.
  $D290,$01 Terminator.
N $D291 Graphic #N$F1.
  $D2AB,$01 Terminator.
N $D2AC Graphic #N$F2.
  $D2C6,$01 Terminator.
N $D2C7 Graphic #N$F3.
  $D2D2,$01 Terminator.
N $D2D3 Graphic #N$F4.
  $D2DD,$01 Terminator.
N $D2DE Graphic #N$F5.
  $D2DF,$01 Terminator.
N $D2E0 Graphic #N$F6.
  $D2F0,$01 Terminator.
N $D2F1 Graphic #N$F7.
  $D2FB,$01 Terminator.
N $D2FC Graphic #N$F8.
  $D306,$01 Terminator.
N $D307 Graphic #N$F9.
  $D321,$01 Terminator.
N $D322 Graphic #N$FA.
  $D32D,$01 Terminator.
N $D32E Graphic #N$FB.
  $D338,$01 Terminator.
N $D339 Graphic #N$FC.
  $D33A,$01 Terminator.
N $D33B Graphic #N$FD.
  $D34B,$01 Terminator.
N $D34C Graphic #N$FE.
  $D356,$01 Terminator.
N $D357 Graphic #N$FF.
  $D358,$01 Terminator.
N $D359 Graphic #N$100.
  $D369,$01 Terminator.
N $D36A Graphic #N$101.
  $D384,$01 Terminator.
N $D385 Graphic #N$102.
  $D390,$01 Terminator.
N $D391 Graphic #N$103.
  $D39B,$01 Terminator.
N $D39C Graphic #N$104.
  $D39D,$01 Terminator.
N $D39E Graphic #N$105.
  $D3AE,$01 Terminator.
N $D3AF Graphic #N$106.
  $D3B9,$01 Terminator.
N $D3BA Graphic #N$107.
  $D3C4,$01 Terminator.
N $D3C5 Graphic #N$108.
  $D3CF,$01 Terminator.
N $D3D0 Graphic #N$109.
  $D3DA,$01 Terminator.
N $D3DB Graphic #N$10A.
  $D3EE,$01 Terminator.
N $D3EF Graphic #N$10B.
  $D3F0,$01 Terminator.
N $D3F1 Graphic #N$10C.
  $D409,$01 Terminator.
N $D40A Graphic #N$10D.
  $D424,$01 Terminator.
N $D425 Graphic #N$10E.
  $D430,$01 Terminator.
N $D431 Graphic #N$10F.
  $D44B,$01 Terminator.
N $D44C Graphic #N$110.
  $D466,$01 Terminator.
N $D467 Graphic #N$111.
  $D468,$01 Terminator.
N $D469 Graphic #N$112.
  $D479,$01 Terminator.
N $D47A Graphic #N$113.
  $D47C,$01 Terminator.
N $D47D Graphic #N$114.
  $D48D,$01 Terminator.
N $D48E Graphic #N$115.
  $D4A8,$01 Terminator.
N $D4A9 Graphic #N$116.
  $D4C3,$01 Terminator.
N $D4C4 Graphic #N$117.
  $D4CF,$01 Terminator.
N $D4D0 Graphic #N$118.
  $D4DA,$01 Terminator.
N $D4DB Graphic #N$119.
  $D4DC,$01 Terminator.
N $D4DD Graphic #N$11A.
  $D4ED,$01 Terminator.
N $D4EE Graphic #N$11B.
  $D508,$01 Terminator.
N $D509 Graphic #N$11C.
  $D523,$01 Terminator.
N $D524 Graphic #N$11D.
  $D52F,$01 Terminator.
N $D530 Graphic #N$11E.
  $D53A,$01 Terminator.
N $D53B Graphic #N$11F.
  $D555,$01 Terminator.
N $D556 Graphic #N$120.
  $D570,$01 Terminator.
N $D571 Graphic #N$121.
  $D572,$01 Terminator.
N $D573 Graphic #N$122.
  $D583,$01 Terminator.
N $D584 Graphic #N$123.
  $D58F,$01 Terminator.
N $D590 Graphic #N$124.
  $D59A,$01 Terminator.
N $D59B Graphic #N$125.
  $D5B5,$01 Terminator.
N $D5B6 Graphic #N$126.
  $D5B7,$01 Terminator.
N $D5B8 Graphic #N$127.
  $D5C8,$01 Terminator.
N $D5C9 Graphic #N$128.
  $D5CB,$01 Terminator.
N $D5CC Graphic #N$129.
  $D5DC,$01 Terminator.
N $D5DD Graphic #N$12A.
  $D5F7,$01 Terminator.
N $D5F8 Graphic #N$12B.
  $D5F9,$01 Terminator.
N $D5FA Graphic #N$12C.
  $D60A,$01 Terminator.
N $D60B Graphic #N$12D.
  $D615,$01 Terminator.
N $D616 Graphic #N$12E.
  $D618,$01 Terminator.
N $D619 Graphic #N$12F.
  $D629,$01 Terminator.
N $D62A Graphic #N$130.
  $D62B,$01 Terminator.
N $D62C Graphic #N$131.
  $D63C,$01 Terminator.
N $D63D Graphic #N$132.
  $D63F,$01 Terminator.
N $D640 Graphic #N$133.
  $D650,$01 Terminator.
N $D651 Graphic #N$134.
  $D653,$01 Terminator.
N $D654 Graphic #N$135.
  $D664,$01 Terminator.
N $D665 Graphic #N$136.
  $D666,$01 Terminator.
N $D667 Graphic #N$137.
  $D677,$01 Terminator.
N $D678 Graphic #N$138.
  $D67A,$01 Terminator.
N $D67B Graphic #N$139.
  $D68B,$01 Terminator.
N $D68C Graphic #N$13A.
  $D68D,$01 Terminator.
N $D68E Graphic #N$13B.
  $D69E,$01 Terminator.
N $D69F Graphic #N$13C.
  $D6A1,$01 Terminator.
N $D6A2 Graphic #N$13D.
  $D6AA,$01 Terminator.
N $D6AB Graphic #N$13E.
  $D6BD,$01 Terminator.
N $D6BE Graphic #N$13F.
  $D6BF,$01 Terminator.
N $D6C0 Graphic #N$140.
  $D6D0,$01 Terminator.
N $D6D1 Graphic #N$141.
  $D6DC,$01 Terminator.
N $D6DD Graphic #N$142.
  $D6DE,$01 Terminator.
N $D6DF Graphic #N$143.
  $D6EF,$01 Terminator.
N $D6F0 Graphic #N$144.
  $D6F1,$01 Terminator.
N $D6F2 Graphic #N$145.
  $D702,$01 Terminator.
N $D703 Graphic #N$146.
  $D70E,$01 Terminator.
N $D70F Graphic #N$147.
  $D719,$01 Terminator.
N $D71A Graphic #N$148.
  $D71B,$01 Terminator.
N $D71C Graphic #N$149.
  $D72C,$01 Terminator.
N $D72D Graphic #N$14A.
  $D72E,$01 Terminator.
N $D72F Graphic #N$14B.
  $D73F,$01 Terminator.
N $D740 Graphic #N$14C.
  $D741,$01 Terminator.
N $D742 Graphic #N$14D.
  $D74B,$01 Terminator.
N $D74C Graphic #N$14E.
  $D74D,$01 Terminator.
N $D74E Graphic #N$14F.
  $D75E,$01 Terminator.
N $D75F Graphic #N$150.
  $D761,$01 Terminator.
N $D762 Graphic #N$151.
  $D772,$01 Terminator.
N $D773 Graphic #N$152.
  $D774,$01 Terminator.
N $D775 Graphic #N$153.
  $D785,$01 Terminator.
N $D786 Graphic #N$154.
  $D787,$01 Terminator.
N $D788 Graphic #N$155.
  $D791,$01 Terminator.
N $D792 Graphic #N$156.
  $D793,$01 Terminator.
N $D794 Graphic #N$157.
  $D7A4,$01 Terminator.
N $D7A5 Graphic #N$158.
  $D7A7,$01 Terminator.
N $D7A8 Graphic #N$159.
  $D7B8,$01 Terminator.
N $D7B9 Graphic #N$15A.
  $D7BA,$01 Terminator.
N $D7BB Graphic #N$15B.
  $D7CB,$01 Terminator.
N $D7CC Graphic #N$15C.
  $D7D7,$01 Terminator.
N $D7D8 Graphic #N$15D.
  $D7E2,$01 Terminator.
N $D7E3 Graphic #N$15E.
  $D7EE,$01 Terminator.
N $D7EF Graphic #N$15F.
  $D7F9,$01 Terminator.
N $D7FA Graphic #N$160.
  $D80D,$01 Terminator.
N $D80E Graphic #N$161.
  $D80F,$01 Terminator.
N $D810 Graphic #N$162.
  $D820,$01 Terminator.
N $D821 Graphic #N$163.
  $D834,$01 Terminator.
N $D835 Graphic #N$164.
  $D836,$01 Terminator.
N $D837 Graphic #N$165.
  $D847,$01 Terminator.
N $D848 Graphic #N$166.
  $D849,$01 Terminator.
N $D84A Graphic #N$167.
  $D853,$01 Terminator.
N $D854 Graphic #N$168.
  $D855,$01 Terminator.
N $D856 Graphic #N$169.
  $D865,$01 Terminator.
N $D866 Graphic #N$16A.
  $D868,$01 Terminator.
N $D869 Graphic #N$16B.
  $D879,$01 Terminator.
N $D87A Graphic #N$16C.
  $D87C,$01 Terminator.
N $D87D Graphic #N$16D.
  $D88D,$01 Terminator.
N $D88E Graphic #N$16E.
  $D88F,$01 Terminator.
N $D890 Graphic #N$16F.
  $D89F,$01 Terminator.
N $D8A0 Graphic #N$170.
  $D8A2,$01 Terminator.
N $D8A3 Graphic #N$171.
  $D8B3,$01 Terminator.
N $D8B4 Graphic #N$172.
  $D8B5,$01 Terminator.
N $D8B6 Graphic #N$173.
  $D8C7,$01 Terminator.
N $D8C8 Graphic #N$174.
  $D8C9,$01 Terminator.
N $D8CA Graphic #N$175.
  $D8D5,$01 Terminator.
N $D8D6 Graphic #N$176.
  $D8DA,$01 Terminator.
N $D8DB Graphic #N$177.
  $D8DC,$01 Terminator.
N $D8DD Graphic #N$178.
  $D8ED,$01 Terminator.
N $D8EE Graphic #N$179.
  $D8F0,$01 Terminator.
N $D8F1 Graphic #N$17A.
  $D901,$01 Terminator.
N $D902 Graphic #N$17B.
  $D903,$01 Terminator.
N $D904 Graphic #N$17C.
  $D90F,$01 Terminator.
N $D910 Graphic #N$17D.
  $D914,$01 Terminator.
N $D915 Graphic #N$17E.
  $D916,$01 Terminator.
N $D917 Graphic #N$17F.
  $D927,$01 Terminator.
N $D928 Graphic #N$180.
  $D92A,$01 Terminator.
N $D92B Graphic #N$181.
  $D93B,$01 Terminator.
N $D93C Graphic #N$182.
  $D93D,$01 Terminator.
N $D93E Graphic #N$183.
  $D94E,$01 Terminator.
N $D94F Graphic #N$184.
  $D951,$01 Terminator.
N $D952 Graphic #N$185.
  $D962,$01 Terminator.
N $D963 Graphic #N$186.
  $D964,$01 Terminator.
N $D965 Graphic #N$187.
  $D968,$01 Terminator.
N $D969 Graphic #N$188.
  $D971,$01 Terminator.
N $D972 Graphic #N$189.
  $D975,$01 Terminator.
N $D976 Graphic #N$18A.
  $D978,$01 Terminator.
N $D979 Graphic #N$18B.
  $D989,$01 Terminator.
N $D98A Graphic #N$18C.
  $D9A4,$01 Terminator.
N $D9A5 Graphic #N$18D.
  $D9A6,$01 Terminator.
N $D9A7 Graphic #N$18E.
  $D9B7,$01 Terminator.
N $D9B8 Graphic #N$18F.
  $D9B9,$01 Terminator.
N $D9BA Graphic #N$190.
  $D9CA,$01 Terminator.
N $D9CB Graphic #N$191.
  $D9E1,$01 Terminator.
N $D9E2 Graphic #N$192.
  $D9E6,$01 Terminator.
N $D9E7 Graphic #N$193.
  $D9E8,$01 Terminator.
N $D9E9 Graphic #N$194.
  $D9F9,$01 Terminator.
N $D9FA Graphic #N$195.
  $D9FB,$01 Terminator.
N $D9FC Graphic #N$196.
  $DA0C,$01 Terminator.
N $DA0D Graphic #N$197.
  $DA0E,$01 Terminator.
N $DA0F Graphic #N$198.
  $DA1F,$01 Terminator.
N $DA20 Graphic #N$199.
  $DA21,$01 Terminator.
N $DA22 Graphic #N$19A.
  $DA3B,$01 Terminator.
N $DA3C Graphic #N$19B.
  $DA56,$01 Terminator.
N $DA57 Graphic #N$19C.
  $DA58,$01 Terminator.
N $DA59 Graphic #N$19D.
  $DA69,$01 Terminator.
N $DA6A Graphic #N$19E.
  $DA6B,$01 Terminator.
N $DA6C Graphic #N$19F.
  $DA85,$01 Terminator.
N $DA86 Graphic #N$1A0.
  $DAA0,$01 Terminator.
N $DAA1 Graphic #N$1A1.
  $DAA2,$01 Terminator.
N $DAA3 Graphic #N$1A2.
  $DAB3,$01 Terminator.
N $DAB4 Graphic #N$1A3.
  $DAB5,$01 Terminator.
N $DAB6 Graphic #N$1A4.
  $DAC7,$01 Terminator.
N $DAC8 Graphic #N$1A5.
  $DAE2,$01 Terminator.
N $DAE3 Graphic #N$1A6.
  $DAFD,$01 Terminator.
N $DAFE Graphic #N$1A7.
  $DB08,$01 Terminator.
N $DB09 Graphic #N$1A8.
  $DB0A,$01 Terminator.
N $DB0B Graphic #N$1A9.
  $DB1C,$01 Terminator.
N $DB1D Graphic #N$1AA.
  $DB1E,$01 Terminator.
N $DB1F Graphic #N$1AB.
  $DB2F,$01 Terminator.
N $DB30 Graphic #N$1AC.
  $DB31,$01 Terminator.
N $DB32 Graphic #N$1AD.
  $DB42,$01 Terminator.
N $DB43 Graphic #N$1AE.
  $DB4D,$01 Terminator.
N $DB4E Graphic #N$1AF.
  $DB4F,$01 Terminator.
N $DB50 Graphic #N$1B0.
  $DB61,$01 Terminator.
N $DB62 Graphic #N$1B1.
  $DB7C,$01 Terminator.
N $DB7D Graphic #N$1B2.
  $DB97,$01 Terminator.
N $DB98 Graphic #N$1B3.
  $DB99,$01 Terminator.
N $DB9A Graphic #N$1B4.
  $DBAB,$01 Terminator.
N $DBAC Graphic #N$1B5.
  $DBC6,$01 Terminator.
N $DBC7 Graphic #N$1B6.
  $DBE1,$01 Terminator.
N $DBE2 Graphic #N$1B7.
  $DBE3,$01 Terminator.
N $DBE4 Graphic #N$1B8.
  $DBF5,$01 Terminator.
N $DBF6 Graphic #N$1B9.
  $DBF7,$01 Terminator.
N $DBF8 Graphic #N$1BA.
  $DC10,$01 Terminator.
N $DC11 Graphic #N$1BB.
  $DC2B,$01 Terminator.
N $DC2C Graphic #N$1BC.
  $DC2D,$01 Terminator.
N $DC2E Graphic #N$1BD.
  $DC47,$01 Terminator.
N $DC48 Graphic #N$1BE.
  $DC62,$01 Terminator.
N $DC63 Graphic #N$1BF.
  $DC75,$01 Terminator.
N $DC76 Graphic #N$1C0.
  $DC77,$01 Terminator.
N $DC78 Graphic #N$1C1.
  $DC88,$01 Terminator.
N $DC89 Graphic #N$1C2.
  $DC8A,$01 Terminator.
N $DC8B Graphic #N$1C3.
  $DC94,$01 Terminator.
N $DC95 Graphic #N$1C4.
  $DC96,$01 Terminator.
N $DC97 Graphic #N$1C5.
  $DCA7,$01 Terminator.
N $DCA8 Graphic #N$1C6.
  $DCA9,$01 Terminator.
N $DCAA Graphic #N$1C7.
  $DCBA,$01 Terminator.
N $DCBB Graphic #N$1C8.
  $DCBC,$01 Terminator.
N $DCBD Graphic #N$1C9.
  $DCCD,$01 Terminator.
N $DCCE Graphic #N$1CA.
  $DCCF,$01 Terminator.
N $DCD0 Graphic #N$1CB.
  $DCE0,$01 Terminator.
N $DCE1 Graphic #N$1CC.
  $DCE2,$01 Terminator.
N $DCE3 Graphic #N$1CD.
  $DCF4,$01 Terminator.
N $DCF5 Graphic #N$1CE.
  $DCF6,$01 Terminator.
N $DCF7 Graphic #N$1CF.
  $DD0F,$01 Terminator.
N $DD10 Graphic #N$1D0.
  $DD11,$01 Terminator.
N $DD12 Graphic #N$1D1.
  $DD22,$01 Terminator.
N $DD23 Graphic #N$1D2.
  $DD24,$01 Terminator.
N $DD25 Graphic #N$1D3.
  $DD36,$01 Terminator.
N $DD37 Graphic #N$1D4.
  $DD38,$01 Terminator.
N $DD39 Graphic #N$1D5.
  $DD51,$01 Terminator.
N $DD52 Graphic #N$1D6.
  $DD6C,$01 Terminator.
N $DD6D Graphic #N$1D7.
  $DD7F,$01 Terminator.
N $DD80 Graphic #N$1D8.
  $DD82,$01 Terminator.
N $DD83 Graphic #N$1D9.
  $DD8B,$01 Terminator.
N $DD8C Graphic #N$1DA.
  $DD9E,$01 Terminator.
N $DD9F Graphic #N$1DB.
  $DDA0,$01 Terminator.
N $DDA1 Graphic #N$1DC.
  $DDB1,$01 Terminator.
N $DDB2 Graphic #N$1DD.
  $DDB3,$01 Terminator.
N $DDB4 Graphic #N$1DE.
  $DDC4,$01 Terminator.
N $DDC5 Graphic #N$1DF.
  $DDCF,$01 Terminator.
N $DDD0 Graphic #N$1E0.
  $DDDA,$01 Terminator.
N $DDDB Graphic #N$1E1.
  $DDED,$01 Terminator.
N $DDEE Graphic #N$1E2.
  $DDF9,$01 Terminator.
N $DDFA Graphic #N$1E3.
  $DE04,$01 Terminator.
N $DE05 Graphic #N$1E4.
  $DE06,$01 Terminator.
N $DE07 Graphic #N$1E5.
  $DE17,$01 Terminator.
N $DE18 Graphic #N$1E6.
  $DE22,$01 Terminator.
N $DE23 Graphic #N$1E7.
  $DE2D,$01 Terminator.
N $DE2E Graphic #N$1E8.
  $DE40,$01 Terminator.
N $DE41 Graphic #N$1E9.
  $DE42,$01 Terminator.
N $DE43 Graphic #N$1EA.
  $DE53,$01 Terminator.
N $DE54 Graphic #N$1EB.
  $DE56,$01 Terminator.
N $DE57 Graphic #N$1EC.
  $DE5F,$01 Terminator.
N $DE60 Graphic #N$1ED.
  $DE72,$01 Terminator.
N $DE73 Graphic #N$1EE.
  $DE74,$01 Terminator.
N $DE75 Graphic #N$1EF.
  $DE85,$01 Terminator.
N $DE86 Graphic #N$1F0.
  $DE87,$01 Terminator.
N $DE88 Graphic #N$1F1.
  $DE98,$01 Terminator.
N $DE99 Graphic #N$1F2.
  $DEA3,$01 Terminator.
N $DEA4 Graphic #N$1F3.
  $DEBE,$01 Terminator.
N $DEBF Graphic #N$1F4.
  $DED9,$01 Terminator.
N $DEDA Graphic #N$1F5.
  $DEE5,$01 Terminator.
N $DEE6 Graphic #N$1F6.
  $DEF0,$01 Terminator.
N $DEF1 Graphic #N$1F7.
  $DEF2,$01 Terminator.
N $DEF3 Graphic #N$1F8.
  $DF03,$01 Terminator.
N $DF04 Graphic #N$1F9.
  $DF0E,$01 Terminator.
N $DF0F Graphic #N$1FA.
  $DF19,$01 Terminator.
N $DF1A Graphic #N$1FB.
  $DF34,$01 Terminator.
N $DF35 Graphic #N$1FC.
  $DF40,$01 Terminator.
N $DF41 Graphic #N$1FD.
  $DF4B,$01 Terminator.
N $DF4C Graphic #N$1FE.
  $DF4D,$01 Terminator.
N $DF4E Graphic #N$1FF.
  $DF5E,$01 Terminator.
N $DF5F Graphic #N$200.
  $DF69,$01 Terminator.
N $DF6A Graphic #N$201.
  $DF6B,$01 Terminator.
N $DF6C Graphic #N$202.
  $DF7C,$01 Terminator.
N $DF7D Graphic #N$203.
  $DF97,$01 Terminator.
N $DF98 Graphic #N$204.
  $DFA3,$01 Terminator.
N $DFA4 Graphic #N$205.
  $DFAE,$01 Terminator.
N $DFAF Graphic #N$206.
  $DFB0,$01 Terminator.
N $DFB1 Graphic #N$207.
  $DFC1,$01 Terminator.
N $DFC2 Graphic #N$208.
  $DFCC,$01 Terminator.
N $DFCD Graphic #N$209.
  $DFD7,$01 Terminator.
N $DFD8 Graphic #N$20A.
  $DFE2,$01 Terminator.
N $DFE3 Graphic #N$20B.
  $DFED,$01 Terminator.
N $DFEE Graphic #N$20C.
  $E001,$01 Terminator.
N $E002 Graphic #N$20D.
  $E003,$01 Terminator.
N $E004 Graphic #N$20E.
  $E01C,$01 Terminator.
N $E01D Graphic #N$20F.
  $E037,$01 Terminator.
N $E038 Graphic #N$210.
  $E043,$01 Terminator.
N $E044 Graphic #N$211.
  $E05E,$01 Terminator.
N $E05F Graphic #N$212.
  $E079,$01 Terminator.
N $E07A Graphic #N$213.
  $E07B,$01 Terminator.
N $E07C Graphic #N$214.
  $E08C,$01 Terminator.
N $E08D Graphic #N$215.
  $E08F,$01 Terminator.
N $E090 Graphic #N$216.
  $E0A0,$01 Terminator.
N $E0A1 Graphic #N$217.
  $E0BB,$01 Terminator.
N $E0BC Graphic #N$218.
  $E0D6,$01 Terminator.
N $E0D7 Graphic #N$219.
  $E0E2,$01 Terminator.
N $E0E3 Graphic #N$21A.
  $E0ED,$01 Terminator.
N $E0EE Graphic #N$21B.
  $E0EF,$01 Terminator.
N $E0F0 Graphic #N$21C.
  $E100,$01 Terminator.
N $E101 Graphic #N$21D.
  $E11B,$01 Terminator.
N $E11C Graphic #N$21E.
  $E136,$01 Terminator.
N $E137 Graphic #N$21F.
  $E142,$01 Terminator.
N $E143 Graphic #N$220.
  $E14D,$01 Terminator.
N $E14E Graphic #N$221.
  $E168,$01 Terminator.
N $E169 Graphic #N$222.
  $E183,$01 Terminator.
N $E184 Graphic #N$223.
  $E185,$01 Terminator.
N $E186 Graphic #N$224.
  $E196,$01 Terminator.
N $E197 Graphic #N$225.
  $E1A2,$01 Terminator.
N $E1A3 Graphic #N$226.
  $E1AD,$01 Terminator.
N $E1AE Graphic #N$227.
  $E1C8,$01 Terminator.
N $E1C9 Graphic #N$228.
  $E1CA,$01 Terminator.
N $E1CB Graphic #N$229.
  $E1DB,$01 Terminator.
N $E1DC Graphic #N$22A.
  $E1DE,$01 Terminator.
N $E1DF Graphic #N$22B.
  $E1EF,$01 Terminator.
N $E1F0 Graphic #N$22C.
  $E20A,$01 Terminator.
N $E20B Graphic #N$22D.
  $E20C,$01 Terminator.
N $E20D Graphic #N$22E.
  $E21D,$01 Terminator.
N $E21E Graphic #N$22F.
  $E228,$01 Terminator.
N $E229 Graphic #N$230.
  $E22A,$01 Terminator.
N $E22B Graphic #N$231.
  $E23C,$01 Terminator.
N $E23D Graphic #N$232.
  $E23E,$01 Terminator.
N $E23F Graphic #N$233.
  $E24F,$01 Terminator.
N $E250 Graphic #N$234.
  $E252,$01 Terminator.
N $E253 Graphic #N$235.
  $E263,$01 Terminator.
N $E264 Graphic #N$236.
  $E265,$01 Terminator.
N $E266 Graphic #N$237.
  $E277,$01 Terminator.
N $E278 Graphic #N$238.
  $E279,$01 Terminator.
N $E27A Graphic #N$239.
  $E28A,$01 Terminator.
N $E28B Graphic #N$23A.
  $E28C,$01 Terminator.
N $E28D Graphic #N$23B.
  $E29E,$01 Terminator.
N $E29F Graphic #N$23C.
  $E2A0,$01 Terminator.
N $E2A1 Graphic #N$23D.
  $E2B1,$01 Terminator.
N $E2B2 Graphic #N$23E.
  $E2B4,$01 Terminator.
N $E2B5 Graphic #N$23F.
  $E2BD,$01 Terminator.
N $E2BE Graphic #N$240.
  $E2D0,$01 Terminator.
N $E2D1 Graphic #N$241.
  $E2D2,$01 Terminator.
N $E2D3 Graphic #N$242.
  $E2E3,$01 Terminator.
N $E2E4 Graphic #N$243.
  $E2EF,$01 Terminator.
N $E2F0 Graphic #N$244.
  $E2F1,$01 Terminator.
N $E2F2 Graphic #N$245.
  $E302,$01 Terminator.
N $E303 Graphic #N$246.
  $E304,$01 Terminator.
N $E305 Graphic #N$247.
  $E315,$01 Terminator.
N $E316 Graphic #N$248.
  $E321,$01 Terminator.
N $E322 Graphic #N$249.
  $E32C,$01 Terminator.
N $E32D Graphic #N$24A.
  $E32E,$01 Terminator.
N $E32F Graphic #N$24B.
  $E33F,$01 Terminator.
N $E340 Graphic #N$24C.
  $E341,$01 Terminator.
N $E342 Graphic #N$24D.
  $E352,$01 Terminator.
N $E353 Graphic #N$24E.
  $E35E,$01 Terminator.
N $E35F Graphic #N$24F.
  $E360,$01 Terminator.
N $E361 Graphic #N$250.
  $E371,$01 Terminator.
N $E372 Graphic #N$251.
  $E374,$01 Terminator.
N $E375 Graphic #N$252.
  $E385,$01 Terminator.
N $E386 Graphic #N$253.
  $E387,$01 Terminator.
N $E388 Graphic #N$254.
  $E398,$01 Terminator.
N $E399 Graphic #N$255.
  $E3A4,$01 Terminator.
N $E3A5 Graphic #N$256.
  $E3A6,$01 Terminator.
N $E3A7 Graphic #N$257.
  $E3B7,$01 Terminator.
N $E3B8 Graphic #N$258.
  $E3BA,$01 Terminator.
N $E3BB Graphic #N$259.
  $E3CB,$01 Terminator.
N $E3CC Graphic #N$25A.
  $E3CD,$01 Terminator.
N $E3CE Graphic #N$25B.
  $E3DE,$01 Terminator.
N $E3DF Graphic #N$25C.
  $E3EA,$01 Terminator.
N $E3EB Graphic #N$25D.
  $E3F5,$01 Terminator.
N $E3F6 Graphic #N$25E.
  $E401,$01 Terminator.
N $E402 Graphic #N$25F.
  $E40C,$01 Terminator.
N $E40D Graphic #N$260.
  $E420,$01 Terminator.
N $E421 Graphic #N$261.
  $E422,$01 Terminator.
N $E423 Graphic #N$262.
  $E433,$01 Terminator.
N $E434 Graphic #N$263.
  $E447,$01 Terminator.
N $E448 Graphic #N$264.
  $E449,$01 Terminator.
N $E44A Graphic #N$265.
  $E45A,$01 Terminator.
N $E45B Graphic #N$266.
  $E466,$01 Terminator.
N $E467 Graphic #N$267.
  $E468,$01 Terminator.
N $E469 Graphic #N$268.
  $E478,$01 Terminator.
N $E479 Graphic #N$269.
  $E47A,$01 Terminator.
N $E47B Graphic #N$26A.
  $E48C,$01 Terminator.
N $E48D Graphic #N$26B.
  $E48F,$01 Terminator.
N $E490 Graphic #N$26C.
  $E4A0,$01 Terminator.
N $E4A1 Graphic #N$26D.
  $E4A2,$01 Terminator.
N $E4A3 Graphic #N$26E.
  $E4B2,$01 Terminator.
N $E4B3 Graphic #N$26F.
  $E4B4,$01 Terminator.
N $E4B5 Graphic #N$270.
  $E4C6,$01 Terminator.
N $E4C7 Graphic #N$271.
  $E4C9,$01 Terminator.
N $E4CA Graphic #N$272.
  $E4DA,$01 Terminator.
N $E4DB Graphic #N$273.
  $E4DC,$01 Terminator.
N $E4DD Graphic #N$274.
  $E4E8,$01 Terminator.
N $E4E9 Graphic #N$275.
  $E4ED,$01 Terminator.
N $E4EE Graphic #N$276.
  $E4EF,$01 Terminator.
N $E4F0 Graphic #N$277.
  $E500,$01 Terminator.
N $E501 Graphic #N$278.
  $E503,$01 Terminator.
N $E504 Graphic #N$279.
  $E514,$01 Terminator.
N $E515 Graphic #N$27A.
  $E516,$01 Terminator.
N $E517 Graphic #N$27B.
  $E522,$01 Terminator.
N $E523 Graphic #N$27C.
  $E527,$01 Terminator.
N $E528 Graphic #N$27D.
  $E529,$01 Terminator.
N $E52A Graphic #N$27E.
  $E53A,$01 Terminator.


  $C740,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C740-$C748-$08(player-01) } UDGTABLE#
  $C753,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C753-$C75B-$08(player-02) } UDGTABLE#
  $C766,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C766-$C76E-$08(player-03) } UDGTABLE#
  $C777,$0A #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C777-$C77F-$08{$00,$00,$20,$28}(player-04) } UDGTABLE#
  $C785,$10 #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C785-$C78D-$08(graphic-32) } UDGTABLE#
  $C796,$1A #UDGTABLE(default,centre) { #UDGARRAY$01,attr=$07,scale=$04,step=$01;$C796-$C7AE-$08{$00,$00,$20,$68}(graphic-33) } UDGTABLE#

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
  $E867,$03 #REGa=*#R$783D.
  $E86A,$02 #REGa-=#N$08.
  $E86C,$03 Write #REGa to *#R$783D.
  $E86F,$01 Restore #REGhl from the stack.
  $E870,$01 Return.

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

c $EBF3
  $EBF3,$03 #REGa=*#R$785A.
  $EBF6,$03 #HTML(#REGhl=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $EBF9,$03 Jump to #R$EBF9 if #REGa is not equal to *#REGhl.
  $EBFC,$03 Jump to #R$6C00.

u $EBFF

c $EC00
  $EC00,$01 Switch to the shadow registers.
  $EC01,$01 #REGc'=#REGa.
  $EC02,$03 #REGa=*#R$785A.
  $EC05,$03 #HTML(#REGhl'=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C78.html">FRAMES</a>.)
  $EC08,$01 Compare #REGa with *#REGhl'.
  $EC09,$01 #REGa=#REGc'.
  $EC0A,$01 Switch back to the normal registers.
  $EC0B,$01 Return if #REGa was not equal to *#REGhl' on line #R$EC08.
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

c $EC6E
  $EC6E,$04 #HTML(Write #N$00 (cursor type "C", "K" or "L") to
. *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C41.html">MODE</a>.)
  $EC72,$04 #HTML(Set CAPS LOCK on, using bit 3 of *<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C6A.html">FLAGS2</a>).
  $EC76,$03 #HTML(#REGhl=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>.)
  $EC79,$02 #HTML(Reset bit 5 of 
. *<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>
. which resets "when a new key has been pressed".)
  $EC7B,$04 Jump to #R$EC7B if no key was pressed.
  $EC7F,$03 #HTML(#REGa=<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
  $EC82,$04 Jump to #N$EC6F if #REGa is higher than #N$80.
  $EC86,$03 Return if #REGa is lower than #N$60.
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
