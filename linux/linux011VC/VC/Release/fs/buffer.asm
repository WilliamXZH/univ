	TITLE	..\fs\buffer.c
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
;	COMDAT _invalidate_buffers
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _COPYBLK
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_start_buffer
PUBLIC	_nr_buffers
PUBLIC	_hash_table
EXTRN	_end:DWORD
_BSS	SEGMENT
_nr_buffers DD	01H DUP (?)
_hash_table DD	0133H DUP (?)
_free_list DD	01H DUP (?)
_buffer_wait DD	01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_start_buffer DD FLAT:_end
$SG671	DB	'Free block list corrupted', 00H
_DATA	ENDS
PUBLIC	_sys_sync
EXTRN	_sync_inodes:NEAR
EXTRN	_ll_rw_block:NEAR
EXTRN	_sleep_on:NEAR
_TEXT	SEGMENT
_sys_sync PROC NEAR

; 56   : {

	push	ebx
	push	esi

; 58   : 	struct buffer_head * bh;
; 59   : 
; 60   : 	sync_inodes();		/* ��i �ڵ�д����ٻ��� */

	call	_sync_inodes

; 61   : // ɨ�����и��ٻ������������ѱ��޸ĵĻ�������д�����󣬽��������������豸��ͬ����
; 62   : 	bh = start_buffer;
; 63   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	mov	eax, DWORD PTR _nr_buffers
	mov	esi, DWORD PTR _start_buffer
	xor	ebx, ebx
	test	eax, eax
	jle	SHORT $L843
	push	edi
$L619:

; 57   : 	int i;

	cli

; 64   : 		wait_on_buffer(bh);		// �ȴ�����������������������Ļ�����

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L837

; 61   : // ɨ�����и��ٻ������������ѱ��޸ĵĻ�������д�����󣬽��������������豸��ͬ����
; 62   : 	bh = start_buffer;
; 63   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	lea	edi, DWORD PTR [esi+16]

; 64   : 		wait_on_buffer(bh);		// �ȴ�����������������������Ļ�����

$L836:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L836
$L837:

; 58   : 	struct buffer_head * bh;
; 59   : 
; 60   : 	sync_inodes();		/* ��i �ڵ�д����ٻ��� */

	sti

; 65   : 		if (bh->b_dirt)

	mov	al, BYTE PTR [esi+11]
	test	al, al
	je	SHORT $L620

; 66   : 			ll_rw_block(WRITE,bh);	// ����д�豸������

	push	esi
	push	1
	call	_ll_rw_block
	add	esp, 8
$L620:
	mov	eax, DWORD PTR _nr_buffers
	inc	ebx
	add	esi, 36					; 00000024H
	cmp	ebx, eax
	jl	SHORT $L619
	pop	edi
	pop	esi

; 67   : 	}
; 68   : 	return 0;

	xor	eax, eax
	pop	ebx

; 69   : }

	ret	0
$L843:
	pop	esi

; 67   : 	}
; 68   : 	return 0;

	xor	eax, eax
	pop	ebx

; 69   : }

	ret	0
_sys_sync ENDP
_TEXT	ENDS
PUBLIC	_sync_dev
_TEXT	SEGMENT
_dev$ = 8
_sync_dev PROC NEAR

; 73   : {

	push	ebp
	mov	ebp, esp

; 78   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	mov	eax, DWORD PTR _nr_buffers
	push	ebx
	xor	ebx, ebx
	push	esi
	mov	esi, DWORD PTR _start_buffer
	push	edi
	test	eax, eax
	jle	SHORT $L866
$L628:

; 79   : 		if (bh->b_dev != dev)

	mov	edi, DWORD PTR _dev$[ebp]
	xor	eax, eax
	mov	ax, WORD PTR [esi+8]
	cmp	eax, edi
	jne	SHORT $L629

; 74   : 	int i;

	cli

; 80   : 			continue;
; 81   : 		wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L848

; 78   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	lea	edi, DWORD PTR [esi+16]

; 80   : 			continue;
; 81   : 		wait_on_buffer(bh);

$L847:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L847
	mov	edi, DWORD PTR _dev$[ebp]
$L848:

; 75   : 	struct buffer_head * bh;
; 76   : 
; 77   : 	bh = start_buffer;

	sti

; 82   : 		if (bh->b_dev == dev && bh->b_dirt)

	xor	ecx, ecx
	mov	cx, WORD PTR [esi+8]
	cmp	ecx, edi
	jne	SHORT $L629
	mov	al, BYTE PTR [esi+11]
	test	al, al
	je	SHORT $L629

; 83   : 			ll_rw_block(WRITE,bh);

	push	esi
	push	1
	call	_ll_rw_block
	add	esp, 8
$L629:
	mov	eax, DWORD PTR _nr_buffers
	inc	ebx
	add	esi, 36					; 00000024H
	cmp	ebx, eax
	jl	SHORT $L628

; 78   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	jmp	SHORT $L630
$L866:
	mov	edi, DWORD PTR _dev$[ebp]
$L630:

; 84   : 	}
; 85   : 	sync_inodes();			// ��i �ڵ�����д����ٻ��塣

	call	_sync_inodes

; 86   : 	bh = start_buffer;
; 87   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	mov	eax, DWORD PTR _nr_buffers
	mov	esi, DWORD PTR _start_buffer
	xor	ebx, ebx
	test	eax, eax
	jle	SHORT $L863
$L633:

; 88   : 		if (bh->b_dev != dev)

	xor	edx, edx
	mov	dx, WORD PTR [esi+8]
	cmp	edx, edi
	jne	SHORT $L634

; 74   : 	int i;

	cli

; 89   : 			continue;
; 90   : 		wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L853

; 86   : 	bh = start_buffer;
; 87   : 	for (i=0 ; i<NR_BUFFERS ; i++,bh++) {

	lea	edi, DWORD PTR [esi+16]

; 89   : 			continue;
; 90   : 		wait_on_buffer(bh);

$L852:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L852
	mov	edi, DWORD PTR _dev$[ebp]
$L853:

; 75   : 	struct buffer_head * bh;
; 76   : 
; 77   : 	bh = start_buffer;

	sti

; 91   : 		if (bh->b_dev == dev && bh->b_dirt)

	xor	eax, eax
	mov	ax, WORD PTR [esi+8]
	cmp	eax, edi
	jne	SHORT $L634
	mov	al, BYTE PTR [esi+11]
	test	al, al
	je	SHORT $L634

; 92   : 			ll_rw_block(WRITE,bh);

	push	esi
	push	1
	call	_ll_rw_block
	add	esp, 8
$L634:
	mov	eax, DWORD PTR _nr_buffers
	inc	ebx
	add	esi, 36					; 00000024H
	cmp	ebx, eax
	jl	SHORT $L633
$L863:
	pop	edi
	pop	esi

; 93   : 	}
; 94   : 	return 0;

	xor	eax, eax
	pop	ebx

; 95   : }

	pop	ebp
	ret	0
_sync_dev ENDP
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
PUBLIC	_check_disk_change
EXTRN	_super_block:BYTE
EXTRN	_floppy_change:NEAR
EXTRN	_put_super:NEAR
EXTRN	_invalidate_inodes:NEAR
_TEXT	SEGMENT
_dev$ = 8
_check_disk_change PROC NEAR

; 126  : {

	push	ebp
	mov	ebp, esp
	push	ebx
	push	esi
	push	edi

; 128  : 
; 129  : // �������豸������������˳���
; 130  : 	if (MAJOR(dev) != 2)

	mov	edi, DWORD PTR _dev$[ebp]
	mov	eax, edi
	and	al, 0
	cmp	eax, 512				; 00000200H
	jne	$L880

; 131  : 		return;
; 132  : // ���Զ�Ӧ�����Ƿ��Ѹ��������û�����˳���
; 133  : 	if (!floppy_change(dev & 0x03))

	mov	ecx, edi
	and	ecx, 3
	push	ecx
	call	_floppy_change
	add	esp, 4
	test	eax, eax
	je	$L880

; 134  : 		return;
; 135  : // �����Ѿ������������ͷŶ�Ӧ�豸��i �ڵ�λͼ���߼���λͼ��ռ�ĸ��ٻ���������ʹ���豸��
; 136  : // i �ڵ�����ݿ���Ϣ��ռ�ĸ��ٻ�������Ч��
; 137  : 	for (i=0 ; i<NR_SUPER ; i++)

	mov	esi, OFFSET FLAT:_super_block+84
$L656:

; 138  : 		if (super_block[i].s_dev == dev)

	xor	eax, eax
	mov	ax, WORD PTR [esi]
	cmp	eax, edi
	jne	SHORT $L657

; 139  : 			put_super(super_block[i].s_dev);

	push	eax
	call	_put_super
	add	esp, 4
$L657:
	add	esi, 108				; 0000006cH
	cmp	esi, OFFSET FLAT:_super_block+948
	jl	SHORT $L656

; 140  : 	invalidate_inodes(dev);

	push	edi
	call	_invalidate_inodes

; 141  : 	invalidate_buffers(dev);

	mov	ecx, DWORD PTR _nr_buffers
	mov	eax, DWORD PTR _start_buffer
	add	esp, 4
	xor	ebx, ebx
	test	ecx, ecx
	jle	SHORT $L880

; 140  : 	invalidate_inodes(dev);

	lea	esi, DWORD PTR [eax+13]

; 141  : 	invalidate_buffers(dev);

$L878:
	xor	edx, edx
	mov	dx, WORD PTR [esi-5]
	cmp	edx, edi
	jne	SHORT $L879

; 127  : 	int i;

	cli

; 141  : 	invalidate_buffers(dev);

	cmp	BYTE PTR [esi], 0
	je	SHORT $L886
	lea	edi, DWORD PTR [esi+3]
$L885:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi]
	add	esp, 4
	test	al, al
	jne	SHORT $L885
	mov	edi, DWORD PTR _dev$[ebp]
$L886:

; 128  : 
; 129  : // �������豸������������˳���
; 130  : 	if (MAJOR(dev) != 2)

	sti

; 141  : 	invalidate_buffers(dev);

	xor	eax, eax
	mov	ax, WORD PTR [esi-5]
	cmp	eax, edi
	jne	SHORT $L879
	mov	BYTE PTR [esi-2], 0
	mov	BYTE PTR [esi-3], 0
$L879:
	mov	eax, DWORD PTR _nr_buffers
	inc	ebx
	add	esi, 36					; 00000024H
	cmp	ebx, eax
	jl	SHORT $L878
$L880:
	pop	edi
	pop	esi
	pop	ebx

; 142  : }

	pop	ebp
	ret	0
_check_disk_change ENDP
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

	je	SHORT $l1$504

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$505, ax

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
$lcs$505:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$504

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$504:

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
PUBLIC	_get_hash_table
_TEXT	SEGMENT
_dev$ = 8
_block$ = 12
_get_hash_table PROC NEAR

; 206  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 211  : 		if (!(bh=find_buffer(dev,block)))

	mov	ebx, DWORD PTR _block$[ebp]
	push	esi
	push	edi
	mov	edi, DWORD PTR _dev$[ebp]
	push	ebx
	push	edi
	call	_find_buffer
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	je	SHORT $L909
$L699:

; 213  : 		// �Ըû������������ü��������ȴ��û���������������ѱ���������
; 214  : 		bh->b_count++;

	inc	BYTE PTR [esi+12]

; 207  : 	struct buffer_head * bh;

	cli

; 215  : 		wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L904
	lea	edi, DWORD PTR [esi+16]
$L903:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L903
	mov	edi, DWORD PTR _dev$[ebp]
$L904:

; 208  : 
; 209  : 	for (;;) {
; 210  : 		// �ڸ��ٻ�����Ѱ�Ҹ����豸��ָ����Ļ����������û���ҵ��򷵻�NULL���˳���

	sti

; 216  : 		// ���ھ�����˯��״̬������б�Ҫ����֤�û����������ȷ�ԣ������ػ�����ͷָ�롣
; 217  : 		if (bh->b_dev == dev && bh->b_blocknr == block)

	xor	eax, eax
	mov	ax, WORD PTR [esi+8]
	cmp	eax, edi
	jne	SHORT $L702
	cmp	DWORD PTR [esi+4], ebx
	je	SHORT $L910
$L702:

; 219  : // ����û������������豸�Ż�����˯��ʱ�����˸ı䣬�������������ü���������Ѱ�ҡ�
; 220  : 		bh->b_count--;

	mov	al, BYTE PTR [esi+12]
	push	ebx
	dec	al
	push	edi
	mov	BYTE PTR [esi+12], al
	call	_find_buffer
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L699
$L909:
	pop	edi
	pop	esi

; 212  : 			return NULL;

	xor	eax, eax
	pop	ebx

; 221  : 	}
; 222  : }

	pop	ebp
	ret	0
$L910:

; 218  : 			return bh;

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 221  : 	}
; 222  : }

	pop	ebp
	ret	0
_get_hash_table ENDP
_dev$ = 8
_block$ = 12
_find_buffer PROC NEAR

; 190  : {		

	push	ebp
	mov	ebp, esp

; 191  : 	struct buffer_head * tmp;
; 192  : 
; 193  : 	for (tmp = hash(dev,block) ; tmp != NULL ; tmp = tmp->b_next)

	mov	ecx, DWORD PTR _dev$[ebp]
	push	esi
	mov	esi, DWORD PTR _block$[ebp]
	mov	eax, ecx
	push	edi
	xor	eax, esi
	xor	edx, edx
	mov	edi, 307				; 00000133H
	div	edi
	mov	eax, DWORD PTR _hash_table[edx*4]
	test	eax, eax
	je	SHORT $L690
$L688:

; 194  : 		if (tmp->b_dev==dev && tmp->b_blocknr==block)

	xor	edx, edx
	mov	dx, WORD PTR [eax+8]
	cmp	edx, ecx
	jne	SHORT $L689
	cmp	DWORD PTR [eax+4], esi
	je	SHORT $L685
$L689:

; 191  : 	struct buffer_head * tmp;
; 192  : 
; 193  : 	for (tmp = hash(dev,block) ; tmp != NULL ; tmp = tmp->b_next)

	mov	eax, DWORD PTR [eax+24]
	test	eax, eax
	jne	SHORT $L688
$L690:

; 195  : 			return tmp;
; 196  : 	return NULL;

	xor	eax, eax
$L685:
	pop	edi
	pop	esi

; 197  : }

	pop	ebp
	ret	0
_find_buffer ENDP
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
PUBLIC	_getblk
EXTRN	_panic:NEAR
_TEXT	SEGMENT
_dev$ = 8
_block$ = 12
_getblk	PROC NEAR

; 237  : {

	push	ebp
	mov	ebp, esp

; 242  : 	if (bh = get_hash_table(dev,block))

	mov	eax, DWORD PTR _block$[ebp]
	mov	ecx, DWORD PTR _dev$[ebp]
	push	ebx
	push	esi
	push	edi
	push	eax
	push	ecx
	call	_get_hash_table
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	$L949
$repeat$710:

; 243  : 		return bh;
; 244  : // ɨ��������ݿ�����Ѱ�ҿ��л�������
; 245  : // ������tmp ָ���������ĵ�һ�����л�����ͷ��
; 246  : 	tmp = free_list;

	mov	ecx, DWORD PTR _free_list
	mov	eax, ecx
$L712:

; 247  : 	do {
; 248  : // ����û���������ʹ�ã����ü���������0���������ɨ����һ�
; 249  : 		if (tmp->b_count)

	mov	dl, BYTE PTR [eax+12]
	test	dl, dl
	jne	SHORT $L713

; 250  : 			continue;
; 251  : // �������ͷָ��bh Ϊ�գ�����tmp ��ָ����ͷ�ı�־(�޸ġ�����)Ȩ��С��bh ͷ��־��Ȩ�أ�
; 252  : // ����bh ָ���tmp ������ͷ�������tmp ������ͷ������������û���޸�Ҳû��������־��λ��
; 253  : // ��˵����Ϊָ���豸�ϵĿ�ȡ�ö�Ӧ�ĸ��ٻ����������˳�ѭ����
; 254  : 		if (!bh || BADNESS(tmp)<BADNESS(bh)) {

	test	esi, esi
	je	SHORT $L717
	xor	edx, edx
	xor	ebx, ebx
	mov	dl, BYTE PTR [eax+11]
	mov	bl, BYTE PTR [eax+13]
	lea	edi, DWORD PTR [ebx+edx*2]
	xor	ebx, ebx
	mov	bl, BYTE PTR [esi+11]
	xor	edx, edx
	mov	dl, BYTE PTR [esi+13]
	lea	edx, DWORD PTR [edx+ebx*2]
	cmp	edi, edx
	jge	SHORT $L713
$L717:

; 255  : 			bh = tmp;
; 256  : 			if (!BADNESS(tmp))

	xor	edx, edx
	xor	ebx, ebx
	mov	dl, BYTE PTR [eax+11]
	mov	bl, BYTE PTR [eax+13]
	mov	esi, eax
	lea	edx, DWORD PTR [ebx+edx*2]
	test	edx, edx
	je	SHORT $L714
$L713:

; 257  : 				break;
; 258  : 		}
; 259  : /* �ظ�����ֱ���ҵ��ʺϵĻ����� */
; 260  : 	} while ((tmp = tmp->b_next_free) != free_list);

	mov	eax, DWORD PTR [eax+32]
	cmp	eax, ecx
	jne	SHORT $L712
$L714:

; 261  : // ������л�����������ʹ�ã����л�������ͷ�����ü�����>0����
; 262  : // ��˯�ߣ��ȴ��п��еĻ��������á�
; 263  : 	if (!bh) {

	test	esi, esi
	jne	SHORT $L719

; 264  : 		sleep_on(&buffer_wait);

	push	OFFSET FLAT:_buffer_wait
	call	_sleep_on
	add	esp, 4
$L954:

; 265  : 		goto repeat;

	mov	ebx, DWORD PTR _dev$[ebp]
$L952:

; 242  : 	if (bh = get_hash_table(dev,block))

	mov	edx, DWORD PTR _block$[ebp]
	push	edx
	push	ebx
	call	_get_hash_table
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	je	SHORT $repeat$710
	pop	edi
	pop	esi
	pop	ebx

; 299  : }

	pop	ebp
	ret	0
$L719:

; 238  : 	struct buffer_head * tmp, * bh;

	cli

; 266  : 	}
; 267  : 	// �ȴ��û���������������ѱ������Ļ�����
; 268  : 	wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L922
	lea	edi, DWORD PTR [esi+16]
$L921:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L921
$L922:

; 239  : 
; 240  : repeat:
; 241  : 	// ����hash �����ָ�����Ѿ��ڸ��ٻ����У��򷵻ض�Ӧ������ͷָ�룬�˳���

	sti

; 269  : 	// ����û������ֱ���������ʹ�õĻ���ֻ���ظ��������̡�
; 270  : 	if (bh->b_count)

	mov	al, BYTE PTR [esi+12]
	test	al, al
	jne	SHORT $L954

; 271  : 		goto repeat;
; 272  : // ����û������ѱ��޸ģ�������д�̣����ٴεȴ�����������������û������ֱ���������ʹ��
; 273  : // �Ļ���ֻ�����ظ��������̡�
; 274  : 	while (bh->b_dirt) {

	mov	al, BYTE PTR [esi+11]
	test	al, al
	je	SHORT $L723
$L722:

; 275  : 		sync_dev(bh->b_dev);

	xor	eax, eax
	mov	ax, WORD PTR [esi+8]
	push	eax
	call	_sync_dev
	add	esp, 4

; 238  : 	struct buffer_head * tmp, * bh;

	cli

; 276  : 		wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L927
	lea	edi, DWORD PTR [esi+16]
$L926:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L926
$L927:

; 239  : 
; 240  : repeat:
; 241  : 	// ����hash �����ָ�����Ѿ��ڸ��ٻ����У��򷵻ض�Ӧ������ͷָ�룬�˳���

	sti

; 277  : 		if (bh->b_count)

	mov	al, BYTE PTR [esi+12]
	test	al, al
	jne	SHORT $L954
	mov	al, BYTE PTR [esi+11]
	test	al, al
	jne	SHORT $L722
$L723:

; 278  : 			goto repeat;
; 279  : 	}
; 280  : /* ע�⣡��������Ϊ�˵ȴ��û�����˯��ʱ���������̿����Ѿ����û���� */
; 281  : /* ��������ٻ����У�����Ҫ�Դ˽��м�顣 */
; 282  : // �ڸ��ٻ���hash ���м��ָ���豸�Ϳ�Ļ������Ƿ��Ѿ��������ȥ������ǵĻ������ٴ��ظ�
; 283  : // �������̡�
; 284  : 	if (find_buffer(dev,block))

	mov	ecx, DWORD PTR _block$[ebp]
	mov	ebx, DWORD PTR _dev$[ebp]
	push	ecx
	push	ebx
	call	_find_buffer
	add	esp, 8
	test	eax, eax
	je	SHORT $L725
	jmp	$L952
$L725:

; 285  : 		goto repeat;
; 286  : /* OK����������֪���û�������ָ��������Ψһһ�飬 */
; 287  : /* ���һ�û�б�ʹ��(b_count=0)��δ������(b_lock=0)�������Ǹɾ��ģ�δ���޸ĵģ� */
; 288  : // ����������ռ�ô˻������������ü���Ϊ1����λ�޸ı�־����Ч(����)��־��
; 289  : 	bh->b_count=1;
; 290  : 	bh->b_dirt=0;
; 291  : 	bh->b_uptodate=0;
; 292  : // ��hash ���кͿ��п��������Ƴ��û�����ͷ���øû���������ָ���豸�����ϵ�ָ���顣
; 293  : 	remove_from_queues(bh);

	mov	ecx, DWORD PTR [esi+24]
	mov	BYTE PTR [esi+12], 1
	test	ecx, ecx
	mov	BYTE PTR [esi+11], 0
	mov	BYTE PTR [esi+10], 0
	je	SHORT $L931
	mov	eax, DWORD PTR [esi+20]
	mov	DWORD PTR [ecx+20], eax
$L931:
	mov	eax, DWORD PTR [esi+20]
	test	eax, eax
	je	SHORT $L932
	mov	DWORD PTR [eax+24], ecx
$L932:
	mov	edi, DWORD PTR [esi+4]
	xor	eax, eax
	mov	ax, WORD PTR [esi+8]
	xor	edx, edx
	xor	eax, edi
	mov	edi, 307				; 00000133H
	div	edi
	lea	eax, DWORD PTR _hash_table[edx*4]
	mov	edx, DWORD PTR _hash_table[edx*4]
	cmp	edx, esi
	jne	SHORT $L933
	mov	DWORD PTR [eax], ecx
$L933:
	mov	edi, DWORD PTR [esi+28]
	test	edi, edi
	je	SHORT $L935
	mov	eax, DWORD PTR [esi+32]
	test	eax, eax
	jne	SHORT $L934
$L935:
	push	OFFSET FLAT:$SG671
	call	_panic
	add	esp, 4
$L934:
	mov	ecx, DWORD PTR [esi+32]
	mov	eax, DWORD PTR _free_list
	mov	DWORD PTR [edi+32], ecx
	mov	ecx, DWORD PTR [esi+32]
	cmp	eax, esi
	mov	DWORD PTR [ecx+28], edi
	jne	SHORT $L936
	mov	eax, ecx
	mov	DWORD PTR _free_list, eax
$L936:

; 294  : 	bh->b_dev=dev;
; 295  : 	bh->b_blocknr=block;
; 296  : // Ȼ����ݴ��µ��豸�źͿ�����²�����������hash ������λ�ô��������շ��ػ���ͷָ�롣
; 297  : 	insert_into_queues(bh);

	mov	edx, DWORD PTR [eax+28]
	mov	ecx, DWORD PTR _block$[ebp]
	mov	DWORD PTR [esi+28], edx
	mov	edx, DWORD PTR [eax+28]
	mov	DWORD PTR [esi+32], eax
	mov	DWORD PTR [eax+28], esi
	xor	eax, eax
	mov	WORD PTR [esi+8], bx
	cmp	bx, ax
	mov	DWORD PTR [esi+4], ecx
	mov	DWORD PTR [edx+32], esi
	mov	DWORD PTR [esi+20], eax
	mov	DWORD PTR [esi+24], eax
	je	SHORT $L949
	mov	eax, ebx
	xor	edx, edx
	and	eax, 65535				; 0000ffffH
	xor	eax, ecx
	mov	ecx, 307				; 00000133H
	div	ecx
	lea	eax, DWORD PTR _hash_table[edx*4]
	mov	edx, DWORD PTR _hash_table[edx*4]
	mov	DWORD PTR [eax], esi
	mov	eax, edx
	mov	DWORD PTR [esi+24], edx
	mov	DWORD PTR [eax+20], esi
$L949:

; 298  : 	return bh;

	mov	eax, esi
	pop	edi
	pop	esi
	pop	ebx

; 299  : }

	pop	ebp
	ret	0
_getblk	ENDP
_TEXT	ENDS
PUBLIC	_brelse
EXTRN	_wake_up:NEAR
_DATA	SEGMENT
	ORG $+2
$SG731	DB	'Trying to free free buffer', 00H
_DATA	ENDS
_TEXT	SEGMENT
_buf$ = 8
_brelse	PROC NEAR

; 304  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 305  : 	if (!buf)		// �������ͷָ����Ч�򷵻ء�

	mov	esi, DWORD PTR _buf$[ebp]
	test	esi, esi
	je	SHORT $L728
	cli

; 306  : 		return;
; 307  : 	wait_on_buffer(buf);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L961
	push	edi
	lea	edi, DWORD PTR [esi+16]
$L960:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L960
	pop	edi
$L961:

; 308  : 	if (!(buf->b_count--))

	sti
	mov	al, BYTE PTR [esi+12]
	mov	cl, al
	dec	cl
	test	al, al
	mov	BYTE PTR [esi+12], cl
	jne	SHORT $L730

; 309  : 		panic("Trying to free free buffer");

	push	OFFSET FLAT:$SG731
	call	_panic
	add	esp, 4
$L730:

; 310  : 	wake_up(&buffer_wait);

	push	OFFSET FLAT:_buffer_wait
	call	_wake_up
	add	esp, 4
$L728:
	pop	esi

; 311  : }

	pop	ebp
	ret	0
_brelse	ENDP
_TEXT	ENDS
PUBLIC	_bread
_DATA	SEGMENT
	ORG $+1
$SG739	DB	'bread: getblk returned NULL', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_block$ = 12
_bread	PROC NEAR

; 319  : {

	push	ebp
	mov	ebp, esp

; 321  : 
; 322  : // �ڸ��ٻ���������һ�黺�������������ֵ��NULL ָ�룬��ʾ�ں˳���������
; 323  : 	if (!(bh=getblk(dev,block)))

	mov	eax, DWORD PTR _block$[ebp]
	mov	ecx, DWORD PTR _dev$[ebp]
	push	esi
	push	eax
	push	ecx
	call	_getblk
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	jne	SHORT $L738

; 324  : 		panic("bread: getblk returned NULL\n");

	push	OFFSET FLAT:$SG739
	call	_panic
	add	esp, 4
$L738:

; 325  : // ����û������е���������Ч�ģ��Ѹ��µģ�����ֱ��ʹ�ã��򷵻ء�
; 326  : 	if (bh->b_uptodate)

	mov	al, BYTE PTR [esi+10]
	test	al, al
	je	SHORT $L740

; 327  : 		return bh;

	mov	eax, esi
	pop	esi

; 337  : }

	pop	ebp
	ret	0
$L740:

; 328  : // �������ll_rw_block()�������������豸�����󡣲��ȴ�������������
; 329  : 	ll_rw_block(READ,bh);

	push	esi
	push	0
	call	_ll_rw_block
	add	esp, 8

; 320  : 	struct buffer_head * bh;

	cli

; 330  : 	wait_on_buffer(bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L969
	push	edi
	lea	edi, DWORD PTR [esi+16]
$L968:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L968
	pop	edi
$L969:

; 321  : 
; 322  : // �ڸ��ٻ���������һ�黺�������������ֵ��NULL ָ�룬��ʾ�ں˳���������
; 323  : 	if (!(bh=getblk(dev,block)))

	sti

; 331  : // ����û������Ѹ��£��򷵻ػ�����ͷָ�룬�˳���
; 332  : 	if (bh->b_uptodate)

	mov	al, BYTE PTR [esi+10]
	test	al, al
	je	SHORT $L741

; 333  : 		return bh;

	mov	eax, esi
	pop	esi

; 337  : }

	pop	ebp
	ret	0
$L741:

; 334  : // ����������豸����ʧ�ܣ��ͷŸû�����������NULL ָ�룬�˳���
; 335  : 	brelse(bh);

	push	esi
	call	_brelse
	add	esp, 4

; 336  : 	return NULL;

	xor	eax, eax
	pop	esi

; 337  : }

	pop	ebp
	ret	0
_bread	ENDP
_TEXT	ENDS
PUBLIC	_COPYBLK
;	COMDAT _COPYBLK
_TEXT	SEGMENT
_from$ = 8
_to$ = 12
_COPYBLK PROC NEAR					; COMDAT

; 342  : {_asm{

	push	ebp
	mov	ebp, esp
	push	esi
	push	edi

; 343  : 	pushf

	pushf

; 344  : 	mov ecx,BLOCK_SIZE/4

	mov	ecx, 256				; 00000100H

; 345  : 	mov esi,from

	mov	esi, DWORD PTR _from$[ebp]

; 346  : 	mov edi,to

	mov	edi, DWORD PTR _to$[ebp]

; 347  : 	cld

	cld

; 348  : 	rep movsd

	rep	 movsd

; 349  : 	popf

	popf

; 350  : }}

	pop	edi
	pop	esi
	pop	ebp
	ret	0
_COPYBLK ENDP
_TEXT	ENDS
PUBLIC	_bread_page
_TEXT	SEGMENT
_address$ = 8
_dev$ = 12
_b$ = 16
_bh$ = -20
$T984 = 12
_bread_page PROC NEAR

; 364  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 20					; 00000014H
	push	ebx

; 369  : 	for (i=0 ; i<4 ; i++)

	mov	ebx, DWORD PTR _dev$[ebp]
	push	esi
	push	edi

; 372  : 			if (bh[i] = getblk(dev,b[i]))
; 373  : 				if (!bh[i]->b_uptodate)
; 374  : 					ll_rw_block(READ,bh[i]);
; 375  : 		} else
; 376  : 			bh[i] = NULL;

	mov	edi, DWORD PTR _b$[ebp]
	lea	eax, DWORD PTR _bh$[ebp]
	lea	esi, DWORD PTR _bh$[ebp]
	sub	edi, eax
	mov	DWORD PTR 16+[ebp], 4
$L757:
	mov	eax, DWORD PTR [edi+esi]
	test	eax, eax
	je	SHORT $L760
	push	eax
	push	ebx
	call	_getblk
	add	esp, 8
	mov	DWORD PTR [esi], eax
	test	eax, eax
	je	SHORT $L758
	mov	cl, BYTE PTR [eax+10]
	test	cl, cl
	jne	SHORT $L758
	push	eax
	push	0
	call	_ll_rw_block
	add	esp, 8
	jmp	SHORT $L758
$L760:
	mov	DWORD PTR [esi], 0
$L758:

; 369  : 	for (i=0 ; i<4 ; i++)

	mov	eax, DWORD PTR 16+[ebp]
	add	esi, 4
	dec	eax
	mov	DWORD PTR 16+[ebp], eax
	jne	SHORT $L757

; 377  : // ��4 �黺�����ϵ�����˳���Ƶ�ָ����ַ����
; 378  : 	for (i=0 ; i<4 ; i++,address += BLOCK_SIZE)

	lea	ecx, DWORD PTR _bh$[ebp]
	mov	DWORD PTR -4+[ebp], 4
	mov	DWORD PTR 16+[ebp], ecx
$L764:

; 379  : 		if (bh[i]) {

	mov	edx, DWORD PTR 16+[ebp]
	mov	ebx, DWORD PTR [edx]
	test	ebx, ebx
	je	SHORT $L765

; 365  : 	struct buffer_head * bh[4];

	cli

; 380  : 			wait_on_buffer(bh[i]);	// �ȴ�����������(����ѱ������Ļ�)��

	mov	al, BYTE PTR [ebx+13]
	test	al, al
	je	SHORT $L978
	lea	esi, DWORD PTR [ebx+16]
$L977:
	push	esi
	call	_sleep_on
	mov	al, BYTE PTR [ebx+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L977
$L978:

; 368  : // ѭ��ִ��4 �Σ���һҳ���ݡ�

	sti

; 381  : 			if (bh[i]->b_uptodate)	// ����û�������������Ч�Ļ������ơ�

	mov	al, BYTE PTR [ebx+10]
	test	al, al
	je	SHORT $L982

; 382  : 				COPYBLK(bh[i]->b_data,(char *)address);

	mov	eax, DWORD PTR [ebx]
	mov	DWORD PTR $T984[ebp], eax

; 365  : 	struct buffer_head * bh[4];

	pushf

; 366  : 	int i;

	mov	ecx, 256				; 00000100H

; 367  : 

	mov	esi, DWORD PTR $T984[ebp]

; 368  : // ѭ��ִ��4 �Σ���һҳ���ݡ�

	mov	edi, DWORD PTR _address$[ebp]

; 369  : 	for (i=0 ; i<4 ; i++)

	cld

; 370  : 		if (b[i]) {

	rep	 movsd

; 371  : // ȡ���ٻ�����ָ���豸�Ϳ�ŵĻ�����������û�����������Ч��������豸����

	popf

; 382  : 				COPYBLK(bh[i]->b_data,(char *)address);

$L982:

; 383  : 			brelse(bh[i]);		// �ͷŸû�������

	push	ebx
	call	_brelse
	add	esp, 4
$L765:
	mov	edx, DWORD PTR 16+[ebp]
	mov	ecx, DWORD PTR _address$[ebp]
	mov	eax, DWORD PTR -4+[ebp]
	add	edx, 4
	add	ecx, 1024				; 00000400H
	dec	eax
	mov	DWORD PTR 16+[ebp], edx
	mov	DWORD PTR _address$[ebp], ecx
	mov	DWORD PTR -4+[ebp], eax
	jne	SHORT $L764

; 384  : 		}
; 385  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_bread_page ENDP
_TEXT	ENDS
PUBLIC	_breada
_DATA	SEGMENT
	ORG $+3
$SG783	DB	'bread: getblk returned NULL', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_dev$ = 8
_first$ = 12
_breada	PROC NEAR

; 394  : {

	push	ebp
	mov	ebp, esp

; 399  : 	va_start(args,first);
; 400  : // ȡ���ٻ�����ָ���豸�Ϳ�ŵĻ�����������û�����������Ч���򷢳����豸���ݿ�����
; 401  : 	if (!(bh=getblk(dev,first)))

	mov	eax, DWORD PTR _first$[ebp]
	mov	ecx, DWORD PTR _dev$[ebp]
	push	edi
	push	eax
	push	ecx
	call	_getblk
	mov	edi, eax
	add	esp, 8
	test	edi, edi
	jne	SHORT $L782

; 402  : 		panic("bread: getblk returned NULL\n");

	push	OFFSET FLAT:$SG783
	call	_panic
	add	esp, 4
$L782:

; 403  : 	if (!bh->b_uptodate)

	mov	al, BYTE PTR [edi+10]
	test	al, al
	jne	SHORT $L998

; 404  : 		ll_rw_block(READ,bh);

	push	edi
	push	0
	call	_ll_rw_block
	add	esp, 8
$L998:

; 405  : // Ȼ��˳��ȡ�ɱ������������Ԥ����ţ�����������ͬ�������������á�
; 406  : 	while ((first=va_arg(args,int))>=0) {

	mov	eax, DWORD PTR _first$[ebp+4]
	push	esi
	test	eax, eax
	mov	DWORD PTR _first$[ebp], eax
	jl	SHORT $L796
	push	ebx
	lea	ebx, DWORD PTR _first$[ebp+4]
$L795:

; 407  : 		tmp=getblk(dev,first);

	mov	edx, DWORD PTR _dev$[ebp]
	push	eax
	push	edx
	call	_getblk
	mov	esi, eax
	add	esp, 8

; 408  : 		if (tmp) {

	test	esi, esi
	je	SHORT $L797

; 409  : 			if (!tmp->b_uptodate)

	mov	al, BYTE PTR [esi+10]
	test	al, al
	jne	SHORT $L798

; 410  : 				ll_rw_block(READA,bh);

	push	edi
	push	2
	call	_ll_rw_block
	add	esp, 8
$L798:

; 411  : 			tmp->b_count--;

	dec	BYTE PTR [esi+12]
$L797:
	mov	eax, DWORD PTR [ebx+4]
	add	ebx, 4
	test	eax, eax
	mov	DWORD PTR _first$[ebp], eax
	jge	SHORT $L795
	pop	ebx
$L796:

; 395  : 	va_list args;

	cli

; 412  : 		}
; 413  : 	}
; 414  : // �ɱ�����������в���������ϡ��ȴ���1 ������������������ѱ���������
; 415  : 	va_end(args);
; 416  : 	wait_on_buffer(bh);

	mov	al, BYTE PTR [edi+13]
	test	al, al
	je	SHORT $L996
	lea	esi, DWORD PTR [edi+16]
$L995:
	push	esi
	call	_sleep_on
	mov	al, BYTE PTR [edi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L995
$L996:

; 396  : 	struct buffer_head * bh, *tmp;
; 397  : 
; 398  : // ȡ�ɱ�������е�1 ����������ţ���

	sti

; 417  : // �����������������Ч���򷵻ػ�����ͷָ�룬�˳��������ͷŸû�����������NULL���˳���
; 418  : 	if (bh->b_uptodate)

	mov	al, BYTE PTR [edi+10]
	pop	esi
	test	al, al
	je	SHORT $L799

; 419  : 		return bh;

	mov	eax, edi
	pop	edi

; 422  : }

	pop	ebp
	ret	0
$L799:

; 420  : 	brelse(bh);

	push	edi
	call	_brelse
	add	esp, 4

; 421  : 	return (NULL);

	xor	eax, eax
	pop	edi

; 422  : }

	pop	ebp
	ret	0
_breada	ENDP
_TEXT	ENDS
PUBLIC	_buffer_init
_TEXT	SEGMENT
_buffer_end$ = 8
_buffer_init PROC NEAR

; 428  : {

	push	ebp
	mov	ebp, esp

; 429  : 	struct buffer_head * h = start_buffer;
; 430  : 	void * b;
; 431  : 	int i;
; 432  : 
; 433  : // ����������߶˵���1Mb�������ڴ�640KB-1MB ����ʾ�ڴ��BIOS ռ�ã����ʵ�ʿ��û������ڴ�
; 434  : // �߶�Ӧ����640KB�������ڴ�߶�һ������1MB��
; 435  : 	if (buffer_end == 1<<20)

	mov	ecx, DWORD PTR _buffer_end$[ebp]
	mov	eax, DWORD PTR _start_buffer
	cmp	ecx, 1048576				; 00100000H
	jne	SHORT $L1003

; 436  : 		b = (void *) (640*1024);

	mov	ecx, 655360				; 000a0000H
$L1003:

; 437  : 	else
; 438  : 		b = (void *) buffer_end;
; 439  : // ��δ������ڳ�ʼ�����������������л���������������ȡϵͳ�л�������Ŀ��
; 440  : // �����Ĺ����Ǵӻ������߶˿�ʼ����1K ��С�Ļ���飬���ͬʱ�ڻ������Ͷ˽��������û����
; 441  : // �Ľṹbuffer_head��������Щbuffer_head ���˫������
; 442  : // h ��ָ�򻺳�ͷ�ṹ��ָ�룬��h+1 ��ָ���ڴ��ַ��������һ������ͷ��ַ��Ҳ����˵��ָ��h
; 443  : // ����ͷ��ĩ���⡣Ϊ�˱�֤���㹻���ȵ��ڴ����洢һ������ͷ�ṹ����Ҫb ��ָ����ڴ��
; 444  : // ��ַ>= h ����ͷ��ĩ�ˣ�Ҳ��Ҫ>=h+1��
; 445  : 	while ( (b = (char*)b - BLOCK_SIZE) >= ((void *) (h+1)) ) {

	sub	ecx, 1024				; 00000400H
	lea	edx, DWORD PTR [eax+36]
	cmp	ecx, edx
	push	edi
	jb	SHORT $L814
	push	ebx
	push	esi
	mov	esi, DWORD PTR _nr_buffers
	xor	ebx, ebx
$L813:
	lea	edi, DWORD PTR [eax-36]

; 446  : 		h->b_dev = 0;			// ʹ�øû��������豸�š�
; 447  : 		h->b_dirt = 0;			// ���־��Ҳ���������޸ı�־��
; 448  : 		h->b_count = 0;			// �û��������ü�����
; 449  : 		h->b_lock = 0;			// ������������־��
; 450  : 		h->b_uptodate = 0;		// ���������±�־�����������Ч��־����
; 451  : 		h->b_wait = NULL;		// ָ��ȴ��û����������Ľ��̡�
; 452  : 		h->b_next = NULL;		// ָ�������ͬhash ֵ����һ������ͷ��
; 453  : 		h->b_prev = NULL;		// ָ�������ͬhash ֵ��ǰһ������ͷ��
; 454  : 		h->b_data = (char *) b;	// ָ���Ӧ���������ݿ飨1024 �ֽڣ���
; 455  : 		h->b_prev_free = h-1;	// ָ��������ǰһ�
; 456  : 		h->b_next_free = h+1;	// ָ����������һ�
; 457  : 		h++;					// h ָ����һ�»���ͷλ�á�
; 458  : 		NR_BUFFERS++;			// �����������ۼӡ�

	inc	esi
	mov	WORD PTR [eax+8], bx
	mov	BYTE PTR [eax+11], bl
	mov	BYTE PTR [eax+12], bl
	mov	BYTE PTR [eax+13], bl
	mov	BYTE PTR [eax+10], bl
	mov	DWORD PTR [eax+16], ebx
	mov	DWORD PTR [eax+24], ebx
	mov	DWORD PTR [eax+20], ebx
	mov	DWORD PTR [eax], ecx
	mov	DWORD PTR [eax+28], edi
	mov	DWORD PTR [eax+32], edx

; 459  : 		if (b == (void *) 0x100000)		// �����ַb �ݼ�������1MB��������384KB��

	cmp	ecx, 1048576				; 00100000H
	mov	eax, edx
	jne	SHORT $L817

; 460  : 			b = (void *) 0xA0000;		// ��b ָ���ַ0xA0000(640KB)����

	mov	ecx, 655360				; 000a0000H
$L817:

; 437  : 	else
; 438  : 		b = (void *) buffer_end;
; 439  : // ��δ������ڳ�ʼ�����������������л���������������ȡϵͳ�л�������Ŀ��
; 440  : // �����Ĺ����Ǵӻ������߶˿�ʼ����1K ��С�Ļ���飬���ͬʱ�ڻ������Ͷ˽��������û����
; 441  : // �Ľṹbuffer_head��������Щbuffer_head ���˫������
; 442  : // h ��ָ�򻺳�ͷ�ṹ��ָ�룬��h+1 ��ָ���ڴ��ַ��������һ������ͷ��ַ��Ҳ����˵��ָ��h
; 443  : // ����ͷ��ĩ���⡣Ϊ�˱�֤���㹻���ȵ��ڴ����洢һ������ͷ�ṹ����Ҫb ��ָ����ڴ��
; 444  : // ��ַ>= h ����ͷ��ĩ�ˣ�Ҳ��Ҫ>=h+1��
; 445  : 	while ( (b = (char*)b - BLOCK_SIZE) >= ((void *) (h+1)) ) {

	sub	ecx, 1024				; 00000400H
	lea	edx, DWORD PTR [eax+36]
	cmp	ecx, edx
	jae	SHORT $L813

; 446  : 		h->b_dev = 0;			// ʹ�øû��������豸�š�
; 447  : 		h->b_dirt = 0;			// ���־��Ҳ���������޸ı�־��
; 448  : 		h->b_count = 0;			// �û��������ü�����
; 449  : 		h->b_lock = 0;			// ������������־��
; 450  : 		h->b_uptodate = 0;		// ���������±�־�����������Ч��־����
; 451  : 		h->b_wait = NULL;		// ָ��ȴ��û����������Ľ��̡�
; 452  : 		h->b_next = NULL;		// ָ�������ͬhash ֵ����һ������ͷ��
; 453  : 		h->b_prev = NULL;		// ָ�������ͬhash ֵ��ǰһ������ͷ��
; 454  : 		h->b_data = (char *) b;	// ָ���Ӧ���������ݿ飨1024 �ֽڣ���
; 455  : 		h->b_prev_free = h-1;	// ָ��������ǰһ�
; 456  : 		h->b_next_free = h+1;	// ָ����������һ�
; 457  : 		h++;					// h ָ����һ�»���ͷλ�á�
; 458  : 		NR_BUFFERS++;			// �����������ۼӡ�

	mov	DWORD PTR _nr_buffers, esi
	pop	esi
	pop	ebx
$L814:

; 461  : 	}
; 462  : 	h--;			// ��h ָ�����һ����Ч����ͷ��
; 463  : 	free_list = start_buffer;		// �ÿ�������ͷָ��ͷһ��������ͷ��

	mov	ecx, DWORD PTR _start_buffer
	sub	eax, 36					; 00000024H
	mov	DWORD PTR _free_list, ecx

; 464  : 	free_list->b_prev_free = h;		// ����ͷ��b_prev_free ָ��ǰһ������һ���
; 465  : 	h->b_next_free = free_list;		// h ����һ��ָ��ָ���һ��γ�һ��������
; 466  : 	// ��ʼ��hash ����ϣ��ɢ�б����ñ������е�ָ��ΪNULL��
; 467  : 	for (i=0;i<NR_HASH;i++)
; 468  : 		hash_table[i]=NULL;

	mov	edi, OFFSET FLAT:_hash_table
	mov	DWORD PTR [ecx+28], eax
	mov	DWORD PTR [eax+32], ecx
	mov	ecx, 307				; 00000133H
	xor	eax, eax
	rep stosd
	pop	edi

; 469  : }	

	pop	ebp
	ret	0
_buffer_init ENDP
_TEXT	ENDS
END
