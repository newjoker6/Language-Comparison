// Includes
#include "template.h"
#include <iostream>
#include <string>
#include <map>

// Namespace
using namespace AGK;
using namespace std;

app App;

// Gloabl Variables
string name$ = agk::GetAppName();
string test$ = "my test";

// Database
map<string, string> database;

//create database as array using record type


// Password Selection Pool
//uString AlphaChoice$ = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0,!,@,#,$,%,^,&,*,(,),-,=,_,+";
const char alphanum[] = "0123456789!@#$%^&*abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

// Box IDs
int WebsiteField;
int PasswordField;
int EmailField;

void app::Begin(void)
{
	agk::SetVirtualResolution (768 / 1.4, 768 / 1.4 );
	agk::SetClearColor( 33,33,33 ); // dark grey
	agk::SetSyncRate(30,0);
	agk::SetScissor(0,0,0,0);
	agk::SetWindowTitle("Password Manager");
	agk::SetWindowAllowResize(1);

	// Create and show lock image
	int Lock = agk::LoadImage("lock.png");
	agk::CreateSprite(1, Lock);
	agk::SetSpritePosition(1, agk::GetVirtualWidth() / 2 - agk::GetSpriteWidth(1) / 2, agk::GetVirtualHeight() / 2 - agk::GetSpriteHeight(1) / 2 - 150);
	
	// Create Text Labels
	int WebsiteLabel = agk::CreateText("Website:");
	agk::SetTextSize(WebsiteLabel, 15);
	agk::SetTextPosition(WebsiteLabel, agk::GetVirtualWidth() / 2 - 250, agk::GetVirtualHeight() / 2);

	int EmailLabel = agk::CreateText("Email:");
	agk::SetTextSize(EmailLabel, 15);
	agk::SetTextPosition(EmailLabel, agk::GetVirtualWidth() / 2 - 250, agk::GetVirtualHeight() / 2 + 40);

	int PasswordLabel = agk::CreateText("Password:");
	agk::SetTextSize(PasswordLabel, 15);
	agk::SetTextPosition(PasswordLabel, agk::GetVirtualWidth() / 2 - 250, agk::GetVirtualHeight() / 2 + 80);

	// Create text fields
	WebsiteField = agk::CreateEditBox();
	agk::SetEditBoxSize(WebsiteField, 250, 20);
	agk::SetEditBoxPosition(WebsiteField, agk::GetVirtualWidth() / 2 - 150, agk::GetVirtualHeight() / 2);

	EmailField = agk::CreateEditBox();
	agk::SetEditBoxSize(EmailField, 350, 20);
	agk::SetEditBoxPosition(EmailField, agk::GetVirtualWidth() / 2 - 150, agk::GetVirtualHeight() / 2 + 40);

	PasswordField = agk::CreateEditBox();
	agk::SetEditBoxSize(PasswordField, 250, 20);
	agk::SetEditBoxPosition(PasswordField, agk::GetVirtualWidth() / 2 - 150, agk::GetVirtualHeight() / 2 + 80);

	// Create Buttons
	agk::AddVirtualButton(8, 0, 0, 10);
	agk::SetVirtualButtonText(8, "Search");
	agk::SetVirtualButtonPosition(8, agk::GetVirtualWidth() / 2 + 140, agk::GetVirtualHeight() / 2 + 10);
	agk::SetVirtualButtonSize(8, 50, 30);
	agk::SetVirtualButtonColor(8, 80, 80, 90);

	agk::AddVirtualButton(9, 0, 0, 10);
	agk::SetVirtualButtonText(9, "Generate");
	agk::SetVirtualButtonPosition(9, agk::GetVirtualWidth() / 2 + 195, agk::GetVirtualHeight() / 2 + 90);
	agk::SetVirtualButtonSize(9, 50, 30);
	agk::SetVirtualButtonColor(9, 80, 80, 90);

	agk::AddVirtualButton(10, 0, 0, 10);
	agk::SetVirtualButtonText(10, "Show");
	agk::SetVirtualButtonPosition(10, agk::GetVirtualWidth() / 2 + 140, agk::GetVirtualHeight() / 2 + 90);
	agk::SetVirtualButtonSize(10, 50, 30);
	agk::SetVirtualButtonColor(10, 80, 80, 90);

	agk::AddVirtualButton(12, 0, 0, 10);
	agk::SetVirtualButtonText(12, "Hide");
	agk::SetVirtualButtonPosition(12, agk::GetVirtualWidth() / 2 + 140, agk::GetVirtualHeight() / 2 + 90);
	agk::SetVirtualButtonSize(12, 50, 30);
	agk::SetVirtualButtonColor(12, 80, 80, 90);

	agk::AddVirtualButton(11, 0, 0, 10);
	agk::SetVirtualButtonText(11, "Add");
	agk::SetVirtualButtonPosition(11, agk::GetVirtualWidth() / 2 + 30, agk::GetVirtualHeight() / 2 + 125);
	agk::SetVirtualButtonSize(11, 360, 30);
	agk::SetVirtualButtonColor(11, 80, 80, 90);
}

void RandomizeSeed()
{
	int seednum = agk::Random();
	agk::SetRandomSeed(seednum);
}

void GeneratePassword()
{
	string genpass;
	genpass = "";

	for (int i = 0; i < 12; i++)
	{
		genpass = genpass + alphanum[rand() % sizeof(alphanum) - 1];
	}
	char buffer[50];
	strcpy(buffer, genpass.c_str());
	agk::SetEditBoxText(PasswordField, buffer);
}

int app::Loop(void)
{
	agk::Print(PasswordField);
	// Show and Hide button swap and enable/disable secret
	if (agk::GetVirtualButtonPressed(10))
	{
		agk::SetEditBoxPasswordMode(PasswordField, 0);
		agk::SetVirtualButtonPosition(10, 40000, agk::GetVirtualHeight() / 2 + 90);
		agk::SetVirtualButtonPosition(12, agk::GetVirtualWidth() / 2 + 140, agk::GetVirtualHeight() / 2 + 90);
	}

	if(agk::GetVirtualButtonPressed(12))
	{
		agk::SetEditBoxPasswordMode(PasswordField, 1);
		agk::SetVirtualButtonPosition(12, 40000, agk::GetVirtualHeight() / 2 + 90);
		agk::SetVirtualButtonPosition(10, agk::GetVirtualWidth() / 2 + 140, agk::GetVirtualHeight() / 2 + 90);
	}

	// Generate Password when generate button is pressed
	if (agk::GetVirtualButtonPressed(9))
	{
		GeneratePassword();
	}

	// Add record to database
	if (agk::GetVirtualButtonPressed(11))
	{
		string site = agk::GetEditBoxText(WebsiteField);
		database[site + "User"] = agk::GetEditBoxText(EmailField);
		database[site + "Pass"] = agk::GetEditBoxText(PasswordField);

	}

	// Find Record
	if (agk::GetVirtualButtonPressed(8))
	{
		string website;
		website = agk::GetEditBoxText(WebsiteField);
		string username = database[website + "User"];
		string password = database[website + "Pass"];


		agk::SetEditBoxText(EmailField, username.c_str());
		agk::SetEditBoxText(PasswordField, password.c_str());
	}

	agk::Sync();

	return 0; // return 1 to close app
}


void app::End (void)
{

}
