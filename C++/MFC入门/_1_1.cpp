OnDraw(CDC* pDC)
{
	CPen pen1,pen2;
	pen1.CreatePen(PS_SOLID,2,RGB(128,128,128));
	pen2.CreatePen(PS_SOLID,2,RGB(128,128,0));
	CPen* pPenOld=(CPen*)pDC->SelectObject(&penl);
	(CPen*)pDC->SelectObject(&pen2);
	pen1.DeleteObject(pOldPen);
}