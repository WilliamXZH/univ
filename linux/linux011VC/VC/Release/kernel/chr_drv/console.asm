	TITLE	..\kernel\chr_drv\console.c
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
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_beepcount
_BSS	SEGMENT
_beepcount DD	01H DUP (?)
_state	DD	01H DUP (?)
_ques	DD	01H DUP (?)
_saved_x DD	01H DUP (?)
_saved_y DD	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_attr	DB	07H
_DATA	ENDS
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

	je	SHORT $l1$499

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$500, ax

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
$lcs$500:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$499

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$499:

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
PUBLIC	_csi_m
_BSS	SEGMENT
_npar	DD	01H DUP (?)
_par	DD	010H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
_csi_m	PROC NEAR

; 494  : 	unsigned int i;
; 495  : 
; 496  : 	for (i = 0; i <= npar; i++)

	mov	eax, DWORD PTR _npar
	push	ebx
	push	esi
	mov	ecx, OFFSET FLAT:_par
	lea	esi, DWORD PTR [eax+1]
	mov	dl, 15					; 0000000fH
$L796:

; 497  : 		switch (par[i])
; 498  : 		{

	mov	eax, DWORD PTR [ecx]
	cmp	eax, 27					; 0000001bH
	ja	SHORT $L797
	xor	ebx, ebx
	mov	bl, BYTE PTR $L1088[eax]
	jmp	DWORD PTR $L1089[ebx*4]
$L805:

; 499  : 		case 0:
; 500  : 			attr = 0x07;
; 501  : 			break;
; 502  : 		case 1:
; 503  : 			attr = 0x0f;

	mov	BYTE PTR _attr, dl

; 504  : 			break;

	jmp	SHORT $L797
$L806:

; 505  : 		case 4:
; 506  : 			attr = 0x0f;
; 507  : 			break;
; 508  : 		case 7:
; 509  : 			attr = 0x70;

	mov	BYTE PTR _attr, 112			; 00000070H

; 510  : 			break;

	jmp	SHORT $L797
$L803:

; 511  : 		case 27:
; 512  : 			attr = 0x07;

	mov	BYTE PTR _attr, 7
$L797:

; 494  : 	unsigned int i;
; 495  : 
; 496  : 	for (i = 0; i <= npar; i++)

	add	ecx, 4
	dec	esi
	jne	SHORT $L796
	pop	esi
	pop	ebx

; 513  : 			break;
; 514  : 		}
; 515  : }

	ret	0
$L1089:
	DD	$L803
	DD	$L805
	DD	$L806
	DD	$L797
$L1088:
	DB	0
	DB	1
	DB	3
	DB	3
	DB	1
	DB	3
	DB	3
	DB	2
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	3
	DB	0
_csi_m	ENDP
_TEXT	ENDS
PUBLIC	_con_write
_BSS	SEGMENT
_video_num_columns DD 01H DUP (?)
_video_size_row DD 01H DUP (?)
_video_num_lines DD 01H DUP (?)
_video_mem_start DD 01H DUP (?)
_video_port_reg DW 01H DUP (?)
	ALIGN	4

_video_port_val DW 01H DUP (?)
	ALIGN	4

_origin	DD	01H DUP (?)
_pos	DD	01H DUP (?)
_x	DD	01H DUP (?)
_y	DD	01H DUP (?)
_top	DD	01H DUP (?)
_bottom	DD	01H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
$T1160 = 11
$T1166 = 11
$T1172 = 11
$T1178 = 11
_tty$ = 8
_nr$ = -4
_c$ = 11
_con_write PROC NEAR

; 705  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 710  : 	nr = CHARS (tty->write_q);

	mov	esi, DWORD PTR _tty$[ebp]
	push	edi
	mov	eax, DWORD PTR [esi+1092]
	mov	ebx, DWORD PTR [esi+1096]
	sub	eax, ebx
	and	eax, 1023				; 000003ffH

; 711  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	mov	DWORD PTR _nr$[ebp], eax
	je	$L917
	mov	eax, DWORD PTR _par
$L916:

; 715  : // 1��ԭ��״̬0�������ַ���ת���ַ�ESC(0x1b = 033 = 27)��
; 716  : // 2��ԭ��״̬1�������ַ���'['��
; 717  : // 3��ԭ��״̬2������ԭ��״̬3�������ַ���';'�����֡�
; 718  : // 4��ԭ��״̬3�������ַ�����';'�����֣�
; 719  : 		GETCH (tty->write_q, c);

	mov	ecx, DWORD PTR [esi+1096]
	mov	dl, BYTE PTR [ecx+esi+1104]
	inc	ecx
	and	ecx, 1023				; 000003ffH
	mov	BYTE PTR _c$[ebp], dl
	mov	DWORD PTR [esi+1096], ecx

; 720  : 		switch (state)
; 721  : 		{

	mov	ecx, DWORD PTR _state
	cmp	ecx, 4
	ja	$L970
	jmp	DWORD PTR $L1209[ecx*4]
$L923:

; 722  : 		case 0:
; 723  : // ����ַ����ǿ����ַ�(c>31)������Ҳ������չ�ַ�(c<127)����
; 724  : 			if (c > 31 && c < 127)

	cmp	dl, 31					; 0000001fH
	jle	SHORT $L924
	cmp	dl, 127					; 0000007fH
	jge	SHORT $L924

; 725  : 			{
; 726  : // ����ǰ��괦����ĩ�˻�ĩ�����⣬�򽫹���Ƶ�����ͷ�С����������λ�ö�Ӧ���ڴ�ָ��pos��
; 727  : 				if (x >= video_num_columns)

	mov	eax, DWORD PTR _video_num_columns
	mov	ecx, DWORD PTR _x
	cmp	ecx, eax
	jb	SHORT $L925

; 728  : 				{
; 729  : 					x -= video_num_columns;
; 730  : 					pos -= video_size_row;

	mov	edx, DWORD PTR _video_size_row
	sub	ecx, eax
	mov	eax, DWORD PTR _pos
	mov	DWORD PTR _x, ecx
	sub	eax, edx
	mov	DWORD PTR _pos, eax

; 731  : 					lf ();

	call	_lf
$L925:

; 732  : 				}
; 733  : // ���ַ�c д����ʾ�ڴ���pos ���������������1 �У�ͬʱҲ��pos ��Ӧ���ƶ�2 ���ֽڡ�
; 734  : //__asm__ ("movb _attr,%%ah\n\t" "movw %%ax,%1\n\t"::"a" (c), "m" (*(short *) pos):"ax");
; 735  : 				_asm {
; 736  : 					mov al,c;

	mov	al, BYTE PTR _c$[ebp]

; 737  : 					mov ah,attr;

	mov	ah, BYTE PTR _attr

; 738  : 					mov ebx,pos

	mov	ebx, DWORD PTR _pos

; 739  : 					mov [ebx],ax;

	mov	WORD PTR [ebx], ax

; 740  : 				}
; 741  : 				pos += 2;

	mov	ecx, DWORD PTR _pos

; 742  : 				x++;

	mov	eax, DWORD PTR _x
	add	ecx, 2
	inc	eax
	mov	DWORD PTR _pos, ecx
	mov	DWORD PTR _x, eax

; 743  : // ����ַ�c ��ת���ַ�ESC����ת��״̬state ��1��
; 744  : 			}
; 745  : 			else if (c == 27)

	jmp	$L1201
$L924:
	cmp	dl, 27					; 0000001bH
	jne	SHORT $L927

; 746  : 				state = 1;

	mov	DWORD PTR _state, 1

; 747  : // ����ַ�c �ǻ��з�(10)�����Ǵ�ֱ�Ʊ��VT(11)�������ǻ�ҳ��FF(12)�����ƶ���굽��һ�С�
; 748  : 			else if (c == 10 || c == 11 || c == 12)

	jmp	$L970
$L927:
	cmp	dl, 10					; 0000000aH
	je	$L930
	cmp	dl, 11					; 0000000bH
	je	$L930
	cmp	dl, 12					; 0000000cH
	je	$L930

; 749  : 				lf ();
; 750  : // ����ַ�c �ǻس���CR(13)���򽫹���ƶ���ͷ��(0 ��)��
; 751  : 			else if (c == 13)

	cmp	dl, 13					; 0000000dH
	jne	SHORT $L932

; 752  : 				cr ();

	call	_cr

; 753  : // ����ַ�c ��DEL(127)���򽫹���ұ�һ�ַ�����(�ÿո��ַ����)����������Ƶ�������λ�á�
; 754  : 			else if (c == ERASE_CHAR (tty))

	jmp	$L1201
$L932:
	xor	ecx, ecx
	mov	cl, BYTE PTR [esi+19]
	movsx	edi, dl
	cmp	edi, ecx
	jne	SHORT $L934

; 755  : 				del ();

	call	_del

; 756  : // ����ַ�c ��BS(backspace,8)���򽫹������1 �񣬲���Ӧ��������Ӧ�ڴ�λ��ָ��pos��
; 757  : 			else if (c == 8)

	jmp	$L1201
$L934:
	cmp	dl, 8
	jne	SHORT $L936

; 758  : 			{
; 759  : 				if (x)

	mov	ecx, DWORD PTR _x
	test	ecx, ecx
	je	$L970

; 760  : 				{
; 761  : 					x--;

	mov	edx, ecx

; 762  : 					pos -= 2;

	mov	ecx, DWORD PTR _pos
	dec	edx
	sub	ecx, 2
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx

; 763  : 				}
; 764  : // ����ַ�c ��ˮƽ�Ʊ��TAB(9)���򽫹���Ƶ�8 �ı������ϡ�����ʱ�������������Ļ���������
; 765  : // �򽫹���Ƶ���һ���ϡ�
; 766  : 			}
; 767  : 			else if (c == 9)

	jmp	$L970
$L936:
	cmp	dl, 9
	jne	SHORT $L939

; 768  : 			{
; 769  : 				c = (char)(8 - (x & 7));

	mov	edx, DWORD PTR _x

; 770  : 				x += c;
; 771  : 				pos += c << 1;

	mov	edi, DWORD PTR _pos
	mov	bl, dl
	mov	cl, 8
	and	bl, 7
	sub	cl, bl
	movsx	ecx, cl
	add	edx, ecx
	lea	ecx, DWORD PTR [edi+ecx*2]

; 772  : 				if (x > video_num_columns)

	mov	edi, DWORD PTR _video_num_columns
	cmp	edx, edi
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx
	jbe	$L970

; 773  : 				{
; 774  : 					x -= video_num_columns;
; 775  : 					pos -= video_size_row;

	mov	eax, DWORD PTR _video_size_row
	sub	edx, edi
	sub	ecx, eax
	mov	DWORD PTR _x, edx
	mov	DWORD PTR _pos, ecx

; 776  : 					lf ();

	call	_lf

; 777  : 				}
; 778  : 				c = 9;
; 779  : // ����ַ�c �������BEL(7)������÷�����������������������
; 780  : 			}
; 781  : 			else if (c == 7)

	jmp	$L1201
$L939:
	cmp	dl, 7
	jne	$L970

; 782  : 				sysbeep ();

	call	_sysbeep
	jmp	$L1201
$L944:

; 783  : 			break;
; 784  : // ���ԭ״̬��0�������ַ���ת���ַ�ESC(0x1b = 033 = 27)����ת��״̬1 ����
; 785  : 		case 1:
; 786  : 			state = 0;
; 787  : // ����ַ�c ��'['����״̬state ת��2��
; 788  : 			if (c == '[')

	cmp	dl, 91					; 0000005bH
	mov	DWORD PTR _state, 0
	jne	SHORT $L945

; 789  : 				state = 2;

	mov	DWORD PTR _state, 2

; 790  : // ����ַ�c ��'E'�������Ƶ���һ�п�ʼ��(0 ��)��
; 791  : 			else if (c == 'E')

	jmp	$L970
$L945:
	cmp	dl, 69					; 00000045H
	jne	SHORT $L947

; 792  : 				gotoxy (0, y + 1);

	mov	edx, DWORD PTR _y
	lea	ecx, DWORD PTR [edx+1]
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	SHORT $L970
	mov	DWORD PTR _x, 0
$L1205:
	mov	edx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edx, ecx
	add	edx, DWORD PTR _origin
	mov	DWORD PTR _pos, edx

; 793  : // ����ַ�c ��'M'����������һ�С�
; 794  : 			else if (c == 'M')

	jmp	SHORT $L970
$L947:
	cmp	dl, 77					; 0000004dH
	jne	SHORT $L949

; 795  : 				ri ();

	call	_ri

; 796  : // ����ַ�c ��'D'����������һ�С�
; 797  : 			else if (c == 'D')

	jmp	SHORT $L1201
$L949:
	cmp	dl, 68					; 00000044H
	jne	SHORT $L951
$L930:

; 798  : 				lf ();

	call	_lf

; 799  : // ����ַ�c ��'Z'�������ն�Ӧ���ַ����С�
; 800  : 			else if (c == 'Z')

	jmp	SHORT $L1201
$L951:
	cmp	dl, 90					; 0000005aH
	jne	SHORT $L953

; 801  : 				respond (tty);

	push	esi
	call	_respond
	add	esp, 4

; 802  : // ����ַ�c ��'7'���򱣴浱ǰ���λ�á�ע���������д��Ӧ����(c=='7')��
; 803  : 			else if (x == '7')

	jmp	SHORT $L1201
$L953:
	mov	ecx, DWORD PTR _x
	cmp	ecx, 55					; 00000037H
	jne	SHORT $L955
$L1003:

; 804  : 				save_cur ();

	call	_save_cur

; 805  : // ����ַ�c ��'8'����ָ���ԭ����Ĺ��λ�á�ע���������д��Ӧ����(c=='8')��
; 806  : 			else if (x == '8')

	jmp	SHORT $L1201
$L955:
	cmp	ecx, 56					; 00000038H
	jne	SHORT $L970
$L1004:

; 948  : // ����ַ�c ��'u'�����ʾ�ָ���굽ԭ�����λ�ô���
; 949  : 			case 'u':
; 950  : 				restore_cur ();

	call	_restore_cur
$L1201:

; 944  : // ����ַ�c ��'s'�����ʾ���浱ǰ�������λ�á�
; 945  : 			case 's':
; 946  : 				save_cur ();
; 947  : 				break;

	mov	eax, DWORD PTR _par
$L970:

; 711  : 	while (nr--)

	mov	ecx, DWORD PTR _nr$[ebp]
	mov	edx, ecx
	dec	ecx
	test	edx, edx
	mov	DWORD PTR _nr$[ebp], ecx
	jne	$L916
$L917:

; 706  : 	int nr;

	cli

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // �������������õĹ��λ�ã�����ʾ���������͹����ʾλ�á�
; 956  : 	set_cursor ();

	mov	BYTE PTR $T1160[ebp], 14		; 0000000eH

; 706  : 	int nr;

	mov	al, BYTE PTR $T1160[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_reg

; 708  : 

	out	dx, al

; 709  : // ����ȡ��д��������������ַ���nr��Ȼ�����ÿ���ַ����д���

	jmp	SHORT $l1$1182
$l1$1182:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1183
$l2$1183:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // �������������õĹ��λ�ã�����ʾ���������͹����ʾλ�á�
; 956  : 	set_cursor ();

	mov	eax, DWORD PTR _pos
	mov	edi, DWORD PTR _video_mem_start
	sub	eax, edi
	shr	eax, 9
	mov	BYTE PTR $T1166[ebp], al

; 706  : 	int nr;

	mov	al, BYTE PTR $T1166[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_val

; 708  : 

	out	dx, al

; 709  : // ����ȡ��д��������������ַ���nr��Ȼ�����ÿ���ַ����д���

	jmp	SHORT $l1$1186
$l1$1186:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1187
$l2$1187:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // �������������õĹ��λ�ã�����ʾ���������͹����ʾλ�á�
; 956  : 	set_cursor ();

	mov	BYTE PTR $T1172[ebp], 15		; 0000000fH

; 706  : 	int nr;

	mov	al, BYTE PTR $T1172[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_reg

; 708  : 

	out	dx, al

; 709  : // ����ȡ��д��������������ַ���nr��Ȼ�����ÿ���ַ����д���

	jmp	SHORT $l1$1190
$l1$1190:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1191
$l2$1191:

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // �������������õĹ��λ�ã�����ʾ���������͹����ʾλ�á�
; 956  : 	set_cursor ();

	mov	ecx, DWORD PTR _pos
	mov	edx, DWORD PTR _video_mem_start
	sub	ecx, edx
	shr	ecx, 1
	mov	BYTE PTR $T1178[ebp], cl

; 706  : 	int nr;

	mov	al, BYTE PTR $T1178[ebp]

; 707  : 	char c;

	mov	dx, WORD PTR _video_port_val

; 708  : 

	out	dx, al

; 709  : // ����ȡ��д��������������ַ���nr��Ȼ�����ÿ���ַ����д���

	jmp	SHORT $l1$1194
$l1$1194:

; 710  : 	nr = CHARS (tty->write_q);

	jmp	SHORT $l2$1195
$l2$1195:

; 712  : 	{
; 713  : // ��д������ȡһ�ַ�c������ǰ���������ַ���״̬state �ֱ���״̬֮���ת����ϵΪ��
; 714  : // state = 0����ʼ״̬������ԭ��״̬4������ԭ��״̬1�����ַ�����'['��

	sti

; 951  : 				break;
; 952  : 			}
; 953  : 		}
; 954  : 	}
; 955  : // �������������õĹ��λ�ã�����ʾ���������͹����ʾλ�á�
; 956  : 	set_cursor ();

	pop	edi
	pop	esi
	pop	ebx

; 957  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L958:

; 807  : 				restore_cur ();
; 808  : 			break;
; 809  : // ���ԭ״̬��1��������һ�ַ���'['����ת��״̬2 ������
; 810  : 		case 2:
; 811  : // ���ȶ�ESC ת���ַ����в���ʹ�õĴ�������par[]���㣬��������npar ָ�������������״̬
; 812  : // Ϊ3������ʱ�ַ�����'?'����ֱ��ת��״̬3 ȥ��������ȥ��һ�ַ����ٵ�״̬3 ������봦��
; 813  : 			for (npar = 0; npar < NPAR; npar++)
; 814  : 				par[npar] = 0;

	mov	ecx, 16					; 00000010H
	xor	eax, eax
	mov	edi, OFFSET FLAT:_par

; 815  : 			npar = 0;
; 816  : 			state = 3;

	mov	DWORD PTR _state, 3
	rep stosd
	xor	ecx, ecx

; 817  : 			if (ques = (c == '?'))

	cmp	dl, 63					; 0000003fH
	sete	al
	test	eax, eax
	mov	DWORD PTR _npar, ecx
	mov	DWORD PTR _ques, eax
	jne	$L1201
	mov	eax, DWORD PTR _par
	jmp	SHORT $L962
$L1203:
	mov	ecx, DWORD PTR _npar
$L962:

; 818  : 				break;
; 819  : // ���ԭ����״̬2������ԭ������״̬3����ԭ�ַ���';'�����֣��������洦��
; 820  : 		case 3:
; 821  : // ����ַ�c �Ƿֺ�';'����������par δ����������ֵ��1��
; 822  : 			if (c == ';' && npar < NPAR - 1)

	cmp	dl, 59					; 0000003bH
	jne	SHORT $L964
	cmp	ecx, 15					; 0000000fH
	jae	SHORT $L966

; 823  : 			{
; 824  : 				npar++;

	inc	ecx
	mov	DWORD PTR _npar, ecx

; 825  : 				break;

	jmp	$L970
$L964:

; 826  : // ����ַ�c �������ַ�'0'-'9'���򽫸��ַ�ת������ֵ����npar �������������10 ��������
; 827  : 			}
; 828  : 			else if (c >= '0' && c <= '9')

	cmp	dl, 48					; 00000030H
	jl	SHORT $L966
	cmp	dl, 57					; 00000039H
	jg	SHORT $L966

; 829  : 			{
; 830  : 				par[npar] = 10 * par[npar] + c - '0';

	mov	eax, DWORD PTR _par[ecx*4]
	movsx	edx, dl
	lea	eax, DWORD PTR [eax+eax*4]
	lea	eax, DWORD PTR [edx+eax*2-48]
	mov	DWORD PTR _par[ecx*4], eax

; 831  : 				break;

	jmp	$L1201
$L966:

; 832  : // ����ת��״̬4��
; 833  : 			}
; 834  : 			else
; 835  : 				state = 4;
; 836  : // ���ԭ״̬��״̬3�������ַ�����';'�����֣���ת��״̬4 �������ȸ�λ״̬state=0��
; 837  : 		case 4:
; 838  : 			state = 0;
; 839  : 			switch (c)
; 840  : 			{

	movsx	ecx, dl
	add	ecx, -64				; ffffffc0H
	xor	edi, edi
	cmp	ecx, 53					; 00000035H
	mov	DWORD PTR _state, edi
	ja	$L970
	xor	edx, edx
	mov	dl, BYTE PTR $L1210[ecx]
	jmp	DWORD PTR $L1211[edx*4]
$L973:

; 841  : // ����ַ�c ��'G'��'`'����par[]�е�һ�����������кš����кŲ�Ϊ�㣬�򽫹������һ��
; 842  : 			case 'G':
; 843  : 			case '`':
; 844  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L974

; 845  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L974:

; 846  : 				gotoxy (par[0], y);

	cmp	eax, DWORD PTR _video_num_columns
	ja	$L970
	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	$L970
	imul	ecx, DWORD PTR _video_size_row
	mov	edx, DWORD PTR _origin
	mov	DWORD PTR _x, eax
	add	edx, ecx
	lea	ecx, DWORD PTR [edx+eax*2]

; 899  : 				gotoxy (par[1], par[0]);

	mov	DWORD PTR _pos, ecx

; 900  : 				break;

	jmp	$L970
$L975:

; 847  : 				break;
; 848  : // ����ַ�c ��'A'�����һ���������������Ƶ�������������Ϊ0 ������һ�С�
; 849  : 			case 'A':
; 850  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L976

; 851  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L976:

; 852  : 				gotoxy (x, y - par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _x
	mov	edi, DWORD PTR _video_num_columns
	sub	ecx, eax
	cmp	edx, edi
	ja	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	jae	$L970
	mov	edi, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edi, ecx
	mov	ecx, DWORD PTR _origin
	add	ecx, edi
	lea	edx, DWORD PTR [ecx+edx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L977:

; 853  : 				break;
; 854  : // ����ַ�c ��'B'��'e'�����һ���������������Ƶ�������������Ϊ0 ������һ�С�
; 855  : 			case 'B':
; 856  : 			case 'e':
; 857  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L978

; 858  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L978:

; 859  : 				gotoxy (x, y + par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _x
	mov	edi, DWORD PTR _video_num_columns
	add	ecx, eax
	cmp	edx, edi
	ja	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	jae	$L970
	mov	edi, DWORD PTR _video_size_row
	mov	DWORD PTR _y, ecx
	imul	edi, ecx
	mov	ecx, DWORD PTR _origin
	add	ecx, edi
	lea	edx, DWORD PTR [ecx+edx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L979:

; 860  : 				break;
; 861  : // ����ַ�c ��'C'��'a'�����һ���������������Ƶĸ�����������Ϊ0 ������һ��
; 862  : 			case 'C':
; 863  : 			case 'a':
; 864  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L980

; 865  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L980:

; 866  : 				gotoxy (x + par[0], y);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	add	ecx, eax
	cmp	ecx, edx
	ja	$L970
	mov	edx, DWORD PTR _y
	mov	edi, DWORD PTR _video_num_lines
	cmp	edx, edi
	jae	$L970
	imul	edx, DWORD PTR _video_size_row
	mov	edi, DWORD PTR _origin
	mov	DWORD PTR _x, ecx
	add	edi, edx
	lea	edx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, edx
	jmp	$L970
$L981:

; 867  : 				break;
; 868  : // ����ַ�c ��'D'�����һ���������������Ƶĸ�����������Ϊ0 ������һ��
; 869  : 			case 'D':
; 870  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L982

; 871  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L982:

; 872  : 				gotoxy (x - par[0], y);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	sub	ecx, eax
	cmp	ecx, edx
	ja	$L970
	mov	edx, DWORD PTR _y
	mov	edi, DWORD PTR _video_num_lines
	cmp	edx, edi
	jae	$L970
	mov	DWORD PTR _x, ecx

; 873  : 				break;

	jmp	$L1207
$L983:

; 874  : // ����ַ�c ��'E'�����һ�����������������ƶ������������ص�0 �С�������Ϊ0 ������һ�С�
; 875  : 			case 'E':
; 876  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L984

; 877  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L984:

; 878  : 				gotoxy (0, y + par[0]);

	mov	edx, DWORD PTR _y
	lea	ecx, DWORD PTR [eax+edx]
	mov	edx, DWORD PTR _video_num_lines
	cmp	ecx, edx
	jae	$L970
	mov	DWORD PTR _x, edi

; 879  : 				break;

	jmp	$L1205
$L985:

; 880  : // ����ַ�c ��'F'�����һ�����������������ƶ������������ص�0 �С�������Ϊ0 ������һ�С�
; 881  : 			case 'F':
; 882  : 				if (!par[0])

	cmp	eax, edi
	jne	SHORT $L986

; 883  : 					par[0]++;

	mov	eax, 1
	mov	DWORD PTR _par, eax
$L986:

; 884  : 				gotoxy (0, y - par[0]);

	mov	ecx, DWORD PTR _y
	mov	edx, DWORD PTR _video_num_lines
	sub	ecx, eax
	cmp	ecx, edx
	jae	$L970
	mov	DWORD PTR _x, edi

; 885  : 				break;

	jmp	$L1205
$L987:

; 886  : // ����ַ�c ��'d'�����һ�����������������ڵ��к�(��0 ����)��
; 887  : 			case 'd':
; 888  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L988

; 889  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L988:

; 890  : 				gotoxy (x, par[0]);

	mov	ecx, DWORD PTR _x
	mov	edx, DWORD PTR _video_num_columns
	cmp	ecx, edx
	ja	$L970
	cmp	eax, DWORD PTR _video_num_lines
	jae	$L970
	mov	edx, eax
	mov	edi, DWORD PTR _origin
	imul	edx, DWORD PTR _video_size_row
	add	edi, edx
	mov	DWORD PTR _y, eax
	lea	ecx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, ecx

; 891  : 				break;

	jmp	$L970
$L989:

; 892  : // ����ַ�c ��'H'��'f'�����һ�������������Ƶ����кţ��ڶ��������������Ƶ����кš�
; 893  : 			case 'H':
; 894  : 			case 'f':
; 895  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L990

; 896  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L990:

; 897  : 				if (par[1])

	mov	ecx, DWORD PTR _par+4
	cmp	ecx, edi
	je	SHORT $L991

; 898  : 					par[1]--;

	dec	ecx
	mov	DWORD PTR _par+4, ecx
$L991:

; 899  : 				gotoxy (par[1], par[0]);

	cmp	ecx, DWORD PTR _video_num_columns
	ja	$L970
	cmp	eax, DWORD PTR _video_num_lines
	jae	$L970
	mov	DWORD PTR _x, ecx
	mov	DWORD PTR _y, eax
	mov	edx, eax
$L1207:
	imul	edx, DWORD PTR _video_size_row
	mov	edi, DWORD PTR _origin
	add	edi, edx
	lea	ecx, DWORD PTR [edi+ecx*2]
	mov	DWORD PTR _pos, ecx

; 900  : 				break;

	jmp	$L970
$L992:

; 901  : // ����ַ�c ��'J'�����һ�����������Թ������λ�������ķ�ʽ��
; 902  : // ANSI ת�����У�'ESC [sJ'(s = 0 ɾ����굽��Ļ�׶ˣ�1 ɾ����Ļ��ʼ����괦��2 ����ɾ��)��
; 903  : 			case 'J':
; 904  : 				csi_J (par[0]);

	push	eax
	call	_csi_J
	add	esp, 4

; 905  : 				break;

	jmp	$L1201
$L993:

; 906  : // ����ַ�c ��'K'�����һ�����������Թ������λ�ö������ַ�����ɾ������ķ�ʽ��
; 907  : // ANSI ת���ַ����У�'ESC [sK'(s = 0 ɾ������β��1 �ӿ�ʼɾ����2 ���ж�ɾ��)��
; 908  : 			case 'K':
; 909  : 				csi_K (par[0]);

	push	eax
	call	_csi_K
	add	esp, 4

; 910  : 				break;

	jmp	$L1201
$L994:

; 911  : // ����ַ�c ��'L'����ʾ�ڹ��λ�ô�����n ��(ANSI ת���ַ�����'ESC [nL')��
; 912  : 			case 'L':
; 913  : 				csi_L (par[0]);

	push	eax
	call	_csi_L
	add	esp, 4

; 914  : 				break;

	jmp	$L1201
$L995:

; 915  : // ����ַ�c ��'M'����ʾ�ڹ��λ�ô�ɾ��n ��(ANSI ת���ַ�����'ESC [nM')��
; 916  : 			case 'M':
; 917  : 				csi_M (par[0]);

	push	eax
	call	_csi_M
	add	esp, 4

; 918  : 				break;

	jmp	$L1201
$L996:

; 919  : // ����ַ�c ��'P'����ʾ�ڹ��λ�ô�ɾ��n ���ַ�(ANSI ת���ַ�����'ESC [nP')��
; 920  : 			case 'P':
; 921  : 				csi_P (par[0]);

	push	eax
	call	_csi_P
	add	esp, 4

; 922  : 				break;

	jmp	$L1201
$L997:

; 923  : // ����ַ�c ��'@'����ʾ�ڹ��λ�ô�����n ���ַ�(ANSI ת���ַ�����'ESC [n@')��
; 924  : 			case '@':
; 925  : 				csi_at (par[0]);

	push	eax
	call	_csi_at
	add	esp, 4

; 926  : 				break;

	jmp	$L1201
$L998:

; 927  : // ����ַ�c ��'m'����ʾ�ı��괦�ַ�����ʾ���ԣ�����Ӵ֡����»��ߡ���˸�����Եȡ�
; 928  : // ANSI ת���ַ����У�'ESC [nm'��n = 0 ������ʾ��1 �Ӵ֣�4 ���»��ߣ�7 ���ԣ�27 ������ʾ��
; 929  : 			case 'm':
; 930  : 				csi_m ();

	call	_csi_m

; 931  : 				break;

	jmp	$L1201
$L999:

; 932  : // ����ַ�c ��'r'�����ʾ�������������ù�������ʼ�кź���ֹ�кš�
; 933  : 			case 'r':
; 934  : 				if (par[0])

	cmp	eax, edi
	je	SHORT $L1000

; 935  : 					par[0]--;

	dec	eax
	mov	DWORD PTR _par, eax
$L1000:

; 936  : 				if (!par[1])

	mov	ecx, DWORD PTR _par+4
	cmp	ecx, edi
	jne	SHORT $L1001

; 937  : 					par[1] = video_num_lines;

	mov	ecx, DWORD PTR _video_num_lines
	mov	DWORD PTR _par+4, ecx
$L1001:

; 938  : 				if (par[0] < par[1] && par[1] <= video_num_lines)

	cmp	eax, ecx
	jae	$L970
	cmp	ecx, DWORD PTR _video_num_lines
	ja	$L970

; 939  : 				{
; 940  : 					top = par[0];

	mov	DWORD PTR _top, eax

; 941  : 					bottom = par[1];

	mov	DWORD PTR _bottom, ecx

; 942  : 				}
; 943  : 				break;

	jmp	$L970

; 957  : }

	npad	1
$L1209:
	DD	$L923
	DD	$L944
	DD	$L958
	DD	$L1203
	DD	$L966
$L1211:
	DD	$L997
	DD	$L975
	DD	$L977
	DD	$L979
	DD	$L981
	DD	$L983
	DD	$L985
	DD	$L973
	DD	$L989
	DD	$L992
	DD	$L993
	DD	$L994
	DD	$L995
	DD	$L996
	DD	$L987
	DD	$L998
	DD	$L999
	DD	$L1003
	DD	$L1004
	DD	$L970
$L1210:
	DB	0
	DB	1
	DB	2
	DB	3
	DB	4
	DB	5
	DB	6
	DB	7
	DB	8
	DB	19					; 00000013H
	DB	9
	DB	10					; 0000000aH
	DB	11					; 0000000bH
	DB	12					; 0000000cH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	13					; 0000000dH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	7
	DB	3
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	14					; 0000000eH
	DB	2
	DB	8
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	15					; 0000000fH
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	19					; 00000013H
	DB	16					; 00000010H
	DB	17					; 00000011H
	DB	19					; 00000013H
	DB	18					; 00000012H
_con_write ENDP
_lf	PROC NEAR

; 352  : // ������û�д��ڵ�����2 ��֮����ֱ���޸Ĺ�굱ǰ�б���y++������������Ӧ��ʾ�ڴ�λ��
; 353  : // pos(������Ļһ���ַ�����Ӧ���ڴ泤��)��
; 354  : 	if (y + 1 < bottom)

	mov	eax, DWORD PTR _y
	mov	ecx, DWORD PTR _bottom
	inc	eax
	cmp	eax, ecx
	jae	SHORT $L750

; 355  : 	{
; 356  : 		y++;
; 357  : 		pos += video_size_row;

	mov	ecx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, eax
	add	DWORD PTR _pos, ecx

; 362  : }

	ret	0
$L750:

; 358  : 		return;
; 359  : 	}
; 360  : // ������Ҫ����Ļ��������һ�С�
; 361  : 	scrup ();

	jmp	_scrup
_lf	ENDP
_TEXT	ENDS
_BSS	SEGMENT
_video_type DB	01H DUP (?)
	ALIGN	4

_video_mem_end DD 01H DUP (?)
_video_erase_char DW 01H DUP (?)
	ALIGN	4

_scr_end DD	01H DUP (?)
_BSS	ENDS
_TEXT	SEGMENT
$T1220 = -1
$T1226 = -1
$T1232 = -1
$T1238 = -1
_t1$ = -8
_t2$ = -16
_t3$ = -12
_scrup	PROC NEAR

; 128  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	mov	al, BYTE PTR _video_type
	push	esi
	cmp	al, 33					; 00000021H
	push	edi
	je	SHORT $L732
	cmp	al, 32					; 00000020H
	je	SHORT $L732

; 226  : 			}
; 227  : /*	  __asm__ ("cld\n\t"
; 228  : 		   "rep\n\t"
; 229  : 		   "movsl\n\t"	//
; 230  : 		   "movl _video_num_columns,%%ecx\n\t"
; 231  : 		   "rep\n\t"
; 232  : 	"stosw"::"a" (video_erase_char), "c" ((bottom - top - 1) * video_num_columns >> 1), 
; 233  : 	"D" (origin + video_size_row * top), "S" (origin + video_size_row * (top + 1))
; 234  : 			:"cx", "di","si");*/
; 235  : 		}
; 236  : 	}
; 237  : // �����ʾ���Ͳ���EGA(��MDA)����ִ�������ƶ���������ΪMDA ��ʾ���ƿ����Զ�����������ʾ��Χ
; 238  : // �������Ҳ�����Զ�����ָ�룬�������ﲻ����Ļ���ݶ�Ӧ�ڴ泬����ʾ�ڴ�����������������
; 239  : // ������EGA �������ƶ������ȫһ����
; 240  : 	else				/* Not EGA/VGA */
; 241  : 	{
; 242  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	ecx, DWORD PTR _bottom
	mov	eax, DWORD PTR _top
	sub	ecx, eax

; 243  : 		t2 = origin + video_size_row * top;

	mov	edx, DWORD PTR _origin
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax
	add	esi, edx

; 244  : 		t3 = origin + video_size_row * (top + 1);

	inc	eax
	imul	eax, ecx
	add	eax, edx
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], eax

; 245  : 		_asm {
; 246  : 			pushf

	pushf

; 247  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 248  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 249  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 250  : //		  mov edi,(origin + video_size_row * top);
; 251  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 252  : //		  mov esi,(origin + video_size_row * (top + 1));
; 253  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 254  : 			cld;

	cld

; 255  : 			rep movsd;

	rep	 movsd

; 256  : 			mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 257  : 			rep stosw;

	rep	 stosw

; 258  : 			popf

	popf

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L732:

; 134  : // ����ƶ���ʼ��top=0���ƶ������bottom=video_num_lines=25�����ʾ�������������ƶ���
; 135  : 		if (!top && bottom == video_num_lines)

	mov	ecx, DWORD PTR _top
	mov	eax, DWORD PTR _bottom
	test	ecx, ecx
	jne	$L733
	mov	edx, DWORD PTR _video_num_lines
	cmp	eax, edx
	jne	$L733

; 138  : // ��ǰ����Ӧ���ڴ�λ���Լ���Ļĩ��ĩ���ַ�ָ��scr_end ��λ�á�
; 139  : 			origin += video_size_row;

	mov	eax, DWORD PTR _video_size_row

; 140  : 			pos += video_size_row;

	mov	ecx, DWORD PTR _pos
	mov	esi, DWORD PTR _origin
	add	ecx, eax
	add	esi, eax
	mov	DWORD PTR _pos, ecx

; 141  : 			scr_end += video_size_row;

	mov	ecx, DWORD PTR _scr_end
	mov	DWORD PTR _origin, esi

; 142  : // �����Ļĩ�����һ����ʾ�ַ�����Ӧ����ʾ�ڴ�ָ��scr_end ������ʵ����ʾ�ڴ��ĩ�ˣ���
; 143  : // ��Ļ�����ڴ������ƶ�����ʾ�ڴ����ʼλ��video_mem_start �������ڳ��ֵ�����������ո��ַ���
; 144  : 			if (scr_end > video_mem_end)

	mov	esi, DWORD PTR _video_mem_end
	add	ecx, eax
	cmp	ecx, esi
	mov	DWORD PTR _scr_end, ecx
	jbe	SHORT $L734

; 145  : 			{
; 146  : // %0 - eax(�����ַ�+����)��%1 - ecx((��ʾ���ַ�����-1)����Ӧ���ַ���/2�����Գ����ƶ�)��
; 147  : // %2 - edi(��ʾ�ڴ���ʼλ��video_mem_start)��%3 - esi(��Ļ���ݶ�Ӧ���ڴ���ʼλ��origin)��
; 148  : // �ƶ�����[edi]->[esi]���ƶ�ecx �����֡�
; 149  : 				t1 = (video_num_lines - 1) * video_num_columns >> 1;

	dec	edx
	imul	edx, DWORD PTR _video_num_columns
	shr	edx, 1
	mov	DWORD PTR _t1$[ebp], edx

; 150  : 				_asm {
; 151  : 					pushf

	pushf

; 152  : 					mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 153  : //			  mov ecx,((video_num_lines - 1) * video_num_columns >> 1);
; 154  : 					mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 155  : 					mov edi,video_mem_start;

	mov	edi, DWORD PTR _video_mem_start

; 156  : 					mov esi,origin;

	mov	esi, DWORD PTR _origin

; 157  : 					cld;	// �巽��λ��

	cld

; 158  : 					rep movsd;	// �ظ�����������ǰ��Ļ�ڴ������ƶ�����ʾ�ڴ���ʼ����

	rep	 movsd

; 159  : 					mov ecx,video_num_columns;	// ecx=1 ���ַ�����

	mov	ecx, DWORD PTR _video_num_columns

; 160  : 					rep stosw;	// ������������ո��ַ���

	rep	 stosw

; 161  : 					popf

	popf

; 162  : 				}
; 163  : /*	      __asm__ ("cld\n\t"
; 164  : 		       "rep\n\t"
; 165  : 		       "movsl\n\t" 
; 166  : 		       "movl _video_num_columns,%1\n\t"
; 167  : 		       "rep\n\t"
; 168  : 			   "stosw"
; 169  : 		::"a" (video_erase_char), "c" ((video_num_lines - 1) * video_num_columns >> 1), 
; 170  : 		       "D" (video_mem_start), "S" (origin):"cx", "di","si"); */
; 171  : // ������Ļ�ڴ������ƶ������������µ�����ǰ��Ļ��Ӧ�ڴ����ʼָ�롢���λ��ָ�����Ļĩ��
; 172  : // ��Ӧ�ڴ�ָ��scr_end��
; 173  : 				scr_end -= origin - video_mem_start;

	mov	ecx, DWORD PTR _video_mem_start
	mov	edi, DWORD PTR _origin
	mov	esi, DWORD PTR _scr_end

; 174  : 				pos -= origin - video_mem_start;

	mov	edx, DWORD PTR _pos
	mov	eax, ecx

; 175  : 				origin = video_mem_start;

	mov	DWORD PTR _origin, ecx
	sub	eax, edi
	add	esi, eax
	add	edx, eax
	mov	DWORD PTR _scr_end, esi
	mov	DWORD PTR _pos, edx

; 176  : 			}
; 177  : 			else

	jmp	SHORT $L735
$L734:

; 178  : 			{
; 179  : // ������������Ļĩ�˶�Ӧ���ڴ�ָ��scr_end û�г�����ʾ�ڴ��ĩ��video_mem_end����ֻ����
; 180  : // ��������������ַ�(�ո��ַ�)��
; 181  : // %0 - eax(�����ַ�+����)��%1 - ecx(��ʾ���ַ�����)��%2 - edi(��Ļ��Ӧ�ڴ����һ�п�ʼ��)��
; 182  : 				t1 = scr_end - video_size_row;

	sub	ecx, eax
	mov	DWORD PTR _t1$[ebp], ecx

; 183  : 				_asm {
; 184  : 					pushf

	pushf

; 185  : 					mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 186  : 					mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 187  : 					mov edi,t1;

	mov	edi, DWORD PTR _t1$[ebp]

; 188  : //			  mov edi,(scr_end - video_size_row);
; 189  : 					cld;	// �巽��λ��

	cld

; 190  : 					rep stosw;	// �ظ����������³���������������ַ�(�ո��ַ�)��

	rep	 stosw

; 191  : 					popf

	popf

; 178  : 			{
; 179  : // ������������Ļĩ�˶�Ӧ���ڴ�ָ��scr_end û�г�����ʾ�ڴ��ĩ��video_mem_end����ֻ����
; 180  : // ��������������ַ�(�ո��ַ�)��
; 181  : // %0 - eax(�����ַ�+����)��%1 - ecx(��ʾ���ַ�����)��%2 - edi(��Ļ��Ӧ�ڴ����һ�п�ʼ��)��
; 182  : 				t1 = scr_end - video_size_row;

$L735:

; 129  : 	unsigned long t1,t2,t3;

	cli

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // ����ʾ��������д���µ���Ļ���ݶ�Ӧ���ڴ���ʼλ��ֵ��
; 200  : 			set_origin ();

	mov	BYTE PTR $T1220[ebp], 12		; 0000000cH

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1220[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_reg

; 131  : // �����ʾ������EGA����ִ�����²�����

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1242
$l1$1242:

; 133  : 	{

	jmp	SHORT $l2$1243
$l2$1243:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // ����ʾ��������д���µ���Ļ���ݶ�Ӧ���ڴ���ʼλ��ֵ��
; 200  : 			set_origin ();

	mov	edx, DWORD PTR _origin
	mov	edi, DWORD PTR _video_mem_start
	sub	edx, edi
	shr	edx, 9
	mov	BYTE PTR $T1226[ebp], dl

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1226[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_val

; 131  : // �����ʾ������EGA����ִ�����²�����

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1246
$l1$1246:

; 133  : 	{

	jmp	SHORT $l2$1247
$l2$1247:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // ����ʾ��������д���µ���Ļ���ݶ�Ӧ���ڴ���ʼλ��ֵ��
; 200  : 			set_origin ();

	mov	BYTE PTR $T1232[ebp], 13		; 0000000dH

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1232[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_reg

; 131  : // �����ʾ������EGA����ִ�����²�����

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1250
$l1$1250:

; 133  : 	{

	jmp	SHORT $l2$1251
$l2$1251:

; 192  : 				}
; 193  : /*		  __asm__ ("cld\n\t"
; 194  : 		       "rep\n\t"
; 195  : 		       "stosw" 
; 196  : 			::"a" (video_erase_char), "c" (video_num_columns), 
; 197  : 		      "D" (scr_end - video_size_row):"cx","di");*/
; 198  : 			} 
; 199  : // ����ʾ��������д���µ���Ļ���ݶ�Ӧ���ڴ���ʼλ��ֵ��
; 200  : 			set_origin ();

	mov	eax, DWORD PTR _origin
	mov	edx, DWORD PTR _video_mem_start
	sub	eax, edx
	shr	eax, 1
	mov	BYTE PTR $T1238[ebp], al

; 129  : 	unsigned long t1,t2,t3;

	mov	al, BYTE PTR $T1238[ebp]

; 130  : 

	mov	dx, WORD PTR _video_port_val

; 131  : // �����ʾ������EGA����ִ�����²�����

	out	dx, al

; 132  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	jmp	SHORT $l1$1254
$l1$1254:

; 133  : 	{

	jmp	SHORT $l2$1255
$l2$1255:

; 136  : 		{
; 137  : // ������Ļ��ʾ��Ӧ�ڴ����ʼλ��ָ��origin Ϊ������һ����Ļ�ַ���Ӧ���ڴ�λ�ã�ͬʱҲ����

	sti

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L733:

; 201  : // �����ʾ���������ƶ���Ҳ����ʾ��ָ����top ��ʼ�������������ƶ�1 ��(ɾ��1 ��)����ʱֱ��
; 202  : // ����Ļ��ָ����top ����Ļĩ�������ж�Ӧ����ʾ�ڴ����������ƶ�1 �У������³��ֵ����������
; 203  : // ���ַ���
; 204  : // %0-eax(�����ַ�+����)��%1-ecx(top ����1 �п�ʼ����Ļĩ�е���������Ӧ���ڴ泤����)��
; 205  : // %2-edi(top ���������ڴ�λ��)��%3-esi(top+1 ���������ڴ�λ��)��
; 206  : 		}
; 207  : 		else
; 208  : 		{
; 209  : 			t1 = (bottom - top - 1) * video_num_columns >> 1;

	sub	eax, ecx

; 210  : 			t2 = origin + video_size_row * top;

	mov	edx, DWORD PTR _origin
	dec	eax
	imul	eax, DWORD PTR _video_num_columns
	shr	eax, 1
	mov	DWORD PTR _t1$[ebp], eax
	mov	eax, DWORD PTR _video_size_row
	mov	esi, eax
	imul	esi, ecx
	add	esi, edx

; 211  : 			t3 = origin + video_size_row * (top + 1);

	inc	ecx
	imul	ecx, eax
	add	ecx, edx
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], ecx

; 212  : 			_asm {
; 213  : 				pushf

	pushf

; 214  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 215  : 				mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 216  : //		  mov edi,(origin + video_size_row * top);
; 217  : 				mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 218  : //		  mov esi,(origin + video_size_row * (top + 1));
; 219  : 				mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 220  : 				mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 221  : 				cld;	// �巽��λ��

	cld

; 222  : 				rep movsd;// ѭ����������top+1 ��bottom �� ����Ӧ���ڴ���Ƶ�top �п�ʼ����

	rep	 movsd

; 223  : 				mov ecx,video_num_columns;	// ecx = 1 ���ַ�����

	mov	ecx, DWORD PTR _video_num_columns

; 224  : 				rep stosw;// ����������������ַ���

	rep	 stosw

; 225  : 				popf

	popf

; 259  : 		}
; 260  : /*    __asm__ ("cld\n\t" "rep\n\t" "movsl\n\t" \
; 261  : 		"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw"\
; 262  : 		::"a" (video_erase_char), \
; 263  : 		"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 264  : 		"D" (origin + video_size_row * top), \
; 265  : 		"S" (origin + video_size_row * (top + 1)):"cx", "di","si");*/
; 266  : 	}
; 267  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_scrup	ENDP
_ri	PROC NEAR

; 368  : // �����겻�ڵ�1 ���ϣ���ֱ���޸Ĺ�굱ǰ�б���y--������������Ӧ��ʾ�ڴ�λ��pos����ȥ
; 369  : // ��Ļ��һ���ַ�����Ӧ���ڴ泤���ֽ�����
; 370  : 	if (y > top)

	mov	eax, DWORD PTR _y
	mov	ecx, DWORD PTR _top
	cmp	eax, ecx
	jbe	SHORT $L754

; 371  : 	{
; 372  : 		y--;

	mov	ecx, eax

; 373  : 		pos -= video_size_row;

	mov	eax, DWORD PTR _pos
	dec	ecx
	mov	DWORD PTR _y, ecx
	mov	ecx, DWORD PTR _video_size_row
	sub	eax, ecx
	mov	DWORD PTR _pos, eax

; 378  : }

	ret	0
$L754:

; 374  : 		return;
; 375  : 	}
; 376  : // ������Ҫ����Ļ��������һ�С�
; 377  : 	scrdown ();

	jmp	_scrdown
_ri	ENDP
_t1$ = -12
_t2$ = -8
_t3$ = -4
_scrdown PROC NEAR

; 275  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 276  : 	unsigned long t1,t2,t3;
; 277  : // �����ʾ������EGA����ִ�����в�����
; 278  : // [??����if ��else �Ĳ�����ȫһ����!Ϊʲô��Ҫ�ֱ����أ��ѵ��������л��йأ�]
; 279  : 	if (video_type == VIDEO_TYPE_EGAC || video_type == VIDEO_TYPE_EGAM)

	mov	al, BYTE PTR _video_type
	push	esi
	cmp	al, 33					; 00000021H
	push	edi
	je	SHORT $L745
	cmp	al, 32					; 00000020H
	je	SHORT $L745

; 302  : 		}
; 303  : /*      __asm__ ("std\n\t"
; 304  : 	       "rep\n\t"
; 305  : 	       "movsl\n\t"	// 
; 306  : 	       "addl $2,%%edi\n\t"
; 307  : 	       "movl _video_num_columns,%%ecx\n\t"
; 308  : 	       "rep\n\t"
; 309  : 		   "stosw":
; 310  : 	:"a" (video_erase_char), \
; 311  : 	"c" ((bottom - top - 1) * video_num_columns >> 1), \
; 312  : 	"D" (origin + video_size_row * bottom - 4), \
; 313  : 	"S" (origin + video_size_row * (bottom - 1) - 4)
; 314  : 	:"ax", "cx", "di", "si");*/
; 315  : 	}
; 316  : // �������EGA ��ʾ���ͣ���ִ�����²�����Ŀǰ��������ȫһ������
; 317  : 	else				/* Not EGA/VGA */
; 318  : 	{
; 319  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	eax, DWORD PTR _bottom
	mov	edi, DWORD PTR _top
	mov	ecx, eax

; 320  : 		t2 = origin + video_size_row * bottom - 4;

	mov	edx, DWORD PTR _origin
	sub	ecx, edi
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax

; 321  : 		t3 = origin + video_size_row * (bottom - 1) - 4;

	dec	eax
	imul	eax, ecx
	lea	esi, DWORD PTR [esi+edx-4]
	lea	edx, DWORD PTR [eax+edx-4]
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], edx

; 322  : 		_asm {
; 323  : 			pushf

	pushf

; 324  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 325  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 326  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 327  : //		  mov edi,(origin + video_size_row * bottom - 4);
; 328  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 329  : //		  mov esi,(origin + video_size_row * (bottom - 1) - 4);
; 330  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 331  : 			std;

	std

; 332  : 			rep movsd;

	rep	 movsd

; 333  : 			add edi,2;/* %edi has been decremented by 4 */

	add	edi, 2

; 334  : 			mov ecx,video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns

; 335  : 			rep stosw;

	rep	 stosw

; 336  : 			popf

	popf

; 337  : 		}
; 338  :  /*     __asm__ ("std\n\t" "rep\n\t" "movsl\n\t" "addl $2,%%edi\n\t"
; 339  : 				"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw":
; 340  : 			:"a" (video_erase_char), 
; 341  : 			"c" ((bottom - top - 1) * video_num_columns >> 1), 
; 342  : 			"D" (origin + video_size_row * bottom - 4), 
; 343  : 			"S" (origin + video_size_row * (bottom - 1) - 4)
; 344  : 	       :"ax", "cx", "di","si");*/
; 345  : 	}
; 346  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L745:

; 280  : 	{
; 281  : // %0-eax(�����ַ�+����)��%1-ecx(top �п�ʼ����Ļĩ��-1 �е���������Ӧ���ڴ泤����)��
; 282  : // %2-edi(��Ļ���½����һ������λ��)��%3-esi(��Ļ������2 �����һ������λ��)��
; 283  : // �ƶ�����[esi]??[edi]���ƶ�ecx �����֡�
; 284  : 		t1 = (bottom - top - 1) * video_num_columns >> 1;

	mov	eax, DWORD PTR _bottom
	mov	edi, DWORD PTR _top
	mov	ecx, eax

; 285  : 		t2 = origin + video_size_row * bottom - 4;

	mov	edx, DWORD PTR _origin
	sub	ecx, edi
	dec	ecx
	imul	ecx, DWORD PTR _video_num_columns
	shr	ecx, 1
	mov	DWORD PTR _t1$[ebp], ecx
	mov	ecx, DWORD PTR _video_size_row
	mov	esi, ecx
	imul	esi, eax

; 286  : 		t3 = origin + video_size_row * (bottom - 1) - 4;

	dec	eax
	imul	eax, ecx
	lea	esi, DWORD PTR [esi+edx-4]
	lea	edx, DWORD PTR [eax+edx-4]
	mov	DWORD PTR _t2$[ebp], esi
	mov	DWORD PTR _t3$[ebp], edx

; 287  : 		_asm {
; 288  : 			pushf

	pushf

; 289  : 			mov ecx,t1;

	mov	ecx, DWORD PTR _t1$[ebp]

; 290  : //		  mov ecx,((bottom - top - 1) * video_num_columns >> 1);
; 291  : 			mov edi,t2;

	mov	edi, DWORD PTR _t2$[ebp]

; 292  : //		  mov edi,(origin + video_size_row * bottom - 4);
; 293  : 			mov esi,t3;

	mov	esi, DWORD PTR _t3$[ebp]

; 294  : //		  mov esi,(origin + video_size_row * (bottom - 1) - 4);
; 295  : 			mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 296  : 			std;	// �÷���λ��

	std

; 297  : 			rep movsd;	// �ظ������������ƶ���top �е�bottom-1 �ж�Ӧ���ڴ����ݡ�

	rep	 movsd

; 298  : 			add edi,2;	/* %edi �Ѿ���4����ΪҲ�Ƿ���������ַ� */

	add	edi, 2

; 299  : 			mov ecx,video_num_columns;	// ��ecx=1 ���ַ�����

	mov	ecx, DWORD PTR _video_num_columns

; 300  : 			rep stosw;	// �������ַ������Ϸ������С�

	rep	 stosw

; 301  : 			popf

	popf

; 337  : 		}
; 338  :  /*     __asm__ ("std\n\t" "rep\n\t" "movsl\n\t" "addl $2,%%edi\n\t"
; 339  : 				"movl _video_num_columns,%%ecx\n\t" "rep\n\t" "stosw":
; 340  : 			:"a" (video_erase_char), 
; 341  : 			"c" ((bottom - top - 1) * video_num_columns >> 1), 
; 342  : 			"D" (origin + video_size_row * bottom - 4), 
; 343  : 			"S" (origin + video_size_row * (bottom - 1) - 4)
; 344  : 	       :"ax", "cx", "di","si");*/
; 345  : 	}
; 346  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_scrdown ENDP
_cr	PROC NEAR

; 384  : // ������ڵ��к�*2 ��0 �е���������ж�Ӧ���ڴ��ֽڳ��ȡ�
; 385  : 	pos -= x << 1;

	mov	eax, DWORD PTR _x

; 386  : 	x = 0;

	mov	DWORD PTR _x, 0
	lea	ecx, DWORD PTR [eax+eax]
	mov	eax, DWORD PTR _pos
	sub	eax, ecx
	mov	DWORD PTR _pos, eax

; 387  : }

	ret	0
_cr	ENDP
_del	PROC NEAR

; 393  : // ������û�д���0 �У��򽫹���Ӧ�ڴ�λ��ָ��pos ����2 �ֽ�(��Ӧ��Ļ��һ���ַ�)��Ȼ��
; 394  : // ����ǰ��������ֵ��1�������������λ���ַ�������
; 395  : 	if (x)

	mov	eax, DWORD PTR _x
	test	eax, eax
	je	SHORT $L761

; 396  : 	{
; 397  : 		pos -= 2;

	mov	eax, DWORD PTR _pos

; 398  : 		x--;

	mov	ecx, DWORD PTR _x
	sub	eax, 2
	dec	ecx
	mov	DWORD PTR _x, ecx

; 399  : 		*(unsigned short *) pos = video_erase_char;

	mov	cx, WORD PTR _video_erase_char
	mov	DWORD PTR _pos, eax
	mov	WORD PTR [eax], cx
$L761:

; 400  : 	}
; 401  : }

	ret	0
_del	ENDP
_par$ = 8
_count$ = -4
_start$ = 8
_csi_J	PROC NEAR

; 409  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 410  : 	long count; //__asm__ ("cx")	// ��Ϊ�Ĵ���������
; 411  : 	long start; //__asm__ ("di")
; 412  : 
; 413  : // ���ȸ�����������ֱ�������Ҫɾ�����ַ�����ɾ����ʼ����ʾ�ڴ�λ�á�
; 414  : 	switch (par)
; 415  : 	{

	mov	eax, DWORD PTR _par$[ebp]
	push	edi
	sub	eax, 0
	je	SHORT $L773
	dec	eax
	je	SHORT $L774
	dec	eax
	jne	SHORT $L766

; 424  : 	case 2:			/* erase whole display *//* ɾ��������Ļ�ϵ��ַ� */
; 425  : 		count = video_num_columns * video_num_lines;

	mov	eax, DWORD PTR _video_num_lines

; 426  : 		start = origin;

	mov	ecx, DWORD PTR _origin
	imul	eax, DWORD PTR _video_num_columns
	mov	DWORD PTR _count$[ebp], eax
	mov	DWORD PTR _start$[ebp], ecx

; 427  : 		break;

	jmp	SHORT $L770
$L774:

; 419  : 		break;
; 420  : 	case 1:			/* erase from start to cursor *//* ɾ������Ļ��ʼ����괦���ַ� */
; 421  : 		count = (pos - origin) >> 1;

	mov	edx, DWORD PTR _pos
	mov	eax, DWORD PTR _origin
	sub	edx, eax
	shr	edx, 1
	mov	DWORD PTR _count$[ebp], edx

; 422  : 		start = origin;
; 423  : 		break;

	jmp	SHORT $L1262
$L773:

; 416  : 	case 0:			/* erase from cursor to end of display *//* ������굽��Ļ�׶� */
; 417  : 		count = (scr_end - pos) >> 1;

	mov	ecx, DWORD PTR _scr_end
	mov	eax, DWORD PTR _pos
	sub	ecx, eax
	shr	ecx, 1
	mov	DWORD PTR _count$[ebp], ecx
$L1262:

; 418  : 		start = pos;

	mov	DWORD PTR _start$[ebp], eax
$L770:

; 428  : 	default:
; 429  : 		return;
; 430  : 	}
; 431  : // Ȼ��ʹ�ò����ַ���дɾ���ַ��ĵط���
; 432  : // %0 - ecx(Ҫɾ�����ַ���count)��%1 - edi(ɾ��������ʼ��ַ)��%2 - eax������Ĳ����ַ�����
; 433  : 	_asm {
; 434  : 		pushf

	pushf

; 435  : 		mov ecx,count;

	mov	ecx, DWORD PTR _count$[ebp]

; 436  : 		mov edi,start;

	mov	edi, DWORD PTR _start$[ebp]

; 437  : 		mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 438  : 		cld;

	cld

; 439  : 		rep stosw;

	rep	 stosw

; 440  : 		popf

	popf
$L766:

; 441  : 	}
; 442  : /*  __asm__ ("cld\n\t" "rep\n\t" "stosw\n\t"
; 443  : 	::"c" (count), "D" (start), "a" (video_erase_char):"cx", "di");*/
; 444  : }

	pop	edi
	mov	esp, ebp
	pop	ebp
	ret	0
_csi_J	ENDP
_par$ = 8
_count$ = 8
_start$ = -4
_csi_K	PROC NEAR

; 450  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 451  : 	long count; //__asm__ ("cx")	// ���üĴ���������
; 452  : 	long start; //__asm__ ("di")
; 453  : 
; 454  : // ���ȸ�����������ֱ�������Ҫɾ�����ַ�����ɾ����ʼ����ʾ�ڴ�λ�á�
; 455  : 	switch (par)
; 456  : 	{

	mov	eax, DWORD PTR _par$[ebp]
	push	edi
	sub	eax, 0
	je	SHORT $L787
	dec	eax
	je	SHORT $L789
	dec	eax
	jne	SHORT $L780

; 467  : 	case 2:			/* erase whole line *//* �������ַ�ȫɾ�� */
; 468  : 		start = pos - (x << 1);

	mov	eax, DWORD PTR _x
	mov	edx, DWORD PTR _pos
	lea	ecx, DWORD PTR [eax+eax]

; 469  : 		count = video_num_columns;

	mov	eax, DWORD PTR _video_num_columns
	sub	edx, ecx
	mov	DWORD PTR _count$[ebp], eax
	mov	DWORD PTR _start$[ebp], edx

; 470  : 		break;

	jmp	SHORT $L784
$L789:

; 462  : 		break;
; 463  : 	case 1:			/* erase from start of line to cursor *//* ɾ�����п�ʼ����괦 */
; 464  : 		start = pos - (x << 1);

	mov	eax, DWORD PTR _x
	mov	edx, DWORD PTR _pos
	lea	ecx, DWORD PTR [eax+eax]
	sub	edx, ecx

; 465  : 		count = (x < video_num_columns) ? x : video_num_columns;

	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	mov	DWORD PTR _start$[ebp], edx
	jae	SHORT $L1264
	mov	DWORD PTR _count$[ebp], eax
	jmp	SHORT $L784
$L1264:
	mov	DWORD PTR _count$[ebp], ecx

; 466  : 		break;

	jmp	SHORT $L784
$L787:

; 457  : 	case 0:			/* erase from cursor to end of line *//* ɾ����굽��β�ַ� */
; 458  : 		if (x >= video_num_columns)

	mov	ecx, DWORD PTR _x
	mov	eax, DWORD PTR _video_num_columns
	cmp	ecx, eax
	jae	SHORT $L780

; 459  : 			return;
; 460  : 		count = video_num_columns - x;

	sub	eax, ecx
	mov	DWORD PTR _count$[ebp], eax

; 461  : 		start = pos;

	mov	eax, DWORD PTR _pos
	mov	DWORD PTR _start$[ebp], eax
$L784:

; 471  : 	default:
; 472  : 		return;
; 473  : 	}
; 474  : // Ȼ��ʹ�ò����ַ���дɾ���ַ��ĵط���
; 475  : // %0 - ecx(Ҫɾ�����ַ���count)��%1 - edi(ɾ��������ʼ��ַ)��%2 - eax������Ĳ����ַ�����
; 476  : 	_asm {
; 477  : 		pushf

	pushf

; 478  : 		mov ecx,count;

	mov	ecx, DWORD PTR _count$[ebp]

; 479  : 		mov edi,start;

	mov	edi, DWORD PTR _start$[ebp]

; 480  : 		mov ax,video_erase_char;

	mov	ax, WORD PTR _video_erase_char

; 481  : 		cld;

	cld

; 482  : 		rep stosw;

	rep	 stosw

; 483  : 		popf

	popf
$L780:

; 484  : 	}
; 485  : /*  __asm__ ("cld\n\t" "rep\n\t" "stosw\n\t"
; 486  : 	::"c" (count), "D" (start), "a" (video_erase_char):"cx", "di");*/
; 487  : }

	pop	edi
	mov	esp, ebp
	pop	ebp
	ret	0
_csi_K	ENDP
_TEXT	ENDS
EXTRN	_copy_to_cooked:NEAR
_DATA	SEGMENT
	ORG $+3
$SG826	DB	01bH, '[?1;2c', 00H
_DATA	ENDS
_TEXT	SEGMENT
_tty$ = 8
_respond PROC NEAR

; 537  : {

	push	ebp
	mov	ebp, esp

; 538  : 	char *p = RESPONSE;

	mov	edx, OFFSET FLAT:$SG826

; 539  : 
; 540  : 	cli ();			// ���жϡ�

	cli

; 541  : 	while (*p)

	mov	cl, BYTE PTR $SG826
	mov	eax, DWORD PTR _tty$[ebp]
	test	cl, cl
	je	SHORT $L829
	push	esi
$L828:

; 542  : 	{				// ���ַ����з���д���С�
; 543  : 		PUTCH (*p, tty->read_q);

	mov	esi, DWORD PTR [eax+52]
	mov	BYTE PTR [esi+eax+64], cl
	mov	ecx, DWORD PTR [eax+52]
	inc	ecx
	and	ecx, 1023				; 000003ffH

; 544  : 		p++;

	inc	edx
	mov	DWORD PTR [eax+52], ecx
	mov	cl, BYTE PTR [edx]
	test	cl, cl
	jne	SHORT $L828
	pop	esi
$L829:

; 545  : 	}
; 546  : 	sti ();			// ���жϡ�

	sti

; 547  : 	copy_to_cooked (tty);		// ת���ɹ淶ģʽ(���븨��������)��

	push	eax
	call	_copy_to_cooked
	add	esp, 4

; 548  : }

	pop	ebp
	ret	0
_respond ENDP
_nr$ = 8
_csi_at	PROC NEAR

; 627  : {

	push	ebp
	mov	ebp, esp

; 628  : // ���������ַ�������һ���ַ��������Ϊһ���ַ������������ַ���nr Ϊ0�������1 ���ַ���
; 629  : 	if (nr > video_num_columns)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	jbe	SHORT $L866

; 630  : 		nr = video_num_columns;

	mov	eax, ecx

; 631  : 	else if (!nr)

	jmp	SHORT $L1270
$L866:
	test	eax, eax
	jne	SHORT $L1270

; 632  : 		nr = 1;

	mov	eax, 1
$L1270:

; 633  : // ѭ������ָ�����ַ�����
; 634  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L871
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L870:

; 635  : 		insert_char ();

	call	_insert_char
	dec	esi
	jne	SHORT $L870
	pop	esi
$L871:

; 636  : }

	pop	ebp
	ret	0
_csi_at	ENDP
_insert_char PROC NEAR

; 554  : 	unsigned long i = x;
; 555  : 	unsigned short tmp, old = video_erase_char;
; 556  : 	unsigned short *p = (unsigned short *) pos;
; 557  : 
; 558  : // ��꿪ʼ�������ַ�����һ�񣬲��������ַ������ڹ�����ڴ���
; 559  : // ��һ���϶����ַ��Ļ����������һ���ַ����������??
; 560  : 	while (i++ < video_num_columns)

	mov	edx, DWORD PTR _video_num_columns
	mov	ecx, DWORD PTR _video_erase_char
	mov	eax, DWORD PTR _pos
	push	esi
	mov	esi, DWORD PTR _x
	push	edi
	cmp	esi, edx
	lea	edi, DWORD PTR [esi+1]
	jae	SHORT $L841
	sub	edx, edi
	inc	edx
	mov	esi, edx
$L840:

; 561  : 	{
; 562  : 		tmp = *p;

	mov	dx, WORD PTR [eax]

; 563  : 		*p = old;

	mov	WORD PTR [eax], cx

; 564  : 		old = tmp;
; 565  : 		p++;

	add	eax, 2
	dec	esi
	mov	ecx, edx
	jne	SHORT $L840
$L841:
	pop	edi
	pop	esi

; 566  : 	}
; 567  : }

	ret	0
_insert_char ENDP
_nr$ = 8
_csi_L	PROC NEAR

; 642  : {

	push	ebp
	mov	ebp, esp

; 643  : // ������������������Ļ������������Ϊ��Ļ��ʾ����������������nr Ϊ0�������1 �С�
; 644  : 	if (nr > video_num_lines)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_lines
	cmp	eax, ecx
	jbe	SHORT $L876

; 645  : 		nr = video_num_lines;

	mov	eax, ecx

; 646  : 	else if (!nr)

	jmp	SHORT $L1276
$L876:
	test	eax, eax
	jne	SHORT $L1276

; 647  : 		nr = 1;

	mov	eax, 1
$L1276:

; 648  : // ѭ������ָ������nr��
; 649  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L881
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L880:

; 650  : 		insert_line ();

	call	_insert_line
	dec	esi
	jne	SHORT $L880
	pop	esi
$L881:

; 651  : }

	pop	ebp
	ret	0
_csi_L	ENDP
_insert_line PROC NEAR

; 574  : 	int oldtop, oldbottom;
; 575  : 
; 576  : 	oldtop = top;			// ����ԭtop��bottom ֵ��
; 577  : 	oldbottom = bottom;
; 578  : 	top = y;			// ������Ļ����ʼ�С�

	mov	eax, DWORD PTR _y

; 579  : 	bottom = video_num_lines;	// ������Ļ������С�

	mov	ecx, DWORD PTR _video_num_lines
	push	esi
	mov	esi, DWORD PTR _top
	push	edi
	mov	edi, DWORD PTR _bottom
	mov	DWORD PTR _top, eax
	mov	DWORD PTR _bottom, ecx

; 580  : 	scrdown ();			// �ӹ�꿪ʼ������Ļ�������¹���һ�С�

	call	_scrdown

; 581  : 	top = oldtop;			// �ָ�ԭtop��bottom ֵ��
; 582  : 	bottom = oldbottom;

	mov	DWORD PTR _bottom, edi
	mov	DWORD PTR _top, esi
	pop	edi
	pop	esi

; 583  : }

	ret	0
_insert_line ENDP
_nr$ = 8
_csi_P	PROC NEAR

; 657  : {

	push	ebp
	mov	ebp, esp

; 658  : // ���ɾ�����ַ�������һ���ַ��������Ϊһ���ַ�������ɾ���ַ���nr Ϊ0����ɾ��1 ���ַ���
; 659  : 	if (nr > video_num_columns)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_columns
	cmp	eax, ecx
	jbe	SHORT $L886

; 660  : 		nr = video_num_columns;

	mov	eax, ecx

; 661  : 	else if (!nr)

	jmp	SHORT $L1280
$L886:
	test	eax, eax
	jne	SHORT $L1280

; 662  : 		nr = 1;

	mov	eax, 1
$L1280:

; 663  : // ѭ��ɾ��ָ���ַ���nr��
; 664  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L891
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L890:

; 665  : 		delete_char ();

	call	_delete_char
	dec	esi
	jne	SHORT $L890
	pop	esi
$L891:

; 666  : }

	pop	ebp
	ret	0
_csi_P	ENDP
_delete_char PROC NEAR

; 589  : 	unsigned long i;
; 590  : 	unsigned short *p = (unsigned short *) pos;
; 591  : 
; 592  : // �����곬����Ļ�����У��򷵻ء�
; 593  : 	if (x >= video_num_columns)

	mov	ecx, DWORD PTR _x
	mov	eax, DWORD PTR _video_num_columns
	mov	edx, DWORD PTR _pos
	cmp	ecx, eax
	jae	SHORT $L849

; 594  : 		return;
; 595  : // �ӹ����һ���ַ���ʼ����ĩ�����ַ�����һ��
; 596  : 	i = x;
; 597  : 	while (++i < video_num_columns)

	inc	ecx
	cmp	ecx, eax
	jae	SHORT $L855
	sub	eax, ecx
	push	esi
	mov	ecx, eax
	push	edi
	lea	esi, DWORD PTR [edx+2]
	mov	edi, edx
	shr	ecx, 1
	rep movsd
	adc	ecx, ecx
	lea	edx, DWORD PTR [edx+eax*2]
	rep movsw
	pop	edi
	pop	esi
$L855:

; 598  : 	{
; 599  : 		*p = *(p + 1);
; 600  : 		p++;
; 601  : 	}
; 602  : // ���һ���ַ�����������ַ�(�ո��ַ�)��
; 603  : 	*p = video_erase_char;

	mov	ax, WORD PTR _video_erase_char
	mov	WORD PTR [edx], ax
$L849:

; 604  : }

	ret	0
_delete_char ENDP
_nr$ = 8
_csi_M	PROC NEAR

; 672  : {

	push	ebp
	mov	ebp, esp

; 673  : // ���ɾ��������������Ļ������������Ϊ��Ļ��ʾ��������ɾ��������nr Ϊ0����ɾ��1 �С�
; 674  : 	if (nr > video_num_lines)

	mov	eax, DWORD PTR _nr$[ebp]
	mov	ecx, DWORD PTR _video_num_lines
	cmp	eax, ecx
	jbe	SHORT $L896

; 675  : 		nr = video_num_lines;

	mov	eax, ecx

; 676  : 	else if (!nr)

	jmp	SHORT $L1286
$L896:
	test	eax, eax
	jne	SHORT $L1286

; 677  : 		nr = 1;

	mov	eax, 1
$L1286:

; 678  : // ѭ��ɾ��ָ������nr��
; 679  : 	while (nr--)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	je	SHORT $L901
	push	esi
	lea	esi, DWORD PTR [eax+1]
$L900:

; 680  : 		delete_line ();

	call	_delete_line
	dec	esi
	jne	SHORT $L900
	pop	esi
$L901:

; 681  : }

	pop	ebp
	ret	0
_csi_M	ENDP
_delete_line PROC NEAR

; 611  : 	int oldtop, oldbottom;
; 612  : 
; 613  : 	oldtop = top;			// ����ԭtop��bottom ֵ��
; 614  : 	oldbottom = bottom;
; 615  : 	top = y;			// ������Ļ����ʼ�С�

	mov	eax, DWORD PTR _y

; 616  : 	bottom = video_num_lines;	// ������Ļ������С�

	mov	ecx, DWORD PTR _video_num_lines
	push	esi
	mov	esi, DWORD PTR _top
	push	edi
	mov	edi, DWORD PTR _bottom
	mov	DWORD PTR _top, eax
	mov	DWORD PTR _bottom, ecx

; 617  : 	scrup ();			// �ӹ�꿪ʼ������Ļ�������Ϲ���һ�С�

	call	_scrup

; 618  : 	top = oldtop;			// �ָ�ԭtop��bottom ֵ��
; 619  : 	bottom = oldbottom;

	mov	DWORD PTR _bottom, edi
	mov	DWORD PTR _top, esi
	pop	edi
	pop	esi

; 620  : }

	ret	0
_delete_line ENDP
_save_cur PROC NEAR

; 690  : 	saved_x = x;

	mov	eax, DWORD PTR _x

; 691  : 	saved_y = y;

	mov	ecx, DWORD PTR _y
	mov	DWORD PTR _saved_x, eax
	mov	DWORD PTR _saved_y, ecx

; 692  : }

	ret	0
_save_cur ENDP
_restore_cur PROC NEAR

; 698  : 	gotoxy (saved_x, saved_y);

	mov	ecx, DWORD PTR _saved_x
	mov	eax, DWORD PTR _video_num_columns
	cmp	ecx, eax
	ja	SHORT $L1295
	mov	eax, DWORD PTR _saved_y
	mov	edx, DWORD PTR _video_num_lines
	cmp	eax, edx
	jae	SHORT $L1295
	mov	edx, DWORD PTR _video_size_row
	mov	DWORD PTR _y, eax
	imul	edx, eax
	mov	eax, DWORD PTR _origin
	mov	DWORD PTR _x, ecx
	add	eax, edx
	lea	ecx, DWORD PTR [eax+ecx*2]
	mov	DWORD PTR _pos, ecx
$L1295:

; 699  : }

	ret	0
_restore_cur ENDP
_TEXT	ENDS
PUBLIC	_con_init
EXTRN	_idt:BYTE
EXTRN	_keyboard_interrupt:NEAR
_BSS	SEGMENT
_video_page DB	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG1009	DB	'????', 00H
	ORG $+3
$SG1018	DB	'EGAm', 00H
	ORG $+3
$SG1020	DB	'*MDA', 00H
	ORG $+3
$SG1024	DB	'EGAc', 00H
	ORG $+3
$SG1026	DB	'*CGA', 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1313 = -8
$T1320 = -1
$T1321 = -8
$T1327 = -8
$T1333 = -1
$T1334 = -8
$T1338 = -8
_a$ = -2
_con_init PROC NEAR

; 968  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8
	push	ebx

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// ��ʾ����ʾ�ַ�������

	xor	ebx, ebx
	mov	bx, WORD PTR ds:589830
	push	esi
	shr	ebx, 8
	mov	DWORD PTR _video_num_columns, ebx

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// ��ʾ����ʾ�ַ�������

	mov	DWORD PTR _video_num_lines, 25		; 00000019H
	lea	esi, DWORD PTR [ebx+ebx]
	push	edi
	mov	DWORD PTR _video_size_row, esi

; 976  : 	video_page = (unsigned char)ORIG_VIDEO_PAGE;	// ��ǰ��ʾҳ�档

	mov	al, BYTE PTR ds:589828
	mov	BYTE PTR _video_page, al

; 977  : 	video_erase_char = 0x0720;	// �����ַ�(0x20 ��ʾ�ַ��� 0x07 ������)��

	mov	WORD PTR _video_erase_char, 1824	; 00000720H

; 978  : 
; 979  : // ���ԭʼ��ʾģʽ����7�����ʾ�ǵ�ɫ��ʾ����
; 980  : 	if (ORIG_VIDEO_MODE == 7)	/* Is this a monochrome display? */

	cmp	BYTE PTR ds:589830, 7
	jne	SHORT $L1015

; 981  : 	{
; 982  : 		video_mem_start = 0xb0000;	// ���õ���ӳ���ڴ���ʼ��ַ��

	mov	edx, 720896				; 000b0000H

; 983  : 		video_port_reg = 0x3b4;	// ���õ��������Ĵ����˿ڡ�

	mov	WORD PTR _video_port_reg, 948		; 000003b4H
	mov	DWORD PTR _video_mem_start, edx

; 984  : 		video_port_val = 0x3b5;	// ���õ������ݼĴ����˿ڡ�

	mov	WORD PTR _video_port_val, 949		; 000003b5H

; 985  : // ����BIOS �ж�int 0x10 ����0x12 ��õ���ʾģʽ��Ϣ���ж���ʾ����ɫ��ʾ�����ǲ�ɫ��ʾ����
; 986  : // ���ʹ�������жϹ������õ���BX �Ĵ�������ֵ������0x10����˵����EGA ������˳�ʼ
; 987  : // ��ʾ����ΪEGA ��ɫ����ʹ��ӳ���ڴ�ĩ�˵�ַΪ0xb8000��������ʾ�������ַ���Ϊ'EGAm'��
; 988  : // ��ϵͳ��ʼ���ڼ���ʾ�������ַ�������ʾ����Ļ�����Ͻǡ�
; 989  : 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)

	mov	cl, BYTE PTR ds:589834
	mov	al, 16					; 00000010H
	cmp	cl, al
	je	SHORT $L1017

; 990  : 		{
; 991  : 			video_type = VIDEO_TYPE_EGAM;	// ������ʾ����(EGA ��ɫ)��

	mov	BYTE PTR _video_type, 32		; 00000020H

; 992  : 			video_mem_end = 0xb8000;	// ������ʾ�ڴ�ĩ�˵�ַ��

	mov	DWORD PTR _video_mem_end, 753664	; 000b8000H

; 993  : 			display_desc = "EGAm";	// ������ʾ�����ַ�����

	mov	ecx, OFFSET FLAT:$SG1018

; 994  : 		}
; 995  : // ���BX �Ĵ�����ֵ����0x10����˵���ǵ�ɫ��ʾ��MDA����������Ӧ������
; 996  : 		else

	jmp	SHORT $L1025
$L1017:

; 997  : 		{
; 998  : 			video_type = VIDEO_TYPE_MDA;	// ������ʾ����(MDA ��ɫ)��

	mov	BYTE PTR _video_type, al

; 999  : 			video_mem_end = 0xb2000;	// ������ʾ�ڴ�ĩ�˵�ַ��

	mov	DWORD PTR _video_mem_end, 729088	; 000b2000H

; 1000 : 			display_desc = "*MDA";	// ������ʾ�����ַ�����

	mov	ecx, OFFSET FLAT:$SG1020

; 1001 : 		}
; 1002 : 	}
; 1003 : // �����ʾģʽ��Ϊ7����Ϊ��ɫģʽ����ʱ���õ���ʾ�ڴ���ʼ��ַΪ0xb800����ʾ���������Ĵ�
; 1004 : // ���˿ڵ�ַΪ0x3d4�����ݼĴ����˿ڵ�ַΪ0x3d5��
; 1005 : 	else				/* If not, it is color. */

	jmp	SHORT $L1025
$L1015:

; 1006 : 	{
; 1007 : 		video_mem_start = 0xb8000;	// ��ʾ�ڴ���ʼ��ַ��

	mov	edx, 753664				; 000b8000H

; 1008 : 		video_port_reg = 0x3d4;	// ���ò�ɫ��ʾ�����Ĵ����˿ڡ�

	mov	WORD PTR _video_port_reg, 980		; 000003d4H
	mov	DWORD PTR _video_mem_start, edx

; 1009 : 		video_port_val = 0x3d5;	// ���ò�ɫ��ʾ���ݼĴ����˿ڡ�

	mov	WORD PTR _video_port_val, 981		; 000003d5H

; 1010 : // ���ж���ʾ��������BX ������0x10����˵����EGA ��ʾ����
; 1011 : 		if ((ORIG_VIDEO_EGA_BX & 0xff) != 0x10)

	cmp	BYTE PTR ds:589834, 16			; 00000010H
	je	SHORT $L1023

; 1012 : 		{
; 1013 : 			video_type = VIDEO_TYPE_EGAC;	// ������ʾ����(EGA ��ɫ)��

	mov	BYTE PTR _video_type, 33		; 00000021H

; 1014 : 			video_mem_end = 0xbc000;	// ������ʾ�ڴ�ĩ�˵�ַ��

	mov	DWORD PTR _video_mem_end, 770048	; 000bc000H

; 1015 : 			display_desc = "EGAc";	// ������ʾ�����ַ�����

	mov	ecx, OFFSET FLAT:$SG1024

; 1016 : 		}
; 1017 : // ���BX �Ĵ�����ֵ����0x10����˵����CGA ��ʾ������������Ӧ������
; 1018 : 		else

	jmp	SHORT $L1025
$L1023:

; 1019 : 		{
; 1020 : 			video_type = VIDEO_TYPE_CGA;	// ������ʾ����(CGA)��

	mov	BYTE PTR _video_type, 17		; 00000011H

; 1021 : 			video_mem_end = 0xba000;	// ������ʾ�ڴ�ĩ�˵�ַ��

	mov	DWORD PTR _video_mem_end, 761856	; 000ba000H

; 1022 : 			display_desc = "*CGA";	// ������ʾ�����ַ�����

	mov	ecx, OFFSET FLAT:$SG1026
$L1025:

; 1023 : 		}
; 1024 : 	}
; 1025 : 
; 1026 : /* Let the user known what kind of display driver we are using */
; 1027 : /* ���û�֪����������ʹ����һ����ʾ�������� */
; 1028 : 
; 1029 : // ����Ļ�����Ͻ���ʾ��ʾ�����ַ��������õķ�����ֱ�ӽ��ַ���д����ʾ�ڴ����Ӧλ�ô���
; 1030 : // ���Ƚ���ʾָ��display_ptr ָ����Ļ��һ���Ҷ˲�4 ���ַ���(ÿ���ַ���2 ���ֽڣ���˼�8)��
; 1031 : 	display_ptr = ((char *) video_mem_start) + video_size_row - 8;
; 1032 : // Ȼ��ѭ�������ַ����е��ַ�������ÿ����һ���ַ����տ�һ�������ֽڡ�
; 1033 : 	while (*display_desc)

	mov	al, BYTE PTR [ecx]
	lea	edi, DWORD PTR [edx+esi-8]
	test	al, al
	je	SHORT $L1030
$L1029:

; 1034 : 	{
; 1035 : 		*display_ptr++ = *display_desc++;	// �����ַ���

	inc	ecx
	mov	BYTE PTR [edi], al

; 1036 : 		display_ptr++;		// �տ������ֽ�λ�á�

	add	edi, 2
	mov	al, BYTE PTR [ecx]
	test	al, al
	jne	SHORT $L1029
$L1030:

; 1037 : 	}
; 1038 : 
; 1039 : /* ��ʼ�����ڹ����ı���(��Ҫ����EGA/VGA) */
; 1040 : 
; 1041 : 	origin = video_mem_start;	// ������ʼ��ʾ�ڴ��ַ��
; 1042 : 	scr_end = video_mem_start + video_num_lines * video_size_row;	// ���������ڴ��ַ��

	lea	eax, DWORD PTR [esi+esi*4]
	mov	DWORD PTR _origin, edx

; 1043 : 	top = 0;			// ��кš�

	mov	DWORD PTR _top, 0

; 1044 : 	bottom = video_num_lines;	// ����кš�

	mov	DWORD PTR _bottom, 25			; 00000019H
	lea	ecx, DWORD PTR [edx+eax*4]
	add	eax, ecx

; 1045 : 
; 1046 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	xor	ecx, ecx
	mov	DWORD PTR _scr_end, eax
	mov	cl, BYTE PTR ds:589825
	xor	eax, eax
	mov	al, BYTE PTR ds:589824
	cmp	eax, ebx
	ja	SHORT $L1301
	cmp	ecx, 25					; 00000019H
	jae	SHORT $L1301
	imul	esi, ecx
	add	edx, esi
	mov	DWORD PTR _x, eax
	mov	DWORD PTR _y, ecx
	lea	edx, DWORD PTR [edx+eax*2]
	mov	DWORD PTR _pos, edx
$L1301:

; 1047 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	mov	ecx, OFFSET FLAT:_keyboard_interrupt
	mov	eax, OFFSET FLAT:_keyboard_interrupt
	and	ecx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	ecx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+268, ecx

; 1048 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// ȡ��8259A �жԼ����жϵ����Σ�����IRQ1��

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _idt+264, eax
	mov	DWORD PTR $T1313[ebp], ecx

; 971  : 	char *display_ptr;

	mov	dx, WORD PTR $T1313[ebp]

; 972  : 

	in	al, dx

; 974  : 	video_size_row = video_num_columns * 2;	// ÿ����ʹ���ֽ�����

	jmp	SHORT $l1$1311
$l1$1311:

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// ��ʾ����ʾ�ַ�������

	jmp	SHORT $l2$1312
$l2$1312:

; 1048 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// ȡ��8259A �жԼ����жϵ����Σ�����IRQ1��

	and	al, 253					; 000000fdH
	mov	DWORD PTR $T1321[ebp], ecx
	mov	BYTE PTR $T1320[ebp], al

; 969  : 	register unsigned char a;

	mov	al, BYTE PTR $T1320[ebp]

; 970  : 	char *display_desc = "????";

	mov	dx, WORD PTR $T1321[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 972  : 

	jmp	SHORT $l1$1318
$l1$1318:

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// ��ʾ����ʾ�ַ�������

	jmp	SHORT $l2$1319
$l2$1319:

; 1049 : 	a = inb_p (0x61);		// �ӳٶ�ȡ���̶˿�0x61(8255A �˿�PB)��

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1327[ebp], ecx

; 971  : 	char *display_ptr;

	mov	dx, WORD PTR $T1327[ebp]

; 972  : 

	in	al, dx

; 974  : 	video_size_row = video_num_columns * 2;	// ÿ����ʹ���ֽ�����

	jmp	SHORT $l1$1325
$l1$1325:

; 975  : 	video_num_lines = ORIG_VIDEO_LINES;	// ��ʾ����ʾ�ַ�������

	jmp	SHORT $l2$1326
$l2$1326:

; 1049 : 	a = inb_p (0x61);		// �ӳٶ�ȡ���̶˿�0x61(8255A �˿�PB)��

	mov	BYTE PTR _a$[ebp], al

; 1050 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// ���ý�ֹ���̹���(λ7 ��λ)��

	or	al, 128					; 00000080H
	mov	DWORD PTR $T1334[ebp], ecx
	mov	BYTE PTR $T1333[ebp], al

; 969  : 	register unsigned char a;

	mov	al, BYTE PTR $T1333[ebp]

; 970  : 	char *display_desc = "????";

	mov	dx, WORD PTR $T1334[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 972  : 

	jmp	SHORT $l1$1331
$l1$1331:

; 973  : 	video_num_columns = ORIG_VIDEO_COLS;	// ��ʾ����ʾ�ַ�������

	jmp	SHORT $l2$1332
$l2$1332:

; 1051 : 	outb (a, 0x61);		// ��������̹��������Ը�λ���̲�����

	mov	DWORD PTR $T1338[ebp], ecx

; 969  : 	register unsigned char a;

	mov	dx, WORD PTR $T1338[ebp]

; 970  : 	char *display_desc = "????";

	mov	al, BYTE PTR _a$[ebp]

; 971  : 	char *display_ptr;

	out	dx, al

; 1051 : 	outb (a, 0x61);		// ��������̹��������Ը�λ���̲�����

	pop	edi
	pop	esi
	pop	ebx

; 1052 : }

	mov	esp, ebp
	pop	ebp
	ret	0
_con_init ENDP
_TEXT	ENDS
PUBLIC	_sysbeepstop
_TEXT	SEGMENT
$T1347 = -8
$T1352 = -1
$T1353 = -8
_sysbeepstop PROC NEAR

; 1060 : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 1062 : 	outb ((unsigned char)(inb_p (0x61) & 0xFC), 0x61);

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1347[ebp], ecx

; 1063 : }

	mov	dx, WORD PTR $T1347[ebp]
; File ..\include\asm/io.h

; 82   : {

	in	al, dx

; 83   : //	volatile unsigned char _v; 
; 84   : 	_asm { 

	jmp	SHORT $l1$1345
$l1$1345:

; 85   : 		mov dx,port 

	jmp	SHORT $l2$1346
$l2$1346:
; File ..\kernel\chr_drv\console.c

; 1062 : // Ȼ��ѭ�������ַ����е��ַ�������ÿ����һ���ַ����տ�һ�������ֽڡ�

	and	al, 252					; 000000fcH
	mov	DWORD PTR $T1353[ebp], ecx
	mov	BYTE PTR $T1352[ebp], al

; 1061 : 	display_ptr = ((char *) video_mem_start) + video_size_row - 8;

	mov	dx, WORD PTR $T1353[ebp]

; 1062 : // Ȼ��ѭ�������ַ����е��ַ�������ÿ����һ���ַ����տ�һ�������ֽڡ�

	mov	al, BYTE PTR $T1352[ebp]

; 1063 : 	while (*display_desc)

	out	dx, al
	mov	esp, ebp
	pop	ebp
	ret	0
_sysbeepstop ENDP
$T1360 = -8
$T1367 = -1
$T1368 = -8
$T1374 = -1
$T1375 = -8
$T1381 = -1
$T1382 = -8
$T1386 = -1
$T1387 = -8
_sysbeep PROC NEAR

; 1073 : 	top = 0;			// ��кš�

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 1075 : 

	mov	ecx, 97					; 00000061H
	mov	DWORD PTR $T1360[ebp], ecx

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	mov	dx, WORD PTR $T1360[ebp]

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	in	al, dx

; 1079 : 	a = inb_p (0x61);		// �ӳٶ�ȡ���̶˿�0x61(8255A �˿�PB)��

	jmp	SHORT $l1$1358
$l1$1358:

; 1080 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// ���ý�ֹ���̹���(λ7 ��λ)��

	jmp	SHORT $l2$1359
$l2$1359:

; 1075 : 

	or	al, 3
	mov	DWORD PTR $T1368[ebp], ecx
	mov	BYTE PTR $T1367[ebp], al

; 1074 : 	bottom = video_num_lines;	// ����кš�

	mov	al, BYTE PTR $T1367[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1368[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	jmp	SHORT $l1$1365
$l1$1365:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// ȡ��8259A �жԼ����жϵ����Σ�����IRQ1��

	jmp	SHORT $l2$1366
$l2$1366:

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	mov	DWORD PTR $T1375[ebp], 67		; 00000043H
	mov	BYTE PTR $T1374[ebp], 182		; 000000b6H

; 1074 : 	bottom = video_num_lines;	// ����кš�

	mov	al, BYTE PTR $T1374[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1375[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	jmp	SHORT $l1$1372
$l1$1372:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// ȡ��8259A �жԼ����жϵ����Σ�����IRQ1��

	jmp	SHORT $l2$1373
$l2$1373:

; 1079 : 	a = inb_p (0x61);		// �ӳٶ�ȡ���̶˿�0x61(8255A �˿�PB)��

	mov	ecx, 66					; 00000042H
	mov	BYTE PTR $T1381[ebp], 55		; 00000037H
	mov	DWORD PTR $T1382[ebp], ecx

; 1074 : 	bottom = video_num_lines;	// ����кš�

	mov	al, BYTE PTR $T1381[ebp]

; 1075 : 

	mov	dx, WORD PTR $T1382[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	out	dx, al

; 1077 : 	set_trap_gate (0x21, &keyboard_interrupt);	// ���ü����ж������š�

	jmp	SHORT $l1$1379
$l1$1379:

; 1078 : 	outb_p ((unsigned char)(inb_p (0x21) & 0xfd), 0x21);	// ȡ��8259A �жԼ����жϵ����Σ�����IRQ1��

	jmp	SHORT $l2$1380
$l2$1380:

; 1080 : 	outb_p ((unsigned char)(a | 0x80), 0x61);	// ���ý�ֹ���̹���(λ7 ��λ)��

	mov	DWORD PTR $T1387[ebp], ecx
	mov	BYTE PTR $T1386[ebp], 6

; 1074 : 	bottom = video_num_lines;	// ����кš�

	mov	dx, WORD PTR $T1387[ebp]

; 1075 : 

	mov	al, BYTE PTR $T1386[ebp]

; 1076 : 	gotoxy (ORIG_X, ORIG_Y);	// ��ʼ�����λ��x,y �Ͷ�Ӧ���ڴ�λ��pos��

	out	dx, al

; 1081 : 	outb (a, 0x61);		// ��������̹��������Ը�λ���̲�����
; 1082 : }

	mov	DWORD PTR _beepcount, 12		; 0000000cH

; 1083 : 

	mov	esp, ebp
	pop	ebp
	ret	0
_sysbeep ENDP
_TEXT	ENDS
END
