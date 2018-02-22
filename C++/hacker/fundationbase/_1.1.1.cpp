

void CMsgTestDlg::OnClose(){
	HWND hWnd=::FindWindow("Notepad",NULL);
	if(hWnd==NULL){
		AfxMessageBox("没有找到记事本");
	}
	::SendMessage(hWnd,WM_CLOSE,NULL,NULL);
}
void CMsgTestDlg::OnExec(){
	WinExec("notepad.exe",SW_SHOW);
}
void  CMsgTestDlg::OnEditWnd(){
	HWND hWnd=::FindWindow(NULL,"无标题 - 记事本");
	if(hWnd==NULL){
		AfxMessageBox("没有找到记事本");
		return ;
	}
	char *pCaptionText="消息测试";
	::SendMessage(hWnd,WM_SETTEXT,(WOARAM)0,(LPARAM)pCaptionText);

}

void CMsgTextDlg::OnGetWnd(){
	HWND hWnd=::FindWindow("Notepad",NULL);
	if(hWnd==NULL){
		AfxMessageBox("没有找到记事本");
		return;
	}
	char pCaptionText[MAXBYTE]={0};
	::SendMessage(hWnd,WM_GETTEXT,(WPARAM)MAXBYTE,(LPARAM)pCaptionText);
	AfxMessageBox(pCaptionText);
}

