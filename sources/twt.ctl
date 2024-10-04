; Copyright New Generation Software 1984, 2024 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @rom
> $4000 @start
> $4000 @expand=#DEF(#POKE #LINK:Pokes)
> $4000 @expand=#DEF(#ANIMATE(delay,count=$50)(name=$a)*$name-1,$delay;#FOR$02,$count||x|$name-x|;||($name-animation))
> $4000 @set-handle-unsupported-macros=1
b $4000 Loading Screen
D $4000 #UDGTABLE { =h Travel With Trashman Loading Screen. } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels.
  $5800,$0300,$20 Attributes.

> $5C92 @org
c $5C92 Game Entry Point
@ $5C92 label=GameEntryPoint
  $5C92,$0B Copy #N$0100 bytes from #N$FF00 to #N$5B00.
  $5C9D,$03 Jump to #R$8003.

u $5CA0

b $5D00

b $6000 World Map/ Shadow Buffer?
@ $6000 label=ShadowBuffer
  $7204,$01
  $7207,$01

W $7239,$02

W $7240,$02

  $7258

  $72B2

u $7800

g $7801 Flightpath Movement Vectors
@ $7801 label=Flightpath_X_MovementVector
B $7801,$02
@ $7803 label=Flightpath_Y_MovementVector
B $7803,$02

g $7805 Current Location Co-ordinates
@ $7805 label=CurrentLocationCoordinates
B $7805,$02

u $7807 Destination Location Co-ordinates
@ $7807 label=DestinationLocationCoordinates
B $7807,$02

g $7809 Flightpath Min/ Max Y Co-ordinates
@ $7809 label=Flightpath_Minimum_Y_Coordinate
D $7809 Used by the routine at #R$899C.
B $7809,$01
@ $780A label=Flightpath_Maximum_Y_Coordinate
B $780A,$01

g $7811 Temporary Screen Location
@ $7811 label=TemporaryScreenLocation
B $7811,$01

g $7812
B $7812,$01

g $7813
W $7813,$02

g $7815
B $7815,$01

g $781F
B $781F,$01

g $7820 Ticker Buffer
@ $7820 label=Buffer_Ticker
B $7820,$50

b $78C0

  $78FE

  $7E00

c $8003 Game Loop
@ $8003 label=GameInitialise
  $8003,$03 Call #R$8146.
  $8006,$05 Write #N$01 to *#R$EFFF.
@ $800B label=RestartGame
  $800B,$04 #HTML(#REGsp=*<a rel="noopener nofollow" href="https://skoolkit.ca/disassemblies/rom/hex/asm/5C4B.html">VARS</a>.)
@ $800F label=ShowMenu
  $800F,$03 Call #R$8A61.
  $8012,$06 Write *#R$8E84 to *#R$7805.
  $8018,$08 Write #N$00 to: #LIST { *#R$EFFA } { *#R$EFFB } LIST#
  $8020,$03 Call #R$83AA.
  $8023,$03 Call #R$84D5.
@ $8026 label=NewGame
  $8026,$03 Call #R$849D.
  $8029,$03 Call #R$803A.
@ $802C label=GameLoop
  $802C,$03 Call #R$8600.
  $802F,$03 Call #R$8666.
  $8032,$03 Call #R$8749.
  $8035,$03 Call #R$899C.
  $8038,$02 Jump to #R$802C.

c $803A Initialise Location States
@ $803A label=Initialise_LocationStates
N $803A Start with Madrid, as it's the first location in the table Trashman can
. travel to (London doesn't count, that's the first game!)
  $803A,$03 Set a pointer in #REGhl for the first location state: #R$8EAA.
  $803D,$03 Set #N($0011,$04,$04) in #REGde, which is the count of data before
. the location name starts. The location names vary in length but the data for
. them does not.
  $8040,$02 Set a counter in #REGb of the number of locations which have a
. playable level for Trashman (#N$0D - one less than the total which includes
. London).
@ $8042 label=Initialise_LocationState
  $8042,$02 Mark this location as: "#STATE$00".
N $8044 Keep moving forward one byte until the termination bit is found,
. signifying the final character of the location name.
@ $8044 label=FindEndCharacter_Loop
  $8044,$01 Increment #REGhl by one.
  $8045,$04 Jump to #R$8044 if the terminator bit is not set.
  $8049,$01 Move #REGhl to point to the next location state.
  $804A,$02 Decrease the location counter by one and loop back to #R$8042 until
. all of the location states have been processeed.
  $804C,$03 #REGa=*#R$EFFB.
  $804F,$02,b$01 Keep only bit 5 (1UP/ 2UP choice).
  $8051,$03 Write #REGa to *#R$EFFB.
M $804C,$08 Reset all the bits in *#R$EFFB except for the 1UP/ 2UP choice.
  $8054,$01 Return.

c $8055
  $8055,$01 Stash #REGbc on the stack.
  $8056,$03 Call #R$8079.
  $8059,$03 Call #R$81D4.
  $805C,$03 Call #R$813C.
  $805F,$03 #REGa=*#R$EFFC.
  $8062,$02,b$01 Keep only bits 0-2.
  $8064,$02 Jump to #R$8072 if the result is zero.
  $8066,$04 Jump to #R$8075 if #REGa is not equal to #N$04.
  $806A,$03 #REGhl=*#R$7805.
  $806D,$03 Call #R$8A07.
  $8070,$02 Jump to #R$8075.
  $8072,$03 Call #R$81B3.
  $8075,$01 Restore #REGbc from the stack.
  $8076,$02 Decrease counter by one and loop back to #R$8055 until counter is zero.
  $8078,$01 Return.

c $8079
  $8079,$03 #HTML(#REGa=*<a rel="noopener nofollow" rel="noopener nofollow" href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $807C,$03 Write #REGa to *#R$EFFC.
  $807F,$02 #REGe=#N$10.
  $8081,$01 #REGc=#REGa.
  $8082,$03 #REGa=*#R$EFFF.
  $8085,$02 Test bit 1 of #REGa.
  $8087,$02 Jump to #R$80D5 if  is not zero.
  $8089,$02 Test bit 0 of #REGa.
  $808B,$02 Jump to #R$80CB if  is not zero.
  $808D,$02 Test bit 2 of #REGa.
  $808F,$02 Jump to #R$8096 if  is zero.
  $8091,$02 #REGb=#N$7F.
  $8093,$03 Jump to #R$811C.
  $8096,$02 Test bit 3 of #REGa.
  $8098,$02 Jump to #R$809F if  is zero.
  $809A,$02 #REGb=#N$3F.
  $809C,$03 Jump to #R$811C.
  $809F,$02 Test bit 4 of #REGa.
  $80A1,$02 Jump to #R$80A7 if  is zero.
  $80A3,$02 #REGa=#N$C8.
  $80A5,$02 Jump to #R$80C1.
  $80A7,$02 Test bit 5 of #REGa.
  $80A9,$02 Jump to #R$80AF if  is zero.
  $80AB,$02 #REGa=#N$78.
  $80AD,$02 Jump to #R$80C1.
  $80AF,$02 Test bit 6 of #REGa.
  $80B1,$02 Jump to #R$80B7 if  is zero.
  $80B3,$02 #REGa=#N$50.
  $80B5,$02 Jump to #R$80C1.
  $80B7,$02 Test bit 7 of #REGa.
  $80B9,$02 Jump to #R$80BF if  is zero.
  $80BB,$02 #REGa=#N$32.
  $80BD,$02 Jump to #R$80C1.
  $80BF,$01 Halt operation (suspend CPU until the next interrupt).
  $80C0,$01 Return.
  $80C1,$03 Write #REGa to *#R$EFFE.
  $80C4,$05 Write #N$00 to *#R$EFFF.
  $80C9,$02 Jump to #R$8102.
  $80CB,$02 Set bit 1 of #REGa.
  $80CD,$03 Write #REGa to *#R$EFFF.
  $80D0,$03 #REGhl=#R$8FEB.
  $80D3,$02 Jump to #R$80E2.
  $80D5,$03 #REGhl=#R$EFDD.
  $80D8,$03 #HTML(#REGa=*<a rel="noopener nofollow" rel="noopener nofollow" href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $80DB,$01 Compare #REGa with *#REGhl.
  $80DC,$03 Jump to #R$8102 M.
  $80DF,$03 #REGhl=*#R$EFDE.
  $80E2,$05 Jump to #R$80EE if *#REGhl is not equal to #N$00.
  $80E7,$03 #REGhl=#R$EFFF.
  $80EA,$02 Write #N$00 to *#REGhl.
  $80EC,$02 Jump to #R$80BF.
  $80EE,$01 Increment #REGhl by one.
  $80EF,$01 #REGb=*#REGhl.
  $80F0,$01 Increment #REGhl by one.
  $80F1,$03 Write #REGhl to *#R$EFDE.
  $80F4,$03 #REGhl=#R$EFFE.
  $80F7,$01 Compare #REGa with *#REGhl.
  $80F8,$01 Write #REGa to *#REGhl.
  $80F9,$02 Jump to #R$80FD if #REGa is not zero.
  $80FB,$02 #REGe=#N$00.
  $80FD,$01 #REGa=#REGc.
  $80FE,$01 #REGa+=#REGb.
  $80FF,$03 Write #REGa to *#R$EFDD.
  $8102,$03 #REGhl=#R$EFFD.
  $8105,$05 #HTML(Return if *<a rel="noopener nofollow" rel="noopener nofollow" href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> is not equal to #REGc.)
  $810A,$01 Decrease *#REGhl by one.
  $810B,$02 Jump to #R$8105 if *#REGhl is not zero.
  $810D,$04 Write *#R$EFFE to *#REGhl.
  $8111,$03 #REGa=*#R$99CC.
  $8114,$01 Flip the bits according to #REGe.
  $8115,$03 Write #REGa to *#R$99CC.
  $8118,$02 OUT #N$FE
  $811A,$02 Jump to #R$8105.
  $811C,$02,b$01 Keep only bits 4-7.
  $811E,$03 Write #REGa to *#R$EFFF.
  $8121,$03 #REGhl=#R$EFFD.
  $8124,$03 #HTML(#REGa=*<a rel="noopener nofollow" rel="noopener nofollow" href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $8127,$02 Return if #REGa is not equal to #REGc.
  $8129,$01 Decrease *#REGhl by one.
  $812A,$02 Jump to #R$8124 if *#REGhl is not zero.
  $812C,$03 Call #R$9619.
  $812F,$01 Merge the bits from #REGb.
  $8130,$01 Write #REGa to *#REGhl.
  $8131,$03 #REGa=*#R$99CC.
  $8134,$01 Flip the bits according to #REGe.
  $8135,$03 Write #REGa to *#R$99CC.
  $8138,$02 OUT #N$FE
  $813A,$02 Jump to #R$8124.

c $8146 Print World Map
@ $8146 label=Print_WorldMap
N $8146 #PUSHS #POKES$8C28,$50;$8C29,$4F;$8C2A,$42;$8C2B,$53;$8C2C,$54;$8C2D,$45;$8C2E,$52;$EFF2,$28;$EFF3,$8C
. #UDGTABLE { #SIM(start=$8146,stop=$81AB)#SCR$02(world-map) } UDGTABLE# #PUSHS
  $8146,$04 #REGix=#R$F000.
  $814A,$03 #REGhl=#R$6000.
  $814D,$02 #REGe=#N$FF.
  $814F,$02 #REGd=#N$80.
  $8151,$02 #REGa=#N$00.
  $8153,$02 Increment #REGix by one.
  $8155,$03 #REGb=*#REGix+#N$FF.
  $8158,$01 Increment #REGe by one.
  $8159,$02 Jump to #R$815D if #REGe is zero.
  $815B,$02 #REGe=#N$FF.
  $815D,$02 Rotate #REGe right (with carry).
  $815F,$02 Rotate *#REGhl left.
  $8161,$01 Decrease #REGb by one.
  $8162,$02 Shift #REGd right.
  $8164,$02 Jump to #R$816B if #REGb is zero.
  $8166,$01 Compare #REGa with #REGb.
  $8167,$02 Jump to #R$815D if #REGa is not zero.
  $8169,$02 Jump to #R$8153.
  $816B,$01 Increment #REGhl by one.
  $816C,$02 #REGa=#N$78.
  $816E,$01 Compare #REGa with #REGh.
  $816F,$02 Jump to #R$8186 if #REGa is zero.
  $8171,$01 #REGa=#REGb.
  $8172,$02 Compare #REGa with #N$08.
  $8174,$02 Jump to #R$8180 if #REGa is higher.
  $8176,$02 Compare #REGa with #N$00.
  $8178,$02 #REGd=#N$80.
  $817A,$02 Jump to #R$8153 if #REGa is zero.
  $817C,$02 #REGa=#N$00.
  $817E,$02 Jump to #R$815D.
  $8180,$01 Write #REGe to *#REGhl.
  $8181,$02 #REGa-=#N$08.
  $8183,$01 #REGb=#REGa.
  $8184,$02 Jump to #R$816B.
  $8186,$03 #REGhl=#R$6000(#N$601F).
  $8189,$03 #REGde=#N($0020,$04,$04).
  $818C,$02 #REGb=#N$C0.
  $818E,$02 Reset bit 0 of *#REGhl.
  $8190,$01 #REGhl+=#REGde.
  $8191,$02 Decrease counter by one and loop back to #R$818E until counter is zero.
  $8193,$03 #REGhl=#R$6000.
  $8196,$03 #REGde=#N($4000,$04,$04).
  $8199,$03 #REGbc=#N($1800,$04,$04).
  $819C,$02 LDIR.
  $819E,$03 #REGhl=#N$5800 (screen buffer location).
  $81A1,$03 #REGde=#N$5801 (attribute buffer location).
  $81A4,$03 #REGbc=#N($02FF,$04,$04).
  $81A7,$02 Write #COLOUR$4E to *#REGhl.
  $81A9,$02 LDIR.
  $81AB,$02 #REGa=#N$01.
  $81AD,$03 Write #REGa to *#R$99CC.
  $81B0,$02 OUT #N$C9FE
  $81B2,$01 Return.

c $81B3 Flash Location Map Points
@ $81B3 label=FlashLocationMapPoints
N $81B3 Starting with the first location, London.
  $81B3,$04 #REGix=#R$8E82.
  $81B7,$02 Set a counter in #REGb for the total number of locations (#N$0E).
@ $81B9 label=FlashLocationMapPoints_Loop
  $81B9,$01 Stash the locations count on the stack.
  $81BA,$06 Load the map co-ordinates for the current location into #REGhl.
  $81C0,$03 Call #R$8A07.
  $81C3,$05 Add #N($0016,$04,$04) to #REGix which is a safe place to land to
. find the next location.
N $81C8 All locations end with the string for the location name, so now move
. through the string to find the terminating bit. This is necessary as the
. location names have varying lengths.
@ $81C8 label=CheckTerminator_Loop
  $81C8,$04 Test bit 7 of *#REGix+#N$00.
  $81CC,$02 Increment #REGix by one.
  $81CE,$02 Keep jumping back to #R$81C8 until the terminating bit 7 is found.
  $81D0,$01 Restore the locations count from the stack.
  $81D1,$02 Decrease the locations count by one and loop back to #R$81B9 until
. locations have been processed.
  $81D3,$01 Return.

c $813C Handler: Debounce Space
@ $813C label=Handler_DebounceSpace
  $813C,$04 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$7F | SPACE | FULL-STOP | M | N | B }
. TABLE#
  $8140,$03 Return if "SPACE" is not being pressed.
  $8143,$03 Jump to #R$800B.

c $81D4 Handler: Ticker
@ $81D4 label=Handler_Ticker
N $81D4 Example messaging (note, this is two frames at a time - the game is
. smoother - plus, in the game the message starts off-screen). #PUSHS
. #POKES($EFFA,$80);$8C30,$82;$8C31,$8E;$EFF8,$01#SIM(start=$823B,stop=$839E)
. #FOR$01,$50||x|#SIM(start=$8059,stop=$805C)||
. #UDGTABLE {
.   #FOR$01,$FF||x|#SIM(start=$8059,stop=$805C)#SIM(start=$8059,stop=$805C)
.     #SCR$02,$00,$16,$20,$01(*ticker-x)#PLOT(0,0,0)(ticker-x)
.   ||
.   #UDGARRAY#(#ANIMATE$08,$FF(ticker))
. } UDGTABLE# #POPS
  $81D4,$06 Return if the ticker is not currently enabled.
  $81DA,$03 #REGhl=#R$7815.
  $81DD,$01 Decrease *#REGhl by one.
  $81DE,$02 Jump to #R$8220 if *#REGhl is not zero.
  $81E0,$02 Write #N$07 to *#REGhl.
  $81E2,$03 #REGhl=#R$7812.
  $81E5,$01 Decrease *#REGhl by one.
  $81E6,$02 Jump to #R$8207 if *#REGhl is not zero.
  $81E8,$07 Jump to #R$81FE if bit 1 ("Flightpath In-Progress") of *#R$EFFB is set.
  $81EF,$07 Jump to #R$81FB if *#R$EFFA is equal to #N$00.
  $81F6,$03 Call #R$823B.
  $81F9,$02 Jump to #R$81D4.
N $81FB The ticker animation is complete, so reset the state flag.
@ $81FB label=TickerAnimation_Complete
  $81FB,$02 Set the ticker bit in *#R$EFFB to "ticker OFF".
  $81FD,$01 Return.

  $81FE,$03 #REGa=*#N$781E.
  $8201,$03 Call #R$8388.
  $8204,$03 Jump to #R$81D4.

  $8207,$03 #REGhl=*#R$7813.
  $820A,$04 Increment *#R$7813 by one.
  $820E,$01 #REGl=*#REGhl.
  $820F,$02 #REGh=#N$00.
  $8211,$03 #REGhl*=#N$08.
  $8214,$04 #REGhl+=#R$F840(#N$F740).
  $8218,$08 Copy #N($0008,$04,$04) bytes from *#REGhl to #N$7816.
N $8220 Rotate the messaging left across the screen.
  $8220,$02 Set a counter in #REGc for the number of bytes in a character (#N$08).
  $8222,$03 #REGhl=#N$7816.
  $8225,$03 Set #REGde to the screen buffer location #N$50DF.
@ $8228 label=TickerRotate_Loop
  $8228,$02 Rotate *#REGhl left (with carry).
  $822A,$01 Stash #REGde on the stack.
  $822B,$01 Exchange the #REGde and #REGhl registers.
N $822C Rotate the current line.
  $822C,$02 Set a counter in #REGb for the number of characters in a line (#N$20).
@ $822E label=TickerRotateLine_Loop
  $822E,$02 Rotate *#REGhl left.
  $8230,$01 Decrease #REGhl by one.
  $8231,$02 Decrease counter by one and loop back to #R$822E until counter is zero.
  $8233,$01 Restore #REGhl from the stack.
  $8234,$01 Increment #REGh by one.
  $8235,$01 Exchange the #REGde and #REGhl registers.
  $8236,$01 Increment #REGhl by one.
  $8237,$01 Decrease #REGc by one.
  $8238,$02 Jump to #R$8228 if #REGc is not zero.
  $823A,$01 Return.

c $823B Generate Ticker Messaging
@ $823B label=Messaging_GenerateTicker
N $823B These examples are generated with the location being "London" so
. obviously aren't possible to see in the actual game (given London isn't a
. playable level - that's the first game!)
N $823B Note, this isn't a complete list - as some vary with the bonus points
. messaging:
. #PUSHS #POKES$8C30,$82;$8C31,$8E;$EFF8,$01 #UDGTABLE(default) { =h Bit | =h Message }
. #FOR$01,$07(x,{ #Nx | #TICKERx(ticker-#Nx) })
. UDGTABLE# #POPS
  $823B,$03 Call #R$835F.
N $823E Test if the player has been deported from Russia.
  $823E,$07 Jump to #R$826F if the player hasn't been "deported from Russia".
N $8245 Player has been deported from Russia, so handle displaying the
. messaging in the ticker.
  $8245,$02 Reset bit 2 ("Deported From Russia") in *#R$EFFA.
  $8247,$02 Reset bit 0 of *#R$EFFA.
N $8249 Build the string in the ticker buffer.
  $8249,$06 Adds ... "#STR($8CF0)" to the ticker buffer.
  $824F,$02 Set the spacing to #N$5A in #REGa.
  $8251,$08 Jump to #R$837F if the player has no bonus points.
  $8259,$02 Reset bit 1 ("Has Bonus Points?") of *#R$EFFA.
  $825B,$06 Adds ... "#STR($8D17)" to the ticker buffer.
  $8261,$03 Adds the players bonus points to the ticker buffer.
  $8264,$06 Adds ... "#STR($8DB1)" to the ticker buffer.
  $826A,$05 Set the spacing to #N$78 and jump to #R$837F.
N $826F Test if the player has been hit by the bull in Madrid.
@ $826F label=Ticker_CheckKilledInSpain
  $826F,$04 Jump to #R$829D if the player has not been hit by the bull.
N $8273 Player has been hit by the bull, so handle displaying the
. messaging in the ticker.
  $8273,$02 Reset bit 3 ("Hit By The Bull") of *#R$EFFA.
  $8275,$02 Reset bit 0 of *#R$EFFA.
N $8277 Build the string in the ticker buffer.
  $8277,$06 Adds ... "#STR($8D30)" to the ticker buffer.
  $827D,$02 Set the spacing to #N$55 in #REGa.
  $827F,$08 Jump to #R$837F if the player has no bonus points.
  $8287,$02 Reset bit 1 ("Has Bonus Points?") of *#R$EFFA.
  $8289,$06 Adds ... "#STR($8D55)" to the ticker buffer.
  $828F,$03 Adds the players bonus points to the ticker buffer.
  $8292,$06 Adds ... "#STR($8D5A)" to the ticker buffer.
  $8298,$05 Set the spacing to #N$8E and jump to #R$837F.
N $829D Did the player manage to complete the sub-game?
@ $829D label=Ticker_CheckSubGameWasSuccess
  $829D,$04 Jump to #R$82B7 if bit 0 of *#R$EFFA is not set.
  $82A1,$02 Reset bit 0 of *#R$EFFA.
N $82A3 Build the string in the ticker buffer.
  $82A3,$06 Adds ... "#STR($8D8B)" to the ticker buffer.
  $82A9,$03 Add the current location name to the ticker buffer.
  $82AC,$06 Adds ... "#STR($8DA3)" to the ticker buffer.
  $82B2,$05 Set the spacing to #N$5A and jump to #R$837F.
N $82B7 As above, but also with bonus points.
@ $82B7 label=Ticker_CheckSubGameWasSuccess_WithBonusPoints
  $82B7,$04 Jump to #R$82DA if the player has no bonus points.
N $82BB Player has completed the sub-game and has bonus points, so handle
. displaying the messaging in the ticker.
  $82BB,$02 Reset bit 1 ("Has Bonus Points?") of *#R$EFFA.
N $82BD Build the string in the ticker buffer.
  $82BD,$06 Adds ... "#STR($8D8B)" to the ticker buffer.
  $82C3,$03 Add the current location name to the ticker buffer.
  $82C6,$06 Adds ... "#STR($8DA5)" to the ticker buffer.
  $82CC,$03 Add the players bonus points to the ticker buffer.
  $82CF,$06 Adds ... "#STR($8DB1)" to the ticker buffer.
  $82D5,$05 Set the spacing to #N$6E and jump to #R$837F.
N $82DA Is the player out of money and stranded in their current location?
@ $82DA label=Ticker_CheckStranded
  $82DA,$04 Jump to #R$82F4 if the player is not "stranded" (doesn't have enough money to fly).
N $82DE Player is stranded in their current location, so handle displaying the
. messaging in the ticker.
  $82DE,$02 Reset bit 4 ("Stranded") of *#R$EFFA.
N $82E0 Build the string in the ticker buffer.
  $82E0,$06 Adds ... "#STR($8CC3)" to the ticker buffer.
  $82E6,$03 Add the current location name to the ticker buffer.
  $82E9,$06 Adds ... "#STR($8CD0)" to the ticker buffer.
  $82EF,$05 Set the spacing to #N$50 and jump to #R$837F.
N $82F4 Can the player not afford to fly?
@ $82F4 label=Ticker_CheckAffordToFly
  $82F4,$04 Jump to #R$830E if the player can afford to fly to someplace else.
N $82F8 The player is broke and can't afford to fly to a new destination, so
. handle displaying this in the ticker.
  $82F8,$02 Reset bit 5 ("Can't Afford To Fly") of *#R$EFFA.
N $82FA Build the string in the ticker buffer.
  $82FA,$06 Adds ... "#STR($8CC3)" to the ticker buffer.
  $8300,$03 Add the current location name to the ticker buffer.
  $8303,$06 Adds ... "#STR($8CDC)" to the ticker buffer.
  $8309,$05 Set the spacing to #N$5A and jump to #R$837F.
N $830E Has the player completed ALL the sub-games?
@ $830E label=Ticker_CheckGameWasCompleted
  $830E,$04 Jump to #R$8322 if the player hasn't yet completed all the
. sub-games.
N $8312 Player has completed all the sub-games, so handle displaying the
. messaging in the ticker.
  $8312,$02 Reset bit 6 ("Completed All Locations") of *#R$EFFA.
N $8314 Build the string in the ticker buffer.
  $8314,$06 Adds ... "#STR($8DBC)" to the ticker buffer.
  $831A,$03 Add the current location name to the ticker buffer.
  $831D,$05 Set the spacing to #N$78 and jump to #R$837F.
N $8322 Is the player flying somewhere new?
@ $8322 label=Ticker_CheckFlyingToNewDestination
  $8322,$03 Just return if the player is not flying somewhere new, there are no
. more conditions covered.
N $8325 Player is flying to a new destination, so handle displaying the
. messaging in the ticker.
  $8325,$02 Reset bit 7 ("Flying To New Destination") of *#R$EFFA.
N $8327 Build the string in the ticker buffer.
  $8327,$06 Adds ... "#STR($8CBA)" to the ticker buffer.
  $832D,$03 Add the current location name to the ticker buffer.
  $8330,$05 Set the spacing to #N$46 and jump to #R$837F.
N $8335 Adds the players bonus points count to the ticker.
@ $8335 label=AddBonusPointsToTicker
  $8335,$03 #REGhl=#R$EFF8.
  $8338,$04 #REGix=#R$EFFB.
  $833C,$04 Set bit 4 ("Used for printing scores/ stripping off leading
. zeroes") of *#REGix+#N$00.
  $8340,$02 Set a counter in #REGc for the number of digits (#N$02).
@ $8342 label=ProcessBonusPointsDigit_Loop
  $8342,$02 Set a counter in #REGb for the count of how many score digits are
. to be processed in each score byte (#N$02).
@ $8344 label=ProcessBonusPoints_Loop
  $8344,$02 Load #REGa with ASCII "0" (#N$30).
  $8346,$02 Extract the score digit into the accumulator.
N $8348 Don't print any zeros while bit 4 is set, it's only unset when a
. printable digit is "found" (i.e. not a zero). Once it is, then the zero
. characters are set freely (e.g. we won't print 001, but we will print 100).
  $8348,$06 Jump to #R$8356 if bit 4 of *#REGix+#N$00 is not set.
N $834E Strip off leading zeros.
  $834E,$04 Jump to #R$8358 if the current digit is "0".
N $8352 The digit is not a zero, so flag and process.
  $8352,$04 Reset bit 4 ("Used for printing scores/ stripping off leading
. zeroes") of *#REGix+#N$00.
@ $8356 label=WriteDigitToTickerBuffer
  $8356,$01 Write the digit to the ticker buffer.
  $8357,$01 Increment the ticker buffer pointer by one.
@ $8358 label=BonusPointsProcessNextNumber
  $8358,$02 Decrease counter by one and loop back to #R$8344 until counter is zero.
N $835A The score is evaluated backwards.
  $835A,$01 Decrease the score pointer by one.
  $835B,$01 Decrease the score digit counter by one.
  $835C,$02 Jump to #R$8342 until both digits of the score have been processed.
  $835E,$01 Return.

c $835F Initialise Ticker Buffer
@ $835F label=InitialiseTickerBuffer
N $835F Adds "#STR($8C99)" into the ticker buffer.
  $835F,$03 #REGhl=#R$8C99.
  $8362,$03 #REGde=#R$7820.
  $8365,$03 Call #R$839F.
N $8368 Adds the active players name into the ticker buffer.
  $8368,$03 #REGhl=*#R$EFF2.
  $836B,$03 Jump to #R$839F.

c $836E Add Location To Ticker Buffer
@ $836E label=AddLocationTickerBuffer
  $836E,$04 #REGix=*#R$EFF2.
  $8372,$06 Load the current location pointer to #REGhl.
N $8378 Add #N($0011,$04,$04) to #REGhl, which is the count of data before the
. location name string starts.
.
. The location names vary in length but the data for them does not.
  $8378,$04 #REGhl+=#N($0011,$04,$04).
  $837C,$03 Jump to #R$839F.

c $837F Add Spacing To Fill Ticker Buffer
@ $837F label=AddSpacingFillTickerBuffer
R $837F A Final position for spacing
R $837F DE Starting address in #R$7820
  $837F,$01 Exchange the #REGde and #REGhl registers.
@ $8380 label=AddSpacingFillTickerBuffer_Loop
  $8380,$03 Jump to #R$8388 if #REGa is equal to #REGl.
  $8383,$02 Write an ASCII space (#N$20) to *#REGhl.
  $8385,$01 Increment #REGhl by one.
  $8386,$02 Jump to #R$8380.
@ $8388 label=DoneFillingTickerBuffer
  $8388,$05 Write #N$01 to *#R$7815.
  $838D,$06 Write the final spacing position to: #LIST { *#R$7812 } { *#R$781E } LIST#
  $8393,$06 Write #R$781F to *#R$7813.
  $8399,$05 Set bit 0 ("Ticker On/ Off") of *#R$EFFB to turn the ticker on.
  $839E,$01 Return.

c $839F Add String To Buffer
@ $839F label=AddStringToBuffer
R $839F DE Buffer address
R $839F HL Message string
  $839F,$01 Fetch a character from the string and store it in #REGa.
  $83A0,$02,b$01 Strip off the termination bit.
  $83A2,$01 Write the character to the buffer.
  $83A3,$02 Test if bit 7 of the current character is set.
  $83A5,$01 Increment the message string pointer by one.
  $83A6,$01 Increment the buffer pointer by one.
  $83A7,$02 Jump to #R$839F until the termination bit is set.
  $83A9,$01 Return.

c $83AA Game Selection Menu
@ $83AA label=GameMenu
N $83AA #PUSHS #UDGTABLE { #SIM(start=$83AA,stop=$83DF)#SCR$02(main-menu) } UDGTABLE# #POPS
N $83AA Prints "#STR($8B31)".
  $83AA,$03 #REGhl=#R$8B31.
  $83AD,$03 #REGde=#N$504B (screen buffer location).
  $83B0,$03 Call #R$8A3D.
  $83B3,$03 #REGhl=#N$506B (screen buffer location).
  $83B6,$05 #R$8A37 the header with #N$0F character blocks of #N$FF.
N $83BB Prints "#STR($8B40)".
  $83BB,$03 #REGhl=#R$8B40.
  $83BE,$03 #REGde=#N$5089 (screen buffer location).
  $83C1,$03 Call #R$8A3D.
N $83C4 Prints "#STR($8B53)".
  $83C4,$03 #REGhl=#R$8B53.
  $83C7,$03 #REGde=#N$50A9 (screen buffer location).
  $83CA,$03 Call #R$8A3D.
N $83CD Prints "#STR($8B66)".
  $83CD,$03 #REGhl=#R$8B66.
  $83D0,$03 #REGde=#N$50C9 (screen buffer location).
  $83D3,$03 Call #R$8A3D.
N $83D6 Prints "#STR($8B73)".
  $83D6,$03 #REGhl=#R$8B73.
  $83D9,$03 #REGde=#N$50E9 (screen buffer location).
  $83DC,$03 Call #R$8A3D.
N $83DF Handle retrieving the players input.
@ $83DF label=GameMenu_InputLoop
  $83DF,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$F7 | 1 | 2 | 3 | 4 | 5 }
. TABLE#
  $83E4,$02,b$01 Set bits 5-7 (to fill in the extra bits).
  $83E6,$04 Jump to #R$83F1 if any of the keys have been pressed.
  $83EA,$05 Call #R$8055 with a count of #N$05.
  $83EF,$02 Jump to #R$83DF.
N $83F1 Process the players input.
@ $83F1 label=GameMenu_HandleInput
  $83F1,$04 Jump to #R$841C if #REGa is equal to #N$FE.
N $83F5 Was Kempston joystick selected?
  $83F5,$03 #REGhl=#R$8E55.
  $83F8,$04 Jump to #R$8418 if #REGa is equal to #N$FD.
N $83FC Was Interface 2 joystick selected?
  $83FC,$03 #REGhl=#R$8E64.
  $83FF,$04 Jump to #R$840A if #REGa is equal to #N$FB.
N $8403 Was the Cursor joystick selected?
  $8403,$03 #REGhl=#R$8E73.
  $8406,$04 Jump back to #R$83DF if the cursor joystick was not selected.
N $840A Self-modifying code. See; #R$85F4.
@ $840A label=SetNoOperation
  $840A,$02 Write #N$00 (NOP) to *#R$85F4.
@ $840C label=SetActiveKeyMap
  $840C,$03 Write #REGa to *#R$85F4.
  $840F,$08 Copy #N($000F,$04,$04) bytes from *#REGhl to *#R$EFE0.
  $8417,$01 Return.
N $8418 Self-modifying code. See; #R$85F4.
N $8418 Invert the bits in the controls routine.
@ $8418 label=SetKempstonJoystick
  $8418,$02 #REGa=#N$2F (CPL) to *#R$85F4.
  $841A,$02 Jump to #R$840C.
N $841C Self-modifying code. See; #R$85F4.
@ $841C label=SetUserDefinedKeys
  $841C,$05 Write #N$00 (NOP) to *#R$85F4.
  $8421,$03 Call #R$8A71.
N $8424 Prints "#STR($8B88)".
  $8424,$03 #REGhl=#R$8B88.
  $8427,$03 #REGde=#N$50A7 (screen buffer location).
  $842A,$03 Call #R$8A3D.
N $842D Cycle through each key/ key messaging to collect the user input:
N $842D Using #FOREACH($8B96,$8B9F,$8BA8,$8BB1,$8BBA)||n|"#STR(n,$01)"|, | and || strings.
  $842D,$03 #REGhl=#R$8B96.
  $8430,$02 Store a counter in #REGb of #N$05 for how many strings to print.
  $8432,$04 #REGix=#R$EFE0.
@ $8436 label=SetKeys_Loop
  $8436,$03 Stash the string counter and active keymap position on the stack.
  $8439,$03 #REGde=#N$50B5 (screen buffer location).
  $843C,$03 Call #R$8A3D.
  $843F,$01 Stash the messaging pointer on the stack.
  $8440,$03 Call #R$8479.
  $8443,$05 Call #R$8055 with a count of #N$05.
  $8448,$05 Read from the keyboard;
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $844D,$02,b$01 Set bits 5-7 (to fill in the extra bits).
  $844F,$04 Jump to #R$8459 if any of the keys have been pressed.
  $8453,$02 Rotate #REGb left (with carry).
  $8455,$02 Jump to #R$844B if #REGa is lower.
  $8457,$02 Jump to #R$8443.
  $8459,$01 Invert the bits in #REGa.
  $845A,$02,b$01 Keep only bits 0-4.
  $845C,$01 #REGe=#REGa.
  $845D,$01 RRA.
  $845E,$02 Jump to #R$845D if #REGa is higher.
  $8460,$04 Jump to #R$8440 if #REGa is not equal to #N$00.
  $8464,$03 Restore the messaging pointer and active keymap position from the stack.
  $8467,$09 Write the keymap data to the current active key.
  $8470,$05 Add #N($0003,$04,$04) to #REGix to move to the next key.
  $8475,$01 Restore the string counter from the stack.
  $8476,$02 Decrease the string counter by one and loop back to #R$8436 until
. all keys have been collected.
  $8478,$01 Return.

c $8479 Pause Check
@ $8479 label=PauseCheck
  $8479,$05 Call #R$8055 with a count of #N$01.
  $847E,$03 Call #R$848E.
  $8481,$02 Jump to #R$8479 if the carry flag is set.
N $8483 Repeat of the above.
  $8483,$05 Call #R$8055 with a count of #N$01.
  $8488,$03 Call #R$848E.
  $848B,$02 Jump to #R$8479 if the carry flag is set.
  $848D,$01 Return.
N $848E Check to see if the SHIFT, Z, X, C, and V keys are being held down.
@ $848E label=PauseCheck_Input
  $848E,$05 Read from the keyboard;
@ $8491 label=PauseCheck_Loop
. #TABLE(default,centre,centre,centre,centre,centre,centre)
. { =h,r2 Port Number | =h,c5 Bit }
. { =h 0 | =h 1 | =h 2 | =h 3 | =h 4 }
. { #N$FE | SHIFT | Z | X | C | V }
. TABLE#
  $8493,$02,b$01 Keep only bits 0-4.
  $8495,$03 Return if #REGa is not equal to #N$1F (which is ALL of the keys
. above - #EVAL($1F,$02,$08)).
  $8498,$02 Rotate #REGb left (with carry).
  $849A,$02 Jump to #R$8491 if #REGb has the carry flag set.
  $849C,$01 Return.

c $849D Initialise New Game
@ $849D label=Initialise_NewGame
N $849D Clears the 1UP/ 2UP game data for: #LIST { #R$8C30 } { #R$8C32 } { #R$8C35 } { #R$8C37 } LIST#
  $849D,$03 Start at #R$8C30 (stored in #REGhl), as the player name is retained
. (probably as it's a pain to enter!)
  $84A0,$02 Set a counter in #REGb for #N$08 bytes (#N$02 for location, #N$03
. for score, #N$02 for cash balance and #N$01 for player state).
N $84A2 Loop through the player variables and reset them all to #N$00#RAW(,) ready
. for the new game.
@ $84A2 label=Clear1UPStats_Loop
  $84A2,$02 Write #N$00 to *#REGhl.
  $84A4,$01 Increment #REGhl by one.
  $84A5,$02 Decrease counter by one and loop back to #R$84A2 until counter is zero.
N $84A7 Set the initial location for when the game starts.
  $84A7,$07 Write #R$8E82 to *#R$8C30.
N $84AE Set the starting cash amount.
  $84AE,$06 Write #N$0250 to *#R$8C35.
N $84B4 Copy all the same 1UP data to 2UP.
  $84B4,$0B Copy #N($0008,$04,$04) bytes of data from #R$8C30 to #R$8C40.
N $84BF Set the active player to 1UP.
  $84BF,$06 Write #R$8C28 to *#R$EFF2.
N $84C5 Set the 1UP default state (and also 2UP if this is a two player game).
  $84C5,$05 Write #EVAL($81,$02,$08) to *#R$8C37.
  $84CA,$06 Return if this is not a two player game.
  $84D0,$04 Write #EVAL($82,$02,$08) to *#R$8C47.
  $84D4,$01 Return.

c $84D5 Select 1 Or 2 Player Game
@ $84D5 label=Select1Or2PlayerGame
  $84D5,$03 Call #R$8A71.
N $84D8 Prints "#STR($8BC3)".
  $84D8,$03 #REGhl=#R$8BC3.
  $84DB,$03 #REGde=#N$504A (screen buffer location).
  $84DE,$03 Call #R$8A3D.
  $84E1,$03 #REGhl=#N$506A (screen buffer location).
  $84E4,$05 #R$8A37 the header with #N$10 character blocks of #N$FF.
N $84E9 Prints "#STR($8BD3)".
  $84E9,$03 #REGhl=#R$8BD3.
  $84EC,$03 #REGde=#N$50E7 (screen buffer location).
  $84EF,$03 Call #R$8A3D.
N $84F2 Get the 1UP players name.
  $84F2,$06 Write #R$8C28 to *#R$EFF2.
  $84F8,$03 Call #R$8548.
  $84FB,$05 Write #EVAL($00,$02,$08) to *#R$EFFB to set this as a 1UP only game.
N $8500 Prints "#STR($8BFE)".
  $8500,$03 #REGhl=#R$8BFE.
  $8503,$03 #REGde=#N$5088 (screen buffer location).
  $8506,$03 Call #R$8A3D.
  $8509,$03 Call #R$8519.
  $850C,$01 Return if this is only a 1 player game.
N $850D There is a 2UP player! Get their name and set *#R$EFFB accordingly.
  $850D,$03 Call #R$85CE.
  $8510,$03 Call #R$8548.
  $8513,$05 Write #EVAL($20,$02,$08) to *#R$EFFB to set this as a 2 player game.
  $8518,$01 Return.

c $8519 Select Yes/ No
@ $8519 label=Select_Yes/No
  $8519,$03 Call #R$8479.
N $851C Set up to print "#STR($8C10,$03)".
@ $851C label=Select_No
  $851C,$03 #REGhl=#R$8C10.
  $851F,$03 Call #R$852F.
  $8522,$02 Jump to #R$8526 if "Yes" was selected.
  $8524,$01 Set flags.
  $8525,$01 Return.
N $8526 Set up to print "#STR($8C23)".
@ $8526 label=Select_Yes
  $8526,$03 #REGhl=#R$8C23.
  $8529,$03 Call #R$852F.
  $852C,$02 Jump to #R$851C if "No" was selected".
  $852E,$01 Return.
N $852F Prints the current choice, and handles the player input.
@ $852F label=Select_GetInput
  $852F,$03 #REGde=#N$509B (screen buffer location).
  $8532,$03 Call #R$8A3D.
N $8535 Keep looping round until the player either chooses, or changes their
. choice.
@ $8535 label=Select_Yes/No_Loop
  $8535,$05 Call #R$8055 with a count of #N$0A.
  $853A,$03 Call #R$85E7.
  $853D,$01 #REGa=the control byte.
  $853E,$02,b$01 Keep only bits 3 ("down") and 5 ("fire").
  $8540,$03 Return if "down" was pressed.
  $8543,$04 Jump to #R$8535 if there was no input from the player.
  $8547,$01 Else, "fire" was pressed - just return.

c $8548 Player Name Input
@ $8548 label=PlayerNameInput
N $8548 Prints "#STR($8BE8,$05)".
  $8548,$03 #REGhl=#R$8BE8.
  $854B,$03 #REGde=#N$5088 (screen buffer location).
  $854E,$03 Call #R$8A3D.
N $8551 Prints the name of the current player.
  $8551,$03 #REGhl=*#R$EFF2.
  $8554,$03 #REGde=#N$5091 (screen buffer location).
  $8557,$03 Call #R$8A3D.
N $855A Draw an underline to show the "cursor".
  $855A,$03 #REGhl=#N$50B1 (screen buffer location).
  $855D,$02 Write #N$FF to *#REGhl.
  $855F,$01 Stash the cursor position on the stack.
  $8560,$04 Stash *#R$EFF2 on the stack.
  $8564,$03 Call #R$8479.
@ $8567 label=PlayerNameInput_Fire
  $8567,$02 #REGb=#N$0A.
@ $8569 label=PlayerNameInput_Loop
  $8569,$03 Call #R$8055.
  $856C,$03 Call #R$85E7.
  $856F,$05 Jump to #R$8597 if #REGe is equal to #N$18.
  $8574,$04 Jump to #R$85AB if #REGe is equal to #N$08.
  $8578,$04 Jump to #R$8567 if #REGe is not equal to #N$20.
  $857C,$02 Restore #REGhl and #REGde from the stack.
  $857E,$03 Write #N$00 to *#REGde.
  $8581,$03 Return if bit 7 of *#REGhl is set.
  $8584,$01 Increment #REGde by one.
  $8585,$01 Invert the bits in #REGa.
  $8586,$01 Write #REGa to *#REGde.
  $8587,$01 Stash #REGde on the stack.
  $8588,$01 Increment #REGhl by one.
  $8589,$01 Stash #REGhl on the stack.
  $858A,$03 #REGhl=*#R$EFF2.
  $858D,$03 #REGde=#N$5091 (screen buffer location).
  $8590,$03 Call #R$8A3D.
  $8593,$02 #REGb=#N$14.
  $8595,$02 Jump to #R$8569.
@ $8597 label=PlayerNameInput_Up
  $8597,$01 Restore #REGhl from the stack.
  $8598,$01 #REGa=*#REGhl.
  $8599,$02,b$01 Keep only bits 0-6.
  $859B,$02 Compare #REGa with #N$20.
  $859D,$02 #REGc=#N$41.
  $859F,$02 Jump to #R$85BD if #REGa is zero.
  $85A1,$02 Compare #REGa with #N$5A.
  $85A3,$02 #REGc=#N$20.
  $85A5,$02 Jump to #R$85BD if #REGa is zero.
  $85A7,$01 Increment #REGa by one.
  $85A8,$01 #REGc=#REGa.
  $85A9,$02 Jump to #R$85BD.
@ $85AB label=PlayerNameInput_Down
  $85AB,$01 Restore #REGhl from the stack.
  $85AC,$01 #REGa=*#REGhl.
  $85AD,$02,b$01 Keep only bits 0-6.
  $85AF,$02 Compare #REGa with #N$41.
  $85B1,$02 #REGc=#N$20.
  $85B3,$02 Jump to #R$85BD if #REGa is zero.
  $85B5,$02 Compare #REGa with #N$20.
  $85B7,$02 #REGc=#N$5A.
  $85B9,$02 Jump to #R$85BD if #REGa is zero.
  $85BB,$01 Decrease #REGa by one.
  $85BC,$01 #REGc=#REGa.
  $85BD,$02 #REGa=#N$80.
  $85BF,$01 Merge the bits from *#REGhl.
  $85C0,$01 Set the bits from #REGc.
  $85C1,$01 Write #REGa to *#REGhl.
  $85C2,$01 Stash #REGhl on the stack.
  $85C3,$03 #REGhl=*#R$EFF2.
  $85C6,$03 #REGde=#N$5091 (screen buffer location).
  $85C9,$03 Call #R$8A3D.
  $85CC,$02 Jump to #R$8567.

c $85CE Toggle Players
@ $85CE label=Toggle_Players
N $85CE Switch the active player.
  $85CE,$03 Store *#R$EFF2 in #REGhl for the comparison.
N $85D1 Start with comparing against 1UP.
  $85D1,$03 #REGde=#R$8C28.
  $85D4,$05 If the currently active player is not 1UP then jump to #R$85DC
. (which will then set it to 1UP).
N $85D9 Else, set the active player to 2UP.
  $85D9,$03 #REGde=#R$8C38.
N $85DC Sets the active player to *#R$EFF2.
@ $85DC label=Set_Active_Player
  $85DC,$04 Write #REGde to *#R$EFF2.
  $85E0,$04 Move #REGhl #N($000F,$04,$04) bytes to point to the active player state.
  $85E4,$02 Test bit 7 of *#REGhl.
  $85E6,$01 Return.

c $85E7 Handler: Controls
@ $85E7 label=Handler_Controls
N $85E7 #TABLE(default,centre,centre,centre)
. { =h Byte | =h Bits | =h Meaning }
. { #N$00 | #EVAL($00,$02,$08) | Right }
. { #N$08 | #EVAL($08,$02,$08) | Down }
. { #N$10 | #EVAL($10,$02,$08) | Left }
. { #N$18 | #EVAL($18,$02,$08) | Up }
. { #N$20 | #EVAL($20,$02,$08) | Fire }
. { #N$28 | #EVAL($28,$02,$08) | No input }
. TABLE#
R $85E7 O:E The control code
  $85E7,$02 #REGe=#N$00.
  $85E9,$03 #REGhl=#R$EFE0.
@ $85EC label=Handler_Controls_Loop
  $85EC,$01 Load the port into #REGc.
  $85ED,$01 Increment #REGhl by one.
  $85EE,$01 #REGb=*#REGhl.
  $85EF,$01 Increment #REGhl by one.
  $85F0,$01 #REGd=*#REGhl.
  $85F1,$01 Increment #REGhl by one.
  $85F2,$02 #REGa=byte from port held by *#REGc.
N $85F4 Self-modifying code. See; #R$840A, #R$840C and #R$8418.
@ $85F4 label=HandleControlBits
  $85F4,$01 Will be either "no operation" or "invert the bits".
  $85F5,$01 Merge the bits from #REGd.
  $85F6,$01 Return if the result is zero.
  $85F7,$04 #REGe+=#N$08.
  $85FB,$03 Return if there was no input.
  $85FE,$02 Jump to #R$85EC.

c $8600 Print Header
@ $8600 label=Print_Header
N $8600 #POPS #SIM(start=$8006,stop=$8020)#POKES($8C33,$10)
. #UDGTABLE { #SIM(start=$8026,stop=$8665)#SCR$02{$00,$00,$200,$20}(game-header) } UDGTABLE#
N $8600 Prints "#STR($8C48)".
  $8600,$03 #REGhl=#R$8C48.
  $8603,$03 #REGde=#N$4001 (screen buffer location).
  $8606,$03 Call #R$8A3D.
N $8609 Prints the name of the current player.
  $8609,$03 #REGhl=*#R$EFF2.
  $860C,$03 #REGde=#N$4011 (screen buffer location).
  $860F,$03 Call #R$8A3D.
N $8612 Prints the players score.
  $8612,$04 #REGhl+=#N($0004,$04,$04).
  $8616,$03 #REGde=#N$4021 (screen buffer location).
  $8619,$03 #REGbc=#N($0203,$04,$04).
  $861C,$03 Call #R$9712.
N $861F Prints "#STR($8C66)".
  $861F,$03 #REGhl=#R$8C66.
  $8622,$03 #REGde=#N$4029 (screen buffer location).
  $8625,$03 Call #R$8A3D.
N $8628 Prepare to fetch and print the location name.
  $8628,$04 #REGix=#R$EFF2.
  $862C,$03 #REGl=*#REGix+#N$08.
  $862F,$03 #REGh=*#REGix+#N$09.
  $8632,$02 Increment #REGhl by two.
  $8634,$01 #REGe=*#REGhl.
  $8635,$01 Increment #REGhl by one.
  $8636,$01 #REGd=*#REGhl.
  $8637,$04 Write #REGde to *#R$7805.
N $863B Point #REGhl to the location name, and print it.
  $863B,$04 #REGhl+=#N($000E,$04,$04).
  $863F,$03 #REGde=#N$402B (screen buffer location).
  $8642,$03 Call #R$8A3D.
  $8645,$02 #REGa=#N$3A.
  $8647,$01 #REGa-=#REGe.
  $8648,$02 Jump to #R$864F if #REGhl is zero.
  $864A,$01 Exchange the #REGde and #REGhl registers.
  $864B,$01 #REGc=#REGa.
  $864C,$03 Call #R$8A76.
N $864F Prints "#STR($8C26)".
@ $864F label=Print_CashRemaining
  $864F,$03 #REGde=#N$403A (screen buffer location).
  $8652,$03 #REGhl=#R$8C26.
  $8655,$03 Call #R$8A3D.
N $8658 Prints the amount of cash remaining for the active player.
  $8658,$03 #REGhl=*#R$EFF2.
  $865B,$04 #REGhl+=#N($000E,$04,$04).
  $865F,$03 #REGbc=#N($0202,$04,$04).
  $8662,$03 Call #R$9712.
  $8665,$01 Return.

c $8666 Choose Location Or Take Job
@ $8666 label=ChooseLocationOrTakeJob
N $8666 #PUSHS #UDGTABLE { #SIM(start=$8672,stop=$872A)#SCR$02(choose-location) } UDGTABLE# #POPS
  $8666,$05 Call #R$8055 with a count of #N$01.
  $866B,$07 Jump to #R$8666 if bit 0 ("Ticker On/ Off") of *#R$EFFB is set.
  $8672,$03 Call #R$8A61.
N $8675 Prints "#STR($8C68)".
  $8675,$03 #REGhl=#R$8C68.
  $8678,$03 #REGde=#N$504A (screen buffer location).
  $867B,$03 Call #R$8A3D.
  $867E,$03 #REGhl=#N$506A (screen buffer location).
  $8681,$05 #R$8A37 the header with #N$0B character blocks of #N$FF.
  $8686,$03 #REGhl=#N$5078 (screen buffer location).
  $8689,$05 #R$8A37 the header with #N$04 character blocks of #N$FF.
  $868E,$05 Initialise *#R$7811 to #N$80.
  $8693,$0A Loads the active players current location into #REGbc (using either
. *#R$8C30 or *#R$8C40).
  $869D,$01 Stash the active players current location on the stack.
  $869E,$06 Move the pointer in #REGix by #N($0002,$04,$04).
  $86A4,$06 Load the current locations map co-ordinates into #REGhl.
  $86AA,$03 Write the current locations map co-ordinates to *#R$7805.
N $86AD Prints each destination (and cost) to the screen.
  $86AD,$03 Set the increment value in #REGbc so #REGix will point to the first
. flight destination from where the player is located.
@ $86B0 label=PrintDestinations_Loop
  $86B0,$02 Move the pointer in #REGix by the increment value in #REGbc.
  $86B2,$06 Fetch the destination and store it in #REGhl.
  $86B8,$05 Jump to #R$86F9 if all destinations have been printed.
  $86BD,$04 Move the pointer in #REGhl to the destination name, the data before
. the name string is always #N($0011,$04,$04) bytes.
N $86C1 Load the screen position for printing into #REGde.
  $86C1,$02 #REGd=#N$50.
  $86C3,$03 #REGa=*#R$7811.
  $86C6,$02,b$01 Set bits 0 and 3.
  $86C8,$01 #REGe=#REGa.
N $86C9 Print the destination location name to the screen.
  $86C9,$03 Call #R$8A3D.
N $86CC Calculate where to print the cost.
  $86CC,$01 #REGa=#REGe.
  $86CD,$02,b$01 Keep only bits 5-7.
  $86CF,$02,b$01 Set bits 3-4.
  $86D1,$01 #REGe=#REGa.
  $86D2,$02,b$01 Keep only bits 5-7.
  $86D4,$02 #REGa+=#N$20.
  $86D6,$03 Write #REGa to *#R$7811.
  $86D9,$02 Stash #REGix on the stack.
  $86DB,$03 #REGhl=#REGix (using the stack).
  $86DE,$03 Move #REGhl to the last digit of the cost, ready for printing.
  $86E1,$03 Set the number format in #REGbc.
  $86E4,$03 Call #R$9712.
  $86E7,$02 Restore #REGix from the stack.
  $86E9,$05 Move the printing position in #REGde back to the start of the cost.
N $86EE Now print "#STR($8C26)".
  $86EE,$03 #REGhl=#R$8C26.
  $86F1,$03 Call #R$8A3D.
  $86F4,$03 Set the increment in #REGbc to point to the next destination.
  $86F7,$02 Jump to #R$86B0.
N $86F9 Now deduce if the current location has a playable game or not.
@ $86F9 label=AllDestinationsPrinted
  $86F9,$01 Restore the current location into #REGhl (from the stack).
  $86FA,$05 Move #REGhl to this locations "state" and load the state into #REGa.
  $86FF,$0B Jump to #R$870B if *#R$EFF2 is pointing to #R$8C28 (is this player
. one?)
N $870A This is player two, so shift the location state right through two
. positions.
  $870A,$01 Set the carry flag if 2UP has completed the sub-game at this
. location.
@ $870B label=ShiftLocationState
  $870B,$01 Set the carry flag if 1UP has completed the sub-game at this
. destination).
  $870C,$02 #REGb=#N$E0.
N $870E Decide which message to print; "#STR($8C7A)" or "#STR($8C87)".
  $870E,$03 #REGhl=#R$8C7A.
  $8711,$02 Jump to #R$8718 if the game at this location has already been
. completed.
  $8713,$02 #REGb=#N$00.
  $8715,$03 #REGhl=#R$8C87.
N $8718 Calculate where to print the messaging.
@ $8718 label=PrintJobMessaging
  $8718,$03 #REGa=*#R$7811.
  $871B,$02,b$01 Set bits 1 and 3.
  $871D,$01 #REGe=#REGa.
  $871E,$02 #REGd=#N$50.
  $8720,$02,b$01 Keep only bits 5-7.
  $8722,$01 #REGa+=#REGb.
  $8723,$03 Write #REGa to *#R$7811.
  $8726,$01 Stash #REGbc on the stack.
N $8727 Print either "#STR($8C7A)" or "#STR($8C87)" to the screen.
  $8727,$03 Call #R$8A3D.
  $872A,$01 Restore #REGaf from the stack.
  $872B,$03 Return if #REGa is equal to #N$00.
  $872E,$04 #REGix=#R$EFF2.
  $8732,$03 Call #R$894F.
  $8735,$01 Return if the player can afford the "cheapest" destination.
N $8736 The active player can't afford to fly anywhere.
  $8736,$04 Reset bit 7 of *#REGix+#N$0F.
  $873A,$05 Call #R$8055 with a count of #N$64.
  $873F,$03 Call #R$8A61.
  $8742,$03 Call #R$823B.
  $8745,$01 Restore #REGhl from the stack.
  $8746,$03 Jump to #R$8903.

c $8749 Handler: Location Choice
@ $8749 label=Handler_LocationChoice
  $8749,$03 #REGa=*#R$7811.
  $874C,$02,b$01 Set bit 3.
  $874E,$01 #REGc=#REGa.
  $874F,$05 Initialise *#R$7811 with #N$88.
  $8754,$01 Stash #REGbc on the stack.
  $8755,$03 Call #R$8830.
  $8758,$03 Call #R$8479.
N $875B Loop round until player input is detected.
@ $875B label=Handler_LocationChoice_InputLoop
  $875B,$05 Call #R$8055 with a count of #N$0A.
  $8760,$03 Call #R$85E7.
  $8763,$06 Jump to #R$87F8 if "up" was pressed.
  $8769,$05 Jump to #R$880F if "down" was pressed.
  $876E,$04 Jump to #R$875B if anything other than "fire" was pressed.
N $8772 Process the player pressing "fire".
  $8772,$04 #REGix=*#R$EFF2.
  $8776,$06 Fetch the players current location and store it in #REGhl.
  $877C,$03 Set the increment between destinations in #REGbc.
  $877F,$04 Set the selected position from *#R$7811 in #REGe.
  $8783,$02 Set the position of the top destination in #REGa.
N $8785 With the selected position being in #REGe, start with #REGa being the
. position of the top entry (#N$88) and check if the values match, if they
. don't - loop back round adding #N$20 to the checking value in #REGa until a
. a match is found (and the destination will be in #REGhl).
@ $8785 label=CalculateSelectedDestination_Loop
  $8785,$01 Move #REGhl to the next destination.
  $8786,$03 Jump to #R$878D if #REGa is equal to the selected position.
  $8789,$02 Move down one line.
  $878B,$02 Jump to #R$8785.
N $878D Destination has been found.
@ $878D label=FoundSelectedDestination
  $878D,$01 #REGc=*#REGhl.
  $878E,$01 Increment #REGhl by one.
  $878F,$06 Jump to #R$883C if *#REGhl is lower than #N$60.
  $8795,$01 #REGb=*#REGhl.
  $8796,$01 Increment #REGhl by one.
  $8797,$02 Stash the pointer to the cost on the stack.
  $8799,$02 Load the cost of this trip into #REGde.
  $879B,$06 Load the players cash balance into #REGhl.
  $87A1,$05 Jump to #R$87DF if the players cash balance is lower than the cost
. of this trip.
N $87A6 The player can afford the trip, so continue.
  $87A6,$06 Update the players current destination with the new destination.
  $87AC,$04 Move #REGhl to point to the co-ordinates of the destination.
  $87B0,$03 Load the map co-ordinates into #REGbc.
  $87B3,$04 Write the map co-ordinates to *#R$7807.
N $87B7 Spent the money on the air fare.
  $87B7,$08 Store a pointer to the players cash balance in #REGde.
  $87BF,$01 Restore the pointer to the cost of this trip from the stack into
. #REGhl.
  $87C0,$05 Call #R$96FE with #N$02 digits to process.
N $87C5 Print the updated cash balance to the screen.
  $87C5,$02 Decrease the cash balance pointer by one to point to the correct
. starting position (the print call moved it). Move this to #REGhl.
  $87C7,$03 #REGde=#N$403B (screen buffer location).
  $87CA,$03 #REGbc=#N($0202,$04,$04).
  $87CD,$03 Call #R$9712.
  $87D0,$01 Restore #REGhl from the stack (housekeeping, this is immediately
. thrown away).
  $87D1,$05 Set bit 7 ("Flying To New Destination") of *#R$EFFA.
  $87D6,$03 Call #R$823B.
  $87D9,$03 Call #R$8A61.
  $87DC,$03 Jump to #R$896C.
N $87DF Prints "#STR($8C10)#STR($8C13)#STR($8C1C)".
@ $87DF label=NotEnoughMoneyToFly
  $87DF,$01 Restore #REGde from the stack (housekeeping, this is immediately
. thrown away).
N $87E0 Prints "#STR($8C10)".
  $87E0,$03 #REGhl=#R$8C10.
  $87E3,$03 #REGde=#N$50A3 (screen buffer location).
  $87E6,$03 Call #R$8A3D.
N $87E9 Prints "#STR($8C13)".
  $87E9,$03 #REGde=#N$50C0 (screen buffer location).
  $87EC,$03 Call #R$8A3D.
N $87EF Prints "#STR($8C1C)".
  $87EF,$03 #REGde=#N$50E1 (screen buffer location).
  $87F2,$03 Call #R$8A3D.
  $87F5,$03 Jump to #R$875B.
N $87F8 Process the player pressing "up".
@ $87F8 label=ProcessLocationChoiceInput_Up
  $87F8,$03 Call #R$8824.
  $87FB,$01 Restore #REGbc from the stack.
  $87FC,$07 Jump to #R$8821 if *#R$7811 is equal to with #N$88.
  $8803,$02 #REGa-=#N$20.
@ $8805 label=UpdateDestinationChoice
  $8805,$03 Write #REGa to *#R$7811.
  $8808,$01 Stash #REGbc on the stack.
  $8809,$03 Call #R$8830.
  $880C,$03 Jump to #R$875B.
N $880F Process the player pressing "down".
@ $880F label=ProcessLocationChoiceInput_Down
  $880F,$03 Call #R$8824.
  $8812,$01 Restore #REGbc from the stack.
  $8813,$06 Jump to #R$881D if *#R$7811 is equal to #REGc.
  $8819,$02 #REGa+=#N$20.
  $881B,$02 Jump to #R$8805.
N $881D Set the cursor position back to the initial "top" choice.
@ $881D label=LocationChoice_BackToTop
  $881D,$02 #REGa=#N$88.
  $881F,$02 Jump to #R$8805.
N $8821
@ $8821 label=LocationChoice_MoveChoice
  $8821,$01 #REGa=#REGc.
  $8822,$02 Jump to #R$8805.

c $8824 Erase Arrow Symbol
@ $8824 label=Erase_ArrowSymbol
N $8824 Converts the value in *#R$7811 to a usable screen value and prints a
. "SPACE" over the current arrow symbol in that position.
  $8824,$06 Utilising *#R$7811 set the screen position for the space in #REGde.
  $882A,$03 Using the empty space/ terminator at the end of #R$8BB1, point
. #REGhl to #R$8BB1(#N$8BB9).
  $882D,$03 Jump to #R$8A3D.

c $8830 Print Arrow Symbol
@ $8830 label=Print_ArrowSymbol
N $8830 Converts the value in *#R$7811 to a usable screen value and prints an
. arrow symbol in that position.
  $8830,$06 Utilising *#R$7811 set the screen position for the arrow in #REGde.
  $8836,$03 #REGhl=#R$8C27.
  $8839,$03 Jump to #R$8A3D.

c $883C Handler: Sub-Game
@ $883C label=Handler_SubGame
  $883C,$01 Discard the last entry on the stack.
  $883D,$07 Loads a pointer to the current players score and cash balance into
. #REGhl. The active player reference is via *#R$EFF2.
  $8844,$08 Copy the #N($0005,$04,$04) bytes of data for the score and cash
. balance from *#REGhl to *#R$EFF4/ *#R$EFF7.
  $884C,$01 Exchange the #REGde and #REGhl registers.
  $884D,$02 Write #N$00 to *#REGhl.
  $884F,$05 Write #N$00 to *#R$EFFF.
  $8854,$03 Call #R$9052.
  $8857,$05 Write #N$01 to *#R$EFFF.
  $885C,$04 #REGix=#R$EFF2.
  $8860,$03 #REGa=*#R$EFF4.
  $8863,$03 Write #REGa to *#REGix+#N$0A.
  $8866,$03 #REGa=*#R$EFF5.
  $8869,$03 Write #REGa to *#REGix+#N$0B.
  $886C,$03 #REGa=*#R$EFF6.
  $886F,$03 Write #REGa to *#REGix+#N$0C.
M $8860,$12 Copy the three bytes of *#R$EFF4 to the current players score
. storage.
  $8872,$07 Loads a pointer to the current players cash balance into #REGhl.
  $8879,$03 #REGde=#R$EFF7.
  $887C,$05 Stash *#R$EFF7 on the stack.
  $8881,$02 #REGb=#N$02.
  $8883,$03 Call #R$96FE.
  $8886,$01 Restore #REGbc from the stack.
  $8887,$03 Write #REGc to *#REGix+#N$0D.
  $888A,$03 Write #REGb to *#REGix+#N$0E.
  $888D,$02 Jump to #R$88AB if #REGa is lower.
  $888F,$08 Jump to #R$88AB if *#R$EFF7 is zero.
  $8897,$04 #REGhl+=#R$FFFB.
  $889B,$03 #REGde=#R$EFF7.
  $889E,$01 Exchange the #REGde and #REGhl registers.
  $889F,$02 #REGb=#N$03.
  $88A1,$03 Call #R$9708.
  $88A4,$03 #REGhl=#R$EFFA.
  $88A7,$02 Set bit 1 ("Has Bonus Points?") of *#REGhl.
  $88A9,$02 Reset bit 0 of *#REGhl.
  $88AB,$03 #REGhl=#R$EFFA.
  $88AE,$02 Test bit 4 of *#REGhl.
  $88B0,$03 Call #R$894F zero.
  $88B3,$01 #REGa=*#REGhl.
  $88B4,$02,b$01 Keep only bits 2-5.
  $88B6,$02 Jump to #R$88CD if #REGa is zero.
  $88B8,$02,b$01 Keep only bits 2.
  $88BA,$02 Jump to #R$88C2 if #REGa is not zero.
  $88BC,$04 Reset bit 7 of *#REGix+#N$0F.
  $88C0,$02 Jump to #R$88FC.
  $88C2,$03 #REGbc=#R$8E82.
  $88C5,$03 Write #REGc to *#REGix+#N$08.
  $88C8,$03 Write #REGb to *#REGix+#N$09.
  $88CB,$02 Jump to #R$88FC.
  $88CD,$03 #REGa=*#REGix+#N$0F.
  $88D0,$02,b$01 Keep only bits 0-1.
  $88D2,$03 #REGl=*#REGix+#N$08.
  $88D5,$03 #REGh=*#REGix+#N$09.
  $88D8,$04 #REGhl+=#N($0010,$04,$04).
  $88DC,$01 #REGc=#REGa.
  $88DD,$01 Flip the bits according to *#REGhl.
  $88DE,$01 Write #REGa to *#REGhl.
  $88DF,$03 #REGhl=#R$8E92.
  $88E2,$03 #REGde=#N($0011,$04,$04).
  $88E5,$02 #REGb=#N$0E.
  $88E7,$01 #REGa=#REGc.
  $88E8,$01 Merge the bits from *#REGhl.
  $88E9,$02 Jump to #R$88FC if #REGa is zero.
  $88EB,$01 Increment #REGhl by one.
  $88EC,$02 Test bit 7 of *#REGhl.
  $88EE,$02 Jump to #R$88EB if #REGhl is zero.
  $88F0,$01 #REGhl+=#REGde.
  $88F1,$02 Decrease counter by one and loop back to #R$88E7 until counter is zero.
  $88F3,$03 #REGhl=#R$EFFA.
  $88F6,$02 Set bit 6 of *#REGhl.
  $88F8,$04 Reset bit 7 of *#REGix+#N$0F.
  $88FC,$01 Restore #REGhl from the stack.
  $88FD,$03 Call #R$8146.
  $8900,$03 Call #R$8600.
  $8903,$03 Call #R$823B.
  $8906,$05 Call #R$8055 with a count of #N$01.
  $890B,$03 #REGhl=#R$EFFB.
  $890E,$02 Test bit 0 ("Ticker On/ Off") of *#REGhl.
  $8910,$02 Jump to #R$8906 if #REGhl is not zero.
  $8912,$04 #REGix=#R$EFF2.
  $8916,$07 Call #R$8A84 if bit 7 of *#REGix+#N$0F is zero.
  $891D,$03 Call #R$85CE.
  $8920,$03 Jump to #R$802C if #REGhl is not zero.
  $8923,$03 Call #R$85CE.
  $8926,$03 Jump to #R$802C if #REGhl is not zero.
  $8929,$03 #REGhl=#R$EFFB.
  $892C,$02 Test bit 6 of *#REGhl.
  $892E,$03 Call #R$8AE1 zero.
  $8931,$03 Call #R$8A61.
N $8934 Prints "#STR($8E34)".
  $8934,$03 #REGhl=#R$8E34.
  $8937,$03 #REGde=#N$5069 (screen buffer location).
  $893A,$03 Call #R$8A3D.
N $893D Prints "#STR($8E45)".
  $893D,$03 #REGhl=#R$8E45.
  $8940,$03 #REGde=#N$5089 (screen buffer location).
  $8943,$03 Call #R$8A3D.
  $8946,$03 Call #R$8519.
  $8949,$03 Jump to #R$800F if #REGhl is lower.
  $894C,$03 Jump to #R$8026.

c $894F Afford To Fly Check
@ $894F label=Check_AffordToFly
R $894F IX The active player; either #R$8C28 or #R$8C38
  $894F,$06 Fetch the players current location and store it in #REGhl.
  $8955,$04 Move #REGhl by #N($0006,$04,$04) to point to the destination cost.
  $8959,$03 Load the cost of this destination into #REGde.
  $895C,$06 Loads the active players cash balance into #REGhl.
  $8962,$03 Subtract the cost of the destination from the active players cash
. balance.
  $8965,$04 Return if the player can afford the "cheapest" destination.
N $8969 Else, the player is stuck in their current destination. Set the flag
. for this.
  $8969,$02 Set bit 5 ("Can't Afford To Fly") of *#R$EFFA.
  $896B,$01 Return.

c $896C Calculate FlightPath
@ $896C label=CalculateFlightPath
  $896C,$03 #REGhl=*#R$7805.
  $896F,$04 #REGde=*#R$7807.
N $8973 Calculate X movement vector.
  $8973,$02 #REGa=current X - destination X.
  $8975,$02 Assume moving left (negative X direction).
  $8977,$03 If the result is positive, skip negation and jump to #R$897E.
  $897A,$02 Negate #REGa if it's negative.
  $897C,$02 Moving right (positive X direction).
@ $897E label=StoreAbsolute_X_Difference
  $897E,$01 Store absolute X difference in #REGc.
N $897F Calculate Y movement vector.
  $897F,$02 #REGa=current Y - destination Y.
  $8981,$02 Assume moving up (negative Y direction).
  $8983,$02 If result is non-negative, skip negation and jump to #R$8989.
  $8985,$02 Negate #REGa if it's negative.
  $8987,$02 Moving down (positive Y direction).
@ $8989 label=StoreAbsolute_Y_Difference
  $8989,$01 Store absolute Y difference in #REGb.
N $898A Store calculated vectors and flags.
  $898A,$04 Write #REGbc to *#R$7801.
  $898E,$04 Write #REGbc to *#R$7809.
  $8992,$04 Write #REGde to *#R$7803.
  $8996,$05 Set bit 1 ("Flightpath In-Progress") of *#R$EFFB.
  $899B,$01 Return.

c $899C Handler: Flight Path
@ $899C label=Handler_FlightPath
N $899C This routine uses Bresenham's line algorithm to plot a point between
. the source and destination co-ordinates to show Trashman travelling from one
. location to another.
  $899C,$02 #REGb=#N$01.
  $899E,$05 Set bit 0 of *#R$EFFF.
  $89A3,$03 Call #R$8055.
  $89A6,$03 #REGa=*#R$EFFC.
  $89A9,$02,b$01 Keep only bits 0-3.
  $89AB,$04 Jump to #R$899C if #REGa is not equal to #N$08.
  $89AF,$04 #REGbc=*#R$7801.
  $89B3,$04 #REGde=*#R$7803.
  $89B7,$03 #REGhl=*#R$7805.
  $89BA,$04 Compare #REGc and #REGb to determine the movement direction.
. Jump to #R$89D7 if #REGc is lower than #REGb.
N $89BE Handle movement in positive X direction.
  $89BE,$02 #REGc-=#REGb.
N $89C0 Move in Y direction.
  $89C0,$03 #REGl+=#REGe.
  $89C3,$04 Load *#R$780A into #REGb.
N $89C7 Compare with remaining X movement.
  $89C7,$03 Jump to #R$89F1 if *#R$780A is lower than #REGc.
  $89CA,$02 Adjust Y co-ordinate.
  $89CC,$04 Load *#R$7809 into #REGc.
  $89D0,$05 Adjust X co-ordinate.
  $89D5,$02 Jump to #R$89F1.
N $89D7 Handle movement in negative X direction.
@ $89D7 label=FlightPath_NegativeDirection
  $89D7,$03 #REGb-=#REGc (remaining X movement).
  $89DA,$03 Move in Y direction.
  $89DD,$04 Load *#R$7809 into #REGc.
  $89E1,$03 Jump to #R$89F1 if #REGc is lower than #REGb.
  $89E4,$02 Adjust Y co-ordinate.
  $89E6,$04 Load *#R$780A into #REGb.
  $89EA,$05 Adjust X co-ordinate.
  $89EF,$02 Jump to #R$89F1.
N $89F1 Update position and check if destination reached.
@ $89F1 label=FlightPath_CheckArrived
  $89F1,$03 Write new X/ Y co-ordinates to *#R$7805.
  $89F4,$04 Write updated movement vector to *#R$7801.
  $89F8,$07 Compare current position with destination.
  $89FF,$02 Jump to #R$899C until destination is reached.
  $8A01,$05 Reset bit 1 ("Flightpath Complete") of *#R$EFFB.
  $8A06,$01 Return.

c $8A07 Toggle Map Point
@ $8A07 label=ToggleMapPoint
R $8A07 HL Map co-ordinates
  $8A07,$01 #REGa=#REGl.
  $8A08,$02,b$01 Keep only bits 0-2.
  $8A0A,$01 #REGb=#REGa.
  $8A0B,$02 #REGa=#N$80.
  $8A0D,$02 Jump to #R$8A12 if #REGa is zero.
  $8A0F,$01 RRCA.
  $8A10,$02 Decrease counter by one and loop back to #R$8A0F until counter is zero.
  $8A12,$01 #REGe=#REGa.
  $8A13,$01 #REGa=#REGh.
  $8A14,$02,b$01 Keep only bits 0-2.
  $8A16,$01 #REGd=#REGa.
  $8A17,$06 Rotate #REGh right three positions (with carry).
  $8A1D,$01 #REGa=#REGh.
  $8A1E,$02,b$01 Keep only bits 3-4.
  $8A20,$02,b$01 Set bits 6.
  $8A22,$01 Set the bits from #REGd.
  $8A23,$02 Rotate #REGh right.
  $8A25,$02 Rotate #REGl right.
  $8A27,$02 Rotate #REGh right.
  $8A29,$02 Rotate #REGl right.
  $8A2B,$02 Rotate #REGh right.
  $8A2D,$02 Rotate #REGl right.
  $8A2F,$01 #REGh=#REGa.
  $8A30,$01 #REGa=*#REGhl.
  $8A31,$01 Flip the bits according to #REGe.
  $8A32,$01 Write #REGa to *#REGhl.
  $8A33,$02 #REGa=#N$00.
  $8A35,$01 Increment #REGa by one.
  $8A36,$01 Return.

c $8A37 Underline
@ $8A37 label=Underline
R $8A37 B Number of locations to write #N$FF to
R $8A37 HL Screen buffer address
  $8A37,$02 Write #N$FF to *#REGhl.
  $8A39,$01 Increment #REGhl by one.
  $8A3A,$02 Decrease counter by one and loop back to #R$8A37 until counter is zero.
  $8A3C,$01 Return.

c $8A3D Print String
@ $8A3D label=Print_String
R $8A3D HL Pointer to string
R $8A3D DE Screen buffer location
  $8A3D,$01 Fetch a character from the string pointer and store it in #REGa.
  $8A3E,$01 Stash the string pointer on the stack.
  $8A3F,$02,b$01 Strip off the termination bit.
N $8A41 Fetch the font UDG for the current character.
  $8A41,$03 Create an offset in #REGhl.
  $8A44,$03 Letter UDGs are #N$08 bytes, so multiply #REGhl by #N$08.
  $8A47,$04 Add #R$F840 to #REGhl to reference the UDG for the current letter
. in the string.
N $8A4B Now print it to the screen buffer.
  $8A4B,$03 Call #R$8A56.
  $8A4E,$01 Restore the string pointer from the stack.
  $8A4F,$01 Increment the screen buffer pointer by one.
  $8A50,$02 Test for the termination bit in the current letter *#REGhl.
  $8A52,$01 Increment the string pointer by one.
  $8A53,$02 Jump to #R$8A3D until the terminator bit is found.
  $8A55,$01 Return.
N $8A56 Printing routine.
@ $8A56 label=Print_Character
  $8A56,$02 Set a counter in #REGb of #N$08, for the number of bytes in a
. letter UDG.
  $8A58,$01 Stash the screen buffer pointer on the stack.
@ $8A59 label=Print_Character_Loop
  $8A59,$01 Fetch the letter UDG byte from *#REGhl...
  $8A5A,$01 ...and write it to the screen buffer using the position stored in
. *#REGde.
  $8A5B,$01 Increment the string pointer by one.
  $8A5C,$01 Move right one byte to the next screen buffer position.
  $8A5D,$02 Decrease the UDG byte counter by one and loop back to #R$8A59 until
. the letter has been printed to the screen.
  $8A5F,$01 Restore the screen buffer pointer from the stack.
  $8A60,$01 Return.

c $8A61 Clear Menu Screen Areas
@ $8A61 label=ClearMenuScreenAreas
N $8A61 #PUSHS #FOR$4000,$57FF||n|#POKESn,$FF||#FOR$5800,$5AFF||n|#POKESn,$47||
. #SIM(start=$800F,stop=$8012)
. #UDGTABLE { #SCR$02(clear-screen-01) } UDGTABLE#
. #POPS
  $8A61,$03 #REGhl=#N$5049 (screen buffer location).
  $8A64,$02 #REGc=#N$13.
  $8A66,$03 Call #R$8A76.
  $8A69,$03 #REGhl=#N$5069 (screen buffer location).
  $8A6C,$02 #REGc=#N$13.
  $8A6E,$03 Call #R$8A76.
N $8A71 #PUSHS #FOR$4000,$57FF||n|#POKESn,$FF||#FOR$5800,$5AFF||n|#POKESn,$47||
. #SIM(start=$8A71,stop=$8A83)
. #UDGTABLE { #SCR$02(clear-screen-02) } UDGTABLE#
. #POPS
@ $8A71 label=ClearBottomScreenArea
  $8A71,$03 #REGhl=#N$5088 (screen buffer location).
  $8A74,$02 #REGc=#N$77.
@ $8A76 label=ClearScreenArea
  $8A76,$02 #REGb=#N$08.
  $8A78,$01 Stash #REGhl on the stack.
@ $8A79 label=ClearScreenArea_Loop
  $8A79,$02 Write #N$00 to *#REGhl.
  $8A7B,$01 Increment #REGh by one.
  $8A7C,$02 Decrease counter by one and loop back to #R$8A79 until counter is zero.
  $8A7E,$01 Restore #REGhl from the stack.
  $8A7F,$01 Increment #REGhl by one.
  $8A80,$01 Decrease #REGc by one.
  $8A81,$02 Jump to #R$8A76 until #REGc is zero.
  $8A83,$01 Return.

c $8A84 High Score Table
@ $8A84 label=HighScoreTable
N $8A84 #PUSHS
. #POKES$8E08,$50;$8E09,$4F;$8E0A,$42;$8E11,$02
. #POKES$8E13,$52;$8E14,$41;$8E15,$4E;$8E1C,$01
. #UDGTABLE { #SIM(start=$8AE1,stop=$8B1B)#SCR$02(high-scores) } UDGTABLE# #POPS
  $8A84,$02 #REGb=#N$04.
  $8A86,$04 #REGix=#R$8E08.
  $8A8A,$03 #REGhl=*#R$EFF2.
  $8A8D,$04 #REGhl+=#N($000C,$04,$04).
  $8A91,$06 Jump to #R$8AA4 if *#REGhl is higher than *#REGix+#N$0A.
  $8A97,$05 #REGix+=#N($000B,$04,$04).
  $8A9C,$02 Decrease counter by one and loop back to #R$8A8A until counter is zero.
  $8A9E,$03 #REGhl=#R$EFFB.
  $8AA1,$02 Reset bit 6 of *#REGhl.
  $8AA3,$01 Return.

  $8AA4,$02 Jump to #R$8AB8 if  is not zero.
  $8AA6,$01 Decrease #REGhl by one.
  $8AA7,$06 Jump to #R$8A97 if *#REGhl is lower than *#REGix+#N$09.
  $8AAD,$02 Jump to #R$8AB8 if *#REGhl is not equal to *#REGix+#N$09.
  $8AAF,$01 Decrease #REGhl by one.
  $8AB0,$06 Jump to #R$8A97 if *#REGhl is lower than *#REGix+#N$08.
  $8AB6,$02 Jump to #R$8A97 if *#REGhl is equal to *#REGix+#N$08.
  $8AB8,$01 Decrease #REGb by one.
  $8AB9,$02 Jump to #R$8ACA if #REGb is zero.
  $8ABB,$02 #REGa=#N$00.
  $8ABD,$02 #REGa+=#N$0B.
  $8ABF,$02 Decrease counter by one and loop back to #R$8ABD until counter is zero.
  $8AC1,$01 #REGc=#REGa.
  $8AC2,$03 #REGhl=#R$8E1E(#N$8E28).
  $8AC5,$03 #REGde=#R$8E29(#N$8E33).
  $8AC8,$02 LDDR.
  $8ACA,$03 #REGde=#REGix (using the stack).
  $8ACD,$03 #REGhl=*#R$EFF2.
  $8AD0,$03 #REGbc=#N($0008,$04,$04).
  $8AD3,$02 LDIR.
  $8AD5,$02 Increment #REGhl by two.
  $8AD7,$03 #REGbc=#N($0003,$04,$04).
  $8ADA,$02 LDIR.
  $8ADC,$03 #REGhl=#R$EFFB.
  $8ADF,$02 Set bit 6 of *#REGhl.
  $8AE1,$03 Call #R$8A61.
N $8AE4 Prints "#STR($8DF9)".
  $8AE4,$03 #REGhl=#R$8DF9.
  $8AE7,$03 #REGde=#N$5049 (screen buffer location).
  $8AEA,$03 Call #R$8A3D.
  $8AED,$03 #REGhl=#N$5069 (screen buffer location).
  $8AF0,$05 #R$8A37 the header with #N$0F character blocks of #N$FF.
  $8AF5,$02 #REGb=#N$04.
N $8AF7 Cycle through each high score and print the details.
  $8AF7,$03 #REGhl=#R$8E08.
  $8AFA,$03 #REGde=#N$5089 (screen buffer location).
@ $8AFD label=PrintHighScore_Loop
  $8AFD,$03 Stash #REGbc, #REGhl and #REGde on the stack.
  $8B00,$03 Call #R$8A3D.
  $8B03,$02 Increment #REGde by two.
  $8B05,$02 Increment #REGhl by two.
  $8B07,$03 #REGbc=#N($0203,$04,$04).
  $8B0A,$03 Call #R$9712.
  $8B0D,$01 Restore #REGde from the stack.
  $8B0E,$05 #REGde+=#N($0020,$04,$04).
  $8B13,$01 Restore #REGhl from the stack.
  $8B14,$04 #REGhl+=#N($000B,$04,$04).
  $8B18,$01 Restore #REGbc from the stack.
  $8B19,$02 Decrease counter by one and loop back to #R$8AFD until counter is zero.
  $8B1B,$05 Call #R$8055 with a count of #N$64.
  $8B20,$03 Call #R$8479.
  $8B23,$05 Call #R$8055 with a count of #N$01.
  $8B28,$03 Call #R$85E7.
  $8B2B,$05 Jump to #R$8B23 if #REGe is not equal to #N$20.
  $8B30,$01 Return.

t $8B31 Messaging: Menu
@ $8B31 label=Messaging_SelectControls
N $8B31 Used by the routine at #R$83AA.
  $8B31,$0F,$0E:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(select-01)
@ $8B40 label=Messaging_UserDefinedKeys
  $8B40,$13,$12:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(select-02)
@ $8B53 label=Messaging_KempstonJoystick
  $8B53,$13,$12:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(select-03)
@ $8B66 label=Messaging_Interface2
  $8B66,$0D,$0C:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(select-04)
@ $8B73 label=Messaging_CursorKeys
  $8B73,$15,$14:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(select-05)

t $8B88 Messaging: Redefine Keys
@ $8B88 label=Messaging_PleaseSelectKeys
N $8B88 Used by the routine at #R$83AA.
  $8B88,$0E,$0D:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-01)
@ $8B96 label=Messaging_RedefineKeys_Right
  $8B96,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-02)
@ $8B9F label=Messaging_RedefineKeys_Down
  $8B9F,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-03)
@ $8BA8 label=Messaging_RedefineKeys_Left
  $8BA8,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-04)
@ $8BB1 label=Messaging_RedefineKeys_Up
  $8BB1,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-05)
@ $8BBA label=Messaging_RedefineKeys_Fire
  $8BBA,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(redefine-keys-06)

t $8BC3 Messaging: Visa Application
@ $8BC3 label=Messaging_VisaApplication
N $8BC3 Used by the routine at #R$84D5.
  $8BC3,$10,$0F:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(visa-application-01)
@ $8BD3 label=Messaging_FormNo
  $8BD3,$15,$14:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(visa-application-02)
N $8BE8 Used by the routine at #R$8548.
@ $8BE8 label=Messaging_Name
  $8BE8,$16,$15:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(visa-application-03)
N $8BFE Used by the routine at #R$84D5.
@ $8BFE label=Messaging_AnotherForm
  $8BFE,$12,$11:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(visa-application-04)

t $8C10 Messaging: No
@ $8C10 label=Messaging_No
  $8C10,$03,$02:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(no)

t $8C13 Messaging: Discounts
@ $8C13 label=Messaging_Discounts
  $8C13,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(discounts)

t $8C1C Messaging: Allowed
@ $8C1C label=Messaging_Allowed
  $8C1C,$07,$06:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(allowed)

t $8C23 Messaging: Yes
@ $8C23 label=Messaging_Yes
  $8C23,$03,$02:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(yes)

t $8C26 Messaging: Pound Symbol
@ $8C26 label=Messaging_£
  $8C26,$01 #FONT:(`)$F840,attr=$4E(pound)

t $8C27 Messaging: Arrow Symbol
@ $8C27 label=Messaging_Arrow
  $8C27,$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(arrow)

t $8C28 1UP/ 2UP Player Details
@ $8C28 label=1UP_Name
N $8C28 See #POKE#9999(£9999).
N $8C28 1UP variables.
  $8C28,$08 1UP Player name.
@ $8C30 label=1UP_Location
W $8C30,$02 1UP Location pointer.
@ $8C32 label=1UP_Score
B $8C32,$03 1UP Score.
@ $8C35 label=1UP_Cash
  $8C35,$02 1UP Cash.
@ $8C37 label=1UP_State
B $8C37,$01 1UP State.
N $8C38 2UP variables.
@ $8C38 label=2UP_Name
  $8C38,$08 2UP Player name.
@ $8C40 label=2UP_Location
W $8C40,$02 2UP Location pointer.
@ $8C42 label=2UP_Score
B $8C42,$03 2UP Score.
@ $8C45 label=2UP_Cash
  $8C45,$02 2UP Cash.
@ $8C47 label=2UP_State
B $8C47,$01 2UP State.

t $8C48 Messaging: Header
@ $8C48 label=Messaging_Header
  $8C48,$1E,$1D:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(header)

t $8C66 Messaging: In
@ $8C66 label=Messaging_In
  $8C66,$02,$01:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(in)

t $8C68 Messaging: Travel Header
@ $8C68 label=Messaging_TravelHeader
  $8C68,$12,$11:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(travel-header)

t $8C7A Messaging: Job Complete
@ $8C7A label=Messaging_JobComplete
  $8C7A,$0D,$0C:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(job-complete)

t $8C87 Messaging: Accept Job Offered
@ $8C87 label=Messaging_AcceptJobOffered
  $8C87,$12,$11:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(accept-job)

t $8C99 Messaging: Stop Press
@ $8C99 label=Messaging_StopPress
  $8C99,$21,$20:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(stop-press)

t $8CBA Messaging: Flies To
@ $8CBA label=Messaging_FliesTo
  $8CBA,$09,$08:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(flies-to)

t $8CC3 Messaging: Stranded In
@ $8CC3 label=Messaging_StrandedIn
  $8CC3,$0D,$0C:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(stranded-in)

t $8CD0 Messaging: Penniless
@ $8CD0 label=Messaging_Penniless
  $8CD0,$0C,$0B:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(penniless)

t $8CDC Messaging: Without Fare Home
@ $8CDC label=Messaging_WithoutFareHome
  $8CDC,$14,$13:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(without-fare-home)

t $8CF0 Messaging: Deported Russia
@ $8CF0 label=Messaging_DeportedRussia
  $8CF0,$27,$26:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(deported-russia)

t $8D17 Messaging: Denies Smuggling
@ $8D17 label=Messaging_DeniesSmuggling
  $8D17,$19,$18:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(denies-smuggling)

t $8D30 Messaging: Killed In Spain
@ $8D30 label=Messaging_KilledInSpain
  $8D30,$25,$24:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(killed-in-spain)

t $8D55 Messaging: His
@ $8D55 label=Messaging_His
  $8D55,$05,$04:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(his)

t $8D5A Messaging: Flown Back To UK
@ $8D5A label=Messaging_FlownBackToUK
  $8D5A,$31,$30:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(flown-back-to-uk)

t $8D8B Messaging: Successful Clean Up
@ $8D8B label=Messaging_SuccessfulCleanUp
  $8D8B,$18,$17:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(successful-clean-up)

t $8DA3 Messaging: Full Stop
@ $8DA3 label=Messaging_FullStop
  $8DA3,$02,$01:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(full-stop)

t $8DA5 Messaging: And Gains
@ $8DA5 label=Messaging_AndGains
  $8DA5,$0C,$0B:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(and-gains)

t $8DB1 Messaging: Bonus Pts
@ $8DB1 label=Messaging_BonusPts
  $8DB1,$0B,$0A:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(bonus-pts)

t $8DBC Messaging: Game Complete
@ $8DBC label=Messaging_GameComplete
  $8DBC,$3D,$3C:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(game-complete)

t $8DF9 Messaging: Famous Trashmen
@ $8DF9 label=Messaging_FamousTrashmen
  $8DF9,$0F,$0E:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(famous-trashmen)

t $8E08 Messaging: High Scores
@ $8E08 label=Messaging_HighScores
N $8E08 High score position: #N($01+(#PC-$8E08)/$0B).
  $8E08,$08 Name.
B $8E10,$03 Score.
L $8E08,$0B,$04

t $8E34 Messaging: Change Controls
@ $8E34 label=Messaging_ChangeControls
  $8E34,$11,$10:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(change-controls)

t $8E45 Messaging: Change Players
@ $8E45 label=Messaging_ChangePlayers
  $8E45,$10,$0F:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(change-players)

b $8E55 Key Map: Kempston Joystick
@ $8E55 label=KeyMap_Kempston
N $8E55 Right.
N $8E58 Down.
N $8E5B Left.
N $8E5E Up.
N $8E61 Fire.
  $8E55,$01 Port.
  $8E56,$02
L $8E55,$03,$05,$02

b $8E64 Key Map: Interface 2 Joystick
@ $8E64 label=KeyMap_Interface2
  $8E64,$01 Port.
  $8E65,$02
L $8E64,$03,$05,$02

b $8E73 Key Map: Cursor Keys
@ $8E73 label=KeyMap_CursorKeys
  $8E73,$01 Port.
  $8E74,$02
L $8E73,$03,$05,$02

b $8E82 Table: Locations
@ $8E82 label=London_Location
N $8E82 Location #N$01: London (not a "real" location).
W $8E82,$02 Data: #N((#PEEK(#PC+$01)*$0100)+#PEEK(#PC),$04,$04) (not a level).
@ $8E84 label=London_MapCoordinates
  $8E84,$02 Map co-ordinates.
@ $8E86 label=London_Destinations_1
W $8E86,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8E88,$02 Cost: "#MONEY".
@ $8E8A label=London_Destinations_2
W $8E8A,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8E8C,$02 Cost: "#MONEY".
@ $8E8E label=London_Destinations_3
W $8E8E,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8E90,$02 Cost: "#MONEY".
@ $8E92 label=London_State
  $8E92,$01 State: #STATE(#PEEK(#PC)).
@ $8E93 label=London_Name
T $8E93,$07,$06:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-london)

N $8E9A Location #N$02: Madrid.
@ $8E9A label=Madrid_Location
W $8E9A,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8E9C label=Madrid_MapCoordinates
  $8E9C,$02 Map co-ordinates.
@ $8E9E label=Madrid_Destinations_1
W $8E9E,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EA0,$02 Cost: "#MONEY".
@ $8EA2 label=Madrid_Destinations_2
W $8EA2,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EA4,$02 Cost: "#MONEY".
@ $8EA6 label=Madrid_Destinations_3
W $8EA6,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EA8,$02 Cost: "#MONEY".
@ $8EAA label=Madrid_State
  $8EAA,$01 State: #STATE(#PEEK(#PC)).
@ $8EAB label=Madrid_Name
T $8EAB,$07,$06:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-madrid)

N $8EB2 Location #N$03: Paris.
@ $8EB2 label=Paris_Location
W $8EB2,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8EB4 label=Paris_MapCoordinates
  $8EB4,$02 Map co-ordinates.
@ $8EB6 label=Paris_Destinations_1
W $8EB6,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EB8,$02 Cost: "#MONEY".
@ $8EBA label=Paris_Destinations_2
W $8EBA,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EBC,$02 Cost: "#MONEY".
@ $8EBE label=Paris_Destinations_3
W $8EBE,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EC0,$02 Cost: "#MONEY".
@ $8EC2 label=Paris_State
  $8EC2,$01 State: #STATE(#PEEK(#PC)).
@ $8EC3 label=Paris_Name
T $8EC3,$06,$05:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-paris)

N $8EC9 Location #N$04: Munich.
@ $8EC9 label=Munich_Location
W $8EC9,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8ECB label=Munich_MapCoordinates
  $8ECB,$02 Map co-ordinates.
@ $8ECD label=Munich_Destinations_1
W $8ECD,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8ECF,$02 Cost: "#MONEY".
@ $8ED1 label=Munich_Destinations_2
W $8ED1,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8ED3,$02 Cost: "#MONEY".
@ $8ED5 label=Munich_Destinations_3
W $8ED5,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8ED7,$02 Cost: "#MONEY".
@ $8ED9 label=Munich_State
  $8ED9,$01 State: #STATE(#PEEK(#PC)).
@ $8EDA label=Munich_Name
T $8EDA,$07,$06:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-munich)

N $8EE1 Location #N$05: Moscow.
@ $8EE1 label=Moscow_Location
W $8EE1,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8EE3 label=Moscow_MapCoordinates
  $8EE3,$02 Map co-ordinates.
@ $8EE5 label=Moscow_Destinations_1
W $8EE5,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EE7,$02 Cost: "#MONEY".
@ $8EE9 label=Moscow_Destinations_2
W $8EE9,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EEB,$02 Cost: "#MONEY".
@ $8EED label=Moscow_Destinations_3
W $8EED,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EEF,$02 Cost: "#MONEY".
@ $8EF1 label=Moscow_State
  $8EF1,$01 State: #STATE(#PEEK(#PC)).
@ $8EF2 label=Moscow_Name
T $8EF2,$07,$06:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-moscow)

N $8EF9 Location #N$06: Jerusalem.
@ $8EF9 label=Jerusalem_Location
W $8EF9,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8EFB label=Jerusalem_MapCoordinates
  $8EFB,$02 Map co-ordinates.
@ $8EFD label=Jerusalem_Destinations_1
W $8EFD,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8EFF,$02 Cost: "#MONEY".
@ $8F01 label=Jerusalem_Destinations_2
W $8F01,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F03,$02 Cost: "#MONEY".
@ $8F05 label=Jerusalem_Destinations_3
W $8F05,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F07,$02 Cost: "#MONEY".
@ $8F09 label=Jerusalem_State
  $8F09,$01 State: #STATE(#PEEK(#PC)).
@ $8F0A label=Jerusalem_Name
T $8F0A,$0A,$09:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-jerusalem)

N $8F14 Location #N$07: Benares.
@ $8F14 label=Benares_Location
W $8F14,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F16 label=Benares_MapCoordinates
  $8F16,$02 Map co-ordinates.
@ $8F18 label=Benares_Destinations_1
W $8F18,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F1A,$02 Cost: "#MONEY".
@ $8F1C label=Benares_Destinations_2
W $8F1C,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F1E,$02 Cost: "#MONEY".
@ $8F20 label=Benares_Destinations_3
W $8F20,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F22,$02 Cost: "#MONEY".
@ $8F24 label=Benares_State
  $8F24,$01 State: #STATE(#PEEK(#PC)).
@ $8F25 label=Benares_Name
T $8F25,$08,$07:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-benares)

N $8F2D Location #N$08: Hong Kong.
@ $8F2D label=HongKong_Location
W $8F2D,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F2F label=HongKong_MapCoordinates
  $8F2F,$02 Map co-ordinates.
@ $8F31 label=HongKong_Destinations_1
W $8F31,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F33,$02 Cost: "#MONEY".
@ $8F35 label=HongKong_Destinations_2
W $8F35,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F37,$02 Cost: "#MONEY".
@ $8F39 label=HongKong_Destinations_3
W $8F39,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F3B,$02 Cost: "#MONEY".
@ $8F3D label=HongKong_State
  $8F3D,$01 State: #STATE(#PEEK(#PC)).
@ $8F3E label=HongKong_Name
T $8F3E,$0A,$09:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-hong-kong)

N $8F48 Location #N$09: Alice Springs.
@ $8F48 label=AliceSprings_Location
W $8F48,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F4A label=AliceSprings_MapCoordinates
  $8F4A,$02 Map co-ordinates.
@ $8F4C label=AliceSprings_Destinations_1
W $8F4C,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F4E,$02 Cost: "#MONEY".
@ $8F50 label=AliceSprings_Destinations_2
W $8F50,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F52,$02 Cost: "#MONEY".
@ $8F54 label=AliceSprings_Destinations_3
W $8F54,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F56,$02 Cost: "#MONEY".
@ $8F58 label=AliceSprings_State
  $8F58,$01 State: #STATE(#PEEK(#PC)).
@ $8F59 label=AliceSprings_Name
T $8F59,$0E,$0D:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-alice-springs)

N $8F67 Location #N$0A: Samoa.
@ $8F67 label=Samoa_Location
W $8F67,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F69 label=Samoa_MapCoordinates
  $8F69,$02 Map co-ordinates.
@ $8F6B label=Samoa_Destinations_1
W $8F6B,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F6D,$02 Cost: "#MONEY".
@ $8F6F label=Samoa_Destinations_2
W $8F6F,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F71,$02 Cost: "#MONEY".
@ $8F73 label=Samoa_Destinations_3
W $8F73,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F75,$02 Cost: "#MONEY".
@ $8F77 label=Samoa_State
  $8F77,$01 State: #STATE(#PEEK(#PC)).
@ $8F78 label=Samoa_Name
T $8F78,$06,$05:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-samoa)

N $8F7E Location #N$0B: Chichen Itza.
@ $8F7E label=ChichenItza_Location
W $8F7E,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F80 label=ChichenItza_MapCoordinates
  $8F80,$02 Map co-ordinates.
@ $8F82 label=ChichenItza_Destinations_1
W $8F82,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F84,$02 Cost: "#MONEY".
@ $8F86 label=ChichenItza_Destinations_2
W $8F86,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F88,$02 Cost: "#MONEY".
@ $8F8A label=ChichenItza_Destinations_3
W $8F8A,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8F8C,$02 Cost: "#MONEY".
@ $8F8E label=ChichenItza_State
  $8F8E,$01 State: #STATE(#PEEK(#PC)).
@ $8F8F label=ChichenItza_Name
T $8F8F,$0D,$0C:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-chichen-itza)

N $8F9C Location #N$0C: New Orleans.
@ $8F9C label=NewOrleans_Location
W $8F9C,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8F9E label=NewOrleans_MapCoordinates
  $8F9E,$02 Map co-ordinates.
@ $8FA0 label=NewOrleans_Destinations_1
W $8FA0,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FA2,$02 Cost: "#MONEY".
@ $8FA4 label=NewOrleans_Destinations_2
W $8FA4,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FA6,$02 Cost: "#MONEY".
@ $8FA8 label=NewOrleans_Destinations_3
W $8FA8,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FAA,$02 Cost: "#MONEY".
@ $8FAC label=NewOrleans_State
  $8FAC,$01 State: #STATE(#PEEK(#PC)).
@ $8FAD label=NewOrleans_Name
T $8FAD,$0C,$0B:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-new-orleans)

N $8FB9 Location #N$0D: Kanyu.
@ $8FB9 label=Kanyu_Location
W $8FB9,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8FBB label=Kanyu_MapCoordinates
  $8FBB,$02 Map co-ordinates.
@ $8FBD label=Kanyu_Destinations_1
W $8FBD,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FBF,$02 Cost: "#MONEY".
@ $8FC1 label=Kanyu_Destinations_2
W $8FC1,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FC3,$02 Cost: "#MONEY".
@ $8FC5 label=Kanyu_Destinations_3
W $8FC5,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FC7,$02 Cost: "#MONEY".
@ $8FC9 label=Kanyu_State
  $8FC9,$01 State: #STATE(#PEEK(#PC)).
@ $8FCA label=Kanyu_Name
T $8FCA,$06,$05:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-kanyu)

N $8FD0 Location #N$0E: Sao Paulo.
@ $8FD0 label=SaoPaulo_Location
W $8FD0,$02 Data: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
@ $8FD2 label=SaoPaulo_MapCoordinates
  $8FD2,$02 Map co-ordinates.
@ $8FD4 label=SaoPaulo_Destinations_1
W $8FD4,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FD6,$02 Cost: "#MONEY".
@ $8FD8 label=SaoPaulo_Destinations_2
W $8FD8,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FDA,$02 Cost: "#MONEY".
@ $8FDC label=SaoPaulo_Destinations_3
W $8FDC,$02 Location: #R((#PEEK(#PC+$01)*$0100)+#PEEK(#PC)).
  $8FDE,$02 Cost: "#MONEY".
@ $8FE0 label=SaoPaulo_State
  $8FE0,$01 State: #STATE(#PEEK(#PC)).
@ $8FE1 label=SaoPaulo_Name
T $8FE1,$0A,$09:$01 #FONT#(:(#STR(#PC)))$F840,attr=$4E(location-sao-paulo)

b $8FEB

c $9052 Initialise Sub-Game
@ $9052 label=Initialise_SubGame
  $9052,$03 Call #R$908B.
  $9055,$03 Call #R$9126.
  $9058,$03 Call #R$90A2.
  $905B,$03 Call #R$90FC.
  $905E,$03 Call #R$9194.
  $9061,$06 Write *#R$99D1 to *#R$92BD(#N$92BE).
  $9067,$06 Write *#R$99D5 to *#R$7204.
  $906D,$06 Write #R$9A32 to *#R$99BA.
  $9073,$06 Write #R$99F0 to *#R$99A7.
N $9079 #HTML(Self-modifying code; alters the <code>CALL</code> location target below.)
  $9079,$09 Call the routine pointed to by *#R$99D3.
  $9082,$03 Call #R$9134.
  $9085,$03 Call #R$9163.
  $9088,$03 Jump to #R$9270.

c $908B Copy Sub-Game Data
@ $908B label=CopySubGameData
  $908B,$04 #REGix=*#R$EFF2.
  $908F,$06 Fetch the players current location and store it in #REGhl.
  $9095,$04 Store a pointer to the current locations game data in #REGhl.
  $9099,$08 Copy #N($002F,$04,$04) bytes from *#REGhl to *#R$99C4.
  $90A1,$01 Return.

c $90A2
  $90A2,$04 #REGix=#R$6240.
  $90A6,$03 #REGhl=*#R$99C4.
  $90A9,$01 #REGa=*#REGhl.
  $90AA,$04 Jump to #R$90CA if *#REGa is equal to #N$00.
  $90AE,$01 #REGb=#REGa.
  $90AF,$08 Shift #REGb right four positions.
  $90B7,$02,b$01 Keep only bits 0-3.
  $90B9,$03 RLCA.
M $90AE,$0E Split *#REGhl in half, the upper four bits into #REGa and the lower four bits into #REGb.
  $90BC,$03 Stash #REGhl, #REGbc and #REGaf on the stack.
  $90BF,$03 Call #R$90E8.
  $90C2,$02 Restore #REGaf and #REGbc from the stack.
  $90C4,$02 Decrease counter by one and loop back to #R$90BD until counter is zero.
  $90C6,$01 Restore #REGhl from the stack.
  $90C7,$01 Increment #REGhl by one.
  $90C8,$02 Jump to #R$90A9.

  $90CA,$04 #REGix=#R$7800.
  $90CE,$03 #REGhl=#R$6000.
  $90D1,$03 #REGbc=#N($0300,$04,$04).
  $90D4,$03 Set an increment count in #REGde for below.
  $90D7,$03 Write #REGl to *#REGix+#N$01.
  $90DA,$03 Write #REGh to *#REGix+#N$00.
  $90DD,$04 Increment #REGix by two.
  $90E1,$01 #REGhl+=#N($0006,$04,$04).
  $90E2,$01 Decrease #REGbc by one.
  $90E3,$04 Jump back to #R$90D7 until #REGbc is zero.
  $90E7,$01 Return.
  $90E8,$04 #REGde=*#R$99C6.
  $90EC,$01 #REGa+=#REGe.
  $90ED,$02 Jump to #R$90F0 if #REGbc is higher.
  $90EF,$01 Increment #REGd by one.
  $90F0,$03 Write #REGa to *#REGix+#N$02.
  $90F3,$03 Write #REGd to *#REGix+#N$03.
  $90F6,$05 #REGix+=#N($0006,$04,$04).
  $90FB,$01 Return.

c $90FC
  $90FC,$03 #REGhl=*#R$99C8.
  $90FF,$04 #REGix=#R$6240.
  $9103,$02 #REGa=#N$00.
  $9105,$02 RLD.
  $9107,$01 Return if {} is zero.
  $9108,$01 #REGb=#REGa.
  $9109,$02 RLD.
  $910B,$01 #REGc=#REGa.
  $910C,$02 RLD.
  $910E,$04 #REGde=*#R$99CA.
  $9112,$01 #REGa=#REGc.
  $9113,$01 #REGa+=#REGe.
  $9114,$02 Jump to #R$9117 if #REGd is higher.
  $9116,$01 Increment #REGd by one.
  $9117,$01 #REGe=#REGa.
  $9118,$01 #REGa=*#REGde.
  $9119,$03 #REGde=#N($0006,$04,$04).
  $911C,$03 Write #REGa to *#REGix+#N$04.
  $911F,$02 #REGix+=#REGde.
  $9121,$02 Decrease counter by one and loop back to #R$911C until counter is zero.
  $9123,$01 Increment #REGhl by one.
  $9124,$02 Jump to #R$9103.

c $9126 Clear Shadow Buffer
@ $9126 label=ClearShadowBuffer
  $9126,$0D Write #N$00 to #N($2000,$04,$04) bytes starting from #R$6000.
  $9133,$01 Return.

c $9134 Copy Buffer To Screen
@ $9134 label=CopyBufferToScreen
  $9134,$03 Set the size of the playarea in #REGbc (width #N$20, height #N$12).
  $9137,$03 #REGhl=#R$78C0.
  $913A,$02 Stash the playarea size and #REGhl on the stack.
@ $913A label=CopyBufferToScreen_Loop
  $913C,$03 Call #R$9562.
  $913F,$01 Restore #REGhl from the stack.
  $9140,$02 Increment #REGhl by two.
  $9142,$01 Restore the playarea size from the stack.
  $9143,$02 Decrease the playarea width counter by one and loop back to #R$913A
. the whole width has been drawn for this line.
  $9145,$02 Reset the playarea width in #REGb back to #N$20.
  $9147,$01 Decrease the playarea height counter by one.
  $9148,$02 Jump to #R$913A until all the playarea lines have been drawn.
  $914A,$03 #REGhl=#N$4040 (screen buffer location).
  $914D,$02 #REGc=#N$20.
  $914F,$03 Call #R$8A76.
  $9152,$03 #REGhl=#N$50A0 (screen buffer location).
  $9155,$02 #REGc=#N$60.
  $9157,$03 Jump to #R$8A76.

c $915A Copy UDG To Screen
@ $915A label=CopyUDGToScreen
R $915A DE Destination screen buffer address
R $915A HL Source UDG address
  $915A,$02 #REGb=#N$08.
@ $915C label=CopyUDGToScreen_Loop
  $915C,$01 #REGa=*#REGhl.
  $915D,$01 Write #REGa to *#REGde.
  $915E,$01 Increment #REGhl by one.
  $915F,$01 Increment #REGd by one.
  $9160,$02 Decrease counter by one and loop back to #R$915C until counter is zero.
  $9162,$01 Return.

c $9163 Paint Header And Footer
@ $9163 label=PaintHeaderFooter
  $9163,$03 #REGa=*#R$99CC.
  $9166,$01 Stash this value temporarily in #REGc.
  $9167,$02,b$01 Keep only bits 3-5.
  $9169,$03 RRCA.
  $916C,$02 Set border to the colour held by #REGa.
  $916E,$03 Write #REGa to *#R$99CC.
  $9171,$01 Restore the original value of #REGa.
  $9172,$03 #REGhl=#N$5800 (screen buffer location).
  $9175,$03 Call #R$918D.
  $9178,$03 #REGhl=#N$5AA0 (attribute buffer location).
  $917B,$03 Call #R$918D.
  $917E,$02 Set a counter in #REGb for the playarea height: #N$12.
  $9180,$03 #REGde=#N($001F,$04,$04).
  $9183,$03 #REGhl=#N$5860 (attribute buffer location).
  $9186,$01 Write #REGa to *#REGhl.
@ $9186 label=PaintRightHandSide_Loop
  $9187,$01 #REGhl+=#REGde.
  $9188,$01 Write #REGa to *#REGhl.
  $9189,$01 Increment #REGhl by one.
  $918A,$02 Decrease counter by one and loop back to #R$9186 until counter is zero.
  $918C,$01 Return.

c $918D Handler: Paint Header And Footer
@ $918D label=Handler_PaintHeaderFooter
R $918D A Attribute value to write
R $918D HL Screen buffer address
  $918D,$02 Set a counter in #REGb for #N$03 whole lines.
  $918F,$01 Write the attribute byte to *#REGhl.
@ $918F label=Handler_PaintHeaderFooter_Loop
  $9190,$01 Increment #REGhl by one.
  $9191,$02 Decrease the counter by one and loop back to #R$918F until the counter is zero.
  $9193,$01 Return.

c $9194
  $9194,$03 #REGde=#N($0006,$04,$04).
  $9197,$03 #REGhl=*#R$99CD.
  $919A,$04 #REGix=#R$6240.
  $919E,$01 #REGa=*#REGhl.
  $919F,$01 #REGb=#REGa.
  $91A0,$04 Shift #REGb right two positions.
  $91A4,$02 Jump to #R$91B6 if #REGhl is zero.
  $91A6,$02,b$01 Keep only bits 0-1.
  $91A8,$01 #REGc=#REGa.
  $91A9,$02 Shift #REGc right.
  $91AB,$01 RLA.
  $91AC,$02,b$01 Keep only bits 0-1.
  $91AE,$02,b$01 Set bits 2.
  $91B0,$03 Call #R$921B.
  $91B3,$01 Increment #REGhl by one.
  $91B4,$02 Jump to #R$919E.
  $91B6,$04 #REGix=#R$6000.
  $91BA,$02 #REGc=#N$07.
  $91BC,$02 #REGa=#N$01.
  $91BE,$02 #REGb=#N$60.
  $91C0,$03 Call #R$921B.
  $91C3,$04 #REGix=#R$6FC0.
  $91C7,$02 #REGb=#N$60.
  $91C9,$03 Call #R$921B.
  $91CC,$02 #REGb=#N$12.
  $91CE,$04 #REGix=#R$6240.
  $91D2,$03 #REGde=#N($00C0,$04,$04).
  $91D5,$04 Write #N$05 to *#REGix+#N$00.
  $91D9,$04 Write #N$07 to *#REGix+#N$01.
  $91DD,$02 #REGix+=#REGde.
  $91DF,$04 Write #N$05 to *#REGix+#N$FA.
  $91E3,$04 Write #N$07 to *#REGix+#N$FB.
  $91E7,$02 Decrease counter by one and loop back to #R$91D5 until counter is zero.
  $91E9,$04 #REGix=#N$6F06.
  $91ED,$03 #REGbc=#N$121E.
  $91F0,$03 #REGde=#R$FF40.
  $91F3,$01 Stash #REGbc on the stack.
  $91F4,$02 Stash #REGix on the stack.
  $91F6,$02 #REGa=#N$06.
  $91F8,$04 Test bit 0 of *#REGix+#N$01.
  $91FC,$02 Jump to #R$9213 if #REGhl is not zero.
  $91FE,$02 #REGa=#N$00.
  $9200,$03 Write #REGa to *#REGix+#N$01.
  $9203,$02 #REGix+=#REGde.
  $9205,$02 Decrease counter by one and loop back to #R$91F8 until counter is zero.
  $9207,$02 Restore #REGix from the stack.
  $9209,$03 #REGbc=#N($0006,$04,$04).
  $920C,$02 #REGix+=#REGbc.
  $920E,$01 Restore #REGbc from the stack.
  $920F,$01 Decrease #REGc by one.
  $9210,$02 Jump to #R$91F3 if #REGc is not zero.
  $9212,$01 Return.
  $9213,$02 Compare #REGa with #N$06.
  $9215,$02 Jump to #R$9200 if #REGa is zero.
  $9217,$02 #REGa+=#N$01.
  $9219,$02 Jump to #R$9200.
  $921B,$03 Write #REGa to *#REGix+#N$00.
  $921E,$03 Write #REGc to *#REGix+#N$01.
  $9221,$02 #REGix+=#REGde.
  $9223,$02 Decrease counter by one and loop back to #R$921B until counter is zero.
  $9225,$01 Return.

c $9226
  $9226,$01 Stash #REGbc on the stack.
  $9227,$06 Write *#REGix+#N$04 to *#R$99AA.
  $922D,$02 #REGa=#N$00.
  $922F,$03 #REGe=*#REGix+#N$00.
  $9232,$03 #REGd=*#REGix+#N$01.
  $9235,$02 Stash #REGix on the stack.
  $9237,$01 Stash #REGde on the stack.
  $9238,$02 Restore #REGix from the stack.
  $923A,$03 Call #R$95C6.
  $923D,$02 Restore #REGix from the stack.
  $923F,$03 #REGl=*#REGix+#N$02.
  $9242,$03 #REGh=*#REGix+#N$03.
  $9245,$03 #REGc=*#REGix+#N$00.
  $9248,$03 #REGb=*#REGix+#N$01.
  $924B,$02 #REGa=#N$00.
  $924D,$02 Stash #REGix on the stack.
  $924F,$03 Call #R$9427.
  $9252,$02 Restore #REGix from the stack.
  $9254,$03 #REGde=#N($0005,$04,$04).
  $9257,$02 #REGix+=#REGde.
  $9259,$04 #REGde=*#R$926E.
  $925D,$03 #REGhl=#R$99F0.
  $9260,$03 Write #REGhl to *#R$99A7.
  $9263,$03 #REGhl=*#R$99B8.
  $9266,$01 #REGhl+=#REGde.
  $9267,$03 Write #REGhl to *#R$99B8.
  $926A,$01 Restore #REGbc from the stack.
  $926B,$02 Decrease counter by one and loop back to #R$9226 until counter is zero.
  $926D,$01 Return.
  $926E,$01 No operation.
  $926F,$01 No operation.

c $9270
  $9270,$04 Write #REGsp to *#R$99AE.
  $9274,$03 #REGa=*#R$99E2.
  $9277,$03 Write #REGa to *#R$99AC.
  $927A,$03 Write #REGa to *#R$99AD.
  $927D,$03 #REGa=*#R$99EE.
  $9280,$03 Write #REGa to *#R$99AA.
  $9283,$03 #REGhl=*#R$99E7.
  $9286,$03 #REGde=#N($0007,$04,$04).
  $9289,$01 #REGhl+=#REGde.
  $928A,$02 Write #N$01 to *#REGhl.
  $928C,$03 #REGhl=#N$7208.
  $928F,$03 Write #REGhl to *#R$99B8.
  $9292,$03 Call #R$9346.
  $9295,$02 #REGa=#N$00.
  $9297,$03 Write #REGa to *#R$99AB.
  $929A,$03 #REGa=*#R$99EF.
  $929D,$03 Write #REGa to *#N$7207.
  $92A0,$03 Call #R$8079.
  $92A3,$03 #REGhl=#N$7207.
  $92A6,$01 Decrease *#REGhl by one.
  $92A7,$03 Jump to #R$92B0 P.
  $92AA,$03 #REGa=*#R$99EF.
  $92AD,$03 Write #REGa to *#N$7207.
  $92B0,$03 Call #R$953F.
  $92B3,$03 #REGde=#R$99F0.
  $92B6,$04 Write #REGde to *#R$99A7.
  $92BA,$03 Call #R$92C5.
N $92BD Self-modifying code. See; #R$9052.
  $92BD,$03 Call #R$92C5.
  $92C0,$03 Call #R$9634.
  $92C3,$02 Jump to #R$92A0.

c $92C5
  $92C5,$06 Return if *#N$7207 is not equal to #N$00.
  $92CB,$06 Write *#R$99EE to *#R$99AA.
  $92D1,$03 #REGhl=#R$7200.
  $92D4,$03 Call #R$9439.
  $92D7,$04 #REGix=#R$7200.
  $92DB,$04 Test bit 6 of *#REGix+#N$06.
  $92DF,$02 Jump to #R$931E if #REGa is not zero.
  $92E1,$07 Jump to #R$9303 if *#N$7238 is equal to #N$00.
  $92E8,$01 Decrease #REGa by one.
  $92E9,$03 Write #REGa to *#N$7238.
  $92EC,$02 Test bit 2 of #REGa.
  $92EE,$02 Jump to #R$9303 if #REGa is not zero.
  $92F0,$02,b$01 Keep only bits 0-1.
  $92F2,$02 Compare #REGa with #N$03.
  $92F4,$03 #REGa=*#N$7206.
  $92F7,$03 Call #R$9619 zero.
  $92FA,$02,b$01 Keep only bits 3-4.
  $92FC,$01 #REGe=#REGa.
  $92FD,$04 #REGix=#R$7200.
  $9301,$02 Jump to #R$9309.
  $9303,$03 Call #R$936C.
  $9306,$03 Return if #REGa is equal to #N$20.
  $9309,$03 #REGa=*#N$7206.
  $930C,$02,b$01 Keep only bits 3-4.
  $930E,$03 Jump to #R$9316 if #REGa is equal to #REGe.
  $9311,$03 Write #REGe to *#REGix+#N$06.
  $9314,$02 Jump to #R$933B.
  $9316,$04 Test bit 5 of *#REGix+#N$06.
  $931A,$02 Jump to #R$9324 if #REGa is zero.
  $931C,$02 Jump to #R$9311.
  $931E,$04 Reset bit 6 of *#REGix+#N$06.
  $9322,$02 Jump to #R$933B.
  $9324,$03 #REGhl=*#N$7201.
  $9327,$03 Call #R$9375.
  $932A,$02 Test bit 5 of #REGa.
  $932C,$01 Return if {} is not zero.
  $932D,$02 Test bit 4 of #REGa.
  $932F,$02 Jump to #R$935C if #REGa is not zero.
  $9331,$02 Test bit 0 of #REGa.
  $9333,$01 Return if {} is not zero.
  $9334,$03 Write #REGhl to *#N$7204.
  $9337,$04 Set bit 5 of *#REGix+#N$06.
  $933B,$04 #REGix=#R$7200.
  $933F,$04 #REGbc=*#R$99BA.
  $9343,$03 Call #R$9403.
  $9346,$03 #REGa=*#N$7206.
  $9349,$04 #REGix=#R$99BA.
  $934D,$03 Call #R$95C6.
  $9350,$04 #REGix=#R$7200.
  $9354,$04 #REGbc=*#R$99BA.
  $9358,$03 Call #R$941E.
  $935B,$01 Return.
  $935C,$04 Set bit 6 of *#REGix+#N$06.
  $9360,$03 Call #R$939D.
  $9363,$07 Write #N$7208 to *#R$99B8.
  $936A,$02 Jump to #R$933B.
  $936C,$03 Call #R$85E7.
  $936F,$04 Return if #REGe is not equal to #N$28.
  $9373,$01 Restore #REGhl from the stack.
  $9374,$01 Return.

c $9375
  $9375,$03 #REGa=*#REGix+#N$03.
  $9378,$02,b$01 Keep only bits 3-4.
  $937A,$01 RRCA.
  $937B,$01 RRCA.
  $937C,$01 #REGc=#REGa.
  $937D,$02 #REGb=#N$00.
  $937F,$02 Stash #REGix on the stack.
  $9381,$04 #REGix=#R$99B0.
  $9385,$02 #REGix+=#REGbc.
  $9387,$03 #REGc=*#REGix+#N$00.
  $938A,$03 #REGb=*#REGix+#N$01.
  $938D,$01 #REGhl+=#REGbc.
  $938E,$01 Stash #REGhl on the stack.
  $938F,$03 #REGix=#REGhl (using the stack).
  $9392,$03 #REGh=*#REGix+#N$00.
  $9395,$03 #REGl=*#REGix+#N$01.
  $9398,$01 #REGa=*#REGhl.
  $9399,$01 Restore #REGhl from the stack.
  $939A,$02 Restore #REGix from the stack.
  $939C,$01 Return.

c $939D
  $939D,$01 #REGb=#REGh.
  $939E,$01 #REGc=#REGl.
  $939F,$03 #REGde=#N($000A,$04,$04).
  $93A2,$04 #REGix=#R$7E00.
  $93A6,$04 Test bit 0 of *#REGix+#N$00.
  $93AA,$02 Jump to #R$93B7 if #REGa is zero.
  $93AC,$03 #REGl=*#REGix+#N$01.
  $93AF,$03 #REGh=*#REGix+#N$02.
  $93B2,$01 Set flags.
  $93B3,$02 #REGhl-=#REGbc.
  $93B5,$02 Jump to #R$93BB if #REGa is zero.
  $93B7,$02 #REGix+=#REGde.
  $93B9,$02 Jump to #R$93A6.
  $93BB,$03 #REGl=*#REGix+#N$05.
  $93BE,$03 #REGh=*#REGix+#N$06.
  $93C1,$04 #REGde=*#R$99C6.
  $93C5,$02 #REGhl-=#REGde (with carry).
  $93C7,$02 Jump to #R$93CE if #REGa is not zero.
  $93C9,$05 Write #N$80 to *#N$7238.
  $93CE,$04 Write #N$00 to *#REGix+#N$00.
  $93D2,$03 Call #R$93E9.
  $93D5,$03 #REGa=*#R$99AB.
  $93D8,$02 #REGa-=#N$01.
  $93DA,$01 DAA.
  $93DB,$03 Write #REGa to *#R$99AB.
  $93DE,$05 Write #N$01 to *#R$7200.
  $93E3,$03 #REGhl=#R$EFFF.
  $93E6,$02 Set bit 3 of *#REGhl.
  $93E8,$01 Return.

c $93E9
  $93E9,$05 #REGix+=#N($0003,$04,$04).
  $93EE,$03 #REGde=#REGix (using the stack).
  $93F1,$06 Write #R$9478 to *#R$9462(#N$9463).
  $93F7,$01 #REGl=#REGc.
  $93F8,$01 #REGh=#REGb.
  $93F9,$04 #REGix=*#R$99CF.
  $93FD,$02 #REGa=#N$00.
  $93FF,$03 Call #R$9447.
  $9402,$01 Return.

c $9403
  $9403,$03 #REGl=*#REGix+#N$01.
  $9406,$03 #REGh=*#REGix+#N$02.
  $9409,$03 #REGa=*#REGix+#N$03.
  $940C,$07 Write #R$9478 to *#R$9462(#N$9463).
  $9413,$04 #REGde=*#R$99B8.
  $9417,$03 #REGix=#REGbc (using the stack).
  $941A,$03 Call #R$9447.
  $941D,$01 Return.

c $941E
  $941E,$03 #REGl=*#REGix+#N$04.
  $9421,$03 #REGh=*#REGix+#N$05.
  $9424,$03 #REGa=*#REGix+#N$06.
  $9427,$07 Write #R$94CC to *#R$9462(#N$9463).
  $942E,$04 #REGde=*#R$99B8.
  $9432,$03 #REGix=#REGbc (using the stack).
  $9435,$03 Call #R$9447.
  $9438,$01 Return.

c $9439
  $9439,$01 Increment #REGhl by one.
  $943A,$01 #REGe=#REGl.
  $943B,$01 #REGd=#REGh.
  $943C,$03 #REGbc=#N($0003,$04,$04).
  $943F,$01 #REGhl+=#REGbc.
  $9440,$02 LDIR.
  $9442,$01 Increment #REGhl by one.
  $9443,$03 Write #REGhl to *#R$99B8.
  $9446,$01 Return.

c $9447
  $9447,$01 #REGc=#REGa.
  $9448,$02 #REGb=#N$00.
  $944A,$02 #REGix+=#REGbc.
  $944C,$03 #REGc=*#REGix+#N$06.
  $944F,$03 #REGb=*#REGix+#N$07.
  $9452,$01 #REGhl+=#REGbc.
  $9453,$03 #REGc=*#REGix+#N$02.
  $9456,$03 #REGb=*#REGix+#N$03.
  $9459,$03 #REGix=#REGhl (using the stack).
  $945C,$03 Stash #REGbc and #REGix on the stack.
  $945F,$03 Stash #REGbc and #REGix on the stack.
  $9462,$03 Jump to #R$94CC.

c $9465
  $9465,$03 #REGhl=#N($0008,$04,$04).
  $9468,$01 #REGhl+=#REGde.
  $9469,$01 Exchange the #REGde and #REGhl registers.
  $946A,$01 Restore #REGbc from the stack.
  $946B,$02 Decrease counter by one and loop back to #R$945F until counter is zero.
  $946D,$02 Restore #REGix from the stack.
  $946F,$02 Increment #REGix by one.
  $9471,$02 Increment #REGix by one.
  $9473,$01 Restore #REGbc from the stack.
  $9474,$01 Decrease #REGc by one.
  $9475,$02 Jump to #R$945C if #REGc is not zero.
  $9477,$01 Return.

c $9478
  $9478,$01 Increment #REGde by one.
  $9479,$01 #REGa=*#REGde.
  $947A,$01 Decrease #REGde by one.
  $947B,$02,b$01 Keep only bits 3-7.
  $947D,$03 Write #REGa to *#R$99A9.
  $9480,$03 #REGbc=#N($0005,$04,$04).
  $9483,$03 #REGl=*#REGix+#N$01.
  $9486,$03 #REGh=*#REGix+#N$00.
  $9489,$02 Set bit 2 of *#REGhl.
  $948B,$01 Stash #REGhl on the stack.
  $948C,$01 Set flags.
  $948D,$02 #REGhl-=#REGde (with carry).
  $948F,$02 Jump to #R$94AA if #REGde is zero.
  $9491,$02 Restore #REGix from the stack.
  $9493,$03 #REGa=*#R$99A9.
  $9496,$03
  $9499,$03 Write #REGa to *#REGix+#N$00.
  $949C,$07 Jump to #R$94A7 if *#REGix+#N$05 is equal to #N$00.
  $94A3,$02 #REGix+=#REGbc.
  $94A5,$02 Jump to #R$9483.
  $94A7,$01 Restore #REGbc from the stack.
  $94A8,$02 Jump to #R$94C3.
  $94AA,$01 Restore #REGhl from the stack.
  $94AB,$01 #REGhl+=#REGbc.
  $94AC,$01 #REGa=*#REGhl.
  $94AD,$01 Increment #REGhl by one.
  $94AE,$01 #REGl=*#REGhl.
  $94AF,$03 Write #REGa to *#REGix+#N$00.
  $94B2,$03 Write #REGl to *#REGix+#N$01.
  $94B5,$01 #REGh=#REGa.
  $94B6,$02 Set bit 2 of *#REGhl.
  $94B8,$01 Restore #REGbc from the stack.
  $94B9,$03 #REGhl=*#R$99A7.
  $94BC,$01 Write #REGc to *#REGhl.
  $94BD,$01 Increment #REGhl by one.
  $94BE,$01 Write #REGb to *#REGhl.
  $94BF,$01 Increment #REGhl by one.
  $94C0,$03 Write #REGhl to *#R$99A7.
  $94C3,$04 #REGix=#N($0040,$04,$04).
  $94C7,$02 #REGix+=#REGbc.
  $94C9,$03 Jump to #R$9465.

c $94CC
  $94CC,$01 Increment #REGde by one.
  $94CD,$01 #REGa=*#REGde.
  $94CE,$02,b$01 Keep only bits 0-2.
  $94D0,$03 Write #REGa to *#R$99A9.
  $94D3,$03 #REGl=*#REGix+#N$01.
  $94D6,$03 #REGh=*#REGix+#N$00.
  $94D9,$02 Stash #REGix on the stack.
  $94DB,$01 Stash #REGhl on the stack.
  $94DC,$02 Set bit 2 of *#REGhl.
  $94DE,$01 Increment #REGhl by one.
  $94DF,$01 #REGa=*#REGhl.
  $94E0,$02,b$01 Keep only bits 0-2.
  $94E2,$03 #REGhl=#R$99A9.
  $94E5,$01 Compare #REGa with *#REGhl.
  $94E6,$01 Restore #REGhl from the stack.
  $94E7,$02 Jump to #R$9526 if #REGa is higher.
  $94E9,$01 Decrease #REGde by one.
  $94EA,$03 Write #REGe to *#REGix+#N$01.
  $94ED,$03 Write #REGd to *#REGix+#N$00.
  $94F0,$01 Stash #REGde on the stack.
  $94F1,$02 Restore #REGix from the stack.
  $94F3,$03 Write #REGl to *#REGix+#N$06.
  $94F6,$03 Write #REGh to *#REGix+#N$05.
  $94F9,$03 #REGa=*#REGix+#N$01.
  $94FC,$02,b$01 Keep only bits 3-7.
  $94FE,$02 Set bit 2 of #REGa.
  $9500,$01 Set the bits from *#REGhl.
  $9501,$03 Write #REGa to *#REGix+#N$00.
  $9504,$03 #REGbc=#N($0004,$04,$04).
  $9507,$01 #REGhl+=#REGbc.
  $9508,$01 #REGa=*#REGhl.
  $9509,$02,b$01 Keep only bits 3-7.
  $950B,$03 Set the bits of #REGa with *#REGix+#N$04.
  $950E,$03 Write #REGa to *#REGix+#N$04.
  $9511,$02 Restore #REGbc and #REGbc from the stack.
  $9513,$03 #REGhl=*#R$99A7.
  $9516,$01 Write #REGc to *#REGhl.
  $9517,$01 Increment #REGhl by one.
  $9518,$01 Write #REGb to *#REGhl.
  $9519,$01 Increment #REGhl by one.
  $951A,$03 Write #REGhl to *#R$99A7.
  $951D,$04 #REGix=#N($0040,$04,$04).
  $9521,$02 #REGix+=#REGbc.
  $9523,$03 Jump to #R$9465.
  $9526,$01 #REGa=*#REGde.
  $9527,$02,b$01 Keep only bits 3-7.
  $9529,$01 Set the bits from *#REGhl.
  $952A,$01 Write #REGa to *#REGhl.
  $952B,$04 #REGhl+=#N($0005,$04,$04).
  $952F,$01 #REGa=*#REGhl.
  $9530,$02 Compare #REGa with #N$00.
  $9532,$02 Restore #REGix from the stack.
  $9534,$02 Jump to #R$953B if #REGa is zero.
  $9536,$03 #REGix=#REGhl (using the stack).
  $9539,$02 Jump to #R$94D3.
  $953B,$01 Decrease #REGde by one.
  $953C,$01 Restore #REGbc from the stack.
  $953D,$02 Jump to #R$951D.

c $953F
  $953F,$03 #REGbc=#R$99F0.
  $9542,$03 #REGhl=*#R$99A7.
  $9545,$01 Set flags.
  $9546,$02 #REGhl-=#REGbc.
  $9548,$01 Return if {} is zero.
  $9549,$02 Shift #REGl right.
  $954B,$01 #REGb=#REGl.
  $954C,$03 #REGhl=#R$99F0.
  $954F,$01 Stash #REGbc on the stack.
  $9550,$01 #REGe=*#REGhl.
  $9551,$01 Increment #REGhl by one.
  $9552,$01 #REGd=*#REGhl.
  $9553,$01 Increment #REGhl by one.
  $9554,$03 Write #REGhl to *#R$99A7.
  $9557,$01 Exchange the #REGde and #REGhl registers.
  $9558,$03 Call #R$9562.
  $955B,$03 #REGhl=*#R$99A7.
  $955E,$01 Restore #REGbc from the stack.
  $955F,$02 Decrease counter by one and loop back to #R$954F until counter is zero.
  $9561,$01 Return.

c $9562
  $9562,$01 Stash #REGhl on the stack.
  $9563,$01 #REGd=*#REGhl.
  $9564,$01 Increment #REGhl by one.
  $9565,$01 #REGe=*#REGhl.
  $9566,$01 Exchange the #REGde and #REGhl registers.
  $9567,$02 Test bit 2 of *#REGhl.
  $9569,$02 Jump to #R$95A5 if #REGhl is zero.
  $956B,$02 Reset bit 2 of *#REGhl.
  $956D,$02 Increment #REGhl by two.
  $956F,$01 #REGe=*#REGhl.
  $9570,$01 Increment #REGhl by one.
  $9571,$01 #REGd=*#REGhl.
  $9572,$01 Increment #REGhl by one.
  $9573,$01 #REGa=*#REGhl.
  $9574,$03 Write #REGa to *#R$99A9.
  $9577,$01 Increment #REGhl by one.
  $9578,$01 Stash #REGhl on the stack.
  $9579,$03 #REGhl=#R$99BC.
  $957C,$01 Exchange the #REGde and #REGhl registers.
  $957D,$03 #REGbc=#N($0008,$04,$04).
  $9580,$02 LDIR.
  $9582,$02 Restore #REGix from the stack.
  $9584,$03 #REGa=*#REGix+#N$00.
  $9587,$02 Compare #REGa with #N$00.
  $9589,$02 Jump to #R$95A7 if #REGa is zero.
  $958B,$01 #REGh=#REGa.
  $958C,$03 #REGl=*#REGix+#N$01.
  $958F,$02 Increment #REGhl by two.
  $9591,$01 #REGe=*#REGhl.
  $9592,$01 Increment #REGhl by one.
  $9593,$01 #REGd=*#REGhl.
  $9594,$02 Increment #REGhl by two.
  $9596,$01 Stash #REGhl on the stack.
  $9597,$02 #REGb=#N$08.
  $9599,$03 #REGhl=#R$99BC.
  $959C,$01 #REGa=*#REGde.
  $959D,$01 Set the bits from *#REGhl.
  $959E,$01 Write #REGa to *#REGhl.
  $959F,$01 Increment #REGhl by one.
  $95A0,$01 Increment #REGde by one.
  $95A1,$02 Decrease counter by one and loop back to #R$959C until counter is zero.
  $95A3,$02 Jump to #R$9582.
  $95A5,$01 Restore #REGhl from the stack.
  $95A6,$01 Return.

  $95A7,$03 #REGde=#R$99BC.
  $95AA,$01 Restore #REGhl from the stack.
  $95AB,$02 Shift #REGh right.
  $95AD,$02 Rotate #REGl right.
  $95AF,$01 #REGa=#REGh.
  $95B0,$02,b$01 Keep only bits 0-1, 3-4, 6-7.
  $95B2,$02,b$01 Set bit 6.
  $95B4,$01 #REGh=#REGa.
  $95B5,$03 #REGa=*#R$99A9.
  $95B8,$01 Write #REGa to *#REGhl.
  $95B9,$06 Shift #REGh left three positions (with carry).
  $95BF,$02 Reset bit 7 of #REGh.
  $95C1,$01 Exchange the #REGde and #REGhl registers.
  $95C2,$03 Call #R$915A.
  $95C5,$01 Return.

c $95C6
  $95C6,$01 #REGe=#REGa.
  $95C7,$02 #REGd=#N$00.
  $95C9,$02 #REGix+=#REGde.
  $95CB,$03 #REGb=*#REGix+#N$02.
  $95CE,$03 #REGc=*#REGix+#N$03.
  $95D1,$02 #REGa=#N$00.
  $95D3,$01 #REGa+=#REGc.
  $95D4,$02 Decrease counter by one and loop back to #R$95D3 until counter is zero.
  $95D6,$01 #REGb=#REGa.
  $95D7,$04 #REGc=*#R$99AA.
  $95DB,$03 #REGl=*#REGix+#N$00.
  $95DE,$03 #REGh=*#REGix+#N$01.
  $95E1,$03 #REGe=*#REGix+#N$04.
  $95E4,$03 #REGd=*#REGix+#N$05.
  $95E7,$04 #REGix=#R$99B8.
  $95EB,$01 Stash #REGbc on the stack.
  $95EC,$01 #REGa=*#REGde.
  $95ED,$03 Write #REGa to *#REGix+#N$01.
  $95F0,$03 Write #REGl to *#REGix+#N$02.
  $95F3,$03 Write #REGh to *#REGix+#N$03.
  $95F6,$03 Write #REGc to *#REGix+#N$04.
  $95F9,$05 #REGix+=#N($0008,$04,$04).
  $95FE,$01 #REGhl+=#N($0008,$04,$04).
  $95FF,$01 Increment #REGde by one.
  $9600,$01 Restore #REGbc from the stack.
  $9601,$02 Decrease counter by one and loop back to #R$95EB until counter is zero.
  $9603,$01 Return.

c $9604
  $9604,$01 #REGa=#REGl.
  $9605,$02 Compare #REGa with #N$C0.
  $9607,$02 Jump to #R$960F if #REGa is higher.
  $9609,$04 Return if #N$78 is equal to #REGh.
  $960D,$02 Jump to #R$9613.
  $960F,$04 Return if #N$7D is equal to #REGh.
  $9613,$01 #REGa=#REGl.
  $9614,$02 #REGa+=#N$02.
  $9616,$02,b$01 Keep only bits 2-5.
  $9618,$01 Return.

c $9619
  $9619,$04 #REGix=#R$99A5.
  $961D,$04 Rotate *#REGix+#N$01 right.
  $9621,$04 Test bit 4 of *#REGix+#N$00.
  $9625,$02 Jump to #R$9628 if #REGa is zero.
  $9627,$01 Invert the carry flag.
  $9628,$04 Rotate *#REGix+#N$00 left.
  $962C,$04 Rotate *#REGix+#N$01 left.
  $9630,$03 #REGa=*#REGix+#N$00.
  $9633,$01 Return.

c $9634
  $9634,$06 Return if *#R$7207 is not equal to #N$01.
  $963A,$03 #REGhl=#R$99A4.
  $963D,$04 #REGix=#R$7200.
  $9641,$01 Decrease *#REGhl by one.
  $9642,$02 Jump to #R$9679 if *#REGhl is not zero.
  $9644,$02 Write #N$05 to *#REGhl.
  $9646,$03 #REGa=*#R$99A3.
  $9649,$04 Jump to #R$965B if #REGa is equal to #N$00.
  $964D,$01 Decrease #REGa by one.
  $964E,$03 Write #REGa to *#R$99A3.
  $9651,$02 Jump to #R$965B if #REGa is not zero.
  $9653,$02 #REGc=#N$40.
  $9655,$03 #REGhl=#N$50C0 (screen buffer location).
  $9658,$03 Call #R$8A76.
  $965B,$03 #REGhl=#R$99D9.
  $965E,$03 #REGa=*#R$99AB.
  $9661,$08 Shift #REGa right four positions.
  $9669,$01 Increment #REGa by one.
  $966A,$01 Write #REGa to *#REGhl.
  $966B,$03 #REGde=#R$EFF7.
  $966E,$02 #REGb=#N$02.
  $9670,$03 Call #R$96FE.
  $9673,$02 Jump to #R$96EB if #REGa is lower.
  $9675,$04 Set bit 1 of *#REGix+#N$00.
  $9679,$04 Test bit 0 of *#REGix+#N$00.
  $967D,$02 Jump to #R$96B1 if #REGa is zero.
  $967F,$03 #REGde=#R$EFF7.
  $9682,$03 #REGhl=#R$99DB.
  $9685,$02 #REGb=#N$02.
  $9687,$03 Call #R$9708.
  $968A,$03 #REGde=#R$EFF4.
  $968D,$03 #REGhl=#R$99DD.
  $9690,$02 #REGb=#N$03.
  $9692,$03 Call #R$9708.
  $9695,$03 #REGde=#N$4021 (screen buffer location).
  $9698,$03 #REGbc=#N($0203,$04,$04).
  $969B,$03 #REGhl=#R$EFF6.
  $969E,$03 Call #R$9712.
  $96A1,$03 #REGhl=#R$99AD.
  $96A4,$01 Decrease *#REGhl by one.
  $96A5,$02 Jump to #R$96B1 if *#REGhl is not zero.
  $96A7,$03 #REGhl=#R$EFFA.
  $96AA,$02 Set bit 0 of *#REGhl.
  $96AC,$04 #REGsp=*#R$99AE.
  $96B0,$01 Return.

  $96B1,$04 Test bit 4 of *#REGix+#N$00.
  $96B5,$02 Jump to #R$96BF if *#REGhl is not zero.
  $96B7,$04 Test bit 1 of *#REGix+#N$00.
  $96BB,$02 Jump to #R$96E6 if *#REGhl is zero.
  $96BD,$02 Jump to #R$96DA.
  $96BF,$03 #REGde=#R$EFF7.
  $96C2,$03 #REGhl=#R$99E0.
  $96C5,$02 #REGb=#N$02.
  $96C7,$03 Call #R$96FE.
  $96CA,$02 Jump to #R$96EB if *#REGhl is lower.
  $96CC,$03 #REGhl=#R$99A3.
  $96CF,$02 Write #N$05 to *#REGhl.
  $96D1,$03 #REGhl=*#R$99D7.
  $96D4,$03 #REGde=#N$50C0 (screen buffer location).
  $96D7,$03 Call #R$9754.
  $96DA,$03 #REGde=#N$403B (screen buffer location).
  $96DD,$03 #REGbc=#N($0202,$04,$04).
  $96E0,$03 #REGhl=#R$EFF8.
  $96E3,$03 Call #R$9712.
  $96E6,$04 Write #N$00 to *#REGix+#N$00.
  $96EA,$01 Return.

  $96EB,$06 Write #N($0000,$04,$04) to *#R$EFF7.
  $96F1,$03 Call #R$96DA.
  $96F4,$03 #REGhl=#R$EFFA.
  $96F7,$02 Set bit 4 of *#REGhl.
  $96F9,$04 #REGsp=*#R$99AE.
  $96FD,$01 Return.

c $96FE Spend Money
@ $96FE label=SpendMoney
R $96FE B Number of digits
R $96FE DE Pointer to players cash
R $96FE HL Pointer to cost to deduct
N $96FE See #POKE#dontspendmoney(Don't Spend Money) and #POKE#altdontspendmoney(Don't Spend Money (alt)).
  $96FE,$01 Set flags ready for the subtraction.
@ $96FF label=SpendMoney_Loop
  $96FF,$01 Load the player cash digit from *#REGde into #REGa.
  $9700,$01 Subtract the cost from the digit in *#REGhl (with the carry flag).
  $9701,$01 Digital to analogue conversion.
  $9702,$01 Write the result in #REGa back to the players cash.
  $9703,$02 Increment both the players cash and cost to deduct pointers.
  $9705,$02 Decrease number of digits counter by one and loop back to #R$96FF
. until all digits have been processed.
  $9707,$01 Return.

c $9708 Add Money
@ $9708 label=AddMoney
R $9708 B Number of digits
R $9708 DE Pointer to players cash
R $9708 HL Pointer to cost to add
  $9708,$01 Set flags.
@ $9709 label=AddMoney_Loop
  $9709,$01 #REGa=*#REGde.
  $970A,$01 #REGa+=*#REGhl.
  $970B,$01 Digital to analogue conversion.
  $970C,$01 Write #REGa to *#REGde.
  $970D,$01 Increment #REGhl by one.
  $970E,$01 Increment #REGde by one.
  $970F,$02 Decrease number of digits counter by one and loop back to #R$9709
. until all digits have been processed.
  $9711,$01 Return.

c $9712 Print Numbers
@ $9712 label=PrintNumbers
R $9712 HL
R $9712 BC
  $9712,$04 #REGix=#R$7200.
  $9716,$04 Set bit 3 of *#REGix+#N$00.
  $971A,$01 Stash #REGbc on the stack.
  $971B,$02 #REGa=#N$30.
  $971D,$01 Stash #REGbc on the stack.
  $971E,$02 RLD.
  $9720,$02 Stash #REGhl and #REGaf on the stack.
  $9722,$04 Jump to #R$9732 if #REGa is equal to #N$30.
  $9726,$04 Reset bit 3 of *#REGix+#N$00.
  $972A,$03 Create an offset using #REGhl.
  $972D,$03 #REGhl*=#N$08.
  $9730,$02 Jump to #R$973D.
  $9732,$04 Test bit 3 of *#REGix+#N$00.
  $9736,$03 #REGhl=#N($0100,$04,$04).
  $9739,$02 Jump to #R$973D if #REGa is not zero.
  $973B,$02 #REGl=#N$80.
  $973D,$04 #REGhl+=#R$F840(#N$F740).
  $9741,$01 Stash #REGde on the stack.
  $9742,$03 Call #R$915A.
  $9745,$01 Restore #REGde from the stack.
  $9746,$01 Increment #REGde by one.
  $9747,$03 Restore #REGaf, #REGhl and #REGbc from the stack.
  $974A,$02 Decrease counter by one and loop back to #R$971D until counter is zero.
  $974C,$02 RLD.
  $974E,$01 Restore #REGbc from the stack.
  $974F,$01 Decrease #REGhl by one.
  $9750,$01 Decrease #REGc by one.
  $9751,$02 Jump to #R$971A if #REGc is not zero.
  $9753,$01 Return.

c $9754
  $9754,$03 #REGde=#N$50C1 (screen buffer location).
  $9757,$03 Call #R$8A3D.
  $975A,$01 #REGa=#REGe.
  $975B,$02 NEG.
  $975D,$01 #REGc=#REGa.
  $975E,$01 Exchange the #REGde and #REGhl registers.
  $975F,$03 Jump to #R$8A76.

c $9762

c $97D7

c $98F2
  $98F2,$04 #REGix=*#R$99E7.
  $98F6,$03 Write #REGe to *#REGix+#N$00.
  $98F9,$03 Write #REGc to *#REGix+#N$04.
  $98FC,$03 Write #REGb to *#REGix+#N$05.
  $98FF,$03 Call #R$9619.
  $9902,$03 #REGhl=#R$99ED.
  $9905,$01 Merge the bits from *#REGhl.
  $9906,$03 #REGhl=*#R$99E7.
  $9909,$03 Call #R$9439.
  $990C,$01 Decrease #REGhl by one.
  $990D,$01 Increment #REGa by one.
  $990E,$01 Write #REGa to *#REGhl.
  $990F,$02 #REGa=#N$00.
  $9911,$03 Jump to #R$985B.

c $9914
  $9914,$01 #REGd=*#REGhl.
  $9915,$01 Increment #REGhl by one.
  $9916,$01 #REGe=*#REGhl.
  $9917,$01 Exchange the #REGde and #REGhl registers.
  $9918,$02 Set bit 2 of *#REGhl.
  $991A,$01 Decrease #REGde by one.
  $991B,$03 #REGhl=*#R$99A7.
  $991E,$01 Write #REGe to *#REGhl.
  $991F,$01 Increment #REGhl by one.
  $9920,$01 Write #REGd to *#REGhl.
  $9921,$01 Increment #REGhl by one.
  $9922,$03 Write #REGhl to *#R$99A7.
  $9925,$01 Return.

c $9926
  $9926,$03 Call #R$9942.
  $9929,$04 #REGix=*#R$99E3.
  $992D,$03 #REGa=*#REGix+#N$06.
  $9930,$04 #REGix=*#R$99E5.
  $9934,$03 Call #R$95C6.
  $9937,$04 #REGix=*#R$99E3.
  $993B,$04 #REGbc=*#R$99E5.
  $993F,$03 Jump to #R$941E.

c $9942
  $9942,$04 #REGix=*#R$99E3.
  $9946,$04 #REGbc=*#R$99E5.
  $994A,$03 Jump to #R$9403.
  $994D,$06 Return if *#R$99AB is equal to #N$50.
  $9953,$06 Return if *#R$99AC is equal to #N$00.
  $9959,$03 #REGhl=*#R$99B8.
  $995C,$01 Stash #REGhl on the stack.
  $995D,$04 #REGix=*#R$99E3.
  $9961,$03 Call #R$9762.
  $9964,$01 Restore #REGhl from the stack.
  $9965,$03 Write #REGhl to *#R$99B8.
  $9968,$01 Return.

b $9969

B $99A3,$01
B $99A4,$01
W $99A5,$02

W $99A7,$02

B $99AA,$01
B $99AB,$01
B $99AC,$01
B $99AD,$01
W $99AE,$02

W $99BA,$02


b $99C4 Active Sub-Game Data
@ $99C4 label=ActiveSubGameData
D $99C4 Populated from the location data:
. #TABLE(default,centre,centre)
. { =h Location | =h Data }
. { Paris | #R$AAAE }
. { Jerusalem | #R$B0CA }
. { Madrid | #R$B496 }
. { Munich | #R$BA76 }
. { Hong Kong | #R$C146 }
. { Moscow | #R$C753 }
. { Alice Springs | #R$C9DD }
. { Samoa | #R$D1E8 }
. { Benares | #R$D67D }
. { Chichen Itza | #R$DA90 }
. { New Orleans | #R$DE4C }
. { Kanyu | #R$E10B }
. { Sao Paulo | #R$E716 }
. TABLE#
W $99C4,$02
W $99C6,$02
W $99C8,$02
W $99CA,$02
  $99CC,$01
W $99CD,$02

  $99CF

  $99D1

W $99D3,$02 Pointer to initialisation routine.
@ $99D3 label=ActiveSubGameInitialisation

  $99D5

W $99D7,$02

  $99DB

  $99DD

  $99E0

  $99E2

W $99E3,$02
W $99E5,$02
  $99E7

  $99ED
  $99EE
  $99EF

  $99F0

b $9A32
  $9A32,$08 #UDG(#PC)
L $9A32,$08,$100
  $AA6A,$08 #UDG(#PC)
L $AA6A,$08,$02
  $AA7D,$08 #UDG(#PC)
L $AA7D,$08,$06

b $AAAE Sub-Game Data: Paris
@ $AAAE label=Paris_Data
D $AAAE #PUSHS #UDGTABLE { #LOCATION($8EB2)(paris) } UDGTABLE# #POPS
W $AAAE,$02 #R$B031
W $AAB0,$02 #R$AF29
W $AAB2,$02 #R$AFB2
W $AAB4,$02 #R$AFA9
  $AAB6,$01
W $AAB7,$02 #R$AEF3
W $AAB9,$02
W $AABB,$02 Location subgame routine.
@ $AABB label=Paris_SubGame
W $AABD,$02 Initialisation routine.
@ $AABD label=Paris_SetUp

c $AADA Initialise: Paris
@ $AADA label=Initialise_Paris
  $AADA,$03 #REGhl=#R$5EB0.
  $AADD,$03 #REGde=#N$5EB1.
  $AAE0,$03 #REGbc=#N($014F,$04,$04).
  $AAE3,$02 Write #N$00 to *#REGhl.
  $AAE5,$02 LDIR.
  $AAE7,$03 #REGhl=#R$AEAB.
  $AAEA,$03 Call #R$B0AE.
  $AAED,$04 #REGix=#R$ADAB.
  $AAF1,$07 Write #R$7240 to *#R$99B8.
  $AAF8,$02 #REGb=#N$09.
  $AAFA,$07 Write #N($0060,$04,$04) to *#R$926E.
  $AB01,$03 Call #R$9226.
  $AB04,$07 Write #N($0020,$04,$04) to *#R$926E.
  $AB0B,$02 #REGb=#N$12.
  $AB0D,$03 Call #R$9226.
  $AB10,$06 Write #R$7E00 to *#R$7239.
  $AB16,$01 Return.

c $AB17 Handler: Paris
@ $AB17 label=Handler_Paris
  $AB17,$03 Call #R$AC1B.
  $AB1A,$06 Return if *#R$7207 is zero.
  $AB20,$03 #REGhl=*#R$99E3.
  $AB23,$04 #REGhl+=#N($0038,$04,$04).
  $AB27,$05 Jump to #R$AB2F if #REGl is not equal to #N$C8.
  $AB2C,$06 Write #R$5EB0 to *#R$99E3.
  $AB32,$02 Test bit 7 of *#REGhl.
  $AB34,$03 Jump to #R$ABE5 if #REGa is zero.
  $AB37,$03 Call #R$9439.
  $AB3A,$04 #REGix=*#R$99E3.
  $AB3E,$07 Jump to #R$AB5B if *#REGix+#N$00 is equal to #N$80.
  $AB45,$03 Decrease *#REGix+#N$00 by one.
  $AB48,$03 Compare #REGa with *#REGix+#N$00.
  $AB4B,$01 Return if {} is not zero.
  $AB4C,$06 Write #R$AD53 to *#R$ACFA.
  $AB52,$03 Call #R$994D.
  $AB55,$03 #REGhl=*#R$99E3.
  $AB58,$02 Write #N$80 to *#REGhl.
  $AB5A,$01 Return.
  $AB5B,$04 Test bit 5 of *#REGix+#N$06.
  $AB5F,$02 Jump to #R$AB78 if #REGa is zero.
  $AB61,$04 Reset bit 5 of *#REGix+#N$06.
  $AB65,$03 #REGl=*#REGix+#N$04.
  $AB68,$03 #REGh=*#REGix+#N$05.
  $AB6B,$03 Call #R$9604.
  $AB6E,$03 Jump to #R$9926 if #REGa is not zero.
  $AB71,$04 Write #N$00 to *#REGix+#N$00.
  $AB75,$03 Jump to #R$9942.
  $AB78,$03 #REGa=*#R$99AB.
  $AB7B,$02 Compare #REGa with #N$50.
  $AB7D,$02 Jump to #R$ABA9 if #REGa is zero.
  $AB7F,$03 #REGa=*#R$99AC.
  $AB82,$02 Compare #REGa with #N$00.
  $AB84,$02 Jump to #R$ABA9 if #REGa is zero.
  $AB86,$03 #REGa=*#REGix+#N$18.
  $AB89,$02,b$01 Keep only bits 4, 7.
  $AB8B,$02 Compare #REGa with #N$80.
  $AB8D,$02 Jump to #R$ABA9 if #REGa is not zero.
  $AB8F,$03 Call #R$9619.
  $AB92,$02,b$01 Keep only bits 0-3.
  $AB94,$02,b$01 Set bits 4, 7.
  $AB96,$04 #REGix=*#R$99E3.
  $AB9A,$03 Write #REGa to *#REGix+#N$00.
  $AB9D,$01 Return.
  $AB9E,$02,b$01 Keep only bits 6.
  $ABA0,$02 Jump to #R$ABB0 if #REGa is zero.
  $ABA2,$03 #REGhl=#R$7200.
  $ABA5,$02 Set bit 4 of *#REGhl.
  $ABA7,$02 Jump to #R$ABB0.
  $ABA9,$03 #REGa=*#REGix+#N$07.
  $ABAC,$02 Compare #REGa with #N$00.
  $ABAE,$02 Jump to #R$ABC8 if #REGa is not zero.
  $ABB0,$03 Call #R$9619.
  $ABB3,$01 #REGc=#REGa.
  $ABB4,$02,b$01 Keep only bits 3-4.
  $ABB6,$04 #REGix=*#R$99E3.
  $ABBA,$03 Write #REGa to *#REGix+#N$06.
  $ABBD,$01 #REGa=#REGc.
  $ABBE,$02,b$01 Keep only bits 0-2.
  $ABC0,$02 #REGa+=#N$08.
  $ABC2,$03 Write #REGa to *#REGix+#N$07.
  $ABC5,$03 Jump to #R$9926.
  $ABC8,$03 Decrease *#REGix+#N$07 by one.
  $ABCB,$03 #REGh=*#REGix+#N$05.
  $ABCE,$03 #REGl=*#REGix+#N$04.
  $ABD1,$03 Call #R$9375.
  $ABD4,$02,b$01 Keep only bits 1, 5-6.
  $ABD6,$02 Jump to #R$AB9E if #REGa is not zero.
  $ABD8,$03 Write #REGl to *#REGix+#N$04.
  $ABDB,$03 Write #REGh to *#REGix+#N$05.
  $ABDE,$04 Set bit 5 of *#REGix+#N$06.
  $ABE2,$03 Jump to #R$9926.
  $ABE5,$03 Call #R$9439.
  $ABE8,$03 Call #R$9619.
  $ABEB,$02,b$01 Keep only bits 4-7.
  $ABED,$01 #REGl=#REGa.
  $ABEE,$02 #REGh=#N$00.
  $ABF0,$01 #REGhl+=#REGhl.
  $ABF1,$01 #REGhl+=#REGhl.
  $ABF2,$03 #REGde=#R$78FE.
  $ABF5,$01 #REGhl+=#REGde.
  $ABF6,$02 #REGa=#N$10.
  $ABF8,$04 #REGix=*#R$99E3.
  $ABFC,$03 Call #R$9378.
  $ABFF,$02,b$01 Keep only bits 1, 5-6.
  $AC01,$01 Return if {} is not zero.
  $AC02,$03 #REGa=*#R$99A5.
  $AC05,$02,b$01 Keep only bits 0-3.
  $AC07,$03 Write #REGa to *#REGix+#N$07.
  $AC0A,$04 Write #N$80 to *#REGix+#N$00.
  $AC0E,$03 Write #REGl to *#REGix+#N$04.
  $AC11,$03 Write #REGh to *#REGix+#N$05.
  $AC14,$04 Write #N$30 to *#REGix+#N$06.
  $AC18,$03 Jump to #R$9929.
  $AC1B,$03 #REGhl=*#R$7239.
  $AC1E,$02 Test bit 0 of *#REGhl.
  $AC20,$02 Jump to #R$AC35 if #REGa is not zero.
  $AC22,$03 #REGhl=*#R$7239.
  $AC25,$03 #REGde=#N($000A,$04,$04).
  $AC28,$01 #REGhl+=#REGde.
  $AC29,$02 #REGa=#N$80.
  $AC2B,$01 Compare #REGa with #REGh.
  $AC2C,$03 Write #REGhl to *#R$7239.
  $AC2F,$01 Return if {} is not zero.
  $AC30,$03 #REGhl=#R$7E00.
  $AC33,$02 Jump to #R$AC2B.
  $AC35,$02 Test bit 1 of *#REGhl.
  $AC37,$02 Jump to #R$AC5B if #REGa is not zero.
  $AC39,$03 Call #R$9619.
  $AC3C,$02 Compare #REGa with #N$96.
  $AC3E,$02 Jump to #R$AC22 if #REGa is lower.
  $AC40,$02,b$01 Keep only bits 2-3.
  $AC42,$01 #REGe=#REGa.
  $AC43,$01 RLCA.
  $AC44,$04 #REGix=*#R$7239.
  $AC48,$03 #REGl=*#REGix+#N$01.
  $AC4B,$03 #REGh=*#REGix+#N$02.
  $AC4E,$03 Call #R$9378.
  $AC51,$02,b$01 Keep only bits 0, 4.
  $AC53,$02 Jump to #R$AC22 if #REGa is not zero.
  $AC55,$01 #REGa=#REGe.
  $AC56,$02,b$01 Set bits 0-1.
  $AC58,$03 Write #REGa to *#REGix+#N$00.
  $AC5B,$04 #REGix=*#R$7239.
  $AC5F,$03 #REGc=*#REGix+#N$01.
  $AC62,$03 #REGb=*#REGix+#N$02.
  $AC65,$03 Call #R$93E9.
  $AC68,$04 #REGix=*#R$7239.
  $AC6C,$03 #REGa=*#REGix+#N$00.
  $AC6F,$02 #REGa+=#N$10.
  $AC71,$02 Compare #REGa with #N$50.
  $AC73,$02 Jump to #R$AC7F if #REGa is lower.
  $AC75,$02,b$01 Keep only bits 0, 2-3.
  $AC77,$03 Write #REGa to *#REGix+#N$00.
  $AC7A,$03 Call #R$ACBA.
  $AC7D,$02 Jump to #R$AC22.
  $AC7F,$03 Write #REGa to *#REGix+#N$00.
  $AC82,$03 Call #R$ACCA.
  $AC85,$03 #REGa=*#REGix+#N$02.
  $AC88,$03 #REGd=*#REGix+#N$03.
  $AC8B,$04 #REGix=*#R$7239.
  $AC8F,$02 Compare #REGa with #N$00.
  $AC91,$02 Jump to #R$ACC1 if #REGa is zero.
  $AC93,$01 #REGe=#REGa.
  $AC94,$03 #REGl=*#REGix+#N$01.
  $AC97,$03 #REGh=*#REGix+#N$02.
  $AC9A,$01 #REGhl+=#REGde.
  $AC9B,$01 #REGd=*#REGhl.
  $AC9C,$01 Increment #REGhl by one.
  $AC9D,$01 #REGe=*#REGhl.
  $AC9E,$01 #REGa=*#REGde.
  $AC9F,$01 Decrease #REGhl by one.
  $ACA0,$02,b$01 Keep only bits 0, 4.
  $ACA2,$02 Jump to #R$ACAD if #REGhl is not zero.
  $ACA4,$03 Write #REGl to *#REGix+#N$01.
  $ACA7,$03 Write #REGh to *#REGix+#N$02.
  $ACAA,$03 Jump to #R$97A7.
  $ACAD,$03 #REGa=*#REGix+#N$00.
  $ACB0,$02,b$01 Keep only bits 0-3.
  $ACB2,$02,b$01 Set bits 6.
  $ACB4,$03 Write #REGa to *#REGix+#N$00.
  $ACB7,$03 Jump to #R$ACBA.
  $ACBA,$03 Call #R$ACCA.
  $ACBD,$04 #REGix=*#R$7239.
  $ACC1,$03 #REGl=*#REGix+#N$01.
  $ACC4,$03 #REGh=*#REGix+#N$02.
  $ACC7,$03 Jump to #R$97A7.
  $ACCA,$02,b$01 Keep only bits 2-6.
  $ACCC,$01 #REGe=#REGa.
  $ACCD,$02 #REGd=#N$00.
  $ACCF,$04 #REGix=#R$AD03.
  $ACD3,$02 #REGix+=#REGde.
  $ACD5,$03 #REGe=*#REGix+#N$00.
  $ACD8,$03 #REGd=*#REGix+#N$01.
  $ACDB,$04 Write #REGde to *#R$ACFA.
  $ACDF,$02,b$01 Keep only bits 5-6.
  $ACE1,$02 #REGe=#N$10.
  $ACE3,$02 Jump to #R$ACF3 if #REGhl is zero.
  $ACE5,$02 Compare #REGa with #N$20.
  $ACE7,$02 #REGe=#N$20.
  $ACE9,$02 Jump to #R$ACF3 if #REGa is zero.
  $ACEB,$02 Compare #REGa with #N$40.
  $ACED,$02 #REGe=#N$40.
  $ACEF,$02 Jump to #R$ACF3 if #REGa is zero.
  $ACF1,$02 #REGe=#N$80.
  $ACF3,$03 #REGhl=#R$EFFF.
  $ACF6,$01 #REGa=#REGe.
  $ACF7,$01 Set the bits from *#REGhl.
  $ACF8,$01 Write #REGa to *#REGhl.
  $ACF9,$01 Return.
B $ACFA
B $AD03
B $AD53
B $ADAB
B $AEAB

b $AF29

b $AFA9

b $AFB2

b $B031

c $B0AE Paris
  $B0AE,$02 #REGc=#N$48.
  $B0B0,$04 #REGix=#R$6240.
  $B0B4,$03 #REGde=#N($0006,$04,$04).
  $B0B7,$02 #REGb=#N$08.
  $B0B9,$01 #REGa=*#REGhl.
  $B0BA,$01 RLCA.
  $B0BB,$02 Jump to #R$B0C1 if  is higher.
  $B0BD,$04 Set bit 7 of *#REGix+#N$00.
  $B0C1,$02 #REGix+=#REGde.
  $B0C3,$02 Decrease counter by one and loop back to #R$B0BA until counter is zero.
  $B0C5,$01 Increment #REGhl by one.
  $B0C6,$01 Decrease #REGc by one.
  $B0C7,$02 Jump to #R$B0B7 if #REGc is not zero.
  $B0C9,$01 Return.

b $B0CA Sub-Game Data: Jerusalem
@ $B0CA label=Jerusalem_Data
D $B0CA #PUSHS #UDGTABLE { #LOCATION($8EF9)(jerusalem) } UDGTABLE# #POPS
W $B0D5,$02
W $B0D7,$02
@ $B0D7 label=Jerusalem_SubGame
W $B0D9,$02
@ $B0D9 label=Jerusalem_SetUp

c $B112 Initialise: Jerusalem
@ $B112 label=Jerusalem_Initialise

c $B113 Handler: Jerusalem
@ $B113 label=Handler_Jerusalem
  $B113,$05 Write #N$00 to *#R$99AA.
  $B118,$06 Return if *#R$7207 is zero.
  $B11E,$03 Call #R$9619.
  $B121,$03 #REGa=*#R$99A5.
  $B124,$03 #REGhl=#N$77FE.
  $B127,$02,b$01 Keep only bits 0-3.
  $B129,$01 Compare #REGa with *#REGhl.
  $B12A,$02 #REGe=#N$00.
  $B12C,$02 Jump to #R$B130 if #REGa is higher.
  $B12E,$02 #REGe=#N$01.
  $B130,$03 #REGhl=*#R$99E3.
  $B133,$04 #REGhl+=#N($0038,$04,$04).
  $B137,$05 Jump to #R$B13F if #REGh is not equal to #N$77.
  $B13C,$03 #REGhl=#R$7240.
  $B13F,$03 Write #REGhl to *#R$99E3.
  $B142,$02 Test bit 7 of *#REGhl.
  $B144,$03 Jump to #R$B1D3 if #REGa is not zero.
  $B147,$03 #REGa=*#N$77FF.
  $B14A,$02 Compare #REGa with #N$07.
  $B14C,$02 Jump to #R$B130 if #REGa is zero.
  $B14E,$02 Test bit 0 of #REGe.
  $B150,$02 Jump to #R$B172 if #REGa is zero.
  $B152,$02 Test bit 1 of *#REGhl.
  $B154,$02 Jump to #R$B130 if #REGa is zero.
  $B156,$02 Write #N$81 to *#REGhl.
  $B158,$03 Call #R$994D.
  $B15B,$03 #REGhl=*#R$99E3.
  $B15E,$03 Call #R$9439.
  $B161,$03 #REGhl=#N$77FF.
  $B164,$01 Increment *#REGhl by one.
  $B165,$03 #REGhl=#N$77FE.
  $B168,$01 Decrease *#REGhl by one.
  $B169,$04 #REGix=*#R$99E3.
  $B16D,$02 #REGe=#N$08.
  $B16F,$03 Jump to #R$B27F.
  $B172,$02 Test bit 1 of *#REGhl.
  $B174,$02 Jump to #R$B130 if *#REGhl is not zero.
  $B176,$02 Write #N$84 to *#REGhl.
  $B178,$03 Call #R$9439.
  $B17B,$03 #REGhl=#N$77FF.
  $B17E,$01 Increment *#REGhl by one.
  $B17F,$03 Call #R$9619.
  $B182,$03 #REGa=*#R$99A5.
  $B185,$02 Test bit 0 of #REGa.
  $B187,$04 #REGix=*#R$99E3.
  $B18B,$02 Jump to #R$B1A2 if *#REGhl is zero.
  $B18D,$02 #REGe=#N$18.
  $B18F,$03 #REGhl=#N$7DC0.
  $B192,$02,b$01 Keep only bits 1-5.
  $B194,$02 Jump to #R$B19A if *#REGhl is not zero.
  $B196,$02 #REGa+=#N$20.
  $B198,$02 Jump to #R$B1B1.
  $B19A,$02 Compare #REGa with #N$3E.
  $B19C,$02 Jump to #R$B1B1 if #REGa is not zero.
  $B19E,$02 #REGa-=#N$20.
  $B1A0,$02 Jump to #R$B1B1.
  $B1A2,$02 Test bit 5 of #REGa.
  $B1A4,$03 #REGhl=#R$7C3E.
  $B1A7,$02 #REGe=#N$10.
  $B1A9,$02 Jump to #R$B1AF if #REGa is not zero.
  $B1AB,$02 #REGl=#N$00.
  $B1AD,$02 #REGe=#N$00.
  $B1AF,$02,b$01 Keep only bits 6-7.
  $B1B1,$01 #REGc=#REGa.
  $B1B2,$02 #REGb=#N$00.
  $B1B4,$01 #REGhl+=#REGbc.
  $B1B5,$03 Write #REGl to *#REGix+#N$04.
  $B1B8,$03 Write #REGh to *#REGix+#N$05.
  $B1BB,$01 #REGb=*#REGhl.
  $B1BC,$01 Increment #REGhl by one.
  $B1BD,$01 #REGc=*#REGhl.
  $B1BE,$01 #REGa=*#REGbc.
  $B1BF,$02,b$01 Keep only bits 1, 5-6.
  $B1C1,$02 Jump to #R$B17F if #REGhl is not zero.
  $B1C3,$03 Write #REGe to *#REGix+#N$06.
  $B1C6,$03 #REGa=*#R$99A5.
  $B1C9,$02,b$01 Keep only bits 0-3.
  $B1CB,$02 #REGa+=#N$08.
  $B1CD,$03 Write #REGa to *#REGix+#N$07.
  $B1D0,$03 Jump to #R$9929.
  $B1D3,$03 Call #R$9439.
  $B1D6,$04 #REGix=*#R$99E3.
  $B1DA,$04 Test bit 5 of *#REGix+#N$03.
  $B1DE,$02 Jump to #R$B1E7 if #REGhl is zero.
  $B1E0,$04 Reset bit 5 of *#REGix+#N$06.
  $B1E4,$03 Jump to #R$B28C.
  $B1E7,$03 #REGl=*#REGix+#N$01.
  $B1EA,$03 #REGh=*#REGix+#N$02.
  $B1ED,$04 Test bit 2 of *#REGix+#N$00.
  $B1F1,$04 Reset bit 2 of *#REGix+#N$00.
  $B1F5,$02 Jump to #R$B206 if #REGhl is not zero.
  $B1F7,$03 Call #R$9604.
  $B1FA,$02 Jump to #R$B206 if #REGhl is not zero.
  $B1FC,$04 Write #N$00 to *#REGix+#N$00.
  $B200,$03 Call #R$9942.
  $B203,$03 Jump to #R$B25B.
  $B206,$03 Decrease *#REGix+#N$07 by one.
  $B209,$03 Jump to #R$B262 if #REGhl is zero.
  $B20C,$03 Call #R$9375.
  $B20F,$01 #REGe=#REGa.
  $B210,$02,b$01 Keep only bits 1, 5-6.
  $B212,$02 Jump to #R$B23D if #REGhl is not zero.
  $B214,$03 Write #REGl to *#REGix+#N$04.
  $B217,$03 Write #REGh to *#REGix+#N$05.
  $B21A,$04 Set bit 5 of *#REGix+#N$06.
  $B21E,$04 Test bit 3 of *#REGix+#N$00.
  $B222,$02 Jump to #R$B28C if #REGhl is zero.
  $B224,$03 #REGa=*#R$99A5.
  $B227,$02,b$01 Keep only bits 0-2.
  $B229,$02 Compare #REGa with #N$06.
  $B22B,$02 Jump to #R$B28C if #REGa is not zero.
  $B22D,$02 #REGa=#N$03.
  $B22F,$01 Merge the bits from #REGe.
  $B230,$02 Compare #REGa with #N$01.
  $B232,$02 Jump to #R$B28C if #REGa is zero.
  $B234,$04 Reset bit 3 of *#REGix+#N$00.
  $B238,$03 Call #R$994D.
  $B23B,$02 Jump to #R$B28C.
  $B23D,$02,b$01 Keep only bits 6.
  $B23F,$02 Jump to #R$B246 if #REGa is zero.
  $B241,$03 #REGhl=#R$7200.
  $B244,$02 Set bit 4 of *#REGhl.
  $B246,$04 Test bit 0 of *#REGix+#N$00.
  $B24A,$02 Jump to #R$B262 if #REGa is not zero.
  $B24C,$07 Jump to #R$B262 if *#REGix+#N$05 is not equal to #N$7A.
  $B253,$04 Write #N$02 to *#REGix+#N$00.
  $B257,$03 #REGhl=#N$77FE.
  $B25A,$01 Increment *#REGhl by one.
  $B25B,$03 #REGhl=#N$77FF.
  $B25E,$01 Decrease *#REGhl by one.
  $B25F,$03 Jump to #R$B113.
  $B262,$04 Test bit 3 of *#REGix+#N$06.
  $B266,$02 Jump to #R$B274 if *#REGhl is not zero.
  $B268,$02 #REGe=#N$08.
  $B26A,$04 Test bit 0 of *#REGix+#N$00.
  $B26E,$02 Jump to #R$B27F if *#REGhl is not zero.
  $B270,$02 #REGe=#N$18.
  $B272,$02 Jump to #R$B27F.
  $B274,$03 #REGa=*#R$99A5.
  $B277,$02 Test bit 4 of #REGa.
  $B279,$02 #REGe=#N$00.
  $B27B,$02 Jump to #R$B27F if *#REGhl is not zero.
  $B27D,$05 Write #N$10 to *#REGix+#N$06.
  $B282,$03 #REGa=*#R$99A5.
  $B285,$02,b$01 Keep only bits 0-3.
  $B287,$02 #REGa+=#N$08.
  $B289,$03 Write #REGa to *#REGix+#N$07.
  $B28C,$03 Jump to #R$9926.
B $B28F

b $B496 Sub-Game Data: Madrid
@ $B496 label=Madrid_Data
D $B496 #PUSHS #UDGTABLE { #LOCATION($8E9A)(madrid) } UDGTABLE# #POPS
W $B496,$02 #R$B512
W $B498,$02 #R$B4C2
W $B49A,$02 #R$B575
W $B49C,$02 #R$B570
  $B49E,$01
W $B49F,$02 #R$B559
W $B4A1,$02
W $B4A3,$02 Location subgame routine.
@ $B4A3 label=Madrid_SubGame
W $B4A5,$02 Initialisation routine.
@ $B4A5 label=Madrid_SetUp
B $B4C2
B $B4FA

b $B4C2

b $B512

b $B559

b $B570

b $B575

c $B5A7 Initialise: Madrid
@ $B5A7 label=Madrid_Initialise
  $B5A7,$04 #REGix=#R$6240.
  $B5AB,$02 #REGb=#N$60.
  $B5AD,$03 #REGde=#R$B4FA.
  $B5B0,$03 #REGl=*#REGix+#N$02.
  $B5B3,$03 #REGh=*#REGix+#N$03.
  $B5B6,$01 Set flags.
  $B5B7,$02 #REGhl-=#REGde (with carry).
  $B5B9,$02 Jump to #R$B607 if the result is zero.
  $B5BB,$02 Stash #REGix on the stack.
  $B5BD,$03 Call #R$9619.
  $B5C0,$03 #REGa=*#R$99A5.
  $B5C3,$02 Restore #REGix from the stack.
  $B5C5,$03 Merge the bits of #REGa with *#REGix+#N$04.
  $B5C8,$02 Jump to #R$B5BB if the result is zero.
  $B5CA,$04 Jump to #R$B5BB if #REGa is equal to #N$40.
  $B5CE,$03 Write #REGa to *#REGix+#N$04.
  $B5D1,$05 #REGix+=#N($0006,$04,$04).
  $B5D6,$02 Decrease counter by one and loop back to #R$B5AD until counter is zero.
  $B5D8,$06 Write #N$7BA4 to *#N$725C.
  $B5DE,$06 Write #N$7260 to *#R$99B8.
  $B5E4,$02 #REGa=#N$01.
  $B5E6,$03 Write #REGa to *#R$7258.
  $B5E9,$01 Decrease #REGa by one.
  $B5EA,$03 Write #REGa to *#R$99AA.
  $B5ED,$03 Call #R$9929.
  $B5F0,$04 #REGix=#R$B623.
  $B5F4,$07 Write #N($0020,$04,$04) to *#R$926E.
  $B5FB,$07 Write #N$7400 to *#R$99B8.
  $B602,$02 #REGb=#N$09.
  $B604,$03 Jump to #R$9226.
  $B607,$02 Stash #REGix on the stack.
  $B609,$03 #REGde=#R$FF44.
  $B60C,$01 Restore #REGhl from the stack.
  $B60D,$01 #REGhl+=#REGde.
  $B60E,$01 #REGa=*#REGhl.
  $B60F,$02,b$01 Keep only bits 0-2.
  $B611,$03 RLCA.
  $B614,$01 #REGc=#REGa.
  $B615,$01 #REGa=*#REGhl.
  $B616,$02,b$01 Keep only bits 3-5.
  $B618,$03 RRCA.
  $B61B,$01 #REGe=#REGa.
  $B61C,$01 #REGa=*#REGhl.
  $B61D,$02,b$01 Keep only bits 6.
  $B61F,$01 Set the bits from #REGc.
  $B620,$01 Set the bits from #REGe.
  $B621,$02 Jump to #R$B5CE.
B $B623

c $B69D Handler: Madrid
@ $B69D label=Handler_Madrid
  $B69D,$03 Call #R$B7A9.
  $B6A0,$03 Call #R$B6A7.
  $B6A3,$03 Call #R$B6BC.
  $B6A6,$01 Return.

c $B6A7

c $B6BC Handler: Bull
@ $B6BC label=Handler_Bull
N $B6BC See #POKE#bull(The Bull Doesn't Kill).
  $B6BC,$07 Jump to #R$B6C8 if the player has not been hit by the bull.
  $B6C3,$04 #REGsp=*#R$99AE.
  $B6C7,$01 Return.
N $B6C8 The player is still alive!
@ $B6C8 label=Handler_Bull_Play
  $B6C8,$05 Write #N$00 to *#R$99AA.
  $B6CD,$04 #REGix=#R$7258.
  $B6D1,$07 Jump to #R$B6DB if *#R$7207 is equal to #N$01.
  $B6D8,$03 Return if *#R$7207 is not equal to #N$05.
  $B6DB,$03 Decrease *#REGix+#N$00 by one.
  $B6DE,$03 Jump to #R$B77E if #REGa is not zero.
  $B6E1,$04 Write #N$01 to *#REGix+#N$00.
  $B6E5,$03 #REGhl=#R$7258.
  $B6E8,$03 Call #R$9439.
  $B6EB,$04 Test bit 5 of *#REGix+#N$06.
  $B6EF,$02 Jump to #R$B721 if #REGa is not zero.
  $B6F1,$03 Decrease *#REGix+#N$07 by one.
  $B6F4,$02 Jump to #R$B727 if #REGa is zero.
  $B6F6,$03 #REGl=*#REGix+#N$01.
  $B6F9,$03 #REGh=*#REGix+#N$02.
  $B6FC,$03 Call #R$9375.
  $B6FF,$02,b$01 Keep only bits 0 and 6.
  $B701,$02 Jump to #R$B70F if #REGa is zero.
  $B703,$04 Jump to #R$B727 if #REGa is equal to #N$01.
N $B707 See #POKE#bull(The Bull Doesn't Kill).
  $B707,$05 Write #EVAL($08,$02,$08) ("Hit By The Bull") to *#R$EFFA.
  $B70C,$03 Jump to #R$9926.
  $B70F,$05 Jump to #R$B727 if #N$7A is equal to #REGh.
  $B714,$03 Write #REGl to *#REGix+#N$04.
  $B717,$03 Write #REGh to *#REGix+#N$05.
  $B71A,$04 Set bit 5 of *#REGix+#N$06.
  $B71E,$03 Jump to #R$9926.
  $B721,$04 Reset bit 5 of *#REGix+#N$06.
  $B725,$02 Jump to #R$B71E.
  $B727,$03 Call #R$97D7.
  $B72A,$04 Jump to #R$B731 if #REGh is higher than #REGl.
  $B72E,$01 #REGa=#REGc.
  $B72F,$01 #REGc=#REGb.
  $B730,$01 #REGb=#REGa.
  $B731,$03 #REGa=*#REGix+#N$06.
  $B734,$02,b$01 Keep only bits 3-4.
  $B736,$02,b$01 Flip bit 4.
  $B738,$01 Compare #REGa with #REGb.
  $B739,$02 Jump to #R$B73C if #REGa is not zero.
  $B73B,$01 #REGb=#REGc.
  $B73C,$03 Write #REGb to *#REGix+#N$06.
  $B73F,$03 Call #R$9619.
  $B742,$03 #REGa=*#R$99A5.
  $B745,$02,b$01 Keep only bits 0-1.
  $B747,$02 Jump to #R$B755 if #REGa is zero.
  $B749,$02 #REGa+=#N$05.
  $B74B,$04 #REGix=#R$7258.
  $B74F,$03 Write #REGa to *#REGix+#N$07.
  $B752,$03 Jump to #R$B71E.
  $B755,$03 Call #R$9619.
  $B758,$03 #REGa=*#R$99A5.
  $B75B,$02,b$01 Keep only bits 1-4.
  $B75D,$02 #REGa+=#N$0A.
  $B75F,$03 Write #REGa to *#R$7258.
  $B762,$04 #REGix=#R$7258.
  $B766,$03 #REGa=*#REGix+#N$06.
  $B769,$02,b$01 Keep only bits 3-4.
  $B76B,$01 RRCA.
  $B76C,$03 #REGhl=#R$BA4E.
  $B76F,$01 #REGe=#REGa.
  $B770,$02 #REGd=#N$00.
  $B772,$01 #REGhl+=#REGde.
  $B773,$03 #REGde=#R$72B0.
  $B776,$03 #REGbc=#N($0004,$04,$04).
  $B779,$02 LDIR.
  $B77B,$03 Jump to #R$B71E.
  $B77E,$03 #REGa=*#REGix+#N$00.
  $B781,$02,b$01 Keep only bits 0-1.
  $B783,$01 Return if {} is not zero.
  $B784,$04 #REGix=*#R$72B0.
  $B788,$03 #REGe=*#REGix+#N$00.
  $B78B,$03 #REGd=*#REGix+#N$01.
  $B78E,$03 #REGhl=*#R$72B2.
  $B791,$01 Exchange the #REGde and #REGhl registers.
  $B792,$03 Write #REGhl to *#R$72B2.
  $B795,$03 Write #REGe to *#REGix+#N$00.
  $B798,$03 Write #REGd to *#REGix+#N$01.
  $B79B,$04 #REGix=#R$7258.
  $B79F,$03 #REGl=*#REGix+#N$04.
  $B7A2,$03 #REGh=*#REGix+#N$05.
  $B7A5,$03 Call #R$9914.
  $B7A8,$01 Return.

c $B7A9
  $B7A9,$04 #REGix=#R$7258.
  $B7AD,$03 Call #R$97D7.
  $B7B0,$01 #REGa=#REGh.
  $B7B1,$01 Set the bits from #REGl.
  $B7B2,$03 #REGhl=#R$7200.
  $B7B5,$02 Reset bit 7 of *#REGhl.
  $B7B7,$02 Compare #REGa with #N$08.
  $B7B9,$02 Jump to #R$B7C2 if #REGa is higher.
  $B7BB,$02 Set bit 7 of *#REGhl.
  $B7BD,$03 #REGhl=#R$EFFF.
  $B7C0,$02 Set bit 2 of *#REGhl.
  $B7C2,$03 Call #R$9619.
  $B7C5,$03 #REGa=*#R$99A5.
  $B7C8,$02,b$01 Keep only bits 1-7.
  $B7CA,$02 Compare #REGa with #N$BF.
  $B7CC,$02 Jump to #R$B7C2 if #REGa is higher.
  $B7CE,$01 #REGl=#REGa.
  $B7CF,$02 #REGh=#N$00.
  $B7D1,$01 #REGe=#REGl.
  $B7D2,$02 #REGd=#N$00.
  $B7D4,$01 #REGhl+=#REGhl.
  $B7D5,$01 #REGhl+=#REGde.
  $B7D6,$01 Stash #REGde on the stack.
  $B7D7,$03 #REGde=#N$6242.
  $B7DA,$01 #REGhl+=#REGde.
  $B7DB,$01 Stash #REGhl on the stack.
  $B7DC,$01 #REGa=*#REGhl.
  $B7DD,$01 Increment #REGhl by one.
  $B7DE,$01 #REGh=*#REGhl.
  $B7DF,$03 #REGde=#R$B4C2.
  $B7E2,$01 #REGl=#REGa.
  $B7E3,$02 #REGhl-=#REGde (with carry).
  $B7E5,$01 #REGa=#REGl.
  $B7E6,$02 Compare #REGa with #N$20.
  $B7E8,$02 Jump to #R$B7ED if #REGa is lower.
  $B7EA,$02 Restore #REGhl and #REGhl from the stack.
  $B7EC,$01 Return.
  $B7ED,$03 #REGhl=#R$7200.
  $B7F0,$02,b$01 Set bit 4.
  $B7F2,$02 Test bit 7 of *#REGhl.
  $B7F4,$02 Jump to #R$B7F8 if #REGa is not zero.
  $B7F6,$02,b$01 Flip bit 4.
  $B7F8,$01 #REGe=#REGa.
  $B7F9,$02 #REGd=#N$00.
  $B7FB,$03 #REGhl=#R$B4C2.
  $B7FE,$01 #REGhl+=#REGde.
  $B7FF,$02 Restore #REGix from the stack.
  $B801,$03 Write #REGl to *#REGix+#N$00.
  $B804,$03 Write #REGh to *#REGix+#N$01.
  $B807,$01 Restore #REGhl from the stack.
  $B808,$04 #REGhl+=#R$78C0.
  $B80C,$03 Jump to #R$9914.

b $B80F
  $BA4E

b $BA76 Sub-Game Data: Munich
@ $BA76 label=Munich_Data
D $BA76 #PUSHS #UDGTABLE { #LOCATION($8EC9)(munich) } UDGTABLE# #POPS
W $BA81,$02
W $BA83,$02
@ $BA83 label=Munich_SubGame
W $BA85,$02
@ $BA85 label=Munich_SetUp

c $BAB5 Initialise: Munich
@ $BAB5 label=Initialise_Munich
  $BAB5,$02 #REGc=#N$48.
  $BAB7,$04 #REGix=#R$6240.
  $BABB,$03 #REGde=#N($0006,$04,$04).
  $BABE,$03 #REGhl=#R$BD4A.
  $BAC1,$02 #REGb=#N$08.
  $BAC3,$01 #REGa=*#REGhl.
  $BAC4,$01 RLCA.
  $BAC5,$02 Jump to #R$BACB if  is higher.
  $BAC7,$04 Set bit 7 of *#REGix+#N$00.
  $BACB,$02 #REGix+=#REGde.
  $BACD,$02 Decrease counter by one and loop back to #R$BAC4 until counter is zero.
  $BACF,$01 Increment #REGhl by one.
  $BAD0,$01 Decrease #REGc by one.
  $BAD1,$02 Jump to #R$BAC1 if #REGc is not zero.
  $BAD3,$06 Write #R$9A92 to *#R$99BA.
  $BAD9,$02 #REGb=#N$22.
  $BADB,$04 #REGix=#R$BD92.
  $BADF,$07 Write #N($0018,$04,$04) to *#R$926E.
  $BAE6,$07 Write #R$7240 to *#R$99B8.
  $BAED,$03 Call #R$9226.
  $BAF0,$02 #REGb=#N$09.
  $BAF2,$07 Write #N($0030,$04,$04) to *#R$926E.
  $BAF9,$03 Call #R$9226.
  $BAFC,$08 Write #N$07 to: #LIST { *#N$6192 } { *#N$6198 } LIST#
  $BB04,$01 Return.

c $BB05 Handler: Munich
@ $BB05 label=Handler_Munich
B $BD36
B $BD4A

b $C146 Sub-Game Data: Hong Kong
@ $C146 label=HongKong_Data
D $C146 #PUSHS #UDGTABLE { #LOCATION($8F2D)(hong-kong) } UDGTABLE# #POPS
W $C151,$02
W $C153,$02
@ $C153 label=HongKong_SubGame
W $C155,$02
@ $C155 label=HongKong_SetUp

c $C172 Initialise: Hong Kong
@ $C172 label=HongKong_Initialise

c $C36B Handler: Hong Kong
@ $C36B label=Handler_HongKong

b $C753 Sub-Game Data: Moscow
@ $C753 label=Moscow_Data
D $C753 #PUSHS #UDGTABLE { #LOCATION($8EE1)(moscow) } UDGTABLE# #POPS
W $C75E,$02
W $C760,$02
@ $C760 label=Moscow_SubGame
W $C762,$02
@ $C762 label=Moscow_SetUp

c $C77F Initialise: Moscow
@ $C77F label=Moscow_Initialise
  $C77F,$03 #REGhl=#N$7AC4.
  $C782,$05 Write #N$00 to *#R$99AA.
  $C787,$03 #REGbc=#N$0408.
@ $C78A label=Moscow_Initialise_Loop
  $C78A,$04 #REGix=*#R$99E3.
  $C78E,$03 Write #REGl to *#REGix+#N$04.
  $C791,$03 Write #REGh to *#REGix+#N$05.
  $C794,$03 Write #REGc to *#REGix+#N$06.
  $C797,$03 Write #REGb to *#REGix+#N$07.
  $C79A,$02 Stash #REGhl and #REGbc on the stack.
  $C79C,$03 #REGhl=*#R$99E3.
  $C79F,$03 Call #R$9439.
  $C7A2,$03 Call #R$9929.
  $C7A5,$03 #REGhl=*#R$99E3.
  $C7A8,$04 #REGhl+=#N($0038,$04,$04).
  $C7AC,$03 Write #REGhl to *#R$99E3.
  $C7AF,$02 Restore #REGbc and #REGhl from the stack.
  $C7B1,$02 Increment #REGhl by two.
  $C7B3,$02 Decrease counter by one and loop back to #R$C78A until counter is zero.
  $C7B5,$01 Return.

c $C7B6 Handler: Moscow
@ $C7B6 label=Handler_Moscow

c $C824 Handler: Moscow2
@ $C824 label=Handler_Moscow2
N $C824 See #POKE#moscow(You Are Not Deported From Moscow).
  $C824,$04 Jump to #R$C832 if #REGa is not equal to #N$40.
  $C828,$03 #REGhl=#R$EFFA.
  $C82B,$02 Set bit 2 of *#REGhl.
  $C82D,$04 #REGsp=*#N$99AE.
  $C831,$01 Return.
  $C832,$03 Call #R$97D7.
  $C835,$03 #REGa=*#REGix+#N$06.
  $C838,$01 Compare #REGa with #REGc.
  $C839,$01 #REGa=#REGc.
  $C83A,$02 Jump to #R$C83D if #REGa is not zero.
  $C83C,$04 Write #REGb to *#REGix+#N$06.
  $C840,$03 Call #R$C846.
  $C843,$03 Jump to #R$9926.
  $C846,$03 Call #R$9619.
  $C849,$02,b$01 Keep only bits 0-1.
  $C84B,$01 Increment #REGa by one.
  $C84C,$04 #REGix=*#R$99E3.
  $C850,$03 Write #REGa to *#REGix+#N$07.
  $C853,$01 Return.
  $C854,$05 Write #N$00 to *#R$99AA.
  $C859,$03 Call #R$980E.
  $C85C,$03 Call #R$98AB.
  $C85F,$02 #REGb=#N$78.
  $C861,$01 #REGa=#REGc.
  $C862,$02,b$01 Set bits 6-7.
  $C864,$01 #REGc=#REGa.
  $C865,$03 Call #R$98F2.
  $C868,$01 Return.

b $C869

b $C9DD Sub-Game Data: Alice Springs
@ $C9DD label=AliceSprings_Data
D $C9DD #PUSHS #UDGTABLE { #LOCATION($8F48)(alice-springs) } UDGTABLE# #POPS
W $C9E8,$02
W $C9EA,$02 Location subgame routine.
@ $C9EA label=AliceSprings_SubGame
W $C9EC,$02 Initialisation routine.
@ $C9EC label=AliceSprings_SetUp

c $CA09

b $D1E8 Sub-Game Data: Samoa
@ $D1E8 label=Samoa_Data
D $D1E8 #PUSHS #UDGTABLE { #LOCATION($8F67)(samoa) } UDGTABLE# #POPS
W $D1F3,$02
W $D1F5,$02 Location subgame routine.
@ $D1F5 label=Samoa_SubGame
W $D1F7,$02 Initialisation routine.
@ $D1F7 label=Samoa_SetUp

c $D214 Initialise: Samoa
@ $D214 label=Samoa_Initialise

c $D5AC Handler: Samoa
@ $D5AC label=Handler_Samoa
B $D66C

b $D67D Sub-Game Data: Benares
@ $D67D label=Benares_Data
D $D67D #PUSHS #UDGTABLE { #LOCATION($8F14)(benares) } UDGTABLE# #POPS
W $D688,$02
W $D68A,$02 Location subgame routine.
@ $D68A label=Benares_SubGame
W $D68C,$02 Initialisation routine.
@ $D68C label=Benares_SetUp

b $DA90 Sub-Game Data: Chichen Itza
@ $DA90 label=ChichenItza_Data
D $DA90 #PUSHS #UDGTABLE { #LOCATION($8F7E)(chichen-itza) } UDGTABLE# #POPS
W $DA9B,$02
W $DA9D,$02 Location subgame routine.
@ $DA9D label=ChichenItza_SubGame
W $DA9F,$02 Initialisation routine.
@ $DA9F label=ChichenItza_SetUp

b $DE4C Sub-Game Data: New Orleans
@ $DE4C label=NewOrleans_Data
D $DE4C #PUSHS #UDGTABLE { #LOCATION($8F9C)(new-orleans) } UDGTABLE# #POPS
W $DE57,$02
W $DE59,$02 Location subgame routine.
@ $DE59 label=NewOrleans_SubGame
W $DE5B,$02 Initialisation routine.
@ $DE5B label=NewOrleans_SetUp

b $E10B Sub-Game Data: Kanyu
@ $E10B label=Kanyu_Data
D $E10B #PUSHS #UDGTABLE { #LOCATION($8FB9)(kanyu) } UDGTABLE# #POPS
W $E116,$02
W $E118,$02 Location subgame routine.
@ $E118 label=Kanyu_SubGame
W $E11A,$02 Initialisation routine.
@ $E11A label=Kanyu_SetUp

c $E137 Initialise: Kanyu
@ $E137 label=Kanyu_Initialise
  $E137,$06 Write #N$79D6 to *#N$74E4.
  $E13D,$05 Write #N$01 to *#N$723A.
  $E142,$03 #REGhl=#N$74E0.
  $E145,$02 Write #N$32 to *#REGhl.
  $E147,$03 Call #R$9439.
  $E14A,$03 Call #R$9929.
  $E14D,$07 Write #N$7240 to *#R$99B8.
  $E154,$07 Write #N($0040,$04,$04) to *#R$926E.
  $E15B,$04 #REGix=#R$E32F.
  $E15F,$02 #REGb=#N$04.
  $E161,$03 Call #R$9226.
  $E164,$07 Write #N($0010,$04,$04) to *#R$926E.
  $E16B,$02 #REGb=#N$05.
  $E16D,$03 Call #R$9226.
  $E170,$07 Write #N($0008,$04,$04) to *#R$926E.
  $E177,$02 #REGb=#N$06.
  $E179,$03 Call #R$9226.
  $E17C,$07 Write #N($0048,$04,$04) to *#R$926E.
  $E183,$02 #REGb=#N$01.
  $E185,$03 Call #R$9226.
  $E188,$07 Write #N($0030,$04,$04) to *#R$926E.
  $E18F,$02 #REGb=#N$04.
  $E191,$03 Jump to #R$9226.

c $E194 Handler: Kanyu
@ $E194 label=Handler_Kanyu
B $E32F
B $E48F

b $E716 Sub-Game Data: Sao Paulo
@ $E716 label=SaoPaulo_Data
D $E716 #PUSHS #UDGTABLE { #LOCATION($8FD0)(sao-paulo) } UDGTABLE# #POPS
W $E721,$02
W $E723,$02 Location subgame routine.
@ $E723 label=SaoPaulo_SubGame
W $E725,$02 Initialisation routine.
@ $E725 label=SaoPaulo_SetUp

c $E755 Initialise: Sao Paulo
@ $E755 label=SaoPaulo_Initialise

c $E7C3 Handler: Sao Paulo
@ $E7C3 label=Handler_SaoPaulo

b $E89B

b $EFDD

b $EFDE

g $EFE0 Active Key Map
@ $EFE0 label=ActiveKeyMap
N $EFE0 Right.
N $EFE3 Down.
N $EFE6 Left.
N $EFE9 Up.
N $EFEC Fire.
B $EFE0,$01 Port.
B $EFE1,$01 Key value.
B $EFE2,$01 Modifier.
L $EFE0,$03,$05,$02

g $EFEF

g $EFF2 Pointer: Active Player
@ $EFF2 label=Pointer_ActivePlayer
D $EFF2 Points to either #R$8C28 or #R$8C38.
W $EFF2,$02

g $EFF4 Active Player Score
@ $EFF4 label=ActivePlayerScore
B $EFF4,$03,$01

g $EFF7 Active Player Cash
@ $EFF7 label=ActivePlayerCash_01
@ $EFF8 label=ActivePlayerCash_02
B $EFF7,$02,$01

b $EFF9

g $EFFA Game State #1
@ $EFFA label=GameState_1
D $EFFA #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | }
. { #N$01 | Has Bonus Points? }
. { #N$02 | Deported From Russia }
. { #N$03 | Hit By The Bull }
. { #N$04 | Stranded }
. { #N$05 | Can't Afford To Fly }
. { #N$06 | Completed All Locations }
. { #N$07 | Flying To New Destination }
. TABLE#
B $EFFA,$01

g $EFFB Game State #2
@ $EFFB label=GameState_2
D $EFFB #TABLE(default,centre,centre)
. { =h Bit | =h Meaning }
. { #N$00 | Ticker On/ Off }
. { #N$01 | Flightpath In-Progress/ Complete }
. { #N$02 | }
. { #N$03 | }
. { #N$04 | Used for printing scores/ stripping off leading zeroes }
. { #N$05 | 1UP/ 2UP Game }
. { #N$06 | }
. { #N$07 | }
. TABLE#
B $EFFB,$01

b $EFFC

b $EFFD

b $EFFE

b $EFFF
b $F000

b $F840 Font UDGs
@ $F840 label=Font
  $F840,$08 #UDG(#PC,attr=56)
L $F840,$08,$5B

  $FF44

c $FFC7
