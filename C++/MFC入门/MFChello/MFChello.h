// MFChello.h : main header file for the MFCHELLO application
//

#if !defined(AFX_MFCHELLO_H__2B052B4A_8642_409A_A779_9FDB0F3C18A5__INCLUDED_)
#define AFX_MFCHELLO_H__2B052B4A_8642_409A_A779_9FDB0F3C18A5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CMFChelloApp:
// See MFChello.cpp for the implementation of this class
//

class CMFChelloApp : public CWinApp
{
public:
	CMFChelloApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMFChelloApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CMFChelloApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MFCHELLO_H__2B052B4A_8642_409A_A779_9FDB0F3C18A5__INCLUDED_)
