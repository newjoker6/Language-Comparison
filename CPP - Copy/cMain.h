#pragma once
#include "wx\wx.h"

class cMain : public wxFrame
{
public:
	cMain();
	~cMain();

public:
	wxPanel* m_pnl1 = nullptr;
	wxButton* m_btn1 = nullptr;
	wxTextCtrl* m_txt1 = nullptr;
	wxStaticText* m_stxt1 = nullptr;
	wxButton* m_btn2 = nullptr;
	wxTextCtrl* m_txt2 = nullptr;
	wxStaticText* m_stxt2 = nullptr;
	wxButton* m_btn3 = nullptr;
	wxTextCtrl* m_txt3 = nullptr;
	wxTextCtrl* m_txt4 = nullptr;
	wxStaticText* m_stxt3 = nullptr;
	wxButton* m_btn4 = nullptr;

	void OnHideButtonClicked(wxCommandEvent &evt);
	void OnAddButtonClicked(wxCommandEvent& evt);
	void OnSearchButtonClicked(wxCommandEvent& evt);
	void OnGenerateButtonClicked(wxCommandEvent& evt);

	wxDECLARE_EVENT_TABLE();

};

