	TITLE	..\kernel\blk_drv\floppy.c
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
;	COMDAT ??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
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
;	COMDAT __set_gate
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __set_tssldt_desc
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __outb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __inb_p
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
;	COMDAT _unlock_buffer
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _end_request
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _immoutb_p
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _copy_buffer
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _setup_rw_floppy
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_do_floppy
PUBLIC	_selected
PUBLIC	_wait_on_floppy_select
_BSS	SEGMENT
_do_floppy DD	01H DUP (?)
_recalibrate DD	01H DUP (?)
_reset	DD	01H DUP (?)
_seek	DD	01H DUP (?)
_reply_buffer DB 07H DUP (?)
	ALIGN	4

_current_drive DB 01H DUP (?)
	ALIGN	4

_sector	DB	01H DUP (?)
	ALIGN	4

_head	DB	01H DUP (?)
	ALIGN	4

_track	DB	01H DUP (?)
	ALIGN	4

_seek_track DB	01H DUP (?)
	ALIGN	4

_command DB	01H DUP (?)
	ALIGN	4

_selected DB	01H DUP (?)
	ALIGN	4

_wait_on_floppy_select DD 01H DUP (?)
_BSS	ENDS
_DATA	SEGMENT
_floppy_type DD	00H
	DD	00H
	DD	00H
	DD	00H
	DD	00H
	DB	00H
	DB	00H
	DB	00H
	ORG $+1
	DD	02d0H
	DD	09H
	DD	02H
	DD	028H
	DD	00H
	DB	02aH
	DB	02H
	DB	0dfH
	ORG $+1
	DD	0960H
	DD	0fH
	DD	02H
	DD	050H
	DD	00H
	DB	01bH
	DB	00H
	DB	0dfH
	ORG $+1
	DD	02d0H
	DD	09H
	DD	02H
	DD	028H
	DD	01H
	DB	02aH
	DB	02H
	DB	0dfH
	ORG $+1
	DD	05a0H
	DD	09H
	DD	02H
	DD	050H
	DD	00H
	DB	02aH
	DB	02H
	DB	0dfH
	ORG $+1
	DD	02d0H
	DD	09H
	DD	02H
	DD	028H
	DD	01H
	DB	023H
	DB	01H
	DB	0dfH
	ORG $+1
	DD	05a0H
	DD	09H
	DD	02H
	DD	050H
	DD	00H
	DB	023H
	DB	01H
	DB	0dfH
	ORG $+1
	DD	0b40H
	DD	012H
	DD	02H
	DD	050H
	DD	00H
	DB	01bH
	DB	00H
	DB	0cfH
	ORG $+1
_cur_spec1 DD	0ffffffffH
_cur_rate DD	0ffffffffH
_floppy	DD	FLAT:_floppy_type
_current_track DB 0ffH
_DATA	ENDS
PUBLIC	_floppy_deselect
EXTRN	_wake_up:NEAR
EXTRN	_printk:NEAR
EXTRN	_current_DOR:BYTE
_DATA	SEGMENT
	ORG $+3
$SG724	DB	'floppy_deselect: drive not selected', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_nr$ = 8
_floppy_deselect PROC NEAR

; 148  : {

	push	ebp
	mov	ebp, esp

; 149  : 	if (nr != (unsigned int)(current_DOR & 3))

	mov	al, BYTE PTR _current_DOR
	mov	ecx, DWORD PTR _nr$[ebp]
	and	eax, 3
	cmp	ecx, eax
	je	SHORT $L723

; 150  : 		printk ("floppy_deselect: drive not selected\n\r");

	push	OFFSET FLAT:$SG724
	call	_printk
	add	esp, 4
$L723:

; 151  : 	selected = 0;
; 152  : 	wake_up (&wait_on_floppy_select);

	push	OFFSET FLAT:_wait_on_floppy_select
	mov	BYTE PTR _selected, 0
	call	_wake_up
	add	esp, 4

; 153  : }

	pop	ebp
	ret	0
_floppy_deselect ENDP
_TEXT	ENDS
PUBLIC	_floppy_change
EXTRN	_floppy_on:NEAR
EXTRN	_floppy_off:NEAR
EXTRN	_interruptible_sleep_on:NEAR
_TEXT	SEGMENT
_nr$ = 8
$T933 = 8
_floppy_change PROC NEAR

; 163  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 164  : repeat:
; 165  : 	floppy_on (nr);		// 开启指定软驱nr（kernel/sched.c,251）。

	mov	esi, DWORD PTR _nr$[ebp]
$repeat$728:
	push	esi
	call	_floppy_on

; 167  : // 等待状态。
; 168  : 	while ((unsigned int)(current_DOR & 3) != nr && selected)

	mov	al, BYTE PTR _current_DOR
	add	esp, 4
	mov	cl, al
	and	ecx, 3
	cmp	ecx, esi
	je	SHORT $L732
$L731:
	mov	cl, BYTE PTR _selected
	test	cl, cl
	je	SHORT $L732

; 169  : 		interruptible_sleep_on (&wait_on_floppy_select);

	push	OFFSET FLAT:_wait_on_floppy_select
	call	_interruptible_sleep_on
	mov	al, BYTE PTR _current_DOR
	add	esp, 4
	mov	dl, al
	and	edx, 3
	cmp	edx, esi
	jne	SHORT $L731
$L732:

; 170  : // 如果当前没有选择其它软驱或者当前任务被唤醒时，当前软驱仍然不是指定的软驱nr，则循环等待。
; 171  : 	if ((unsigned int)(current_DOR & 3) != nr)

	and	eax, 3
	cmp	eax, esi

; 172  : 		goto repeat;

	jne	SHORT $repeat$728

; 173  : // 取数字输入寄存器值，如果最高位（位7）置位，则表示软盘已更换，此时关闭马达并退出返回1。
; 174  : // 否则关闭马达退出返回0。
; 175  : 	if (inb (FD_DIR) & 0x80)

	mov	DWORD PTR $T933[ebp], 1015		; 000003f7H

; 164  : repeat:
; 165  : 	floppy_on (nr);		// 开启指定软驱nr（kernel/sched.c,251）。

	mov	dx, WORD PTR $T933[ebp]

; 166  : // 如果当前选择的软驱不是指定的软驱nr，并且已经选择其它了软驱，则让当前任务进入可中断

	in	al, dx

; 173  : // 取数字输入寄存器值，如果最高位（位7）置位，则表示软盘已更换，此时关闭马达并退出返回1。
; 174  : // 否则关闭马达退出返回0。
; 175  : 	if (inb (FD_DIR) & 0x80)

	test	al, 128					; 00000080H

; 176  : 	{
; 177  : 		floppy_off (nr);

	push	esi
	je	SHORT $L736
	call	_floppy_off
	add	esp, 4

; 178  : 		return 1;

	mov	eax, 1
	pop	esi

; 182  : }

	pop	ebp
	ret	0
$L736:

; 179  : 	}
; 180  : 	floppy_off (nr);

	call	_floppy_off
	add	esp, 4

; 181  : 	return 0;

	xor	eax, eax
	pop	esi

; 182  : }

	pop	ebp
	ret	0
_floppy_change ENDP
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
PUBLIC	_unlock_buffer
PUBLIC	??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
;	COMDAT ??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@
; File ..\kernel\blk_drv\blk.h
_DATA	SEGMENT
??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ DB 'floppy: free bu'
	DB	'ffer being unlocked', 0aH, 00H		; `string'
_DATA	ENDS
;	COMDAT _unlock_buffer
_TEXT	SEGMENT
_bh$ = 8
_unlock_buffer PROC NEAR				; COMDAT

; 102  : {

	push	ebp
	mov	ebp, esp
	push	esi

; 103  :   if (!bh->b_lock)		// 如果指定的缓冲区bh 并没有被上锁，则显示警告信息。

	mov	esi, DWORD PTR _bh$[ebp]
	mov	al, BYTE PTR [esi+13]
	test	al, al
	jne	SHORT $L671

; 104  :     printk (DEVICE_NAME ": free buffer being unlocked\n");

	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L671:

; 105  :   bh->b_lock = 0;		// 否则将该缓冲区解锁。

	mov	BYTE PTR [esi+13], 0

; 106  :   wake_up (&bh->b_wait);	// 唤醒等待该缓冲区的进程。

	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
	pop	esi

; 107  : }

	pop	ebp
	ret	0
_unlock_buffer ENDP
_TEXT	ENDS
PUBLIC	_unexpected_floppy_interrupt
_TEXT	SEGMENT
_unexpected_floppy_interrupt PROC NEAR

; 489  : 	output_byte (FD_SENSEI);	// 发送检测中断状态命令。

	push	8
	call	_output_byte
	add	esp, 4

; 490  : 	if (result () != 2 || (ST0 & 0xE0) == 0x60)	// 如果返回结果字节数不等于2 或命令

	call	_result
	cmp	eax, 2
	jne	SHORT $L839
	mov	al, BYTE PTR _reply_buffer
	and	al, 224					; 000000e0H
	cmp	al, 96					; 00000060H
	je	SHORT $L839

; 492  : 	else				// 否则置重新校正标志。
; 493  : 		recalibrate = 1;

	mov	DWORD PTR _recalibrate, 1

; 494  : }

	ret	0
$L839:

; 491  : 		reset = 1;			// 异常结束，则置复位标志。

	mov	DWORD PTR _reset, 1

; 494  : }

	ret	0
_unexpected_floppy_interrupt ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+2
$SG774	DB	'Unable to send byte to FDC', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_byte$ = 8
$T964 = -4
$T969 = -4
_output_byte PROC NEAR

; 262  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 266  : 	if (reset)

	mov	eax, DWORD PTR _reset
	test	eax, eax
	jne	SHORT $L763

; 270  : 	for (counter = 0; counter < 10000; counter++)

	xor	ecx, ecx

; 271  : 	{
; 272  : 		status = inb_p (FD_STATUS) & (STATUS_READY | STATUS_DIR);

	mov	DWORD PTR $T964[ebp], 1012		; 000003f4H
$L767:

; 265  : 

	mov	dx, WORD PTR $T964[ebp]

; 266  : 	if (reset)

	in	al, dx

; 267  : 		return;
; 268  : // 循环读取主状态控制器FD_STATUS(0x3f4)的状态。如果状态是STATUS_READY 并且STATUS_DIR=0

	jmp	SHORT $l1$961
$l1$961:

; 269  : // (CPU??FDC)，则向数据端口输出指定字节。

	jmp	SHORT $l2$962
$l2$962:

; 271  : 	{
; 272  : 		status = inb_p (FD_STATUS) & (STATUS_READY | STATUS_DIR);

	and	al, 192					; 000000c0H

; 273  : 		if (status == STATUS_READY)

	cmp	al, 128					; 00000080H
	je	SHORT $L971
	inc	ecx
	cmp	ecx, 10000				; 00002710H
	jl	SHORT $L767

; 276  : 			return;
; 277  : 		}
; 278  : 	}
; 279  : // 如果到循环1 万次结束还不能发送，则置复位标志，并打印出错信息。
; 280  : 	reset = 1;
; 281  : 	printk ("Unable to send byte to FDC\n\r");

	push	OFFSET FLAT:$SG774
	mov	DWORD PTR _reset, 1
	call	_printk
	add	esp, 4
$L763:

; 282  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L971:

; 274  : 		{
; 275  : 			outb (byte, FD_DATA);

	mov	DWORD PTR $T969[ebp], 1013		; 000003f5H

; 263  : 	int counter;

	mov	dx, WORD PTR $T969[ebp]

; 264  : 	unsigned char status;

	mov	al, BYTE PTR _byte$[ebp]

; 265  : 

	out	dx, al

; 282  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_output_byte ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+3
$SG790	DB	'Getstatus times out', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T979 = -4
$T986 = -8
_result	PROC NEAR

; 289  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 290  : 	int i = 0, counter, status;
; 291  : 
; 292  : 	if (reset)

	mov	eax, DWORD PTR _reset
	xor	ecx, ecx
	test	eax, eax
	push	esi

; 293  : 		return -1;

	jne	SHORT $L992

; 294  : 	for (counter = 0; counter < 10000; counter++)

	xor	esi, esi

; 296  : 		status = inb_p (FD_STATUS) & (STATUS_DIR | STATUS_READY | STATUS_BUSY);

	mov	DWORD PTR $T979[ebp], 1012		; 000003f4H
$L782:

; 290  : 	int i = 0, counter, status;
; 291  : 
; 292  : 	if (reset)

	mov	dx, WORD PTR $T979[ebp]

; 293  : 		return -1;

	in	al, dx

; 295  : 	{

	jmp	SHORT $l1$976
$l1$976:

; 296  : 		status = inb_p (FD_STATUS) & (STATUS_DIR | STATUS_READY | STATUS_BUSY);

	jmp	SHORT $l2$977
$l2$977:
	and	eax, 208				; 000000d0H

; 297  : 		if (status == STATUS_READY)

	cmp	eax, 128				; 00000080H
	je	SHORT $L989

; 299  : 		if (status == (STATUS_DIR | STATUS_READY | STATUS_BUSY))

	cmp	eax, 208				; 000000d0H
	jne	SHORT $L783

; 300  : 		{
; 301  : 			if (i >= MAX_REPLIES)

	cmp	ecx, 7
	jge	SHORT $L990

; 302  : 				break;
; 303  : 			reply_buffer[i++] = inb_p (FD_DATA);

	mov	DWORD PTR $T986[ebp], 1013		; 000003f5H

; 290  : 	int i = 0, counter, status;
; 291  : 
; 292  : 	if (reset)

	mov	dx, WORD PTR $T986[ebp]

; 293  : 		return -1;

	in	al, dx

; 295  : 	{

	jmp	SHORT $l1$983
$l1$983:

; 296  : 		status = inb_p (FD_STATUS) & (STATUS_DIR | STATUS_READY | STATUS_BUSY);

	jmp	SHORT $l2$984
$l2$984:

; 302  : 				break;
; 303  : 			reply_buffer[i++] = inb_p (FD_DATA);

	mov	BYTE PTR _reply_buffer[ecx], al
	inc	ecx
$L783:
	inc	esi
	cmp	esi, 10000				; 00002710H
	jl	SHORT $L782
$L990:

; 304  : 		}
; 305  : 	}
; 306  : 	reset = 1;
; 307  : 	printk ("Getstatus times out\n\r");

	push	OFFSET FLAT:$SG790
	mov	DWORD PTR _reset, 1
	call	_printk
	add	esp, 4
$L992:

; 308  : 	return -1;

	or	eax, -1
	pop	esi

; 309  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L989:

; 298  : 			return i;

	mov	eax, ecx
	pop	esi

; 309  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_result	ENDP
_TEXT	ENDS
PUBLIC	_end_request
PUBLIC	??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@	; `string'
PUBLIC	??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
EXTRN	_blk_dev:BYTE
EXTRN	_wait_for_request:DWORD
;	COMDAT ??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@
; File ..\kernel\blk_drv\blk.h
_DATA	SEGMENT
??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@ DB 'floppy I/O error', 0aH, 0dH
	DB	00H						; `string'
_DATA	ENDS
;	COMDAT ??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@
_DATA	SEGMENT
??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ DB 'dev %04x, bloc'
	DB	'k %d', 0aH, 0dH, 00H			; `string'
_DATA	ENDS
;	COMDAT _end_request
_TEXT	SEGMENT
_uptodate$ = 8
_end_request PROC NEAR					; COMDAT

; 112  : {

	push	ebp
	mov	ebp, esp

; 113  :   DEVICE_OFF (CURRENT->dev);	// 关闭设备。

	mov	eax, DWORD PTR _blk_dev+20
	push	ebx
	push	esi
	mov	ecx, DWORD PTR [eax]
	and	ecx, 3
	push	ecx
	call	_floppy_off

; 114  :   if (CURRENT->bh)

	mov	edx, DWORD PTR _blk_dev+20
	mov	ebx, DWORD PTR _uptodate$[ebp]
	add	esp, 4
	mov	esi, DWORD PTR [edx+28]
	test	esi, esi
	je	SHORT $L995

; 115  :     {				// CURRENT 为指定主设备号的当前请求结构。
; 116  :       CURRENT->bh->b_uptodate = uptodate;	// 置更新标志。
; 117  :       unlock_buffer (CURRENT->bh);	// 解锁缓冲区。

	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	test	al, al
	jne	SHORT $L996
	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L996:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L995:
	pop	esi

; 118  :     }
; 119  :   if (!uptodate)

	test	ebx, ebx
	pop	ebx
	jne	SHORT $L678

; 120  :     {				// 如果更新标志为0 则显示设备错误信息。
; 121  :       printk (DEVICE_NAME " I/O error\n\r");

	push	OFFSET FLAT:??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk

; 122  :       printk ("dev %04x, block %d\n\r", CURRENT->dev, CURRENT->bh->b_blocknr);

	mov	eax, DWORD PTR _blk_dev+20
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	add	esp, 16					; 00000010H
$L678:

; 123  :     }
; 124  :   wake_up (&CURRENT->waiting);	// 唤醒等待该请求项的进程。

	mov	ecx, DWORD PTR _blk_dev+20
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up

; 125  :   wake_up (&wait_for_request);	// 唤醒等待请求的进程。

	push	OFFSET FLAT:_wait_for_request
	call	_wake_up

; 126  :   CURRENT->dev = -1;		// 释放该请求项。

	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 8
	mov	DWORD PTR [eax], -1

; 127  :   CURRENT = CURRENT->next;	// 从请求链表中删除该请求项。

	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+20, edx

; 128  : }

	pop	ebp
	ret	0
_end_request ENDP
_TEXT	ENDS
PUBLIC	_floppy_init
EXTRN	_idt:BYTE
EXTRN	_floppy_interrupt:NEAR
_TEXT	SEGMENT
$T1009 = -8
$T1014 = -1
$T1015 = -8
_floppy_init PROC NEAR

; 628  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 630  : 	set_trap_gate (0x26, &floppy_interrupt);	//设置软盘中断门 int 0x26(38)。

	mov	ecx, OFFSET FLAT:_floppy_interrupt
	mov	eax, OFFSET FLAT:_floppy_interrupt
	and	ecx, -65536				; ffff0000H
	and	eax, 65535				; 0000ffffH
	add	ecx, 36608				; 00008f00H
	add	eax, 524288				; 00080000H
	mov	DWORD PTR _idt+308, ecx

; 631  : 	outb (inb_p (0x21) & ~0x40, 0x21);	// 复位软盘的中断请求屏蔽位，允许

	mov	ecx, 33					; 00000021H
	mov	DWORD PTR _blk_dev+16, OFFSET FLAT:_do_fd_request
	mov	DWORD PTR _idt+304, eax
	mov	DWORD PTR $T1009[ebp], ecx
	mov	dx, WORD PTR $T1009[ebp]

; 632  : 										// 软盘控制器发送中断请求信号。

	in	al, dx
; File ..\include\asm/system.h

; 47   : {// c语句和汇编语句都可以通过

	jmp	SHORT $l1$1006
$l1$1006:

; 48   : 	gate_addr[0] = 0x00080000 + (addr & 0xffff);

	jmp	SHORT $l2$1007
$l2$1007:
; File ..\kernel\blk_drv\floppy.c

; 631  : {

	and	al, 191					; 000000bfH
	mov	DWORD PTR $T1015[ebp], ecx
	mov	BYTE PTR $T1014[ebp], al

; 629  : void

	mov	dx, WORD PTR $T1015[ebp]

; 630  : floppy_init (void)

	mov	al, BYTE PTR $T1014[ebp]

; 631  : {

	out	dx, al

; 633  : 	set_trap_gate (0x26, &floppy_interrupt);	//设置软盘中断门 int 0x26(38)。

	mov	esp, ebp
	pop	ebp
	ret	0
_floppy_init ENDP
_TEXT	ENDS
EXTRN	_ticks_to_floppy_on:NEAR
EXTRN	_panic:NEAR
EXTRN	_add_timer:NEAR
_DATA	SEGMENT
	ORG $+2
$SG877	DB	'floppy: request list destroyed', 00H
	ORG $+1
$SG880	DB	'floppy: block not locked', 00H
	ORG $+3
$SG888	DB	'do_fd_request: unknown command', 00H
_DATA	ENDS
_TEXT	SEGMENT
_do_fd_request PROC NEAR

; 570  : 	unsigned int block;
; 571  : 
; 572  : 	seek = 0;
; 573  : // 如果复位标志已置位，则执行软盘复位操作，并返回。
; 574  : 	if (reset)

	mov	eax, DWORD PTR _reset
	push	ebx
	xor	ebx, ebx
	push	esi
	cmp	eax, ebx
	push	edi
	mov	DWORD PTR _seek, ebx
	je	SHORT $L871

; 575  : 	{
; 576  : 		reset_floppy ();

	call	_reset_floppy
	pop	edi
	pop	esi
	pop	ebx

; 621  : }

	ret	0
$L871:

; 577  : 		return;
; 578  : 	}
; 579  : // 如果重新校正标志已置位，则执行软盘重新校正操作，并返回。
; 580  : 	if (recalibrate)

	cmp	DWORD PTR _recalibrate, ebx
	je	SHORT $L1031

; 581  : 	{
; 582  : 		recalibrate_floppy ();

	call	_recalibrate_floppy
	pop	edi
	pop	esi
	pop	ebx

; 621  : }

	ret	0
$L1031:

; 583  : 		return;
; 584  : 	}
; 585  : // 检测请求项的合法性(参见kernel/blk_drv/blk.h,127)。
; 586  : 	INIT_REQUEST;

	mov	esi, DWORD PTR _blk_dev+20
	cmp	esi, ebx
	je	$L869
$repeat$873:
	mov	eax, DWORD PTR [esi]
	and	al, 0
	cmp	eax, 512				; 00000200H
	je	SHORT $L876
	push	OFFSET FLAT:$SG877
	call	_panic
	mov	esi, DWORD PTR _blk_dev+20
	add	esp, 4
$L876:
	mov	eax, DWORD PTR [esi+28]
	cmp	eax, ebx
	je	SHORT $L879
	cmp	BYTE PTR [eax+13], bl
	jne	SHORT $L879
	push	OFFSET FLAT:$SG880
	call	_panic
	mov	esi, DWORD PTR _blk_dev+20
	add	esp, 4
$L879:

; 587  : // 将请求项结构中软盘设备号中的软盘类型(MINOR(CURRENT->dev)>>2)作为索引取得软盘参数块。
; 588  : 	floppy = (MINOR (CURRENT->dev) >> 2) + floppy_type;

	mov	edx, DWORD PTR [esi]
	mov	eax, edx

; 589  : // 如果当前驱动器不是请求项中指定的驱动器，则置标志seek，表示需要进行寻道操作。
; 590  : // 然后置请求项设备为当前驱动器。
; 591  : 	if (current_drive != CURRENT_DEV)

	and	edx, 3
	sar	eax, 2
	and	eax, 63					; 0000003fH
	lea	ecx, DWORD PTR [eax+eax*2]
	xor	eax, eax
	mov	al, BYTE PTR _current_drive
	lea	ecx, DWORD PTR _floppy_type[ecx*8]
	cmp	eax, edx
	mov	DWORD PTR _floppy, ecx
	je	SHORT $L881

; 592  : 		seek = 1;

	mov	DWORD PTR _seek, 1
$L881:

; 593  : 	current_drive = CURRENT_DEV;

	mov	al, BYTE PTR [esi]

; 594  : // 设置读写起始扇区。因为每次读写是以块为单位（1 块2 个扇区），所以起始扇区需要起码比
; 595  : // 磁盘总扇区数小2 个扇区。否则结束该次软盘请求项，执行下一个请求项。
; 596  : 	block = CURRENT->sector;	// 取当前软盘请求项中起始扇区号??block。

	mov	edi, DWORD PTR [esi+12]
	and	al, 3
	mov	BYTE PTR _current_drive, al

; 597  : 	if (block + 2 > floppy->size)

	lea	eax, DWORD PTR [edi+2]
	cmp	eax, DWORD PTR [ecx]
	jbe	$L882

; 598  : 	{				// 如果block+2 大于磁盘扇区总数，则
; 599  : 		end_request (0);		// 结束本次软盘请求项。

	push	edx
	call	_floppy_off
	mov	ecx, DWORD PTR _blk_dev+20
	add	esp, 4
	mov	esi, DWORD PTR [ecx+28]
	cmp	esi, ebx
	je	SHORT $L1034
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], bl
	cmp	al, bl
	jne	SHORT $L1028
	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L1028:
	mov	BYTE PTR [esi+13], bl
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1034:
	push	OFFSET FLAT:??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+20
	mov	edx, DWORD PTR [eax+28]
	mov	ecx, DWORD PTR [edx+4]
	mov	edx, DWORD PTR [eax]
	push	ecx
	push	edx
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+20
	add	eax, 24					; 00000018H
	push	eax
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 24					; 00000018H
	mov	DWORD PTR [eax], -1
	mov	esi, DWORD PTR [eax+32]
	cmp	esi, ebx
	mov	DWORD PTR _blk_dev+20, esi
	jne	$repeat$873
	pop	edi
	pop	esi
	pop	ebx

; 621  : }

	ret	0
$L882:

; 600  : 		goto repeat;
; 601  : 	}
; 602  : // 求对应在磁道上的扇区号，磁头号，磁道号，搜寻磁道号（对于软驱读不同格式的盘）。
; 603  : 	sector = block % floppy->sect;	// 起始扇区对每磁道扇区数取模，得磁道上扇区号。

	mov	ebx, DWORD PTR [ecx+4]
	mov	eax, edi
	xor	edx, edx
	div	ebx

; 604  : 	block /= floppy->sect;	// 起始扇区对每磁道扇区数取整，得起始磁道数。

	mov	eax, edi
	mov	BYTE PTR _sector, dl
	xor	edx, edx
	div	ebx

; 605  : 	head = block % floppy->head;	// 起始磁道数对磁头数取模，得操作的磁头号。

	mov	ebx, DWORD PTR [ecx+8]
	xor	edx, edx

; 606  : 	track = block / floppy->head;	// 起始磁道数对磁头数取整，得操作的磁道号。
; 607  : 	seek_track = track << floppy->stretch;	// 相应于驱动器中盘类型进行调整，得寻道号。

	mov	ecx, DWORD PTR [ecx+16]
	mov	edi, eax
	div	ebx
	mov	eax, edi
	mov	BYTE PTR _head, dl
	xor	edx, edx
	div	ebx
	mov	BYTE PTR _track, al
	shl	al, cl

; 608  : // 如果寻道号与当前磁头所在磁道不同，则置需要寻道标志seek。
; 609  : 	if (seek_track != current_track)

	mov	cl, BYTE PTR _current_track
	cmp	al, cl
	mov	BYTE PTR _seek_track, al
	je	SHORT $L883

; 610  : 		seek = 1;

	mov	DWORD PTR _seek, 1
$L883:

; 611  : 	sector++;			// 磁盘上实际扇区计数是从1 算起。

	mov	cl, BYTE PTR _sector

; 612  : 	if (CURRENT->cmd == READ)	// 如果请求项中是读操作，则置软盘读命令码。

	mov	esi, DWORD PTR [esi+4]
	inc	cl
	test	esi, esi
	mov	BYTE PTR _sector, cl
	jne	SHORT $L884

; 613  : 		command = FD_READ;

	mov	BYTE PTR _command, 230			; 000000e6H

; 614  : 	else if (CURRENT->cmd == WRITE)	// 如果请求项中是写操作，则置软盘写命令码。

	jmp	SHORT $L887
$L884:
	cmp	esi, 1
	jne	SHORT $L886

; 615  : 		command = FD_WRITE;

	mov	BYTE PTR _command, 197			; 000000c5H

; 616  : 	else

	jmp	SHORT $L887
$L886:

; 617  : 		panic ("do_fd_request: unknown command");

	push	OFFSET FLAT:$SG888
	call	_panic
	add	esp, 4
$L887:

; 618  : // 添加定时器，用于指定驱动器到能正常运行所需延迟的时间（滴答数），当定时时间到时就调用
; 619  : // 函数floppy_on_interrupt()，
; 620  : 	add_timer (ticks_to_floppy_on (current_drive), &floppy_on_interrupt);

	xor	ecx, ecx
	push	OFFSET FLAT:_floppy_on_interrupt
	mov	cl, BYTE PTR _current_drive
	push	ecx
	call	_ticks_to_floppy_on
	add	esp, 4
	push	eax
	call	_add_timer
	add	esp, 8
$L869:
	pop	edi
	pop	esi
	pop	ebx

; 621  : }

	ret	0
_do_fd_request ENDP
_recalibrate_floppy PROC NEAR

; 501  : 	recalibrate = 0;		// 复位重新校正标志。
; 502  : 	current_track = 0;		// 当前磁道号归零。
; 503  : 	do_floppy = recal_interrupt;	// 置软盘中断调用函数指针指向重新校正调用函数。
; 504  : 	output_byte (FD_RECALIBRATE);	// 发送命令：重新校正。

	push	7
	mov	DWORD PTR _recalibrate, 0
	mov	BYTE PTR _current_track, 0
	mov	DWORD PTR _do_floppy, OFFSET FLAT:_recal_interrupt
	call	_output_byte

; 505  : 	output_byte (head << 2 | current_drive);	// 发送参数：（磁头号加）当前驱动器号。

	mov	al, BYTE PTR _head
	mov	cl, BYTE PTR _current_drive
	shl	al, 2
	or	al, cl
	push	eax
	call	_output_byte

; 506  : 	if (reset)			// 如果出错(复位标志被置位)则继续执行软盘请求。

	mov	eax, DWORD PTR _reset
	add	esp, 8
	test	eax, eax
	je	SHORT $L844

; 507  : 		do_fd_request ();

	jmp	_do_fd_request
$L844:

; 508  : }

	ret	0
_recalibrate_floppy ENDP
_recal_interrupt PROC NEAR

; 475  : 	output_byte (FD_SENSEI);	// 发送检测中断状态命令。

	push	8
	call	_output_byte
	add	esp, 4

; 476  : 	if (result () != 2 || (ST0 & 0xE0) == 0x60)	// 如果返回结果字节数不等于2 或命令

	call	_result
	cmp	eax, 2
	jne	SHORT $L833
	mov	al, BYTE PTR _reply_buffer
	and	al, 224					; 000000e0H
	cmp	al, 96					; 00000060H
	je	SHORT $L833

; 478  : 	else				// 否则复位重新校正标志。
; 479  : 		recalibrate = 0;

	mov	DWORD PTR _recalibrate, 0
	jmp	SHORT $L834
$L833:

; 477  : 		reset = 1;			// 异常结束，则置复位标志。

	mov	DWORD PTR _reset, 1
$L834:

; 480  : 	do_fd_request ();		// 执行软盘请求项。

	jmp	_do_fd_request
_recal_interrupt ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+1
$SG853	DB	'Reset-floppy called', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1044 = -1
$T1045 = -8
$T1049 = -8
_reset_floppy PROC NEAR

; 528  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 532  : 	cur_spec1 = -1;

	or	eax, -1

; 534  : 	recalibrate = 1;		// 重新校正标志置位。
; 535  : 	printk ("Reset-floppy called\n\r");	// 显示执行软盘复位操作信息。

	push	OFFSET FLAT:$SG853
	mov	DWORD PTR _reset, 0
	mov	DWORD PTR _cur_spec1, eax
	mov	DWORD PTR _cur_rate, eax
	mov	DWORD PTR _recalibrate, 1
	call	_printk
	add	esp, 4

; 536  : 	cli ();			// 关中断。

	cli

; 537  : 	do_floppy = reset_interrupt;	// 设置在软盘中断处理程序中调用的函数。
; 538  : 	outb_p (current_DOR & ~0x04, FD_DOR);	// 对软盘控制器FDC 执行复位操作。

	mov	al, BYTE PTR _current_DOR
	mov	ecx, 1010				; 000003f2H
	and	al, 251					; 000000fbH
	mov	DWORD PTR _do_floppy, OFFSET FLAT:_reset_interrupt
	mov	DWORD PTR $T1045[ebp], ecx
	mov	BYTE PTR $T1044[ebp], al

; 529  : 	int i;

	mov	al, BYTE PTR $T1044[ebp]

; 530  : 

	mov	dx, WORD PTR $T1045[ebp]

; 531  : 	reset = 0;			// 复位标志置0。

	out	dx, al

; 532  : 	cur_spec1 = -1;

	jmp	SHORT $l1$1042
$l1$1042:

; 533  : 	cur_rate = -1;

	jmp	SHORT $l2$1043
$l2$1043:

; 537  : 	do_floppy = reset_interrupt;	// 设置在软盘中断处理程序中调用的函数。
; 538  : 	outb_p (current_DOR & ~0x04, FD_DOR);	// 对软盘控制器FDC 执行复位操作。

	mov	eax, 100				; 00000064H
$L856:

; 540  : 		_asm nop;

	npad	1

; 539  : 	for (i = 0; i < 100; i++)	// 空操作，延迟。

	dec	eax
	jne	SHORT $L856

; 541  : 	outb (current_DOR, FD_DOR);	// 再启动软盘控制器。

	mov	DWORD PTR $T1049[ebp], ecx

; 529  : 	int i;

	mov	dx, WORD PTR $T1049[ebp]

; 530  : 

	mov	al, BYTE PTR _current_DOR

; 531  : 	reset = 0;			// 复位标志置0。

	out	dx, al

; 542  : 	sti ();			// 开中断。

	sti

; 543  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_reset_floppy ENDP
_reset_interrupt PROC NEAR

; 516  : 	output_byte (FD_SENSEI);	// 发送检测中断状态命令。

	push	8
	call	_output_byte

; 517  : 	(void) result ();		// 读取命令执行结果字节。

	call	_result

; 518  : 	output_byte (FD_SPECIFY);	// 发送设定软驱参数命令。

	push	3
	call	_output_byte

; 519  : 	output_byte (cur_spec1);	/* hut etc */// 发送参数。

	mov	al, BYTE PTR _cur_spec1
	push	eax
	call	_output_byte

; 520  : 	output_byte (6);		/* Head load time =6ms, DMA */

	push	6
	call	_output_byte
	add	esp, 16					; 00000010H

; 521  : 	do_fd_request ();		// 调用执行软盘请求。

	jmp	_do_fd_request
_reset_interrupt ENDP
$T1057 = -4
_floppy_on_interrupt PROC NEAR

; 550  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 554  : // 定时延迟2 个滴答时间，然后调用软盘读写传输函数transfer()。否则直接调用软盘读写传输函数。
; 555  : 	if (current_drive != (current_DOR & 3))

	mov	al, BYTE PTR _current_DOR
	mov	cl, BYTE PTR _current_drive
	mov	dl, al
	mov	BYTE PTR _selected, 1
	and	dl, 3
	cmp	cl, dl
	je	SHORT $L864

; 556  : 	{
; 557  : 		current_DOR &= 0xFC;

	and	al, 252					; 000000fcH

; 558  : 		current_DOR |= current_drive;
; 559  : 		outb (current_DOR, FD_DOR);	// 向数字输出寄存器输出当前DOR。

	mov	DWORD PTR $T1057[ebp], 1010		; 000003f2H
	or	al, cl
	mov	BYTE PTR _current_DOR, al

; 551  : /* 我们不能任意设置选择的软驱，因为这样做可能会引起进程睡眠。我们只是迫使它自己选择 */

	mov	dx, WORD PTR $T1057[ebp]

; 552  :   selected = 1;			// 置已选择当前驱动器标志。

	mov	al, BYTE PTR _current_DOR

; 553  : // 如果当前驱动器号与数字输出寄存器DOR 中的不同，则重新设置DOR 为当前驱动器current_drive。

	out	dx, al

; 560  : 		add_timer (2, &transfer);	// 添加定时器并执行传输函数。

	push	OFFSET FLAT:_transfer
	push	2
	call	_add_timer
	add	esp, 8

; 564  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L864:

; 561  : 	}
; 562  : 	else
; 563  : 		transfer ();		// 执行软盘读写传输函数。

	call	_transfer

; 564  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_floppy_on_interrupt ENDP
$T1064 = -4
_transfer PROC NEAR

; 421  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 424  : 	if (cur_spec1 != floppy->spec1)

	mov	ecx, DWORD PTR _floppy
	xor	eax, eax
	mov	al, BYTE PTR [ecx+22]
	mov	ecx, DWORD PTR _cur_spec1
	cmp	ecx, eax
	je	SHORT $L820

; 427  : 		output_byte (FD_SPECIFY);	// 发送设置磁盘参数命令。

	push	3
	mov	DWORD PTR _cur_spec1, eax
	call	_output_byte

; 428  : 		output_byte (cur_spec1);	/* hut etc */// 发送参数。

	mov	dl, BYTE PTR _cur_spec1
	push	edx
	call	_output_byte

; 429  : 		output_byte (6);		/* Head load time =6ms, DMA */

	push	6
	call	_output_byte
	add	esp, 12					; 0000000cH
$L820:

; 430  : 	}
; 431  : // 判断当前数据传输速率是否与指定驱动器的一致，若不是就发送指定软驱的速率值到数据传输
; 432  : // 速率控制寄存器(FD_DCR)。
; 433  : 	if (cur_rate != floppy->rate)

	mov	ecx, DWORD PTR _floppy
	xor	eax, eax
	mov	al, BYTE PTR [ecx+21]
	mov	ecx, DWORD PTR _cur_rate
	cmp	ecx, eax
	je	SHORT $L1061

; 434  : 		outb_p (cur_rate = floppy->rate, FD_DCR);

	mov	DWORD PTR $T1064[ebp], 1015		; 000003f7H
	mov	DWORD PTR _cur_rate, eax

; 422  : // 首先看当前驱动器参数是否就是指定驱动器的参数，若不是就发送设置驱动器参数命令及相应

	mov	al, BYTE PTR _cur_rate

; 423  : // 参数（参数1：高4 位步进速率，低四位磁头卸载时间；参数2：磁头加载时间）。

	mov	dx, WORD PTR $T1064[ebp]

; 424  : 	if (cur_spec1 != floppy->spec1)

	out	dx, al

; 425  : 	{

	jmp	SHORT $l1$1062
$l1$1062:

; 426  : 		cur_spec1 = floppy->spec1;

	jmp	SHORT $l2$1063
$l2$1063:

; 434  : 		outb_p (cur_rate = floppy->rate, FD_DCR);

$L1061:

; 435  : // 若返回结果信息表明出错，则再调用软盘请求函数，并返回。
; 436  : 	if (reset)

	mov	eax, DWORD PTR _reset
	test	eax, eax

; 437  : 	{
; 438  : 		do_fd_request ();
; 439  : 		return;

	jne	$L1069

; 440  : 	}
; 441  : // 若寻道标志为零（不需要寻道），则设置DMA 并发送相应读写操作命令和参数，然后返回。
; 442  : 	if (!seek)

	mov	eax, DWORD PTR _seek
	test	eax, eax
	jne	$L825

; 443  : 	{
; 444  : 		setup_rw_floppy ();

	call	_setup_DMA
	mov	dl, BYTE PTR _command
	mov	DWORD PTR _do_floppy, OFFSET FLAT:_rw_interrupt
	push	edx
	call	_output_byte
	mov	al, BYTE PTR _head
	mov	cl, BYTE PTR _current_drive
	shl	al, 2
	or	al, cl
	push	eax
	call	_output_byte
	mov	cl, BYTE PTR _track
	push	ecx
	call	_output_byte
	mov	dl, BYTE PTR _head
	push	edx
	call	_output_byte
	mov	al, BYTE PTR _sector
	push	eax
	call	_output_byte
	push	2
	call	_output_byte
	mov	ecx, DWORD PTR _floppy
	mov	dl, BYTE PTR [ecx+4]
	push	edx
	call	_output_byte
	mov	eax, DWORD PTR _floppy
	mov	cl, BYTE PTR [eax+20]
	push	ecx
	call	_output_byte
	push	-1
	call	_output_byte
	mov	eax, DWORD PTR _reset
	add	esp, 36					; 00000024H
	test	eax, eax
	je	SHORT $L828

; 463  : 		do_fd_request ();

	call	_do_fd_request

; 464  : }

	mov	esp, ebp
	pop	ebp
	ret	0
$L825:

; 445  : 		return;
; 446  : 	}
; 447  : // 否则执行寻道处理。置软盘中断处理调用函数为寻道中断函数。
; 448  : 	do_floppy = seek_interrupt;
; 449  : // 如果器始磁道号不等于零则发送磁头寻道命令和参数
; 450  : 	if (seek_track)

	mov	al, BYTE PTR _seek_track
	mov	DWORD PTR _do_floppy, OFFSET FLAT:_seek_interrupt
	test	al, al
	je	SHORT $L826

; 451  : 	{
; 452  : 		output_byte (FD_SEEK);	// 发送磁头寻道命令。

	push	15					; 0000000fH
	call	_output_byte

; 453  : 		output_byte (head << 2 | current_drive);	//发送参数：磁头号+当前软驱号。

	mov	dl, BYTE PTR _head
	mov	cl, BYTE PTR _current_drive
	shl	dl, 2
	or	dl, cl
	push	edx
	call	_output_byte

; 454  : 		output_byte (seek_track);	// 发送参数：磁道号。

	mov	al, BYTE PTR _seek_track
	push	eax
	call	_output_byte
	add	esp, 12					; 0000000cH

; 455  : 	}
; 456  : 	else

	jmp	SHORT $L827
$L826:

; 457  : 	{
; 458  : 		output_byte (FD_RECALIBRATE);	// 发送重新校正命令。

	push	7
	call	_output_byte

; 459  : 		output_byte (head << 2 | current_drive);	//发送参数：磁头号+当前软驱号。

	mov	cl, BYTE PTR _head
	mov	al, BYTE PTR _current_drive
	shl	cl, 2
	or	cl, al
	push	ecx
	call	_output_byte
	add	esp, 8
$L827:

; 460  : 	}
; 461  : // 如果复位标志已置位，则继续执行软盘请求项。
; 462  : 	if (reset)

	mov	eax, DWORD PTR _reset
	test	eax, eax
	je	SHORT $L828
$L1069:

; 463  : 		do_fd_request ();

	call	_do_fd_request
$L828:

; 464  : }

	mov	esp, ebp
	pop	ebp
	ret	0
_transfer ENDP
_TEXT	ENDS
EXTRN	_tmp_floppy_area:BYTE
_TEXT	SEGMENT
$T1074 = -12
$T1080 = -1
$T1081 = -12
$T1087 = -12
$T1093 = -12
$T1099 = -12
$T1105 = -1
$T1106 = -12
$T1112 = -1
$T1113 = -12
$T1119 = -1
$T1120 = -12
_addr$ = -8
_setup_DMA PROC NEAR

; 203  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	eax, DWORD PTR _blk_dev+20
	push	ebx
	push	esi
	push	edi
	mov	ebx, DWORD PTR [eax+20]
	mov	DWORD PTR _addr$[ebp], ebx

; 206  : 	cli ();

	cli

; 209  : 	if (addr >= 0x100000)

	cmp	ebx, 1048576				; 00100000H
	jl	SHORT $L1073

; 211  : 		addr = (long) tmp_floppy_area;
; 212  : 		if (command == FD_WRITE)

	mov	al, BYTE PTR _command
	mov	ebx, OFFSET FLAT:_tmp_floppy_area
	cmp	al, 197					; 000000c5H
	mov	DWORD PTR _addr$[ebp], ebx
	jne	SHORT $L1073

; 213  : 			copy_buffer (CURRENT->buffer, tmp_floppy_area);

	mov	ecx, DWORD PTR _blk_dev+20
	mov	edx, DWORD PTR [ecx+20]
	mov	DWORD PTR $T1074[ebp], edx

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	pushf

; 205  : 

	mov	cx, 256					; 00000100H

; 206  : 	cli ();

	mov	esi, DWORD PTR $T1074[ebp]

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	mov	edi, OFFSET FLAT:_tmp_floppy_area

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	cld

; 209  : 	if (addr >= 0x100000)

	rep	 movsd

; 210  : 	{

	popf

; 213  : 			copy_buffer (CURRENT->buffer, tmp_floppy_area);

$L1073:

; 214  : 	}
; 215  : /* mask DMA 2 *//* 屏蔽DMA 通道2 */
; 216  : // 单通道屏蔽寄存器端口为0x10。位0-1 指定DMA 通道(0--3)，位2：1 表示屏蔽，0 表示允许请求。
; 217  : 	immoutb_p (4 | 2, 10);

	mov	esi, 10					; 0000000aH
	mov	BYTE PTR $T1080[ebp], 6
	mov	DWORD PTR $T1081[ebp], esi

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR $T1080[ebp]

; 205  : 

	mov	dx, WORD PTR $T1081[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1078
$l1$1078:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1079
$l2$1079:

; 218  : /* 输出命令字节。我是不知道为什么，但是每个人（minix，*/
; 219  : /* sanches 和canton）都输出两次，首先是12 口，然后是11 口 */
; 220  : // 下面嵌入汇编代码向DMA 控制器端口12 和11 写方式字（读盘0x46，写盘0x4A）。
; 221  : 	if (command == FD_READ)

	cmp	BYTE PTR _command, 230			; 000000e6H
	jne	SHORT $L751

; 222  : 		_asm mov al,DMA_READ;

	mov	al, 70					; 00000046H

; 223  : 	else

	jmp	SHORT $L752
$L751:

; 224  : 		_asm mov al,DMA_WRITE;

	mov	al, 74					; 0000004aH
$L752:

; 225  : 	_asm {
; 226  : 		out 12,al

	out	12, al					; 0000000cH

; 227  : 		jmp l1

	jmp	SHORT $l1$753
$l1$753:

; 228  : 	l1: jmp l2

	jmp	SHORT $l2$754
$l2$754:

; 229  : 	l2: out 11,al

	out	11, al					; 0000000bH

; 230  : 		jmp l3

	jmp	SHORT $l3$755
$l3$755:

; 231  : 	l3: jmp l4

	jmp	SHORT $l4$756
$l4$756:

; 232  : 	l4:
; 233  : 	}
; 234  : //  __asm__ ("outb %%al,$12\n\tjmp 1f\n1:\tjmp 1f\n1:\t"
; 235  : //	   "outb %%al,$11\n\tjmp 1f\n1:\tjmp 1f\n1:"::
; 236  : //	   "a" ((char) ((command == FD_READ) ? DMA_READ : DMA_WRITE)));
; 237  : /* 8 low bits of addr *//* 地址低0-7 位 */
; 238  : // 向DMA 通道2 写入基/当前地址寄存器（端口4）。
; 239  : 	immoutb_p ((unsigned char)addr, 4);

	mov	ecx, 4
	mov	DWORD PTR $T1087[ebp], ecx

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR _addr$[ebp]

; 205  : 

	mov	dx, WORD PTR $T1087[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1085
$l1$1085:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1086
$l2$1086:

; 240  : 	addr >>= 8;

	sar	ebx, 8
	mov	DWORD PTR _addr$[ebp], ebx

; 241  : /* bits 8-15 of addr *//* 地址高8-15 位 */
; 242  : 	immoutb_p ((unsigned char)addr, 4);

	mov	DWORD PTR $T1093[ebp], ecx

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR _addr$[ebp]

; 205  : 

	mov	dx, WORD PTR $T1093[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1091
$l1$1091:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1092
$l2$1092:

; 243  : 	addr >>= 8;

	sar	ebx, 8
	mov	DWORD PTR _addr$[ebp], ebx

; 244  : /* bits 16-19 of addr *//* 地址16-19 位 */
; 245  : // DMA 只可以在1M 内存空间内寻址，其高16-19 位地址需放入页面寄存器(端口0x81)。
; 246  : 	immoutb_p ((unsigned char)addr, 0x81);

	mov	DWORD PTR $T1099[ebp], 129		; 00000081H

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR _addr$[ebp]

; 205  : 

	mov	dx, WORD PTR $T1099[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1097
$l1$1097:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1098
$l2$1098:

; 247  : /* low 8 bits of count-1 (1024-1=0x3ff) *//* 计数器低8 位(1024-1=0x3ff) */
; 248  : // 向DMA 通道2 写入基/当前字节计数器值（端口5）。
; 249  : 	immoutb_p (0xff, 5);

	mov	ecx, 5
	mov	BYTE PTR $T1105[ebp], 255		; 000000ffH
	mov	DWORD PTR $T1106[ebp], ecx

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR $T1105[ebp]

; 205  : 

	mov	dx, WORD PTR $T1106[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1103
$l1$1103:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1104
$l2$1104:

; 250  : /* high 8 bits of count-1 *//* 计数器高8 位 */
; 251  : // 一次共传输1024 字节（两个扇区）。
; 252  : 	immoutb_p (3, 5);

	mov	DWORD PTR $T1113[ebp], ecx
	mov	BYTE PTR $T1112[ebp], 3

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR $T1112[ebp]

; 205  : 

	mov	dx, WORD PTR $T1113[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1110
$l1$1110:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1111
$l2$1111:

; 253  : /* activate DMA 2 *//* 开启DMA 通道2 的请求 */
; 254  : // 复位对DMA 通道2 的屏蔽，开放DMA2 请求DREQ 信号。
; 255  : 	immoutb_p (0 | 2, 10);

	mov	DWORD PTR $T1120[ebp], esi
	mov	BYTE PTR $T1119[ebp], 2

; 204  : 	long addr = (long) CURRENT->buffer;	// 当前请求项缓冲区所处内存中位置（地址）。

	mov	al, BYTE PTR $T1119[ebp]

; 205  : 

	mov	dx, WORD PTR $T1120[ebp]

; 206  : 	cli ();

	out	dx, al

; 207  : // 如果缓冲区处于内存1M 以上的地方，则将DMA 缓冲区设在临时缓冲区域(tmp_floppy_area 数组)

	jmp	SHORT $l1$1117
$l1$1117:

; 208  : // (因为8237A 芯片只能在1M 地址范围内寻址)。如果是写盘命令，则还需将数据复制到该临时区域。

	jmp	SHORT $l2$1118
$l2$1118:

; 256  : 	sti ();

	sti

; 257  : }

	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	0
_setup_DMA ENDP
_TEXT	ENDS
_DATA	SEGMENT
	ORG $+2
$SG803	DB	'Drive %d is write protected', 0aH, 0dH, 00H
_DATA	ENDS
_TEXT	SEGMENT
$T1139 = -4
_rw_interrupt PROC NEAR

; 337  : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi
	push	edi

; 344  : 	if (result () != 7 || (ST0 & 0xf8) || (ST1 & 0xbf) || (ST2 & 0x73))

	call	_result
	cmp	eax, 7
	mov	al, BYTE PTR _reply_buffer+1
	jne	$L801
	test	BYTE PTR _reply_buffer, 248		; 000000f8H
	jne	$L801
	test	al, 191					; 000000bfH
	jne	$L801
	test	BYTE PTR _reply_buffer+2, 115		; 00000073H
	jne	$L801

; 355  : 		return;
; 356  : 	}
; 357  : // 如果当前请求项的缓冲区位于1M 地址以上，则说明此次软盘读操作的内容还放在临时缓冲区内，
; 358  : // 需要复制到请求项的缓冲区中（因为DMA 只能在1M 地址范围寻址）。
; 359  : 	if (command == FD_READ && (unsigned long) (CURRENT->buffer) >= 0x100000)

	cmp	BYTE PTR _command, 230			; 000000e6H
	jne	SHORT $L1138
	mov	eax, DWORD PTR _blk_dev+20
	mov	eax, DWORD PTR [eax+20]
	cmp	eax, 1048576				; 00100000H
	jb	SHORT $L1138

; 360  : 		copy_buffer (tmp_floppy_area, CURRENT->buffer);

	mov	DWORD PTR $T1139[ebp], eax

; 338  : // 如果返回结果字节数不等于7，或者状态字节0、1 或2 中存在出错标志，则若是写保护

	pushf

; 339  : // 就显示出错信息，释放当前驱动器，并结束当前请求项。否则就执行出错计数处理。

	mov	cx, 256					; 00000100H

; 340  : // 然后继续执行软盘请求操作。

	mov	esi, OFFSET FLAT:_tmp_floppy_area

; 341  : // ( 0xf8 = ST0_INTR | ST0_SE | ST0_ECE | ST0_NR )

	mov	edi, DWORD PTR $T1139[ebp]

; 342  : // ( 0xbf = ST1_EOC | ST1_CRC | ST1_OR | ST1_ND | ST1_WP | ST1_MAM，应该是0xb7)

	cld

; 343  : // ( 0x73 = ST2_CM | ST2_CRC | ST2_WC | ST2_BC | ST2_MAM )

	rep	 movsd

; 344  : 	if (result () != 7 || (ST0 & 0xf8) || (ST1 & 0xbf) || (ST2 & 0x73))

	popf

; 360  : 		copy_buffer (tmp_floppy_area, CURRENT->buffer);

$L1138:

; 361  : // 释放当前软盘，结束当前请求项（置更新标志），再继续执行其它软盘请求项。
; 362  : 	floppy_deselect (current_drive);

	xor	ecx, ecx
	mov	cl, BYTE PTR _current_drive
	push	ecx
	call	_floppy_deselect

; 363  : 	end_request (1);

	mov	edx, DWORD PTR _blk_dev+20
	mov	eax, DWORD PTR [edx]
	and	eax, 3
	push	eax
	call	_floppy_off
	mov	ecx, DWORD PTR _blk_dev+20
	add	esp, 8
	mov	esi, DWORD PTR [ecx+28]
	test	esi, esi
	je	SHORT $L1152
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 1
	test	al, al
	jne	SHORT $L1149
	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L1149:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1152:
	mov	edx, DWORD PTR _blk_dev+20
	add	edx, 24					; 00000018H
	push	edx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 8
	mov	DWORD PTR [eax], -1
	mov	eax, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+20, eax
	call	_do_fd_request

; 364  : 	do_fd_request ();
; 365  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L801:

; 345  : 	{
; 346  : 		if (ST1 & 0x02)

	test	al, 2
	je	$L802

; 347  : 		{			// 0x02 = ST1_WP - Write Protected。
; 348  : 			printk ("Drive %d is write protected\n\r", current_drive);

	xor	ecx, ecx
	mov	cl, BYTE PTR _current_drive
	push	ecx
	push	OFFSET FLAT:$SG803
	call	_printk

; 349  : 			floppy_deselect (current_drive);

	xor	edx, edx
	mov	dl, BYTE PTR _current_drive
	push	edx
	call	_floppy_deselect

; 350  : 			end_request (0);

	mov	eax, DWORD PTR _blk_dev+20
	mov	ecx, DWORD PTR [eax]
	and	ecx, 3
	push	ecx
	call	_floppy_off
	mov	edx, DWORD PTR _blk_dev+20
	add	esp, 16					; 00000010H
	mov	esi, DWORD PTR [edx+28]
	test	esi, esi
	je	SHORT $L1154
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 0
	test	al, al
	jne	SHORT $L1131
	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L1131:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1154:
	push	OFFSET FLAT:??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+20
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	ecx, DWORD PTR _blk_dev+20
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 24					; 00000018H
	mov	DWORD PTR [eax], -1
	mov	edx, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+20, edx

; 354  : 		do_fd_request ();

	call	_do_fd_request

; 364  : 	do_fd_request ();
; 365  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
$L802:

; 351  : 		}
; 352  : 		else
; 353  : 			bad_flp_intr ();

	call	_bad_flp_intr

; 354  : 		do_fd_request ();

	call	_do_fd_request

; 364  : 	do_fd_request ();
; 365  : }

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
_rw_interrupt ENDP
_bad_flp_intr PROC NEAR

; 315  : 	CURRENT->errors++;		// 当前请求项出错次数增1。

	mov	eax, DWORD PTR _blk_dev+20
	mov	edx, DWORD PTR [eax+8]
	inc	edx

; 316  : // 如果当前请求项出错次数大于最大允许出错次数，则取消选定当前软驱，并结束该请求项（不更新）。
; 317  : 	if (CURRENT->errors > MAX_ERRORS)

	mov	ecx, edx
	mov	DWORD PTR [eax+8], edx
	cmp	ecx, 8
	jle	$L1166

; 318  : 	{
; 319  : 		floppy_deselect (current_drive);

	xor	eax, eax
	push	esi
	mov	al, BYTE PTR _current_drive
	push	eax
	call	_floppy_deselect

; 320  : 		end_request (0);

	mov	ecx, DWORD PTR _blk_dev+20
	mov	edx, DWORD PTR [ecx]
	and	edx, 3
	push	edx
	call	_floppy_off
	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 8
	mov	esi, DWORD PTR [eax+28]
	test	esi, esi
	je	SHORT $L1170
	mov	al, BYTE PTR [esi+13]
	mov	BYTE PTR [esi+10], 0
	test	al, al
	jne	SHORT $L1165
	push	OFFSET FLAT:??_C@_0CE@BKIH@floppy?3?5free?5buffer?5being?5unlock@ ; `string'
	call	_printk
	add	esp, 4
$L1165:
	mov	BYTE PTR [esi+13], 0
	add	esi, 16					; 00000010H
	push	esi
	call	_wake_up
	add	esp, 4
$L1170:
	push	OFFSET FLAT:??_C@_0BD@HEIH@floppy?5I?1O?5error?6?$AN?$AA@ ; `string'
	call	_printk
	mov	eax, DWORD PTR _blk_dev+20
	mov	ecx, DWORD PTR [eax+28]
	mov	eax, DWORD PTR [eax]
	mov	edx, DWORD PTR [ecx+4]
	push	edx
	push	eax
	push	OFFSET FLAT:??_C@_0BF@ONON@dev?5?$CF04x?0?5block?5?$CFd?6?$AN?$AA@ ; `string'
	call	_printk
	mov	ecx, DWORD PTR _blk_dev+20
	add	ecx, 24					; 00000018H
	push	ecx
	call	_wake_up
	push	OFFSET FLAT:_wait_for_request
	call	_wake_up
	mov	eax, DWORD PTR _blk_dev+20
	add	esp, 24					; 00000018H
	mov	DWORD PTR [eax], -1
	mov	eax, DWORD PTR [eax+32]
	mov	DWORD PTR _blk_dev+20, eax
	pop	esi
$L1166:

; 321  : 	}
; 322  : // 如果当前请求项出错次数大于最大允许出错次数的一半，则置复位标志，需对软驱进行复位操作，
; 323  : // 然后再试。否则软驱需重新校正一下，再试。
; 324  : 	if (CURRENT->errors > MAX_ERRORS / 2)

	cmp	DWORD PTR [eax+8], 4
	jle	SHORT $L795

; 325  : 		reset = 1;

	mov	DWORD PTR _reset, 1

; 328  : }

	ret	0
$L795:

; 326  : 	else
; 327  : 		recalibrate = 1;

	mov	DWORD PTR _recalibrate, 1

; 328  : }

	ret	0
_bad_flp_intr ENDP
_seek_interrupt PROC NEAR

; 399  : /* sense drive status *//* 检测中断状态 */
; 400  : // 发送检测中断状态命令，该命令不带参数。返回结果信息两个字节：ST0 和磁头当前磁道号。
; 401  : 	output_byte (FD_SENSEI);

	push	8
	call	_output_byte
	add	esp, 4

; 402  : // 如果返回结果字节数不等于2，或者ST0 不为寻道结束，或者磁头所在磁道(ST1)不等于设定磁道，
; 403  : // 则说明发生了错误，于是执行检测错误计数处理，然后继续执行软盘请求项，并退出。
; 404  : 	if (result () != 2 || (ST0 & 0xF8) != 0x20 || ST1 != seek_track)

	call	_result
	cmp	eax, 2
	jne	$L816
	mov	al, BYTE PTR _reply_buffer
	and	al, 248					; 000000f8H
	cmp	al, 32					; 00000020H
	jne	$L816
	mov	al, BYTE PTR _reply_buffer+1
	mov	cl, BYTE PTR _seek_track
	cmp	al, cl
	jne	$L816

; 408  : 		return;
; 409  : 	}
; 410  : 	current_track = ST1;		// 设置当前磁道。

	mov	BYTE PTR _current_track, al

; 411  : 	setup_rw_floppy ();		// 设置DMA 并输出软盘操作命令和参数。

	call	_setup_DMA
	mov	cl, BYTE PTR _command
	mov	DWORD PTR _do_floppy, OFFSET FLAT:_rw_interrupt
	push	ecx
	call	_output_byte
	mov	dl, BYTE PTR _head
	mov	al, BYTE PTR _current_drive
	shl	dl, 2
	or	dl, al
	push	edx
	call	_output_byte
	mov	al, BYTE PTR _track
	push	eax
	call	_output_byte
	mov	cl, BYTE PTR _head
	push	ecx
	call	_output_byte
	mov	dl, BYTE PTR _sector
	push	edx
	call	_output_byte
	push	2
	call	_output_byte
	mov	eax, DWORD PTR _floppy
	mov	cl, BYTE PTR [eax+4]
	push	ecx
	call	_output_byte
	mov	edx, DWORD PTR _floppy
	mov	al, BYTE PTR [edx+20]
	push	eax
	call	_output_byte
	push	-1
	call	_output_byte
	mov	eax, DWORD PTR _reset
	add	esp, 36					; 00000024H
	test	eax, eax
	je	SHORT $L1175
	jmp	_do_fd_request
$L816:

; 405  : 	{
; 406  : 		bad_flp_intr ();

	call	_bad_flp_intr

; 407  : 		do_fd_request ();

	jmp	_do_fd_request

; 411  : 	setup_rw_floppy ();		// 设置DMA 并输出软盘操作命令和参数。

$L1175:

; 412  : }

	ret	0
_seek_interrupt ENDP
_TEXT	ENDS
END
