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

; 276  : 		cmp ecx, current/* 任务n 是当前任务吗?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* 是，则什么都不做，退出。*/ 

	je	SHORT $l1$501

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
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

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$501

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

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

; 325  : 	_asm mov word ptr [ebx+2],dx // 基址base 低16 位(位15-0)->[addr+2]。

	mov	WORD PTR [ebx+2], dx

; 326  : 	_asm ror edx,16 // edx 中基址高16 位(位31-16) -> dx。 

	ror	edx, 16					; 00000010H

; 327  : 	_asm mov byte ptr [ebx+4],dl // 基址高16 位中的低8 位(位23-16)->[addr+4]。

	mov	BYTE PTR [ebx+4], dl

; 328  : 	_asm mov byte ptr [ebx+7],dh // 基址高16 位中的高8 位(位31-24)->[addr+7]。

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

; 197  : 	unsigned int major;		// 主设备号（对于硬盘是3）。
; 198  : 
; 199  : // 如果设备的主设备号不存在或者该设备的读写操作函数不存在，则显示出错信息，并返回。
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
; 206  : 	make_request (major, rw, bh);	// 创建请求项并插入请求队列。

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

; 126  : // 这里'READ'和'WRITE'后面的'A'字符代表英文单词Ahead，表示提前预读/写数据块的意思。
; 127  : // 当指定的缓冲区正在使用，已被上锁时，就放弃预读/写请求。
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
; 137  : // 如果命令不是READ 或WRITE 则表示内核程序有错，显示出错信息并死机。
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

; 140  : // 锁定缓冲区，如果缓冲区已经上锁，则当前任务（进程）就会睡眠，直到被明确地唤醒。
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
; 124  : /* WRITEA/READA 是特殊的情况 - 它们并不是必要的，所以如果缓冲区已经上锁，*/
; 125  : /* 我们就不管它而退出，否则的话就执行一般的读/写操作。 */

	sti

; 142  : // 如果命令是写并且缓冲区数据不脏，或者命令是读并且缓冲区数据是更新过的，则不用添加
; 143  : // 这个请求。将缓冲区解锁并退出。
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
; 137  : // 如果命令不是READ 或WRITE 则表示内核程序有错，显示出错信息并死机。
; 138  : 	if (rw != READ && rw != WRITE)

	jmp	SHORT $L635
$L639:

; 142  : // 如果命令是写并且缓冲区数据不脏，或者命令是读并且缓冲区数据是更新过的，则不用添加
; 143  : // 这个请求。将缓冲区解锁并退出。
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
; 150  : /* 我们不能让队列中全都是写请求项：我们需要为读请求保留一些空间：读操作
; 151  : * 是优先的。请求队列的后三分之一空间是为读准备的。
; 152  : */
; 153  : // 请求项是从请求数组末尾开始搜索空项填入的。根据上述要求，对于读命令请求，可以直接
; 154  : // 从队列末尾开始操作，而写请求则只能从队列的2/3 处向头上搜索空项填入。
; 155  : 	if (rw == READ)

	xor	ecx, ecx

; 156  : 		req = request + NR_REQUEST;	// 对于读请求，将队列指针指向队列尾部。

	mov	eax, OFFSET FLAT:_request+1152
	cmp	ebx, ecx
	je	SHORT $L697

; 157  : 	else
; 158  : 		req = request + ((NR_REQUEST * 2) / 3);	// 对于写请求，队列指针指向队列2/3 处。

	mov	eax, OFFSET FLAT:_request+756
$L697:

; 159  : /* 搜索一个空请求项 */
; 160  : // 从后向前搜索，当请求结构request 的dev 字段值=-1 时，表示该项未被占用。
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
; 164  : /* 如果没有找到空闲项，则让该次新请求睡眠：需检查是否提前读/写 */
; 165  : // 如果没有一项是空闲的（此时request 数组指针已经搜索越过头部），则查看此次请求是否是
; 166  : // 提前读/写（READA 或WRITEA），如果是则放弃此次请求。否则让本次请求睡眠（等待请求队列
; 167  : // 腾出空项），过一会再来搜索请求队列。
; 168  : 	if (req < request)

	jmp	SHORT $L703
$L698:
	cmp	eax, OFFSET FLAT:_request
	jae	SHORT $L647
$L703:

; 169  : 	{				// 如果请求队列中没有空项，则
; 170  : 		if (rw_ahead)

	cmp	DWORD PTR _rw_ahead$[ebp], ecx
	jne	SHORT $L699

; 173  : 			return;
; 174  : 		}
; 175  : 		sleep_on (&wait_for_request);	// 否则让本次请求睡眠，过会再查看请求队列。

	push	OFFSET FLAT:_wait_for_request
	call	_sleep_on
	add	esp, 4

; 176  : 		goto repeat;

	jmp	SHORT $repeat$640
$L699:

; 171  : 		{			// 如果是提前读/写请求，则解锁缓冲区，退出。
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
; 178  : /* 向空闲请求项中填写请求信息，并将其加入队列中 */
; 179  : // 请求结构参见（kernel/blk_drv/blk.h,23）。
; 180  : 	req->dev = bh->b_dev;		// 设备号。

	xor	edx, edx

; 181  : 	req->cmd = rw;		// 命令(READ/WRITE)。
; 182  : 	req->errors = 0;		// 操作时产生的错误次数。
; 183  : 	req->sector = bh->b_blocknr << 1;	// 起始扇区。(1 块=2 扇区)
; 184  : 	req->nr_sectors = 2;		// 读写扇区数。
; 185  : 	req->buffer = bh->b_data;	// 数据缓冲区。
; 186  : 	req->waiting = NULL;		// 任务等待操作执行完成的地方。
; 187  : 	req->bh = bh;			// 缓冲区头指针。
; 188  : 	req->next = NULL;		// 指向下一请求项。
; 189  : 	add_request (major + blk_dev, req);	// 将请求项加入队列中(blk_dev[major],req)。

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

; 94   : 	cli ();			// 关中断。

	cli

; 95   : 	if (req->bh)

	mov	eax, DWORD PTR [ebx+28]
	test	eax, eax
	je	SHORT $L608

; 96   : 		req->bh->b_dirt = 0;	// 清缓冲区“脏”标志。

	mov	BYTE PTR [eax+11], 0
$L608:

; 97   : // 如果dev 的当前请求(current_request)子段为空，则表示目前该设备没有请求项，本次是第1 个
; 98   : // 请求项，因此可将块设备当前请求指针直接指向请求项，并立刻执行相应设备的请求函数。
; 99   : 	if (!(tmp = dev->current_request))

	mov	eax, DWORD PTR _dev$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	test	ecx, ecx
	jne	SHORT $L609

; 100  : 	{
; 101  : 		dev->current_request = req;

	mov	DWORD PTR [eax+4], ebx

; 102  : 		sti ();			// 开中断。

	sti

; 103  : 		(dev->request_fn) ();	// 执行设备请求函数，对于硬盘(3)是do_hd_request()。

	call	DWORD PTR [eax]
	pop	ebx

; 115  : }

	pop	ebp
	ret	0
$L609:

; 104  : 		return;
; 105  : 	}
; 106  : // 如果目前该设备已经有请求项在等待，则首先利用电梯算法搜索最佳位置，然后将当前请求插入
; 107  : // 请求链表中。
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
; 106  : // 如果目前该设备已经有请求项在等待，则首先利用电梯算法搜索最佳位置，然后将当前请求插入
; 107  : // 请求链表中。
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

; 345  : 	_asm mov word ptr [ebx],dx // 段长limit 低16 位(位15-0)->[addr]。

	mov	WORD PTR [ebx], dx

; 346  : 	_asm ror edx,16 // edx 中的段长高4 位(位19-16)->dl。

	ror	edx, 16					; 00000010H

; 347  : 	_asm mov dh,byte ptr [ebx+6] // 取原[addr+6]字节->dh，其中高4 位是些标志。

	mov	dh, BYTE PTR [ebx+6]

; 348  : 	_asm and dh,0f0h // 清dh 的低4 位(将存放段长的位19-16)。

	and	dh, -16					; fffffff0H

; 349  : 	_asm or dl,dh // 将原高4 位标志和段长的高4 位(位19-16)合成1 字节，

	or	dl, dh

; 350  : 	_asm mov byte ptr [ebx+6],dl // 并放回[addr+6]处。

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

; 378  : 		_asm mov ah,byte ptr [ebx+7] // 取[addr+7]处基址高16 位的高8 位(位31-24)->dh。

	mov	ah, BYTE PTR [ebx+7]

; 379  : 		_asm mov al,byte ptr [ebx+4] // 取[addr+4]处基址高16 位的低8 位(位23-16)->dl。

	mov	al, BYTE PTR [ebx+4]

; 380  : 		_asm shl eax,16 // 基地址高16 位移到edx 中高16 位处。

	shl	eax, 16					; 00000010H

; 381  : 		_asm mov ax,word ptr [ebx+2] // 取[addr+2]处基址低16 位(位15-0)->dx。

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

; 114  : 	_asm mov word ptr [ebx],ax // 将TSS 长度放入描述符长度域(第0-1 字节)。

	mov	WORD PTR [ebx], ax

; 115  : 	_asm mov eax,addr 

	mov	eax, DWORD PTR _addr$[ebp]

; 116  : 	_asm mov word ptr [ebx+2],ax // 将基地址的低字放入描述符第2-3 字节。

	mov	WORD PTR [ebx+2], ax

; 117  : 	_asm ror eax,16 // 将基地址高字移入ax 中。

	ror	eax, 16					; 00000010H

; 118  : 	_asm mov byte ptr [ebx+4],al // 将基地址高字中低字节移入描述符第4 字节。

	mov	BYTE PTR [ebx+4], al

; 119  : 	_asm mov al,tp

	mov	al, BYTE PTR _tp$[ebp]

; 120  : 	_asm mov byte ptr [ebx+5],al // 将标志类型字节移入描述符的第5 字节。

	mov	BYTE PTR [ebx+5], al

; 121  : 	_asm mov al,0 

	mov	al, 0

; 122  : 	_asm mov byte ptr [ebx+6],al // 描述符的第6 字节置0。

	mov	BYTE PTR [ebx+6], al

; 123  : 	_asm mov byte ptr [ebx+7],ah // 将基地址高字中高字节移入描述符第7 字节。

	mov	BYTE PTR [ebx+7], ah

; 124  : 	_asm ror eax,16 // eax 清零。

	ror	eax, 16					; 00000010H
	pop	ebx

; 125  : }

	pop	ebp
	ret	0
__set_tssldt_desc ENDP
_TEXT	ENDS
END
