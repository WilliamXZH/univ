#include<afxwin.h>
typedef struct tagMSG
{
	HWND hwnd;
	UINT message;
	WPARAM wParam;
	LPARAM lParam;
	DWORD time;
	POINT pt;
}MSG;
main(){
	yoourProc();
}
LONG yourWndProc(HWND hWnd,UINT uMessageType,WPARAM wP,LPARAM)
{
	switch(uMessageType)
	{
	case(WM_PAINT):
		doYourWindow();
		break;
	case(WM_LBUTTONDOWN):
		doYourWork();
		break;
	default:
		callDefaultProc();
		break;
	}
}