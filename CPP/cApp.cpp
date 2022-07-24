#include "cApp.h"

wxIMPLEMENT_APP(cApp);

cApp::cApp()
{

}

cApp::~cApp()
{

}

bool cApp::OnInit()
{
	wxImage::AddHandler(new wxPNGHandler());
	m_frame1 = new cMain();
	m_frame1->Show();
	return true;
}