	TITLE	..\fs\char_dev.c
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
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_DATA	SEGMENT
_crw_table DD	00H
	DD	FLAT:_rw_memory
	DD	00H
	DD	00H
	DD	FLAT:_rw_ttyx
	DD	FLAT:_rw_tty
	DD	00H
	DD	00H
_DATA	ENDS
EXTRN	_tty_write:NEAR
EXTRN	_tty_read:NEAR
_TEXT	SEGMENT
_rw$ = 8
_minor$ = 12
_buf$ = 16
_count$ = 20
_rw_ttyx PROC NEAR

; 35   : {

	push	ebp
	mov	ebp, esp

; 36   : 	return ((rw==READ)?tty_read(minor,buf,count):
; 37   : 		tty_write(minor,buf,count));

	mov	eax, DWORD PTR _rw$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	mov	edx, DWORD PTR _minor$[ebp]
	test	eax, eax
	mov	eax, DWORD PTR _count$[ebp]
	push	eax
	push	ecx
	push	edx
	jne	SHORT $L774
	call	_tty_read
	add	esp, 12					; 0000000cH

; 38   : }

	pop	ebp
	ret	0
$L774:

; 36   : 	return ((rw==READ)?tty_read(minor,buf,count):
; 37   : 		tty_write(minor,buf,count));

	call	_tty_write
	add	esp, 12					; 0000000cH

; 38   : }

	pop	ebp
	ret	0
_rw_ttyx ENDP
_TEXT	ENDS
EXTRN	_current:DWORD
_TEXT	SEGMENT
_rw$ = 8
_buf$ = 16
_count$ = 20
_pos$ = 24
_rw_tty	PROC NEAR

; 43   : {

	push	ebp
	mov	ebp, esp

; 44   : 	// 若进程没有对应的控制终端，则返回出错号。
; 45   : 	if (current->tty<0)

	mov	eax, DWORD PTR _current
	mov	eax, DWORD PTR [eax+616]
	test	eax, eax
	jge	SHORT $L663

; 46   : 		return -EPERM;

	or	eax, -1

; 49   : }

	pop	ebp
	ret	0
$L663:

; 47   : 	// 否则调用终端读写函数rw_ttyx()，并返回实际读写字节数。
; 48   : 	return rw_ttyx(rw,current->tty,buf,count,pos);

	mov	ecx, DWORD PTR _pos$[ebp]
	mov	edx, DWORD PTR _count$[ebp]
	push	ecx
	mov	ecx, DWORD PTR _buf$[ebp]
	push	edx
	mov	edx, DWORD PTR _rw$[ebp]
	push	ecx
	push	eax
	push	edx
	call	_rw_ttyx
	add	esp, 20					; 00000014H

; 49   : }

	pop	ebp
	ret	0
_rw_tty	ENDP
_rw$ = 8
_minor$ = 12
_buf$ = 16
_count$ = 20
_pos$ = 24
_rw_memory PROC NEAR

; 96   : {

	push	ebp
	mov	ebp, esp

; 97   : // 根据内存设备子设备号，分别调用不同的内存读写函数。
; 98   : 	switch(minor) {

	mov	eax, DWORD PTR _minor$[ebp]
	cmp	eax, 4
	ja	SHORT $L734
	jmp	DWORD PTR $L779[eax*4]
$L729:

; 99   : 		case 0:
; 100  : 			return rw_ram(rw,buf,count,pos);

	mov	eax, DWORD PTR _pos$[ebp]
	mov	ecx, DWORD PTR _count$[ebp]
	mov	edx, DWORD PTR _buf$[ebp]
	push	eax
	mov	eax, DWORD PTR _rw$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_rw_ram
	add	esp, 16					; 00000010H

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
$L730:

; 101  : 		case 1:
; 102  : 			return rw_mem(rw,buf,count,pos);

	mov	ecx, DWORD PTR _pos$[ebp]
	mov	edx, DWORD PTR _count$[ebp]
	mov	eax, DWORD PTR _buf$[ebp]
	push	ecx
	mov	ecx, DWORD PTR _rw$[ebp]
	push	edx
	push	eax
	push	ecx
	call	_rw_mem
	add	esp, 16					; 00000010H

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
$L731:

; 103  : 		case 2:
; 104  : 			return rw_kmem(rw,buf,count,pos);

	mov	edx, DWORD PTR _pos$[ebp]
	mov	eax, DWORD PTR _count$[ebp]
	mov	ecx, DWORD PTR _buf$[ebp]
	push	edx
	mov	edx, DWORD PTR _rw$[ebp]
	push	eax
	push	ecx
	push	edx
	call	_rw_kmem
	add	esp, 16					; 00000010H

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
$L732:

; 105  : 		case 3:
; 106  : 			return (rw==READ)?0:count;	/* rw_null */

	mov	eax, DWORD PTR _rw$[ebp]
	mov	ecx, DWORD PTR _count$[ebp]
	neg	eax
	sbb	eax, eax
	and	eax, ecx

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
$L733:

; 107  : 		case 4:
; 108  : 			return rw_port(rw,buf,count,pos);

	mov	eax, DWORD PTR _pos$[ebp]
	mov	ecx, DWORD PTR _count$[ebp]
	mov	edx, DWORD PTR _buf$[ebp]
	push	eax
	mov	eax, DWORD PTR _rw$[ebp]
	push	ecx
	push	edx
	push	eax
	call	_rw_port
	add	esp, 16					; 00000010H

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
$L734:

; 109  : 		default:
; 110  : 			return -EIO;

	mov	eax, -5					; fffffffbH

; 111  : 	}
; 112  : }

	pop	ebp
	ret	0
	npad	1
$L779:
	DD	$L729
	DD	$L730
	DD	$L731
	DD	$L732
	DD	$L733
_rw_memory ENDP
_rw_ram	PROC NEAR

; 54   : 	return -EIO;

	mov	eax, -5					; fffffffbH

; 55   : }

	ret	0
_rw_ram	ENDP
_rw_mem	PROC NEAR

; 60   : 	return -EIO;

	mov	eax, -5					; fffffffbH

; 61   : }

	ret	0
_rw_mem	ENDP
_rw_kmem PROC NEAR

; 66   : 	return -EIO;

	mov	eax, -5					; fffffffbH

; 67   : }

	ret	0
_rw_kmem ENDP
_rw$ = 8
_buf$ = 12
_count$ = 16
_pos$ = 20
_i$ = -4
$T787 = 19
$T791 = 12
$T795 = 16
$T796 = 19
_rw_port PROC NEAR

; 73   : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 74   : 	int i=*pos;

	mov	eax, DWORD PTR _pos$[ebp]
	push	ebx
	push	esi

; 77   : 	while (count-->0 && i<65536) {

	mov	esi, DWORD PTR _count$[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	edx, esi
	dec	esi
	push	edi
	test	edx, edx
	mov	DWORD PTR _i$[ebp], ecx
	jle	SHORT $L707
	mov	edi, DWORD PTR _buf$[ebp]
$L706:
	cmp	ecx, 65536				; 00010000H
	jge	SHORT $L707

; 79   : 		if (rw==READ)

	mov	eax, DWORD PTR _rw$[ebp]
	test	eax, eax
	jne	SHORT $L708

; 80   : 			put_fs_byte(inb(i),buf++);

	mov	DWORD PTR $T791[ebp], edi

; 75   : 

	mov	dx, WORD PTR _i$[ebp]

; 76   : // 对于所要求读写的字节数，并且端口地址小于64k 时，循环执行单个字节的读写操作。

	in	al, dx

; 80   : 			put_fs_byte(inb(i),buf++);

	mov	BYTE PTR $T787[ebp], al
	inc	edi

; 75   : 

	mov	ebx, DWORD PTR $T791[ebp]

; 76   : // 对于所要求读写的字节数，并且端口地址小于64k 时，循环执行单个字节的读写操作。

	mov	al, BYTE PTR $T787[ebp]

; 77   : 	while (count-->0 && i<65536) {

	mov	BYTE PTR fs:[ebx], al

; 81   : // 若是写命令，则从用户数据缓冲区中取一字节输出到端口i。
; 82   : 		else

	jmp	SHORT $L798
$L708:

; 83   : 			outb(get_fs_byte(buf++),i);

	mov	DWORD PTR $T795[ebp], edi
	inc	edi

; 77   : 	while (count-->0 && i<65536) {

	mov	ebx, DWORD PTR $T795[ebp]

; 78   : // 若是读命令，则从端口i 中读取一字节内容并放到用户缓冲区中。

	mov	al, BYTE PTR fs:[ebx]

; 83   : 			outb(get_fs_byte(buf++),i);

	mov	BYTE PTR $T796[ebp], al

; 74   : 	int i=*pos;

	mov	dx, WORD PTR _i$[ebp]

; 75   : 

	mov	al, BYTE PTR $T796[ebp]

; 76   : // 对于所要求读写的字节数，并且端口地址小于64k 时，循环执行单个字节的读写操作。

	out	dx, al

; 83   : 			outb(get_fs_byte(buf++),i);

$L798:

; 84   : // 前移一个端口。[??]
; 85   : 		i++;

	inc	ecx
	mov	eax, esi
	dec	esi
	mov	DWORD PTR _i$[ebp], ecx
	test	eax, eax
	jg	SHORT $L706
$L707:

; 86   : 	}
; 87   : // 计算读/写的字节数，并相应调整读写指针。
; 88   : 	i -= *pos;

	mov	edx, DWORD PTR _pos$[ebp]
	pop	edi
	pop	esi
	pop	ebx
	mov	eax, DWORD PTR [edx]
	sub	ecx, eax

; 89   : 	*pos += i;

	add	eax, ecx
	mov	DWORD PTR [edx], eax

; 90   : // 返回读/写的字节数。
; 91   : 	return i;

	mov	eax, ecx

; 92   : }

	mov	esp, ebp
	pop	ebp
	ret	0
_rw_port ENDP
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
PUBLIC	_rw_char
_TEXT	SEGMENT
_rw$ = 8
_dev$ = 12
_buf$ = 16
_count$ = 20
_pos$ = 24
_rw_char PROC NEAR

; 132  : {

	push	ebp
	mov	ebp, esp

; 133  : 	crw_ptr call_addr;
; 134  : 
; 135  : // 如果设备号超出系统设备数，则返回出错码。
; 136  : 	if (MAJOR(dev)>=NRDEVS)

	mov	eax, DWORD PTR _dev$[ebp]
	mov	ecx, eax
	and	cl, 0
	cmp	ecx, 2048				; 00000800H
	jb	SHORT $L751

; 137  : 		return -ENODEV;

	mov	eax, -19				; ffffffedH

; 143  : }

	pop	ebp
	ret	0
$L751:

; 138  : // 若该设备没有对应的读/写函数，则返回出错码。
; 139  : 	if (!(call_addr=crw_table[MAJOR(dev)]))

	mov	edx, eax
	shr	edx, 8
	mov	ecx, DWORD PTR _crw_table[edx*4]
	test	ecx, ecx
	jne	SHORT $L753

; 140  : 		return -ENODEV;

	mov	eax, -19				; ffffffedH

; 143  : }

	pop	ebp
	ret	0
$L753:

; 141  : // 调用对应设备的读写操作函数，并返回实际读/写的字节数。
; 142  : 	return call_addr(rw,MINOR(dev),buf,count,pos);

	mov	edx, DWORD PTR _pos$[ebp]
	and	eax, 255				; 000000ffH
	push	edx
	mov	edx, DWORD PTR _count$[ebp]
	push	edx
	mov	edx, DWORD PTR _buf$[ebp]
	push	edx
	push	eax
	mov	eax, DWORD PTR _rw$[ebp]
	push	eax
	call	ecx
	add	esp, 20					; 00000014H

; 143  : }

	pop	ebp
	ret	0
_rw_char ENDP
_TEXT	ENDS
PUBLIC	_switch_to
EXTRN	_task:BYTE
EXTRN	_last_task_used_math:DWORD
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
END
