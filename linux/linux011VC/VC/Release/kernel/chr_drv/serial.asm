	TITLE	..\kernel\chr_drv\serial.c
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
;	COMDAT __INC_PIPE
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _switch_to
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __get_base
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_limit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_rs_init
EXTRN	_tty_table:BYTE
EXTRN	_idt:BYTE
EXTRN	_rs1_interrupt:NEAR
EXTRN	_rs2_interrupt:NEAR
_TEXT	SEGMENT
$T744 = -8
$T749 = -1
$T750 = -8
_rs_init PROC NEAR

; 58   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 59   : 	set_intr_gate (0x24, rs1_interrupt);	// ���ô��п�1 ���ж�������(Ӳ��IRQ4 �ź�)��

	mov	eax, OFFSET FLAT:_rs1_interrupt
	mov	ecx, OFFSET FLAT:_rs1_interrupt
	and	eax, 65535				; 0000ffffH
	and	ecx, -65536				; ffff0000H
	add	eax, 524288				; 00080000H
	add	ecx, 36352				; 00008e00H
	mov	DWORD PTR _idt+288, eax

; 60   : 	set_intr_gate (0x23, rs2_interrupt);	// ���ô��п�2 ���ж�������(Ӳ��IRQ3 �ź�)��

	mov	edx, OFFSET FLAT:_rs2_interrupt
	mov	eax, OFFSET FLAT:_rs2_interrupt
	mov	DWORD PTR _idt+292, ecx

; 61   : 	init (tty_table[1].read_q.data);	// ��ʼ�����п�1(.data �Ƕ˿ں�)��

	mov	ecx, DWORD PTR _tty_table+3216
	and	edx, 65535				; 0000ffffH
	and	eax, -65536				; ffff0000H
	add	edx, 524288				; 00080000H
	add	eax, 36352				; 00008e00H
	push	ecx
	mov	DWORD PTR _idt+280, edx
	mov	DWORD PTR _idt+284, eax
	call	_init

; 62   : 	init (tty_table[2].read_q.data);	// ��ʼ�����п�2��

	mov	edx, DWORD PTR _tty_table+6384
	push	edx
	call	_init

; 63   : 	outb (inb_p (0x21) & 0xE7, 0x21);	// ������8259A оƬ��IRQ3��IRQ4 �ж��ź�����

	mov	ecx, 33					; 00000021H
	add	esp, 8
	mov	DWORD PTR $T744[ebp], ecx

; 61   : 	init (tty_table[1].read_q.data);	// ��ʼ�����п�1(.data �Ƕ˿ں�)��

	mov	dx, WORD PTR $T744[ebp]

; 62   : 	init (tty_table[2].read_q.data);	// ��ʼ�����п�2��

	in	al, dx

; 64   : }

	jmp	SHORT $l1$741
$l1$741:
; File ..\include\asm/system.h

; 47   : {// c���ͻ����䶼����ͨ��

	jmp	SHORT $l2$742
$l2$742:
; File ..\kernel\chr_drv\serial.c

; 63   : * ��tty_write()�ѽ����ݷ������(д)����ʱ�����������ӳ��򡣱�������

	and	al, 231					; 000000e7H
	mov	DWORD PTR $T750[ebp], ecx
	mov	BYTE PTR $T749[ebp], al

; 59   : 	outb (inb_p (0x21) & 0xE7, 0x21);	// ������8259A оƬ��IRQ3��IRQ4 �ж��ź�����

	mov	dx, WORD PTR $T750[ebp]

; 60   : }

	mov	al, BYTE PTR $T749[ebp]

; 61   : 

	out	dx, al

; 64   : * ���д�����Ƿ�Ϊ�գ�����Ӧ�����жϼĴ�����

	mov	esp, ebp
	pop	ebp
	ret	0
_rs_init ENDP
_port$ = 8
$T757 = -1
$T758 = -8
$T764 = -1
$T770 = -1
$T771 = -8
$T777 = -1
$T778 = -8
$T784 = -1
$T785 = -8
$T791 = -1
$T792 = -8
_init	PROC NEAR

; 38   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	ecx, DWORD PTR _port$[ebp]
	push	esi
	push	edi
	mov	BYTE PTR $T757[ebp], 128		; 00000080H
	lea	esi, DWORD PTR [ecx+3]
	mov	DWORD PTR $T758[ebp], esi
	mov	al, BYTE PTR $T757[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR $T758[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$754
$l1$754:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$755
$l2$755:

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	mov	BYTE PTR $T764[ebp], 48			; 00000030H

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	al, BYTE PTR $T764[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR _port$[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$761
$l1$761:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$762
$l2$762:
	lea	edi, DWORD PTR [ecx+1]
	mov	BYTE PTR $T770[ebp], 0
	mov	DWORD PTR $T771[ebp], edi

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	al, BYTE PTR $T770[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR $T771[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$767
$l1$767:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$768
$l2$768:

; 44   : /* ���Ͳ��������Ӹ��ֽڣ�0x00 */
; 45   : 	outb_p (0x03, port + 3);	/* reset DLAB */

	mov	DWORD PTR $T778[ebp], esi
	mov	BYTE PTR $T777[ebp], 3

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	al, BYTE PTR $T777[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR $T778[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$774
$l1$774:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$775
$l2$775:

; 46   : /* ��λDLAB λ������λΪ8 λ */
; 47   : 	outb_p (0x0b, port + 4);	/* set DTR,RTS, OUT_2 */

	add	ecx, 4
	mov	BYTE PTR $T784[ebp], 11			; 0000000bH
	mov	DWORD PTR $T785[ebp], ecx

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	al, BYTE PTR $T784[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR $T785[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$781
$l1$781:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$782
$l2$782:

; 48   : /* ����DTR��RTS�������û����2 */
; 49   : 	outb_p (0x0d, port + 1);	/* enable all intrs but writes */

	mov	DWORD PTR $T792[ebp], edi
	mov	BYTE PTR $T791[ebp], 13			; 0000000dH

; 39   : 	outb_p (0x80, port + 3);	/* set DLAB of line control reg */

	mov	al, BYTE PTR $T791[ebp]

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR $T792[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	out	dx, al

; 42   : /* ���Ͳ��������ӵ��ֽڣ�0x30->2400bps */

	jmp	SHORT $l1$788
$l1$788:

; 43   : 	outb_p (0x00, port + 1);	/* MS of divisor */

	jmp	SHORT $l2$789
$l2$789:

; 40   : /* ������·���ƼĴ�����DLAB λ(λ7) */

	mov	dx, WORD PTR _port$[ebp]

; 41   : 	outb_p (0x30, port);		/* LS of divisor (48 -> 2400 bps */

	in	al, dx

; 50   : /* ����д(д���ֿ�)���⣬���������ж�Դ�ж� */
; 51   : 	(void) inb (port);		/* read data port to reset things (?) */

	pop	edi
	pop	esi

; 52   : /* �����ݿڣ��Խ��и�λ����(?) */
; 53   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_init	ENDP
_TEXT	ENDS
PUBLIC	_rs_write
_TEXT	SEGMENT
_tty$ = 8
$T802 = 8
$T807 = 11
$T808 = -4
_rs_write PROC NEAR

; 73   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 74   : 	cli ();			// ���жϡ�

	cli

; 77   : 	if (!EMPTY (tty->write_q))

	mov	ecx, DWORD PTR _tty$[ebp]
	mov	eax, DWORD PTR [ecx+1092]
	mov	edx, DWORD PTR [ecx+1096]
	cmp	eax, edx
	je	SHORT $L805

; 78   : 		outb (inb_p (tty->write_q.data + 1) | 0x02, tty->write_q.data + 1);

	mov	dx, WORD PTR [ecx+1088]
	inc	dx
	mov	DWORD PTR $T802[ebp], edx

; 76   : // �ж������־��λ1������д�ظüĴ�����

	mov	dx, WORD PTR $T802[ebp]

; 77   : 	if (!EMPTY (tty->write_q))

	in	al, dx

; 79   : 	sti ();			// ���жϡ�

	jmp	SHORT $l1$799
$l1$799:

; 80   : }

	jmp	SHORT $l2$800
$l2$800:

; 78   : 		outb (inb_p (tty->write_q.data + 1) | 0x02, tty->write_q.data + 1);

	mov	cx, WORD PTR [ecx+1088]
	inc	cx
	or	al, 2
	mov	DWORD PTR $T808[ebp], ecx
	mov	BYTE PTR $T807[ebp], al

; 74   : 	cli ();			// ���жϡ�

	mov	dx, WORD PTR $T808[ebp]

; 75   : // ���д���в��գ����0x3f9(��0x2f9) ���ȶ�ȡ�ж�����Ĵ������ݣ����Ϸ��ͱ��ּĴ���

	mov	al, BYTE PTR $T807[ebp]

; 76   : // �ж������־��λ1������д�ظüĴ�����

	out	dx, al

; 78   : 		outb (inb_p (tty->write_q.data + 1) | 0x02, tty->write_q.data + 1);

$L805:

; 79   : 	sti ();			// ���жϡ�

	sti

; 80   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_rs_write ENDP
_TEXT	ENDS
PUBLIC	__INC_PIPE
;	COMDAT __INC_PIPE
_TEXT	SEGMENT
_head$ = 8
__INC_PIPE PROC NEAR					; COMDAT

; 85   : extern _inline void _INC_PIPE(unsigned long *head) {

	push	ebp
	mov	ebp, esp
	push	ebx

; 86   : 	_asm mov ebx,head

	mov	ebx, DWORD PTR _head$[ebp]

; 87   : 	_asm inc dword ptr [ebx]

	inc	DWORD PTR [ebx]

; 88   : 	_asm and dword ptr [ebx],4095

	and	DWORD PTR [ebx], 4095			; 00000fffH
	pop	ebx

; 89   : }

	pop	ebp
	ret	0
__INC_PIPE ENDP
_TEXT	ENDS
PUBLIC	_switch_to
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
EXTRN	_current:DWORD
;	COMDAT _switch_to
_TEXT	SEGMENT
_n$ = 8
___tmp$ = -4
_switch_to PROC NEAR					; COMDAT

; 268  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi
	push	edi

; 269  : 	unsigned short __tmp;
; 270  : 	__tmp = (unsigned short)_TSS(n);

	mov	eax, DWORD PTR _n$[ebp]
	shl	eax, 4
	add	eax, 32					; 00000020H
	mov	WORD PTR ___tmp$[ebp], ax

; 271  : 
; 272  : 	_asm {
; 273  : 		mov ebx, offset task

	mov	ebx, OFFSET FLAT:_task

; 274  : 		mov eax, n

	mov	eax, DWORD PTR _n$[ebp]

; 275  : 		mov ecx, [ebx+eax*4]

	mov	ecx, DWORD PTR [ebx+eax*4]

; 276  : 		cmp ecx, current/* ����n �ǵ�ǰ������?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* �ǣ���ʲô���������˳���*/ 

	je	SHORT $l1$612

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$613, ax

; 282  : 		_emit 0xea

	DB	-22					; ffffffeaH

; 283  : 		_emit 0		// ip

	DB	0

; 284  : 		_emit 0 

	DB	0

; 285  : 		_emit 0 

	DB	0

; 286  : 		_emit 0

	DB	0
$lcs$613:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$612

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$612:

; 293  : 	}
; 294  : l1: ;
; 295  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_switch_to ENDP
_TEXT	ENDS
PUBLIC	__set_base
;	COMDAT __set_base
_TEXT	SEGMENT
_addr$ = 8
_base$ = 12
__set_base PROC NEAR					; COMDAT

; 319  : { 

	push	ebp
	mov	ebp, esp
	push	ebx

; 320  : /*	addr[1] = base;
; 321  : 	((char*)addr)[4] = base >> 16;
; 322  : 	((char*)addr)[7] = base >> 8;*/
; 323  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 324  : 	_asm mov edx,base 

	mov	edx, DWORD PTR _base$[ebp]

; 325  : 	_asm mov word ptr [ebx+2],dx // ��ַbase ��16 λ(λ15-0)->[addr+2]��

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx �л�ַ��16 λ(λ31-16) -> dx�� 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // ��ַ��16 λ�еĵ�8 λ(λ23-16)->[addr+4]��

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // ��ַ��16 λ�еĸ�8 λ(λ31-24)->[addr+7]��

	mov	BYTE PTR [ebx+7], dh
	pop	ebx

; 329  : }

	pop	ebp
	ret	0
__set_base ENDP
_TEXT	ENDS
PUBLIC	__set_limit
;	COMDAT __set_limit
_TEXT	SEGMENT
_addr$ = 8
_limit$ = 12
__set_limit PROC NEAR					; COMDAT

; 340  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 341  : /*	addr[0] = limit;
; 342  : 	((char*)addr)[6] = ((char*)addr)[6] & 0xf0 + (limit >> 16) & 0x0f;*/
; 343  : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 344  : 	_asm mov edx,limit 

	mov	edx, DWORD PTR _limit$[ebp]

; 345  : 	_asm mov word ptr [ebx],dx // �γ�limit ��16 λ(λ15-0)->[addr]��

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx �еĶγ���4 λ(λ19-16)->dl��

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // ȡԭ[addr+6]�ֽ�->dh�����и�4 λ��Щ��־��

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // ��dh �ĵ�4 λ(����Ŷγ���λ19-16)��

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // ��ԭ��4 λ��־�Ͷγ��ĸ�4 λ(λ19-16)�ϳ�1 �ֽڣ�

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // ���Ż�[addr+6]����

	mov	BYTE PTR [ebx+6], dl
	pop	ebx

; 351  : }

	pop	ebp
	ret	0
__set_limit ENDP
_TEXT	ENDS
PUBLIC	__get_base
;	COMDAT __get_base
_TEXT	SEGMENT
_addr$ = 8
__get_base PROC NEAR					; COMDAT

; 374  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 375  : //	unsigned long __base; 
; 376  : 	_asm { 
; 377  : 		_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 378  : 		_asm mov ah,byte ptr [ebx+7] // ȡ[addr+7]����ַ��16 λ�ĸ�8 λ(λ31-24)->dh��

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // ȡ[addr+4]����ַ��16 λ�ĵ�8 λ(λ23-16)->dl��

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // ����ַ��16 λ�Ƶ�edx �и�16 λ����

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // ȡ[addr+2]����ַ��16 λ(λ15-0)->dx��

	mov	ax, WORD PTR [ebx+2]
	pop	ebx

; 382  : //		_asm mov __base,eax 
; 383  : 		} 
; 384  : //	return __base; 
; 385  : }

	pop	ebp
	ret	0
__get_base ENDP
_TEXT	ENDS
PUBLIC	_get_limit
;	COMDAT _get_limit
_TEXT	SEGMENT
_segment$ = 8
_get_limit PROC NEAR					; COMDAT

; 400  : extern _inline unsigned long get_limit(unsigned long segment) { 

	push	ebp
	mov	ebp, esp

; 401  : //	unsigned long __limit; 
; 402  : 	_asm { 
; 403  : 		mov eax,segment 

	mov	eax, DWORD PTR _segment$[ebp]

; 404  : 		lsl eax,eax 

	lsl	eax, eax

; 405  : //		mov __limit,eax 
; 406  : 	} 
; 407  : //	return __limit; 
; 408  : }

	pop	ebp
	ret	0
_get_limit ENDP
_TEXT	ENDS
PUBLIC	__set_tssldt_desc
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT
_n$ = 8
_addr$ = 12
_tp$ = 16
__set_tssldt_desc PROC NEAR				; COMDAT

; 105  : { 

	push	ebp
	mov	ebp, esp
	push	ebx

; 106  : /*	n[0] = 104;
; 107  : 	n[1] = addr;
; 108  : 	n[2] = addr >> 16;
; 109  : 	((char*)n)[7] = ((char*)n)[5];
; 110  : 	((char*)n)[5] = tp;
; 111  : 	((char*)n)[6] = 0;*/
; 112  : 	_asm mov ebx,n

	mov	ebx, DWORD PTR _n$[ebp]

; 113  : 	_asm mov ax,104 

	mov	ax, 104					; 00000068H

; 114  : 	_asm mov word ptr [ebx],ax // ��TSS ���ȷ���������������(��0-1 �ֽ�)��

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // ������ַ�ĵ��ַ�����������2-3 �ֽڡ�

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // ������ַ��������ax �С�

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // ������ַ�����е��ֽ�������������4 �ֽڡ�

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // ����־�����ֽ������������ĵ�5 �ֽڡ�

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // �������ĵ�6 �ֽ���0��

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // ������ַ�����и��ֽ�������������7 �ֽڡ�

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax ���㡣

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
END
