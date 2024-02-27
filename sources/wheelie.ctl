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

b $5B00

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

c $6400
  $6400,$01 Stash #REGhl on the stack.
  $6401,$03 #REGhl=*#R$781E.
  $6404,$01 #REGa=*#REGhl.
  $6405,$01 Increment #REGl by one.
  $6406,$02 Jump to #R$640F if #REGl is not zero.
  $6408,$01 Increment #REGh by one.
  $6409,$04 Jump to #R$640F if bit 2 of #REGh is not set.
  $640D,$02 #REGh=#N$79.
  $640F,$03 Write #REGhl to *#R$781E.
  $6412,$01 Restore #REGhl from the stack.
  $6413,$01 Return.

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
  $643B,$04 #REGd-=#N$05.
  $643F,$01 Return.

c $6440

u $64A4

c $64AA
  $64AA,$03 #REGhl=#R$9E00.
  $64AD,$03 #REGbc=#N$0A00.
  $64B0,$02 #REGa=#N$32.
  $64B2,$02 CPIR.
  $64B4,$03 Return if #REGbc is zero.
  $64B7,$02 Stash #REGhl and #REGbc on the stack.
  $64B9,$01 #REGa=#N$00.
  $64BA,$02 No operation.
  $64BC,$02 #REGb=#N$04.
  $64BE,$01 #REGe=#REGa.
  $64BF,$01 Decrease #REGl by one.
  $64C0,$03 Call #R$6400.
  $64C3,$02,b$01 Keep only bits 0-2.
  $64C5,$03 Jump to #R$64F4 if #REGa is lower than #REGe.
  $64C8,$03 Call #R$7088.
  $64CB,$02,b$01 Keep only bits 0-2.
  $64CD,$01 #REGa+=#REGa.
  $64CE,$01 #REGe=#REGa.
  $64CF,$01 #REGa+=#REGa.
  $64D0,$01 #REGa+=#REGe.
  $64D1,$02 #REGa+=#N$6C.
  $64D3,$01 #REGe=#REGa.
  $64D4,$02 #REGd=#N$B4.
  $64D6,$01 #REGa=*#REGde.
  $64D7,$01 Write #REGa to *#REGhl.
  $64D8,$01 Increment #REGe by one.
  $64D9,$01 Increment #REGl by one.
  $64DA,$02 Decrease counter by one and loop back to #R$64D6 until counter is zero.
  $64DC,$04 Jump to #R$64F9 if *#REGde is zero.
  $64E0,$03 Decrease #REGl by three.
  $64E3,$01 Increment #REGh by one.
  $64E4,$02 #REGb=#N$02.
  $64E6,$01 #REGa=*#REGhl.
  $64E7,$01 Set flags.
  $64E8,$01 #REGa=*#REGde.
  $64E9,$02 Jump to #R$64ED if *#REGhl is zero.
  $64EB,$02 Increment #REGa by two.
  $64ED,$01 Write #REGa to *#REGhl.
  $64EE,$01 Increment #REGl by one.
  $64EF,$01 Increment #REGe by one.
  $64F0,$02 Decrease counter by one and loop back to #R$64E6 until counter is zero.
  $64F2,$02 Jump to #R$64F9.
  $64F4,$02 Write #N$01 to *#REGhl.
  $64F6,$01 Increment #REGl by one.
  $64F7,$02 Decrease counter by one and loop back to #R$64F4 until counter is zero.
  $64F9,$02 Restore #REGbc and #REGhl from the stack.
  $64FB,$02 Jump to #R$64B0.

u $64FD

c $6500
  $6500,$03 #REGde=#R$9E00.
  $6503,$03 #REGhl=#R$8960.
  $6506,$03 Call #R$6424.
  $6509,$03 #REGhl=#R$A101.
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

c $6564

c $659C
  $659C,$03 #REGhl=*#R$7817.
  $659F,$01 #REGd=#REGh.
  $65A0,$01 #REGe=#REGl.
  $65A1,$03 #REGa=*#R$7819.
  $65A4,$01 #REGc=#REGa.
  $65A5,$01 Increment #REGa by one.
  $65A6,$02,b$01 Keep only bits 0-2.
  $65A8,$03 Write #REGa to *#R$7819.
  $65AB,$02 Jump to #R$65B7 if #REGa is not zero.
  $65AD,$01 Increment #REGl by one.
  $65AE,$02 Jump to #R$65B4 if #REGl is not zero.
  $65B0,$04 #REGh+=#N$05.
  $65B4,$03 Write #REGhl to *#R$7817.
  $65B7,$04 #REGe+=#N$08.
  $65BB,$02 Jump to #R$65C1 if {} is higher.
  $65BD,$04 #REGd+=#N$05.
  $65C1,$01 #REGa=#REGc.
  $65C2,$02 #REGb=#N$01.
  $65C4,$03 Call #R$6564.
  $65C7,$03 #REGhl=#N$401F (screen buffer location).
  $65CA,$01 #REGd=#REGh.
  $65CB,$01 #REGe=#REGl.
  $65CC,$01 Switch to the shadow registers.
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
  $663F,$04 #REGe+=#N$20.
  $6643,$01 #REGl=#REGa.
  $6644,$02 Jump to #R$6648 if {} is higher.
  $6646,$02 #REGd=#N$48.
  $6648,$01 #REGh=#REGd.
  $6649,$01 Switch to the shadow registers.
  $664A,$02 Decrease counter by one and loop back to #R$65CD until counter is zero.
  $664C,$01 Switch to the shadow registers.
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

c $67E9 Controller: Scroll Playarea
@ $67E9 label=Controller_ScrollPlayarea
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

c $6893
  $6893,$18
  $68AB,$01 Return.

u $68AC

c $68AD
  $68AD,$05 Return if *#R$781B is zero.
  $68B2,$03 #REGhl=*#R$781C.
  $68B5,$01 #REGb=#REGa.
  $68B6,$02 #REGc=#N$00.
  $68B8,$01 Decrease #REGhl by one.
  $68B9,$01 #REGd=*#REGhl.
  $68BA,$01 Decrease #REGhl by one.
  $68BB,$01 #REGe=*#REGhl.
  $68BC,$01 Decrease #REGhl by one.
  $68BD,$01 #REGa=*#REGhl.
  $68BE,$01 Write #REGa to *#REGde.
  $68BF,$01 Decrease #REGhl by one.
  $68C0,$01 #REGa=#REGd.
  $68C1,$02 #REGa-=#N$11.
  $68C3,$02,b$01 Set bits 0-2.
  $68C5,$01 #REGd=#REGa.
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
  $68DE,$02 Decrease counter by one and loop back to #R$68B8 until counter is zero.
  $68E0,$03 Write #REGhl to *#R$781C.
  $68E3,$04 Write #N$00 to *#R$781B.
  $68E7,$01 Return.

u $68E8

c $68EC
  $68EC,$01 Switch to the shadow registers.
  $68ED,$03 Write #REGhl' to *#R$781C.
  $68F0,$01 #REGa=#REGb'.
  $68F1,$03 Write #REGa to *#R$781B.
  $68F4,$01 Switch back to the normal registers.
  $68F5,$01 Return.

c $68F6
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

c $6910

c $692C

u $6992

c $6996

u $69F2

c $6A00

u $6AA6

c $6AAC

u $6B2A

c $6B2D
  $6B2D,$03 #REGa=*#R$7822.
  $6B30,$02 #REGe=#N$0D.
  $6B32,$02 Test bit 7 of #REGa.
  $6B34,$02 Jump to #R$6B38 if {} is not zero.
  $6B36,$02 #REGe=#N$12.
  $6B38,$02 #REGc=#N$07.
  $6B3A,$03 #REGhl=#R$7833.
  $6B3D,$01 #REGd=*#REGhl.
  $6B3E,$01 Increment #REGl by one.
  $6B3F,$01 #REGa=*#REGhl.
  $6B40,$03 Call #R$692C.
  $6B43,$01 Return.
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

c $6C00

c $6CAA Game Initialisation
@ $6CAA label=GameInitialisation
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
  $6D13,$01 Flip the bits according to #REGa.
  $6D14,$03 Call #R$6800.
  $6D17,$03 #HTML(#REGa=*<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $6D1A,$01 Increment #REGa by one.
  $6D1B,$03 Jump to #R$EBF6.

c $6D1E
  $6D1E,$03 Jump to #R$E80E.

c $6D21
  $6D21,$04 #REGsp=#N$FFFF.
  $6D25,$03 Jump to #R$6CAA.

c $6D28

c $6D49

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

c $7088
  $7088,$03 Call #R$6400.
  $708B,$01 #REGe=#REGa.
  $708C,$01 #REGa=#REGh.
  $708D,$04 Jump to #R$709B if #REGa is lower than #N$9F.
  $7091,$02 Jump to #R$7097 if #REGa is equal to #N$9F.
  $7093,$02 #REGa-=#N$05.
  $7095,$02 Jump to #R$708D.
  $7097,$01 #REGa=#REGe.
  $7098,$02,b$01 Keep only bit 0.
  $709A,$01 Return.
  $709B,$01 #REGa=#REGe.
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
. { #N$00 | #R$E600 }
. { #N$01 | #R$E640 }
. { #N$02 | #R$E680 }
. { #N$03 | #R$E6C0 }
. { #N$04 | #R$E700 }
. { #N$05 | #R$E740 }
. { #N$06 | #R$E780 }
. { #N$07 | #R$E7C0 }
. TABLE#
@ $720A label=InitialiseLevel
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
  $724F,$04 Jump to #R$724A if #REGa is equal to #N$1F.
  $7253,$04 Jump to #R$724A if #REGa is lower than #N$08.
  $7257,$01 #REGl=#REGa.
  $7258,$03 Call #R$6400.
  $725B,$02,b$01 Keep only bits 0-1.
  $725D,$01 #REGh=#REGa.
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
B $73B6,$01

c $73B7 Demo Mode Input
@ $73B7 label=DemoModeInput
  $73B7,$05 Write #N$04 to *#R$7839.
  $73BC,$06 Write #N$3400 to *#R$783C.
  $73C2,$03 Call #R$6828.
  $73C5,$03 Jump to #R$73D1 if #REGa is zero.
  $73C8,$06 No operation.
  $73CE,$03 Jump to #R$E81B.
  $73D1,$03 Call #R$6400.
  $73D4,$02,b$01 Keep only bits 2-3.
  $73D6,$02 Jump to #R$73D1 if the result is zero.
  $73D8,$02,b$01 Flip bits 2-3.
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
.       <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html#3d89">#N$3D89</a>.)
N $7470 This calculation avoids the whitespace at the top and bottom of the ROM UDG; in the code below you'll see it
.       only copies six bytes/ lines.
@ $7470 label=PrintTarget
  $7470,$01 #REGa=*#REGbc'.
  $7471,$06 #REGl'=#N$81+(#REGa*#N$08).
  $7477,$02 #HTML(#REGh'=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html">#N$3D</a>.)
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

b $74A9

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

b $74C2

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

b $74DB

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

c $751A
  $751A,$03 #REGhl=*#R$782E.
  $751D,$03 #REGde=#N($0011,$04,$04).
  $7520,$01 #REGa=*#REGhl.
  $7521,$04 Jump to #R$752D if #REGa is lower than #N$28.
  $7525,$02 Compare #REGa with #N$46.
  $7527,$02 #REGe=#N$08.
  $7529,$02 Jump to #R$752D if #REGa was higher than #N$46 (on line #R$7525).
  $752B,$02 #REGe=#N$01.
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

c $754F Initialise Game
@ $754F label=InitialiseGame
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
  $7561,$02 #REGb=#REGa*#N$02.
  $7563,$01 Switch to the shadow registers.
  $7564,$02 #REGl=#R$7864(#N$64).
  $7566,$03 Call #R$74AA.
  $7569,$02 Decrease counter by one and loop back to #R$7563 until counter is zero.
  $756B,$04 Jump to #R$757E if #REGc is zero.
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

c $763C
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
  $765C,$03 Call #R$68AD.
  $765F,$03 #REGa=*#R$7822.
  $7662,$02 Test bit 7 of #REGa.
  $7664,$02 #REGa=#N$87.
  $7666,$02 Jump to #R$766A if {} is not zero.
  $7668,$02 #REGa+=#N$40.
  $766A,$03 Write #REGa to *#R$7834.
  $766D,$03 Call #R$6B2D.
N $7670 Print the "#STR($BA86,$03,$20)" messaging in the footer.
N $7670 #HTML(#FONT:(OUT OF FUEL)$3D00,attr=$A9(out-of-fuel))
  $7670,$02 #REGa=#N$A9 (#COLOUR$A9).
  $7672,$03 #REGhl=#R$BA86.
  $7675,$03 Call #R$74C3.
  $7678,$02 #REGd=#N$10.
  $767A,$02 #REGc=#N$01.
  $767C,$03 #REGhl=#N$1E00.
  $767F,$01 #REGa=#REGc.
  $7680,$01 #REGb=#REGc.
  $7681,$02 OUT #N$FE
  $7683,$02,b$01 Flip bits 4.
  $7685,$02 Decrease counter by one and loop back to #R$7685 until counter is zero.
  $7687,$01 Decrease #REGl by one.
  $7688,$02 Jump to #R$7680 if #REGl is not zero.
  $768A,$01 Decrease #REGh by one.
  $768B,$02 Jump to #R$7680 if #REGh is not zero.
  $768D,$01 Increment #REGc by one.
  $768E,$01 Decrease #REGd by one.
  $768F,$02 Jump to #R$767C if #REGd is not zero.
  $7691,$06 Write #N$3400 to *#R$783C.
  $7697,$03 Jump to #R$7161.
  $769A,$03 #REGa=*#R$7822.
  $769D,$02 Test bit 7 of #REGa.
  $769F,$02 Jump to #R$76A2 if {} is not zero.
  $76A1,$01 Invert the bits in #REGa.
  $76A2,$02 #REGa-=#N$7E.
  $76A4,$02 Shift #REGa right.
  $76A6,$01 #REGe=#REGa.
  $76A7,$02 #REGd=#N$00.
  $76A9,$01 Set flags.
  $76AA,$02 #REGhl-=#REGde (with carry).
  $76AC,$03 Write #REGhl to *#R$783C.
  $76AF,$02 Jump to #R$76D0 if {} is lower.
  $76B1,$01 #REGa=#REGh.
  $76B2,$02 Shift #REGa right.
  $76B4,$02 Shift #REGa right.
  $76B6,$01 Invert the bits in #REGa.
  $76B7,$02 #REGa-=#N$0C.
  $76B9,$01 #REGl=#REGa.
  $76BA,$02 #REGh=#N$BA.
  $76BC,$03 #REGde=#N$5A65 (attribute buffer location).
  $76BF,$03 Call #R$6893.
  $76C2,$03 #REGhl=*#R$783C.
  $76C5,$01 #REGa=#REGh.
  $76C6,$02 Compare #REGa with #N$04.
  $76C8,$03 Call #R$6D50 is higher.
  $76CB,$02 Test bit 6 of #REGl.
  $76CD,$03 Call #R$6D50 not zero.
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

b $7802

g $7814
B $7814,$01

g $7815

g $7817

g $7819
B $7819,$01

g $781A
B $781A,$01

g $781B
B $781B,$01

g $781C
W $781C,$02

g $781E
W $781E,$02

g $7820 Current Level
@ $7820 label=CurrentLevel
B $7820,$01

g $7821

g $7822

g $7824
B $7824,$01

g $7825

g $7828

g $782A

g $782C Control Method Pointer
@ $782C label=ControlMethod_Pointer
W $782C,$02

g $782E

g $7831
W $7831,$02

g $7834

g $7839 Lives
@ $7839 label=Lives
B $7839,$01

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

b $8960

b $9E00

b $A101

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

w $B4DC

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

b $BAF3

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

b $E600

c $E800 Initialise Demo Mode
@ $E800 label=InitialiseDemoMode
  $E800,$06 Write #R$73B7 to *#R$782C.
  $E806,$05 Write #N$05 to *#R$7820.
  $E80B,$03 Jump to #R$6CAA.

c $E80E Game
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
  $EC5A,$02,b$01 Keep only bits 0-2, 4.
  $EC5C,$02 Jump to #R$EC37.

c $EC5E Sounds: Level Complete
@ $EC5E label=Sounds_LevelComplete
N $EC5E #AUDIO(level-complete.wav)(#INCLUDE(LevelComplete))
  $EC5E,$03 #REGhl=#R$EEE8.
  $EC61,$02 Jump to #R$EC35.

c $EC63 Sounds: The Race Is On!
@ $EC63 label=Sounds_TheRaceIsOn
N $EC63 #AUDIO(race-is-on.wav)(#INCLUDE(RaceIsOn))
  $EC63,$03 #REGhl=#R$EF4F.
  $EC66,$02 Jump to #R$EC35.

c $EC68 Sounds: Ghostrider Has Finished
@ $EC68 label=Sounds_GhostriderFinished
N $EC68 #AUDIO(ghostrider-finished.wav)(#INCLUDE(GhostriderFinished))
  $EC68,$03 #REGhl=#R$EFC2.
  $EC6B,$02 Jump to #R$EC35.

u $EC6D

c $EC6E
  $EC6E,$04 Write #N$07 to *#REGiy+#N$07.
  $EC72,$04 Set bit 3 of *#REGix+#N$30.
  $EC76,$03 #HTML(#REGhl=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C3B.html">FLAGS</a>.)
  $EC79,$02 Reset bit 5 of *#REGhl.
  $EC7B,$02 Test bit 5 of *#REGhl.
  $EC7D,$02 Jump to #R$EC7B if {} is zero.
  $EC7F,$03 #HTML(#REGa=<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C08.html">*LAST_K</a>.)
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

c $ECAB Check Password
@ $ECAB label=CheckPassword
  $ECAB,$06 #HTML(Write #N$0A23 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>/<a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
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
  $ECD2,$06 #HTML(Write #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C09.html">*REPDEL</a>
.           and #N$01 to <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C0A.html">*REPPER</a>.)
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
@ $EE54 label=Messaging_Mistake
  $EE54,$20

t $EE74 Messaging: How To Play Wheelie
@ $EE74 label=Messaging_HowToPlay
  $EE74,$20 "#STR(#PC,$04,$20)".

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

b $EFFF

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
