

void CMsgTestDlg::OnClose(){
	HWND hWnd=::FindWindow("Notepad",NULL);
	if(hWnd==NULL){
		AfxMessageBox("û���ҵ����±�");
	}
	::SendMessage(hWnd,WM_CLOSE,NULL,NULL);
}
void CMsgTestDlg::OnExec(){
	WinExec("notepad.exe",SW_SHOW);
}
void  CMsgTestDlg::OnEditWnd(){
	HWND hWnd=::FindWindow(NULL,"�ޱ��� - ���±�");
	if(hWnd==NULL){
		AfxMessageBox("û���ҵ����±�");
		return ;
	}
	char *pCaptionText="��Ϣ����";
	::SendMessage(hWnd,WM_SETTEXT,(WOARAM)0,(LPARAM)pCaptionText);

}

void CMsgTextDlg::OnGetWnd(){
	HWND hWnd=::FindWindow("Notepad",NULL);
	if(hWnd==NULL){
		AfxMessageBox("û���ҵ����±�");
		return;
	}
	char pCaptionText[MAXBYTE]={0};
	::SendMessage(hWnd,WM_GETTEXT,(WPARAM)MAXBYTE,(LPARAM)pCaptionText);
	AfxMessageBox(pCaptionText);
}

