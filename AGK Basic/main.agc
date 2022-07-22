
// Project: Password Manager 
// Created: 22-07-22

// Sets Folder name for saved data
#company_name "Password Manager"


// show all errors
SetErrorMode(2)


// set window properties
SetWindowTitle( "Password Manager" )
SetWindowSize( 768, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window


// set display properties
SetVirtualResolution( 768/1.4, 768/1.4 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 )
SetClearColor(33,33,33)


// Create and show lock image
lock = LoadImage("lock.png")
CreateSprite(1, lock)
SetSpritePosition(1, GetVirtualWidth()/2 - GetSpriteWidth(1)/2, GetVirtualHeight()/2 - GetSpriteHeight(1)/2 - 150)

// Create Text labels
WebsiteLabel = CreateText("Website:")
SetTextSize(WebsiteLabel, 25)
SetTextPosition(WebsiteLabel, GetVirtualWidth()/2 - 250, GetVirtualHeight()/2)

EmailLabel = CreateText("Email:")
SetTextSize(EmailLabel, 25)
SetTextPosition(EmailLabel, GetVirtualWidth()/2 - 250, GetVirtualHeight()/2 + 40)

PasswordLabel = CreateText("Password:")
SetTextSize(PasswordLabel, 25)
SetTextPosition(PasswordLabel, GetVirtualWidth()/2 - 250, GetVirtualHeight()/2 + 80)


// Create text fields
WebsiteField = CreateEditBox()
SetEditBoxSize(WebsiteField, 250, 20)
SetEditBoxPosition(WebsiteField, GetVirtualWidth()/2 - 150, GetVirtualHeight()/2)

EmailField = CreateEditBox()
SetEditBoxSize(EmailField, 350, 20)
SetEditBoxPosition(EmailField, GetVirtualWidth()/2 - 150, GetVirtualHeight()/2 + 40)

PasswordField = CreateEditBox()
SetEditBoxSize(PasswordField, 250, 20)
SetEditBoxPosition(PasswordField, GetVirtualWidth()/2 - 150, GetVirtualHeight()/2 + 80)
print(Str(PasswordField))


// Create Buttons
AddVirtualButton(8, 0, 0, 10)
SetVirtualButtonText(8, "Search")
SetVirtualButtonPosition(8, GetVirtualWidth()/2 + 140, GetVirtualHeight()/2 + 10)
SetVirtualButtonSize(8, 50, 30)
SetVirtualButtonColor( 8, 50, 50, 60 )

AddVirtualButton(9, 0, 0, 10)
SetVirtualButtonText(9, "Generate")
SetVirtualButtonPosition(9, GetVirtualWidth()/2 + 195, GetVirtualHeight()/2 + 90)
SetVirtualButtonSize(9, 50, 30)
SetVirtualButtonColor( 9, 50, 50, 60 )

AddVirtualButton(10, 0, 0, 10)
SetVirtualButtonText(10, "Show")
SetVirtualButtonPosition(10, GetVirtualWidth()/2 + 140, GetVirtualHeight()/2 + 90)
SetVirtualButtonSize(10, 50, 30)
SetVirtualButtonColor( 10, 50, 50, 60 )

AddVirtualButton(12, 0, 0, 10)
SetVirtualButtonText(12, "Hide")
SetVirtualButtonPosition(12, GetVirtualWidth()/2 + 140, GetVirtualHeight()/2 + 90)
SetVirtualButtonSize(12, 50, 30)
SetVirtualButtonColor( 12, 50, 50, 60 )

AddVirtualButton(11, 0, 0, 10)
SetVirtualButtonText(11, "Add")
SetVirtualButtonPosition(11, GetVirtualWidth()/2+30, GetVirtualHeight()/2 + 125)
SetVirtualButtonSize(11, 360, 30)
SetVirtualButtonColor( 11, 50, 50, 60 )


// Database
#constant max_records = 100
global current_record = 1
global total_records = 1

type record
	website as string
	username as string
	password as string
endtype


//create database as array using record type
global database as record[max_records]


// Randomize Seed
function RandomizeSeed()
	seednum = Random()
	SetRandomSeed(seednum)
endfunction


// Password Selection Pool
Global AlphaChoice$ = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0,!,@,#,$,%,^,&,*,(,),-,=,_,+"


// Password Generation Function
function GeneratePassword()
	pass$ = ""
	RandomizeSeed()
	
	// For loop
	for i = 1 to Random(8, 16) 
		char$ = GetStringToken(AlphaChoice$, ",", Random(1, len(AlphaChoice$)/2+1))
		pass$ = pass$ + char$
	next i
	
	SetEditBoxText(100003, pass$)
endfunction


// Save database
function save_data()
	OpenToWrite(999, "data.dat", 0)
	WriteInteger(999, total_records)
	for i=1 to max_records
		WriteString(999, database[i].website)
		WriteString(999, database[i].username)
		WriteString(999, database[i].password)
	next i
	CloseFile(999)
endfunction


// Load Database
function load_data()
	
	if GetFileExists("data.dat")
		OpenToRead(999, "data.dat")
		total_records = ReadInteger(999)
		for i=1 to max_records
			database[i].website = ReadString(999)
			database[i].username = ReadString(999)
			database[i].password = ReadString(999)
		next i
		CloseFile(999)
		current_record = total_records + 1

	endif
	
endfunction



load_data()

do
	// Show and Hide button swap and enable/disable secret
    if GetVirtualButtonPressed(10)
		SetEditBoxPasswordMode(PasswordField, 0)
		SetVirtualButtonPosition(10, 40000, GetVirtualHeight()/2 + 90)
		SetVirtualButtonPosition(12, GetVirtualWidth()/2 + 140, GetVirtualHeight()/2 + 90)
    	endif
    	
    	if GetVirtualButtonPressed(12)
		SetEditBoxPasswordMode(PasswordField, 1)
		SetVirtualButtonPosition(12, 40000, GetVirtualHeight()/2 + 90)
		SetVirtualButtonPosition(10, GetVirtualWidth()/2 + 140, GetVirtualHeight()/2 + 90)
    	endif
    	
    	// Generate Password when generate button is pressed
    	if GetVirtualButtonPressed(9)
    		GeneratePassword()
    	endif
    	
    	// Add record to database
    	if GetVirtualButtonPressed(11):
    		if total_records <> max_records:
	    		database[current_record].website = GetEditBoxText(WebsiteField)
	    		database[current_record].username = GetEditBoxText(EmailField)
	    		database[current_record].password = GetEditBoxText(PasswordField)
	    		inc total_records
	    		current_record = total_records + 1
	    		save_data()
    		endif
	endif
    	
    	// Find record
    	if GetVirtualButtonPressed(8)
    		temp as string[100]		
    		for i=1 to max_records
    			temp[i] = database[i].website
		next i
		index = temp.indexof(GetEditBoxText(WebsiteField))
		if index = -1
			index = 0
			print("NO RECORD")
		endif
		SetEditBoxText(EmailField, database[index].username)
		SetEditBoxText(PasswordField, database[index].password)

	endif
    	
    Sync()
loop
