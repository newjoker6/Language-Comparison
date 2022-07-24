#include "cMain.h"
#include <map>
using namespace std;


wxBEGIN_EVENT_TABLE(cMain, wxFrame)
EVT_BUTTON(10001, OnHideButtonClicked)
EVT_BUTTON(10002, OnAddButtonClicked)
EVT_BUTTON(10003, OnSearchButtonClicked)
EVT_BUTTON(10004, OnGenerateButtonClicked)
END_EVENT_TABLE()

bool passwordhide = FALSE;

map<wxString, wxString> database;

const char alphanum[] = "0123456789!@#$%^&*abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
int string_length = sizeof(alphanum) - 1;

cMain::cMain() : wxFrame(nullptr, wxID_ANY, "Password Manager", wxPoint(30, 30), wxSize(800, 600))
{
	m_pnl1 = new wxPanel(this, wxID_ANY, wxDefaultPosition, wxSize(800, 600));
	m_pnl1->SetBackgroundColour(wxColour(*wxLIGHT_GREY));


	m_btn1 = new wxButton(m_pnl1, 10003, "Search", wxPoint(450, 300), wxSize(60, 20));
	m_txt1 = new wxTextCtrl(m_pnl1, wxID_ANY, "", wxPoint(250, 300), wxSize(195, 20));
	m_stxt1 = new wxStaticText(m_pnl1, wxID_ANY, "Website", wxPoint(190, 300), wxSize(50, 30));
	m_stxt1->SetBackgroundColour(wxColour(*wxLIGHT_GREY));
	m_stxt1->SetForegroundColour(wxColour(*wxBLACK));

	m_txt2 = new wxTextCtrl(m_pnl1, wxID_ANY, "", wxPoint(250, 325), wxSize(260, 20));
	m_stxt2 = new wxStaticText(m_pnl1, wxID_ANY, "Email", wxPoint(190, 325), wxSize(50, 30));
	m_stxt2->SetBackgroundColour(wxColour(*wxLIGHT_GREY));
	m_stxt2->SetForegroundColour(wxColour(*wxBLACK));

	m_btn2 = new wxButton(m_pnl1, 10001, "Hide", wxPoint(385, 350), wxSize(60, 20));
	m_btn3 = new wxButton(m_pnl1, 10004, "Generate", wxPoint(450, 350), wxSize(60, 20));
	m_txt4 = new wxTextCtrl(m_pnl1, wxID_ANY, "", wxPoint(250, -350), wxSize(130, 20), wxTE_PASSWORD);
	m_txt3 = new wxTextCtrl(m_pnl1, wxID_ANY, "", wxPoint(250, 350), wxSize(130, 20));
	m_stxt3 = new wxStaticText(m_pnl1, wxID_ANY, "Password", wxPoint(190, 350), wxSize(50, 30));
	m_stxt3->SetBackgroundColour(wxColour(*wxLIGHT_GREY));
	m_stxt3->SetForegroundColour(wxColour(*wxBLACK));

	m_btn4 = new wxButton(m_pnl1, 10002, "Add", wxPoint(250, 375), wxSize(260, 20));
}

cMain::~cMain()
{
}

void cMain::OnHideButtonClicked(wxCommandEvent& evt)
{
	if (passwordhide == FALSE)
	{
		m_txt3->Move(wxPoint(250, -350));
		m_txt4->Move(wxPoint(250, 350));
		m_txt4->Clear();
		m_txt4->AppendText(m_txt3->GetValue());
		passwordhide = TRUE;
	}
	else if (passwordhide == TRUE)
	{
		m_txt4->Move(wxPoint(250, -350));
		m_txt3->Move(wxPoint(250, 350));
		m_txt3->Clear();
		m_txt3->AppendText(m_txt4->GetValue());
		passwordhide = FALSE;
	}
	evt.Skip();
}

void cMain::OnAddButtonClicked(wxCommandEvent& evt)
{
	database[m_txt1->GetValue() + "User"] = m_txt2->GetValue();
	if (passwordhide == FALSE){
		database[m_txt1->GetValue() + "Pass"] = m_txt3->GetValue();
	}
	else if (passwordhide == TRUE) {
		database[m_txt1->GetValue() + "Pass"] = m_txt4->GetValue();
	}

}

void cMain::OnSearchButtonClicked(wxCommandEvent& evt)
{
	wxString website;
	website = m_txt1->GetValue();
	m_txt2->Clear();
	m_txt2->AppendText(database[website + "User"]);
	if (passwordhide == FALSE) {
		m_txt3->Clear();
		m_txt3->AppendText(database[website + "Pass"]);
	}
	else if (passwordhide == TRUE) {
		m_txt4->Clear();
		m_txt4->AppendText(database[website + "Pass"]);
	}
}

void cMain::OnGenerateButtonClicked(wxCommandEvent& evt)
{
	wxString genpass;
	genpass = "";

	srand(time(0));

	for (int i = 0; i < 12; i++)
		genpass = genpass + alphanum[rand() % string_length];

	if (passwordhide == FALSE) {
		m_txt3->Clear();
		m_txt3->AppendText(genpass);
	}
	else if (passwordhide == TRUE) {
		m_txt4->Clear();
		m_txt4->AppendText(genpass);
	}

}