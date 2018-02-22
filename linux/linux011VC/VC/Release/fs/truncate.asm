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
; 85   : // 如果不是常规文件或者是目录文件，则返回。
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
; 88   : // 释放i 节点的7 个直接逻辑块，并将这7 个逻辑块项全置零。
; 89   :   for (i = 0; i < 7; i++)

	lea	edi, DWORD PTR [esi+14]
	mov	DWORD PTR 8+[ebp], 7
$L599:

; 90   :     if (inode->i_zone[i])

	mov	ax, WORD PTR [edi]
	test	ax, ax
	je	SHORT $L600

; 91   : 	{				// 如果块号不为0，则释放之。
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
; 95   :   free_ind (inode->i_dev, inode->i_zone[7]);	// 释放一次间接块。

	xor	ecx, ecx
	xor	edi, edi
	mov	cx, WORD PTR [esi+28]
	mov	di, WORD PTR [esi+44]
	push	ecx
	push	edi
	call	_free_ind

; 96   :   free_dind (inode->i_dev, inode->i_zone[8]);	// 释放二次间接块。

	xor	edx, edx
	mov	dx, WORD PTR [esi+30]
	push	edx
	push	edi
	call	_free_dind
	add	esp, 16					; 00000010H

; 97   :   inode->i_zone[7] = inode->i_zone[8] = 0;	// 逻辑块项7、8 置零。

	mov	WORD PTR [esi+30], 0
	mov	WORD PTR [esi+28], 0

; 98   :   inode->i_size = 0;		// 文件大小置零。

	mov	DWORD PTR [esi+4], 0

; 99   :   inode->i_dirt = 1;		// 置节点已修改标志。

	mov	BYTE PTR [esi+51], 1

; 100  :   inode->i_mtime = inode->i_ctime = CURRENT_TIME;	// 重置文件和节点修改时间为当前时间。

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
; 20   : // 如果逻辑块号为0，则返回。
; 21   :   if (!block)

	mov	esi, DWORD PTR _block$[ebp]
	test	esi, esi
	je	SHORT $L567
	push	edi

; 22   :     return;
; 23   : // 读取一次间接块，并释放其上表明使用的所有逻辑块，然后释放该一次间接块的缓冲区。
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
; 26   :       p = (unsigned short *) bh->b_data;	// 指向数据缓冲区。

	mov	esi, DWORD PTR [ecx]
	push	ebx
	mov	ebx, 512				; 00000200H
$L574:

; 27   :       for (i = 0; i < 512; i++, p++)	// 每个逻辑块上可有512 个块号。
; 28   : 	if (*p)

	mov	ax, WORD PTR [esi]
	test	ax, ax
	je	SHORT $L575

; 29   : 	  free_block (dev, *p);	// 释放指定的逻辑块。

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

; 30   :       brelse (bh);		// 释放缓冲区。

	push	ecx
	call	_brelse
	mov	esi, DWORD PTR _block$[ebp]
	add	esp, 4
	pop	ebx
$L572:

; 31   :     }
; 32   : //其它字段
; 33   : //i_zone[0]
; 34   : //i_zone[1]
; 35   : //i_zone[2]
; 36   : //i_zone[3]
; 37   : //i_zone[4]
; 38   : //i_zone[5]
; 39   : //i_zone[6]
; 40   : //i 节点
; 41   : //直接块号
; 42   : //一次间接块
; 43   : //二次间接块
; 44   : //的一级块
; 45   : //二次间接块
; 46   : //的二级块
; 47   : //一次间接块号
; 48   : //二次间接块号
; 49   : //i_zone[7]
; 50   : //i_zone[8]
; 51   : // 释放设备上的一次间接块。
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
; 63   : // 如果逻辑块号为0，则返回。
; 64   :   if (!block)

	mov	esi, DWORD PTR _block$[ebp]
	test	esi, esi
	je	SHORT $L583
	push	edi

; 65   :     return;
; 66   : // 读取二次间接块的一级块，并释放其上表明使用的所有逻辑块，然后释放该一级块的缓冲区。
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
; 69   :       p = (unsigned short *) bh->b_data;	// 指向数据缓冲区。

	mov	esi, DWORD PTR [ecx]
	push	ebx
	mov	ebx, 512				; 00000200H
$L590:

; 70   :       for (i = 0; i < 512; i++, p++)	// 每个逻辑块上可连接512 个二级块。
; 71   : 	if (*p)

	mov	ax, WORD PTR [esi]
	test	ax, ax
	je	SHORT $L591

; 72   : 	  free_ind (dev, *p);	// 释放所有一次间接块。

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

; 73   :       brelse (bh);		// 释放缓冲区。

	push	ecx
	call	_brelse
	mov	esi, DWORD PTR _block$[ebp]
	add	esp, 4
	pop	ebx
$L588:

; 74   :     }
; 75   : // 最后释放设备上的二次间接块。
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

; 276  : 		cmp ecx, current/* 任务n 是当前任务吗?(current ==task[n]?) */ 

	cmp	ecx, DWORD PTR _current

; 277  : 		je l1 /* 是，则什么都不做，退出。*/ 

	je	SHORT $l1$499

; 278  : 		xchg ecx,current/* current = task[n]； */

	xchg	ecx, DWORD PTR _current

; 279  : 		/*执行长跳转，造成任务切换 (头大了很长时间，多多包涵)*/
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

; 289  : // 在任务切换回来后才会继续执行下面的语句。
; 290  : 		cmp last_task_used_math,ecx /* 新任务上次使用过协处理器吗？*/

	cmp	DWORD PTR _last_task_used_math, ecx

; 291  : 		jne l1

	jne	SHORT $l1$499

; 292  : 		clts/* 新任务上次使用过协处理器，则清cr0 的TS 标志。*/

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
END
