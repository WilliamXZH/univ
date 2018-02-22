	TITLE	..\fs\block_dev.c
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
;	COMDAT _get_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_byte
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_word
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _put_fs_long
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _get_ds
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _set_fs
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_block_write
EXTRN	_getblk:NEAR
EXTRN	_brelse:NEAR
EXTRN	_breada:NEAR
_TEXT	SEGMENT
_dev$ = 8
_pos$ = 12
_buf$ = 16
_count$ = 20
_block$ = -16
_offset$ = -8
_written$ = -4
$T683 = -12
_block_write PROC NEAR

; 32   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 33   : // 由pos 地址换算成开始读写块的块序号block。并求出需读第1 字节在该块中的偏移位置offset。
; 34   : 	int block = *pos >> BLOCK_SIZE_BITS;

	mov	eax, DWORD PTR _pos$[ebp]
	push	ebx
	push	esi
	push	edi
	mov	eax, DWORD PTR [eax]

; 38   : 	struct buffer_head * bh;
; 39   : 	register char * p;
; 40   : 
; 41   : // 针对要写入的字节数count，循环执行以下操作，直到全部写入。
; 42   : 	while (count > 0) {

	mov	edi, DWORD PTR _count$[ebp]
	mov	ebx, eax
	and	eax, 1023				; 000003ffH
	sar	ebx, 10					; 0000000aH
	test	edi, edi
	mov	DWORD PTR _offset$[ebp], eax
	mov	DWORD PTR _written$[ebp], 0
	jle	$L627
	lea	eax, DWORD PTR [ebx+1]
	mov	DWORD PTR 20+[ebp], eax
	jmp	SHORT $L626
$L690:

; 33   : // 由pos 地址换算成开始读写块的块序号block。并求出需读第1 字节在该块中的偏移位置offset。
; 34   : 	int block = *pos >> BLOCK_SIZE_BITS;

	mov	eax, DWORD PTR 20+[ebp]
$L626:

; 43   : // 计算在该块中可写入的字节数。如果需要写入的字节数填不满一块，则只需写count 字节。
; 44   : 		chars = BLOCK_SIZE - offset;

	mov	edx, DWORD PTR _offset$[ebp]
	mov	esi, 1024				; 00000400H
	sub	esi, edx

; 45   : 		if (chars > count)

	cmp	esi, edi
	jle	SHORT $L628

; 46   : 			chars=count;

	mov	esi, edi
$L628:

; 47   : // 如果正好要写1 块数据，则直接申请1 块高速缓冲块，否则需要读入将被修改的数据块，并预读
; 48   : // 下两块数据，然后将块号递增1。
; 49   : 		if (chars == BLOCK_SIZE)

	cmp	esi, 1024				; 00000400H
	jne	SHORT $L629

; 50   : 			bh = getblk(dev,block);

	mov	ecx, DWORD PTR _dev$[ebp]
	push	ebx
	push	ecx
	call	_getblk
	add	esp, 8

; 51   : 		else

	jmp	SHORT $L691
$L629:

; 52   : 			bh = breada(dev,block,block+1,block+2,-1);

	lea	edx, DWORD PTR [eax+1]
	push	-1
	push	edx
	push	eax
	mov	eax, DWORD PTR _dev$[ebp]
	push	ebx
	push	eax
	call	_breada
	add	esp, 20					; 00000014H
$L691:

; 53   : 		block++;

	mov	ecx, DWORD PTR 20+[ebp]
	mov	edx, eax
	inc	ebx
	inc	ecx

; 54   : // 如果缓冲块操作失败，则返回已写字节数，如果没有写入任何字节，则返回出错号（负数）。
; 55   : 		if (!bh)

	test	edx, edx
	mov	DWORD PTR _block$[ebp], ebx
	mov	DWORD PTR 20+[ebp], ecx
	je	SHORT $L687

; 57   : // p 指向读出数据块中开始写的位置。若最后写入的数据不足一块，则需从块开始填写（修改）所需
; 58   : // 的字节，因此这里需置offset 为零。
; 59   : 		p = offset + bh->b_data;

	mov	ecx, DWORD PTR [edx]
	mov	eax, DWORD PTR _offset$[ebp]
	add	ecx, eax

; 60   : 		offset = 0;
; 61   : // 将文件中偏移指针前移已写字节数。累加已写字节数chars。传送计数值减去此次已传送字节数。
; 62   : 		*pos += chars;

	mov	eax, DWORD PTR _pos$[ebp]

; 63   : 		written += chars;
; 64   : 		count -= chars;

	sub	edi, esi
	mov	DWORD PTR _offset$[ebp], 0
	add	DWORD PTR [eax], esi
	mov	eax, DWORD PTR _written$[ebp]
	add	eax, esi
	mov	DWORD PTR _written$[ebp], eax

; 65   : // 从用户缓冲区复制chars 字节到p 指向的高速缓冲区中开始写入的位置。
; 66   : 		while (chars-- > 0)

	mov	eax, esi
	dec	esi
	test	eax, eax
	jle	SHORT $L634

; 57   : // p 指向读出数据块中开始写的位置。若最后写入的数据不足一块，则需从块开始填写（修改）所需
; 58   : // 的字节，因此这里需置offset 为零。
; 59   : 		p = offset + bh->b_data;

	inc	esi
$L633:

; 67   : 			*(p++) = get_fs_byte(buf++);

	mov	eax, DWORD PTR _buf$[ebp]
	mov	DWORD PTR $T683[ebp], eax
	inc	eax
	mov	DWORD PTR _buf$[ebp], eax

; 35   : 	int offset = *pos & (BLOCK_SIZE-1);
; 36   : 	int chars;

	mov	ebx, DWORD PTR $T683[ebp]

; 37   : 	int written = 0;

	mov	al, BYTE PTR fs:[ebx]

; 67   : 			*(p++) = get_fs_byte(buf++);

	mov	BYTE PTR [ecx], al
	inc	ecx
	dec	esi
	jne	SHORT $L633

; 65   : // 从用户缓冲区复制chars 字节到p 指向的高速缓冲区中开始写入的位置。
; 66   : 		while (chars-- > 0)

	mov	ebx, DWORD PTR _block$[ebp]
$L634:

; 68   : // 置该缓冲区块已修改标志，并释放该缓冲区（也即该缓冲区引用计数递减1）。
; 69   : 		bh->b_dirt = 1;
; 70   : 		brelse(bh);

	push	edx
	mov	BYTE PTR [edx+11], 1
	call	_brelse
	add	esp, 4
	test	edi, edi
	jg	$L690
$L627:

; 71   : 	}
; 72   : 	return written;		// 返回已写入的字节数，正常退出。

	mov	eax, DWORD PTR _written$[ebp]
$L618:
	pop	edi
	pop	esi
	pop	ebx

; 73   : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L687:

; 56   : 			return written?written:-EIO;

	mov	eax, DWORD PTR _written$[ebp]
	test	eax, eax
	jne	SHORT $L618
	pop	edi
	pop	esi
	mov	eax, -5					; fffffffbH
	pop	ebx

; 73   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_block_write ENDP
_TEXT	ENDS
PUBLIC	_block_read
_TEXT	SEGMENT
_dev$ = 8
_pos$ = 12
_buf$ = 16
_count$ = 20
_offset$ = -16
_read$ = -8
$T698 = -1
$T699 = -20
_block_read PROC NEAR

; 77   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 24					; 00000018H

; 78   : // 由pos 地址换算成开始读写块的块序号block。并求出需读第1 字节在该块中的偏移位置offset。
; 79   : 	int block = *pos >> BLOCK_SIZE_BITS;

	mov	eax, DWORD PTR _pos$[ebp]
	push	ebx

; 82   : 	int read = 0;
; 83   : 	struct buffer_head * bh;
; 84   : 	register char * p;
; 85   : 
; 86   : // 针对要读入的字节数count，循环执行以下操作，直到全部读入。
; 87   : 	while (count>0) {

	mov	ebx, DWORD PTR _count$[ebp]
	push	esi
	mov	eax, DWORD PTR [eax]
	push	edi
	mov	edi, eax
	and	eax, 1023				; 000003ffH
	shr	edi, 10					; 0000000aH
	test	ebx, ebx
	mov	DWORD PTR _offset$[ebp], eax
	mov	DWORD PTR _read$[ebp], 0
	jle	$L653
	lea	eax, DWORD PTR [edi+1]
	mov	DWORD PTR -12+[ebp], eax
	jmp	SHORT $L652
$L705:

; 78   : // 由pos 地址换算成开始读写块的块序号block。并求出需读第1 字节在该块中的偏移位置offset。
; 79   : 	int block = *pos >> BLOCK_SIZE_BITS;

	mov	eax, DWORD PTR -12+[ebp]
$L652:

; 88   : // 计算在该块中需读入的字节数。如果需要读入的字节数不满一块，则只需读count 字节。
; 89   : 		chars = BLOCK_SIZE-offset;

	mov	edx, DWORD PTR _offset$[ebp]
	mov	esi, 1024				; 00000400H
	sub	esi, edx

; 90   : 		if (chars > count)

	cmp	esi, ebx
	jle	SHORT $L654

; 91   : 			chars = count;

	mov	esi, ebx
$L654:

; 92   : // 读入需要的数据块，并预读下两块数据，如果读操作出错，则返回已读字节数，如果没有读入任何
; 93   : // 字节，则返回出错号。然后将块号递增1。
; 94   : 		if (!(bh = breada(dev,block,block+1,block+2,-1)))

	mov	edx, DWORD PTR _dev$[ebp]
	lea	ecx, DWORD PTR [eax+1]
	push	-1
	push	ecx
	push	eax
	push	edi
	push	edx
	call	_breada
	mov	edx, eax
	add	esp, 20					; 00000014H
	test	edx, edx
	je	SHORT $L702

; 96   : 		block++;

	mov	ecx, DWORD PTR -12+[ebp]

; 97   : // p 指向从设备读出数据块中需要读取的开始位置。若最后需要读取的数据不足一块，则需从块开始
; 98   : // 读取所需的字节，因此这里需将offset 置零。
; 99   : 		p = offset + bh->b_data;

	mov	eax, DWORD PTR _offset$[ebp]
	inc	edi
	inc	ecx
	mov	DWORD PTR -12+[ebp], ecx
	mov	ecx, DWORD PTR [edx]
	add	ecx, eax

; 100  : 		offset = 0;
; 101  : // 将文件中偏移指针前移已读出字节数chars。累加已读字节数。传送计数值减去此次已传送字节数。
; 102  : 		*pos += chars;

	mov	eax, DWORD PTR _pos$[ebp]

; 103  : 		read += chars;
; 104  : 		count -= chars;

	sub	ebx, esi
	mov	DWORD PTR _offset$[ebp], 0
	add	DWORD PTR [eax], esi
	mov	eax, DWORD PTR _read$[ebp]
	add	eax, esi
	mov	DWORD PTR _count$[ebp], ebx
	mov	DWORD PTR _read$[ebp], eax

; 105  : // 从高速缓冲区中p 指向的开始位置复制chars 字节数据到用户缓冲区，并释放该高速缓冲区。
; 106  : 		while (chars-->0)

	mov	eax, esi
	dec	esi
	test	eax, eax
	jle	SHORT $L658
	inc	esi
	mov	DWORD PTR -24+[ebp], esi
$L657:

; 107  : 			put_fs_byte(*(p++),buf++);

	mov	esi, DWORD PTR _buf$[ebp]
	mov	al, BYTE PTR [ecx]
	mov	DWORD PTR $T699[ebp], esi
	inc	ecx
	inc	esi
	mov	BYTE PTR $T698[ebp], al
	mov	DWORD PTR _buf$[ebp], esi

; 78   : // 由pos 地址换算成开始读写块的块序号block。并求出需读第1 字节在该块中的偏移位置offset。
; 79   : 	int block = *pos >> BLOCK_SIZE_BITS;

	mov	ebx, DWORD PTR $T699[ebp]

; 80   : 	int offset = *pos & (BLOCK_SIZE-1);

	mov	al, BYTE PTR $T698[ebp]

; 81   : 	int chars;

	mov	BYTE PTR fs:[ebx], al

; 107  : 			put_fs_byte(*(p++),buf++);

	mov	eax, DWORD PTR -24+[ebp]
	dec	eax
	mov	DWORD PTR -24+[ebp], eax
	jne	SHORT $L657

; 105  : // 从高速缓冲区中p 指向的开始位置复制chars 字节数据到用户缓冲区，并释放该高速缓冲区。
; 106  : 		while (chars-->0)

	mov	ebx, DWORD PTR _count$[ebp]
$L658:

; 108  : 		brelse(bh);

	push	edx
	call	_brelse
	add	esp, 4
	test	ebx, ebx
	jg	$L705
$L653:

; 109  : 	}
; 110  : 	return read;		// 返回已读取的字节数，正常退出。

	mov	eax, DWORD PTR _read$[ebp]
$L644:
	pop	edi
	pop	esi
	pop	ebx

; 111  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L702:

; 95   : 			return read?read:-EIO;

	mov	eax, DWORD PTR _read$[ebp]
	test	eax, eax
	jne	SHORT $L644
	pop	edi
	pop	esi
	mov	eax, -5					; fffffffbH
	pop	ebx

; 111  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_block_read ENDP
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
PUBLIC	_get_fs_byte
;	COMDAT _get_fs_byte
_TEXT	SEGMENT
_addr$ = 8
_get_fs_byte PROC NEAR					; COMDAT

; 7    : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 8    : //  unsigned register char _v;
; 9    : 
; 10   : // __asm__ ("movb %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 11   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 12   :   _asm mov al,byte ptr fs:[ebx];

	mov	al, BYTE PTR fs:[ebx]
	pop	ebx

; 13   : //  _asm mov _v,al;
; 14   : //  return _v;
; 15   : }

	pop	ebp
	ret	0
_get_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_get_fs_word
;	COMDAT _get_fs_word
_TEXT	SEGMENT
_addr$ = 8
_get_fs_word PROC NEAR					; COMDAT

; 23   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 24   : //  unsigned short _v;
; 25   : 
; 26   : //__asm__ ("movw %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 27   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 28   :   _asm mov ax,word ptr fs:[ebx];

	mov	ax, WORD PTR fs:[ebx]
	pop	ebx

; 29   : //  _asm mov _v,ax;
; 30   : //  return _v;
; 31   : }

	pop	ebp
	ret	0
_get_fs_word ENDP
_TEXT	ENDS
PUBLIC	_get_fs_long
;	COMDAT _get_fs_long
_TEXT	SEGMENT
_addr$ = 8
_get_fs_long PROC NEAR					; COMDAT

; 39   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 40   : //  unsigned long _v;
; 41   : 
; 42   : //__asm__ ("movl %%fs:%1,%0": "=r" (_v):"m" (*addr));
; 43   :   _asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 44   :   _asm mov eax,dword ptr fs:[ebx];

	mov	eax, DWORD PTR fs:[ebx]
	pop	ebx

; 45   : //  _asm mov _v,eax;
; 46   : //  return _v;
; 47   : }

	pop	ebp
	ret	0
_get_fs_long ENDP
_TEXT	ENDS
PUBLIC	_put_fs_byte
;	COMDAT _put_fs_byte
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_byte PROC NEAR					; COMDAT

; 54   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 55   : //  __asm__ ("movb %0,%%fs:%1"::"r" (val), "m" (*addr));
; 56   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 57   : 	_asm mov al,val;

	mov	al, BYTE PTR _val$[ebp]

; 58   : 	_asm mov byte ptr fs:[ebx],al;

	mov	BYTE PTR fs:[ebx], al
	pop	ebx

; 59   : }

	pop	ebp
	ret	0
_put_fs_byte ENDP
_TEXT	ENDS
PUBLIC	_put_fs_word
;	COMDAT _put_fs_word
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_word PROC NEAR					; COMDAT

; 66   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 67   : //  __asm__ ("movw %0,%%fs:%1"::"r" (val), "m" (*addr));
; 68   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 69   : 	_asm mov ax,val;

	mov	ax, WORD PTR _val$[ebp]

; 70   : 	_asm mov word ptr fs:[ebx],ax;

	mov	WORD PTR fs:[ebx], ax
	pop	ebx

; 71   : }

	pop	ebp
	ret	0
_put_fs_word ENDP
_TEXT	ENDS
PUBLIC	_put_fs_long
;	COMDAT _put_fs_long
_TEXT	SEGMENT
_val$ = 8
_addr$ = 12
_put_fs_long PROC NEAR					; COMDAT

; 78   : {

	push	ebp
	mov	ebp, esp
	push	ebx

; 79   : //  __asm__ ("movl %0,%%fs:%1"::"r" (val), "m" (*addr));
; 80   : 	_asm mov ebx,addr

	mov	ebx, DWORD PTR _addr$[ebp]

; 81   : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 82   : 	_asm mov dword ptr fs:[ebx],eax;

	mov	DWORD PTR fs:[ebx], eax
	pop	ebx

; 83   : }

	pop	ebp
	ret	0
_put_fs_long ENDP
_TEXT	ENDS
PUBLIC	_get_fs
;	COMDAT _get_fs
_TEXT	SEGMENT
_get_fs	PROC NEAR					; COMDAT

; 97   : //  unsigned short _v;
; 98   : //__asm__ ("mov %%fs,%%ax": "=a" (_v):);
; 99   :   _asm mov ax,fs;

	mov	ax, fs

; 100  : //  _asm mov _v,ax;
; 101  : //  return _v;
; 102  : }

	ret	0
_get_fs	ENDP
_TEXT	ENDS
PUBLIC	_get_ds
;	COMDAT _get_ds
_TEXT	SEGMENT
_get_ds	PROC NEAR					; COMDAT

; 109  : //  unsigned short _v;
; 110  : //__asm__ ("mov %%ds,%%ax": "=a" (_v):);
; 111  :   _asm mov ax,fs;

	mov	ax, fs

; 112  : //  _asm mov _v,ax;
; 113  : //  return _v;
; 114  : }

	ret	0
_get_ds	ENDP
_TEXT	ENDS
PUBLIC	_set_fs
;	COMDAT _set_fs
_TEXT	SEGMENT
_val$ = 8
_set_fs	PROC NEAR					; COMDAT

; 120  : {

	push	ebp
	mov	ebp, esp

; 121  : //  __asm__ ("mov %0,%%fs"::"a" ((unsigned short) val));
; 122  : 	_asm mov eax,val;

	mov	eax, DWORD PTR _val$[ebp]

; 123  : 	_asm mov fs,ax;

	mov	fs, ax

; 124  : }

	pop	ebp
	ret	0
_set_fs	ENDP
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
