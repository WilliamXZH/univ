	TITLE	..\fs\file_dev.c
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
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_file_read
EXTRN	_bmap:NEAR
EXTRN	_brelse:NEAR
EXTRN	_bread:NEAR
EXTRN	_jiffies:DWORD
EXTRN	_startup_time:DWORD
_TEXT	SEGMENT
_inode$ = 8
_filp$ = 12
_buf$ = 16
_count$ = 20
_left$ = -8
$T696 = -1
$T697 = -12
$T701 = -12
_file_read PROC NEAR

; 23   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
	push	ebx

; 28   : 	if ((left=count)<=0)

	mov	ebx, DWORD PTR _count$[ebp]
	test	ebx, ebx
	jg	SHORT $L702

; 29   : 		return 0;

	xor	eax, eax
	pop	ebx

; 63   : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L702:
	push	esi
	push	edi
$L628:

; 32   : // 根据i 节点和文件表结构信息，取数据块文件当前读写位置在设备上对应的逻辑块号nr。若nr 不
; 33   : // 为0，则从i 节点指定的设备上读取该逻辑块，如果读操作失败则退出循环。若nr 为0，表示指定
; 34   : // 的数据块不存在，置缓冲块指针为NULL。
; 35   : 		if (nr = bmap(inode,(filp->f_pos)/BLOCK_SIZE)) {

	mov	eax, DWORD PTR _filp$[ebp]
	mov	edi, DWORD PTR _inode$[ebp]
	mov	esi, DWORD PTR [eax+12]
	mov	eax, esi
	cdq
	and	edx, 1023				; 000003ffH
	add	eax, edx
	sar	eax, 10					; 0000000aH
	push	eax
	push	edi
	call	_bmap
	add	esp, 8
	test	eax, eax
	je	SHORT $L630

; 36   : 			if (!(bh=bread(inode->i_dev,nr)))

	xor	ecx, ecx
	push	eax
	mov	cx, WORD PTR [edi+44]
	push	ecx
	call	_bread
	mov	edi, eax
	add	esp, 8
	test	edi, edi
	je	$L705

; 37   : 				break;
; 38   : 		} else

	jmp	SHORT $L632
$L630:

; 39   : 			bh = NULL;

	xor	edi, edi
$L632:

; 40   : // 计算文件读写指针在数据块中的偏移值nr，则该块中可读字节数为(BLOCK_SIZE-nr)，然后与还需
; 41   : // 读取的字节数left 作比较，其中小值即为本次需读的字节数chars。若(BLOCK_SIZE-nr)大则说明
; 42   : // 该块是需要读取的最后一块数据，反之则还需要读取一块数据。
; 43   : 		nr = filp->f_pos % BLOCK_SIZE;

	mov	edx, esi
	and	edx, -2147482625			; 800003ffH
	jns	SHORT $L709
	dec	edx
	or	edx, -1024				; fffffc00H
	inc	edx
$L709:

; 44   : 		chars = MIN( BLOCK_SIZE-nr , left );

	mov	eax, 1024				; 00000400H
	sub	eax, edx
	cmp	eax, ebx
	jl	SHORT $L690
	mov	eax, ebx
$L690:

; 45   : // 调整读写文件指针。指针前移此次将读取的字节数chars。剩余字节计数相应减去chars。
; 46   : 		filp->f_pos += chars;

	mov	ecx, DWORD PTR _filp$[ebp]
	add	esi, eax

; 47   : 		left -= chars;

	sub	ebx, eax

; 48   : // 若从设备上读到了数据，则将p 指向读出数据块缓冲区中开始读取的位置，并且复制chars 字节
; 49   : // 到用户缓冲区buf 中。否则往用户缓冲区中填入chars 个0 值字节。
; 50   : 		if (bh) {

	test	edi, edi
	mov	DWORD PTR [ecx+12], esi
	mov	DWORD PTR _left$[ebp], ebx
	je	SHORT $L704

; 51   : 			char * p = nr + bh->b_data;

	mov	ecx, DWORD PTR [edi]
	add	ecx, edx

; 52   : 			while (chars-->0)

	mov	edx, eax
	dec	eax
	test	edx, edx
	jle	SHORT $L637

; 51   : 			char * p = nr + bh->b_data;

	lea	esi, DWORD PTR [eax+1]
$L636:

; 53   : 				put_fs_byte(*(p++),buf++);

	mov	eax, DWORD PTR _buf$[ebp]
	mov	dl, BYTE PTR [ecx]
	mov	DWORD PTR $T697[ebp], eax
	inc	ecx
	inc	eax
	mov	BYTE PTR $T696[ebp], dl
	mov	DWORD PTR _buf$[ebp], eax

; 24   : 	int left,chars,nr;
; 25   : 	struct buffer_head * bh;

	mov	ebx, DWORD PTR $T697[ebp]

; 26   : 

	mov	al, BYTE PTR $T696[ebp]

; 27   : // 若需要读取的字节计数值小于等于零，则返回。

	mov	BYTE PTR fs:[ebx], al

; 53   : 				put_fs_byte(*(p++),buf++);

	dec	esi
	jne	SHORT $L636

; 52   : 			while (chars-->0)

	mov	ebx, DWORD PTR _left$[ebp]
$L637:

; 54   : 			brelse(bh);

	push	edi
	call	_brelse
	add	esp, 4

; 55   : 		} else {

	jmp	SHORT $L641
$L704:

; 56   : 			while (chars-->0)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	jle	SHORT $L641
	lea	ecx, DWORD PTR [eax+1]
$L640:

; 57   : 				put_fs_byte(0,buf++);

	mov	eax, DWORD PTR _buf$[ebp]
	mov	DWORD PTR $T701[ebp], eax
	inc	eax
	mov	DWORD PTR _buf$[ebp], eax

; 24   : 	int left,chars,nr;
; 25   : 	struct buffer_head * bh;

	mov	ebx, DWORD PTR $T701[ebp]

; 26   : 

	mov	al, 0

; 27   : // 若需要读取的字节计数值小于等于零，则返回。

	mov	BYTE PTR fs:[ebx], al

; 57   : 				put_fs_byte(0,buf++);

	dec	ecx
	jne	SHORT $L640

; 56   : 			while (chars-->0)

	mov	ebx, DWORD PTR _left$[ebp]
$L641:

; 30   : // 若还需要读取的字节数不等于0，就循环执行以下操作，直到全部读出。
; 31   : 	while (left) {

	test	ebx, ebx
	jne	$L628
$L705:

; 58   : 		}
; 59   : 	}
; 60   : // 修改该i 节点的访问时间为当前时间。返回读取的字节数，若读取字节数为0，则返回出错号。
; 61   : 	inode->i_atime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	esi, DWORD PTR _startup_time
	mov	ecx, DWORD PTR _inode$[ebp]
	sar	edx, 5
	mov	eax, edx
	pop	edi
	shr	eax, 31					; 0000001fH
	add	edx, eax

; 62   : 	return (count-left)?(count-left):-ERROR;

	mov	eax, DWORD PTR _count$[ebp]
	add	edx, esi
	sub	eax, ebx
	mov	DWORD PTR [ecx+36], edx
	pop	esi
	jne	SHORT $L621
	mov	eax, -99				; ffffff9dH
$L621:
	pop	ebx

; 63   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_file_read ENDP
_TEXT	ENDS
PUBLIC	_file_write
EXTRN	_create_block:NEAR
_TEXT	SEGMENT
_inode$ = 8
_filp$ = 12
_buf$ = 16
_count$ = 20
_i$ = -4
$T716 = -8
_file_write PROC NEAR

; 69   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 75   : 
; 76   : /*
; 77   :  * ok，当许多进程同时写时，append 操作可能不行，但那又怎样。不管怎样那样做会
; 78   :  * 导致混乱一团。
; 79   :  */
; 80   : // 如果是要向文件后添加数据，则将文件读写指针移到文件尾部。否则就将在文件读写指针处写入。
; 81   : 	if (filp->f_flags & O_APPEND)

	mov	eax, DWORD PTR _filp$[ebp]
	push	ebx
	push	esi
	push	edi
	test	BYTE PTR [eax+3], 4
	mov	DWORD PTR _i$[ebp], 0
	je	SHORT $L658

; 82   : 		pos = inode->i_size;

	mov	ebx, DWORD PTR _inode$[ebp]
	mov	edi, DWORD PTR [ebx+4]

; 83   : 	else

	jmp	SHORT $L718
$L658:

; 84   : 		pos = filp->f_pos;

	mov	edi, DWORD PTR [eax+12]
	mov	ebx, DWORD PTR _inode$[ebp]
$L718:

; 85   : // 若已写入字节数i 小于需要写入的字节数count，则循环执行以下操作。
; 86   : 	while (i<count) {

	mov	eax, DWORD PTR _count$[ebp]
	test	eax, eax
	jle	$L720
$L661:

; 87   : // 创建数据块号(pos/BLOCK_SIZE)在设备上对应的逻辑块，并返回在设备上的逻辑块号。如果逻辑
; 88   : // 块号=0，则表示创建失败，退出循环。
; 89   : 		if (!(block = create_block(inode,pos/BLOCK_SIZE)))

	mov	eax, edi
	cdq
	and	edx, 1023				; 000003ffH
	add	eax, edx
	sar	eax, 10					; 0000000aH
	push	eax
	push	ebx
	call	_create_block
	add	esp, 8
	test	eax, eax
	je	$L720

; 90   : 			break;
; 91   : // 根据该逻辑块号读取设备上的相应数据块，若出错则退出循环。
; 92   : 		if (!(bh=bread(inode->i_dev,block)))

	push	eax
	xor	eax, eax
	mov	ax, WORD PTR [ebx+44]
	push	eax
	call	_bread
	mov	esi, eax
	add	esp, 8
	test	esi, esi
	je	$L720

; 93   : 			break;
; 94   : // 求出文件读写指针在数据块中的偏移值c，将p 指向读出数据块缓冲区中开始读取的位置。置该
; 95   : // 缓冲区已修改标志。
; 96   : 		c = pos % BLOCK_SIZE;

	mov	ecx, edi
	and	ecx, -2147482625			; 800003ffH
	jns	SHORT $L726
	dec	ecx
	or	ecx, -1024				; fffffc00H
	inc	ecx
$L726:

; 97   : 		p = c + bh->b_data;

	mov	eax, DWORD PTR [esi]
	mov	edx, ecx
	add	edx, eax

; 98   : 		bh->b_dirt = 1;
; 99   : // 从开始读写位置到块末共可写入c=(BLOCK_SIZE-c)个字节。若c 大于剩余还需写入的字节数
; 100  : // (count-i)，则此次只需再写入c=(count-i)即可。
; 101  : 		c = BLOCK_SIZE-c;

	mov	eax, 1024				; 00000400H
	sub	eax, ecx

; 102  : 		if (c > count-i) c = count-i;

	mov	ecx, DWORD PTR _count$[ebp]
	sub	ecx, DWORD PTR _i$[ebp]
	mov	BYTE PTR [esi+11], 1
	cmp	eax, ecx
	jle	SHORT $L665
	mov	eax, ecx
$L665:

; 103  : // 文件读写指针前移此次需写入的字节数。如果当前文件读写指针位置值超过了文件的大小，则
; 104  : // 修改i 节点中文件大小字段，并置i 节点已修改标志。
; 105  : 		pos += c;
; 106  : 		if (pos > inode->i_size) {

	mov	ecx, DWORD PTR [ebx+4]
	add	edi, eax
	cmp	edi, ecx
	jbe	SHORT $L666

; 107  : 			inode->i_size = pos;

	mov	DWORD PTR [ebx+4], edi

; 108  : 			inode->i_dirt = 1;

	mov	BYTE PTR [ebx+51], 1
$L666:

; 109  : 		}
; 110  : // 已写入字节计数累加此次写入的字节数c。从用户缓冲区buf 中复制c 个字节到高速缓冲区中p
; 111  : // 指向开始的位置处。然后释放该缓冲区。
; 112  : 		i += c;

	mov	ecx, DWORD PTR _i$[ebp]
	add	ecx, eax
	mov	DWORD PTR _i$[ebp], ecx

; 113  : 		while (c-->0)

	mov	ecx, eax
	dec	eax
	test	ecx, ecx
	jle	SHORT $L669

; 109  : 		}
; 110  : // 已写入字节计数累加此次写入的字节数c。从用户缓冲区buf 中复制c 个字节到高速缓冲区中p
; 111  : // 指向开始的位置处。然后释放该缓冲区。
; 112  : 		i += c;

	lea	ecx, DWORD PTR [eax+1]
$L668:

; 114  : 			*(p++) = get_fs_byte(buf++);

	mov	eax, DWORD PTR _buf$[ebp]
	mov	DWORD PTR $T716[ebp], eax
	inc	eax
	mov	DWORD PTR _buf$[ebp], eax

; 70   : 	off_t pos;
; 71   : 	int block,c;
; 72   : 	struct buffer_head * bh;
; 73   : 	char * p;

	mov	ebx, DWORD PTR $T716[ebp]

; 74   : 	int i=0;

	mov	al, BYTE PTR fs:[ebx]

; 114  : 			*(p++) = get_fs_byte(buf++);

	mov	BYTE PTR [edx], al
	inc	edx
	dec	ecx
	jne	SHORT $L668

; 113  : 		while (c-->0)

	mov	ebx, DWORD PTR _inode$[ebp]
$L669:

; 115  : 		brelse(bh);

	push	esi
	call	_brelse
	mov	edx, DWORD PTR _count$[ebp]
	mov	eax, DWORD PTR _i$[ebp]
	add	esp, 4
	cmp	eax, edx
	jl	$L661
$L720:

; 116  : 	}
; 117  : // 更改文件修改时间为当前时间。
; 118  : 	inode->i_mtime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	mov	esi, DWORD PTR _startup_time
	sar	edx, 5
	mov	eax, edx
	shr	eax, 31					; 0000001fH
	add	edx, eax

; 119  : // 如果此次操作不是在文件尾添加数据，则把文件读写指针调整到当前读写位置，并更改i 节点修改
; 120  : // 时间为当前时间。
; 121  : 	if (!(filp->f_flags & O_APPEND)) {

	mov	eax, DWORD PTR _filp$[ebp]
	add	edx, esi
	test	BYTE PTR [eax+3], 4
	mov	DWORD PTR [ebx+8], edx
	jne	SHORT $L670

; 122  : 		filp->f_pos = pos;

	mov	DWORD PTR [eax+12], edi

; 123  : 		inode->i_ctime = CURRENT_TIME;

	mov	ecx, DWORD PTR _jiffies
	mov	eax, 1374389535				; 51eb851fH
	imul	ecx
	sar	edx, 5
	mov	ecx, edx
	shr	ecx, 31					; 0000001fH
	add	edx, ecx
	add	edx, esi
	mov	DWORD PTR [ebx+40], edx
$L670:

; 124  : 	}
; 125  : // 返回写入的字节数，若写入字节数为0，则返回出错号-1。
; 126  : 	return (i?i:-1);

	mov	eax, DWORD PTR _i$[ebp]
	pop	edi
	pop	esi
	pop	ebx
	test	eax, eax
	jne	SHORT $L712
	or	eax, -1
$L712:

; 127  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_file_write ENDP
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

	je	SHORT $l1$523

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
; 280  : 		mov ax, __tmp

	mov	ax, WORD PTR ___tmp$[ebp]

; 281  : 		mov word ptr ds:[lcs],ax

	mov	WORD PTR ds:$lcs$524, ax

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
$lcs$524:

; 287  : lcs:	_emit 0		// cs

	DB	0

; 288  : 		_emit 0

	DB	0

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$523

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

	clts
$l1$523:

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
END
