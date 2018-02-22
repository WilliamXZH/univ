	TITLE	..\fs\truncate.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_truncate
EXTRN	_free_block:NEAR
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_TEXT	SEGMENT
_inode$ = 8
_truncate PROC NEAR

; 82   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 83   :   int i;
; 84   : 
; 85   : // ������ǳ����ļ�������Ŀ¼�ļ����򷵻ء�
; 86   :   if (!(S_ISREG (inode->i_mode) || S_ISDIR (inode->i_mode)))

	mov	esi, DWORD PTR _inode$[ebp]
	mov	ax, WORD PTR [esi]
	and	ax, 61440				; 0000f000H
	cmp	ax, 32768				; 00008000H
	je	SHORT $L598
	cmp	ax, 16384				; 00004000H
	jne	$L596
$L598:
	push	edi

; 87   :     return;
; 88   : // �ͷ�i �ڵ��7 ��ֱ���߼��飬������7 ���߼�����ȫ���㡣
; 89   :   for (i = 0; i < 7; i++)

	lea	edi, DWORD PTR [esi+14]
	mov	DWORD PTR 8+[ebp], 7
$L599:

; 90   :     if (inode->i_zone[i])

	mov	ax, WORD PTR [edi]
	test	ax, ax
	je	SHORT $L600

; 91   : 	{				// �����Ų�Ϊ0�����ͷ�֮��
; 92   : 		free_block (inode->i_dev, inode->i_zone[i]);

	and	eax, 65535				; 0000ffffH
	push	eax
	xor	eax, eax
	mov	ax, WORD PTR [esi+44]
	push	eax
	call	_free_block
	add	esp, 8

; 93   : 		inode->i_zone[i] = 0;

	mov	WORD PTR [edi], 0
$L600:
	mov	eax, DWORD PTR 8+[ebp]
	add	edi, 2
	dec	eax
	mov	DWORD PTR 8+[ebp], eax
	jne	SHORT $L599

; 94   : 	}
; 95   :   free_ind (inode->i_dev, inode->i_zone[7]);	// �ͷ�һ�μ�ӿ顣

	xor	ecx, ecx
	xor	edi, edi
	mov	cx, WORD PTR [esi+28]
	mov	di, WORD PTR [esi+44]
	push	ecx
	push	edi
	call	_free_ind

; 96   :   free_dind (inode->i_dev, inode->i_zone[8]);	// �ͷŶ��μ�ӿ顣

	xor	edx, edx
	mov	dx, WORD PTR [esi+30]
	push	edx
	push	edi
	call	_free_dind
	add	esp, 16					; 00000010H

; 97   :   inode->i_zone[7] = inode->i_zone[8] = 0;	// �߼�����7��8 ���㡣

	mov	WORD PTR [esi+30], 0
	mov	WORD PTR [esi+28], 0

; 98   :   inode->i_size = 0;		// �ļ���С���㡣

	mov	DWORD PTR [esi+4], 0

; 99   :   inode->i_dirt = 1;		// �ýڵ����޸ı�־��

	mov	BYTE PTR [esi+51], 1

; 100  :   inode->i_mtime = inode->i_ctime = CURRENT_TIME;	// �����ļ��ͽڵ��޸�ʱ��Ϊ��ǰʱ�䡣

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	pop	edi
	imul	ecx
	mov	ecx, DWORD PTR _startup_time
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax
	lea	eax, DWORD PTR [edx+ecx]
	mov	DWORD PTR [esi+40], eax
	mov	DWORD PTR [esi+8], eax
$L596:
	pop	esi

; 101  : }

	pop	ebp
	ret	0
_truncate ENDP
_TEXT	ENDS
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
_TEXT	SEGMENT
_dev$ = 8
_block$ = 12
_bh$ = 8
_free_ind PROC NEAR

; 15   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 16   :   struct buffer_head *bh;
; 17   :   unsigned short *p;
; 18   :   int i;
; 19   : 
; 20   : // ����߼����Ϊ0���򷵻ء�
; 21   :   if (!block)

	mov	esi, DWORD PTR _block$[ebp]
	test	esi, esi
	je	SHORT $L567
	push	edi

; 22   :     return;
; 23   : // ��ȡһ�μ�ӿ飬���ͷ����ϱ���ʹ�õ������߼��飬Ȼ���ͷŸ�һ�μ�ӿ�Ļ�������
; 24   :   if (bh = bread (dev, block))

	mov	edi, DWORD PTR _dev$[ebp]
	push	esi
	push	edi
	call	_bread
	mov	ecx, eax
	add	esp, 8
	test	ecx, ecx
	mov	DWORD PTR _bh$[ebp], ecx
	je	SHORT $L572

; 25   :     {
; 26   :       p = (unsigned short *) bh->b_data;	// ָ�����ݻ�������

	mov	esi, DWORD PTR [ecx]
	push	ebx
	mov	ebx, 512				; 00000200H
$L574:

; 27   :       for (i = 0; i < 512; i++, p++)	// ÿ���߼����Ͽ���512 ����š�
; 28   : 	if (*p)

	mov	ax, WORD PTR [esi]
	test	ax, ax
	je	SHORT $L575

; 29   : 	  free_block (dev, *p);	// �ͷ�ָ�����߼��顣

	and	eax, 65535				; 0000ffffH
	push	eax
	push	edi
	call	_free_block
	mov	ecx, DWORD PTR _bh$[ebp]
	add	esp, 8
$L575:
	add	esi, 2
	dec	ebx
	jne	SHORT $L574

; 30   :       brelse (bh);		// �ͷŻ�������

	push	ecx
	call	_brelse
	mov	esi, DWORD PTR _block$[ebp]
	add	esp, 4
	pop	ebx
$L572:

; 31   :     }
; 32   : //�����ֶ�
; 33   : //i_zone[0]
; 34   : //i_zone[1]
; 35   : //i_zone[2]
; 36   : //i_zone[3]
; 37   : //i_zone[4]
; 38   : //i_zone[5]
; 39   : //i_zone[6]
; 40   : //i �ڵ�
; 41   : //ֱ�ӿ��
; 42   : //һ�μ�ӿ�
; 43   : //���μ�ӿ�
; 44   : //��һ����
; 45   : //���μ�ӿ�
; 46   : //�Ķ�����
; 47   : //һ�μ�ӿ��
; 48   : //���μ�ӿ��
; 49   : //i_zone[7]
; 50   : //i_zone[8]
; 51   : // �ͷ��豸�ϵ�һ�μ�ӿ顣
; 52   :   free_block (dev, block);

	push	esi
	push	edi
	call	_free_block
	add	esp, 8
	pop	edi
$L567:
	pop	esi

; 53   : }

	pop	ebp
	ret	0
_free_ind ENDP
_dev$ = 8
_block$ = 12
_bh$ = 8
_free_dind PROC NEAR

; 58   : {

	push	ebp
	mov	ebp, esp
	push	esi

; 59   :   struct buffer_head *bh;
; 60   :   unsigned short *p;
; 61   :   int i;
; 62   : 
; 63   : // ����߼����Ϊ0���򷵻ء�
; 64   :   if (!block)

	mov	esi, DWORD PTR _block$[ebp]
	test	esi, esi
	je	SHORT $L583
	push	edi

; 65   :     return;
; 66   : // ��ȡ���μ�ӿ��һ���飬���ͷ����ϱ���ʹ�õ������߼��飬Ȼ���ͷŸ�һ����Ļ�������
; 67   :   if (bh = bread (dev, block))

	mov	edi, DWORD PTR _dev$[ebp]
	push	esi
	push	edi
	call	_bread
	mov	ecx, eax
	add	esp, 8
	test	ecx, ecx
	mov	DWORD PTR _bh$[ebp], ecx
	je	SHORT $L588

; 68   :     {
; 69   :       p = (unsigned short *) bh->b_data;	// ָ�����ݻ�������

	mov	esi, DWORD PTR [ecx]
	push	ebx
	mov	ebx, 512				; 00000200H
$L590:

; 70   :       for (i = 0; i < 512; i++, p++)	// ÿ���߼����Ͽ�����512 �������顣
; 71   : 	if (*p)

	mov	ax, WORD PTR [esi]
	test	ax, ax
	je	SHORT $L591

; 72   : 	  free_ind (dev, *p);	// �ͷ�����һ�μ�ӿ顣

	and	eax, 65535				; 0000ffffH
	push	eax
	push	edi
	call	_free_ind
	mov	ecx, DWORD PTR _bh$[ebp]
	add	esp, 8
$L591:
	add	esi, 2
	dec	ebx
	jne	SHORT $L590

; 73   :       brelse (bh);		// �ͷŻ�������

	push	ecx
	call	_brelse
	mov	esi, DWORD PTR _block$[ebp]
	add	esp, 4
	pop	ebx
$L588:

; 74   :     }
; 75   : // ����ͷ��豸�ϵĶ��μ�ӿ顣
; 76   :   free_block (dev, block);

	push	esi
	push	edi
	call	_free_block
	add	esp, 8
	pop	edi
$L583:
	pop	esi

; 77   : }

	pop	ebp
	ret	0
_free_dind ENDP
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
END
