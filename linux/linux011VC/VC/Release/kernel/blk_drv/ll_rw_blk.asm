	TITLE	..\kernel\blk_drv\ll_rw_blk.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_blk_dev
PUBLIC	_request
PUBLIC	_wait_for_request
_BSS	SEGMENT
_blk_dev DQ	07H DUP (?)
_request DB	0480H DUP (?)
_wait_for_request DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
$SG600	DB	'll_rw_block.c: buffer not locked', 0aH, 0dH, 00H
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

	je	SHORT $l1$501

; 278  : 		xchg ecx,current/* current = task[n]�� */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*ִ�г���ת����������л� (ͷ���˺ܳ�ʱ�䣬������)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$502, ax

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
$lcs$502:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // �������л�������Ż����ִ���������䡣
; 290  : 		cmp last_task_used_math,ecx /* �������ϴ�ʹ�ù�Э��������*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$501

; 292  : 		clts/* �������ϴ�ʹ�ù�Э������������cr0 ��TS ��־��*/

	clts
$l1$501:

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
PUBLIC	_ll_rw_block
EXTRN	_printk:NEAR
_DATA	SEGMENT
	ORG $+1
$SG658	DB	'Trying to read nonexistent block-device', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_rw$ = 8
_bh$ = 12
_ll_rw_block PROC NEAR

; 196  : {

	push	ebp
	mov	ebp, esp

; 197  : 	unsigned int major;		// ���豸�ţ�����Ӳ����3����
; 198  : 
; 199  : // ����豸�����豸�Ų����ڻ��߸��豸�Ķ�д�������������ڣ�����ʾ������Ϣ�������ء�
; 200  : 	if ((major = MAJOR (bh->b_dev)) >= NR_BLK_DEV ||
; 201  : 		!(blk_dev[major].request_fn))

	mov	ecx, DWORD PTR _bh$[ebp]
	xor	eax, eax
	mov	ax, WORD PTR [ecx+8]
	shr	eax, 8
	cmp	eax, 7
	jae	SHORT $L657
	mov	edx, DWORD PTR _blk_dev[eax*8]
	test	edx, edx
	je	SHORT $L657

; 204  : 		return;
; 205  : 	}
; 206  : 	make_request (major, rw, bh);	// �������������������С�

	push	ecx
	mov	ecx, DWORD PTR _rw$[ebp]
	push	ecx
	push	eax
	call	_make_request
	add	esp, 12					; 0000000cH

; 207  : }

	pop	ebp
	ret	0
$L657:

; 202  : 	{
; 203  : 		printk ("Trying to read nonexistent block-device\n\r");

	push	OFFSET FLAT:$SG658
	call	_printk
	add	esp, 4

; 207  : }

	pop	ebp
	ret	0
_ll_rw_block ENDP
_TEXT	ENDS
EXTRN	_panic:NEAR
EXTRN	_sleep_on:NEAR
EXTRN	_wake_up:NEAR
_DATA	SEGMENT
	ORG $+2
$SG636	DB	'Bad block dev command, must be R/W/RA/WA', 00H
_DATA	ENDS
_TEXT	SEGMENT
_major$ = 8
_rw$ = 12
_bh$ = 16
_rw_ahead$ = 12
_make_request PROC NEAR

; 120  : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 126  : // ����'READ'��'WRITE'�����'A'�ַ�����Ӣ�ĵ���Ahead����ʾ��ǰԤ��/д���ݿ����˼��
; 127  : // ��ָ���Ļ���������ʹ�ã��ѱ�����ʱ���ͷ���Ԥ��/д����
; 128  : 	if (rw_ahead = (rw == READA || rw == WRITEA))

	mov	ebx, DWORD PTR _rw$[ebp]
	push	esi
	mov	esi, DWORD PTR _bh$[ebp]
	cmp	ebx, 2
	je	SHORT $L680
	cmp	ebx, 3
	je	SHORT $L680

; 133  : 			rw = READ;
; 134  : 		else
; 135  : 			rw = WRITE;
; 136  : 	}
; 137  : // ��������READ ��WRITE ���ʾ�ں˳����д���ʾ������Ϣ��������
; 138  : 	if (rw != READ && rw != WRITE)

	test	ebx, ebx
	mov	DWORD PTR _rw_ahead$[ebp], 0
	je	SHORT $L635
	cmp	ebx, 1
	je	SHORT $L635

; 139  : 		panic ("Bad block dev command, must be R/W/RA/WA");

	push	OFFSET FLAT:$SG636
	call	_panic
	add	esp, 4
$L635:

; 121  : 	struct request *req;

	cli

; 140  : // ����������������������Ѿ���������ǰ���񣨽��̣��ͻ�˯�ߣ�ֱ������ȷ�ػ��ѡ�
; 141  : 	lock_buffer (bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	je	SHORT $L685
	push	edi
	lea	edi, DWORD PTR [esi+16]
$L684:
	push	edi
	call	_sleep_on
	mov	al, BYTE PTR [esi+13]
	add	esp, 4
	test	al, al
	jne	SHORT $L684
	pop	edi
$L685:
	mov	BYTE PTR [esi+13], 1

; 122  : 	int rw_ahead;
; 123  : 
; 124  : /* WRITEA/READA ���������� - ���ǲ����Ǳ�Ҫ�ģ���������������Ѿ�������*/
; 125  : /* ���ǾͲ��������˳�������Ļ���ִ��һ��Ķ�/д������ */

	sti

; 142  : // ���������д���һ��������ݲ��࣬���������Ƕ����һ����������Ǹ��¹��ģ��������
; 143  : // ������󡣽��������������˳���
; 144  : 	if ((rw == WRITE && !bh->b_dirt) || (rw == READ && bh->b_uptodate))

	cmp	ebx, 1
	jne	SHORT $L639
	mov	al, BYTE PTR [esi+11]
	test	al, al
	je	SHORT $L638
	jmp	SHORT $repeat$640
$L680:

; 129  : 	{
; 130  : 		if (bh->b_lock)

	mov	al, BYTE PTR [esi+13]
	mov	DWORD PTR _rw_ahead$[ebp], 1
	test	al, al
	jne	$L628

; 131  : 			return;
; 132  : 		if (rw == READA)

	xor	eax, eax
	cmp	ebx, 2
	setne	al
	mov	ebx, eax

; 133  : 			rw = READ;
; 134  : 		else
; 135  : 			rw = WRITE;
; 136  : 	}
; 137  : // ��������READ ��WRITE ���ʾ�ں˳����д���ʾ������Ϣ��������
; 138  : 	if (rw != READ && rw != WRITE)

	jmp	SHORT $L635
$L639:

; 142  : // ���������д���һ��������ݲ��࣬���������Ƕ����һ����������Ǹ��¹��ģ��������
; 143  : // ������󡣽��������������˳���
; 144  : 	if ((rw == WRITE && !bh->b_dirt) || (rw == READ && bh->b_uptodate))

	test	ebx, ebx
	jne	SHORT $repeat$640
	mov	al, BYTE PTR [esi+10]
	test	al, al
	je	SHORT $repeat$640
$L638:

; 145  : 	{
; 146  : 		unlock_buffer (bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L689
	push	OFFSET FLAT:$SG600
	call	_printk
	add	esp, 4
$L689:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
	pop	esi
	pop	ebx

; 190  : }

	pop	ebp
	ret	0
$repeat$640:

; 147  : 		return;
; 148  : 	}
; 149  : repeat:
; 150  : /* ���ǲ����ö�����ȫ����д�����������ҪΪ��������һЩ�ռ䣺������
; 151  : * �����ȵġ�������еĺ�����֮һ�ռ���Ϊ��׼���ġ�
; 152  : */
; 153  : // �������Ǵ���������ĩβ��ʼ������������ġ���������Ҫ�󣬶��ڶ��������󣬿���ֱ��
; 154  : // �Ӷ���ĩβ��ʼ��������д������ֻ�ܴӶ��е�2/3 ����ͷ�������������롣
; 155  : 	if (rw == READ)

	xor	ecx, ecx

; 156  : 		req = request + NR_REQUEST;	// ���ڶ����󣬽�����ָ��ָ�����β����

	mov	eax, OFFSET FLAT:_request+1152
	cmp	ebx, ecx
	je	SHORT $L697

; 157  : 	else
; 158  : 		req = request + ((NR_REQUEST * 2) / 3);	// ����д���󣬶���ָ��ָ�����2/3 ����

	mov	eax, OFFSET FLAT:_request+756
$L697:

; 159  : /* ����һ���������� */
; 160  : // �Ӻ���ǰ������������ṹrequest ��dev �ֶ�ֵ=-1 ʱ����ʾ����δ��ռ�á�
; 161  : 	while (--req >= request)

	sub	eax, 36					; 00000024H
	cmp	eax, OFFSET FLAT:_request
	jb	SHORT $L703
$L644:

; 162  : 		if (req->dev < 0)

	cmp	DWORD PTR [eax], ecx
	jl	SHORT $L698
	sub	eax, 36					; 00000024H
	cmp	eax, OFFSET FLAT:_request
	jae	SHORT $L644

; 163  : 			break;
; 164  : /* ���û���ҵ���������øô�������˯�ߣ������Ƿ���ǰ��/д */
; 165  : // ���û��һ���ǿ��еģ���ʱrequest ����ָ���Ѿ�����Խ��ͷ��������鿴�˴������Ƿ���
; 166  : // ��ǰ��/д��READA ��WRITEA���������������˴����󡣷����ñ�������˯�ߣ��ȴ��������
; 167  : // �ڳ��������һ����������������С�
; 168  : 	if (req < request)

	jmp	SHORT $L703
$L698:
	cmp	eax, OFFSET FLAT:_request
	jae	SHORT $L647
$L703:

; 169  : 	{				// ������������û�п����
; 170  : 		if (rw_ahead)

	cmp	DWORD PTR _rw_ahead$[ebp], ecx
	jne	SHORT $L699

; 173  : 			return;
; 174  : 		}
; 175  : 		sleep_on (&wait_for_request);	// �����ñ�������˯�ߣ������ٲ鿴������С�

	push	OFFSET FLAT:_wait_for_request
	call	_sleep_on
	add	esp, 4

; 176  : 		goto repeat;

	jmp	SHORT $repeat$640
$L699:

; 171  : 		{			// �������ǰ��/д������������������˳���
; 172  : 			unlock_buffer (bh);

	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L693
	push	OFFSET FLAT:$SG600
	call	_printk
	add	esp, 4
$L693:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
	pop	esi
	pop	ebx

; 190  : }

	pop	ebp
	ret	0
$L647:

; 177  : 	}
; 178  : /* ���������������д������Ϣ���������������� */
; 179  : // ����ṹ�μ���kernel/blk_drv/blk.h,23����
; 180  : 	req->dev = bh->b_dev;		// �豸�š�

	xor	edx, edx

; 181  : 	req->cmd = rw;		// ����(READ/WRITE)��
; 182  : 	req->errors = 0;		// ����ʱ�����Ĵ��������
; 183  : 	req->sector = bh->b_blocknr << 1;	// ��ʼ������(1 ��=2 ����)
; 184  : 	req->nr_sectors = 2;		// ��д��������
; 185  : 	req->buffer = bh->b_data;	// ���ݻ�������
; 186  : 	req->waiting = NULL;		// ����ȴ�����ִ����ɵĵط���
; 187  : 	req->bh = bh;			// ������ͷָ�롣
; 188  : 	req->next = NULL;		// ָ����һ�����
; 189  : 	add_request (major + blk_dev, req);	// ����������������(blk_dev[major],req)��

	push	eax
	mov	dx, WORD PTR [esi+8]
	mov	DWORD PTR [eax], edx
	mov	edx, DWORD PTR [esi+4]
	mov	DWORD PTR [eax+4], ebx
	mov	DWORD PTR [eax+8], ecx
	shl	edx, 1
	mov	DWORD PTR [eax+12], edx
	mov	edx, DWORD PTR [esi]
	mov	DWORD PTR [eax+16], 2
	mov	DWORD PTR [eax+20], edx
	mov	DWORD PTR [eax+24], ecx
	mov	DWORD PTR [eax+28], esi
	mov	DWORD PTR [eax+32], ecx
	mov	eax, DWORD PTR _major$[ebp]
	lea	ecx, DWORD PTR _blk_dev[eax*8]
	push	ecx
	call	_add_request
	add	esp, 8
$L628:
	pop	esi
	pop	ebx

; 190  : }

	pop	ebp
	ret	0
_make_request ENDP
_dev$ = 8
_req$ = 12
_add_request PROC NEAR

; 90   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 91   : 	struct request *tmp;
; 92   : 
; 93   : 	req->next = NULL;

	mov	ebx, DWORD PTR _req$[ebp]
	mov	DWORD PTR [ebx+32], 0

; 94   : 	cli ();			// ���жϡ�

	cli

; 95   : 	if (req->bh)

	mov	eax, DWORD PTR [ebx+28]
	test	eax, eax
	je	SHORT $L608

; 96   : 		req->bh->b_dirt = 0;	// �建�������ࡱ��־��

	mov	BYTE PTR [eax+11], 0
$L608:

; 97   : // ���dev �ĵ�ǰ����(current_request)�Ӷ�Ϊ�գ����ʾĿǰ���豸û������������ǵ�1 ��
; 98   : // �������˿ɽ����豸��ǰ����ָ��ֱ��ָ�������������ִ����Ӧ�豸����������
; 99   : 	if (!(tmp = dev->current_request))

	mov	eax, DWORD PTR _dev$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	test	ecx, ecx
	jne	SHORT $L609

; 100  : 	{
; 101  : 		dev->current_request = req;

	mov	DWORD PTR [eax+4], ebx

; 102  : 		sti ();			// ���жϡ�

	sti

; 103  : 		(dev->request_fn) ();	// ִ���豸������������Ӳ��(3)��do_hd_request()��

	call	DWORD PTR [eax]
	pop	ebx

; 115  : }

	pop	ebp
	ret	0
$L609:

; 104  : 		return;
; 105  : 	}
; 106  : // ���Ŀǰ���豸�Ѿ����������ڵȴ������������õ����㷨�������λ�ã�Ȼ�󽫵�ǰ�������
; 107  : // ���������С�
; 108  : 	for (; tmp->next; tmp = tmp->next)

	mov	eax, DWORD PTR [ecx+32]
	push	esi
	test	eax, eax
	push	edi
	je	SHORT $L711
$L610:

; 109  : 	if ((IN_ORDER (tmp, req) ||
; 110  : 		!IN_ORDER (tmp, tmp->next)) && IN_ORDER (req, tmp->next))

	mov	edi, DWORD PTR [ecx+4]
	mov	edx, DWORD PTR [ebx+4]
	cmp	edi, edx
	jl	SHORT $L618
	jne	SHORT $L616
	mov	edx, DWORD PTR [ecx]
	mov	esi, DWORD PTR [ebx]
	cmp	edx, esi
	jl	SHORT $L618
	jne	SHORT $L616
	mov	edx, DWORD PTR [ecx+12]
	mov	esi, DWORD PTR [ebx+12]
	cmp	edx, esi
	jb	SHORT $L618
$L616:
	mov	edx, DWORD PTR [eax+4]
	cmp	edi, edx
	jl	SHORT $L611
	jne	SHORT $L618
	mov	edx, DWORD PTR [ecx]
	mov	esi, DWORD PTR [eax]
	cmp	edx, esi
	jl	SHORT $L611
	jne	SHORT $L618
	mov	edx, DWORD PTR [ecx+12]
	mov	esi, DWORD PTR [eax+12]
	cmp	edx, esi
	jb	SHORT $L611
$L618:
	mov	edx, DWORD PTR [eax+4]
	mov	esi, DWORD PTR [ebx+4]
	cmp	esi, edx
	jl	SHORT $L711
	jne	SHORT $L611
	mov	edx, DWORD PTR [ebx]
	mov	esi, DWORD PTR [eax]
	cmp	edx, esi
	jl	SHORT $L711
	jne	SHORT $L611
	mov	edx, DWORD PTR [ebx+12]
	mov	esi, DWORD PTR [eax+12]
	cmp	edx, esi
	jb	SHORT $L711
$L611:

; 104  : 		return;
; 105  : 	}
; 106  : // ���Ŀǰ���豸�Ѿ����������ڵȴ������������õ����㷨�������λ�ã�Ȼ�󽫵�ǰ�������
; 107  : // ���������С�
; 108  : 	for (; tmp->next; tmp = tmp->next)

	mov	ecx, eax
	mov	eax, DWORD PTR [ecx+32]
	test	eax, eax
	jne	SHORT $L610
$L711:

; 111  : 		break;
; 112  : 	req->next = tmp->next;

	mov	eax, DWORD PTR [ecx+32]
	mov	DWORD PTR [ebx+32], eax

; 113  : 	tmp->next = req;

	mov	DWORD PTR [ecx+32], ebx

; 114  : 	sti ();

	sti

; 113  : 	tmp->next = req;

	pop	edi
	pop	esi
	pop	ebx

; 115  : }

	pop	ebp
	ret	0
_add_request ENDP
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
PUBLIC	_blk_dev_init
_TEXT	SEGMENT
_blk_dev_init PROC NEAR

; 213  : 	int i;
; 214  : 
; 215  : 	for (i = 0; i < NR_REQUEST; i++)

	mov	eax, OFFSET FLAT:_request+32
	or	ecx, -1
$L663:

; 216  : 	{
; 217  : 		request[i].dev = -1;

	mov	DWORD PTR [eax-32], ecx

; 218  : 		request[i].next = NULL;

	mov	DWORD PTR [eax], 0
	add	eax, 36					; 00000024H
	cmp	eax, OFFSET FLAT:_request+1184
	jl	SHORT $L663

; 219  : 	}
; 220  : }

	ret	0
_blk_dev_init ENDP
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
