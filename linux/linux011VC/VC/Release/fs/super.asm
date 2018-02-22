	TITLE	..\fs\super.c
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
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _set_bit
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_super_block
_BSS	SEGMENT
_super_block DB	0360H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
COMM	_ROOT_DEV:DWORD
_DATA	ENDS
PUBLIC	_set_bit
;	COMDAT _set_bit
_TEXT	SEGMENT
_bitnr$ = 8
_addr$ = 12
_set_bit PROC NEAR					; COMDAT

; 32   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 33   : //	register int __res;
; 34   : 	_asm{
; 35   : 		xor eax,eax

	xor	eax, eax

; 36   : 		mov ebx,bitnr

	mov	ebx, DWORD PTR _bitnr$[ebp]

; 37   : 		mov edx,addr

	mov	edx, DWORD PTR _addr$[ebp]

; 38   : 		bt [edx],ebx

	bt	DWORD PTR [edx], ebx

; 39   : 		setb al

	setb	al
	pop	ebx

; 40   : //		mov __res,eax
; 41   : 	}
; 42   : //	return __res;
; 43   : }

	pop	ebp
	ret	0
_set_bit ENDP
_TEXT	ENDS
PUBLIC	_get_super
_TEXT	SEGMENT
_dev$ = 8
_get_super PROC NEAR

; 84   : {

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 85   : 	struct super_block *s;
; 86   : 
; 87   : // ���û��ָ���豸���򷵻ؿ�ָ�롣
; 88   : 	if (!dev)

	mov	edi, DWORD PTR _dev$[ebp]
	test	edi, edi

; 89   : 		return NULL;

	je	SHORT $L647
$L795:

; 90   : // s ָ�򳬼������鿪ʼ���������������������飬Ѱ��ָ���豸�ĳ����顣
; 91   : 	s = 0 + super_block;

	mov	esi, OFFSET FLAT:_super_block
$L646:

; 92   : 	while (s < NR_SUPER + super_block)
; 93   : // �����ǰ��������ָ���豸�ĳ����飬�����ȵȴ��ó�������������Ѿ����������������Ļ�����
; 94   : // �ڵȴ��ڼ䣬�ó������п��ܱ������豸ʹ�ã���˴�ʱ�����ж�һ���Ƿ���ָ���豸�ĳ����飬
; 95   : // ������򷵻ظó������ָ�롣��������¶Գ���������������һ�飬���s ����ָ�򳬼�������
; 96   : // ��ʼ����
; 97   : 	if (s->s_dev == dev)

	xor	eax, eax
	mov	ax, WORD PTR [esi+84]
	cmp	eax, edi
	jne	SHORT $L648

; 98   : 	{
; 99   : 		wait_on_super (s);

	push	esi
	call	_wait_on_super

; 100  : 		if (s->s_dev == dev)

	xor	ecx, ecx
	add	esp, 4
	mov	cx, WORD PTR [esi+84]
	cmp	ecx, edi
	je	SHORT $L794

; 102  : 		s = 0 + super_block;
; 103  : // �����ǰ������ǣ�������һ����û���ҵ�ָ���ĳ����飬�򷵻ؿ�ָ�롣
; 104  : 	}
; 105  : 	else

	jmp	SHORT $L795
$L648:

; 106  : 		s++;

	add	esi, 108				; 0000006cH
	cmp	esi, OFFSET FLAT:_super_block+864
	jb	SHORT $L646
$L647:
	pop	edi

; 107  : 	return NULL;

	xor	eax, eax
	pop	esi

; 108  : }

	pop	ebp
	ret	0
$L794:

; 101  : 			return s;

	mov	eax, esi
	pop	edi
	pop	esi

; 108  : }

	pop	ebp
	ret	0
_get_super ENDP
_TEXT	ENDS
EXTRN	_sleep_on:NEAR
_TEXT	SEGMENT
_sb$ = 8
_wait_on_super PROC NEAR

; 74   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 75   : 	cli ();			// ���жϡ�

	cli

; 76   : 	while (sb->s_lock)		// ����������Ѿ���������˯�ߵȴ���

	mov	esi, DWORD PTR _sb$[ebp]
	mov	al, BYTE PTR [esi+104]
	test	al, al
	je	SHORT $L639
	push	edi

; 77   : 		sleep_on (&(sb->s_wait));

	lea	edi, DWORD PTR [esi+100]
$L638:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+104]
	add	esp, 4
	test	al, al
	jne	SHORT $L638
	pop	edi
$L639:

; 78   : 	sti ();			// ���жϡ�

	sti
	pop	esi

; 79   : }

	pop	ebp
	ret	0
_wait_on_super ENDP
_TEXT	ENDS
PUBLIC	_put_super
EXTRN	_brelse:NEAR
EXTRN	_printk:NEAR
_DATA	SEGMENT
$SG658	DB	'root diskette changed: prepare for armageddon', 0aH, 0dH
	DB	00H
$SG661	DB	'Mounted disk changed - tssk, tssk', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_put_super PROC NEAR

; 116  : {

	push	ebp
	mov	ebp, esp

; 117  : 	struct super_block *sb;
; 118  : //  struct m_inode *inode;
; 119  : 	int i;
; 120  : 
; 121  : // ���ָ���豸�Ǹ��ļ�ϵͳ�豸������ʾ������Ϣ����ϵͳ�̸ı��ˣ�׼��������ս�ɡ��������ء�
; 122  : 	if (dev == ROOT_DEV)

	mov	eax, DWORD PTR _dev$[ebp]
	mov	ecx, DWORD PTR _ROOT_DEV
	cmp	eax, ecx
	push	esi
	jne	SHORT $L657

; 123  : 	{
; 124  : 		printk ("root diskette changed: prepare for armageddon\n\r");

	push	OFFSET FLAT:$SG658
	call	_printk
	add	esp, 4
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
$L657:

; 125  : 		return;
; 126  : 	}
; 127  : // ����Ҳ���ָ���豸�ĳ����飬�򷵻ء�
; 128  : 	if (!(sb = get_super (dev)))

	push	eax
	call	_get_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	je	SHORT $L654

; 129  : 		return;
; 130  : // ����ó�����ָ�����ļ�ϵͳi �ڵ��ϰ�װ���������ļ�ϵͳ������ʾ������Ϣ�����ء�
; 131  : 	if (sb->s_imount)

	mov	eax, DWORD PTR [esi+92]
	test	eax, eax
	je	SHORT $L660

; 132  : 	{
; 133  : 		printk ("Mounted disk changed - tssk, tssk\n\r");

	push	OFFSET FLAT:$SG661
	call	_printk
	add	esp, 4
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
$L660:
	push	ebx
	push	edi

; 134  : 		return;
; 135  : 	}
; 136  : // �ҵ�ָ���豸�ĳ���������������ó����飬Ȼ���øó������Ӧ���豸���ֶ�Ϊ0��Ҳ������
; 137  : // �����ó����顣
; 138  : 	lock_super (sb);

	push	esi
	call	_lock_super
	add	esp, 4

; 139  : 	sb->s_dev = 0;

	mov	WORD PTR [esi+84], 0
	lea	edi, DWORD PTR [esi+20]
	mov	ebx, 8
$L662:

; 140  : // Ȼ���ͷŸ��豸i �ڵ�λͼ���߼���λͼ�ڻ���������ռ�õĻ���顣
; 141  : 	for (i = 0; i < I_MAP_SLOTS; i++)
; 142  : 		brelse (sb->s_imap[i]);

	mov	eax, DWORD PTR [edi]
	push	eax
	call	_brelse
	add	esp, 4
	add	edi, 4
	dec	ebx
	jne	SHORT $L662

; 143  : 	for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	edi, DWORD PTR [esi+52]
	mov	ebx, 8
$L665:

; 144  : 		brelse (sb->s_zmap[i]);

	mov	ecx, DWORD PTR [edi]
	push	ecx
	call	_brelse
	add	esp, 4
	add	edi, 4
	dec	ebx
	jne	SHORT $L665

; 145  : // ���Ըó���������������ء�
; 146  : 	free_super (sb);

	push	esi
	call	_free_super
	add	esp, 4
	pop	edi
	pop	ebx
$L654:
	pop	esi

; 147  : 	return;
; 148  : }

	pop	ebp
	ret	0
_put_super ENDP
_sb$ = 8
_lock_super PROC NEAR

; 53   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 54   : 	cli ();			// ���жϡ�

	cli

; 55   : 	while (sb->s_lock)		// ����ó������Ѿ���������˯�ߵȴ���

	mov	esi, DWORD PTR _sb$[ebp]
	mov	al, BYTE PTR [esi+104]
	test	al, al
	je	SHORT $L628
	push	edi

; 56   : 		sleep_on (&(sb->s_wait));

	lea	edi, DWORD PTR [esi+100]
$L627:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+104]
	add	esp, 4
	test	al, al
	jne	SHORT $L627
	pop	edi
$L628:

; 57   : 	sb->s_lock = 1;		// ���ó������������������־����

	mov	BYTE PTR [esi+104], 1

; 58   : 	sti ();			// ���жϡ�

	sti

; 57   : 	sb->s_lock = 1;		// ���ó������������������־����

	pop	esi

; 59   : }

	pop	ebp
	ret	0
_lock_super ENDP
_TEXT	ENDS
EXTRN	_wake_up:NEAR
_TEXT	SEGMENT
_sb$ = 8
_free_super PROC NEAR

; 64   : {

	push	ebp
	mov	ebp, esp

; 65   : 	cli ();			// ���жϡ�

	cli

; 66   : 	sb->s_lock = 0;		// ��λ������־��

	mov	eax, DWORD PTR _sb$[ebp]
	mov	BYTE PTR [eax+104], 0

; 67   : 	wake_up (&(sb->s_wait));	// ���ѵȴ��ó�����Ľ��̡�

	add	eax, 100				; 00000064H
	push	eax
	call	_wake_up
	add	esp, 4

; 68   : 	sti ();			// ���жϡ�

	sti

; 69   : }

	pop	ebp
	ret	0
_free_super ENDP
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

	je	SHORT $l1$500

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$501, ax

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
$lcs$501:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$500

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$500:

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
PUBLIC	_sys_umount
EXTRN	_inode_table:BYTE
EXTRN	_namei:NEAR
EXTRN	_iput:NEAR
EXTRN	_sync_dev:NEAR
_DATA	SEGMENT
$SG723	DB	'Mounted inode has i_mount=0', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev_name$ = 8
_sys_umount PROC NEAR

; 249  : {

	push	ebp
	mov	ebp, esp

; 250  : 	struct m_inode *inode;
; 251  : 	struct super_block *sb;
; 252  : 	int dev;
; 253  : 
; 254  : // ���ȸ����豸�ļ����ҵ���Ӧ��i �ڵ㣬��ȡ���е��豸�š�
; 255  : 	if (!(inode = namei (dev_name)))

	mov	eax, DWORD PTR _dev_name$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax

; 256  : 		return -ENOENT;

	je	$L721

; 257  : 	dev = inode->i_zone[0];
; 258  : // ������ǿ��豸�ļ������ͷŸ������i �ڵ�dev_i�����س����롣
; 259  : 	if (!S_ISBLK (inode->i_mode))

	mov	cx, WORD PTR [eax]
	xor	esi, esi
	mov	si, WORD PTR [eax+14]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 24576				; 00006000H

; 260  : 	{
; 261  : 		iput (inode);

	push	eax
	je	SHORT $L718
	call	_iput
	add	esp, 4

; 262  : 		return -ENOTBLK;

	mov	eax, -15				; fffffff1H
	pop	edi
	pop	esi
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L718:

; 263  : 	}
; 264  : // �ͷ��豸�ļ�����i �ڵ㡣
; 265  : 	iput (inode);

	call	_iput

; 266  : // ����豸�Ǹ��ļ�ϵͳ�����ܱ�ж�أ����س���š�
; 267  : 	if (dev == ROOT_DEV)

	mov	eax, DWORD PTR _ROOT_DEV
	add	esp, 4
	cmp	esi, eax
	jne	SHORT $L719
$L817:
	pop	edi
	pop	esi

; 268  : 		return -EBUSY;

	mov	eax, -16				; fffffff0H
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L719:

; 269  : // ���ȡ�豸�ĳ�����ʧ�ܣ����߸��豸�ļ�ϵͳû�а�װ�����򷵻س����롣
; 270  : 	if (!(sb = get_super (dev)) || !(sb->s_imount))

	push	esi
	call	_get_super
	mov	edi, eax
	add	esp, 4
	test	edi, edi
	je	SHORT $L721
	mov	ebx, DWORD PTR [edi+92]
	test	ebx, ebx
	je	SHORT $L721

; 272  : // �����������ָ���ı���װ����i �ڵ�û����λ�䰲װ��־������ʾ������Ϣ��
; 273  : 	if (!sb->s_imount->i_mount)

	mov	al, BYTE PTR [ebx+53]
	test	al, al
	jne	SHORT $L722

; 274  : 		printk ("Mounted inode has i_mount=0\n");

	push	OFFSET FLAT:$SG723
	call	_printk
	add	esp, 4
$L722:

; 275  : // ����i �ڵ�����Ƿ��н�����ʹ�ø��豸�ϵ��ļ���������򷵻�æ�����롣
; 276  : 	for (inode = inode_table + 0; inode < inode_table + NR_INODE; inode++)

	mov	eax, OFFSET FLAT:_inode_table+48
$L724:

; 277  : 		if (inode->i_dev == dev && inode->i_count)

	xor	edx, edx
	mov	dx, WORD PTR [eax-4]
	cmp	edx, esi
	jne	SHORT $L725
	cmp	WORD PTR [eax], 0
	jne	SHORT $L817
$L725:

; 275  : // ����i �ڵ�����Ƿ��н�����ʹ�ø��豸�ϵ��ļ���������򷵻�æ�����롣
; 276  : 	for (inode = inode_table + 0; inode < inode_table + NR_INODE; inode++)

	add	eax, 56					; 00000038H
	lea	ecx, DWORD PTR [eax-48]
	cmp	ecx, OFFSET FLAT:_inode_table+1792
	jb	SHORT $L724

; 278  : 			return -EBUSY;
; 279  : // ��λ����װ����i �ڵ�İ�װ��־���ͷŸ�i �ڵ㡣
; 280  : 	sb->s_imount->i_mount = 0;
; 281  : 	iput (sb->s_imount);

	push	ebx
	mov	BYTE PTR [ebx+53], 0
	call	_iput

; 282  : // �ó������б���װi �ڵ��ֶ�Ϊ�գ����ͷ��豸�ļ�ϵͳ�ĸ�i �ڵ㣬�ó������б���װϵͳ
; 283  : // ��i �ڵ�ָ��Ϊ�ա�
; 284  : 	sb->s_imount = NULL;
; 285  : 	iput (sb->s_isup);

	mov	edx, DWORD PTR [edi+88]
	xor	ebx, ebx
	push	edx
	mov	DWORD PTR [edi+92], ebx
	call	_iput

; 286  : 	sb->s_isup = NULL;
; 287  : // �ͷŸ��豸�ĳ������Լ�λͼռ�õĻ���飬���Ը��豸ִ�и��ٻ������豸�����ݵ�ͬ��������
; 288  : 	put_super (dev);

	push	esi
	mov	DWORD PTR [edi+88], ebx
	call	_put_super

; 289  : 	sync_dev (dev);

	push	esi
	call	_sync_dev
	add	esp, 16					; 00000010H

; 290  : 	return 0;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
$L721:
	pop	edi
	pop	esi

; 271  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 291  : }

	pop	ebp
	ret	0
_sys_umount ENDP
_TEXT	ENDS
PUBLIC	_sys_mount
_TEXT	SEGMENT
_dev_name$ = 8
_dir_name$ = 12
_sys_mount PROC NEAR

; 298  : {

	push	ebp
	mov	ebp, esp

; 299  : 	struct m_inode *dev_i, *dir_i;
; 300  : 	struct super_block *sb;
; 301  : 	int dev;
; 302  : 
; 303  : // ���ȸ����豸�ļ����ҵ���Ӧ��i �ڵ㣬��ȡ���е��豸�š�
; 304  : // ���ڿ������豸�ļ����豸����i �ڵ��i_zone[0]�С�
; 305  : 	if (!(dev_i = namei (dev_name)))

	mov	eax, DWORD PTR _dev_name$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	call	_namei
	add	esp, 4
	test	eax, eax
	jne	SHORT $L740
	pop	edi
	pop	esi

; 306  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L740:

; 307  : 	dev = dev_i->i_zone[0];
; 308  : // ������ǿ��豸�ļ������ͷŸ�ȡ�õ�i �ڵ�dev_i�����س����롣
; 309  : 	if (!S_ISBLK (dev_i->i_mode))

	mov	cx, WORD PTR [eax]
	xor	edi, edi
	mov	di, WORD PTR [eax+14]
	and	ecx, 61440				; 0000f000H
	cmp	ecx, 24576				; 00006000H

; 310  : 	{
; 311  : 		iput (dev_i);

	push	eax
	je	SHORT $L741
	call	_iput
	add	esp, 4

; 312  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L741:

; 313  : 	}
; 314  : // �ͷŸ��豸�ļ���i �ڵ�dev_i��
; 315  : 	iput (dev_i);

	call	_iput

; 316  : // ���ݸ�����Ŀ¼�ļ����ҵ���Ӧ��i �ڵ�dir_i��
; 317  : 	if (!(dir_i = namei (dir_name)))

	mov	edx, DWORD PTR _dir_name$[ebp]
	push	edx
	call	_namei
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L742
	pop	edi
	pop	esi

; 318  : 		return -ENOENT;

	mov	eax, -2					; fffffffeH
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L742:

; 319  : // �����i �ڵ�����ü�����Ϊ1�������������ã������߸�i �ڵ�Ľڵ���Ǹ��ļ�ϵͳ�Ľڵ�
; 320  : // ��1�����ͷŸ�i �ڵ㣬���س����롣
; 321  : 	if (dir_i->i_count != 1 || dir_i->i_num == ROOT_INO)

	mov	ebx, 1
	cmp	WORD PTR [esi+48], bx
	jne	SHORT $L744
	cmp	WORD PTR [esi+46], bx
	je	SHORT $L744

; 325  : 	}
; 326  : // ����ýڵ㲻��һ��Ŀ¼�ļ��ڵ㣬��Ҳ�ͷŸ�i �ڵ㣬���س����롣
; 327  : 	if (!S_ISDIR (dir_i->i_mode))

	mov	ax, WORD PTR [esi]
	and	eax, 61440				; 0000f000H
	cmp	eax, 16384				; 00004000H
	je	SHORT $L745

; 328  : 	{
; 329  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 330  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L745:

; 331  : 	}
; 332  : // ��ȡ����װ�ļ�ϵͳ�ĳ����飬���ʧ����Ҳ�ͷŸ�i �ڵ㣬���س����롣
; 333  : 	if (!(sb = read_super (dev)))

	push	edi
	call	_read_super
	add	esp, 4
	test	eax, eax

; 334  : 	{
; 335  : 		iput (dir_i);
; 336  : 		return -EBUSY;

	je	SHORT $L744

; 337  : 	}
; 338  : // �����Ҫ����װ���ļ�ϵͳ�Ѿ���װ�������ط������ͷŸ�i �ڵ㣬���س����롣
; 339  : 	if (sb->s_imount)

	mov	ecx, DWORD PTR [eax+92]
	test	ecx, ecx

; 340  : 	{
; 341  : 		iput (dir_i);
; 342  : 		return -EBUSY;

	jne	SHORT $L744

; 343  : 	}
; 344  : // �����Ҫ��װ����i �ڵ��Ѿ���װ���ļ�ϵͳ(��װ��־�Ѿ���λ)�����ͷŸ�i �ڵ㣬���س����롣
; 345  : 	if (dir_i->i_mount)

	mov	cl, BYTE PTR [esi+53]
	test	cl, cl
	je	SHORT $L748

; 346  : 	{
; 347  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 348  : 		return -EPERM;

	or	eax, -1
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L748:

; 349  : 	}
; 350  : // ����װ�ļ�ϵͳ������ġ�����װ��i �ڵ㡱�ֶ�ָ��װ����Ŀ¼����i �ڵ㡣
; 351  : 	sb->s_imount = dir_i;

	mov	DWORD PTR [eax+92], esi

; 352  : // ���ð�װλ��i �ڵ�İ�װ��־�ͽڵ����޸ı�־��/* ע�⣡����û��iput(dir_i) */
; 353  : 	dir_i->i_mount = 1;		/* �⽫��umount �ڲ��� */

	mov	BYTE PTR [esi+53], bl

; 354  : 	dir_i->i_dirt = 1;		/* NOTE! we don't iput(dir_i) */

	mov	BYTE PTR [esi+51], bl
	pop	edi
	pop	esi

; 355  : 	return 0;			/* we do that in umount */

	xor	eax, eax
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
$L744:

; 322  : 	{
; 323  : 		iput (dir_i);

	push	esi
	call	_iput
	add	esp, 4

; 324  : 		return -EBUSY;

	mov	eax, -16				; fffffff0H
	pop	edi
	pop	esi
	pop	ebx

; 356  : }

	pop	ebp
	ret	0
_sys_mount ENDP
_TEXT	ENDS
EXTRN	_check_disk_change:NEAR
EXTRN	_bread:NEAR
_TEXT	SEGMENT
_dev$ = 8
_i$ = -4
_read_super PROC NEAR

; 154  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	ebx
	push	esi

; 155  : 	struct super_block *s;
; 156  : 	struct buffer_head *bh;
; 157  : 	int i, block;
; 158  : 
; 159  : // ���û��ָ���豸���򷵻ؿ�ָ�롣
; 160  : 	if (!dev)

	mov	esi, DWORD PTR _dev$[ebp]
	push	edi
	xor	edi, edi
	cmp	esi, edi

; 161  : 		return NULL;

	je	$L843

; 162  : // ���ȼ����豸�Ƿ�ɸ�������Ƭ��Ҳ���Ƿ��������豸��������������̣�����ٻ������йظ�
; 163  : // �豸�����л�����ʧЧ����Ҫ����ʧЧ�����ͷ�ԭ�����ص��ļ�ϵͳ����
; 164  : 	check_disk_change (dev);

	push	esi
	call	_check_disk_change

; 165  : // ������豸�ĳ������Ѿ��ڸ��ٻ����У���ֱ�ӷ��ظó������ָ�롣
; 166  : 	if (s = get_super (dev))

	push	esi
	call	_get_super
	add	esp, 8
	cmp	eax, edi

; 167  : 		return s;

	jne	$L671

; 168  : // ���������ڳ������������ҳ�һ������(Ҳ����s_dev=0 ����)����������Ѿ�ռ���򷵻ؿ�ָ�롣
; 169  : 	for (s = 0 + super_block;; s++)

	mov	ebx, OFFSET FLAT:_super_block
$L678:

; 170  : 	{
; 171  : 		if (s >= NR_SUPER + super_block)
; 172  : 			return NULL;
; 173  : 		if (!s->s_dev)

	cmp	WORD PTR [ebx+84], di
	je	SHORT $L830
	add	ebx, 108				; 0000006cH
	cmp	ebx, OFFSET FLAT:_super_block+864
	jb	SHORT $L678
	pop	edi
	pop	esi

; 233  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L830:

; 174  : 			break;
; 175  : 	}
; 176  : // �ҵ����������󣬾ͽ��ó���������ָ���豸���Ըó�������ڴ�����в��ֳ�ʼ����
; 177  : 	s->s_dev = dev;

	mov	WORD PTR [ebx+84], si

; 178  : 	s->s_isup = NULL;

	mov	DWORD PTR [ebx+88], edi

; 179  : 	s->s_imount = NULL;

	mov	DWORD PTR [ebx+92], edi

; 180  : 	s->s_time = 0;

	mov	DWORD PTR [ebx+96], edi

; 181  : 	s->s_rd_only = 0;

	mov	BYTE PTR [ebx+105], 0

; 182  : 	s->s_dirt = 0;
; 183  : // Ȼ�������ó����飬�����豸�϶�ȡ��������Ϣ��bh ָ��Ļ������С���������������ʧ�ܣ�
; 184  : // ���ͷ�����ѡ���ĳ����������е��������������ؿ�ָ���˳���
; 185  : 	lock_super (s);

	push	ebx
	mov	BYTE PTR [ebx+106], 0
	call	_lock_super

; 186  : 	if (!(bh = bread (dev, 1)))

	push	1
	push	esi
	call	_bread
	add	esp, 12					; 0000000cH
	cmp	eax, edi
	jne	SHORT $L683

; 230  : //�ͷ�����ѡ���ĳ����������е���������ó���������ؿ�ָ���˳���
; 231  : 		s->s_dev = 0;
; 232  : 		free_super (s);

	push	ebx
	mov	WORD PTR [ebx+84], di
	call	_free_super
	add	esp, 4

; 233  : 		return NULL;

	xor	eax, eax
	pop	edi
	pop	esi
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L683:

; 187  : 	{
; 188  : 		s->s_dev = 0;
; 189  : 		free_super (s);
; 190  : 		return NULL;
; 191  : 	}
; 192  : // ���豸�϶�ȡ�ĳ�������Ϣ���Ƶ�������������Ӧ��ṹ�С����ͷŴ�Ŷ�ȡ��Ϣ�ĸ��ٻ���顣
; 193  : 	*((struct d_super_block *) s) = *((struct d_super_block *) bh->b_data);

	mov	esi, DWORD PTR [eax]
	mov	ecx, 5
	mov	edi, ebx

; 194  : 	brelse (bh);

	push	eax
	rep movsd
	call	_brelse
	add	esp, 4

; 195  : // �����ȡ�ĳ�������ļ�ϵͳħ���ֶ����ݲ��ԣ�˵���豸�ϲ�����ȷ���ļ�ϵͳ�����ͬ����
; 196  : // һ�����ͷ�����ѡ���ĳ����������е��������������ؿ�ָ���˳���
; 197  : // ���ڸð�linux �ںˣ�ֻ֧��minix �ļ�ϵͳ�汾1.0����ħ����0x137f��
; 198  : 	if (s->s_magic != SUPER_MAGIC)

	cmp	WORD PTR [ebx+16], 4991			; 0000137fH

; 199  : 	{
; 200  : 		s->s_dev = 0;
; 201  : 		free_super (s);
; 202  : 		return NULL;

	jne	$L841

; 203  : 	}
; 204  : // ���濪ʼ��ȡ�豸��i �ڵ�λͼ���߼���λͼ���ݡ����ȳ�ʼ���ڴ泬����ṹ��λͼ�ռ䡣
; 205  : 	for (i = 0; i < I_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+20]

; 206  : 		s->s_imap[i] = NULL;

	mov	ecx, 8
	xor	eax, eax
	mov	edi, esi
	rep stosd

; 207  : 	for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	edi, DWORD PTR [ebx+52]

; 208  : 		s->s_zmap[i] = NULL;

	mov	ecx, 8
	rep stosd

; 209  : // Ȼ����豸�϶�ȡi �ڵ�λͼ���߼���λͼ��Ϣ��������ڳ������Ӧ�ֶ��С�
; 210  : 	block = 2;
; 211  : 	for (i = 0; i < s->s_imap_blocks; i++)

	cmp	WORD PTR [ebx+4], ax
	mov	edi, 2
	jbe	SHORT $L696
$L693:

; 212  : 		if (s->s_imap[i] = bread (dev, block))

	mov	eax, DWORD PTR _dev$[ebp]
	push	edi
	push	eax
	call	_bread
	add	esp, 8
	mov	DWORD PTR [esi], eax
	test	eax, eax
	je	SHORT $L696

; 213  : 			block++;

	inc	edi
	xor	edx, edx
	mov	dx, WORD PTR [ebx+4]
	add	esi, 4
	lea	ecx, DWORD PTR [edi-2]
	cmp	ecx, edx
	jl	SHORT $L693
$L696:

; 214  : 		else
; 215  : 			break;
; 216  : 	for (i = 0; i < s->s_zmap_blocks; i++)

	cmp	WORD PTR [ebx+6], 0
	mov	DWORD PTR _i$[ebp], 0
	jbe	SHORT $L701
	lea	esi, DWORD PTR [ebx+52]
$L698:

; 217  : 		if (s->s_zmap[i] = bread (dev, block))

	mov	eax, DWORD PTR _dev$[ebp]
	push	edi
	push	eax
	call	_bread
	add	esp, 8
	mov	DWORD PTR [esi], eax
	test	eax, eax
	je	SHORT $L701
	mov	eax, DWORD PTR _i$[ebp]
	xor	ecx, ecx
	mov	cx, WORD PTR [ebx+6]

; 218  : 			block++;

	inc	edi
	inc	eax
	add	esi, 4
	cmp	eax, ecx
	mov	DWORD PTR _i$[ebp], eax
	jl	SHORT $L698
$L701:

; 219  : 		else
; 220  : 			break;
; 221  : // ���������λͼ�߼�����������λͼӦ��ռ�е��߼�������˵���ļ�ϵͳλͼ��Ϣ�����⣬������
; 222  : // ��ʼ��ʧ�ܡ����ֻ���ͷ�ǰ�������������Դ�����ؿ�ָ�벢�˳���
; 223  : 	if (block != 2 + s->s_imap_blocks + s->s_zmap_blocks)

	xor	edx, edx
	xor	eax, eax
	mov	dx, WORD PTR [ebx+6]
	mov	ax, WORD PTR [ebx+4]
	lea	ecx, DWORD PTR [edx+eax+2]
	cmp	edi, ecx
	je	SHORT $L703

; 224  : 	{
; 225  : // �ͷ�i �ڵ�λͼ���߼���λͼռ�õĸ��ٻ�������
; 226  : 		for (i = 0; i < I_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+20]
	mov	edi, 8
$L704:

; 227  : 			brelse (s->s_imap[i]);

	mov	edx, DWORD PTR [esi]
	push	edx
	call	_brelse
	add	esp, 4
	add	esi, 4
	dec	edi
	jne	SHORT $L704

; 228  : 		for (i = 0; i < Z_MAP_SLOTS; i++)

	lea	esi, DWORD PTR [ebx+52]
	mov	edi, 8
$L707:

; 229  : 			brelse (s->s_zmap[i]);

	mov	eax, DWORD PTR [esi]
	push	eax
	call	_brelse
	add	esp, 4
	add	esi, 4
	dec	edi
	jne	SHORT $L707
$L841:

; 230  : //�ͷ�����ѡ���ĳ����������е���������ó���������ؿ�ָ���˳���
; 231  : 		s->s_dev = 0;
; 232  : 		free_super (s);

	push	ebx
	mov	WORD PTR [ebx+84], 0
	call	_free_super
	add	esp, 4
$L843:
	pop	edi
	pop	esi

; 233  : 		return NULL;

	xor	eax, eax
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L703:

; 234  : 	}
; 235  : // ����һ�гɹ��������������i �ڵ�ĺ�������������豸�����е�i �ڵ��Ѿ�ȫ��ʹ�ã������
; 236  : // �����᷵��0 ֵ�����0 ��i �ڵ��ǲ����õģ��������ｫλͼ�е����λ����Ϊ1���Է�ֹ�ļ�
; 237  : // ϵͳ����0 ��i �ڵ㡣ͬ���ĵ���Ҳ���߼���λͼ�����λ����Ϊ1��
; 238  : 	s->s_imap[0]->b_data[0] |= 1;

	mov	ecx, DWORD PTR [ebx+20]

; 239  : 	s->s_zmap[0]->b_data[0] |= 1;

	mov	edx, DWORD PTR [ebx+52]

; 240  : // �����ó����飬�����س�����ָ�롣
; 241  : 	free_super (s);

	push	ebx
	mov	eax, DWORD PTR [ecx]
	mov	cl, BYTE PTR [eax]
	or	cl, 1
	mov	BYTE PTR [eax], cl
	mov	eax, DWORD PTR [edx]
	or	BYTE PTR [eax], 1
	call	_free_super
	add	esp, 4

; 242  : 	return s;

	mov	eax, ebx
$L671:
	pop	edi
	pop	esi
	pop	ebx

; 243  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_read_super ENDP
_TEXT	ENDS
PUBLIC	_mount_root
EXTRN	_file_table:BYTE
EXTRN	_iget:NEAR
EXTRN	_panic:NEAR
EXTRN	_wait_for_keypress:NEAR
_DATA	SEGMENT
	ORG $+3
$SG757	DB	'bad i-node size', 00H
$SG763	DB	'Insert root floppy and press ENTER', 00H
	ORG $+1
$SG768	DB	'Unable to mount root', 00H
	ORG $+3
$SG770	DB	'Unable to read root i-node', 00H
	ORG $+1
$SG775	DB	'%d/%d free blocks', 0aH, 0dH, 00H
$SG780	DB	'%d/%d free inodes', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T848 = -8
$T849 = -4
$T854 = -4
$T855 = -8
_mount_root PROC NEAR

; 362  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 370  : // ��ʼ���ļ������飨��64 �Ҳ��ϵͳͬʱֻ�ܴ�64 ���ļ������������ļ��ṹ�е����ü���
; 371  : // ����Ϊ0��[??Ϊʲô���������ʼ����]
; 372  : 	for (i = 0; i < NR_FILE; i++)

	mov	eax, OFFSET FLAT:_file_table+4
$L758:

; 373  : 		file_table[i].f_count = 0;

	mov	WORD PTR [eax], 0
	add	eax, 16					; 00000010H
	cmp	eax, OFFSET FLAT:_file_table+1028
	jl	SHORT $L758

; 374  : // ������ļ�ϵͳ�����豸�����̵Ļ�������ʾ��������ļ�ϵͳ�̣������س����������ȴ�������
; 375  : 	if (MAJOR (ROOT_DEV) == 2)

	mov	eax, DWORD PTR _ROOT_DEV
	and	al, 0
	cmp	eax, 512				; 00000200H
	jne	SHORT $L762

; 376  : 	{
; 377  : 		printk ("Insert root floppy and press ENTER");

	push	OFFSET FLAT:$SG763
	call	_printk
	add	esp, 4

; 378  : 		wait_for_keypress ();

	call	_wait_for_keypress
$L762:

; 379  : 	}
; 380  : // ��ʼ�����������飨��8 ���
; 381  : 	for (p = &super_block[0]; p < &super_block[NR_SUPER]; p++)

	mov	eax, OFFSET FLAT:_super_block+104
$L764:

; 382  : 	{
; 383  : 		p->s_dev = 0;

	xor	ecx, ecx
	mov	WORD PTR [eax-20], cx

; 384  : 		p->s_lock = 0;

	mov	BYTE PTR [eax], cl

; 385  : 		p->s_wait = NULL;

	mov	DWORD PTR [eax-4], ecx
	add	eax, 108				; 0000006cH
	lea	ecx, DWORD PTR [eax-104]
	cmp	ecx, OFFSET FLAT:_super_block+864
	jb	SHORT $L764

; 386  : 	}
; 387  : // ��������豸�ϳ�����ʧ�ܣ�����ʾ��Ϣ����������
; 388  : 	if (!(p = read_super (ROOT_DEV)))

	mov	edx, DWORD PTR _ROOT_DEV
	push	ebx
	push	esi
	push	edi
	push	edx
	call	_read_super
	mov	esi, eax
	add	esp, 4
	test	esi, esi
	jne	SHORT $L767

; 389  : 		panic ("Unable to mount root");

	push	OFFSET FLAT:$SG768
	call	_panic
	add	esp, 4
$L767:

; 390  : //���豸�϶�ȡ�ļ�ϵͳ�ĸ�i �ڵ�(1)�����ʧ������ʾ������Ϣ��������
; 391  : 	if (!(mi = iget (ROOT_DEV, ROOT_INO)))

	mov	eax, DWORD PTR _ROOT_DEV
	push	1
	push	eax
	call	_iget
	mov	edi, eax
	add	esp, 8
	test	edi, edi
	jne	SHORT $L769

; 392  : 		panic ("Unable to read root i-node");

	push	OFFSET FLAT:$SG770
	call	_panic
	add	esp, 4
$L769:

; 393  : // ��i �ڵ����ô�������3 �Ρ���Ϊ����266-268 ����Ҳ�����˸�i �ڵ㡣
; 394  : 	mi->i_count += 3;		/* NOTE! it is logically used 4 times, not 1 */
; 395  : /* ע�⣡���߼��Ͻ������ѱ�������4 �Σ�������1 �� */
; 396  : // �øó�����ı���װ�ļ�ϵͳi �ڵ�ͱ���װ����i �ڵ�Ϊ��i �ڵ㡣
; 397  : 	p->s_isup = p->s_imount = mi;
; 398  : // ���õ�ǰ���̵ĵ�ǰ����Ŀ¼�͸�Ŀ¼i �ڵ㡣��ʱ��ǰ������1 �Ž��̡�
; 399  : 	current->pwd = mi;

	mov	eax, DWORD PTR _current
	add	WORD PTR [edi+48], 3

; 400  : 	current->root = mi;
; 401  : // ͳ�Ƹ��豸�Ͽ��п�����������i ���ڳ������б������豸�߼���������
; 402  : 	free = 0;
; 403  : 	i = p->s_nzones;
; 404  : // Ȼ������߼���λͼ����Ӧ����λ��ռ�����ͳ�Ƴ����п���������꺯��set_bit()ֻ���ڲ���
; 405  : // ����λ���������ñ���λ��"i&8191"����ȡ��i �ڵ���ڵ�ǰ���е�ƫ��ֵ��"i>>13"�ǽ�i ����
; 406  : // 8192��Ҳ����һ�����̿�����ı���λ����
; 407  : 	while (--i >= 0)

	xor	ecx, ecx
	mov	DWORD PTR [esi+92], edi
	mov	cx, WORD PTR [esi+2]
	mov	DWORD PTR [eax+624], edi
	mov	DWORD PTR [esi+88], edi
	mov	DWORD PTR [eax+628], edi
	xor	edi, edi
	dec	ecx
	js	SHORT $L773
$L772:

; 408  : 		if (!set_bit (i & 8191, p->s_zmap[i >> 13]->b_data))

	mov	edx, ecx
	sar	edx, 13					; 0000000dH
	mov	eax, DWORD PTR [esi+edx*4+52]
	mov	edx, DWORD PTR [eax]
	mov	eax, ecx
	and	eax, 8191				; 00001fffH
	mov	DWORD PTR $T849[ebp], edx
	mov	DWORD PTR $T848[ebp], eax

; 363  : 	int i, free;
; 364  : 	struct super_block *p;
; 365  : 	struct m_inode *mi;

	xor	eax, eax

; 366  : 

	mov	ebx, DWORD PTR $T848[ebp]

; 367  : // �������i �ڵ�ṹ����32 ���ֽڣ���������������ж������ڷ�ֹ�޸�Դ����ʱ�Ĳ�һ���ԡ�

	mov	edx, DWORD PTR $T849[ebp]

; 368  : 	if (32 != sizeof (struct d_inode))

	bt	DWORD PTR [edx], ebx

; 369  : 		panic ("bad i-node size");

	setb	al

; 408  : 		if (!set_bit (i & 8191, p->s_zmap[i >> 13]->b_data))

	test	eax, eax
	jne	SHORT $L774

; 409  : 			free++;

	inc	edi
$L774:

; 400  : 	current->root = mi;
; 401  : // ͳ�Ƹ��豸�Ͽ��п�����������i ���ڳ������б������豸�߼���������
; 402  : 	free = 0;
; 403  : 	i = p->s_nzones;
; 404  : // Ȼ������߼���λͼ����Ӧ����λ��ռ�����ͳ�Ƴ����п���������꺯��set_bit()ֻ���ڲ���
; 405  : // ����λ���������ñ���λ��"i&8191"����ȡ��i �ڵ���ڵ�ǰ���е�ƫ��ֵ��"i>>13"�ǽ�i ����
; 406  : // 8192��Ҳ����һ�����̿�����ı���λ����
; 407  : 	while (--i >= 0)

	dec	ecx
	jns	SHORT $L772
$L773:

; 410  : // ��ʾ�豸�Ͽ����߼�����/�߼���������
; 411  : 	printk ("%d/%d free blocks\n\r", free, p->s_nzones);

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+2]
	push	ecx
	push	edi
	push	OFFSET FLAT:$SG775
	call	_printk

; 412  : // ͳ���豸�Ͽ���i �ڵ�����������i ���ڳ������б������豸��i �ڵ�����+1����1 �ǽ�0 �ڵ�
; 413  : // Ҳͳ�ƽ�ȥ��
; 414  : 	free = 0;
; 415  : 	i = p->s_ninodes + 1;
; 416  : // Ȼ�����i �ڵ�λͼ����Ӧ����λ��ռ��������������i �ڵ�����
; 417  : 	while (--i >= 0)

	xor	ecx, ecx
	add	esp, 12					; 0000000cH
	mov	cx, WORD PTR [esi]
	xor	edi, edi
	test	ecx, ecx
	jl	SHORT $L778
$L777:

; 418  : 		if (!set_bit (i & 8191, p->s_imap[i >> 13]->b_data))

	mov	edx, ecx
	sar	edx, 13					; 0000000dH
	mov	eax, DWORD PTR [esi+edx*4+20]
	mov	edx, DWORD PTR [eax]
	mov	eax, ecx
	and	eax, 8191				; 00001fffH
	mov	DWORD PTR $T855[ebp], edx
	mov	DWORD PTR $T854[ebp], eax

; 363  : 	int i, free;
; 364  : 	struct super_block *p;
; 365  : 	struct m_inode *mi;

	xor	eax, eax

; 366  : 

	mov	ebx, DWORD PTR $T854[ebp]

; 367  : // �������i �ڵ�ṹ����32 ���ֽڣ���������������ж������ڷ�ֹ�޸�Դ����ʱ�Ĳ�һ���ԡ�

	mov	edx, DWORD PTR $T855[ebp]

; 368  : 	if (32 != sizeof (struct d_inode))

	bt	DWORD PTR [edx], ebx

; 369  : 		panic ("bad i-node size");

	setb	al

; 418  : 		if (!set_bit (i & 8191, p->s_imap[i >> 13]->b_data))

	test	eax, eax
	jne	SHORT $L779

; 419  : 			free++;

	inc	edi
$L779:

; 412  : // ͳ���豸�Ͽ���i �ڵ�����������i ���ڳ������б������豸��i �ڵ�����+1����1 �ǽ�0 �ڵ�
; 413  : // Ҳͳ�ƽ�ȥ��
; 414  : 	free = 0;
; 415  : 	i = p->s_ninodes + 1;
; 416  : // Ȼ�����i �ڵ�λͼ����Ӧ����λ��ռ��������������i �ڵ�����
; 417  : 	while (--i >= 0)

	dec	ecx
	jns	SHORT $L777
$L778:

; 420  : // ��ʾ�豸�Ͽ��õĿ���i �ڵ���/i �ڵ�������
; 421  : 	printk ("%d/%d free inodes\n\r", free, p->s_ninodes);

	xor	ecx, ecx
	mov	cx, WORD PTR [esi]
	push	ecx
	push	edi
	push	OFFSET FLAT:$SG780
	call	_printk
	add	esp, 12					; 0000000cH
	pop	edi
	pop	esi
	pop	ebx

; 422  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_mount_root ENDP
_TEXT	ENDS
END
