// SrvrItem.h : interface of the CTestSrvrItem class
//

#if !defined(AFX_SRVRITEM_H__7778141F_0ACD_49DC_AC4F_3EAECB4EEAA1__INCLUDED_)
#define AFX_SRVRITEM_H__7778141F_0ACD_49DC_AC4F_3EAECB4EEAA1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CTestSrvrItem : public COleServerItem
{
	DECLARE_DYNAMIC(CTestSrvrItem)

// Constructors
public:
	CTestSrvrItem(CTestDoc* pContainerDoc);

// Attributes
	CTestDoc* GetDocument() const
		{ return (CTestDoc*)COleServerItem::GetDocument(); }

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTestSrvrItem)
	public:
	virtual BOOL OnDraw(CDC* pDC, CSize& rSize);
	virtual BOOL OnGetExtent(DVASPECT dwDrawAspect, CSize& rSize);
	//}}AFX_VIRTUAL

// Implementation
public:
	~CTestSrvrItem();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:
	virtual void Serialize(CArchive& ar);   // overridden for document i/o
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SRVRITEM_H__7778141F_0ACD_49DC_AC4F_3EAECB4EEAA1__INCLUDED_)
