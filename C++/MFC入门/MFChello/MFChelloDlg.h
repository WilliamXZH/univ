// MFChelloDlg.h : header file
//

#if !defined(AFX_MFCHELLODLG_H__A9A58B84_5935_469F_8AD5_2563F70905AF__INCLUDED_)
#define AFX_MFCHELLODLG_H__A9A58B84_5935_469F_8AD5_2563F70905AF__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CMFChelloDlg dialog

class CMFChelloDlg : public CDialog
{
// Construction
public:
	CMFChelloDlg(CWnd* pParent = NULL);	// standard constructor
	
	void OnLButtonDown(UINT nFlags,CPoint point);
	void OnRButtonDown(UINT nFlags,CPoint point);
// Dialog Data
	//{{AFX_DATA(CMFChelloDlg)
	enum { IDD = IDD_MFCHELLO_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMFChelloDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CMFChelloDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/*void CMFChelloDlg::OnLButtonDown(UINT nFlags,CPoint point)
{
	CDialog::OnLButtonDown(nFlags,point);
	MessageBox("你点的是左键","The first Dialog",NB_OK);
}
void CMFChelloDlg::OnRButtonDown(UINT nFlags,CPoint point)
{
	CDialog::OnRButtonDown(nFlags,point);
	MessageBox("你点的是右键","The first Dialog",NB_OK);
}*/
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MFCHELLODLG_H__A9A58B84_5935_469F_8AD5_2563F70905AF__INCLUDED_)
