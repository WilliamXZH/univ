	TITLE	..\lib\open.c
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_open
EXTRN	_errno:DWORD
_TEXT	SEGMENT
_filename$ = 8
_flag$ = 12
_res$ = -4
_open	PROC NEAR

; 24   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 25   : 	register int res;
; 26   : 	va_list arg;
; 27   : 
; 28   : // ����va_start()�꺯����ȡ��flag ���������ָ�룬Ȼ�����ϵͳ�ж�int 0x80������open ����
; 29   : // �ļ��򿪲�����
; 30   : // %0 - eax(���ص��������������)��%1 - eax(ϵͳ�жϵ��ù��ܺ�__NR_open)��
; 31   : // %2 - ebx(�ļ���filename)��%3 - ecx(���ļ���־flag)��%4 - edx(��������ļ�����mode)��
; 32   : 	va_start(arg,flag);
; 33   : 	res = va_arg(arg,int);

	mov	eax, DWORD PTR _flag$[ebp+4]
	push	ebx
	mov	DWORD PTR _res$[ebp], eax

; 34   : 	_asm{
; 35   : 		mov eax,__NR_open

	mov	eax, 5

; 36   : 		mov ebx,filename

	mov	ebx, DWORD PTR _filename$[ebp]

; 37   : 		mov ecx,flag

	mov	ecx, DWORD PTR _flag$[ebp]

; 38   : 		mov edx,res

	mov	edx, DWORD PTR _res$[ebp]

; 39   : 		int 0x80

	int	-128					; ffffff80H

; 40   : 		mov res,eax

	mov	DWORD PTR _res$[ebp], eax

; 41   : 	}
; 42   : /*	__asm__("int $0x80"
; 43   : 		:"=a" (res)
; 44   : 		:"0" (__NR_open),"b" (filename),"c" (flag),
; 45   : 		"d" (va_arg(arg,int)));*/
; 46   : // ϵͳ�жϵ��÷���ֵ���ڻ����0����ʾ��һ���ļ�����������ֱ�ӷ���֮��
; 47   : 	if (res>=0)

	mov	eax, DWORD PTR _res$[ebp]
	pop	ebx
	test	eax, eax

; 48   : 		return res;

	jge	SHORT $L386

; 49   : // ����˵������ֵС��0�������һ�������롣���øó����벢����-1��
; 50   : 	errno = -res;

	neg	eax
	mov	DWORD PTR _errno, eax

; 51   : 	return -1;

	or	eax, -1
$L386:

; 52   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_open	ENDP
_TEXT	ENDS
END
