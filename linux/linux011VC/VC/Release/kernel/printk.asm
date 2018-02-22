	TITLE	..\kernel\printk.c
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
PUBLIC	_printk
EXTRN	_tty_write:NEAR
EXTRN	_vsprintf:NEAR
_BSS	SEGMENT
_buf	DB	0400H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
_fmt$ = 8
_i$ = -4
_printk	PROC NEAR

; 31   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 32   : 	va_list args;			// va_list ʵ������һ���ַ�ָ�����͡�
; 33   : 	int i;
; 34   : 
; 35   : 	va_start (args, fmt);		// ��������ʼ�������ڣ�include/stdarg.h,13��
; 36   : 	i = vsprintf (buf, fmt, args);	// ʹ�ø�ʽ��fmt �������б�args �����buf �С�

	mov	ecx, DWORD PTR _fmt$[ebp]
	lea	eax, DWORD PTR _fmt$[ebp+4]
	push	eax
	push	ecx
	push	OFFSET FLAT:_buf
	call	_vsprintf
	add	esp, 12					; 0000000cH
	mov	DWORD PTR _i$[ebp], eax

; 37   : // ����ֵi ��������ַ����ĳ��ȡ�
; 38   : 	va_end (args);		// �����������������
; 39   : 	_asm{
; 40   : 		push fs	// ����fs��

	push	fs

; 41   : 		push ds

	push	ds

; 42   : 		pop fs	// ��fs = ds��

	pop	fs

; 43   : 		push i	// ���ַ�������ѹ���ջ(��������ջ�ǵ��ò���)��

	push	DWORD PTR _i$[ebp]

; 44   : 		push offset buf	// ��buf �ĵ�ַѹ���ջ��

	push	OFFSET FLAT:_buf

; 45   : 		push 0	// ����ֵ0 ѹ���ջ����ͨ����channel��

	push	0

; 46   : 		call tty_write	// ����tty_write ������(kernel/chr_drv/tty_io.c,290)��

	call	_tty_write

; 47   : 		add esp,8	// ������������������ջ����(buf,channel)��

	add	esp, 8

; 48   : 		pop i	// �����ַ�������ֵ����Ϊ����ֵ��

	pop	DWORD PTR _i$[ebp]

; 49   : 		pop fs		// �ָ�ԭfs �Ĵ�����

	pop	fs

; 50   : 	}
; 51   :  /* __asm__ ("push %%fs\n\t"
; 52   : 	   "push %%ds\n\t" "pop %%fs\n\t"
; 53   : 	   "pushl %0\n\t"
; 54   : 	   "pushl $_buf\n\t"
; 55   : 	   "pushl $0\n\t"
; 56   : 	   "call _tty_write\n\t"
; 57   : 	   "addl $8,%%esp\n\t"
; 58   : 	   "popl %0\n\t"
; 59   : 	   "pop %%fs"
; 60   : ::"r" (i):"ax", "cx", "dx");	// ֪ͨ���������Ĵ���ax,cx,dx ֵ�����Ѿ��ı䡣*/
; 61   : 	return i;			// �����ַ������ȡ�

	mov	eax, DWORD PTR _i$[ebp]

; 62   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_printk	ENDP
_TEXT	ENDS
END
